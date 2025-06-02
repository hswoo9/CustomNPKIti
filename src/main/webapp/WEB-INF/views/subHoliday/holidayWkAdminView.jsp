<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
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
<script type="text/javascript" src='<c:url value="/js/jszip.min.js"></c:url>'></script>

<style type="text/css">
	.k-header .k-link {
		text-align: center;
	}
	.k-grid-content>table>tbody>tr {
		text-align: center;
	}
	.k-grid th.k-header, .k-grid-header {
		background: #F0F6FD;
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
	$(function(){
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
			휴일근무 - 신청자 검색 팝업(#empListPop)
		*/
		var myWindow2 = $("#empListPop"),
			undo2 = $("#empListPopBtn");
		undo2.click(function(){
			myWindow2.data("kendoWindow").open();
			undo2.fadeOut();
			empGrid();
		});
		$("#empListPopClose").click(function(){
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
				//$("[name='apply_dept_name']").val(row.dept_name);
				$("[name='apply_position']").val(row.position);
				myWindow2.data("kendoWindow").close();
			});
		}
		
		/*
			휴일근무 - 보고서 다운로드 팝업(#fileDownloadPop)
		*/
		var myWindow = $("#fileDownloadPop");
		$(document).off('click').on('click', "[value='초과근무보고서']", function(){
			$("#report_name").html($(this).val());
			var row = $("#gridOverWkReqList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			var target_table_name = '';
			if($(this).val() === '근무계획서'){
				target_table_name = "work_plan_report_id";
			}else if($(this).val() === '초과근무보고서'){
				target_table_name = "after_action_report_id";
			}
			$("[name='weekday']").val(row.weekday);
			myWindow.data("kendoWindow").open();
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
											$("#fileDownloadDiv").find('tr[class="updateFrm"]').show();
											$("[name='occur_min']").val(jj.min.occur_min);
											$("[name='agree_min']").val(jj.min.agree_min);
											$("[name='use_min']").val(jj.min.use_min);
											$("[name='rest_min']").val(jj.min.rest_min);
											$("#start_time_picker").data("kendoTimePicker").value(jj.time.work_start_time);
											$("#end_time_picker").data("kendoTimePicker").value(jj.time.work_end_time);
											$("#occur_min_show").val(
												parseInt(jj.min.occur_min/60) + "시간" + parseInt(jj.min.occur_min%60) + "분(휴게시간: " + jj.min.break_min + "분)"
											);
											$("#agree_min_show").val(
												parseInt(jj.min.agree_min/60) + "시간" + parseInt(jj.min.agree_min%60) + "분"
											);
											$("#use_rest_show").val(
												'인정: ' + jj.min.agree_min + '분/사용: ' + jj.min.use_min + '분/잔여: ' + jj.min.rest_min + '분' 		
											);
											$("#is_use_rest").val("true");
											$("#inputFrmBtn").val("수정");
											requestURL = "updateAgreeMin";
										}else{
											requestURL = "inputAgreeMin";
										}
										$(document).off('submit').on('submit', "[name='inputAgreeMinFrm']", function(e){
											e.preventDefault();
											var formData = new FormData($(this).get(0));
											formData.append('ot_work_apply_id', json.ot_work_apply_id);
											// formData.append('occur_min', json.apply_min);
											formData.append('apply_start_date', json.apply_start_date);
											formData.append('create_emp_seq', "${empInfo.empSeq}");
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
														mainGridReload();
														alert("서버 저장 성공!!");
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
		myWindow.kendoWindow({
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
		
		// input 창에 숫자랑 .만 쓸 수 있도록 
		$(document).on('keyup', '.timeValidation', function(){
			$(this).val($(this).val().replace(/[^0123456789.]/g,""));
		});
		
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
						var work_min = parseInt(result.work_min);
						var agreed_min = $("[name='agree_min']").val();
						$("#occur_min_show").val(parseInt(result.total_work_min/60) + "시간" + parseInt(result.total_work_min%60) + "분(휴게시간: " + result.rest_min + "분)");

						var over_min = 0;
						if($("[name='weekday']").val() != "토" && work_min > 480) {
							over_min = work_min - 480;
							agreed_min = parseInt(480 * 1.5) + parseInt(over_min * 2);
						} else {
							agreed_min = parseInt(work_min * 1.5);
						}
						$("#agree_min_show").val(parseInt(agreed_min/60) + "시간" + parseInt(agreed_min%60) + "분");

						$("[name='occur_min']").val(result.total_work_min);
						$("[name='agree_min']").val(agreed_min);
						$("[name='break_min']").val(result.rest_min);
						if($("#is_use_rest").val() !== ""){
							var rest_min = parseInt($("[name='rest_min']").val()); //위에서 구한 휴게시간이랑 다름...잔여시간임!!!
							var rest_change_min = (agreed_min - $("[name='use_min']").val());
							$("[name='rest_min']").val(rest_change_min);
							$("#chagen_use_rest_show").val(
								'인정: ' + agreed_min + '분/사용: ' + $("[name='use_min']").val() + '분/잔여: ' + rest_change_min + '분'
							);
						}else{
							$("#use_rest_show").val(
									'인정: ' + agreed_min + '분/사용: 0분/잔여: ' + agreed_min + '분'
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
		
		/*
			휴일근무 - 조회(subHoliday/gridOverWkReqList)
		*/
		var mainGridReload = function(){
			$("#gridOverWkReqList"/* Mapping1 */).data("kendoGrid").dataSource.read();
		}
		$(document).on('submit', "[name='overWkApplyListFrm']", function(e){
			e.preventDefault();
			mainGridReload();
		});
		var mainGrid = function(){
			var grid = $("#gridOverWkReqList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridOverWkReqList',/* Mapping1 */
							dataType: 'json',
							type: 'post',
							cache: false,
							contentType: false,
							processData: false
						},
						parameterMap: function(data, operation){
							var formData = new FormData($("[name='overWkApplyListFrm']").get(0));;
							formData.append('take', data.take);
							formData.append('skip', data.skip);
							formData.append('page', data.page);
							formData.append('pageSize', data.pageSize);
							formData.append('group_code', 'OVERWK_TYPE');
							formData.append('code', '02');
							formData.append('reward_code', 'H');
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
				height: 436,
				dataBound: gridDataBound,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: 'multiple',
				toolbar: [{name: 'excel', text: '엑셀 다운로드'}],
				excel: {
					fileName: '휴일근무엑셀.xlsx',
					allPages: true
				},
				excelExport: function(e) {
					var sheet = e.workbook.sheets[0];
					var template0;
					var template1;
					var template2;
					if(this.columns[0].template){
						template0 = kendo.template(function(row){
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
						});
					}
					if(this.columns[17].template){
						template1 = kendo.template(function(row){
							if(row.work_place === 'outdoor'){
			        			return "외근";
			        		}else if(row.work_place === 'indoor'){
			        			return "내근";
			        		}else{
			        			return "";
			        		}
						});
					}
					if(this.columns[18].template){
						template2 = kendo.template(function(row){
							console.log('row', row);
							if(row.work_place == 'outdoor'){
								//console.log('afterActionReportId', row.after_action_report_id);
				        		if(row.after_action_report_id === undefined){
				        			return '보고서미등록';
				        		}else{
				        			return '보고서등록'; 
				        		}
			        		}else{
			        			return '';
			        		}
						});
					}
					for(var i = 1;i < sheet.rows.length; i++){
						var row = sheet.rows[i];
						if(sheet.rows[i].type == 'data'){
							var dataItem = {
									approval_status: row.cells[0].value,
									work_place: row.cells[17].value,
									after_action_report_id: row.cells[18].value
							};
							row.cells[0].value = template0(dataItem);
							row.cells[17].value = template1(dataItem);
							row.cells[18].value = template2(dataItem);
						}
					}
				},
				columns: [
				{
					field: "approval_status",
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
					field: "approval_emp_name",
					title: "승인권자"
				},{
					
		            field: "str_to_date",
		            title: "신청일자"
		        },{
		        	field: "weekday",/* 쿼리필요 */
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
		            },
		            width: 50
		        },{
		            field: "apply_dept_name",
		            title: "부서"
		        },{
		            field: "apply_emp_name",/* 쿼리필요 */
		            title: "성명"
		        },{
		            field: "apply_position",
		            title: "직급"
		        },{
		            field: "apply_duty",
		            title: "직책"
		        },{
		          	field: "apply_start_time",
		          	title: "시작시간"
		        },{
		            field: "apply_end_time",
		            title: "종료시간"
		        },/* {
		        	field: "work_type",
		        	title: "휴일근무유형"
		        }, */{
			        field: "work_dscr",
			        title: "업무내용",
		        },/* {
		        	field: "action_plan",
		        	title: "근무계획서",
		        	template: function(row){
		        		return "<input type='button' class='fileDownLoad text_blue' value='근무계획서'>";
		        	}
		        }, */{
		        	field: "work_start_time",
		        	title: "실제출근시간"
		        },{
		        	field: "work_end_time",
		        	title: "실제퇴근시간"
		        },{
		        	field: "occurTime",
		        	title: "발생시간",
		        	template: function(row){
			        	return row.occurHour;
		        	}
		        },{
		        	field: "breakTime",
		        	title: "휴게시간",
					template: function(row){
						return row.breakHour;
					}
		        },{
		        	field: "agreeTime",
		        	title: "인정시간",
					template: function(row){
						return row.agreeHour;
					}
		        },{
					field: "occurNightTime",
					title: "야간근무시간",
					template: function(row){
						return row.occurNightHour;
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
		        	field: "after_action_report_id",
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
		        }],
				change: function(e){
					//codeGridClick(e);
				}
			}).data("kendoGrid");
			
			function codeGridClick(e){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
					console.log(record);
				}); 
			}
		}
				
		mainGrid();
		
	});
</script>


<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>근무계획</h4>
		</div>
	</div>
	<div class="sub_contents_wrap">
		<form method="post" name="overWkApplyListFrm"
		action="${pageContext.request.contextPath }/subHoliday/gridOverWkReqList">
			<div class="top_box">
				<dl>
<!-- 				<dt class="ar" style="width: 75px">부서</dt>
					<dd>
						<input type="text" name="apply_dept_name" disabled="disabled" 
						value="" style="width:160px;"/> 
					</dd> -->
					<dt class="ar" style="width: 75px">성명</dt>
					<dd>
						<input type="text" id="applyEmpName" disabled="disabled" 
						value="" style="width:160px;"/> 
						<input type="hidden" name="apply_emp_seq" value="">
						<input type="hidden" name="apply_position" value="">
					</dd>
					<dd>
						<input type="button" id="empListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
					</dd>
					<dt class="ar" style="width: 75px">기간</dt>
					<dd>
						<input type="text" value="" id="startDt" name="startDt" class="w113 datePickerInput"/>
						&nbsp;~&nbsp;
						<input type="text" value="" id="endDt"	name="endDt" class="w113 datePickerInput" />
					</dd>
				</dl>
			</div>
			<div class="btn_div mt10 cl">
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="submit" id="gridReloadBtn">조회</button>
					</div>
				</div>
			</div>
		</form>
		<div class="com_ta2 mt20" id="gridOverWkReqList"></div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

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
			<input type="hidden" id="weekday" name="weekday">
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
		<th style="width: 85px;">발생시간</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input type="text" id="occur_min_show" value="" readonly style="width: 95%;">
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
	<tr class="inputFrm">
		<th style="width: 85px;">인정/사용/잔여</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<input type="text" id="use_rest_show" value="" readonly style="width: 95%;">
				<input type="hidden" id="is_use_rest" value="">
			</span>
		</td>
	</tr>
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
	<input type="hidden" name="occur_min" value="">
	<input type="hidden" name="agree_min" value="">
	<input type="hidden" name="use_min" value="">
	<input type="hidden" name="rest_min" value="">
	<input type="hidden" name="break_min" value="">
	<input type="hidden" name="isHoliday" value="true">
	<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
	<input type="hidden" name="ieParsing" value="ie">
</table>
</script>