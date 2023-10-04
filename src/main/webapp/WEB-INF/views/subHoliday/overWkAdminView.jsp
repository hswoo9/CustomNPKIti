<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>

<style type="text/css">
.k-header .k-link{
   text-align: center;
 
}
.k-grid-content>table>tbody>tr
{
   text-align: center;
} 
.k-grid th.k-header,
.k-grid-header
{
     background : #F0F6FD;
} 
.select-box {
	height: 24px;
	margin-top: 0px;
}
.inputFrm, .updateFrm {
	display: none;
}
</style>

<script type="text/javascript">
 
$(document).ready(function() {
	/*
		부서목록 - KendoComboBox(#deptListBox)
	*/
	var comboBox = $("#deptListBox").kendoComboBox({
		dataSource: new kendo.data.DataSource({
			transport: {
				read: {
					url: _g_contextPath_+ '/common/getDeptList',
					dataType: 'json',
					type: 'post'
				},
				parameterMap: function(data, operation){
					return data;
				}
			},
			schema: {
				data: function(response){
					response.allDept.unshift({dept_name: "전체", dept_seq: ""});
					return response.allDept;
				}
			}
		}),
		dataTextField: 'dept_name',
		dataValueField: 'dept_seq',
		change: function(e){
			var rows = comboBox.select();
			var record = comboBox.dataItem(rows);
			//console.log(record);
			$("[name='apply_dept_name']").val(record.dept_name);
			$("[name='apply_dept_name2']").val(record.dept_name);
		},
		index: 0,
		open: function(e){
			$("#applyEmpName").val("");
			$("[name='apply_emp_seq']").val("");
		}
	}).data("kendoComboBox");
	
	/*
		시간외근무 신청 - 신청자 검색 팝업(#empListPop)
	*/
	var myWindow = $("#empListPop"),
		undo = $("#empListPopBtn");
	undo.click(function(){
		myWindow.data("kendoWindow").open();
		undo.fadeOut();
		empGrid();
	});
	$("#empListPopClose").click(function(){
		myWindow.data("kendoWindow").close();
	});
	myWindow.kendoWindow({
		width: "600px",
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
						url: _g_contextPath_ + '/common/empInformation',
						dataType: 'json',
						type: 'post'
					},
					parameterMap: function(data, operation){
						data.deptSeq = $("#deptListBox").val(); 
						data.emp_name = $("#emp_name").val();
						data.dept_name = $("#dept_name").val();
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
				field: "emp_name",
				title: "이름",
				attributes: {
					style: "padding-left: 0 !important"
				}
			},{
				field: "dept_name",
				title: "부서"
			},{
				field: "position",
				title: "직급"
			},{
				field: "duty",
				title: "직책"
			},{
				title: "선택",
				template: '<input type="button" class="text_blue emp_select" value="선택">',
				attributes: {
					style: "padding-left: 0 !important"
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
		$(document).on('click', ".emp_select", function(){
			var row = $("#gridEmpList").data("kendoGrid").dataItem($(this).closest("tr"));
			$("#applyEmpName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
			$("[name='apply_emp_seq']").val(row.emp_seq);
			$("[name='userSeq2']").val(row.emp_seq);
			myWindow.data("kendoWindow").close();
		});
	}
	
	/*
		엑셀다운로드
	*/
/* 	$(document).on('click', "#excelBtn", function(e){
		e.preventDefault();
 		//$("[name='date2']").val($('#monthpicker').val().replace(/-/gi , ''));
 		$("[name='startDt']").val($('#startDt').val().replace(/-/gi , ''));
 		$("[name='endDt']").val($('#endDt').val().replace(/-/gi , ''));
 		$("[name='apply_dept_name2']").val();
 		$("[name='userSeq2']").val();
		document.overWkExcelList.submit();		
	}); */
	$("#excelBtn").click(function(e){
		e.preventDefault();
 		//$("[name='date2']").val($('#monthpicker').val().replace(/-/gi , ''));
 		$("[name='startDt']").val($('#startDt').val().replace(/-/gi , ''));
 		$("[name='endDt']").val($('#endDt').val().replace(/-/gi , ''));
 		$("[name='apply_dept_name2']").val();
 		$("[name='userSeq2']").val();
		document.overWkExcelList.submit();		
	});
	
	/* 검색 Enter 버튼 작동처리 */		
	 $('.top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			$('#grid').data('kendoGrid').dataSource.read();
		};
	});
	
	 /* kendo datepicker 년월 처리 */
	$("#monthpicker").kendoDatePicker({
	    // defines the start view
	    start: "year",
	
	    // defines when the calendar should return date
	    depth: "year",
	
	    // display month and year in the input
	    format: "yyyy-MM",
		parseFormats : ["yyyy-MM"],
		culture : "ko-KR",
		// specifies that DateInput is used for masking the input element
		dateInput: true
	});
	var date = new Date(), y = date.getFullYear(), m = date.getMonth();
	var firstDay = new Date(y, m, 1);
	var lastDay = new Date(y, m + 1, 0);
	$("#startDt").kendoDatePicker({
		start : "month",
		depth : "month",
		format : "yyyy-MM-dd",
		parseFormats : [ "yyyy-MM-dd" ],
		culture : "ko-KR",
		value: firstDay
	});
	$("#endDt").kendoDatePicker({
		start : "month",
		depth : "month",
		format : "yyyy-MM-dd",
		parseFormats : [ "yyyy-MM-dd" ],
		culture : "ko-KR",
		value : lastDay
	});
	$("#startDt").attr("readonly", true);
	$("#endDt").attr("readonly", true);
	
	/* 연장근무 개인조회 시간 정보 조회 그리드 (첫번째 그리드) */
	var timeGridDataSource = new kendo.data.DataSource({
		serverPaging: false,
		pageSize: 1,
		info: false,
	    transport: { 
	        read:  {
	            url: _g_contextPath_+'/subHoliday/overWkTimeList',
	            dataType: "json",
	            type: 'post'
	        },
	      	parameterMap: function(data, operation) {
	      		//data.date = $('#monthpicker').val().replace(/-/gi , '');
	      		data.startDt = $('#startDt').val().replace(/-/gi , '');
	      		data.endDt = $('#endDt').val().replace(/-/gi , '');
	        	data.userSeq = $("[name='apply_emp_seq']").val();
	        	data.notIn = '';
	        	data.apply_dept_name = $("[name='apply_dept_name']").val();
	     	return data;
	     	}
	    },
	    schema: {
	      data: function(response) {
	        return response.list;
	      }
	    }
	});
		
	/* 연장근무 개인조회 시간 정보 조회 그리드 (첫번째 그리드) refresh */
	function timeGridReload(){
		$('#timeGrid').data('kendoGrid').dataSource.read();
	}
		
	/* 연장근무 개인조회 시간 정보 조회 그리드 (첫번째 그리드) */
	function timeGrid(){
		//캔도 그리드 기본
		var timeGrid = $("#timeGrid").kendoGrid({
	        dataSource: timeGridDataSource,
	        pageable: false,
	        scrollable: false,
	        editable: {
	            mode: 'inline',
	        },
	        columns: [
	        {
	            field: "APPLY_HOUR",
	            title: "신청시간",
	        }, {
	            field: "OCCUR_HOUR",
	            title: "발생시간",
	        }, 
 	        {
	            field: "AGREE_HOUR",
	            title: "인정시간",
	        } 
	        ],
	        change: function (e){
	        }
	    }).data("kendoGrid");
	}	
		
	/* 데이터 없을 시 그리드 처리 함수 */
	function gridDataBound(e) {
	       var grid = e.sender;         
	       if (grid.dataSource.total() == 0) {
	           var colCount = grid.columns.length;
	           $(e.sender.wrapper)
	               .find('tbody')
	               .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
	       }
	};		

	/* 연장근무 개인 신청내역 그리드 */
	var dataSource = new kendo.data.DataSource({
		serverPaging: false,
		info: false,
	    transport: { 
	        read:  {
	            url: _g_contextPath_+'/subHoliday/overWkList',
	            dataType: "json",
	            type: 'post'
	        },
	      	parameterMap: function(data, operation) {
	      		//data.date = $('#monthpicker').val().replace(/-/gi,"");
	      		data.startDt = $('#startDt').val().replace(/-/gi , '');
	      		data.endDt = $('#endDt').val().replace(/-/gi , '');
	         	data.userSeq = $("[name='apply_emp_seq']").val();
				data.deptSeq = 'all';
				data.apply_dept_name = $("[name='apply_dept_name']").val();
	     	return data;
	     	}
	    },
	    schema: {
	      data: function(response) {
	        return response.list;
	      }
	    }, 
	    group: {	// 신청인 별로 그룹화하고 인정시간 sum 구하기
	    	field: "empName", aggregates: [
	        	{ field: "empName", aggregate: "max" },
	            { field: "applyMin", aggregate: "sum" },
	            { field: "agreeMin", aggregate: "sum" },
	            { field: "occurMin", aggregate: "sum" },
	            { field: "breakMin", aggregate: "sum" },
	            { field: "nightWorkMin", aggregate: "sum" },
	    	]
	    },
	    aggregate: [ 
	    	{ field: "applyMin", aggregate: "sum" },
 	        { field: "agreeMin", aggregate: "sum" },
	        { field: "occurMin", aggregate: "sum" },
	        { field: "breakMin", aggregate: "sum" },
	        { field: "nightWorkMin", aggregate: "sum" },
 	    ]
	});

	function gridReload(){
		$('#grid').data('kendoGrid').dataSource.read();
	}

	function fn_workDn(row) {
		var html = row.workDn == null ? '<span>B형</span>' : '<span>'+row.workDn+'</span>';
		return html;
	}


	/* 연장근무 개인 신청내역 그리드 */
	function mainGrid(){
		//캔도 그리드 기본
		var grid = $("#grid").kendoGrid({
	        dataSource: dataSource,
//	         dataBound: gridDataBound,
	        height: 500,
	        scrollable:{
	            endless: true
	        },
	        sortable: true,
	        persistSelection: true,
	        selectable: "multiple",
	        columns: [
	        {
	            field: "apply_dept_name",
	            title: "부서",
	        },{
	            field: "empName",
	            title: "성명",
	            groupFooterTemplate: "<span class=''>#=max# 합계</span>",
	            footerTemplate: "<span class='text_blue'>총계</span>",
	        },{
	            field: "applyDate",
	            title: "신청일자",
	        }, {
	        	field: "weekDay",
				title: "요일",
				template : function(row){
					var key = row.weekDay;
	            	switch(key){
	            	case '토': return "<span style='color:blue'>"+ key +"</span>"; break;
	            	case '일': return "<span style='color:red'>"+ key +"</span>"; break;
	            	case undefined : return "<span></span>"; break;
	            	default : return "<span>"+ key +"</span>"; break; 
	            	}
	            },
	            width: 50
	        },{
	        	field: "otType",
	        	title: "평일휴일",
	        	template: function(row){
	        		var key = row.otType;
	            	switch(key){
	            	case '평일': return "<span>"+ key +"</span>"; break;
	            	case '휴일': return "<span style='color:red'>"+ key +"</span>"; break;
	            	case undefined : return "<span></span>"; break;
	            	default : return "<span>"+ key +"</span>"; break; 
	            	}
	        	}
	        },{
	        	field: "work_place",
	        	title: "근무지",
	        	template: function(row){
	        		if(row.work_place === 'outdoor'){
	        			return "<span>외근</span>";
	        		}else if(row.work_place === 'indoor'){
	        			return "<span>내근</span>";
	        		}else{
	        			return "";
	        		}
	        	}
	        },{
	        	field: "after_action_report",
	        	title: "초과근무보고서",
	        	template: function(row){
	        		if(row.work_place == 'outdoor'){
	        			/* if(row.approval_status == '5' || row.approval_status == '2'){
		        			return '<input type="button" class="fileDownLoad text_blue" value="초과근무보고서">'; 
		        		}else if(row.approval_status == '1'){
		        			return '<input type="button" class="text_red fileUpLoad" value="보고서등록">';
		        		}  */
	        			if(row.after_action_report_id === undefined){
		        			return '<span class="text_red">보고서미등록</span>';
		        		}else{
		        			return '<input type="button" class="fileDownLoad text_blue" value="초과근무보고서">'; 
		        		}
	        		}else{
	        			return '';
	        		}
	        	}
	        },{
	            field: "workType",
	            title: "근무유형",
	        }, {
	            field: "apply_start_time",
	            title: "신청시작시간",
	        }, {
	            field: "apply_end_time",
	            title: "신청종료시간",
	        }, {
	        	field: "come_dt",
	            title: "실제출근시간",
	        }, {
	            field: "leave_dt",
	            title: "실제퇴근시간",
	        },{
				field: "approval_status_kr",
				title: "진행단계",
				template: function(row){
					var status = row.approval_status;
					var status_kr = '';
					switch(status){
					case '0': status_kr = '변경신청'; break;
					case '1': status_kr = '신청'; break;
					case '2': status_kr = '승인'; break;
			 		//case '3': status_kr = '승인취소'; break;
					case '4': status_kr = '반려'; break;
					case '5': status_kr = '승인대기'; break;
					}
					return status_kr;
				},
				width: 80
			}, {
				field: "approval_emp_name",
				title: "승인권자"
			}, {
	            field: "applyMin",
	            template: "#=kendo.parseInt(applyMin/60,'n0')#시간 #=applyMin%60#분",
	            title: "신청시간",
	            groupFooterTemplate:"<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	            footerTemplate:"<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	        }, {
	            field: "occurMin",
	            template: "#=kendo.parseInt(occurMin/60,'n0')#시간 #=occurMin%60#분",
	            title: "발생시간",
	            groupFooterTemplate:"<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	            footerTemplate:"<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	        }
 	        , {
	        	field: "breakMin",
	        	title: "휴게시간",
	        	template: "#=breakMin#분",
	        	groupFooterTemplate: "<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	        	footerTemplate: "<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>"
	        }, {
 	            field: "agreeMin",
	            template: "#=kendo.parseInt(agreeMin/60,'n0')#시간 #=agreeMin%60#분",
	            title: "인정시간", 
	            groupFooterTemplate:"<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	            footerTemplate:"<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	        }, {
	        	field: "nightWorkMin",
	        	title: "야간근무시간",
	        	template: "#=kendo.parseInt(nightWorkMin/60,'n0')#시간 #=nightWorkMin%60#분",
	        	groupFooterTemplate: "<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
	        	footerTemplate: "<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>"
	        },{
	            field: "reward_type",
	            title: "보상선택",
	            template: function(row){
					var reward_type = row.reward_type;
					var reward_type_result = '';
					switch(reward_type){
					case '1': reward_type_result = '수당'; break;
					case '2': reward_type_result = '보상휴가'; break;
					}
					return reward_type_result;
				}
	        }
	        ],
	        change: function (e){
	        	//codeGridClick(e);
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
	/* 검색버튼 기능 함수 */
	/* ;;; document on 붙일 수 있는 한계 있는듯 
	$(document).on('click', '#searchBtn', function(){
		timeGridReload();	
		gridReload();
	}); */
	$("#searchBtn").click(function(){
		timeGridReload();	
		gridReload();
	});
	
	timeGrid();
	
	mainGrid();
	
	/*
		휴일근무 - 보고서 다운로드 팝업(#fileDownloadPop)
	*/
	var myWindow2 = $("#fileDownloadPop");
	$(document).off('click').on('click', "[value='초과근무보고서']", function(){
		$("#report_name").html($(this).val());
		var row = $("#grid")
					.data("kendoGrid")
					.dataItem($(this).closest("tr"));
		var json = row.toJSON();
		var target_table_name = '';
		if($(this).val() === '근무계획서'){
			target_table_name = "work_plan_report_id";
		}else if($(this).val() === '초과근무보고서'){
			target_table_name = "after_action_report_id";
		}
		myWindow2.data("kendoWindow").open();
		$.getJSON(_g_contextPath_ + '/subHoliday/getFileInfo',
				{'target_table_name': target_table_name, 'target_id': json.ot_work_apply_id},
				function(data){
					var real_file_name = data.real_file_name,
						file_extension = data.file_extension,
						attach_file_id = data.attach_file_id;
					html = document.querySelector("#fileDownloadTemplate").innerHTML;
					var resultHTML = html.replace("{real_file_name}", real_file_name)
										 .replace("{file_extension}", file_extension)
										 .replace("{attach_file_id}", attach_file_id);
					$("#fileDownloadDiv").empty().append(resultHTML);
					if(json.approval_status === "2"){
						$.getJSON(_g_contextPath_ + '/subHoliday/getAgreeMin',
								{'ot_work_apply_id': json.ot_work_apply_id},
								function(jj){
									$("#fileDownloadDiv").find('[class="inputFrm"]').show();
									ct2KendoTimePicker($("#start_time_picker"), $("#end_time_picker"));
									var requestURL = "";
									if(jj.min.agree_min !== ''){
										var agree__min = jj.min.agree_min;
										$("#fileDownloadDiv").find('tr[class="updateFrm"]').show();
										$("[name='agree_min']").val(agree__min);
										$("[name='agree_min_old']").val(agree__min);
										$("[name='use_min']").val(jj.min.use_min);
										$("[name='rest_min']").val(agree__min);
										$("[name='rest_min_old']").val(agree__min);
										$("#start_time_picker").data("kendoTimePicker").value(jj.time.work_start_time);
										$("#end_time_picker").data("kendoTimePicker").value(jj.time.work_end_time);
										$("#agree_min_show").val(
											parseInt(agree__min/60) + "시간" + parseInt(agree__min%60) + "분"
										);
										if(json.ot_type_code_id === 572){//572: 평일, 573: 휴일
											$("#use-rest").css('display', 'none');
										}else{
											$("#use_rest_show").val(
													'인정: ' + agree__min + '분'		
											);///사용: ' + jj.min.use_min + '분/잔여: ' + agree__min + '분'
											$("#is_use_rest").val("true");
										}
										$("#inputFrmBtn").val("수정");
										requestURL = "updateAgreeMin";
									}else{
										if(json.ot_type_code_id === 572){//572: 평일, 573: 휴일
											$("#use-rest").css('display', 'none');
										}
										requestURL = "inputAgreeMin";
									}
									$(document).off('submit').on('submit', "[name='inputAgreeMinFrm']", function(e){
										e.preventDefault();
										var formData = new FormData($(this).get(0));
										console.log(json)
										formData.append('ot_work_apply_id', json.ot_work_apply_id);
										formData.append('occur_min', temp_occur_min);
										formData.append('apply_start_date', json.apply_start_date);
										formData.append('create_emp_seq', "${userInfo.empSeq}");
										//평일시간외근무(수당보상)
										if(json.ot_type_code_id === 573){//572: 평일, 573: 휴일
											formData.append('isHoliday', "isHoliday");
										}
										$.ajax({
											url: _g_contextPath_ + '/subHoliday/' + requestURL,
											type: 'post',
											dataType: 'json',
											data: formData,
											contentType: false,
											processData: false,
											success: function(json){
												if(json.code === 'success'){
													myWindow.data("kendoWindow").close();
													//mainGridReload();
													timeGridReload();
													gridReload();
													alert("서버 저장 성공!!");
													myWindow2.data("kendoWindow").close();
												}else{
													alert("서버 저장 실패..");
												}
											}
										});
									});
								});
					}
				});
	});
	myWindow2.kendoWindow({
		width: "400px",
		title: "첨부파일 다운로드",
		visible: false,
		modal: true,
		actions: [
			"Close"
		],
		close: function(){
			
		}
	}).data("kendoWindow").center();
	
	function ct2KendoTimePicker(a, b){
		
		var startTime = $(a).kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			interval: 30,
		    change: startChange
		}).attr("readonly", true).data("kendoTimePicker");
	
		var endTime = $(b).kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			interval: 30,
		}).attr("readonly", true).data("kendoTimePicker");
	
		function startChange(){
			if(startTime.value() > endTime.value()){
				endTime.value('');
			}
			var sTime = new Date(startTime.value());
			endTime.min(sTime);
			/* 최대 8시간 제한
			sTime.setHours(sTime.getHours()+8);
			endTime.max(sTime)
			*/
		}
		
	}
	var temp_occur_min = '0';
	$(document).off('change').on('change', '.time_picker', function(e){
		e.stopPropagation(); // js, jQuery event bubbling stop
		var start_time_picker = $("#start_time_picker").data("kendoTimePicker");
		var end_time_picker = $("#end_time_picker").data("kendoTimePicker");
		var start_time = $("#start_time_picker").val();
		var end_time = $("#end_time_picker").val();
		if(start_time !== null && end_time !== null && start_time !== '' && end_time !== ''){
			var data = {
				attend_time : start_time
				,leave_time : end_time
			}
			$.ajax({
				url: _g_contextPath_ + "/workPlan/getWorkMin",
				type : 'POST',
				data: data,
				async   : false,
				success: function(result){
					console.log('근무시간: ' + result.work_min + ' 휴게시간: ' + result.rest_min);
					//var work_min = parseInt((result.work_min*1.5)-(result.work_min*1.5)%30);
					var work_min = parseInt((result.work_min)-(result.work_min)%30);	//1.5배 뺌
					var agreed_min_old = $("[name='agree_min_old']").val();
					$("#agree_min_show").val(parseInt(work_min/60) + "시간" + parseInt(work_min%60) + "분(휴게시간: " + result.rest_min + "분)");
					$("[name='agree_min']").val(work_min);
					$("[name='occur_min']").val(result.work_min);
					temp_occur_min = result.work_min;
					$("[name='break_min']").val(result.rest_min);
					if($("#is_use_rest").val() !== ""){
						var rest_min = parseInt($("[name='rest_min']").val()); //위에서 구한 휴게시간이랑 다름...잔여시간임!!!
						var rest_change_min = rest_min + (work_min - parseInt(agreed_min_old));
						$("[name='rest_min']").val(work_min);
						$("#chagen_use_rest_show").val(
							'인정: ' + work_min + '분'
						);///사용: ' + $("[name='use_min']").val() + '분/잔여: ' + rest_change_min + '분'
					}else{
						$("#use_rest_show").val(
								'인정: ' + work_min + '분/사용: 0분/잔여: ' + work_min + '분' 		
						);
					}
				}
			});
		}
	});
	
	/*
		휴일근무 - 초과근무보고서 파일 다운로드(#fileText)
	*/
	$(document).on('click', '#fileText', function(e){
		e.preventDefault();
		var attach_file_id = $("[name='attach_file_id']").val();
	
		$.ajax({
			url: _g_contextPath_ + '/common/fileDown',
			type: 'get',
			data: {'attach_file_id': attach_file_id}
		}).success(function(data){
			var downWin = window.open('','_self');
			downWin.location.href = _g_contextPath_+'/common/fileDown?attach_file_id='+attach_file_id;
		});
	});
	
});
	</script> 

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>근무계획</h4>
		</div>
	</div>
	<div class="sub_contents_wrap">
	<p class="tit_p mt5 mt20">연장근무 신청 리스트</p>
		<div class="top_box">
			<dl>
				<dt  class="ar" style="width:65px" >년월</dt>
				<dd>
					<%-- <input type="text" value="${nowDate}" name="" id="monthpicker" placeholder="" /> --%>
					<input type="text" value="" id="startDt" class="w113"/>
					&nbsp;~&nbsp;
					<input type="text" value="" id="endDt"	class="w113" />
				</dd>
				<dt  class="ar" style="width:65px" >부서</dt>
				<dd>
					<input id="deptListBox" class="select-box">
					<input type="hidden" name="apply_dept_name">
				</dd>
				<dt  class="ar" style="width:65px" >성명</dt>
				<dd>
					<input type="text" value="" 
					id="applyEmpName" style="width:160px;" disabled="disabled">
					<input type="hidden" name="apply_emp_seq" value="">
					<input type="button" id="empListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
				</dd>
			</dl>
		</div>
		<div class="btn_div mt10 cl">
			<div class="right_div">
				<div class="controll_btn p0">
					<form method="post" name="overWkExcelList" 
					action="${pageContext.request.contextPath }/subHoliday/overWkExcelList">
					<input type="hidden" name="startDt">
					<input type="hidden" name="endDt">
					<input type="hidden" name="date2">
					<input type="hidden" name="apply_dept_name2">
					<input type="hidden" name="userSeq2">
						<button type="submit" id="excelBtn">엑셀다운로드</button>										
						<button type="button" id="searchBtn">조회</button>
					</form>
				</div>
			</div>			
		</div>
		<div style="margin: 0 auto;max-width: 800px">
			<!-- 버튼 -->
			<div class="btn_div mt10 cl">
				<div class="left_div">
					<p class="tit_p mt5 mb0">연장근무 신청 리스트</p>
				</div>	
			</div>
		</div>
		<div id="midWrap" style="max-width: 800px; margin: 0 auto">
			<div class="com_ta2">
				<div id="timeGrid"></div>
			</div>
		</div>
		<div class="com_ta2 mt15">
		    <div id="grid"></div>
		</div>						
	</div><!-- //sub_contents_wrap -->
</div><!-- iframe wrap -->

<!--// 팝업----------------------------------------------------- -->
	<!-- <div class="modal"></div> -->
	
<!-- 신청자 검색 팝업  -->
<div class="pop_wrap_dir" id="empListPop" style="width:600px;">
	<div class="pop_head">
		<h1>사원리스트</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width:65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" class="grid_reload" style="width:120px;">
					<input type="button" id="empSearchBtn" value="검색">
				</dd>
<!-- 				<dt>부서</dt>
				<dd>
					<input type="text" id="dept_name" class="grid_reload" style="width:180px;">
					<input type="button" id="empSearchBtn" value="검색">
				</dd> -->
			</dl>
		</div>
		<div class="com_ta mt15">
			<div id="gridEmpList"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" id="empListPopClose" value="닫기">
		</div>
	</div>
</div>
<!-- 보고서 다운로드 팝업 -->
<div class="pop_wrap_dir" id="fileDownloadPop" style="width:400px; display: none;">
	<div class="pop_con">
		<div class="btn_div mt0">
			<div class="left_div">
				<h5>초과근무보고서</h5>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
				</div>
			</div>
		</div>
		<div class="com_ta" style="" >
			<form name="inputAgreeMinFrm" id="fileDownloadDiv" action="<c:url value='/subHoliday/inputAgreeMin'/>" ></form>
				<!-- <table id="fileDownloadDiv"></table> -->
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" value="닫기"/>
		</div>
	</div>
</div>

<script id="fileDownloadTemplate" type="text/template">
<table>
	<tr>
		<th style="width: 85px;">첨부파일</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<img src="<c:url value='/Images/ico/ico_clip02.png'/>" alt="attach_file">&nbsp;
				<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF"
				 id="fileText" class="file_name">{real_file_name}.{file_extension}</a>&nbsp;
				<input type="hidden" name="attach_file_id" value="{attach_file_id}">
			</span>
		</td>
	</tr>
	<tr class="inputFrm">
		<th style="width: 85px;">출근시간입력</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input id="start_time_picker" name="attend_time" class="time_picker">
			</span>
		</td>
	</tr>
	<tr class="inputFrm">
		<th style="width: 85px;">퇴근시간입력</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input id="end_time_picker" name="leave_time" class="time_picker">
			</span>
		</td>
	</tr>
	<tr class="inputFrm">
		<th style="width: 85px;">인정시간</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input type="text" id="agree_min_show" value="" readonly style="width: 95%;">
			</span>
		</td>
	</tr>
	<!-- <tr class="inputFrm" id="use-rest">
		<th style="width: 85px;">인정/사용/잔여</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input type="text" id="use_rest_show" value="" readonly style="width: 95%;">
				<input type="hidden" id="is_use_rest" value="">
			</span>
		</td>
	</tr> -->
	<tr class="updateFrm">
		<th style="width: 85px;">변경후</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input type="text" id="chagen_use_rest_show" value="" readonly style="width: 95%;">
			</span>
		</td>
	</tr>
	<tr class="inputFrm">
		<td colspan="2" style="padding: 0; padding-bottom: 5px;">
			<div class="btn_cen">
				<input type="submit" class="blue_btn" id="inputFrmBtn" value="저장">
			</div>
		</td>
	</tr>
	<input type="hidden" name="agree_min_old" value="">
	<input type="hidden" name="agree_min" value="">
	<input type="hidden" name="use_min" value="">
	<input type="hidden" name="rest_min_old" value="">
	<input type="hidden" name="rest_min" value="">
	<input type="hidden" name="break_min" value="">
	<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
	<input type="hidden" name="ieParsing" value="ie">
</table>
</script>
