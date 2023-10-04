<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
				<dt class="ar" style="width: 30px">기간</dt>
				<dd>
					<input type="text" value="${nowDate}" name="" id="monthpicker"
						placeholder="" />&nbsp;~ <input type="text" value="" name=""
						id="monthpicker2" placeholder="" />
				</dd>
				
				<dt class="ar" style="width: 30px">성명</dt>
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
					<select name="" id="statusType" style="width: 160px" onchange="">
						<option value="">전체</option>
						<option value="1">신청</option>
						<option value="2">승인</option>
<!-- 						<option value="3">반려</option> -->
					</select>
				</dd>
			</dl>
			

		</div>
		<!-- 버튼 -->
		<div class="btn_div mt10 cl">
			
			<div class="left_div">
				<span class="tit_p mt5 mb0">유연근무 신청현황</span>

			</div>
			
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="fn_approval" onclick="">승인</button>
					<button type="button" id="fn_approvalCancle" onclick="">승인 취소</button>
<!-- 					<button type="button" id="fn_reject" onclick="">반려</button> -->
					<button type="button" id="" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>
		
		<div class="com_ta2 mt20" id="grid">
		</div>
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->


<input type="hidden" id="empSeq" value="${ userInfo.empSeq}" />
<input type="hidden" id="deptSeq" value="${ userInfo.deptSeq}" />

<script type="text/javascript">


$(function(){
	
	if ( $('deptSeq').val() == '1237' ) {
/* 		 $('empSeq').val('');
		 $('fn_approval').css({'display':'none'});
		 $('fn_approvalCancle').css({'display':'none'}); */
	} else {
		$('fn_approval').css({'display':'inline-block'});
		 $('fn_approvalCancle').css({'display':'inline-block'});
		
	}
	
	
})

var dataSource = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/workPlanAppList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		
/*       	if ( $('#deptSeq').val() == '1237' ) {
      			data.approvalSeq = '';
//       			 $('#fn_approval').css({'display':'none'});
//       			 $('#fn_approvalCancle').css({'display':'none'});
      		} else {
      			
      			data.approvalSeq = $('#empSeq').val();
      			$('#fn_approval').css({'display':'inline-block'});
      			$('#fn_approvalCancle').css({'display':'inline-block'});
      			
      		} */
      		
        	data.userSeq = $('#userSeq').val();
        	data.statusType = $('#statusType').val();
        	data.dateFr = $('#monthpicker').val().replace(/-/gi,"");
        	data.dateTo = $('#monthpicker2').val().replace(/-/gi,"");
        	data.notIn = '';
        	
        	var adminYN = "${admin_yn}";
        	if(adminYN == 'Y'){
				data.approvalSeq = '';
			}else{
				data.approvalSeq = $('#empSeq').val(); //권한 풀어놓은거 나중에 처리
			}
			
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

var detailDataSource = new kendo.data.DataSource({
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

function detailGrid(){
	//캔도 그리드 기본
	var grid = $("#detailGrid").kendoGrid({
        dataSource: detailDataSource,
//         height: 436,
        
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
	
	$('#monthpicker2').val(nextMonth());
	
	mainGrid();
	
});

function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
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
	var key = row.work_plan_id;
	
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
        height: 436,
        dataBound: gridDataBound,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        persistSelection: true,
        selectable: "multiple",
        columns: [
       	{
       		headerTemplate: "<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",
         	template: fn_workStep,
           	width : 50,
        },{
            field: "statusKr",
            title: "진행단계",
            template: function(row){
            	var statusKr = row.statusKr,
	        		style = {}; 
            	switch (statusKr) {
	    		case '신청' : 
	    			style.color = 'blue';
	    			style.fontWeight = 'bold';
	    			break;
	    		case '승인' : style.color = 'black'; break;
	    		case '반려' : style.color = 'tomato'; break;
	    		default  : style.color = 'black'; break;
	    		}
	        	return $('<span>'+ statusKr +'</span>').css(style).get(0).outerHTML;
            }
       	},{
            field: "reqMonth",
            title: "대상 년월",
            
        },{
            field: "request_dept_name",
            title: "부서",
            
        },{
            field: "emp_name",
            title: "성명",
            
        },{
            field: "request_position",
            title: "직급",
            
        },{
            field: "request_duty",
            title: "직책",
            
        },{
          field: "reqDate",
          title: "신청 일자",
           
        },{
            template: '<input type="button" id="" onclick="detailPop(this);" value="보기"/>',
            title: "상세 내역",
             
          }],
        change: function (e){
        	
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
	function codeGridClick(){
		
	}
}

$(function(){
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
	
	
	
})
/* tab_nor_Fn('02');
var tabNum = '02';
function tab_nor_Fn(num){
	tabNum = num;
	$(".tab"+num).show();
	$(".tab"+num).siblings().hide();
	
	var inx = num -1

	$(".tab_nor li").eq(inx).addClass("on");
	$(".tab_nor li").eq(inx).siblings().removeClass("on");
	
    var param = {};
    param.num = num;
    
    $.ajax({
        type:"post",
        url: "<c:url value='/subHoliday/adminTab.do' />",
        data: param,
        datatype:"html",            
        success:function(data){
            $("#tabDiv").html(data);
            initTab(num);
           
        }
    });		
    
} */

function detailPop(e) {
	
	var grid = $('#grid').data("kendoGrid");
	dataItem = grid.dataItem($(e).closest("tr"));
	$('#detailKey').val(dataItem.work_plan_id);
	$("#detailPop").data("kendoWindow").open();
	detailGrid();
	$('#detailGrid').data('kendoGrid').dataSource.read();
	
}

function scheduleInsert(e) {
	
	
	var arr= [];
	for (var x in e) {
		arr.push(e[x]);
		
	}
	$.each(arr, function(i,v) {
		var empSeq = v.use_emp_seq;
		var deptSeq = v.use_dept_seq;
		var startDt = v.startTime;
		var endDt = v.endTime;
		var alldayYn = '';
		var mcalArr = [];
		
		if ( v.use_date_dn == 'single' ) {
			alldayYn = 'N';
		} else {
			alldayYn = 'Y';
		}
		mcalArr = v.mcalSeq.split(';');
		$.each(mcalArr, function(i,v) {
			
			$.ajax({
				type : 'POST',
				url : '/schedule/MobileSchedule/InsertAttendSchedule',
				data:JSON.stringify({
					  "header" : {
							  "pId"      : ""
							, "groupSeq" : "tpf"
							, "tId"      : ""
							, "empSeq"   : empSeq
					  }
					, "body" : {
						  "mcalSeq"     : v
						, "langCode"    : "kr"
						, "schTitle"    : "대체휴무"
						, "alldayYn"    : alldayYn
						, "alarm_yn"    : "N"
						, "startDate"   : startDt
						, "endDate"     : endDt
						, "calType"     : "E"
						, "pId"         : ""
						, "groupSeq"    : "tpf"
						, "tId"         : ""
						, "empSeq"      : empSeq
						, "compSeq"     : "1000"
						, "deptSeq"     : deptSeq
						, "companyInfo" : {
								  "bizSeq"      : "1000"
								, "compSeq"     : "1000"
								, "deptSeq"     : deptSeq
								, "emailAddr"   : ""
								, "emailDomain" : ""
						}
					}
				}),
				dataType : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(data) {
					searchBtn();
				},
				error:function(e) {
					consol.log(e);
					alert("일정등록 중 에러가 발생하였습니다.");
				}
			}); 
		})
		
	})
	
}

$(document).ready(function() {
	$('#fn_approval').on('click', function(){
		var ch = $('.checkbox:checked');
		if (ch.length < 1) {
			alert('승인할 목록을 체크해주세요');
		} else {
			var ch = $('.checkbox:checked');
			var data = {};
			grid = $('#grid').data("kendoGrid");
			var step = true;
			$.each(ch, function(i,v){
				var index = i;
				var tem = {}
				dataItem = grid.dataItem($(v).closest("tr"));
				tem['work_plan_id']	 =String(dataItem.work_plan_id);
// 				if ( dataItem.mcalSeq == '' || dataItem.mcalSeq == null ) {
// 					tem['mcalSeq'] = '';
// 				} else {
// 					tem['mcalSeq'] = dataItem.mcalSeq;
// 				}
				
				data[index] = tem;
				
				if ( dataItem.status != '1') {
					alert('신청단계만 체크해주세요.');
					searchBtn();
					step = false;
					return false;
				}
			})
			
			if (!step) return;
			var result = confirm('승인 하시겠습니까?');
			
			if (result) {
				
				$.ajax({
					url: _g_contextPath_+"/workPlan/workPlanApproval",
					dataType : 'text',
					data : {data : JSON.stringify(data)},
					type : 'POST',
					success : function(result){
						searchBtn();
					}
				})
			} else {
				searchBtn();
			} 
		}
		
	})
	
	$('#fn_approvalCancle').on('click', function(){
		
		var ch = $('.checkbox:checked');
		if (ch.length < 1) {
			alert('승인 취소할 목록을 체크해주세요');
		} else {
			var ch = $('.checkbox:checked');
			var data = new Array();
			grid = $('#grid').data("kendoGrid");
			var step = true;
			$.each(ch, function(i,v){
				
				dataItem = grid.dataItem($(v).closest("tr"));
				data.push(dataItem.work_plan_id);
// 				if ( dataItem.status != '2') {
// 					alert('승인된 건만 체크해주세요.');
// 					searchBtn();
// 					step = false;
// 					return false;
// 				}
				
			});
			if (!step) return;
			
			var result = confirm('승인취소 하시겠습니까?');
			
			if (result) {
				
				$.ajax({
					url: _g_contextPath_+"/workPlan/workPlanAppCancel",
					dataType : 'text',
					data : {data : data.join(',')},
					type : 'POST',
					success : function(result){
						console.log(result)
						searchBtn();
					},error: function(error){
						console.log(error);
					}
				})
			} else {
				searchBtn();
			}
		}
		
	})
	
// 	$('#rejectBtn').on('click', function() {
// 		var result = confirm('반려 하시겠습니까?');
// 		if(result) {
// 			var ch = $('.checkbox:checked');
// 			var data = new Array();
// 			var return_cause = $('#return_cause').val();
// 	   		grid = $('#grid').data("kendoGrid");
// 			$.each(ch, function(i,v){
// 				dataItem = grid.dataItem($(v).closest("tr"));
// 				data.push(dataItem.replace_day_off_use_id);
// 			});
// 			var allData = {
// 	   				data : data.join(','),
// 	   				return_cause : return_cause
// 	   		}
// 			$.ajax({
// 				url : _g_contextPath_+"/subHoliday/replaceHoliWorkReturn",
// 				dataType : 'text',
// 				data : allData,
// 				type : 'post',			
// 				success : function(result) {
// 					alert("저장 되었습니다.");
// 					$("#popUp").data("kendoWindow").close();
// 					$('#return_cause').val('');
// 					searchBtn();
// 				},
// 				error : function(error) {

// 					console.log(error);
// 					console.log(error.status);
// 				}
// 			});
// 		} else {
			
// 		}
// 	});
	
	
	
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
	/* kendo datepicker 년월 처리 년월 To */
	$("#monthpicker2").kendoDatePicker({
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
	
	$("#monthpicker").attr("readonly", true);
	$("#monthpicker2").attr("readonly", true);
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
 /* 부서선택시 사원선택 그리드 처리 */
	function deptList(e) {
		var seq = $(e).val();
		console.log($('#deptName option:selected').text());
		$('#deptSeq').val(seq);
		$('#deptName2').val($('#deptName option:selected').text());
		empGridReload();

	}
 
	$(document).ready(function() {
		var myWindow = $("#popUp");
	    undo = $("#fn_reject");
		
		 undo.click(function() {
			 	var ch = $('.checkbox:checked');
				var data = new Array();
				var step = new Array();
		   		grid = $('#grid').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.replace_day_off_use_id);
					step.push(dataItem.replace_holi_step);
				});
			 if (ch.length < 1) {
				 
				 alert('반려할 목록을 체크해주세요');
			 } else {
				 
				 var stepSts = true;
				 for (var i = 0 ; i < step.length ; i ++) {
					 if (step[i] == 'OS02') {
				        	stepSts = false;
							 alert("승인된 건은 반려가 불가능합니다.");
							 searchBtn();
							 return false;
				        }
				 }
				
				 
				 if (!stepSts) return;
				 myWindow.data("kendoWindow").open();
				    
			     undo.fadeOut();
			 }
			    
				
		     
		     
		 });
		
		 function onClose() {
		     undo.fadeIn();		    
			
		 }
		 $("#cancle").click(function(){
			 myWindow.data("kendoWindow").close();
		 });
		 myWindow.kendoWindow({
		     width: "900px",
		    height: "200px",
		     visible: false,
		     modal : true,
		     actions: [
		    	 "Close"
		     ],
		     close: onClose
		 }).data("kendoWindow").center();
		
		
		
		var myWindow2 = $("#popUp2");
		undo2 = $("#emp, #emp2");

		undo2.click(function() {
			
				myWindow2.data("kendoWindow").open();
				undo2.fadeOut();
			

		});

		function onClose2() {
			$('#emp_name').val('');
			$('#dept_name').val('');
			empGridReload();
			undo2.fadeIn();

		}
		
		$("#cancel").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		
		$("#cancel2").click(function() {
			$('#detailPop').data("kendoWindow").close();
		});
		
		myWindow2.kendoWindow({
			width : "600px",
			height : "665px",
			visible : false,
			modal : true,
			actions : [ "Close" ],
			close : onClose2
		}).data("kendoWindow").center();
		
		$('#detailPop').kendoWindow({
			width : "700px",
			height : "665px",
			visible : false,
			modal : true,
			title: "유연근무 신청 현황",
			actions : [ "Close" ],
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
				//data.deptSeq = $('#deptSeq').val();
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
	
	
	$(function() {

		empGrid();

	});
	
	/* 사원팝업 kendo 그리드 refresh */
	function empGridReload() {
		/* $('#empGrid').data('kendoGrid').dataSource.read(); */
		$("#empGrid").data("kendoGrid").dataSource.page(1);
	}
	
	/* 사원팝업 kendo 그리드 */
	function empGrid() {
		//캔도 그리드 기본
		var empGrid = $("#empGrid")
				.kendoGrid(
						{
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
									} ],
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
				console.log(record);
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
		$('#deptName2').val(row.dept_name);
		$('#popUp2').data("kendoWindow").close();
	}
	</script>
<!-- 	<input type="hidden" id="userSeq" value=""/> -->
	<input type="hidden" id="approvalSeq" value="${userInfo.userSeq }"/>
<div class="pop_wrap_dir" id="popUp" style="width:900px;">
		<div class="pop_head">
			<h1>반려 사유</h1>
			
		</div>
		
		<div class="pop_con">
			<div class="com_ta" style="">
				<div class="top_box gray_box">
							
							<dl >
								<dt style="width:80px;">	반려사유</dt>
								<dd>
									<input style="width:700px" type="text" id="return_cause" name="return_cause"/>
								</dd>																
							</dl>
							
						</div>
					</div>	
						
		</div><!-- //pop_con -->
		
		<div class="pop_foot">
			<div class="btn_cen pt12">

				<input type="button" class="blue_btn" id="rejectBtn" onclick="" value="반려" />
			</div>
		</div>
		<!-- //pop_foot -->
	
	</div><!-- //pop_wrap -->



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

			<input type="button" class="gray_btn" id="cancel" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<div class="pop_wrap_dir" id="detailPop" style="width: 700px;">
	
	<div class="pop_con">
		
		<div class="com_ta mt15" style="">
			<div id="detailGrid"></div>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">

			<input type="button" class="gray_btn" id="cancel2" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<input type="hidden" id="detailKey" value="" />