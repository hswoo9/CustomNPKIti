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
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>근무계획</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">

		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px">년월</dt>
				<dd>
					<input type="text" value="${nowDate}" name="" id="monthpicker"
						placeholder="" /> 
				</dd>
				<dt  class="ar" style="width:65px" >부서</dt>
				<dd>
					<input id="deptListBox" class="select-box">
					<input type="hidden" name="request_dept_name">
				</dd>
				<dt class="ar" style="width: 65px">성명</dt>
				<dd>
					<input type="text" id="empName" disabled="disabled" value="" /> 
					<input type="hidden" id="userSeq" disabled="disabled" value="" /> 
					<input type="hidden" id="deptName2" value="" /> 
				</dd>
				<dd>
					<input type="button" id="emp" value="검색" />
				</dd>
				<dt class="ar" style="width: 60px">승인상태</dt>
				<dd>
					<select name="statusType" id="statusType" style="width: 160px" onchange="">
						<option value="">전체</option>
						<option value="1">신청</option>
						<option value="2">승인</option>
 						<option value="3">반려</option>
					</select>
				</dd>
				<dt class="ar" style="width: 60px">근무유형</dt>
				<dd>
					<select name="workPlanType" id="workPlanType" style="width: 160px" onchange="">
						<option value="">전체</option>
					<c:forEach var="w" items="${workPlanType}">
						<%-- <option value="${w.work_type_id}">${w.work_type}</option> --%>
						<c:choose>
						     <c:when test="${(w.work_type_id == 6) || (w.work_type_id == 11)}"></c:when>
						     <c:otherwise>
						     	<option value="${w.work_type_id}">${w.work_type}</option>
						     </c:otherwise>
						 </c:choose>
					</c:forEach>
					</select>
				</dd>
			</dl>

		</div>
		<!-- 버튼 -->
		<div class="btn_div mt10 cl">

			<div class="left_div">
				<span class="tit_p mt5 mb0">유연근무 현황</span>

			</div>
	
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="excelBtn">엑셀다운로드</button>
					<button type="button" id="searchBtn">조회</button>
					<!-- <button type="button" id="" onclick="searchBtn();">조회</button> -->
				</div>
			</div>
		</div>
                <strong> <span style="color: rgb(0, 0, 255); float: right;"> ※ 엑셀 다운로드 시 조회기간이 길수록 다소 시간이 소요되오니 참고바랍니다. </span></strong><br />
		<div class="com_ta2 mt20" id="grid">
		</div>
		
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">상세내역</p>
			</div>
		</div>
		
		<div class="com_ta2 mt20" id="grid2">
		</div>
		
		<input type="hidden" id="detailKey" />
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->


<input type="hidden" id="rejectKey" />


<script type="text/javascript">


var dataSource = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/workPlanMasterList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
        	data.userSeq = $('#userSeq').val();
        	data.statusType = $('#statusType').val();
        	data.month = $('#monthpicker').val().replace(/-/gi,"");
        	data.request_dept_name = $("[name='request_dept_name']").val();
        	data.workPlanType = $('#workPlanType').val();
        	data.notIn = '';
     	return data;
     	}
        
    },
    schema: {
      data: function(response) {
        return response.list;
      },
      total: function(response) {
	        return response.totalCount;
	      },
	      model: {
	          fields: {

	          }
	      }
    }
});

var dataSource2 = new kendo.data.DataSource({
	serverPaging: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/adminWorkPlanDetail',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
        	data.key = $('#detailKey').val();
     	return data;
     	}
    },
    schema: {
      data: function(response) {
        return response.list;
      },
	      model: {
	          fields: {

	          }
	      }
    }
});



function nextMonth() {
	  var d = new Date()
	  var monthOfYear = d.getMonth()
	  d.setMonth(monthOfYear + 1)
	  return getDateStr(d)
	}
function getDateStr(myDate){
	var month = myDate.getMonth()+1;
	if ( month < 10 ) {
		month = '0'+month;
	}
	return (myDate.getFullYear() + '-' + month)
}
$(function(){
	
	$('select').kendoDropDownList();
	
});

function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
}

function gridReload2(){
	$('#grid2').data('kendoGrid').dataSource.read();
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

/* 토요일 일요일 그리드 색깔 처리 함수 */
function fn_weekDay(row) {
	var key = row.weekDay;
	
	switch (key) {
		case '토' : return '<span style="color:blue">'+key+'</span>'; 
			break;
		case '일' : return '<span style="color:red">'+key+'</span>'; 
			break;
		default  : return '<span>'+key+'</span>'; 
			break;
	}
	
}

function fn_workStep(row) {
	
	var step = row.status;
	var key = row.work_plan_history_id;
	
// 	if (nowDate == 'future') {
// 		if ( step != '4' ){
			return '<input type="checkbox" id="over'+key+'" class="k-checkbox checkbox"/><label for="over'+key+'" class="k-checkbox-label"></label>';
// 		}else {
// 			return '';
// 		}
		
// 	} else {
// 		return '';
// 	}
	
}

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        height: 270,
        dataBound: gridDataBound,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 100],//true,
            buttonCount: 5
        },
        persistSelection: true,
        selectable: "multiple",
        columns: [
       	{
      		field: "request_date",
      		title: "신청일자",
      		width: 150,
      		template: function(row){
      			var str = '';
      			(row.request_date === undefined) 
      				? str = '' 
      				: str = row.request_date.replace(/(\d{4})(\d{2})(\d{2})/g, function(match, p1, p2, p3){
      					return [p1, p2, p3].join('-');
      				});
      			return str;
      		}
        },{
            field: "status_kr",
            title: "진행단계",
            width: 150
       	},{
       		field: "approval_emp_name",
       		title: "승인권자",
       		width: 100
       	},{
            field: "dept_name",
            title: "부서",
            width: 150
            
        },{
            field: "emp_name",
            title: "성명",
            width: 100
            
        },{
            field: "position_name",
            title: "직급",
            width: 100
            
        },{
            field: "duty_name",
            title: "직책",
            width: 100
            
        },{
        	field: "remark",
        	title: "비고",
        	width: 150
        }],
        change: function (e){
        	codeGridClick(e);
        }
    }).data("kendoGrid");
	
	grid.table.on("click", ".checkbox", selectRow);
	
	var checkedIds = {};
	
	// on click of the checkbox:
	function selectRow(){
		
		var checked = this.checked,
		row = $(this).closest("tr"),
		grid = $('#grid').data("kendoGrid"),
		dataItem = grid.dataItem(row);
		
		checkedIds[dataItem.CODE_CD] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	function codeGridClick(e){
		var rows = grid.select();
		var record;
		rows.each(function() {
			record = grid.dataItem($(this));
		});
		$('#detailKey').val(record.work_plan_id);
		gridReload2();
	}
}

function mainGrid2(){
	//캔도 그리드 기본
	var grid = $("#grid2").kendoGrid({
        dataSource: dataSource2,
        height: 400,
        columns: [
           	{
                field: "work_date",
                title: "근무일자",
                
           	},{
                template: weekDay,
                title: "요일",
                
            },{
                field: "work_type",
                title: "근무유형",
                
            },{
                field: "attend_time",
                title: "출근시간",
                
            },{
                field: "leave_time",
                title: "퇴근시간",
                
            },{
                field: "come_dt",
                title: "실제 출근시간",
                
            },{
                field: "leave_dt",
                title: "실제 퇴근시간",
                
            },{
                field: "remark",
                title: "비고",
                
            }],
        change: function (e){
        	
        }
    }).data("kendoGrid");

}

function weekDay(row) {
	var color = '';
	
	if ( row.HOLIDAY_STATUS == 'Y' ) {
		if ( row.weekday == '토요일' ) {
			color = 'text_blue';
		} else {
			color = 'text_red';
		}
	} 
	
	return '<span class="'+color+'">'+row.weekday+'</span>';
	
}

function changeTimeTemp(row) {
	
	var attTime = row.changeWorkAttend;
	var leaveTime = row.changeWorkLeave;
	
	return attTime+'</br>'+leaveTime;
	
}


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
			$("[name='request_dept_name']").val(record.dept_name);
			$("[name='request_dept_name2']").val(record.dept_name);
		},
		index: 0,
		open: function(e){
			$("#empName").val("");
			$("#userSeq").val("");
		}
	}).data("kendoComboBox");
	
	$('.sub_contents_wrap .top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			searchBtn();
		};
	});
	
	$('#popUp2 .top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			empGridReload();
		};
	});
	/* kendo datepicker 년월 처리 년월 From */
	$("#monthpicker").kendoDatePicker({
		// defines the start view
		start : "year",

		// defines when the calendar should return date
		depth : "year",

		// display month and year in the input
		format : "yyyy-MM",
		parseFormats : [ "yyyy-MM" ],

		// specifies that DateInput is used for masking the input element
		culture : "ko-KR",
		dateInput : true
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
		parseFormats : [ "yyyyMMdd" ],
		culture : "ko-KR",
		value : lastDay
	});
	$("#startDt").attr("readonly", true);
	$("#endDt").attr("readonly", true);
	/*
		엑셀다운로드 팝업(#excelDownPop)
	*/
	var myWindow = $("#excelDownPop"),
		undo = $("#excelBtn");
	undo.click(function(){
		myWindow.data("kendoWindow").open();
		undo.fadeOut();
	});
	myWindow.kendoWindow({
		width: "400px",
		visible: false,
		modal: true,
		actions: [
			"Close"
		],
		close: function(){
			undo.fadeIn();
		}
	}).data("kendoWindow").center();
	
	$(document).on('submit', "[name='workPlanExcelList']", function(e){
		e.preventDefault();
		//$("[name='date2']").val($('#monthpicker').val().replace(/-/gi , ''));
		$("[name='startDt']").val($('#startDt').val().replace(/-/gi , ''));
		$("[name='endDt']").val($('#endDt').val().replace(/-/gi , ''));
		document.workPlanExcelList.submit();	 
	});	
	
	mainGrid();
	
	mainGrid2();
	
	$("#headerCheckbox").change(function(){
		
		var checkedIds = {};
        if($("#headerCheckbox").is(":checked")){
        	$(".checkbox").prop("checked", "checked");
        	var checked = this.checked,
            row = $(this).closest("tr"),
            grid = $("#grid").data("kendoGrid"),
            dataItem = grid.dataItem(row);

            checkedIds[dataItem.emp_seq] = checked;

            if (checked) {
                row.addClass("k-state-selected");

            } else {
                row.removeClass("k-state-selected");
               
            }
        }else{
        	$(".checkbox").removeProp("checked");
        }
    });
});
	function gridDataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	
    
		 function searchBtn() {
			 gridReload();
			 $('#headerCheckbox').prop('checked', false);
			 $('#userSeq').val('');
			 $('#empName').val('');
			
			}
	$(document).on('click', '#searchBtn', function(){
		gridReload();
		$('#userSeq').val('');
		$('#empName').val('');
	});
 /* 부서선택시 사원선택 그리드 처리 */
	function deptList(e) {
		var seq = $(e).val();
		console.log($('#deptName option:selected').text());
		$('#deptSeq').val(seq);
		$('#deptName2').val($('#deptName option:selected').text());
		empGridReload();

	}
 
	$(document).ready(function() {
		var myWindow2 = $("#popUp2");
		undo2 = $("#emp, #emp2");

		undo2.click(function() {
			empGrid();
			myWindow2.data("kendoWindow").open();
			undo2.fadeOut();
		});

		function onClose2() {
			$('#emp_name').val('');
			$('#dept_name').val('');
			empGridReload();
			undo2.fadeIn();

		}
		$("#cancle").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
			width : "600px",
			height : "665px",
			visible : false,
			modal : true,
			actions : [ "Close" ],
			close : onClose2
		}).data("kendoWindow").center();

	});
	/* 사원팝업 kendo 그리드 */
	var empDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : _g_contextPath_+'/common/empInformation',
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.deptSeq = $("#deptListBox").val(); //$('#deptSeq').val();
				data.emp_name = $('#emp_name').val();
				data.dept_name = $('#dept_name').val();
				data.notIn = '';
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
	
	
/* 	$(function() {

		empGrid();

	}); */
	
	/* 사원팝업 kendo 그리드 refresh */
	function empGridReload() {
		/* $('#empGrid').data('kendoGrid').dataSource.read(); */
		$("#empGrid").data("kendoGrid").dataSource.page(1);
	}
	
	/* 사원팝업 kendo 그리드 */
	function empGrid() {
		//캔도 그리드 기본
		var empGrid = $("#empGrid").kendoGrid({
						dataSource : empDataSource,
						height : 460,

						pageable : {
							refresh : true,
							pageSizes : true,
							buttonCount : 5
						},
						persistSelection : true,
						selectable : "multiple",
						columns : [
							/* { template: "<input type='checkbox' class='checkbox'/>"
							,width:50,	
							}, */
							{
								field : "emp_name",
								title : "이름",
	
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
	
							},
							{
								title : "선택",
								template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
							} 
						],
						change : function(e) {
							empGridClick(e)
						}
					}).data("kendoGrid");

		empGrid.table.on("click", ".checkbox", selectRow);

		var checkedIds = {};

		// on click of the checkbox:
		function selectRow() {

			var checked = this.checked, row = $(this).closest("tr"), empGrid = $(
					'#empGrid').data("kendoGrid"), dataItem = grid
					.dataItem(row);

			checkedIds[dataItem.emp_seq] = checked;
			if (checked) {
				//-select the row
				row.addClass("k-state-selected");
			} else {
				//-remove selection
				row.removeClass("k-state-selected");
			}

		}
		function empGridClick() {
			var rows = empGrid.select();
			var record;
			rows.each(function() {
				record = empGrid.dataItem($(this));
			});
			subReload(record);
		}
	}

	function subReload(record) {

		$('#use_emp_seq').val(record.emp_seq);
		$('#empDept').val(record.dept_name);
		$('#empName').val(record.emp_name);

	}
	/* 사원 선택 기능 */
	function empSelect(e) {
		var row = $("#empGrid").data("kendoGrid").dataItem($(e).closest("tr"));
		$('#empName').val(row.emp_name);
		$('#userSeq').val(row.emp_seq);
		$('[name="userSeq2"]').val(row.emp_seq);
		$('#deptName2').val(row.dept_name);
		$('#popUp2').data("kendoWindow").close();
	}
	</script>
	<input type="hidden" id="userSeq" value=""/>
	<input type="hidden" id="approvalSeq" value="${userInfo.userSeq }"/>

<div class="pop_wrap_dir" id="popUp2" style="width: 600px;">
	<div class="pop_head">
		<h1>사원 리스트</h1>

	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" style="width: 120px" />
				</dd>
				<dt>부서</dt>
				<dd>
					<input type="text" id="dept_name" style="width: 180px" /> <input
						type="button" onclick="empGridReload();" id="searchButton"
						value="검색" />
				</dd>
			</dl>
		</div>
		<div class="com_ta mt15" style="">
			<div id="empGrid"></div>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">

			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<!-- 엑셀 다운로드 팝업 -->							
</form>

<div class="pop_wrap_dir" id="excelDownPop" style="width:400px; display: none;">
	<div class="pop_con">
		<div class="btn_div mt0">
			<div class="left_div">
				<h5>엑셀다운로드</h5>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
				</div>
			</div>
		</div>
		<div class="com_ta" style="" >
			<form name="workPlanExcelList" method="post" 
			id="fileDownloadDiv" action="${pageContext.request.contextPath }/workPlan/workPlanExcelList" >
				<table>
				<tr>
					<th style="width: 85px;">조회시작일</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="startDt" class="w113">
							<input type="hidden" name="startDt">
						</span>
					</td>
				</tr>
				<tr>
					<th style="width: 85px;">조회종료일</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="endDt" class="w113">
							<input type="hidden" name="endDt">
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding: 0; padding-bottom: 5px;">
						<div class="btn_cen">
							<input type="submit" class="blue_btn" id="inputFrmBtn" value="저장">
							<input type="button" class="gray_btn" value="닫기"/>
						</div>
					</td>
				</tr>
				<!-- <input type="hidden" name="date2"> -->
				<input type="hidden" name="request_dept_name2">
				<input type="hidden" name="userSeq2">
				<!-- form의 끝에 값이 적용되지 않고 ajax로 request발생시 ie10/11에서 request parsing에러 발생 -->
				<input type="hidden" name="ieParsing" value="ie">
			</table>
			</form>
		</div>
	</div>
</div>