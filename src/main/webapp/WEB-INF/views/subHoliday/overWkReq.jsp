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
<jsp:useBean id="nowTime" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
<fmt:formatDate value="${nowTime}" var="nowTime" pattern="HHmm" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>

<style type="text/css">
	.time-input {
		width: 51px; 
		height: 24px; 
		margin-top: 0px;
	}
	.col-6 {
		position:absolute;
		left:45%;
	}
	.mid-box-bg {
		background: #F0F6FD;
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
	.top_box input[type='submit'] {
		background: #1088e3;
		height: 24px;
		padding: 0 11px;
		color: #fff;
		border: none;
		font-weight: bold;
		border-radius: 0px;
		cursor: pointer;
	}
	.top_box input[type='submit'][disabled='disabled'] {
		background: silver;
	}
</style>

<script type="text/javascript">
	function gridReload(){
		$("#gridOverWkMonthList"/* Mapping1 */).data('kendoGrid').dataSource.read();
	}
	$(function(){
		//console.log("${empInfo}");
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
							data.deptSeq = "${empInfo.deptSeq}"; //같은 부서 사람들만 대신 신청 가능
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
			$(document).on('click', ".emp_select", function(){
				var row = $("#gridEmpList").data("kendoGrid").dataItem($(this).closest("tr"));
				$("#applyEmpName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
				$("[name='apply_emp_seq']").val(row.emp_seq);
				$("[name='apply_dept_name']").val(row.dept_name);
				$("[name='apply_position']").val(row.position);
				$("[name='apply_duty']").val(row.duty);
				$("[name='apply_duty_code']").val(row.duty_code);
				myWindow.data("kendoWindow").close();
			});
		}
		/*
			시간외근무 신청 - 승인권자 검색 팝업(#headerListPop)
		*/
		var myWindow2 = $("#headerListPop"),
			undo2 = $("#headerListPopBtn");
		undo2.click(function(){
			myWindow2.data("kendoWindow").open();
			undo2.fadeOut();
			headerGrid();
		});
		$("#headerListPopClose").click(function(){
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
			width: "600px",
			height: "665px",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				undo2.fadeIn();
				$("#header_name").val("");
				$("#header_dept_name").val("");
			}
		}).data("kendoWindow").center();
		
		function headerGridReload(){
			$("#gridHeaderList"/* popUpGrid2 */).data("kendoGrid").dataSource.read();
		}
		$("#headerSearchBtn").click(function(){
			headerGridReload();
		});
		$(document).on({
			'keyup': function(event){
				if(event.keyCode===13){//enterkey
					headerGridReload();
				}
			}
		},".grid_reload2");
		
		var headerGrid = function(){
			var grid = $("#gridHeaderList"/* popUpGrid2 */).kendoGrid({
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
							data.deptSeq = '';//"${empInfo.deptSeq}";
							data.emp_name = $("#header_name").val();
							data.dept_name = $("#header_dept_name").val();
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
					template: '<input type="button" class="text_blue header_select" value="선택">',
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
			$(document).on('click', ".header_select", function(){
				var row = $("#gridHeaderList").data("kendoGrid").dataItem($(this).closest("tr"));
				$("#headerName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
				$("[name='approval_emp_seq']").val(row.emp_seq);
				$("[name='approval_emp_name']").val(row.emp_name);
				myWindow2.data("kendoWindow").close();
			});
		}
		
		/*
			근무시간 불러오기(subHoliday/getWorkTime)
		*/
		$("#startDt").change(function(){
			var strArray = this.value.split('-');
			var str='';
			for(var i in strArray){
				str += strArray[i];
			}
	    	$("[name='apply_start_date']").val(str);
	    	$.getWorkTime(str, $("[name='apply_emp_seq']").val());
	    	var startTimePicker = $("#start_time_picker").data("kendoTimePicker");
			var endTimePicker = $("#end_time_picker").data("kendoTimePicker");
			startTimePicker.value('');
			endTimePicker.value('');
			startTimePicker.enable(false);
			endTimePicker.enable(false);
			$("#applyBtn").prop('disabled', true);
			$("#applyBtn").css("background", "silver");
		});
		$.workTimeErrorMsg = function(msg){
			$("#workTimeErrorMsg").html(msg);
			$(".workTimeError").show();
			$("#errorMsg").slideDown();
			$("#workTime").val('');
			$("[name='work_start_time']").val('');
			$("[name='work_end_time']").val('');
			$("[name='work_min']").val('');
			setTimeout(function(){
				$("#errorMsg").slideUp();
				setTimeout(function(){
					$(".workTimeError").hide();
				}, 500);
			}, 2000);
		}		
		$.getWorkTime = function(work_date, emp_seq){
			$.getJSON(_g_contextPath_ + '/subHoliday/getWorkTime',
					{'work_date': work_date, 'emp_seq': emp_seq},
					function(data){
						var startTimePicker = $("#start_time_picker").data("kendoTimePicker");
						var endTimePicker = $("#end_time_picker").data("kendoTimePicker");
						if(data.holiday === true || data.work_type_id == '6'){
							$.workTimeErrorMsg("휴일 근무 신청은 '휴일근무 신청 탭'에서 해주세요.");
							startTimePicker.enable(false);
							endTimePicker.enable(false);
							startTimePicker.value('');
							endTimePicker.value('');
							$("#applyBtn").prop('disabled', true);
				    		$("#applyBtn").css("background", "silver");
						}else if(data.basic === true){
							$.workTimeErrorMsg("유연근무 데이터가 존재하지 않습니다. 기본 근무시간으로 설정합니다.");
							$("#workTimeErrorMsg").html("유연근무 데이터가 존재하지 않습니다. 기본 근무시간으로 설정합니다.");
							$("#workTime").val(data.attend_time + " ~ " + data.leave_time);
							$("[name='work_type_id']").val(data.work_type_id);
							$("[name='work_start_time']").val(data.attend_time);
							$("[name='work_end_time']").val(data.leave_time);
							$("[name='work_min']").val(data.work_min);
						}else if(data.status === '3'){
							$.workTimeErrorMsg("유연근무 변경 절차가 진행중입니다. 관련 절차를 완료한 이후 다시 신청해주세요.");	
							startTimePicker.enable(false);
							endTimePicker.enable(false);
							startTimePicker.value('');
							endTimePicker.value('');
							$("#applyBtn").prop('disabled', true);
				    		$("#applyBtn").css("background", "silver");
						}else{
							var workTypeId = data.work_type_id;
							$("#workTime").val(data.attend_time + " ~ " + data.leave_time);
							$("[name='work_type_id']").val(workTypeId);
							$("[name='work_start_time']").val(data.attend_time);
							$("[name='work_end_time']").val(data.leave_time);
							$("[name='work_min']").val(data.work_min);
							if(workTypeId === 13 || workTypeId === 14 || workTypeId === 15 || workTypeId === 20 || workTypeId === 58 || workTypeId === 66){
								$('#isHalf').val('none');
							}else if(workTypeId === 22){
								//반일제(14-18)
								$('#isHalf').val('none');
							}else if(workTypeId === 60){
								//육아기단축(9-4)
								$('#isHalf').val('none');
							}else{
								$('#isHalf').val('false');
							}
						}
			});
		}
		var nowTime = parseInt("${nowTime}");
		var dateMin = "";
		/*
		if(nowTime >= 1800) {
			dateMin = "${nowDate}-${dd + 1}";
			//$("[name='apply_start_date']").val("${nowDateToServer + 1 }");
			//$("#startDt").val("${nowDate}-${dd + 1}");
			$.getWorkTime("${nowDateToServer + 1}", "${empInfo.empSeq}");
		}else{
			dateMin = "${nowDate}-${dd}";
			//$("[name='apply_start_date']").val("${nowDateToServer}");
			//$("#startDt").val("${nowDate}-${dd}");
			$.getWorkTime("${nowDateToServer}", "${empInfo.empSeq}");
		}*/
		
		$.getWorkTime("${nowDateToServer}", "${empInfo.empSeq}");
		$("#startDt").data("kendoDatePicker").setOptions({
			//min: dateMin //사후신청가능
			//min: "${nowDate}-${dd}" //사후신청불가
			min: "2022-01-01" //2022-01-01 시점 사후신청 가능.
		});
		
		/*
			신청시간 라디오버튼, kendoTimePicker
		*/
		$.applyTimeErrorMsg = function(msg){
			$("#applyTimeErrorMsg").html(msg);
			$(".applyTimeError").show();
			$("#errorMsg").slideDown();
			setTimeout(function(){
				$("#errorMsg").slideUp();
				setTimeout(function(){
					$(".applyTimeError").hide();
				}, 500);
			}, 2000);
		}
		$("[name='am_pm_type']").change(function(){
			var startTimePicker = $("#start_time_picker").data("kendoTimePicker");
			var endTimePicker = $("#end_time_picker").data("kendoTimePicker");
			var workStartTime = $("[name='work_start_time']").val();
			var workEndTime = $("[name='work_end_time']").val();
			var workMin = parseInt($("[name='work_min']").val(), 10);
			var workStart = workStartTime.split(":");
			var workStartHour = parseInt(workStart[0]);
			var workStartMin = workStart[1];
			var workEnd = workEndTime.split(":");
			var workEndHour = parseInt(workEnd[0]);
			var workEndMin = workEnd[1];
			var startTimeValue = startTimePicker.value();
			if(startTimeValue === null) startTimeValue = '00:00';
			
			if(workStartTime === ''){
				$.applyTimeErrorMsg("먼저 신청일자를 선택하여 근무시간을 불러오세요.");
				startTimePicker.enable(false);
				endTimePicker.enable(false);
				$("#applyBtn").prop('disabled', true);
	    		$("#applyBtn").css("background", "silver");
				return;
			}else{
				startTimePicker.enable();
				endTimePicker.enable();
			}
			
			var isHalf = $('#isHalf').val();

			if(workMin <= 480){
				var startMin = (workEndHour + 1) + ":" + workEndMin;
				//console.log('isHalf', isHalf);
				if(isHalf === 'true'){
					startMin = (workEndHour + 1) + ":00";
					/*}else if( isHalf === 'false') {
                        startMin = (workEndHour) + ':00';*/
				}else if( isHalf === 'none'){
					startMin = (workEndHour) + ':00';
				}
			}else{
				var startMin = workEndHour + ":" + workEndMin;

				if(isHalf === 'true'){
					startMin = workEndHour + ":00";
					/*}else if( isHalf === 'false') {
                        startMin = (workEndHour) + ':00';*/
				}else if( isHalf === 'none'){
					startMin = (workEndHour) + ':00';
				}
			}


			
			if(this.value === 'AM'){
				startTimePicker.setOptions({
					min: "06:00",
					max: /* workStartTime */(workStartHour - 1) + ":" + workStartMin
				});
				endTimePicker.setOptions({
					min: startTimeValue,
					max: /* workStartTime */(workStartHour - 1) + ":" + workStartMin
				});
			}else if(this.value === 'PM'){
				startTimePicker.setOptions({
					min: /* workEndTime */startMin,
					max: "00:00"
				});
				endTimePicker.setOptions({
					min: startTimeValue,
					max: "02:00"//"00:00" 20200131 새벽2시까지 신청가능하도록	
				});
			}
		});
		
		$(".time_picker").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			change: function(){
				var id = this.wrapper.find("input").attr("id");
				var start_time_picker = $("#start_time_picker").data("kendoTimePicker");
				var end_time_picker = $("#end_time_picker").data("kendoTimePicker");
				if(id === 'start_time_picker'){
					end_time_picker.setOptions({
						min: this.value()
					});
				}else if(id === 'end_time_picker'){
					start_time_picker.setOptions({
						max: this.value()
					});
				}
				//var start_time = start_time_picker.value();
				//var end_time = end_time_picker.value();
				var start_time = $("#start_time_picker").val();
				var end_time = $("#end_time_picker").val();
				if(start_time !== null && end_time !== null && start_time !== '' && end_time !== ''){
					/* var endTime_hr = parseInt(kendo.toString(end_time, "HH"));
					var endTime_mm = parseInt(kendo.toString(end_time, "mm"));
					var startTime_hr = parseInt(kendo.toString(start_time, "HH"));
					var startTime_mm = parseInt(kendo.toString(start_time, "mm"));
					var end_min = endTime_hr*60 + endTime_mm;
					var start_min = startTime_hr*60 + startTime_mm;
					var apply_min = 0;
					if(endTime_hr < startTime_hr){
						apply_min = (24*60 - start_min) + (end_min);
					}else{
						apply_min = end_min - start_min;
					} */
					
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
							console.log("야간시간 : "+result.night_min)
							console.log('근무시간: ' + result.work_min + ' 휴게시간: ' + result.rest_min);
							var apply_min = parseInt(result.work_min);
							$("#apply_show_hour").html(parseInt(apply_min/60));
							$("#apply_show_min").html(parseInt(apply_min%60));
							$("#rest_show_min").html(result.rest_min);
							$("[name='apply_min']").val(apply_min);
							$("[name='break_min']").val(result.rest_min);
							$("[name='night_min']").val(result.night_min);
							var day_admit_min = $("#day_admit_min").val();
							if(apply_min > day_admit_min){
								$.applyTimeErrorMsg("신청 시간이 일일 시간외근무 인정시간("+ day_admit_min/60 +"시간)을 초과하였습니다.");
								$("#applyBtn").prop('disabled', true);
					    		$("#applyBtn").css("background", "silver");
					    		return;
							}else{
								$("#applyBtn").prop('disabled', false);
								$("#applyBtn").css("background", "#1088e3");
							}
							/*
								주52시간 관련 주간 시간외근무 인정시간 불러오기
							*/
							$.getJSON(_g_contextPath_ + '/subHoliday/getWeekAgreeMin',
									{
										'apply_emp_seq' : $("[name='apply_emp_seq']").val(),
										'apply_start_date' : $("[name='apply_start_date']").val()
									},
									function(json){
										var weekAgreeMinSum = parseInt(json.weekAgreeMin);
										var week_ot_work_min = parseInt($("#week_ot_work_min").val());
										var week_law_work_min = parseInt($("#week_law_work_min").val());
										console.log('weekAgreeMinSum', weekAgreeMinSum, 'week_ot_work_min', week_ot_work_min);
										if((weekAgreeMinSum + apply_min) > week_ot_work_min){
											$.applyTimeErrorMsg("신청 시간이  [최대 초과근로 시간, 주"+ ((week_ot_work_min/* +week_law_work_min */)/60) +"시간]을 초과하였습니다.");
											/* 
												주52시간 관련, 알림메세지만 띄우도록(X)
												-> 초과근무 주 12시간 초과시 신청이 되지 않도록 변경
											*/
											$("#applyBtn").prop('disabled', true);
								    		$("#applyBtn").css("background", "silver");
										}else{
											$("#applyBtn").prop('disabled', false);
											$("#applyBtn").css("background", "#1088e3");
										}
									});
						}
					});
				}else{
					$("#applyBtn").prop('disabled', true);
		    		$("#applyBtn").css("background", "silver");
				}
			}
		});
		$(".time_picker").attr("readonly", true);
		$("#start_time_picker").data("kendoTimePicker").enable(false);
		$("#end_time_picker").data("kendoTimePicker").enable(false);
		
		/*
			시간외근무 신청(subHoliday/overWkReqInsert)
		*/
		$(document).on('submit', "[name='overWkReqFrm']", function(e){
			e.preventDefault();
			var workPlace = $('[name="work_place"]').val();
			var reward_type = $('[name="reward_type"]').val();
			var duty_code = $('[name="apply_duty_code"]').val();
			var work_dscr = $('[name="work_dscr"]').val();
			if(workPlace === ''){
				alert('근무지를 선택해주세요.');
				return;
			}
			if(work_dscr.length < 5){
				alert('업무내용을 5자 이상 입력해주세요.');
				return;
			}
			if(reward_type === ''){
				alert('보상선택을 선택해주세요.');
				return;
			}
			if((duty_code == 'A02' || duty_code == 'A04') && reward_type=='1'){
				alert('팀장 혹은 본부장은 보상휴가만 선택할 수 있습니다.');
				return;
			}
			var formData = new FormData($(this).get(0));
			$.ajax({
				url: _g_contextPath_ + '/subHoliday/overWkReqInsert',
				type: 'post',
				dataType: 'json',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(json){
					if(json.code === 'success'){
						$.getApplyMinMonthSum();
						gridReload();
						alert("신청 성공!");
					}else if(json.code === 'fail'){
						alert("신청 실패");
					}else{
						alert(json.code);
					}
				}
			});
		});
		
		$('#selMonth').kendoDatePicker({
	    	culture : "ko-KR",
		    format : "yyyy-MM",
		    start: "year",
		    depth: "year",
		    value: new Date(),
		});
		
		$("#selMonth").attr("readonly", true);
		
		/*
			해당월 신청자 총연장근무 현황 (subHoliday/getApplyMinMonthSum) 승인(2)된 항목들만 합산하여 조회
		*/
		$.getApplyMinMonthSum = function(){
			$.getJSON(_g_contextPath_ + '/subHoliday/getApplyMinMonthSum',
					{'apply_emp_seq': "${empInfo.empSeq}",'month':$("#selMonth").val().replace(/-/gi , '')},
					function(json){
						var apply_min = parseInt(json.apply_min_sum);
						var occur_min = parseInt(json.occur_min_sum);
						var agree_min = parseInt(json.agree_min_sum);
						$("#applyHour").html(parseInt(apply_min/60) + '시간 ' + apply_min%60 + '분');
						$("#occurHour").html(parseInt(occur_min/60) + '시간 ' + occur_min%60 + '분');
						$("#agreeHour").html(parseInt(agree_min/60) + '시간 ' + agree_min%60 + '분');
					});
		}
		$.getApplyMinMonthSum();
		
		/*
			해당월 연장근무 신청내역(subHoliday/gridOverWkMonthList)
		*/
		
		/* 데이터 없을시 그리드 처리 함수 */
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
			var grid = $("#gridOverWkMonthList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridOverWkMonthList',/* Mapping1 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.apply_emp_seq = "${empInfo.empSeq}";
							data.group_code = "OVERWK_TYPE";
							data.code = "01";
							data.month = $("#selMonth").val().replace(/-/gi , '');
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
				height: 218,/* 436*/
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
					}
				},{
					field: "work_place",
					title: "근무지",
					template : function(row) {
						var key = row.work_place;
		            	switch(key){
		            	case 'indoor': return "<span style='color:black'>근무지 내</span>"; break;
		            	case 'outdoor': return "<span style='color:black'>근무지 외</span>"; break;
		            	default : return "<span></span>"; break; 
		            	}
					}
				},{
					field: "str_to_date",
					title: "신청일자"
				},{
					field: "weekday",
					title: "요일"
				},{
					field: "work_type",
					title: "근무유형",
					template: function(row){
						if(row.work_type === undefined || row.work_type === null){
							return '기본';
						}else{
							return row.work_type;
						}
					}
				},{
					field: "apply_start_time",
					title: "신청시작시간"
				},{
					field: "apply_end_time",
					title: "신청종료시간"
				}/* ,{
					field: "leave_dt",
					title: "퇴근시간"
				},{
					field: "occur_min_sum",
					title: "발생시간",
					template: "#= parseInt(occur_min_sum/60) # 시간 #= occur_min_sum%60 #분"
				} ,{
					field: "agree_min_sum",
					title: "인정시간",
					template: "#= parseInt(agree_min_sum/60) # 시간 #= agree_min_sum%60 #분"
				},*/,
				{
					field: "apply_min",
					title: "신청시간",
					template: function(row){
						return row.apply_min/60 + '시간';
					}
				},{
					field: "break_min",
					title: "휴게시간",
					template: function(row){
						return row.break_min === undefined ? '' : row.break_min + '분';
					}
				},{
					field: "remark",
					title: "상태/반려사유"
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
			        			return '<input type="button" class="text_red fileUpLoad" value="보고서등록">';
			        		}else{
			        			return '<input type="button" class="fileDownLoad text_blue" value="초과근무보고서">'; 
			        		}
		        		}else{
		        			return '';
		        		}
		        	}
		        },{
		        	title: "신청취소",
		        	template: function(row){
		        		var html = '';
		        		if(row.approval_status === '1'){
		        			html = "<input type='button' class='fileDownLoad text_red' onclick='otApplyCancel(this);' value='신청취소'>"
		        		}
		        		return html;
		        	}
		        }],
				change: function(e){
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
				
		mainGrid();
		
		$('#inOutType').kendoDropDownList({});
		$('#reward_type').kendoDropDownList({});
		/*
			휴일근무 - 보고서 등록 팝업(#fileUploadPop) 
		*/
		var myWindow3 = $("#fileUploadPop");
		$(document).off('click').on('click', '[value="보고서등록"]', function(){
			var row = $("#gridOverWkMonthList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			myWindow3.data("kendoWindow").open();
			$(document).off('submit').on('submit', "[name='fileUploadFrm']", function(e){
				e.preventDefault();
				var formData = new FormData($(this).get(0));
				formData.append('apply_start_date', json.apply_start_date);
				formData.append('apply_emp_name', json.apply_emp_name);
				formData.append('target_table_name', 'after_action_report_id');
				formData.append('target_id', json.ot_work_apply_id);
				formData.append('ot_work_apply_id', json.ot_work_apply_id);
				formData.append('update_emp_seq', "${empInfo.empSeq}");
				//formData.append('approval_status', '5');/* [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기] */
				//formData.append('approval_status', '1');/* 한국문학번역원: 초과근무보고서 올리기 전에 승인절차 진행하고, 초과근무보고서는 사후에 볼 수 있도록 */
				//formData.append('remark', '초과근무보고서업로드');
				$.ajax({
					url: _g_contextPath_ + '/subHoliday/holiWkApprovalUpdate',
					type: 'post',
					dataType: 'json',
					data: formData,
					contentType: false,
					processData: false,
					success: function(json){
						if(json.code === 'success'){
							gridReload();
							myWindow3.data("kendoWindow").close();
							alert("서버 저장 성공!!");
							//document.fileUploadFrm.reset(); 나중에 사용가능한지 확인 multipart reset
							//location.reload(); //$(document).off('submit').on('submit', 으로 해결
						}else{
							alert("서버 저장 실패..");
						}
					}
				})
			});
		}); 
		myWindow3.kendoWindow({
			width: "620px",
			title: "초과근무보고서",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				$("[name='file']").val('');
			}
		}).data("kendoWindow").center();
	
		/*
			휴일근무 - 보고서 등록 파일업로드
		*/
		$(".file_input_button").on("click", function(){
			$(this).next().click();
		});
		$(document).on('change', "[name='file']", function(){
			var index = $(this).val().lastIndexOf('\\') + 1;
			var valLength = $(this).val().length;
			var row = $(this).closest('tr');
			var fileNm = $(this).val().substr(index, valLength);
			row.find('#fileID1').val(fileNm).css({'color':'#0033FF'});
		});
		
		/*
			보고서 양식 다운로드 
		*/
		$("#formDown").on('click', function(e){
			e.preventDefault();
			var downWin = window.open('','_self');
			downWin.location.href = 'https://gw.ltikorea.or.kr/gw/cmm/file/fileDownloadProc.do?fileId=3607&fileSn=&moduleTp=board&pathSeq=500';
		});

		/*
			휴일근무 - 보고서 다운로드 팝업(#fileDownloadPop)
		*/
		var myWindow4 = $("#fileDownloadPop");
		$(document).on('click', "[value='초과근무보고서']", function(){
			$("#report_name").html($(this).val());
			var row = $("#gridOverWkMonthList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			var target_table_name = '';
			if($(this).val() === '근무계획서'){
				target_table_name = "work_plan_report_id";
			}else if($(this).val() === '초과근무보고서'){
				target_table_name = "after_action_report_id";
			}
			myWindow4.data("kendoWindow").open();
			$.getJSON(_g_contextPath_ + '/subHoliday/getFileInfo',
					{'target_table_name': target_table_name, 'target_id': json.ot_work_apply_id},
					function(data){
						$("#fileDownloadDiv").empty();
						var real_file_name = data.real_file_name,
							file_extension = data.file_extension
							attach_file_id = data.attach_file_id;
						html = document.querySelector("#fileDownloadTemplate").innerHTML;
						var resultHTML = html.replace("{real_file_name}", real_file_name)
											 .replace("{file_extension}", file_extension)
											 .replace("{attach_file_id}", attach_file_id);
						$("#fileDownloadDiv").append(resultHTML);
					});
		});
		
		myWindow4.kendoWindow({
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
		
		/*
			휴일근무 - 초과근무보고서 파일 다운로드
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
	
function otApplyCancel(e) {
	
	var result = confirm('신청 취소하시겠습니까?');
	
	if (!result) {return};
	
	var row = $(e).closest('tr');
	var grid = $('#gridOverWkMonthList').data("kendoGrid");
	var item = grid.dataItem(row);
	var data = {
			ot_work_apply_id : item.ot_work_apply_id
	}
	
	$.ajax({
		url: _g_contextPath_+"/subHoliday/otApplyCancel",
		dataType : 'json',
		data : data,
		async : false,
		type : 'POST',
		success: function(result){
			$("#gridOverWkMonthList").data('kendoGrid').dataSource.read();
		
		}
	});
	
}
</script>
<!-- 일 시간외근무 인정시간 불러오기 -->
<input type="hidden" id="day_admit_min" value="${master.day_admit_min }">
<input type="hidden" id="week_ot_work_min" value="${master.week_ot_work_min }">
<input type="hidden" id="week_law_work_min" value="${master.week_law_work_min }">

<!-- 특정 반일제 근무유형의 경우 apply_start_time 30분 이후부터 할 수 있도록 -->
<input type="hidden" id="isHalf">

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>시간외근무 신청</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap">
	
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">시간외근무 신청</p>
			</div>
		</div>
		
		<div class="top_box">
			<form method="post" name="overWkReqFrm" 
			action="${pageContext.request.contextPath }/subHoliday/overWkReqInsert">
			<input type="hidden" name="create_emp_seq" value="${empInfo.empSeq }">
			<input type="hidden" name="ot_type_code_id" value="${typeCode }">
				<dl>
					<dt style="width:80px;">
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
						신청구분
					</dt>
					<dd style="line-height:25px;">
						<span style="font-weight: bold;">연장근무<!-- ${workDn.code_kr } --></span>
					</dd>
				</dl>
				<dl class="next2">
					<dt style="width:80px;">
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
						신청자
					</dt>
					<dd>
						<input type="text" value="${empInfo.orgnztNm } ${empInfo.empName} ${empInfo.classNm}" 
						id="applyEmpName" style="width:160px;" disabled="disabled">
						<input type="hidden" name="apply_emp_seq" value="${empInfo.empSeq }">
						<input type="hidden" name="apply_dept_name" value="${empInfo.orgnztNm }">
						<input type="hidden" name="apply_position" value="${empInfo.positionNm }">
						<input type="hidden" name="apply_duty" value="${empInfo.classNm }">
						<input type="hidden" name="apply_duty_code" value="${empInfo.classCode }">
						<input type="button" id="empListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
					</dd>
					<div class="col-6">
						<dt style="width:80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
							승인권자
						</dt>
						<dd>
							<input type="text" value="${getHeader.nameDuty }" 
							id="headerName" style="width:160px;" disabled="disabled">
							<input type="hidden" name="approval_emp_seq" value="${getHeader.emp_seq }">
							<input type="hidden" name="approval_emp_name" value="${getHeader.emp_name }">
							<input type="button" id="headerListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
						</dd>
						<dt class="ar" style="width: 60px">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
							근무지
						</dt>
						<dd>
							<select name="work_place" id="inOutType" style="width: 160px" onchange="">
								<option value=""></option>
								<option value="indoor">근무지 내</option>
								<option value="outdoor">근무지 외</option>
							</select>
						</dd>
					</div>
				</dl>
				<dl class="next2">
					<dt style="width:80px;">
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
						신청일자
					</dt>
					<dd>
						<input type="text" value="${nowDate}-${dd}" id="startDt" class="w113 datePickerInput">
						<input type="hidden" name="apply_start_date" value="${nowDateToServer}">
					</dd>
					
					<dt class="ar" style="width:80px;">
						근무시간
					</dt>
					<dd>
						<input type="text" value=""
						id="workTime" style="width: 128px;" disabled="disabled">
						<input type="hidden" name="work_min" value="">
						<input type="hidden" name="work_type_id" value="">
						<input type="hidden" name="work_start_time" value="">
						<input type="hidden" name="work_end_time" value="">
						<input type="hidden" name="work_min" value="">
					</dd>
					<div class="col-6">
						<dt style="width:80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
							신청시간					
						</dt>
						<dd>
							<input type="radio" name="am_pm_type" id="radioAm" value="AM">
							<label for="radioAm">오전</label>
							<input type="radio" name="am_pm_type" id="radioPm" value="PM">
							<label for="radioPm" style="margin-right:10px;">오후</label>
							<input id="start_time_picker" name="apply_start_time" class="time_picker" style="width:120px;">
							&nbsp;~&nbsp;
							<input id="end_time_picker" name="apply_end_time" class="time_picker" style="width:120px;">
							[총&nbsp;<span id="apply_show_hour"></span>시간&nbsp;<span id="apply_show_min"></span>분(휴게시간:&nbsp;<span id="rest_show_min"></span>분)]
							<input type="hidden" name="night_min">
							<input type="hidden" name="apply_min">
							<input type="hidden" name="break_min">
						</dd>
					</div>
				</dl>
				<dl class="next2" id="errorMsg" style="display:none;">
					<dt class="workTimeError" style="width:80px;display:none;">알림</dt>
					<dd style="line-height:25px;">
						<span class="workTimeError" id="workTimeErrorMsg" style="color:red;display:none;"></span>
					</dd>
					<div style="position:relative;left:45%;">
						<dt class="applyTimeError" style="width:80px;display:none;">알림</dt>
						<dd style="line-height:25px;">
							<span class="applyTimeError" id="applyTimeErrorMsg" style="color:red;display:none;"></span>
						</dd>
					</div>
				</dl>
				<dl class="next2">
					<dt style="width:80px;">업무내용</dt>
					<dd>
						<input type="text" name="work_dscr" id="work_dscr" style="width: 595px">
					</dd>
					<dt style="width:80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
							보상선택					
						</dt>
					<dd>
						<select name="reward_type" id="reward_type" style="width: 160px" onchange="">
								<option value=""></option>
								<option id="reward_money" value="1">수당</option>
								<option id="reward_holi" value="2">보상휴가</option>
							</select>
					</dd>
				</dl>
				<dl class="next2">
					<dd style="width: 45%;"></dd>
					<dd>
						<input type="submit" style="margin-bottom: 15px;"
						id="applyBtn" value="신청" disabled="disabled">
					</dd>
				</dl>
				<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
				<input type="hidden" name="ieParsing" value="ie">
			</form>
		</div>
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">연장근무현황</p>
			</div>
		</div>
		
		<div id="midWrap" style="max-width:300px; margin: 0 auto">
			<div class="top_box gray_box">
				<div class="com_ta2">
					<table>
						<tr class="mid-box-bg">
<!-- 							<td>신청시간</td> -->
<!-- 							<td>발생시간</td> -->
							<td>인정시간</td>
						</tr>
						<tr style="background-color: white !important">
<!-- 							<td><span id="applyHour"></span></td> -->
<!-- 							<td><span id="occurHour"></span></td> -->
							<td><span id="agreeHour"></span></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">연장근무 신청내역 <input type="text" id="selMonth" style="width: 100px; text-align: center;" onchange="gridReload();"></p>
			</div>
		</div>
		
		<div class="con_ta2 mt20" id="gridOverWkMonthList"></div><!-- Mapping1 -->
	</div>	
</div>

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
			<input type="button" class="gray_btn" id="empListPopClose" value="닫기">
		</div>
	</div>
</div>

<!-- 승인권자 검색 팝업 -->
<div class="pop_wrap_dir" id="headerListPop" style="width:600px;">
	<div class="pop_head">
		<h1>승인권자리스트</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width:65px;">성명</dt>
				<dd>
					<input type="text" id="header_name" class="grid_reload2" style="width:120px;">
				</dd>
				<dt>부서</dt>
				<dd>
					<input type="text" id="header_dept_name" class="grid_reload2" style="width:180px;">
					<input type="button" id="headerSearchBtn" value="검색">
				</dd>
			</dl>
		</div>
		<div class="com_ta mt15">
			<div id="gridHeaderList"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" id="headerListPopClose" value="닫기">
		</div>
	</div>
</div>

<!-- 보고서 등록 팝업 -->
<div class="pop_wrap_dir" id="fileUploadPop" style="width:620px;">
	<div class="pop_head">
		<h1>파일 첨부</h1>
	</div>
	<form method="post" name="fileUploadFrm" enctype="multipart/form-data"
	action="${pageContext.request.contextPath }/subHoliday/fileUpload">
		<div class="pop_con">
			<div class="com_ta">
				<div id="fileDiv">
					<table>
						<colgroup>
							<col width="180"/>
							<col width=""/>	
						</colgroup>
						<tr id="fileTr">
							<th style="font-weight: bold;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />초과근무보고서</th>
							<td id="fileTd" class="le">
								<input type="text" id="fileID1" class="file_input_textbox clear" readonly="readonly" 
								style="width:200px; text-align: center;" placeholder="파일 선택" /> 
								<input type="button" value="업로드" class="file_input_button ml4 normal_btn2" /> 
								<input type="file" id="fileID" name="file" value="" class="hidden" />
								<input type="button" value="양식다운로드" id="formDown" class="ml4 normal_btn2" />
							</td>
						</tr>
					</table>
				</div>
			</div>	
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="submit" class="blue_btn" id="sendBtn" value="전송" />
			</div>
		</div>
	</form>
</div>


<!-- 보고서 다운로드 팝업 -->
<div class="pop_wrap_dir" id="fileDownloadPop" style="width:400px; display: none;">
	<div class="pop_con">
		<div class="btn_div mt0">
			<div class="left_div">
				<h5 id="report_name"></h5>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
				</div>
			</div>
		</div>
		<div class="com_ta" style="" id="">
			<table id="fileDownloadDiv"></table>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" value="닫기"/>
		</div>
	</div>
</div>

<script id="fileDownloadTemplate" type="text/template">
	<tr>
		<th>첨부파일</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<form name="fileDownFrm" action="<c:url value='/common/fileDown'/>">
					<img src="<c:url value='/Images/ico/ico_clip02.png'/>" alt="attach_file">&nbsp;
					<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF"
				 	id="fileText" class="file_name">{real_file_name}.{file_extension}</a>&nbsp;
					<input type="hidden" name="attach_file_id" value="{attach_file_id}">
				</form>
			</span>
		</td>
	</tr>
</script>