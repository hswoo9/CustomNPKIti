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
	
	timeGrid();
	
	mainGrid();
	
	/*
		휴일근무 - 보고서 등록 팝업(#fileUploadPop) 
	*/
	var myWindow2 = $("#fileUploadPop");
	$(document).off('click').on('click', '[value="보고서등록"]', function(){
		var row = $("#grid")
				.data("kendoGrid")
				.dataItem($(this).closest("tr"));
		var json = row.toJSON();
		myWindow2.data("kendoWindow").open();
		console.log('json', json);
		$(document).off('submit').on('submit', "[name='fileUploadFrm']", function(e){
			e.preventDefault();
			var formData = new FormData($(this).get(0));
			formData.append('apply_start_date', json.apply_start_date);
			formData.append('apply_emp_name', json.apply_emp_name);
			formData.append('target_table_name', 'after_action_report_id');
			formData.append('target_id', json.ot_work_apply_id);
			formData.append('ot_work_apply_id', json.ot_work_apply_id);
			formData.append('update_emp_seq', "${userInfo.empSeq}");
			//formData.append('update_emp_seq', "${empInfo.empSeq}");
			//formData.append('approval_status', '5');/* [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기] */
			formData.append('approval_status', '1');/* 한국문학번역원: 초과근무보고서 올리기 전에 승인절차 진행하고, 초과근무보고서는 사후에 볼 수 있도록 */
			formData.append('remark', '초과근무보고서업로드');
			$.ajax({
				url: _g_contextPath_ + '/subHoliday/holiWkApprovalUpdate',
				type: 'post',
				dataType: 'json',
				data: formData,
				contentType: false,
				processData: false,
				success: function(json){
					if(json.code === 'success'){
						//mainGridReload();
						gridReload();
						myWindow2.data("kendoWindow").close();
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
	myWindow2.kendoWindow({
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
		downWin.location.href = 'http://gw.ltikorea.or.kr/gw/cmm/file/fileDownloadProc.do?fileId=3607&fileSn=&moduleTp=board&pathSeq=500';
	});
	
	/*
		휴일근무 - 보고서 다운로드 팝업(#fileDownloadPop)
	*/
	var myWindow = $("#fileDownloadPop");
	$(document).on('click', "[value='초과근무보고서']", function(){
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
		myWindow.data("kendoWindow").open();
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
						<%-- <input type="text" value="${nowDate}" name="" id="monthpicker" placeholder="" /> --%>
						<input type="text" value="" id="startDt" class="w113"/>
						&nbsp;~&nbsp;
						<input type="text" value="" id="endDt"	class="w113" />
						
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
      		//data.date = $('#monthpicker').val().replace(/-/gi , '');
        	data.startDt = $('#startDt').val().replace(/-/gi , '');
      		data.endDt = $('#endDt').val().replace(/-/gi , '');
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
      		//data.date = $('#monthpicker').val().replace(/-/gi,"");
      		data.startDt = $('#startDt').val().replace(/-/gi , '');
      		data.endDt = $('#endDt').val().replace(/-/gi , '');
        	data.userSeq = $('#userSeq').val();
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
        	
            field: "come_dt",
            title: "실제출근시간",
        }, {
            field: "leave_dt",
            title: "실제퇴근시간",

        }, {
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
        }, {
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
        change: function (e){
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
		/* 검색버튼 기능 함수 */
		 function searchBtn() {
			debugger
			timeGridReload();	
			 gridReload();
			}
		
	</script>

<!-- 보고서 등록 팝업 -->
<div class="pop_wrap_dir" id="fileUploadPop" style="width:620px;">
	<div class="pop_head">
		<h1>파일 첨부</h1>
	</div>
	<form method="post" name="fileUploadFrm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/subHoliday/fileUpload">
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
	
