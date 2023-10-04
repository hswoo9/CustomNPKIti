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
</style>

<script type="text/javascript">
	$(function(){
		//console.log("${empInfo}")
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
			대체휴무 - 신청자 검색 팝업(#empListPop)
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
				$("[name='use_emp_seq']").val(row.emp_seq);
				//$("[name='use_dept_name']").val(row.dept_name);
				$("[name='use_position']").val(row.position);
				$("[name='use_duty']").val(row.duty);
				myWindow.data("kendoWindow").close();
			});
		}
		/*
			조회기간 - 년/월 단위 설정(kendoDataPicker)
		*/
		$("#startDt").data("kendoDatePicker").setOptions({
			format: "yyyy-MM",
			depth: "year",
			start: "year"
		});
		$("#endDt").data("kendoDatePicker").setOptions({
			format: "yyyy-MM",
			depth: "year",
			start: "year"
		});
		/*
			승인상태 - KendoComboBox(#stepType)
		*/
		var comboBox2 = $("#stepType").kendoComboBox({
			dataSource: [{approval_status: '', approval_kr: '전체'} /* 0: 미신청 */
					   , {approval_status: '1', approval_kr: '신청'}
					   , {approval_status: '2', approval_kr: '승인'}
					   , {approval_status: '4', approval_kr: '반려'}],
			dataTextField: 'approval_kr',
			dataValueField: 'approval_status',
			change: function(e){
				var rows = comboBox2.select();
				var record = comboBox2.dataItem(rows);
				//console.log(record);
				$("[name='approval_status']").val(record.approval_status);				
			}
		}).data("kendoComboBox");
		
		/*
			대체휴무 - 승인 [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기]
		*/
		$("#approvalBtn").click(function(){
			var ch = $(".checkbox:checked");
			var notApproved = true;
			if(ch.length < 1){
				alert("승인할 목록을 체크해주세요");
				return;
			}else{
				var jsonArray = new Array();
				var grid = $("#gridSubHolidayReqList").data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					if(json.approval_status === '2'){
						notApproved = false;
						return;
					}
					json.update_emp_seq = "${empInfo.empSeq}";
					json.approval_status = "2";
					jsonArray.push(json);
				});
				if(!notApproved) {
					alert("이미 승인된 항목입니다");
					return;
				}
				var list = JSON.stringify(jsonArray);
				var result = confirm('승인 하시겠습니까?');
				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/subHoliApprovalUpdate',
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
								mainGridReload();
								alert("서버 반영 성공!!");
							}else{
								alert("서버 반영 실패..");
							}
						}
					});
				}
			}
		});
		/*
			시간외근무 - 승인취소 [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기]
		*/
		$("#cancleBtn").click(function(){
			var ch = $(".checkbox:checked");
			var isApproved = true;
			if(ch.length < 1){
				alert("승인취소할 목록을 체크해주세요");
				return;
			}else{
				var jsonArray = new Array();
				var grid = $("#gridSubHolidayReqList").data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					if(json.approval_status !== '2'){
						isApproved = false;
						return;
					}
					json.update_emp_seq = "${empInfo.empSeq}";
					json.approval_status = "1";/* 승인취소시 신청상태로 변경 */
					jsonArray.push(json);
				});
				if(!isApproved) {
					alert("승인되지 않은 항목은 승인 취소할 수 없습니다");
					return;
				}
				var result = confirm('승인취소 하시겠습니까?');
				if(result){
					myWindow2.data("kendoWindow").open();
					undo2.fadeOut();
					$("#rejectBtn").click(function(){
						var return_cause = $("#return_cause").val();
						for(var i in jsonArray){
							jsonArray[i].remark = return_cause;
						}
						var list = JSON.stringify(jsonArray);
						$.ajax({
							url: _g_contextPath_ + '/subHoliday/subHoliApprovalUpdate',
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
									mainGridReload();
									myWindow2.data("kendoWindow").close();
									alert("서버 반영 성공!!");
								}else{
									alert("서버 반영 실패..");
								}
							}
						});
					});
				}
			}
		});
		/*
			시간외근무 - 반려 팝업(#rejectPop) [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기]
		*/
 		var myWindow2 = $("#rejectPop"),
			undo2 = $("#rejectPopBtn");
		undo2.click(function(){
			var ch = $(".checkbox:checked");
			var isApplied = true;
			if(ch.length < 1){
				alert("반려할 목록을 체크해주세요");
				return;
			}else{
				var jsonArray = new Array();
				var grid = $("#gridSubHolidayReqList").data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					if(json.approval_status !== '1'){
						isApplied = false;
						return;
					}
					json.update_emp_seq = "${empInfo.empSeq}";
					json.approval_status = "4";
					jsonArray.push(json);
				});
				if(!isApplied) {
					alert('신청하지 않은 항목은 반려할 수 없습니다');
					return;
				}
				var result = confirm('반려 하시겠습니까?');
				if(result){
					myWindow2.data("kendoWindow").open();
					undo2.fadeOut();
					$("#rejectBtn").click(function(){
						var return_cause = $("#return_cause").val();
						for(var i in jsonArray){
							jsonArray[i].remark = return_cause;
						}
						var list = JSON.stringify(jsonArray);
						$.ajax({
							url: _g_contextPath_ + '/subHoliday/subHoliApprovalUpdate',
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
									mainGridReload();
									myWindow2.data("kendoWindow").close();
									alert("서버 반영 성공!!");
								}else{
									alert("서버 반영 실패..");
								}
							}
						});
					});
				}
			}
		});
		myWindow2.kendoWindow({
			width: "900px",
			height: "200px",
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
		
		/*
			대체휴무 - 조회(/subHoliday/gridSubHolidayReqList)
		*/
		var mainGridReload = function(){
			$("#gridSubHolidayReqList"/* Mapping1 */).data("kendoGrid").dataSource.read();
		}
		$(document).on('submit', "[name='subHolidayReqListFrm']", function(e){
			e.preventDefault();
			mainGridReload();
		});
		var mainGrid = function(){
			var grid = $("#gridSubHolidayReqList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayReqList',/* Mapping1 */
							dataType: 'json',
							type: 'post',
							cache: false,
							contentType: false,
							processData: false
						},
						parameterMap: function(data, operation){
							var formData = new FormData($("[name='subHolidayReqListFrm']").get(0));;
							formData.append('take', data.take);
							formData.append('skip', data.skip);
							formData.append('page', data.page);
							formData.append('pageSize', data.pageSize);
							formData.append('approval_emp_seq', "${empInfo.empSeq}"); //권한 풀어놓기 나중에 처리
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
				columns: [
				{
					headerTemplate: 
						"<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'>" +
						"<label class='k-checkbox-label' for='headerCheckbox'></label>",
					template: function(row){
						var key = row.replace_day_off_use_id;
						return "<input type='checkbox' id='replace_day_off_use_id" + key + "' class='k-checkbox checkbox'/>" + 
							   "<label for='replace_day_off_use_id" + key + "' class='k-checkbox-label'></label>";
					},
					width: 50
				},{
					field: "approval_status_kr",
					title: "진행단계",
					template: function(row){
						var status = row.approval_status,
			        		style = {},
							status_kr = ''; 
		            	switch (status) {
		            	case '1': 
		            		status_kr = '신청'; 
		            		style.color = 'blue';
			    			style.fontWeight = 'bold';
		            		break;
						case '2': 
							status_kr = '승인';
							style.color = 'black';
							break;
						case '4': 
							status_kr = '반려'; 
							style.color = 'tomato';
							break;
			    		default  : style.color = 'black'; break;
			    		}
			        	return $('<span>'+ status_kr +'</span>').css(style).get(0).outerHTML;
					}
				},{
		            field: "use_dept_name",
		            title: "부서"
		       	},{
		            field: "apply_emp_name",/* 쿼리필요 */
		            title: "성명"
		        },{
		            field: "use_position",
		            title: "직급"
		        },{
		            field: "use_duty",
		            title: "직책"
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
		          	field: "apply_start_time",
		          	title: "시작시간"
		        },{
		            field: "apply_end_time",
		            title: "종료시간"
		        },{
			        field: "remark",
			        title: "신청/반려사유",
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
		
		$("#headerCheckbox").change(function(){
			if($(this).is(":checked")){
				$(".checkbox").prop("checked", true);
			}else{
				$(".checkbox").prop("checked", false);
			}
		}); 
	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>시간외근무 승인</h4>
		</div>
	</div>
	<div class="sub_contents_wrap">
		<form method="post" name="subHolidayReqListFrm"
		action="${pageContext.request.contextPath }/subHoliday/gridSubHolidayReqList">
			<div class="top_box">
				<dl>
					<dt class="ar" style="width: 75px">기간</dt>
					<dd>
						<input type="text" value="" id="startDt" name="startDt" class="w113 datePickerInput"/>
						&nbsp;~&nbsp; 
						<input type="text" value="" id="endDt"	name="endDt" class="w113 datePickerInput" />
					</dd>
					<dt class="ar" style="width: 75px">신청자</dt>
					<dd>
						<input type="text" id="applyEmpName" disabled="disabled" value="" style="width:160px;"/> 
						<input type="hidden" name="use_emp_seq" value="">
						<input type="hidden" name="use_position" value="">
						<input type="hidden" name="use_duty" value="">
					</dd>
					<dd>
						<input type="button" id="empListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
					</dd>
				</dl>
				<dl class="next2">
					<dt class="ar" style="width: 75px">승인상태</dt>
					<dd>
						<input id="stepType" class="select-box">
						<input type="hidden" name="approval_status">
					</dd>
				</dl>
			</div>
			<div class="btn_div mt10 cl">
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="approvalBtn">승인</button>
						<button type="button" id="cancleBtn">승인 취소</button>
						<button type="button" id="rejectPopBtn">반려</button>
						<button type="submit" id="gridReloadBtn">조회</button>
					</div>
				</div>
			</div>
			<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
			<input type="hidden" name="ieParsing" value="ie">
		</form>
		<div class="com_ta2 mt20" id="gridSubHolidayReqList"></div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

<!-- 반려 팝업 -->
<div class="pop_wrap_dir" id="rejectPop" style="width:900px;">
	<div class="pop_head">
		<h1>반려 사유</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta" style="">
			<div class="top_box gray_box">
				<dl >
					<dt style="width:80px;">반려사유</dt>
					<dd>
						<input style="width:700px" type="text" id="return_cause"/>
					</dd>																
				</dl>
			</div>
		</div>	
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="rejectBtn" value="반려" />
		</div>
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