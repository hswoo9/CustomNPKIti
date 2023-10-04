<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>
 <script type="text/javascript">
 
 /* 토요일 일요일 그리드 색깔 처리 함수 */
 function fn_weekDay(row) {
		var key = row.weekDay;
		
		switch (key) {
			case '토' : return '<span style="color:blue">'+key+'</span>'; 
				break;
			case '일' : return '<span style="color:red">'+key+'</span>'; 
				break;
			case undefined : return '<span style="color:red"></span>'; 
				break;
			default  : return '<span>'+key+'</span>'; 
				break;
		}
		
	}
/*팝업 위치설정*/
$(document).ready(function() {
	
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

	timeGrid();
	
	mainGrid();
	
});
			
	</script> 
	
<title></title>

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
</style>

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
										<input type="text" value="${nowDate}" name="" id="monthpicker" placeholder="" />
										
									</dd>
									<dt  class="ar" style="width:65px" >부서</dt>
									<dd>
										<input type="text" id="deptName" disabled="disabled" value="${userInfo.orgnztNm }"/>
										<input type="hidden" id="deptSeq" disabled="disabled" value="${deptSeq }"/>
									</dd>
									<dt  class="ar" style="width:65px" >성명</dt>
									<dd>
										<input type="text" id="empName" disabled="disabled" value="${userInfo.empName }"/>
										<input type="hidden" id="userSeq" disabled="disabled" value="${userSeq }"/>
									</dd>
								</dl>
								
							</div>
							<div class="btn_div mt10 cl">
				
				<div class="right_div">
									<div class="controll_btn p0">										
										<button type="button" id="" onclick="searchBtn();">조회</button>
										
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


	
	<script type="text/javascript">
	
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
      		data.date = $('#monthpicker').val().replace(/-/gi , '');
        	data.userSeq = $('#userSeq').val();
        	data.notIn = '';
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

	
/* 연장근무 개인조회 시간 정보 조회 그리드 (첫번째 그리드) refresh */
function timeGridReload(){
	$('#timeGrid').data('kendoGrid').dataSource.read();
	/* $("#timeGrid").data("kendoGrid").dataSource.page(1); */
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
            
        }, {
            field: "AGREE_HOUR",
            title: "인정시간",
           
        }],
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
      		data.date = $('#monthpicker').val().replace(/-/gi,"");
//         	data.userSeq = $('#userSeq').val();
			data.deptSeq = 'all';
     	return data;
     	}
    },
    schema: {
      data: function(response) {
        return response.list;
      },
      model: {
          fields: {
        	  HOURLY_WAGE: { type: "number"},
        	  WORK_APPLY_AMT: { type: "number"},
          }
      }
    }, group: {	// 신청인 별로 그룹화하고 인정시간 sum 구하기
        field: "empName", aggregates: [
        	{ field: "empName", aggregate: "max" },
            { field: "applyMin", aggregate: "sum" },
            { field: "agreeMin", aggregate: "sum" },
            { field: "occurMin", aggregate: "sum" },
         ]
      },
      aggregate: [ { field: "applyMin", aggregate: "sum" },
          { field: "agreeMin", aggregate: "sum" },
          { field: "occurMin", aggregate: "sum" }]
       
});


function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
	/* $("#grid").data("kendoGrid").dataSource.page(1); */
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
//         dataBound: gridDataBound,
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
            field: "apply_position",
            title: "직급",
        },{
            field: "apply_duty",
            title: "직책",
        },{
            field: "applyDate",
            title: "신청일자",
        }, {
        	template : fn_weekDay,
            title: "요일",
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
        	
            field: "attend_time",
            title: "실제출근시간",
        }, {
            field: "leave_time",
            title: "실제퇴근시간",

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
        }, {
            field: "agreeMin",
            template: "#=kendo.parseInt(agreeMin/60,'n0')#시간 #=agreeMin%60#분",
            title: "인정시간", 
            groupFooterTemplate:"<span class=''>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
            footerTemplate:"<span class='text_blue'>#=kendo.parseInt(sum/60)#시간 #=sum%60#분</span>",
        }],
        change: function (e){
        	gridClick(e)
        }
    }).data("kendoGrid");
	
	
}
		/* 검색버튼 기능 함수 */
		 function searchBtn() {
			debugger
			timeGridReload();	
			 gridReload();
			}
		
	</script>
		
	
	
