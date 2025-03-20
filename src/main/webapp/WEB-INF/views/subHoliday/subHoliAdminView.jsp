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
			},
			index: 0
		}).data("kendoComboBox");
		
		/*
			조회기간 - 년/월 단위 설정(kendoDataPicker)
		*/
		$("#startDt").data("kendoDatePicker").setOptions({
			format: "yyyy-MM-dd",
			depth: "month",
			start: "month"
		});
		$("#endDt").data("kendoDatePicker").setOptions({
			format: "yyyy-MM-dd",
			depth: "month",
			start: "month"
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
				$(".applyEmpName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
				$("[name='use_emp_seq']").val(row.emp_seq);
				$("[name='use_dept_name']").val(row.dept_name);
				$("[name='use_position']").val(row.position);
				$("[name='use_duty']").val(row.duty);
				myWindow.data("kendoWindow").close();
			});
		}

		function timeGridReload(){
			$('#timeGrid').data('kendoGrid').dataSource.read();
		}

		function timeGrid(){
			var grid = $("#timeGrid").kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: false,
					pageSize: 1,
					info: false,
					transport: {
						read: {
							url: _g_contextPath_+'/subHoliday/subHolidayTimeTotal',
							dataType: "json",
							type: 'post'
						},
						parameterMap: function(data, operation){
							var use_emp_seq = $("[name='use_emp_seq']").val();
							if(use_emp_seq === "0"){
								data.apply_emp_seq = '';
							}else{
								data.apply_emp_seq = use_emp_seq;
							}
							data.apply_dept_name = $("[name='apply_dept_name']").val();
							data.startDt = $("[name='startDt']").val();
							data.endDt = $("[name='endDt']").val();
							return data;
						}
					},
					schema: {
						data: function(response){
							return [response.data];
						}
					}
				}),
				pageable: false,
				scrollable: false,
				columns: [
					{
						field: "agree_min_sum",
						title: "인정시간",
						attributes: {
							style: "text-align: center;"
						},
						template: function(row){
							var agree_min_sum = row.agree_min_sum;
							if(agree_min_sum === undefined || agree_min_sum === null){
								return "";
							}else{
								return parseInt(agree_min_sum/60) + "시간" + agree_min_sum%60 + "분";
							}
						}
					},{
						field: "use_min_sum",
						title: "사용시간",
						attributes: {
							style: "text-align: center;"
						},
						template: function(row){
							var use_min_sum = row.use_min_sum;
							if(use_min_sum === undefined || use_min_sum === null){
								return "";
							}else{
								return parseInt(use_min_sum/60) + "시간" + use_min_sum%60 + "분";
							}
						}
					},{
						field: "rest_min_sum",
						title: "잔여시간",
						attributes: {
							style: "text-align: center;"
						},
						template: function(row){
							var rest_min_sum = row.rest_min_sum;
							if(rest_min_sum === undefined || rest_min_sum === null){
								return "";
							}else{
								return parseInt(rest_min_sum/60) + "시간" + rest_min_sum%60 + "분";
							}
						}
					}
				]
			}).data("kendoGrid");
		}

		timeGrid();

		/*
			대체휴무 사원별 사용 잔여 현황(subHoliday/gridSubHolidayUseRestList)
		*/
		function gridReload(){
			$("#gridSubHolidayUseRestList"/* Mapping1 */).data('kendoGrid').dataSource.read();
		}
		function mainGrid(){
			var grid = $("#gridSubHolidayUseRestList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayUseRestList',/* Mapping1 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							var use_emp_seq = $("[name='use_emp_seq']").val();
							if(use_emp_seq === "0"){
								data.apply_emp_seq = '';
							}else{
								data.apply_emp_seq = use_emp_seq;
							}
							data.apply_dept_name = $("[name='apply_dept_name']").val();
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
				height: 436, /*436*/
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
						field: "apply_dept_name",
						title: "부서"
					},{
						field: "apply_emp_name",
						title: "신청자",
					},{
						field: "apply_position",
						title: "직급"
					},{
						field: "apply_duty",
						title: "직책"
					},{
						field: "use_min_sum",
						title: "사용시간",
						template: function(row){
							var use_min_sum = row.use_min_sum;
							if(use_min_sum === undefined || use_min_sum === null){
								return "";
							}else {
								return parseInt(use_min_sum/60) + "시간" + use_min_sum%60 + "분";	
							}
						}
					},{
						field: "rest_min_sum",
						title: "잔여시간",
						template: function(row){
							var rest_min_sum = row.rest_min_sum;
							if(rest_min_sum === undefined || rest_min_sum === null){
								return "";
							}else{
								return parseInt(rest_min_sum/60) + "시간" + rest_min_sum%60 + "분";
							}
						}
				}],
				change: function(e){
					//codeGridClick();
					var rows = grid.select();
					var record;
					rows.each(function(){
						record = grid.dataItem($(this));
						$("[name='use_emp_seq']").val(record.apply_emp_seq);
						$("[name='click_use_emp_seq']").val(record.apply_emp_seq);
						gridReload2();
						gridReload3();
						$("[name='use_emp_seq']").val('0');
					});
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
		
		/*
			대체휴무 발생현황 (subHoliday/gridSubHolidayOccurList)
		*/
		function gridReload2(){
			$("#gridSubHolidayOccurList"/* Mapping2 */).data('kendoGrid').dataSource.read();
		}
		
		function mainGrid2(){
			var grid = $("#gridSubHolidayOccurList"/* Mapping2 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 20,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayOccurList',/* Mapping2 */
							dataType: 'json',
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.apply_emp_seq = $("[name='click_use_emp_seq']").val();
							data.startDt = $("[name='startDt']").val();
							data.endDt = $("[name='endDt']").val();
							data.admin = '1';
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
				height: 654, /*436*/
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
					field: "apply_dept_name",
					title: "부서"
				},{
					field: "apply_emp_name",
					title: "신청자"
				},{
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
					field: "apply_start_time",
					title: "신청시작시간"
				},{
					field: "apply_end_time",
					title: "신청종료시간"
				},{
					field: "work_start_time",
					title: "출근시간"
				},{
					field: "work_end_time",
					title: "퇴근시간"
				},{
					field: "agree_min",
					title: "인정시간",
					template: "#= parseInt(agree_min/60) # 시간 #= agree_min%60 #분"
				},{
					field: "use_min",
					title: "사용시간",
					template: "#= parseInt(use_min/60) # 시간 #= use_min%60 #분"
				},{
					field: "rest_min",
					title: "잔여시간",
					template: "#= parseInt(rest_min/60) # 시간 #= rest_min%60 #분"
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
					console.log(record);
				}); 
			}
		}
				
		mainGrid2();
		
		/*
			대체휴무 신청현황(subHoliday/gridSubHolidayReqList)
		*/
		function gridReload3(){
			$("#gridSubHolidayReqList"/* Mapping3 */).data('kendoGrid').dataSource.read();
		}
		$(document).on('submit', "[name='subHolidayReqListFrm']", function(e){ //발생현황도 한꺼번에처리
			e.preventDefault();
			timeGridReload();
			gridReload();
			gridReload2();
			gridReload3();
			//document.subHolidayReqListFrm.reset();
			$("[name='use_emp_seq']").val("0");
			$("[name='apply_dept_name']").val("");
			$(".applyEmpName").val("");
		});
		function mainGrid3(){
			var grid = $("#gridSubHolidayReqList"/* Mapping3 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridSubHolidayReqList',/* Mapping3 */
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
					field: "approval_emp_name",
					title: "승인권자"
				},{
					field: "date_format_create_date",
					title: "신청일자"
				},{
					field: "str_to_start_date",
					title: "휴무시작일자"
				},{
					field: "str_to_end_date",
					title: "휴무종료일자",
					template: function(row){
						var str_to_end_date = row.str_to_end_date;
						if(str_to_end_date === undefined){
							return row.str_to_start_date;
						}else{
							return str_to_end_date;
						}
					}
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
		            },
		            width: 50
				},{
					field: "use_dept_name",
					title: "부서"
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
					field: "use_min",
					title: "사용시간",
					template: "#= parseInt(use_min/60) # 시간 #= use_min%60 #분"
				},{
					field: "remark",
					title: "신청/반려사유"
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
				
		mainGrid3();
		
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
						<input id="deptListBox" class="select-box">
						<input type="hidden" name="apply_dept_name">
<%-- 					<input type="text" name="use_dept_name" disabled="disabled" 
						value="${empInfo.orgnztNm }" style="width:160px;"/>  --%>
					</dd>
					<dt class="ar" style="width:75px;">성명</dt>
					<dd>
						<input type="text" class="applyEmpName" disabled="disabled" 
						value="" style="width:160px;"/> 
						<input type="hidden" name="use_emp_seq" value="0"> <!-- 최초 실행시 조건초기화를 위한 value 0 -->
						<input type="hidden" name="click_use_emp_seq" value="0"> <!-- 최초 실행시 조건초기화를 위한 value 0 -->
						<input type="hidden" name="use_position" value="">
						<input type="hidden" name="use_duty" value="">
						<input type="button" class="empListPopBtn file_input_button ml4 normal_btn2" value="검색">
					</dd>
					<dt class="ar" style="width:80px;">조회기간</dt>
					<dd>
						<input type="text" value="" id="startDt" name="startDt" class="w113 datePickerInput"/>
						&nbsp;~&nbsp;
						<input type="text" value="" id="endDt"	name="endDt" class="w113 datePickerInput" />
					</dd>
				</dl>
			</div>
			
			<div class="btn_div">
				<div class="right_div">
					<div class="controll_btn p0">
						<input type="button" id="upExcelDown" value='보상휴가 현황 엑셀다운로드'>
						<input type="button" id="downExcelDown" value='보상휴가 발생현황 엑셀다운로드'>
						<input type="button" id="allExcelDown" value='전체 보상휴가 발생현황 엑셀다운로드'>
						<button type="submit" id="searchBtn">조회</button>
					</div>
				</div>
			</div>
		</form>

		<div id="midWrap" style="max-width: 800px; margin: 0 auto">
			<div class="com_ta2 mt20" id="timeGrid"></div>
		</div>
		<div class="com_ta2 mt20" id="gridSubHolidayUseRestList"></div><!-- Mapping1 -->
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">보상휴가 발생현황</p>
			</div>
		</div>
		
		<div class="com_ta2 mt20" id="gridSubHolidayOccurList"></div><!-- Mapping2 -->
		
		<div class="btn_div">
			<div class="left_div">
				<p class="tit_p mt5 mb0">보상휴가 신청현황</p>
			</div>
		</div>
		
		<div class="con_ta2 mt20" id="gridSubHolidayReqList"></div><!-- Mapping3 -->
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
<div style="display: none">
	<form action="${pageContext.request.contextPath }/subHoliday/upExcelDown" id="upExcelDownForm">
		<input type="hidden" name="apply_emp_seq" id="up_apply_emp_seq">
		<input type="hidden" name="apply_dept_name" id="up_apply_dept_name">
		<input type="hidden" name="startDt" id="up_startDt">
		<input type="hidden" name="endDt" id="up_endDt">
	</form>
	<form action="${pageContext.request.contextPath }/subHoliday/downExcelDown" id="downExcelDownForm">
		<input type="hidden" name="apply_emp_seq" id="down_apply_emp_seq">
		<input type="hidden" name="apply_dept_name" id="down_apply_dept_name">
		<input type="hidden" name="startDt" id="down_startDt">
		<input type="hidden" name="endDt" id="down_endDt">
	</form>
	<form action="${pageContext.request.contextPath }/subHoliday/allExcelDown" id="allExcelDownForm">
		<input type="hidden" name="startDt" id="down_startDt">
		<input type="hidden" name="endDt" id="down_endDt">
	</form>
</div>
<script type="text/javascript">

$('#upExcelDown').click(function(){
	var use_emp_seq = $("[name='use_emp_seq']").val();
	var apply_emp_seq = '';
	if(use_emp_seq === "0"){
		apply_emp_seq = '';
	}else{
		apply_emp_seq = use_emp_seq;
	}
	$('#up_apply_emp_seq').val($("[name='click_use_emp_seq']").val());
	$('#up_apply_dept_name').val($("[name='apply_dept_name']").val());
	$('#up_startDt').val($("[name='startDt']").val());
	$('#up_endDt').val($("[name='endDt']").val());
	$('#upExcelDownForm').submit();
})
$('#downExcelDown').click(function(){
	var use_emp_seq = $("[name='use_emp_seq']").val();
	var apply_emp_seq = '';
	if(use_emp_seq === "0"){
		apply_emp_seq = '';
	}else{
		apply_emp_seq = use_emp_seq;
	}
	$('#down_apply_emp_seq').val($("[name='click_use_emp_seq']").val());
	$('#down_apply_dept_name').val($("[name='apply_dept_name']").val());
	$('#down_startDt').val($("[name='startDt']").val());
	$('#down_endDt').val($("[name='endDt']").val());
	$('#downExcelDownForm').submit();
})
$('#allExcelDown').click(function(){
	$('#down_startDt').val($("[name='startDt']").val());
	$('#down_endDt').val($("[name='endDt']").val());
	$('#allExcelDownForm').submit();
})
</script>
