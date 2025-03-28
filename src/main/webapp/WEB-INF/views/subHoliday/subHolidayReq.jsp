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
<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src="<c:url value='/js/common/outProcessUtil_wook.js' /> "></script>

<style type="text/css">

	.table-header {
		background : #F0F6FD;
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
	input[type='submit'] {
		background: #1088e3;
		height: 24px;
		padding: 0 11px;
		color: #fff;
		border: none;
		font-weight: bold;
		border-radius: 0px;
		cursor: pointer;
	}
	input[type='submit'][disabled='disabled'] {
		background: silver;
	}
</style>

<script type="text/javascript">
	$(function(){
		//console.log("${empInfo}");
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
		
		/*
			조회기간 - 년/월 단위 설정(kendoDataPicker)
		*/
		$("#startDt1").data("kendoDatePicker").setOptions({
			format: "yyyy-MM",
			depth: "year",
			start: "year"
		});
		$("#endDt1").data("kendoDatePicker").setOptions({
			format: "yyyy-MM",
			depth: "year",
			start: "year"
		});

		/*
			대체휴무 신청 - 신청자 검색 팝업(#empListPop)
		*/
		var myWindow = $("#empListPop"),
			undo = $(".empListPopBtn");
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
					//codeGridClick(e)
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
				}); 
			}
			$(document).on('click', ".emp_select", function(){
				var row = $("#gridEmpList").data("kendoGrid").dataItem($(this).closest("tr"));
				$(".applyEmpName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
				$("[name='use_emp_seq']").val(row.emp_seq);
				$("[name='use_dept_name']").val(row.dept_name);
				$("[name='use_position']").val(row.position);
				$("[name='use_duty']").val(row.duty);
				myWindow.data("kendoWindow").close();
			});
		}
		
		/*
			대체휴무 신청 - 승인권자 검색 팝업(#headerListPop)
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
		/*/!*
			대체휴무 신청 - 신청 팝업("#subHolidayReqPop")
		*!/
		var myWindow3 = $("#subHolidayReqPop"),
			undo3 = $("#subHolidayReqPopBtn");
		undo3.click(function(){
			var ch = $('.checkbox:checked');
			if (ch.length < 1) {
				alert('보상휴가 발생현황 목록을 체크해주세요');
				return;
			} else {
				var data = {};
				var step = true;
				var restMin_sum = 0;
				var selected_date = ''
				var select_result_id = '';
				$.each(ch, function(i,v){
					var index = i;
					var tem = {}

					tem['ot_work_result_id'] = $(v).attr("id").substring(6);
					select_result_id += tem['ot_work_result_id']+'/';
					tem['rest_min'] = $(v).attr("name").split('/')[0];
					restMin_sum += (tem['rest_min']-0);
					selected_date += $(v).attr("name").split('/')[1].substring(0,4) + '.'+$(v).attr("name").split('/')[1].substring(4,6)+'.'+$(v).attr("name").split('/')[1].substring(6,8)+' ';
					data[index] = tem;
				})
				$('#selected_date').val(selected_date);
				$('#restMin_sum').html(parseInt((restMin_sum/60)) + '시간 ' + restMin_sum%60 + '분');
				$('#restMin_sum').val(restMin_sum);
				$('#select_result_id').val(select_result_id);
				myWindow3.data("kendoWindow").open();
				undo3.fadeOut();
			}
			/!*
				잔여시간 - 시간외근무 + 휴일근무 & disapear_yn != 'Y'
			*!/
			$.getJSON(_g_contextPath_ + '/subHoliday/getOverHoliRestMin',
					{'apply_emp_seq':$("[name='use_emp_seq']").val()},
					function(json){
						var restMin = parseInt(json.holiwk_rest_min_sum)
									+ parseInt(json.overwk_rest_min_sum);
						var allMin = parseInt(json.holiwk_agree_min_sum)
									+ parseInt(json.overwk_agree_min_sum);
						$("#restMin_hide").val(restMin);
						$("#allMin_hide").val(allMin);
						$("#restMin").html(parseInt((restMin/60)) + '시간 ' + restMin%60 + '분');
						$("#overHoliRestMin").val(restMin);
						$("#useMin_hide").val((allMin-0)-(restMin-0));
					});
		});
		myWindow3.kendoWindow({
			width: "1000px",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				//document.subHolidayReqFrm.reset();
				$("#applyTypeTemplate").empty();
				comboBox.value('');
				$("#applyBtn").prop('disabled', true);
				$("#applyBtn").css("background", "silver");
				undo3.fadeIn();
			}
		}).data("kendoWindow").center();

		/!*
			신청구분 - KendoComboBox(#applyType)
		*!/
		var work_type_select = '';
		if('${workType.work_type_code}'=='632'){
			work_type_select = [{applyType: 'early', applyType_kr: '2시간(조퇴)'}, {applyType: 'hour', applyType_kr: '4시간(반차)'}, {applyType: 'day', applyType_kr: '8시간(연차)'}];
		}else if('${workType.work_type_code}'=='633'){
			work_type_select = [{applyType: 'early', applyType_kr: '2시간(반차)'}, {applyType: 'day', applyType_kr: '4시간(연차)'}];
		}
		var comboBox = $("#applyType").kendoComboBox({
			dataSource: work_type_select,
			dataTextField: 'applyType_kr',
			dataValueField: 'applyType',
			change: function(e){
				var rows = comboBox.select();
				var record = comboBox.dataItem(rows);
				$("#applyBtn").prop('disabled', true);
				$("#applyBtn").css("background", "silver");
				if(record.applyType === 'hour'){
					$("#applyTypeTemplate").empty();
					html = document.querySelector("#applyTypeHourTemplate").innerHTML;
					$("#applyTypeTemplate").append(html);
				}else if(record.applyType === 'day'){
					$("#applyTypeTemplate").empty();
					html = document.querySelector("#applyTypeDayTemplate").innerHTML;
					$("#applyTypeTemplate").append(html);
				}else{
					$("#applyTypeTemplate").empty();
					html = document.querySelector("#applyTypeHourTemplate").innerHTML;
					$("#applyTypeTemplate").append(html);
				}
				var end_date = null;
		    	var start_date = null;
				$('.datePickerInput_dynamic').kendoDatePicker({
		        	culture : "ko-KR",
				    format : "yyyy-MM-dd",
				    change: function(){
				    	var picker = this;
				    	$.getJSON(_g_contextPath_ + '/subHoliday/getWeekHoliday',
								{'work_date': kendo.toString(picker.value(), 'yyyyMMdd')},
								function(data){
									var week = data.week;
									var holiday = data.holiday;
									if(holiday >= 1){
										alert("휴일에 보상휴가를 신청할 수 없습니다.");
										picker.value('');
									}else if(week >= 5){
										alert("휴일에 보상휴가를 신청할 수 없습니다.");
										picker.value('');
									}
								});
				    	var id = this.wrapper.find("input").attr("id");
				    	var type = this.wrapper.find("input").attr("data-type");
				    	var start_date_picker = $("#startDt").data("kendoDatePicker");
				    	var end_date_picker = $("#endDt").data("kendoDatePicker");
				    	if(id === 'startDt' && type === 'day'){
				    		end_date_picker.setOptions({
				    			min: this.value()
				    		});
				    		start_date = start_date_picker.value();
				    	}else if(id === 'endDt'){
				    		start_date_picker.setOptions({
				    			max: this.value()
				    		});
				    		end_date = end_date_picker.value();
				    	}
				    	if(start_date !== null && end_date !== null){
				    		var diff = end_date - start_date; //return millisecond
				    		var currDay = 24 * 60 * 60 * 1000;
				    		var currMonth = currDay * 30;
				    		var currYear = currMonth * 12;
				    		var diffDays = (parseInt(diff/currDay) + 1);
				    		var apply_start_date = kendo.toString(start_date, 'yyyyMMdd');
				    		var apply_end_date = kendo.toString(end_date, 'yyyyMMdd');
				    		$.getJSON(_g_contextPath_ + '/subHoliday/getWeekendHolidayCnt',
				    				{'apply_start_date': apply_start_date, 'apply_end_date': apply_end_date},
				    				function(json){
				    					diffDays -= json.cnt;
				    					var apply_min = 0;
				    					if(record.applyType_kr=='8시간(연차)'){
				    						apply_min = diffDays * 8 * 60;
				    					}else if(record.applyType_kr=='4시간(연차)'){
				    						apply_min = diffDays * 4 * 60;
				    					}
				    					//var rest_min = $("#overHoliRestMin").val();
				    					var rest_min = $("#restMin_sum").val();
				    					if(apply_min > rest_min){
				    						//alert("잔여시간을 초과하였습니다.");
				    						alert("선택된 시간을 초과하였습니다.");
				    						//document.subHolidayReqFrm.reset();
				    						start_date_picker.value("");
				    						end_date_picker.value("");
				    				    	$("#apply_show_hour").html("");
				    						$("[name='use_min']").val("");
				    						return;
				    					}
							    		$("#apply_show_hour").html(apply_min/60);
							    		$("[name='use_min']").val(apply_min);
							    		$("#applyBtn").prop('disabled', false);
										$("#applyBtn").css("background", "#1088e3");
				    				});
				    	}else{
				    		$("#applyBtn").prop('disabled', true);
				    		$("#applyBtn").css("background", "silver");
				    	}
				    }
				});
		        $(".datePickerInput_dynamic").attr("readonly", true);

		        dateSetUp(record.applyType);

		        $(".time_picker").kendoTimePicker({
					culture: "kr-KR",
					format: "HH:mm",
					interval: 60,
					min : "08:00",
					max : "19:00",
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
						var start_time = start_time_picker.value();
						var end_time = end_time_picker.value();
						if(start_time !== null && end_time !== null){
							var endTime_hr = parseInt(kendo.toString(end_time, "HH"));
							var endTime_mm = parseInt(kendo.toString(end_time, "mm"));
							var end_min = endTime_hr*60 + endTime_mm;
							var startTime_hr = parseInt(kendo.toString(start_time, "HH"));
							var startTime_mm = parseInt(kendo.toString(start_time, "mm"));
							var start_min = startTime_hr*60 + startTime_mm;
							var apply_min = end_min - start_min;
							if(startTime_hr <= 12 && endTime_hr >= 13){
								apply_min -= 60;
							}
							//var rest_min = $("#overHoliRestMin").val();
							var rest_min = $("#restMin_sum").val();
	    					if(apply_min > rest_min){
	    						//alert("잔여시간을 초과하였습니다.");
	    						alert("선택된 시간을 초과하였습니다.");
	    						//document.subHolidayReqFrm.reset();
		    					$("#start_time_picker").data("kendoTimePicker").value("");
		    				    $("#end_time_picker").data("kendoTimePicker").value("");
		    				    $("#apply_show_hour").html("");
		    					$("#apply_show_min").html("");
		    					$("[name='use_min']").val("");
		    					$("#applyBtn").prop('disabled', true);
						    	$("#applyBtn").css("background", "silver");
	    						return;
	    					}
	    					if(record.applyType === 'hour'){
	    						if(apply_min != 240){
		    						//alert("잔여시간을 초과하였습니다.");
		    						alert("반차는 4시간만 신청할 수 있습니다.");
		    						//document.subHolidayReqFrm.reset();
			    					$("#start_time_picker").data("kendoTimePicker").value("");
			    				    $("#end_time_picker").data("kendoTimePicker").value("");
			    				    $("#apply_show_hour").html("");
			    					$("#apply_show_min").html("");
			    					$("[name='use_min']").val("");
			    					$("#applyBtn").prop('disabled', true);
							    	$("#applyBtn").css("background", "silver");
		    						return;
	    						}
	    					}
	    					if(record.applyType === 'early'){
	    						if(apply_min != 120){
		    						//alert("잔여시간을 초과하였습니다.");
		    						alert("조퇴는 2시간만 신청할 수 있습니다.");
		    						//document.subHolidayReqFrm.reset();
			    					$("#start_time_picker").data("kendoTimePicker").value("");
			    				    $("#end_time_picker").data("kendoTimePicker").value("");
			    				    $("#apply_show_hour").html("");
			    					$("#apply_show_min").html("");
			    					$("[name='use_min']").val("");
			    					$("#applyBtn").prop('disabled', true);
							    	$("#applyBtn").css("background", "silver");
		    						return;
	    						}
	    					}
							$("#apply_show_hour").html(parseInt(apply_min/60));
							$("#apply_show_min").html(parseInt(apply_min%60));
							//$('#useMin_hide').val(($('#useMin_hide').val()-0)+(apply_min-0));
							//$('#restMin_hide').val(($('#restMin_hide').val()-0)-(apply_min-0));
							$("[name='use_min']").val(apply_min);
							var startDt = $("#startDt").data("kendoDatePicker").value();
							if(startDt !== null){
								$("#applyBtn").prop('disabled', false);
								$("#applyBtn").css("background", "#1088e3");
							}
						}else{
							$("#applyBtn").prop('disabled', true);
				    		$("#applyBtn").css("background", "silver");
						}
					}
				});
			}
		}).data("kendoComboBox");

		/!*
			신청일자 - kendoDatePicker(#startDt, #endDt)
		*!/
		var dateSetUp = function(applyType){
			if(applyType === 'hour' || applyType === 'early'){
				$("#startDt").data("kendoDatePicker").setOptions({
					//min: "${nowDate}-${dd}" //사후신청가능(min값이 없으면 사후가능)
					//min: "${nowDate}-${dd}" //사후신청불가
				});
				$("#startDt").change(function(){
					var strArray = this.value.split('-');
					var str='';
					for(var i in strArray){
						str += strArray[i];
					}
			    	$("[name='apply_start_date']").val(str);
			    	$("#start_time_picker").data("kendoTimePicker").value("");
			    	$("#end_time_picker").data("kendoTimePicker").value("");
			    	$("#apply_show_hour").html("");
					$("#apply_show_min").html("");
					$("[name='use_min']").val("");
				});
			}else if(applyType === 'day'){
				$("#startDt").data("kendoDatePicker").setOptions({
					//min: "${nowDate}-${dd}" //사후신청가능(min값이 없으면 사후가능)
					//min: "${nowDate}-${dd}" //사후신청불가
				});
				$("#startDt").change(function(){
					var strArray = this.value.split('-');
					var str='';
					for(var i in strArray){
						str += strArray[i];
					}
			    	$("[name='apply_start_date']").val(str);
				});
				$("#endDt").data("kendoDatePicker").setOptions({
					//min: "${nowDate}-${dd}" //사후신청가능(min값이 없으면 사후가능)
					//min: "${nowDate}-${dd}" //사후신청불가
				});
				$("#endDt").change(function(){
					var strArray = this.value.split('-');
					var str='';
					for(var i in strArray){
						str += strArray[i];
					}
			    	$("[name='apply_end_date']").val(str);
				});
			}
		}*/
		/*
    대체휴무 신청 - 신청 팝업("#subHolidayReqPop")
*/
		var myWindow3 = $("#subHolidayReqPop"),
				undo3 = $("#subHolidayReqPopBtn");

		undo3.click(function() {
			var ch = $('.checkbox:checked');
			if (ch.length < 1) {
				alert('보상휴가 발생현황 목록을 체크해주세요');
				return;
			} else {
				var data = {};
				var restMin_sum = 0;
				var selected_date = '';
				var select_result_id = '';
				$.each(ch, function(i, v) {
					var index = i;
					var tem = {};
					tem['ot_work_result_id'] = $(v).attr("id").substring(6);
					select_result_id += tem['ot_work_result_id'] + '/';
					tem['rest_min'] = $(v).attr("name").split('/')[0];
					restMin_sum += (tem['rest_min'] - 0);
					selected_date += $(v).attr("name").split('/')[1].substring(0, 4) + '.' + $(v).attr("name").split('/')[1].substring(4, 6) + '.' + $(v).attr("name").split('/')[1].substring(6, 8) + ' ';
					data[index] = tem;
				});
				$('#selected_date').val(selected_date);
				$('#restMin_sum').html(parseInt((restMin_sum / 60)) + '시간 ' + restMin_sum % 60 + '분');
				$('#restMin_sum').val(restMin_sum);
				$('#select_result_id').val(select_result_id);

				// 시간 선택 템플릿 추가
				$("#applyTypeTemplate").empty();
				var html = document.querySelector("#applyTypeHourTemplate").innerHTML;
				$("#applyTypeTemplate").append(html);

				// DatePicker 초기화
				initializeDatePicker();

				// TimePicker 초기화
				initializeTimePicker();

				myWindow3.data("kendoWindow").open();
				undo3.fadeOut();
			}

			// 잔여시간 조회
			$.getJSON(_g_contextPath_ + '/subHoliday/getOverHoliRestMin', {
				'apply_emp_seq': $("[name='use_emp_seq']").val()
			}, function(json) {
				var restMin = parseInt(json.holiwk_rest_min_sum) + parseInt(json.overwk_rest_min_sum);
				var allMin = parseInt(json.holiwk_agree_min_sum) + parseInt(json.overwk_agree_min_sum);
				$("#restMin_hide").val(restMin);
				$("#allMin_hide").val(allMin);
				$("#restMin").html(parseInt((restMin / 60)) + '시간 ' + restMin % 60 + '분');
				$("#overHoliRestMin").val(restMin);
				$("#useMin_hide").val((allMin - 0) - (restMin - 0));
			});
		});

		myWindow3.kendoWindow({
			width: "1000px",
			visible: false,
			modal: true,
			actions: ["Close"],
			close: function() {
				$("#applyTypeTemplate").empty();
				$("#applyBtn").prop('disabled', true);
				$("#applyBtn").css("background", "silver");
				undo3.fadeIn();
			}
		}).data("kendoWindow").center();

		function initializeDatePicker() {
			$('.datePickerInput_dynamic').kendoDatePicker({
				culture: "ko-KR",
				format: "yyyy-MM-dd",
				change: function() {
					var picker = this;
					var selectedDate = kendo.toString(picker.value(), 'yyyyMMdd');

					// 휴일 체크
					$.getJSON(_g_contextPath_ + '/subHoliday/getWeekHoliday', {
						'work_date': selectedDate
					}, function(data) {
						var week = data.week;
						var holiday = data.holiday;
						if (holiday >= 1 || week >= 5) {
							alert("휴일에 보상휴가를 신청할 수 없습니다.");
							picker.value('');
							return;
						}
					});

					// 선택된 날짜 hidden input에 설정
					if (picker.value()) {
						$("[name='apply_start_date']").val(selectedDate);

						// TimePicker 초기화
						resetTimePickers();
					}
				}
			});

			// DatePicker를 읽기 전용으로 설정
			$(".datePickerInput_dynamic").attr("readonly", true);
		}

		function initializeTimePicker() {
			$(".time_picker").kendoTimePicker({
				culture: "kr-KR",
				format: "HH:mm",
				interval: 30,
				min: "08:00",
				max: "19:00",
				change: function() {
					var start_time_picker = $("#start_time_picker_0").data("kendoTimePicker");
					var end_time_picker = $("#end_time_picker_0").data("kendoTimePicker");

					calculateTime(start_time_picker, end_time_picker);
				}
			});
		}

		function calculateTime(start_time_picker, end_time_picker) {
			var start_time = start_time_picker.value();
			var end_time = end_time_picker.value();

			if (start_time && end_time) {
				var endTime_hr = parseInt(kendo.toString(end_time, "HH"));
				var endTime_mm = parseInt(kendo.toString(end_time, "mm"));
				var end_min = endTime_hr * 60 + endTime_mm;
				var startTime_hr = parseInt(kendo.toString(start_time, "HH"));
				var startTime_mm = parseInt(kendo.toString(start_time, "mm"));
				var start_min = startTime_hr * 60 + startTime_mm;
				var apply_min = end_min - start_min;

				if (startTime_hr <= 12 && endTime_hr >= 13) {
					apply_min -= 60; // 점심시간 제외
				}

				var rest_min = $("#restMin_sum").val();
				if (apply_min > rest_min) {
					alert("선택된 시간을 초과하였습니다.");
					resetTimePickers();
					return;
				}

				updateTimeDisplay(apply_min);
			}
		}

		function addCalculateTime(start_time_picker, end_time_picker, idx) {
			var start_time = start_time_picker.value(); console.log("start_time_picker", start_time)
			var end_time = end_time_picker.value(); console.log("end_time_picker", end_time)
			var rest_min = $("#restMin_sum").val();
			var timeFlag = false;

			if (start_time && end_time) {
				var endTime_hr = parseInt(kendo.toString(end_time, "HH"));
				var endTime_mm = parseInt(kendo.toString(end_time, "mm"));
				var end_min = endTime_hr * 60 + endTime_mm;
				var startTime_hr = parseInt(kendo.toString(start_time, "HH"));
				var startTime_mm = parseInt(kendo.toString(start_time, "mm"));
				var start_min = startTime_hr * 60 + startTime_mm;
				var apply_min = end_min - start_min;

				if (startTime_hr <= 12 && endTime_hr >= 13) {
					apply_min -= 60; // 점심시간 제외
				}

				addUpdateTimeDisplay(apply_min, idx);
			}

			var apply_min_sum = 0;
			$.each($('#applyTypeTemplate dl'), function(i, v) {
				var start_time_l = $(v).find("input[name='apply_start_time']").val();
				var end_time_l = $(v).find("input[name='apply_end_time']").val();

				if (start_time_l && end_time_l) {
					var endTime_hr = parseInt(kendo.toString(end_time_l).split(":")[0]);
					var endTime_mm = parseInt(kendo.toString(end_time_l).split(":")[1]);
					var end_min = endTime_hr * 60 + endTime_mm;
					var startTime_hr = parseInt(kendo.toString(start_time_l).split(":")[0]);
					var startTime_mm = parseInt(kendo.toString(start_time_l).split(":")[1]);
					var start_min = startTime_hr * 60 + startTime_mm;
					apply_min_sum += (end_min - start_min);

					if (startTime_hr <= 12 && endTime_hr >= 13) {
						apply_min_sum -= 60; // 점심시간 제외
					}

					if (apply_min_sum > rest_min) {
						timeFlag = true;
					}
				}
			});

			if (timeFlag) {
				alert("선택된 시간을 초과하였습니다.");
				addResetTimePickers(idx);
				return;
			}
		}

		function resetTimePickers() {
			$("#start_time_picker_0").data("kendoTimePicker").value("");
			$("#end_time_picker_0").data("kendoTimePicker").value("");
			$("#apply_show_hour_0").html("");
			$("#apply_show_min_0").html("");
			$("#use_min_0").val("");
			$("#applyBtn").prop('disabled', true);
			$("#applyBtn").css("background", "silver");
		}

		function addResetTimePickers(idx) {
			$("#start_time_picker_" + idx).data("kendoTimePicker").value("");
			$("#end_time_picker_" + idx).data("kendoTimePicker").value("");
			$("#apply_show_hour_" + idx).html("");
			$("#apply_show_min_" + idx).html("");
			$("#use_min_" + idx).val("");
			$("#applyBtn").prop('disabled', true);
			$("#applyBtn").css("background", "silver");
		}

		function updateTimeDisplay(apply_min) {
			$("#apply_show_hour_0").html(parseInt(apply_min / 60));
			$("#apply_show_min_0").html(apply_min % 60);
			$("#use_min_0").val(apply_min);

			var startDt = $("#startDt_0").data("kendoDatePicker").value();
			if (startDt !== null) {
				$("#applyBtn").prop('disabled', false);
				$("#applyBtn").css("background", "#1088e3");
			}
		}

		function addUpdateTimeDisplay(apply_min, idx) {
			$("#apply_show_hour_" + idx).html(parseInt(apply_min / 60));
			$("#apply_show_min_" + idx).html(apply_min % 60);
			$("#use_min_" + idx).val(apply_min);

			var startDt = $("#startDt_" + idx).data("kendoDatePicker").value();
			if (startDt !== null) {
				$("#applyBtn").prop('disabled', false);
				$("#applyBtn").css("background", "#1088e3");
			}
		}

		function addInitializeDatePicker(idx) {
			$('#startDt_' + idx).kendoDatePicker({
				culture: "ko-KR",
				format: "yyyy-MM-dd",
				change: function() {
					var picker = this;
					var selectedDate = kendo.toString(picker.value(), 'yyyyMMdd');

					// 휴일 체크
					$.getJSON(_g_contextPath_ + '/subHoliday/getWeekHoliday', {
						'work_date': selectedDate
					}, function(data) {
						var week = data.week;
						var holiday = data.holiday;
						if (holiday >= 1 || week >= 5) {
							alert("휴일에 보상휴가를 신청할 수 없습니다.");
							picker.value('');
							return;
						}
					});

					// 선택된 날짜 hidden input에 설정
					if (picker.value()) {
						$("#apply_start_date_" + idx).val(selectedDate);

						// TimePicker 초기화
						addResetTimePickers(idx);
					}
				}
			});

			// DatePicker를 읽기 전용으로 설정
			$('#startDt_' + idx).attr("readonly", true);
		}

		function addInitializeTimePicker(idx) {
			$("#start_time_picker_" + idx).kendoTimePicker({
				culture: "kr-KR",
				format: "HH:mm",
				interval: 30,
				min: "08:00",
				max: "19:00",
				change: function() {
					var start_time_picker = $("#start_time_picker_" + idx).data("kendoTimePicker");
					var end_time_picker = $("#end_time_picker_" + idx).data("kendoTimePicker");

					addCalculateTime(start_time_picker, end_time_picker, idx);
				}
			});

			$("#end_time_picker_" + idx).kendoTimePicker({
				culture: "kr-KR",
				format: "HH:mm",
				interval: 30,
				min: "08:00",
				max: "19:00",
				change: function() {
					var start_time_picker = $("#start_time_picker_" + idx).data("kendoTimePicker");
					var end_time_picker = $("#end_time_picker_" + idx).data("kendoTimePicker");

					addCalculateTime(start_time_picker, end_time_picker, idx);
				}
			});
		}

		/*
			대체휴무 신청(subHoliday/subHolidayReqInsert)
		*/
		var win = '';
		$(document).on('submit', "[name='subHolidayReqFrm']", function(e){
			// var apply_start_date = $('[name="apply_start_date"]').val();
			// var apply_end_date = $('[name="apply_end_date"]').val();
			// var apply_start_time = $('[name="apply_start_time"]').val();
			// var apply_end_time = $('[name="apply_end_time"]').val();
			// var use_time = ($("[name='use_min']").val()-0);
			// var rest_time = ($("#overHoliRestMin").val()-0) - use_time;
			var replace_day_off_use_id2 = ''
			var appro_key = '';
			e.preventDefault();
			var formData = new FormData($(this).get(0));
			formData.append('create_emp_seq', "${empInfo.empSeq}");

			var itemArr = [];
			var use_time_sum = 0;
			$.each($('#applyTypeTemplate dl'), function(i, v) {

				var data = {
					apply_start_date : $(v).find("input[name='apply_start_date']").val(),
					apply_end_date : $(v).find("input[name='apply_end_date']").val(),
					apply_start_time : $(v).find("input[name='apply_start_time']").val(),
					apply_end_time : $(v).find("input[name='apply_end_time']").val(),
					use_time : ($(v).find("input[name='use_min']").val()-0)
				}

				use_time_sum += data.use_time;

				data.rest_time = ($("#overHoliRestMin").val()-0) - use_time_sum;

				itemArr.push(data);
			});

			formData.append("itemArr", JSON.stringify(itemArr));

			$.ajax({
				url: _g_contextPath_ + '/subHoliday/subHolidayReqInsert',
				type: 'post',
				dataType: 'json',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(json){
					console.log(json)
					if(json.code === 'success'){
						//document.subHolidayReqFrm.reset();
						appro_key = "REHREQ"+json.replace_day_off_use_id;
						myWindow3.data("kendoWindow").close();
						gridReload();
						gridReload2();
						replace_day_off_use_id2 = json.replace_day_off_use_id;
						alert("전자결재를 완료해야 보상휴가 신청이 완료됩니다!");
						appProcess(json.replace_day_off_use_id, itemArr);
						/*var formData2 = new FormData();
						formData2.append('appro_key',json.replace_day_off_use_id)
						formData2.append('update_emp_seq', '${empInfo.empSeq}')
						formData2.append('use_emp_seq', '${empInfo.empSeq}')
						console.log(formData2)*/
						/*alert("전자결재를 완료한 뒤에 확인버튼을 눌러주세요!");
						$.ajax({
							url: _g_contextPath_ + '/subHoliday/subHolidayCompare',
							type: 'POST',
							data: formData2,
							cache: false,
							async: false,
							contentType: false,
							processData: false,
							success: function(json){
								console.log(json)
								if(json.code == 'fail'){
									$.ajax({
										url: _g_contextPath_ + '/subHoliday/subHolidayReqDeactivate',
										type: 'post',
										dataType: 'json',
										data: json,
										async: false,
										success: function(json){
											if(json.code === 'success'){
												gridReload();
												gridReload2();
												console.log(win);
												win.close();
											}else{
												alert("서버 반영 실패..");
											}
										}
									});
								}else{
									gridReload();
									gridReload2();
									console.log('전자결재 신청함')
								}
							},error: function(error){
								console.log("실패실패");
								console.log(error);
							}
						});*/
					}else{
						/*$.ajax({
							url: _g_contextPath_ + '/subHoliday/subHolidayCompare',
							type: 'POST',
							data: formData2,
							cache: false,
							async: false,
							contentType: false,
							processData: false,
							success: function(json){
								console.log(json)
								if(json.code == 'fail'){
									$.ajax({
										url: _g_contextPath_ + '/subHoliday/subHolidayReqDeactivate',
										type: 'post',
										dataType: 'json',
										data: json,
										async: false,
										success: function(json){
											if(json.code === 'success'){
												gridReload();
												gridReload2();
											}else{
												alert("서버 반영 실패..");
											}
										}
									});
								}else{
									gridReload();
									gridReload2();
									console.log('전자결재 신청안함')
								}
							},error: function(error){
								console.log("실패실패");
								console.log(error);
							}
						});*/
						alert("신청 실패");
					}
				}
			});

			/*
			전자결재연동용
		*/
		function appProcess(replace_day_off_use_id, itemArr){
			var params = {};
			params.compSeq = "${empInfo.compSeq}";
			params.empSeq = $("[name='use_emp_seq']").val();
			params.outProcessCode = "REHREQ";
			params.approKey = params.outProcessCode + replace_day_off_use_id;
			params.mod = 'W';
			params.title = '보상휴가신청서';
			params.contentsStr = makeContentsStr(params.approKey, itemArr);

			// console.log("contents", params.contentsStr);
			//params.loginid = "admin"
			win = outProcessLogOn(params);
		}

		/* 여기 서버에 패치하고 되는거 확인해야됨 */
		function makeContentsStr(approKey, itemArr){

			var html = "";
			html += '<TR id="applyTr">';
			html += '	<TD rowspan="' + itemArr.length + '" valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">${empInfo.orgnztNm}</SPAN></P>';
			html += '	</TD>';
			html += '	<TD rowspan="' + itemArr.length + '" colspan="2" valign="middle" style="width:51px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + $('#apply_emp_name').val() + '</SPAN></P>';
			html += '	</TD>';

			var use_time_sum = 0;

			for(var i=0; i<itemArr.length; i++) {

				var apply_start_date = itemArr[i].apply_start_date;
				var apply_end_date = itemArr[i].apply_end_date;
				var apply_start_time = itemArr[i].apply_start_time;
				var apply_end_time = itemArr[i].apply_end_time;

				var apply_start = '';
				var apply_end = '';
				var use_time = (itemArr[i].use_time - 0);
				var use = (use_time - 0) / 480;

				use_time_sum += use_time;

				var hourStr = parseInt(use_time / 60) > 9 ? parseInt(use_time / 60) : '0' + parseInt(use_time / 60);
				var minStr = parseInt(use_time % 60) > 9 ? parseInt(use_time % 60) : '0' + parseInt(use_time % 60);
				var req_time = hourStr + ':' + minStr;

				var select_date = $('#selected_date').val() + '발생 보상휴가 사용';

				if(!apply_end_date) {
					apply_start = apply_start_date.substring(0, 4) + '.' + apply_start_date.substring(4, 6) + '.' + apply_start_date.substring(6, 8) + '<br>' + apply_start_time;
					apply_end = apply_start_date.substring(0, 4) + '.' + apply_start_date.substring(4, 6) + '.' + apply_start_date.substring(6, 8) + '<br>' + apply_end_time;
				}else{
					apply_start = apply_start_date.substring(0, 4) + '.' + apply_start_date.substring(4, 6) + '.' + apply_start_date.substring(6, 8);
					apply_end = apply_end_date.substring(0, 4) + '.' + apply_end_date.substring(4, 6) + '.' + apply_end_date.substring(6, 8);
				}

				html += '	<TD valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">보상휴가</SPAN></P>';
				html += '	</TD>';
				html += '	<TD valign="middle" style="width:84px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + apply_start + '</SPAN></P>';
				html += '	</TD>';
				html += '	<TD colspan="2" valign="middle" style="width:83px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + apply_end + '</SPAN></P>';
				html += '	</TD>';
				html += '	<TD colspan="2" valign="middle" style="width:76px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + use + '</SPAN></P>';
				html += '	</TD>';
				html += '	<TD valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + req_time + '</SPAN></P>';
				html += '	</TD>';
				html += '	<TD valign="middle" style="width:106px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
				html += '		<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">' + select_date + '</SPAN></P>';
				html += '	</TD>';

				if(i != itemArr.length){
					html += '	</TR>';
				}

			}

			html += '</TR>';

			var html2 = document.querySelector('#EDIcontents').innerHTML;

			return html2.replace('{create_date}', "${nowDateToServer}")
					.replace('{apply_position}', '${empInfo.classNm}')
					.replace('{apply_emp_name}', $('#apply_emp_name').val())
					.replace('{remark}', $('#remark').val())
					.replace('{orgnztNm}', '${empInfo.orgnztNm}')
					.replace('{orgnztNm2}', '${empInfo.orgnztNm}')
					.replace('{all}', $('#agree_span_hour').val())		// 총 보상휴가일수
					.replace('{use2}', $('#use_span_hour').val())		// 사용일수
					.replace('{use3}', $('#agree_span_hour').val())
					.replace('{use4}',  (use_time_sum-0)/480)			// 보상휴가차감 = 보상휴가 신청 일수
					.replace('{rest}', $('#rest_span_hour').val())		// 잔여보상휴가
					.replace('{year}', "${nowDateToServer}".substring(0,4))
					.replace('{month}', "${nowDateToServer}".substring(4,6))
					.replace('{day}', "${nowDateToServer}".substring(6,8))
					.replace('{appro_key}', appro_key)
					.replace('{applyTr}', html)
					;
		}
		});
		
		/*
			대체휴무 인정/사용/잔여 현황(jsp model처리: sum)
		*/
		
		/*
			대체휴무 발생현황 (subHoliday/gridSubHolidayOccurList)
		*/
		function gridReload(){
			$("#gridSubHolidayOccurList"/* Mapping1 */).data('kendoGrid').dataSource.read();
		}
		
		function mainGrid(){
			var grid = $("#gridSubHolidayOccurList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayOccurList',/* Mapping1 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.apply_emp_seq = $("[name='use_emp_seq']").val();
							data.startDt = $("[name='startDt']").val();
							data.endDt = $("[name='endDt']").val();
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
				height: 218, /*436*/
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
		       		headerTemplate: "<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",
		         	template: reward_select,
		           	width : 50,
		        },
				{
					field: "str_to_applyDate",
					title: "근무일자"
				},{
					field: "weekday",
					title: "요일",
		            template : function(row){
		            	var key = '';
		            	if ( row.weekday == undefined ) {
		            		key = '대체휴무 데이터 이관';
		            	} else {
		            		key = row.weekday;
		            	}
		            	switch(key){
		            	case '토': return "<span style='color:blue'>"+ key +"</span>"; break;
		            	case '일': return "<span style='color:red'>"+ key +"</span>"; break;
		            	default : return "<span>"+ key +"</span>"; break; 
		            	}
		            }
				},{
					field: "ot_type_code_kr",
					title: "구분"
				},{
					field: "agree_min",
					title: "인정시간",
					template: "#= parseInt(agree_min/60) # 시간 #= agree_min%60 # 분"
				},{
					field: "use_min",
					title: "사용시간",
					template: "#= parseInt(use_min/60) # 시간 #= use_min%60 #분"
				},{
					field: "rest_min",
					title: "잔여시간",
					template: "#= parseInt(rest_min/60) # 시간 #= rest_min%60 # 분"
				},{
					field: "holi_start",
					title: "사용(예정)일",
						template: function (e) {
							let txt = "";
							if(e.holi_group != null) {
								let holiArr = e.holi_group.split(",");
								let useMinArr = e.use_min_group.split(",");
								for(let i = 0; i < holiArr.length; i++){
									txt += holiArr[i] + " (" + parseInt(useMinArr[i]/60) + "시간 " + parseInt(useMinArr[i]%60) + "분" + ")<br/>";
								}
							} else {
								txt = "";
							}

							return txt;
						}
				},{
					field: "str_to_disDate",
					title: "소멸예정일"
				}],
				change: function(e){
					//codeGridClick();
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
				}); 
			}
		}
		function reward_select(row) {
			var id = row.ot_work_result_id;
			var rest_min = row.rest_min;
			var select_date = row.apply_start_date;
			if(rest_min==0){
				return '';
			}else{
				return '<input type="checkbox" id="reward'+id+'" name='+rest_min+'/'+select_date+' class="k-checkbox checkbox"/><label for="reward'+id+'" class="k-checkbox-label"></label>';
			}
		}		
		mainGrid();
		$("#headerCheckbox").change(function(){
			
			var checkedIds = {};
	        if($("#headerCheckbox").is(":checked")){
	        	$(".checkbox").prop("checked", "checked");
	        }else{
		        	$(".checkbox").removeProp("checked");
		    }
	    });
		/*
			대체휴무 신청취소(subHoliday/subHolidayReqDeactivate) 
		*/
		$(document).on('click', '.cancleBtn', function(){
			var row = $("#gridSubHolidayReqList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			json.update_emp_seq = "${empInfo.empSeq}";
 			var result = confirm("신청 취소 하시겠습니까?");
 			if(result){
				$.ajax({
					url: _g_contextPath_ + '/subHoliday/subHolidayReqDeactivate',
					type: 'post',
					dataType: 'json',
					data: json,
					success: function(json){
						if(json.code === 'success'){
							gridReload();
							gridReload2();
							alert("서버 반영 성공!!");
						}else{
							alert("서버 반영 실패..");
						}
					}
				});
			} 
		});
		
		/*
			대체휴무 신청현황(subHoliday/gridSubHolidayReqList)
		*/
		function gridReload2(){
			$("#gridSubHolidayReqList"/* Mapping2 */).data('kendoGrid').dataSource.read();
		}
		$(document).on('submit', "[name='subHolidayReqListFrm']", function(e){ //발생현황도 한꺼번에처리
			e.preventDefault();
			gridReload();
			gridReload2();
		});
		function mainGrid2(){
			var grid = $("#gridSubHolidayReqList"/* Mapping2 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayReqList',/* Mapping2 */
							dataType: 'json',
							type: 'post',
							cache: false,
							contentType: false,
							processData: false
						},
						parameterMap: function(data, operation){
							var formData = new FormData($("[name='subHolidayReqListFrm']").get(0));
							formData.append('take', data.take);
							formData.append('skip', data.skip);
							formData.append('page', data.page);
							formData.append('pageSize', data.pageSize);
							return formData;
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
						case '4': status_kr = '반려'; break;
						}
						return status_kr;
					},
					width: 80
				},{
					field: "date_format_create_date",
					title: "신청일자"
				},{
					field: "str_to_start_date",
					title: "휴무시작일자"
				},{
					field: "str_to_end_date",
					title: "휴무종료일자",
/* 					template: function(row){
						var str_to_end_date = row.str_to_end_date;
						if(str_to_end_date === undefined){
							return row.str_to_start_date;
						}else{
							return str_to_end_date;
						}
					} */
				},{
					field: "weekday",
					title: "요일",
					template : function(row){
		            	var key = row.weekday;
		            	switch(key){
		            	case '토': return "<span style='color:blue'>"+ key +"</span>"; break;
		            	case '일': return "<span style='color:red'>"+ key +"</span>"; break;
		            	default : return "<span>"+ key +"</span>"; break; 
		            	}
		            },
		            width: 50
				},{
					field: "use_dept_name",
					title: "부서"
				},{
					field: "apply_start_time",
					title: "시작시간"
				},{
					field: "apply_end_time",
					title: "종료시간"
				},{
					field: "use_min",
					title: "신청시간",
					template: function(row){
						return row.use_min/60 + '시간';
					}
				},{
					field: "apply_emp_name",
					title: "신청자"
				},{
					field: "use_position",
					title: "직급"
				},{
					field: "use_duty",
					title: "직책"
				},{
					field: "remark",
					title: "상태/반려사유"
				},{
					field: "cancle",
					title: "신청취소",
					template: function(row){
						if(row.approval_status === '1'){
							return "<input type='button' class='cancleBtn' value='신청취소'>";
						}else{
							return "";
						}
					}
				}],				
				change: function(e){
					codeGridClick(e);
				}
			}).data("kendoGrid");
			
			function codeGridClick(){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
				}); 
			}
		}
				
		mainGrid2();

		var ddIndex = 0;
		$(document).on("click", "[name='addApplyDl']", function() {
			ddIndex++;
			var html = "";
			html += '<dl class="next2" id="applyDl_' + ddIndex + '" name="applyDl">';
			html += '<dt style="width:80px;">';
			html += '	<img src="" alt=""/>';
			html += '</dt>';
			html += '<dd>'
			html += '	<input type="text" id="startDt_' + ddIndex + '" data-type="hour" class="w113 datePickerInput_dynamic"/>'
			html += '	<input type="hidden" id="apply_start_date_' + ddIndex + '" name="apply_start_date" class="apply_start_date"/>'
			html += '	<input id="start_time_picker_' + ddIndex + '" name="apply_start_time" class="time_picker apply_start_time" style="width:120px;"/>'
			html += '&nbsp; ~&nbsp;';
			html += '	<input id="end_time_picker_' + ddIndex + '" name="apply_end_time" class="time_picker apply_end_time" style="width:120px;"/>';
			html += '   <input type="button" value="삭제" class="file_input_button ml4 normal_btn2" name="delApplyDl" style="background-color: #f33e51;"/>';
			html += '	(총&nbsp;<span id="apply_show_hour_' + ddIndex + '"></span>시간&nbsp;<span id="apply_show_min_' + ddIndex + '"></span>분) ※ 점심시간';
			html += '	(12:00 ~ 13:00)';
			html += '	<input type="hidden" id="use_min_' + ddIndex + '" name="use_min" class="use_min"/>';
			html += '</dd>';
			html += '</dl>';

			$("#applyTypeTemplate").append(html);

			// DatePicker 초기화
			addInitializeDatePicker(ddIndex);

			// TimePicker 초기화
			addInitializeTimePicker(ddIndex);
		});

		$(document).on("click", "[name='delApplyDl']", function() {
			$(this).closest("dl").remove();
		});

	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>보상휴가 현황</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap">
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">보상휴가 현황</p>
			</div>
		</div>
		<form method="post" name="subHolidayReqListFrm"
		action="${pageContext.request.contextPath }/subHoliday/gridSubHolidayReqList">
			<div class="top_box">
				<dl>
					<dt class="ar" style="width:75px;">부서</dt>
					<dd>
						<input type="text" name="use_dept_name" disabled="disabled" 
						value="${empInfo.orgnztNm }" style="width:160px;"/> 
					</dd>
					<dt class="ar" style="width:75px;">성명</dt>
					<dd>
						<input type="text" class="applyEmpName" disabled="disabled" 
						value="${empInfo.empName }" style="width:160px;"/> 
						<input type="hidden" name="use_emp_seq" value="${empInfo.empSeq }">
						<input type="hidden" name="use_position" value="${empInfo.positionNm }">
						<input type="hidden" name="use_duty" value="${empInfo.classNm }">
						<input type="button" class="empListPopBtn file_input_button ml4 normal_btn2" value="검색">
					</dd>
					<dt class="ar" style="width:80px;">조회기간</dt>
					<dd>
						<input type="text" value="${nowDate }" id="startDt1" name="startDt" class="w113 datePickerInput"/>
						&nbsp;~&nbsp;
						<input type="text" value="" id="endDt1"	name="endDt" class="w113 datePickerInput" />
					</dd>
				</dl>
			</div>
			
			<div class="btn_div">
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="subHolidayReqPopBtn">보상휴가 신청</button>
						<button type="submit" id="searchBtn">조회</button>
					</div>
				</div>
			</div>
			<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
			<input type="hidden" name="ieParsing" value="ie">
		</form>
		<div class="top_box">
			<div class="com_ta2">
				<table>
					<tr class="table-header">
						<td colspan="3"><!-- colspan="6" -->
<%-- 						<span id="limitFrYear">${subHourList.yFrom }</span>년
							<span id="limitFrMonth">${subHourList.mFrom }</span>월&nbsp;~&nbsp; --%>
							<span id="limitToYear">${year }</span>년
							<span id="listToMonth">${mm }</span>월 현재 유효 휴무보상
						</td>
					</tr>
					<tr class="table-header">
						<td >인정시간</td><!-- colspan="2" -->
						<td >사용시간</td><!-- colspan="2" -->
						<td >잔여시간</td><!-- colspan="2" -->
					</tr>
					<!-- <tr class="table-header">
						<td style="width:1/6;">시간외근무</td>
						<td style="width:1/6;">휴일근무</td>
						<td style="width:1/6;">시간외근무</td>
						<td style="width:1/6;">휴일근무</td>
						<td style="width:1/6;">시간외근무</td>
						<td style="width:1/6;">휴일근무</td>
					</tr> -->
					<tr style="background-color: white !important">
					<script>
					$(function(){
						var overwk_agree = "${sum.overwk_agree_min_sum}";
						/* var overwk_agree_span = parseInt(overwk_agree/60) + "시간 " + parseInt(overwk_agree%60) + "분";
						$("#overwk_agree_span").html(overwk_agree_span); */
						
						if("${sum.overwk_agree_min_sum}" == null || "${sum.overwk_agree_min_sum}" == ""){
							overwk_agree = 0;
						}
						// console.log("overWkAgree (시간외근무 인정시간): ", overwk_agree);
						
						var holiwk_agree = "${sum.holiwk_agree_min_sum}";
						
						if("${sum.holiwk_agree_min_sum}" == "" || "${sum.holiwk_agree_min_sum}" == null){
							holiwk_agree = 0;
						}
						// console.log("holiWkAgree (휴일근무 인정시간): ", holiwk_agree);
						
						var agree_hour = parseInt(overwk_agree) + parseInt(holiwk_agree); //숫자로 만들어서 시간구하기.

						var agree_span = parseInt(((overwk_agree-0) + (holiwk_agree-0))/60) + "시간" + 
										 parseInt(((overwk_agree-0) + (holiwk_agree-0))%60) + "분";
						$("#agree_span").html(agree_span);

						var agree_hour_temp = isFiniteDecimal(agree_hour, 480);
						$("#agree_span_hour").val(agree_hour_temp == "2" ? Math.round((agree_hour/480) * 100000) / 100000 : agree_hour/480);
						
						var overwk_use = "${sum.overwk_use_min_sum}";
						
						if("${sum.overwk_use_min_sum}" == null || "${sum.overwk_use_min_sum}" == ""){
							overwk_use = 0;
						}
						// console.log("overWkUse (시간외근무 사용시간): ", overwk_use);
						
						var holiwk_use = "${sum.holiwk_use_min_sum}";
						
						if("${sum.holiwk_use_min_sum}" == null || "${sum.holiwk_use_min_sum}" == ""){
							holiwk_use = 0;
						}
						// console.log("holiWkUse (휴일근무 사용시간): ", holiwk_use);
						
						var use_hour = parseInt(overwk_use) + parseInt(holiwk_use);
						var use_span = parseInt(((overwk_use-0) + (holiwk_use-0))/60) + "시간" + 
									   parseInt(((overwk_use-0) + (holiwk_use-0))%60) + "분";
						$("#use_span").html(use_span);

						var use_hour_temp = isFiniteDecimal(use_hour, 480);
						$("#use_span_hour").val(use_hour_temp == "2" ? Math.round((use_hour/480) * 100000) / 100000 : use_hour/480);
						
						var overwk_rest = "${sum.overwk_rest_min_sum}";
						
						if("${sum.overwk_rest_min_sum}" == null || "${sum.overwk_rest_min_sum}" == ""){
							overwk_rest = 0;
						}
						// console.log("overWkRest (시간외근무 잔여시간): ", overwk_rest);

						var holiwk_rest = "${sum.holiwk_rest_min_sum}";
						
						if("${sum.holiwk_rest_min_sum}" == null || "${sum.holiwk_rest_min_sum}" == ""){
							holiwk_rest = 0;
						}
						// console.log("holiWkRest (휴일근무 잔여시간): ", holiwk_rest);
						
						var rest_hour = parseInt(overwk_rest) + parseInt(holiwk_rest);

						var rest_span = parseInt(((overwk_rest-0) + (holiwk_rest-0))/60) + "시간" + 
										parseInt(((overwk_rest-0) + (holiwk_rest-0))%60) + "분";
						$("#rest_span").html(rest_span);

						var rest_hour_temp = isFiniteDecimal(rest_hour, 480);
						$("#rest_span_hour").val(rest_hour_temp == "2" ? Math.round((rest_hour/480) * 100000) / 100000 : rest_hour/480);

						// 유한소수, 무한소수 판별
						function isFiniteDecimal(a, b) {
							// 두 수의 최대공약수를 구합니다.
							function gcd(x, y) {
								while (y !== 0) {
									let temp = y;
									y = x % y;
									x = temp;
								}
								return x;
							}

							const divisor = gcd(a, b);

							// b를 최대공약수로 나눠 기약분수로 만듭니다.
							b /= divisor;

							// b가 2와 5로 나눠지는지 확인합니다.
							while (b % 2 === 0) b /= 2;
							while (b % 5 === 0) b /= 5;

							// 최종적으로 b가 1이면 유한소수입니다.
							return b === 1 ? 1 : 2;
						}
						
					});
					</script>
						<td>
							<span id="agree_span"></span>
							<span id="agree_span_hour" style = "";></span>
						</td>
						<td>
							<span id="use_span"></span>
							<span id="use_span_hour" style = "";></span>
						</td>
						<td>
							<span id="rest_span"></span>
							<span id="rest_span_hour" style = "";></span>
						</td>
						<!-- <td>
							<span id="overwk_agree_span"></span>
						</td>
						<td>
							<span id="holiwk_agree_span"></span>
						</td>
						<td>
							<span id="overwk_use_span"></span>
						</td>
						<td>
							<span id="holiwk_use_span"></span>
						</td>
						<td>
							<span id="overwk_rest_span"></span>
						</td>
						<td>
							<span id="holiwk_rest_span"></span>
						</td> -->
					</tr>
				</table>
			</div>
		</div>
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">보상휴가 발생현황</p>
			</div>
		</div>
		
		<div class="com_ta2 mt20" id="gridSubHolidayOccurList"></div><!-- Mapping1 -->
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">보상휴가 신청현황</p>
			</div>
		</div>
		
		<div class="con_ta2 mt20" id="gridSubHolidayReqList"></div><!-- Mapping2 -->
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

<!-- 대체휴무 신청 팝업 -->
<div class="pop_wrap_dir" id="subHolidayReqPop" style="width:1000px;">
	<div class="pop_head">
		<h1>보상휴가신청</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<div class="top_box gray_box">
				<form method="post" name="subHolidayReqFrm" 
				action="${pageContext.request.contextPath }/subHoliday/subHolidayReqInsert">
				<input type="hidden" name="approval_status" value="1">
				<input type="hidden" id="overHoliRestMin">
				<input type="hidden" id="select_result_id" name="select_result_id">
				<input type="hidden" id="selected_date" name="selected_date">
				<input type="hidden" id="restMin_hide" name="restMin_hide">
				<input type="hidden" id="useMin_hide" name="useMin_hide">
				<input type="hidden" id="allMin_hide" name="allMin_hide">
					<dl>
						<dt style="width:80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							신청자
						</dt>
						<dd>
							<input type="text" class="applyEmpName" disabled="disabled" 
							value="${empInfo.orgnztNm } ${empInfo.empName} ${empInfo.classNm}" style="width:160px;"/> 
							<input type="hidden" name="use_emp_seq" value="${empInfo.empSeq }" />
							<input type="hidden" name="use_dept_name" value="${empInfo.orgnztNm }" />
							<input type="hidden" name="use_position" value="${empInfo.positionNm }" />
							<input type="hidden" name="use_duty" value="${empInfo.classNm }" />
							<input type="hidden" id = "apply_emp_name" name="apply_emp_name" value="${empInfo.empName }" />
							<input type="button" value="검색" class="empListPopBtn file_input_button ml4 normal_btn2" />
						</dd>
						<dt style="width: 80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							결재권자
						</dt>
						<dd>
							<input type="text" value="${getHeader.nameDuty }" 
							id="headerName" style="width:160px;" disabled="disabled">
							<input type="hidden" name="approval_emp_seq" value="${getHeader.emp_seq }">
							<input type="hidden" name="approval_emp_name" value="${getHeader.emp_name }">
							<input type="button" id="headerListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
						</dd>								
					</dl>
					<dl class="next2" style="">
						<dt style="width:80px;">
							잔여시간
						</dt>
						<dd style="line-height: 25px;">
							<span id="restMin"></span>
						</dd>
					</dl>
					<dl class="next2" style="">
						<dt style="width:80px;">
							선택된시간
						</dt>
						<dd style="line-height: 25px;">
							<span id="restMin_sum"></span>
						</dd>
					</dl>
					<%--<dl class="next2">
						<dt style="width:80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							신청구분
						</dt>
						<dd>
							<input id="applyType" class="select-box">
						</dd>
					</dl>--%>

					<div id="applyTypeTemplate"></div>

					<!-- <dl class="next2">
						<dt style="width:80px;">신청사유</dt>
						<dd><input type="text" name="remark" id="remark" style="width: 800px" />
					</dl> -->
					<dl class="next2">
						<dd style="width: 45%">
						</dd>
						<dd>								
							<input type="submit" style="margin-bottom: 15px;"
							id="applyBtn" value="신청" disabled="disabled">
						</dd>
					</dl>
					<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
					<input type="hidden" name="ieParsing" value="ie">
				</form>
			</div>
		</div>			
	</div>
</div>

<script id="applyTypeHourTemplate" type="text/template">
	<dl class="next2" id="applyDl_0" name="applyDl">
		<dt style="width:80px;">
			<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
			신청일시
		</dt>
		<dd>
			<input type="text" id="startDt_0" data-type="hour" class="w113 datePickerInput_dynamic">
			<input type="hidden" name="apply_start_date" class="apply_start_date">
			<input id="start_time_picker_0" name="apply_start_time" class="time_picker apply_start_time" style="width:120px;">
			&nbsp;~&nbsp;
			<input id="end_time_picker_0" name="apply_end_time" class="time_picker apply_end_time" style="width:120px;">
			<input type="button" value="추가" class="file_input_button ml4 normal_btn2" name="addApplyDl" />
			(총&nbsp;<span id="apply_show_hour_0"></span>시간&nbsp;<span id="apply_show_min_0"></span>분) ※ 점심시간 (12:00 ~ 13:00)
			<input type="hidden" id="use_min_0" name="use_min" class="use_min">
		</dd>
	</dl>
</script>
<script id="applyTypeDayTemplate" type="text/template">
<dl class="next2">
	<dt style="width:80px;">
		<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
		신청일자
	</dt>
	<dd>
		<input type="text" id="startDt" data-type="day" class="w113 datePickerInput_dynamic">
		<input type="hidden" name="apply_start_date">
		&nbsp;~&nbsp;
		<input type="text" id="endDt" class="w113 datePickerInput_dynamic">
		<input type="hidden" name="apply_end_date">
		(총&nbsp;<span id="apply_show_hour"></span>시간) ※ 하루 8시간, 공휴일 제외
		<input type="hidden" name="use_min">
	</dd>
</dl>
</script>
<script id="EDIcontents" type="text/template">
<STYLE type="text/css">
p.HStyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle0
	{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle1
	{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle2
	{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle3
	{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle4
	{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle5
	{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle6
	{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle7
	{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle8
	{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle9
	{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle10
	{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle11
	{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle12
	{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle13
	{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
li.HStyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
div.HStyle14
	{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
p.HStyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle15
	{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle16
	{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
p.HStyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
li.HStyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
div.HStyle17
	{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
</STYLE>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
<TR>
	<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>부 서</SPAN></P>
	</TD>
	<TD colspan="4" valign="middle" style='width:247px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{orgnztNm}</SPAN></P>
	</TD>
	<TD colspan="2" valign="middle" style='width:64px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-6%;line-height:160%'>직 위</SPAN></P>
	</TD>
	<TD colspan="3" valign="middle" style='width:217px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_position}</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>성 명</SPAN></P>
	</TD>
	<TD colspan="9" valign="middle" style='width:528px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_emp_name}</SPAN></P>
	</TD>
</TR>
<TR>
	<TD colspan="2" valign="middle" style='width:111px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>휴가의</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>종 류</SPAN></P>
	</TD>
	<TD colspan="9" valign="middle" style='width:528px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>보상휴가</SPAN></P>
	</TD>
</TR>
<TR>
	<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>부서</SPAN></P>
	</TD>
	<TD colspan="2" valign="middle" style='width:51px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>이름</SPAN></P>
	</TD>
	<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>근태구분</SPAN></P>
	</TD>
	<TD valign="middle" style='width:84px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>시작일자</SPAN></P>
	</TD>
	<TD colspan="2" valign="middle" style='width:83px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>종료일자</SPAN></P>
	</TD>
	<TD colspan="2" valign="middle" style='width:76px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청일수</SPAN></P>
	</TD>
	<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청시간</SPAN></P>
	</TD>
	<TD valign="middle" style='width:106px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>비고</SPAN></P>
	</TD>
</TR>
{applyTr}
<TR>
	<TD colspan="11" valign="middle" style='width:640px;height:28px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:right;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>총 보상휴가일수 : &#160;{all} 사용일수 : &#160;{use2} 잔여보상휴가 : &#160;{rest} 보상휴가차감 : &#160;{use4} </SPAN></P>
	</TD>
</TR>
</TABLE>
<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'><BR><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";line-height:160%'>위와 같이 휴(공)가원을 제출하오니 허락하여 주시기 바랍니다.</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;&#160;&#160;&#160;&#160;&nbsp;</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
<TR>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
	<TD valign="middle" style='width:71px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{year}</SPAN></P>
	</TD>
	<TD valign="middle" style='width:23px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>년</SPAN></P>
	</TD>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{month}</SPAN></P>
	</TD>
	<TD valign="middle" style='width:16px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>월</SPAN></P>
	</TD>
	<TD valign="middle" style='width:49px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{day}</SPAN></P>
	</TD>
	<TD valign="middle" style='width:17px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>일</SPAN></P>
	</TD>
	<TD valign="middle" style='width:107px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
	<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
	</TD>
</TR>
</TABLE>
<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>

<P CLASS=HStyle0><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:18.0pt;font-family:"바탕";font-weight:bold;line-height:160%'>한국문학번역원</SPAN><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&nbsp;</SPAN></P>
</script>