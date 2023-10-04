<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<jsp:useBean id="weekDay" class="java.util.Date" />
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>

<style type="text/css">
	.btn_lg {
		width: 100px;
		height: 36px !important;
		font-size: 15px;
	}
	.k-header .k-link {
		text-align: center;
	}
	.k-grid-content>table>tbody>tr {
		text-align: center;
	}
	.k-grid th.k-header, .k-grid-header {
		background: #F0F6FD;
	}
	.master-col {
		width: 160px;
	}
</style>

<script type="text/javascript">
	$(function(){
		//console.log('${empInfo}');
		/*
			시간외마스터 셀렉트(subHoliday/overHoliWorkSelect)
		*/
		$.overHoliWorkSelect = function(){
			$.getJSON(_g_contextPath_ + '/subHoliday/overHoliWorkSelect',
					function(data){
				console.log(data);
						$.timeFunction(data, 'masterFrm');
						$.weekTotal();
						$("[name='ot_master_id']").val(data.ot_master_id);
						$('#night_work_reward').val(data.night_work_reward);
			});
		}
		//서버시간(min) -> 브라우저시간(hour/day/year) 변환 코드
		$.timeFunction = function(data, formName){
			$.each(data, function(key, value){
				var minName = key.split('_min')[0];
				$("[name='" + formName +"'] input[type='text']").each(function(k, v){
					if($(v).prop('id').indexOf(minName) === 0){
						var n = $(v).prop('id').lastIndexOf('_');
						var type = $(v).prop('id').substring(n+1);
						var show = 0;
						switch (type) {
						case 'year': show = value/(60*24*365); break;
						case 'day' : show = value/(60*24); break;
						case 'hour': show = value/60; break;
						}
						$(v).val(show);
					}
				});
			});
		}
		$.weekTotal = function(){
			var week_law_work_hour = parseInt($("#week_law_work_hour").val());
			var week_ot_work_hour = parseInt($("#week_ot_work_hour").val());
			$("#week_total").val(week_law_work_hour + week_ot_work_hour);
		}
		$.overHoliWorkSelect();
		
		/*
			시간외마스터 업데이트(subHoliday/overHoliWorkUpdate)
		*/
		//브라우저시간(hour/day/year) -> 서버시간(min) 변환 코드 
		$.timeToServer = function(formName){
			$("[name='"+ formName +"'] input[type='text']").each(function(k, v){
				var n = $(v).prop('id').lastIndexOf('_');
				var type = $(v).prop('id').substring(n+1);
				var value = $(v).val();
				var server = 0;
				switch (type) {
				case 'year': server = value*(60*24*365); break;
				case 'day' : server = value*(60*24); break;
				case 'hour': server = value*60; break;
				}
				$(this).next().val(server);
			});
		}
		$(document).on('submit', "[name='masterFrm']", function(e){
			e.preventDefault();
			$.timeToServer('masterFrm');
			var formData = new FormData($(this).get(0));
			$.ajax({
				url: _g_contextPath_ + '/subHoliday/overHoliWorkUpdate',
				type: 'post',
				dataType: 'json',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(json){
					if(json.code==='success'){
						alert("서버 저장 성공");
						//$.overHoliWorkSelect();
					}else{
						alert("서버 저장 실패");
					}
				}
			});
		});
		
		/*
			사원 리스트 팝업(#empListPop)
		*/
		var myWindow = $("#empListPop"),
			undo = $("#empListPopBtn");
		undo.click(function(){
			myWindow.data("kendoWindow").open();
			undo.fadeOut();
			empGrid();
			$("#headerCheckbox-p1").change(function(){//empGrid() 함수 호출 코드 밑에 작성해야 작동
				if($(this).is(":checked")){
					$(".checkbox-p1").prop("checked", true);
				}else{
					$(".checkbox-p1").prop("checked", false);
				}
			});
			setTimeout(function(){
				var array = [];
		    	for(var i = -13 ; i <= 13 ; i = i + 0.5){
		    		array.push({'text': i + ' H', 'value': i*60})
		    	}
				$(".time_differ").kendoDropDownList({
				    dataTextField: "text",
				    dataValueField: "value",
				    dataSource: array,
				    index: 26
				});
				$(".addWorkType").kendoDropDownList();
			}, 500);
		});
		$("#empListPopClose").click(function(){
			myWindow.data("kendoWindow").close();
		});
		myWindow.kendoWindow({
			width: "750px",
			height: "665px",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				undo.fadeIn();
				$("#emp_name").val("");
				$("#dept_name").val("");
				empGridReload();
				gridReload();
			}
		}).data("kendoWindow").center();
		
		function empGridReload(){
			$("#gridEmpList"/* popUpGrid */).data("kendoGrid").dataSource.read();
		}
		$("#empSearchBtn").click(function(){
			empGridReload();
		});
		$(document).on({
			'keyup': function(event){
				if(event.keyCode===13){//enterkey
					empGridReload();
				}
			}
		},".grid_reload");
		
		var empGrid = function(){
			var grid = $("#gridEmpList"/* popUpGrid */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_ + '/subHoliday/empInformationAdmitList',
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.deptSeq = '';//"${empInfo.deptSeq}";
							data.emp_name = $("#emp_name").val();
							data.dept_name = $("#dept_name").val();
							data.notIn = '';
							return data;
						}
					},
					schema: {
						data: function(response){
							return response.list;
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 460,
				dataBound: gridDataBound,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: "multiple",
				columns: [{
					headerTemplate:
						"<input type='checkbox' id='headerCheckbox-p1' class='k-checkbox header-checkbox'>" +
						"<label class='k-checkbox-label' for='headerCheckbox-p1'></label>",
					template: function(row){
						var key = row.emp_seq;
						return "<input type='checkbox' id='empSeq" + key + "' class='k-checkbox checkbox-p1'>" +
							   "<label for='empSeq" + key + "' class='k-checkbox-label'></label>";
					},
					width: 50,
					attributes: {
						style: "padding-left: 0 !important"
					}
				},{
					field: "emp_name",
					title: "이름"
				},{
					field: "dept_name",
					title: "부서"
				},{
					field: "position",
					title: "직급",
					width: 80
				},{
					field: "duty",
					title: "직책",
					width: 80
				},{
					field: "work_type_code",
					title: "근무유형",
					template: function(){
						//return "<input type='text' style='width:50%;' class='timeValidation'> 시간";
						//return document.querySelector("#holiSetTemplate").innerHTML;
						/* var workSelect = $("#addWorkType").html();
						return workSelect; */
						var workSelect = $("#addWorkType").find('select').kendoDropDownList();
						workSelect.css('display', 'inline');
						return workSelect.get(0).outerHTML;
					}
				},{
					field: "time_differ_min",
					title: "해외시차(시간)",
					template: function(){
						return "<input type='text' class='time_differ' style='width: 90%;'>";
					}
				},{
					field: "remark",
					title: "비고",
					template: function(){
						return "<input type='text' class='remark' style='width:90%;'>";
					}
				}],
				change: function(e){
					//codeGridClick(e);
				},
				dataBinding: function(e){
					
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
					console.log(record);
				}); 
			}
		}
		// input 창에 숫자랑 .만 쓸 수 있도록 
		$(document).on('keyup', '.timeValidation', function(){
			$(this).val($(this).val().replace(/[^0123456789.]/g,""));
		});
		
		//시간외근무 인정시간 popup창에 넣을 select템플릿 생성하기
/* 		function holidaySetList(){
			var template = document.querySelector("#holiSetTemplate");
			var selectObject = document.createElement("select");
			$(selectObject).addClass("pop_select");
			for(var i=60;i>=0;i--){//월기준 12시간 5주 최대 60시간 !!나중에 수정해야할 수 있음
				var option = document.createElement("option");
				option.text = i;
				option.value = i;
				selectObject.add(option);
			}
			$(template).append(selectObject);
		}
		holidaySetList();  */
		
		$("#empListPopSave").on('click', function(){
 			var ch = $(".checkbox-p1:checked");
			if(ch.length < 1){
				alert("저장할 목록을 체크해주세요");
			}else{
	 			var jsonArray = new Array();
				var grid = $("#gridEmpList").data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					//json.admit_time_min = $(v).closest("tr").find("td input").val()*60;
					json.time_differ_min = $(v).closest("tr").find("td input.time_differ").val();
					json.work_type_code = $(v).closest("tr").find("td select").val();
					json.remark = $(v).closest("tr").find("td input[type='text'].remark").val();
					json.create_emp_seq = "${empInfo.empSeq}";
					jsonArray.push(json);
				});
				var list = JSON.stringify(jsonArray);
				console.log('list', list);
				var result = confirm("저장 하시겠습니까?");
 				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/empSetAdmitInsert',
						type: 'post',
						dataType: 'json',
						data: list,
						headers: { 
							/*
								JSON.stringify로 json배열 보낼때는 이거 써줘야함! 
								컨트롤러에서는 @RequestBody로 받아야됨!
							*/
					        'Accept': 'application/json',
					        'Content-Type': 'application/json' 
					    },
						success: function(json){
							if(json.code === 'success'){
								empGridReload();
								alert("저장 성공!!");
							}else{
								alert("서버 저장 실패..");
							}
						}
					});
				}
				
			}
		});
		
		/*
			사원 수정 팝업(#empSetUpdatePop)
		*/
		var myWindow2 = $("#empSetUpdatePop"),
			undo2 = $("#empUpdatePopBtn");
		undo2.click(function(){
			myWindow2.data("kendoWindow").open();
			undo2.fadeOut();
			empSetUpdateGrid();
			$("#headerCheckbox-p2").change(function(){
				if($(this).is(":checked")){
					$(".checkbox-p2").prop("checked", true);
				}else{
					$(".checkbox-p2").prop("checked", false);
				}
			});
			setTimeout(function(){
				var array = [];
		    	for(var i = -13 ; i <= 13 ; i = i + 0.5){
		    		array.push({'text': i + ' H', 'value': i*60})
		    	}
		    	console.log('array', array);
				$(".time_differ_update").kendoDropDownList({
				    dataTextField: "text",
				    dataValueField: "value",
				    dataSource: array
				});
				$(".addWorkType").kendoDropDownList();
			}, 500);
		});
		$("#empSetUpdatePopClose").click(function(){
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
			width: "750px",
			height: "665px",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				undo2.fadeIn();
				gridReload();
				$("#gridEmpSetUpdate").empty();
			}
		}).data("kendoWindow").center();
		
		function empSetUpdateGridReload(){
			$("#gridEmpSetUpdate"/* popUpdateGrid */).data("kendoGrid").dataSource.read();
		}
		
		var empSetUpdateGrid = function(){
			var dataSourceChecked = function(){
				var ch = $(".checkbox1:checked");
				if(ch.length < 1 ) {
					return;
				}else {
					var jsonArray = new Array();
					var grid = $("#gridOverWkEmpSetList").data("kendoGrid");
					$.each(ch, function(i,v){
						var row = grid.dataItem($(v).closest("tr"));
						var json = row.toJSON();
						json.update_emp_seq = "${empInfo.empSeq}";
						jsonArray.push(json);
					});
					return jsonArray;
				}
			}
			var grid = $("#gridEmpSetUpdate"/* popUpdateGrid */).kendoGrid({
				dataSource: dataSourceChecked(),
				height: 460,
				dataBound: gridDataBound,
				sortable: true,
				persistSelection: true,
				selectable: "multiple",
				columns: [{
					headerTemplate:
						"<input type='checkbox' id='headerCheckbox-p2' class='k-checkbox header-checkbox'>" +
						"<label class='k-checkbox-label' for='headerCheckbox-p2'></label>",
					template: function(row){
						var key = row.emp_seq;
						return "<input type='checkbox' id='empSeqUpdate" + key + "' class='k-checkbox checkbox-p2'>" +
							   "<label for='empSeqUpdate" + key + "' class='k-checkbox-label'></label>";
					},
					width: 50,
					attributes: {
						style: "padding-left: 0 !important"
					}
				},{
					field: "emp_name",
					title: "이름"
				},{
					field: "dept_name",
					title: "부서"
				},{
					field: "position",
					title: "직급",
					width: 80
				},{
					field: "duty",
					title: "직책",
					width: 80
				},{
					field: "work_type_code",//"admit_time",
					title: "근무유형",//"인정시간",
 					template: function(row){
 						//var admit_time = row.admit_time_min/60;
 						/*
 						var dirObject = document.createElement("dir");
						var selectObject = document.createElement("select");
						$(selectObject).addClass("pop_select");
						for(var i=60;i>=0;i--){//월기준 12시간 5주 최대 60시간 !!나중에 수정해야할 수 있음
							var option = document.createElement("option");
							option.text = i;
							option.value = i;
							if(i == admit_time){
								$(option).attr("selected", "selected");
							}
							selectObject.add(option);
						}
						$(dirObject).append(selectObject);
						return  $(dirObject).html() + "&nbsp;시간";
						*/
 						//return "<input type='text' style='width:50%;' class='timeValidation' value='"+ admit_time +"'> 시간";
 						var workSelect = $("#addWorkType").find('select').kendoDropDownList();
						workSelect.css('display', 'inline');
						$(workSelect).data("kendoDropDownList").value(row.work_type_code);
						return workSelect.get(0).outerHTML;
					}
				},{
					field: "time_differ_min",
					title: "해외시차(시간)",
					template: function(row){
						return "<input type='text' class='time_differ_update' style='width: 90%;' value='"+ row.time_differ_min +"'>";
					}
				},{
					field: "remark",
					title: "비고",
					template: function(row){
						var remark = row.remark
						return "<input type='text' style='width:90%;' class='remarks' value='"+ remark +"'>";
					}
				}],
				change: function(e){
					//codeGridClick(e)
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
					console.log(record);
				}); 
			}
		}
				
		$("#empSetUpdatePopSave").on('click', function(){
 			var ch = $(".checkbox-p2:checked");
			if(ch.length < 1){
				alert("수정할 목록을 체크해주세요");
			}else{
	 			var jsonArray = new Array();
				var grid = $("#gridEmpSetUpdate"/* popUpdateGrid */).data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					//json.admit_time_min = $(v).closest("tr").find("td input.timeValidation").val()*60;
					json.work_type_code = $(v).closest("tr").find("td select.addWorkType").val();
					json.time_differ_min = $(v).closest("tr").find("td input.time_differ_update").val();
					json.remark = $(v).closest("tr").find("td input.remarks").val();
					json.create_emp_seq/* 
					MySQL ON DUPLICATE KEY UPDATE 에서 VALUE()로 접근하기 위해서 update_emp_seq가 아니라 create_emp_seq로 써줌
					*/ = "${empInfo.empSeq}"; 
					jsonArray.push(json);
				});
				var list = JSON.stringify(jsonArray);
				var result = confirm("저장 하시겠습니까?");
 				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/empSetAdmitInsert',
						type: 'post',
						dataType: 'json',
						data: list,
						headers: { 
							/*
								JSON.stringify로 json배열 보낼때는 이거 써줘야함! 
								컨트롤러에서는 @RequestBody로 받아야됨!
							*/
					        'Accept': 'application/json',
					        'Content-Type': 'application/json' 
					    },
						success: function(json){
							if(json.code==='success'){
								gridReload();
								myWindow2.data("kendoWindow").close();
								alert("저장 성공!!");
							}else{
								alert("저장 실패..");
							}
						}
					});
				}
			}
		});
		/*
			사원 삭제 버튼
		*/
		$("#empDeleteBtn").on('click', function(){
			var ch = $(".checkbox1:checked");
			if(ch.length < 1){
				alert("삭제할 목록을 체크해주세요");
			}else{
				var jsonArray = new Array();
				var grid = $("#gridOverWkEmpSetList"/* Mappring1 */).data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					json.update_emp_seq = "${empInfo.empSeq}";
					jsonArray.push(json);
				});
				var list = JSON.stringify(jsonArray);
				var result = confirm("삭제 하시겠습니까?");
				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/empSetAdminDeactivate',
						type: 'post',
						dataType: 'json',
						data: list,
						headers: {
							/*
								JSON.stringify로 json배열 보낼때는 이거 써줘야함! 
								컨트롤러에서는 @RequestBody로 받아야됨!
							*/
					        'Accept': 'application/json',
					        'Content-Type': 'application/json'
						},
						success: function(json){
							if(json.code==='success'){
								gridReload();
								alert("삭제 성공!!");
							}else{
								alert("삭제 실패..")
							}
						}
					});
				}
			}
		});
		
		/*
			월 개인 시간외근무 인정시간(subHoliday/gridOverWkEmpSetList)
		*/
		function gridReload(){
			$("#gridOverWkEmpSetList"/* Mapping1 */).data('kendoGrid').dataSource.read();
		}
		
		/* 데이터 없을시 그리드 처리 함수: empGrid(), mainGrid(), mainGrid2() 공용 */
		function gridDataBound(e){
			var grid = e.sender;
			if(grid.dataSource.total()==0){
				var colCount = grid.columns.length;
				$(e.sender.wrapper)
					.find('tbody')
					.append('<tr class="kendo-data-row">' + 
							'<td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
			}
		}
		
		var mainGrid = function(){
			var grid = $("#gridOverWkEmpSetList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridOverWkEmpSetList',/* Mapping1 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.userSeq = "";
							data.deptSeq = "";
							return data;
						}
					},
					schema: {
						data: function(response){
							return response.list;
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 436, /* 436 218+36 254*/
				dataBound: gridDataBound,
				sortable: true,
 				pageable: {
					refresh: true,
					pageSizes: [10, 50, 100],//true,
					buttonCount: 5
				}, 
				persistSelection: true,
				selectable: 'multiple',
				columns: [
				{
					headerTemplate: 
						"<input type='checkbox' id='headerCheckbox1' class='k-checkbox header-checkbox'>" +
						"<label class='k-checkbox-label' for='headerCheckbox1'></label>",
					template: function(row){
						var key = row.emp_seq;
						return "<input type='checkbox' id='empSetSeq" + key + "' class='k-checkbox checkbox1'/>" + 
							   "<label for='empSetSeq" + key + "' class='k-checkbox-label'></label>";
					},
					width: 50
				},{
					field: "dept_name",
					title: "부서명"
				},{
					field: "emp_name",
					title: "성명"
				},{
					field: "work_type_code",//"admit_time",
					title: "근무유형",//"인정시간",
					template: function(row){
						var type = row.work_type_code;
						var code_kr = "";
						if(type === 632){
							code_kr = "전일제";
						}else if (type === 633){
							code_kr = "반일제";
						}
						return "<span>" + code_kr + "</span>";
					}//"#= admit_time_min/60 # 시간"
				},{
					field: "time_differ_min",
					title: "해외시차(시간)",
					template: function(row){
						var timeDifferMin = row.time_differ_min
						if(row.time_differ_min === undefined) timeDifferMin = 0;
						return "<span>"+ timeDifferMin/60 + "시간</span>";
					}
				},{
					field: "remark",
					title: "비고"
				}],
				change: function(e){
					//codeGridClick(e)
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
					console.log(record);
				}); 
			}
		}

		mainGrid();
		
 		$("#headerCheckbox1").change(function(){
			if($(this).is(":checked")){
				$(".checkbox1").prop("checked", true);
			}else{
				$(".checkbox1").prop("checked", false);
			}
		}); 
		/*
			휴일근무설정 팝업(#holidaySetPop)
		*/
		var myWindow3 = $("#holidaySetPop"),
			undo3 = $("#holidaySetPopBtn");
		undo3.click(function(){
			myWindow3.data("kendoWindow").open();
			undo3.fadeOut();
		});
		$("#holidaySetPopClose").click(function(){
			myWindow3.data("kendoWindow").close();
		});
		myWindow3.kendoWindow({
			width: "600px",
			hieght: "241px",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				undo3.fadeIn();
				undo4.fadeIn();
				$("[name='work_type']").val("");
				$("[name='attend_time']").val("");
				$("[name='leave_time']").val("");
				$("[name='remark']").val("");
				gridReload2();
			}
		}).data("kendoWindow").center();
		
		$("#attend_time_picker").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			change: function(){
/* 				var attend_time = kendo.toString(this.value(), "HH:mm");
				console.log("attend_time: " + attend_time); */
			}
		});	
		$("#attend_time_picker").attr("readonly", true);
		
		$("#leave_time_picker").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			change: function(){
/* 				var leave_time = kendo.toString(this.value(), "HH:mm");
				console.log("leave_time: " + leave_time); */
			}
		});
		$("#leave_time_picker").attr("readonly", true);
		
		$("#admit_time_picker").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			value: "01:00",
			interval: 60,
			max: "12:00"
		});
		$("#admit_time_picker").attr("readonly", true);
		
		$(document).on('submit', "[name='holidaySetFrm']", function(e){
			e.preventDefault();
/* 			var rest_hr = parseInt(kendo.toString($("#rest_time_picker").data("kendoTimePicker").value(), "HH"));
			var rest_mm = parseInt(kendo.toString($("#rest_time_picker").data("kendoTimePicker").value(), "mm"));
			$("[name='rest_time']").val((rest_hr * 60) + rest_mm);*/
			var admit_time_hour = parseInt(kendo.toString($("#admit_time_picker").data("kendoTimePicker").value(), "HH"));
			$("[name='admit_time_min']").val(admit_time_hour * 60);
			var formData = new FormData($(this).get(0));
 			$.ajax({
				url: _g_contextPath_ + '/subHoliday/holidaySet',
				type: 'post',
				dataType: 'json',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(json){
					if(json.code === 'success'){
						alert("서버 저장 성공");
						myWindow3.data("kendoWindow").close();
					}else{
						alert("서버 저장 실패");
					}
				} 
			}); 
		});
		
		/*
			휴일근무 수정 팝업(#holidaySetPop) : 설정 팝업과 동일
		*/
		var undo4 = $("#holidayUpdatePopBtn");
		undo4.click(function(){
			var ch = $(".checkbox2:checked");
			if(ch.length < 1){
				alert("수정할 항목을 체크해주세요");
				return;
			}else if(ch.length > 1){
				alert("수정할 항목 하나만 체크해주세요");
				return;
			}else{
				var grid = $("#gridHoliTypeList"/* Mapping2 */).data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					json.create_emp_seq = "${empInfo.empSeq}";
					$("[name='work_type']").val(json.work_type);
					$("#attend_time_picker").data("kendoTimePicker").value(json.attend_time);
					$("#leave_time_picker").data("kendoTimePicker").value(json.leave_time);
					$("#admit_time_picker").data("kendoTimePicker").value(json.admit_time_min/60 + ":00");
					$("[name='remark']").val(json.remark);
				});
			}
			myWindow3.data("kendoWindow").open();
			undo4.fadeOut();
		});
		
		/*
			휴일근무 삭제 버튼
		*/
		$("#holidayDeleteBtn").on('click', function(){
			var ch = $(".checkbox2:checked");
			if(ch.length < 1){
				alert("삭제할 목록을 체크해주세요");
			}else{
				var jsonArray = new Array();
				var grid = $("#gridHoliTypeList"/* Mapping2 */).data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					json.update_emp_seq = "${empInfo.empSeq}";
					jsonArray.push(json);
				});
				var list = JSON.stringify(jsonArray);
				var result = confirm("삭제 하시겠습니까?");
				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/holidaySetDeactivate',
						type: 'post',
						dataType: 'json',
						data: list,
						headers: {
							/*
								JSON.stringify로 json배열 보낼때는 이거 써줘야함! 
								컨트롤러에서는 @RequestBody로 받아야됨!
							*/
					        'Accept': 'application/json',
					        'Content-Type': 'application/json'
						},
						success: function(json){
							if(json.code==='success'){
								gridReload2();
								alert("삭제 성공!!");
							}else{
								alert("삭제 실패..")
							}
						}
					});
				}
			}
		});
		
		
		/*
			휴일근무설정(subHoliday/gridHoliTypeList)
		*/
		function gridReload2(){
			$("#gridHoliTypeList"/* Mapping2 */).data('kendoGrid').dataSource.read();
		}
		
		var mainGrid2 = function(){
			var grid = $("#gridHoliTypeList"/* Mapping2 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridHoliTypeList',/* Mapping2 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							//data.userSeq = $("#userSeq").val();
							//data.deptSeq = $("#deptSeq").val();
							return data;
						}
					},
					schema: {
						data: function(response){
							return response.list;
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 182,/* 436 218-36 */
				dataBound: gridDataBound,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: 'multiple',
				columns: [
				{
					headerTemplate: 
						"<input type='checkbox' id='headerCheckbox2' class='k-checkbox header-checkbox'>" +
						"<label class='k-checkbox-label' for='headerCheckbox2'></label>",
					template: function(row){
						var key = row.work_type;
						return "<input type='checkbox' id='type" + key + "' class='k-checkbox checkbox2'/>" + 
							   "<label for='type" + key + "' class='k-checkbox-label'></label>"
					},
					width: 50
				},{
					field: "work_type",
					title: "근무유형"
				},{
					field: "attend_time",
					title: "출근시간"
				},{
					field: "leave_time",
					title: "퇴근시간"
				},{
					field: "admit_time",
					title: "인정시간",
					template: "#= admit_time_min/60 # 시간"
				},{
					field: "remark",
					title: "비고"
				}],
				change: function(e){
					
				}
			}).data("kendoGrid");
			
		}
		
		//mainGrid2();
		
 		$("#headerCheckbox2").change(function(){
			if($(this).is(":checked")){
				$(".checkbox2").prop("checked", true);
			}else{
				$(".checkbox2").prop("checked", false);
			}
		}); 
		
	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>시간외/휴일근무 설정</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap">
		<form method="post" name="masterFrm" 
			action="${pageContext.request.contextPath }/subHoliday/masterUpdate">
			<input type="hidden" name="update_emp_seq" value="${empInfo.empSeq }">
			<input type="hidden" name="ot_master_id" value="">
			<div class="btn_div" ><!-- style="height: 36px;" -->
				<div class="left_div">
					<p class="tit_p mt5 mb0">시간외근무 설정 마스터</p>
				</div>
				
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="submit" id="saveBtn">저장</button><!-- class="btn_lg" -->
						<!-- <button type="button" id="cancleBtn">취소</button> class="btn_lg" -->
					</div> 
				</div>
			</div>
			
			<div class="top_box">
				<dl>
					<dt class="master-col">일)시간외근무 인정시간</dt>
					<dd>
						<input type="text" id="day_admit_hour">
						<input type="hidden" name="day_admit_min">
						<span>시간</span>
					</dd>
					<dt class="ml50 master-col">휴일근무보상유효기간</dt>
					<dd>
						<input type="text" id="holiday_valid_day">
						<input type="hidden" name="holiday_valid_min">
						<span>일&nbsp;&nbsp;</span>
					</dd>
					<dt class="ml50 master-col">시간외근무보상유효기간</dt>
					<dd>
						<input type="text" id="ot_valid_day">
						<input type="hidden" name="ot_valid_min">
						<span>일</span>
						<span class="master-col" style="width: 500px;font-weight: bold;">*알림* 1231일로 설정하시면 보상유효기간이 당해년도 12월 31일로 설정됩니다.</span>
					</dd>
				</dl>
				<dl class="next2">
					<dt class="master-col">주)법정근로시간</dt>
					<dd>
						<input type="text" id="week_law_work_hour">
						<input type="hidden" name="week_law_work_min">
						<span>시간</span>
					</dd>
					<dt class="ml50 master-col">주)시간외+휴일근로시간</dt>
					<dd>
						<!-- week_ot_work_min만 사용 week_holiday_min은 여유컬럼 -->
						<input type="text" id="week_ot_work_hour">
						<input type="hidden" name="week_ot_work_min">
						<span>시간</span>
					</dd>
					<dt class="ml50 master-col">주)총 근로시간</dt>
					<dd>
						<input type="text" id="week_total">
						<span>시간</span>
					</dd>
				</dl>
				<dl class="next2">
					<dt class="master-col">탄력)3M최대주평균근로시간</dt>
					<dd>
						<input type="text" id="flex_3m_week_hour">
						<input type="hidden" name="flex_3m_week_min">
						<span>시간</span>
					</dd>
					<dt class="ml50 master-col">탄력)2W최대주평균근로시간</dt>
					<dd>
						<input type="text" id="flex_2w_week_hour">
						<input type="hidden" name="flex_2w_week_min">
						<span>시간</span>
					</dd>
					<dt class="ml50 master-col">야간근무추가보상</dt>
					<dd>
						<input type="text" id="night_work_reward" name="night_work_reward">
						<span>배</span>
					</dd>
				</dl>
			</div>
			<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
			<input type="hidden" name="ieParsing" value="ie">
		</form>
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">사원별 근무유형 관리</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="empListPopBtn">등록</button>
					<button type="button" id="empUpdatePopBtn">수정</button>
					<button type="button" id="empDeleteBtn">삭제</button>
				</div>
			</div>
		</div>
		
		<div class="com_ta2 mt5" id="gridOverWkEmpSetList"></div><!-- Mapping1 -->
		<!--
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">휴일근무설정</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="holidaySetPopBtn">등록</button>
					<button type="button" id="holidayUpdatePopBtn">수정</button>
					<button type="button" id="holidayDeleteBtn">삭제</button>
				</div>
			</div>
		</div>
		
		<div class="con_ta2 mt5" id="gridHoliTypeList"></div> Mapping2 -->
	</div>	
</div>

<!-- 개인 시간외근무 인정시간 등록 팝업 -->
<div class="pop_wrap_dir" id="empListPop" style="width:750px;">
	<div class="pop_head">
		<h1>사원리스트</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width:65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" class="grid_reload" style="width:120px;">
				</dd>
				<dt>부서</dt>
				<dd>
					<input type="text" id="dept_name" class="grid_reload" style="width:180px;">
					<input type="button" id="empSearchBtn" value="검색">
				</dd>
			</dl>
		</div>
		<div class="com_ta mt15">
			<div id="gridEmpList"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="empListPopSave" value="저장">
			<input type="button" class="gray_btn" id="empListPopClose" value="닫기">
		</div>
	</div>
</div>

<!-- 개인 시간외근무 인정시간 수정 팝업 -->
<div class="pop_wrap_dir" id="empSetUpdatePop" style="width:750px;">
	<div class="pop_head">
		<h1>인정시간 수정</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta mt15">
			<div id="gridEmpSetUpdate"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="empSetUpdatePopSave" value="저장">
			<input type="button" class="gray_btn" id="empSetUpdatePopClose" value="닫기">
		</div>
	</div>
</div>

<!-- 휴일근무설정 등록 팝업 -->
<div class="pop_wrap_dir" id="holidaySetPop" style="width:600px;">
	<div class="pop_head">
		<h1>휴일근무설정</h1>
	</div>
	<form method="post" name="holidaySetFrm"
		action="${pageContext.request.contextPath }/subHoliday/holidaySet">
		<input type="hidden" name="create_emp_seq" value="${empInfo.empSeq }">
		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt style="width:65px;">근무유형</dt>
					<dd>
						<input type="text" name="work_type" class="grid_reload2" style="width:118px;" required="required">
						<span id="type_validation"></span>
					</dd>
				</dl>
				<dl>
					<dt style="width:65px;">출근시간</dt>
					<dd>
						<input id="attend_time_picker" name="attend_time" style="width:120px;">
					</dd>
					<dt style="width:65px;">퇴근시간</dt>
					<dd>
						<input id="leave_time_picker" name="leave_time" style="width:120px;">
					</dd>
				</dl>
				<dl>
					<dt style="width:65px;">인정시간</dt>
					<dd>
						<input id="admit_time_picker" style="width:120px;">
						<input type="hidden" name="admit_time_min">
					</dd>
				</dl>
<!--			<dl>
					<dt style="width:65px;">휴게시간</dt>
					<dd>
						<input id="rest_time_picker" style="width:120px;">
						<input type="hidden" name="rest_time">
					</dd>
				</dl> -->
				<dl>
					<dt style="width:65px;">비고</dt>
					<dd>
						<input type="text" name="remark" style="width: 338px;">
					</dd>
				</dl>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="submit" id="holidaySetPopSave" value="저장">
				<input type="button" class="gray_btn" id="holidaySetPopClose" value="닫기">
			</div>
		</div>
	</form>
</div>

<script type="text/template" id="holiSetTemplate">
</script>
<div id="addWorkType" style="display: none;">
	<select class="addWorkType" style="width: 80%;">
	<c:forEach items="${workType }" var="list">
		<option value="${list.common_code_id }">${list.code_kr }</option>
	</c:forEach>
	</select>
</div>
