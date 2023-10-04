// 전역변수 설정
var vacation = {
    global : {

    }
}
var uri = "/CustomNPKlti";
//uri = "";
function callSpcVacList(e, d, k, sDt, eDt){
    bottomGrid(e, d, k, sDt, eDt);
}
function callEmpKindsGrid(empSeq, day){
	empKindsGrid(empSeq, day);
}
function callFnTpfDeptComboBoxInit(id){
	fnTpfDeptComboBoxInit(id);
}
function callEmpAllList(id){
	empAllList(id);
}

function callSelectVacationList(id, year, stDt, enDt, key){
	fn_selectVacationList(id, year, stDt, enDt, key);
}

function callVacationKnds(id, type){
	fn_vacationKnds(id, type);
}

function callSelectSpVacationList(id, year, stDt, enDt, vcatnKndSn){
	fn_selectSpVacationList(id, year, stDt, enDt, vcatnKndSn);
}

function fnTpfDeptComboBoxInit(id) {
	if ($('#' + id)) {
		var deptList = fnTpfGetDeptList();
		deptList.unshift({
			dept_name : '전체',
			dept_value : ""
		});
		var itemType = $("#" + id).kendoComboBox({
			dataSource : deptList,
			dataTextField : "dept_name",
			dataValueField : "dept_value",
			index : 0,
			change : function() {
				fnDeptChange(this.value());
				$("#deptSeq").val(this.value());
				$("#requestDeptSeq").val(this.value());
			}
		});
		$(".k-input").attr("readonly", "readonly");
	}
}

function fnDeptChange(){
	var obj = $('#vcatnGbnName').data('kendoComboBox');
}

function fnTpfGetDeptList() {
	var result = {};
	var params = {};
	var opt = {
		url : uri + "/vcatn/getAllDept",
		async : false,
		data : params,
		successFn : function(data) {
			result = data.list;
		}
	};
	acUtil.ajax.call(opt);
	return result;
}

function empAllList(id){
	var empDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : uri + "/common/empInformation",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data) {
				data.emp_name = $('#emp_name').val();
				data.dept_name = $('#requestDeptSeq').val();
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				return response.totalCount;
			}
		}
	});
	
	function empGrid() {
		var grid = $("#"+id).kendoGrid({
			dataSource : empDataSource,
			height : 500,
			sortable : true,
			pageable : {
				refresh : true,
				pageSizes : true,
				buttonCount : 5
			},
			persistSelection : true,
			selectable : "multiple",
			columns : [
					{
						field : "emp_name",
						title : "이름",
						template : fn_empName,
					},
					{
						field : "dept_name",
						title : "부서",
					},
					{
						field : "position",
						title : "직급",
					},
					{
						field : "duty",
						title : "직책",
					}],
			change : function(e) {
				codeGridClick(e)
			}
		}).data("kendoGrid");
		
		grid.table.on("click", ".checkbox", selectRow);
	
		var checkedIds = {};
		function selectRow() {
			var checked = this.checked, row = $(this).closest("tr"), grid = $(
					'#grid').data("kendoGrid"), dataItem = grid.dataItem(row);
	
			checkedIds[dataItem.CODE_CD] = checked;
			if (checked) {
				row.addClass("k-state-selected");
			} else {
				row.removeClass("k-state-selected");
			}
	
		}
		
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
			});
			$("#empSeq").val(record.emp_seq);
			mainGrid();
			subGrid();
			onClose();
		}
		
		function onClose() {
			var empWindow = $("#empPopUp");
			empWindow.data("kendoWindow").close();
		}
	}
	empGrid();
}
function fn_empName(row){
	var str = "<input type='hidden' class='empName' value='"+row.emp_name+"'/>" + row.emp_name;
	return str;
}
function empGridReload() {
	$("#empAllList").data('kendoGrid').dataSource.read();
	$("#grid").data('kendoGrid').dataSource.read();
}

function fn_vacationKnds(id, type){
	var formData = new FormData();
	formData.append("type", type);
	$.ajax({
		url: uri + "/vcatn/vacationKnds",
		data: formData,
		type: 'POST',
		processData: false,
		contentType: false,
		dataType: 'json',
		cache: false,
		async: false,
		success:function(result){
			if(result.list != null){
				var list = result.list;
				var html = "";
				for(var i = 0 ; i < list.length; i++){
					html += "<dd>";
					html += "<button type='button' class='vacationChild' key='"+list[i].VCATN_KND_SN+"' btnType='"+type+"'>"+list[i].VCATN_KND_NAME+"</button>";
					html += "</dd>";
				}
				$("#" + id).append(html);
			}
		}
	});
}

function fn_selectVacationList(id, year, stDt, enDt, key){
	var type = "";
	if(Number(key) == 2){
		type = "V006";
	}	
	var dataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : uri + "/vacation/getUseList",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.year = year;
				data.startDate = stDt;
				data.endDate = enDt;
				data.vacationType = key;
				data.type = type;
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				return response.list.length;
			}
		}
	});
	
	function empGrid() {
		var grid = $("#"+id).kendoGrid({
			dataSource : dataSource,
			height : 500,
			sortable : true,
			pageable : {
				refresh : true,
				pageSizes : true,
				buttonCount : 5
			},
			persistSelection : true,
			selectable : "multiple",
			columns : [

				{
					field : "DEPT_NAME",
					title : "부서",
					template : function(row){
						var str = row.DEPT_NAME;
						if(row.USE_YN == "C"){
							str = "<span style='text-decoration: line-through; color: red;'>"+ row.DEPT_NAME +"</span>";										
						}
						return str;
					}
				}, {
					field : "EMP_NAME",
					title : "이름",
					template : function(row){
						var str = row.EMP_NAME;
						if(row.USE_YN == "C"){
							str = "<span style='text-decoration: line-through; color: red;'>"+ row.EMP_NAME +"</span>";										
						}
						return str;
					},
				}, {
					field : "",
					title : "사용기간",
					columns : [ {
						field : "stDt",
						title : "시작일자",
						template : function(row){
							var str = row.stDt;
							if(row.USE_YN == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDt +"</span>";										
							}
							return str;
						}
					},{
						field : "stDtTime",
						title : "시작시간",
						template : function(row){
							var str = row.stDtTime;
							if(row.USE_YN == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDtTime +"</span>";										
							}
							return str;
						}
					},{
						field : "enDt",
						title : "종료일자",
						template : function(row){
							var str = row.enDt;
							if(row.USE_YN == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDt +"</span>";										
							}
							return str;
						}
					},{
						field : "enDtTime",
						title : "종료시간",
						template : function(row){
							var str = row.enDtTime;
							if(row.USE_YN == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDtTime +"</span>";										
							}
							return str;
						}
					}]
				}, {
					field : "useTime",
					title : "사용일수",
					template : function(row){
						var useTime = row.USE_DAY;
						useTime = fn_useTime(useTime);
						if(row.USE_YN == "C"){
							useTime = "<span style='text-decoration: line-through; color: red;'>"+ useTime +"</span>";										
						}
						return useTime;
					},
					
				}, {
					field : "appDocNo",
					title : "문서번호",
					template : function(row){
						var dikeycode = row.c_dikeycode;
						var str = "";
						if(dikeycode != null && dikeycode != ''){
							str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>" + row.appDocNo + "</a>";
						}else{
							str = "";
						}
						if(row.USE_YN == "C"){
							str = "<span style='text-decoration: line-through; color: red;'>"+ row.appDocNo +"</span>";										
						}
						return str;
					},
				}, {
					field : "doc_title",
					title : "신청내역",
					template : function(row){
						var dikeycode = row.c_dikeycode;
						var str = "";
						if(dikeycode != null && dikeycode != ''){
							str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
						}else{
							str = "";
						}
						if(row.USE_YN == "C"){
							str = "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";										
						}
						return str;
					},
				}, {
					field : "",
					title : "비고",
					
				}],
			change : function(e) {
				codeGridClick(e)
			}
		}).data("kendoGrid");
		
		grid.table.on("click", ".checkbox", selectRow);
	
		var checkedIds = {};
		function selectRow() {
			var checked = this.checked, row = $(this).closest("tr"), grid = $(
					"#"+id).data("kendoGrid"), dataItem = grid.dataItem(row);
	
			checkedIds[dataItem.CODE_CD] = checked;
			if (checked) {
				row.addClass("k-state-selected");
			} else {
				row.removeClass("k-state-selected");
			}
	
		}
		
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
			});
		}
		
	}
	empGrid();
}


function fn_selectSpVacationList(id, year, stDt, enDt, vcatnKndSn) {
	var subSpDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : uri + "/vcatn/getSpecialUseHist",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.year = year;
				data.vcatnKndSn = vcatnKndSn;
				data.startDate = stDt;
				data.endDate = enDt;
				data.authority = "admin";
				return data;
			}
		},
		schema : {
			data : function(response) {
				
				return response.list;
			},
			total : function(response) {
				return response.list.length;
			}
		}
	});
	$("#" + id).empty();
	var grid = $("#" + id).kendoGrid(
		{
			dataSource : subSpDataSource,
			height : 350,
			dataBound : function(e) {
				gridDataBound(e);
			},
			sortable : false,
			pageable : {
				refresh : false,
				pageSizes : [ 10, 20, 30, 50, 100 ],
				buttonCount : 5,
				position : "top",
				messages: {
					itemsPerPage : "",
					display: "total : {2}"
				}
			},
			persistSelection : true,
			selectable : "multiple",
			excel : {
				fileName:"사용내역.xlsx",
				allPages:true, 
				filterable:true,
			},
			columns : [

					{
						field : "DEPT_NAME",
						title : "부서",
						template : function(row){
							var str = row.DEPT_NAME;
							if(row.state == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+row.DEPT_NAME+"</span>";										
							}
							return str;
						}
					}, {
						field : "EMP_NAME",
						title : "이름",
						template : function(row){
							var str = row.EMP_NAME;
							if(row.state == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.EMP_NAME +"</span>";										
							}
							return str;
						}
					}, {
						field : "useDate",
						title : "사용기간",
						columns : [ {
							field : "stDt",
							title : "시작일자",
							template : function(row){
								var str = row.stDt;
								if(row.state == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDt +"</span>";										
								}
								return str;
							}
						},{
							field : "stDtTime",
							title : "시작시간",
							template : function(row){
								var str = row.stDtTime;
								if(row.state == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDtTime +"</span>";										
								}
								return str;
							}
						},{
							field : "enDt",
							title : "종료일자",
							template : function(row){
								var str = row.enDt;
								if(row.state == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDt +"</span>";										
								}
								return str;
							}
						},{
							field : "enDtTime",
							title : "종료시간",
							template : function(row){
								var str = row.enDtTime;
								if(row.state == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDtTime +"</span>";										
								}
								return str;
							}
						}]
					}, {
						field : "USE_DAY",
						title : "사용일수",
						template : function(row){
							return fn_useDay(row);
						},
						
					}, {
						field : "appDocNo",
						title : "문서번호",
						template : function(row){
							var dikeycode = row.c_dikeycode;
							var str = "";
							if(row.state == "C"){
								if(dikeycode != null && dikeycode != ''){
									str += "<span style='text-decoration: line-through; color: red;'>" + row.appDocNo + "</span>";
								}else{
									str = "";
								}
							}else{
								if(dikeycode != null && dikeycode != ''){
									str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>" + row.appDocNo + "</a>";
								}else{
									str = "";
								}
							}
							return str;
						},
					}, {
						field : "doc_title",
						title : "신청내역",
						template : function(row){
							var dikeycode = row.c_dikeycode;
							var str = "";
							if(row.state == "C"){
								if(dikeycode != null && dikeycode != ''){
									str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
								}else{
									str = "";
								}
							}else{
								if(dikeycode != null && dikeycode != ''){
									str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
								}else{
									str = "";
								}
							}
							return str;
						},
					}, {
						field : "AFTFAT_MNT_YN",
						title : "비고",
						template : function(row){
							var str = "";
							var aftfatYn = row.AFTFAT_MNT_YN;
							if(row.state == "C"){
								str = "";
							}else{
								if(aftfatYn == 'Y'){
									str += "<div>";
									if(Number(row.AFTFAT_MNT_MTH) == 1 && row.EVIDENCE_FILE_SN == null){
										str = "<div class='fileBtnUpload'>";
										str += "<span style='color: red;'>증빙파일 미등록</span>";
									}else if(row.EVIDENCE_FILE_SN != null){
										str = "<div class='fileBtnDown'>";
										str += "<input type='button' onclick=\"fn_fileDownload('"+ row.FILE_MASK +"','"+ row.FILE_NAME +"')\" value='다운로드'>";
									}else{
										str += "전자결재";
									}
									str += "</div>";
								}
							}
							return str;
						}
					}],
			change : function(e) {
				codeGridClick(e)
			}
		}).data("kendoGrid");

	grid.table.on("click", ".checkbox", selectRow);

	var checkedIds = {};

	// on click of the checkbox:
	function selectRow() {

		var checked = this.checked, row = $(this).closest("tr"), grid = $(
				"#" + id).data("kendoGrid"), dataItem = grid.dataItem(row);

		checkedIds[dataItem.CODE_CD] = checked;
		if (checked) {
			row.addClass("k-state-selected");
		} else {
			row.removeClass("k-state-selected");
		}

	}
	function codeGridClick() {
		var rows = grid.select();
		var record;
		rows.each(function() {
			record = grid.dataItem($(this));
		});
	}
		
}