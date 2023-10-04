<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="nowDate" class="java.util.Date" />
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/educationManagement/privateEduRegPop.js' />"></script>		<!-- 집합교육 등록 팝업 관련 javascript -->

<div class="pop_wrap_dir" id="popUp" style="width:1000px;">
		<div class="pop_head">
			<h1>개인선택교육 이수요청</h1>
			
		</div>
		<form id="fileForm" method="post" enctype="multipart/form-data">	
		<div class="pop_con">
			<div class="com_ta" style="">
				<div class="top_box gray_box">
							
							<dl >
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육자</dt>
								<dd>
									<input type="text" id="applyEmpName" name="applyEmpName" style="width: 150px" disabled="disabled" value="${deptList.dept} ${userName } ${deptList.position }" />
									<input type="hidden" id="education_emp_seq" name="education_emp_seq" value="${userSeq }" />
									<input type="hidden" id="education_dept_seq" name="education_dept_seq" value="${deptSeq }" />
									<input type="hidden" id="education_dept_name" name="education_dept_name"	value="${deptList.dept}" /> 
									<input type="hidden" id="education_position" name="education_position" value="${deptList.position }" /> 
									<input type="hidden" id="education_duty" name="education_duty" value="${deptList.duty }" />
									<input type="hidden" id="complete_state_code_id" name="complete_state_code_id" value="EC01" />
									<input type="hidden" id="complete_state" name="complete_state" value="${finDn }" />
									<input type="hidden" id="education_id" name="education_id" value="" />
								</dd>
								<dd>
									<input type="hidden" id="education_type_code_id" name="education_type_code_id" value="ED02"/>
									<input type="hidden" id="education_type" name="education_type" value="${eduDn }" />
								</dd>								
							</dl>
							<dl class="next2">
							<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육명</dt>
								<dd>
									<input style="width:700px" type="text" id="education_name" name="education_name" />
								</dd>
								
							</dl>
							<dl class="next2">
							<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육기관</dt>
								<dd>
									<input style="width:200px" type="text" id="education_agency" name="education_agency" />
								</dd>
								
							</dl>
							<dl class="next2">
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육기간</dt>
								<dd>
									<input type="text" value="" style="text-align: ;" class="w113" name="education_start_date" id="education_start_date" onchange="" placeholder="교육시작일" />&nbsp;~&nbsp;
									<input type="text" value="" style="text-align: ;" class="w113" name="education_end_date" id="education_end_date" onchange="" placeholder="교육종료일" />
								</dd>
								
																
							</dl>
							<dl class="next2">
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 이수시간</dt>
								<dd>
									<input type="text" id="education_hour" name="education_hour" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width: 68px"/>&nbsp;시간
									
								</dd>
							</dl>
							<dl class="next2">
								<dt style="width:80px;">잔여교육비</dt>
								<dd>
									<input type="text" id="restFund" disabled="disabled" style="" value="${restFund }"/>&nbsp;원
									<input type="hidden" id="restFundVal" disabled="disabled" style="" value="${restFund }"/>
								</dd>				
								<dt style="margin-left: ;width:80px;">
								&nbsp;사용 교육비
								<!-- <input type="checkbox" id="educationCostYn" value="N"/><label for="educationCostYn"></label>&nbsp;교육비지원 -->
								<input type="hidden" id="education_cost_support_yn" name="education_cost_support_yn" style="" value=""/>
								</dt>
								<dd>
									<input type="text" id="eduCostInput" name="" class="inputNumber" style="width: 68px"/>&nbsp;원
									<input type="hidden" id="education_cost" name="education_cost" class="inputNumber"  style="width: 68px"/>									
								</dd>
								
<!-- 								<dt style="margin-left: ;width:80px;"> -->
<!-- 								&nbsp;청구금액 -->
<!-- 								</dt> -->
<!-- 								<dd> -->
<!-- 									<input type="text" id="eduCostInput2" name="" class="inputNumber" style="width: 68px"/>&nbsp;원 -->
<!-- 									<input type="hidden" id="education_ask_cost" name="education_ask_cost" class="inputNumber"  style="width: 68px"/>									 -->
<!-- 								</dd>															 -->
							</dl>
							<dl class="next2">
							<dt style="width:80px;">비고</dt>
								<dd>
									<input style="width:700px" type="text" id="remark" name="remark"/>
								</dd>
								
							</dl>
						</div>
					</div>	
					<div class="com_ta2 mt15">
						<div id="fileDiv" style="display: ;">
							
								<table>
									<colgroup>
										<col width="180"/>
										<col width=""/>	
									</colgroup>
									<tr  id="fileTr">
										<th style="font-weight: bold;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육계획서</th>
										<td id="fileTd" class="le">
											<input type="text" id="fileID1" class="file_input_textbox clear" value="" readonly="readonly" style="width:200px; text-align: center;" placeholder="파일 선택" /> 
											<input type="button" onclick="" 	value="업로드" class="file_input_button ml4 normal_btn2" /> 
											<input type="file" id="fileID" name="file_name" value="" class="hidden" onchange="getFileNm(this);" />
										</td>
									</tr>
									<tr  id="fileTr2">
										<th style="font-weight: bold;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	결과보고서 (증빙 포함)</th>
										<td id="fileTd2" class="le">
											<input type="text" id="fileID1" class="file_input_textbox clear" value="" readonly="readonly" style="width:200px; text-align: center;" placeholder="파일 선택" /> 
											<input type="button" onclick="" 	value="업로드" class="file_input_button ml4 normal_btn2" /> 
											<input type="file" id="fileID" name="education_result_file" value="" class="hidden" onchange="getFileNm(this);" />
										</td>
									</tr>
								</table>
							
						</div>
					</div>	
		</div><!-- //pop_con -->
		</form>
		<div class="pop_foot" style="margin-bottom: 20px">
			<div class="btn_cen pt12">

				<input type="button" class="blue_btn" id="fn_privateEduReg" onclick="" value="승인요청" />
			</div>
		</div>
		<!-- //pop_foot -->
	
	</div><!-- //pop_wrap -->

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
				<dt class="ar" style="width: 65px">기간</dt>
				<dd>
					<input type="text" value="${year }-01" name="" id="monthpicker"
						placeholder="" />&nbsp;~ <input type="text" value="${nowDate}" name=""
						id="monthpicker2" placeholder="" />

				</dd>
				
				<dt class="ar" style="width: 65px">신청자</dt>
				<dd>
					<input type="text" id="empName" 
						value="${userName }" style="" disabled="disabled"/>
				</dd>
			</dl>

		</div>

		<!-- 버튼 -->
		<div class="btn_div mt10 cl">

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="add" onclick="">개인선택교육 이수요청</button>
					<button type="button" id="mod" onclick="">수정</button>
					<button type="button" id="del" onclick="">삭제</button>
					<button type="button" id="" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>

		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0"></p>
			</div>

		</div>
		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

	<div class="pop_wrap_dir" id="resultEduPop" style="width:400px; display: none;">
		<div class="pop_con">
			<!-- 타이틀/버튼 -->
			<div class="btn_div mt0">
				<div class="left_div">
					<h5><span id="popupTitle"></span> 결과보고서</h5>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
					</div>
				</div>
			</div>
	<div class="com_ta" style="" id="">
		<table id="resultEduFileDiv">
		
		</table>
	</div>
	</div>
	<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" value="닫기" onclick="popCancel();"/>
			</div>
		</div><!-- //pop_foot -->
	</div>


<script type="text/javascript">
function fileList(e) {
	debugger
	var data = {
			keyId : e,	
			fileName : 'tpf_education'
	}
	$('#fileTr2').nextAll().empty();
	$.ajax({
		url: _g_contextPath_+"/common/fileList",
		dataType : 'json',
		data : data,
		type : 'POST',
		success: function(result){
			
			
			if (result.list.length > 0) {
				for (var i = 0 ; i < result.list.length ; i++) {
					
					if(i==result.list.length-1) {	
						$('#fileTr2').after(
								'<tr id="test">'+
								'<th>첨부파일 목록</th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
								'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
								'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);		
					} else {
						$('#fileTr2').after(
								'<tr id="test">'+
								'<th></th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
								'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
								'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);
					}
				}
			} else {
				$('#fileTr2').after(
					'<tr id="test">'+
					'<th>첨부파일 목록</th>'+
					'<td class="le">'+
					'<span class="mr20">'+	
					'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
					'<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이	없습니다.'+
					'</a>'+
					'</span>'+
					'</td>'+
					'</tr>'
				);
			}
			
		}
	});
	
	$.ajax({
		url: _g_contextPath_+"/educationManagement/eduResultFileList",
		dataType : 'json',
		data : data,
		type : 'POST',
		success: function(result){
			
			if (result.list.length > 0) {
				for (var i = 0 ; i < result.list.length ; i++) {
					
					if(i==result.list.length-1) {	
						$('#fileTr2').after(
								'<tr id="test">'+
								'<th>결과보고서</th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduResultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
								'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
								'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);		
					} else {
						$('#fileTr2').after(
								'<tr id="test">'+
								'<th></th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduResultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
								'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
								'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);
					}
				}
			} else {
				$('#fileTr2').after(
					'<tr id="test">'+
					'<th>결과보고서</th>'+
					'<td class="le">'+
					'<span class="mr20">'+	
					'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
					'<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이	없습니다.'+
					'</a>'+
					'</span>'+
					'</td>'+
					'</tr>'
				);
			}
			
		}
	});
	$("#popUp").data("kendoWindow").open();
}
function eduFileDown(e){
	debugger
	var row = $(e).closest("tr");
	var attach_file_id = row.find('#eduFileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			attach_file_id : row.find('#eduFileKey').val(),
			file_seq : row.find('#eduFileSeq').val()
			
	}
	
	$.ajax({
		url : _g_contextPath_+'/common/fileDown',
		type : 'GET',
		data : data,
	}).success(function(data) {
		
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_+'/common/fileDown?attach_file_id='+attach_file_id;
	});
	
}

function resultFileDown(e){
	debugger
	var row = $(e).closest("tr");
	var education_result_id = row.find('#resultEduFileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			education_result_id : row.find('#resultEduFileKey').val(),
			file_seq : row.find('#resultEduFileSeq').val()
			
	}
	
	$.ajax({
		url : _g_contextPath_+'/educationManagement/fileDown',
		type : 'GET',
		data : data,
	}).success(function(data) {
		
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_+'/educationManagement/fileDown?education_result_id='+education_result_id;
	});
	
}
$(document).ready(function() {	
	
	$('#resultEduPop').kendoWindow({
	    width: "400px",
	    title: '결과보고서 확인',
	    visible: false,
	    modal : true,
	    actions: [
	        "Close"
	    ],
	}).data("kendoWindow").center();
	
	$('#mod').on('click', function(){
		debugger
		var ch = $('.checkbox:checked');
		var data = new Array();
		var userYn = new Array();
		grid = $('#grid').data("kendoGrid");
		$.each(ch, function(i,v){
			dataItem = grid.dataItem($(v).closest("tr"));
			if ( $('#education_emp_seq').val() == dataItem.education_emp_seq ) {
				userYn.push(dataItem.education_emp_seq);
			}
		});
		if (ch.length > 0){
			if ( ch.length != userYn.length ) {
				alert('자신이 등록한 계획만 수정할 수 있습니다.');
			} else if ( ch.length > 1 ) {
				alert('하나만 체크해주세요.');
			} else {
				console.log(dataItem.education_id);
				$('#education_id').val(dataItem.education_id);
				$('#education_name').val(dataItem.education_name);
				$('#education_agency').val(dataItem.education_agency);
				$('#education_hour').val(dataItem.education_hour);
				$('#education_start_date').val(dataItem.eduStDt);
				$('#education_end_date').val(dataItem.eduEdDt);
				$('#eduCostInput').val(dataItem.education_cost);
				$('#eduCostInput').attr('disabled', true);
				$('#education_cost').val(dataItem.education_cost);
				$('#remark').val(dataItem.remark);
				fileList(dataItem.education_id);
				
			}
		} else {
			alert('수정할 목록을 체크해주세요.');
		}
		
	})
	
	$('#del').on('click', function(){
		debugger
		var ch = $('.checkbox:checked');
		var data = new Array();
		var userYn = new Array();
		grid = $('#grid').data("kendoGrid");
		$.each(ch, function(i,v){
			dataItem = grid.dataItem($(v).closest("tr"));
			if ( $('#education_emp_seq').val() == dataItem.education_emp_seq ) {
				userYn.push(dataItem.education_emp_seq);
			}
		});
		if ( ch.length != userYn.length ) {
			alert('자신이 등록한 계획만 삭제할 수 있습니다.');
		} else {
			
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_id);
				});
				debugger
				if (ch.length < 1) {
					alert('삭제할 건을 체크하세요');
				} else {
					var result = confirm('삭제하시겠습니까?');
					if (result) {
						$.ajax({
							url: _g_contextPath_+'/educationManagement/eduReqDel',
							dataType : 'text',
							data : {data : data.join(',')},
							type : 'POST',
							success : function(result){
								location.reload();
							}
						})
					} else {
						
					}
					
				}
			
		}
		
		
	})
	
	
	/* $('#education_start_date, #education_end_date').kendoDatePicker({
	
	    culture : "ko-KR",
	    format : "yyyy-MM-dd",
	});
	
	$("#education_start_date, #education_end_date").attr("readonly", true); */
	
	$('#restFund').number( true, 0 );	// 
	
	$('#eduCostInput').on('keyup', function(){
		this.value=this.value.replace(/[^0-9,]/g,'');	// 숫자만 입력가능 함수
		var eduCost = ($('#eduCostInput').val()).replace(/,/gi, "");
		$('#education_cost').val(eduCost);
		if ($('#education_cost').val() > Math.floor($('#restFundVal').val())) {
			alert('잔여교육비가 부족합니다.');
			$('#eduCostInput').val('');
			$('#education_cost').val('');
		} else {
			
		}
	});
	
	$('#eduCostInput2').on('keyup', function(){
		this.value=this.value.replace(/[^0-9,]/g,'');	// 숫자만 입력가능 함수
		var eduCost = ($('#eduCostInput2').val()).replace(/,/gi, "");
		$('#education_ask_cost').val(eduCost);
		
	});
	
	$('.top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			searchBtn();
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
	
	
	

var dataSource = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/privateEduList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.dateFr = $('#monthpicker').val();
      		data.dateTo = $('#monthpicker2').val();
      		data.education_emp_seq = $('#education_emp_seq').val();        	
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

        	  education_cost: { type: "number" },
             
       
          }
      }
    }

       
});

var currentDate = new Date();
function ct2KendoDatePicker(a, b){
	
	var startDate = $(a).kendoDatePicker({
	    culture : "ko-KR",
	    format : "yyyy-MM-dd",
	    change: startChange,
	}).attr("readonly", true).data("kendoDatePicker");

	var endDate = $(b).kendoDatePicker({
	    culture : "ko-KR",
	    format : "yyyy-MM-dd",
	}).attr("readonly", true).data("kendoDatePicker");

	function startChange(){
		if(startDate.value() > endDate.value()){
			endDate.value('');
		}
		endDate.min(startDate.value());
	}
	
}

$(function(){
	ct2KendoDatePicker($('#education_start_date'), $('#education_end_date'));
	mainGrid();
	$("#headerCheckbox").change(function(){
		debugger
		var checkedIds = {};
	    if($("#headerCheckbox").is(":checked")){
	    	$(".checkbox").prop("checked", "checked");
	    	var checked = this.checked,
	        row = $(this).closest("tr"),
	        grid = $("#grid").data("kendoGrid"),
	        dataItem = grid.dataItem(row);

	        checkedIds[dataItem.education_id] = checked;

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

function gridReload(){
	/* $('#grid').data('kendoGrid').dataSource.read(); */
	$("#grid").data("kendoGrid").dataSource.page(1);
}
function fn_workStep(row) {
	var step = row.complete_state_code_id;
	var key = row.education_person_id;
	switch (step) {
		case 'EC01' : return '<input type="checkbox" id="private'+key+'" class="k-checkbox checkbox"/><label for="private'+key+'" class="k-checkbox-label"></label>'; 
			break;
		default  : return ''; 
			break;

	}
	
}

function completeState(row) {
	var html;
	
	if ( row.complete_state_code_id == 'EC03' ) {
		html = '<span class="text_red">'+row.completeState+'</span>';
	} else if ( row.complete_state_code_id == 'EC02' ){
		html = '<span class="text_blue">'+row.completeState+'</span>';
	} else {
		html = '<span class="">'+row.completeState+'</span>';
	}
	
	
	return html;
	
}

//켄도그리드 컬럼 autoFit 함수
kendo.ui.Grid.fn.fitColumns = function(parentColumn)
{
  var grid = this;
  var columns = grid.columns;
  if(parentColumn && parentColumn.columns)
    	columns = parentColumn.columns;
  columns.forEach(function(col) {
    if(col.columns)
      	return grid.fitColumns(col);
    grid.autoFitColumn(col);
  });
  grid.expandToFit();
}//fitColumns

kendo.ui.Grid.fn.expandToFit = function()
{
					var $gridHeaderTable = this.thead.closest('table');
      var gridDataWidth = $gridHeaderTable.width();
      var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap').innerWidth();
      // Since this is called after column auto-fit, reducing size
      // of columns would overflow data.
      if (gridDataWidth >= gridWrapperWidth) {
          return;
      }

      var $headerCols = $gridHeaderTable.find('colgroup > col');
      var $tableCols = this.table.find('colgroup > col');

      var sizeFactor = (gridWrapperWidth / gridDataWidth);
      $headerCols.add($tableCols).not('.k-group-col').each(function () {
          var currentWidth = $(this).width();
          var newWidth = (currentWidth * sizeFactor);
          $(this).css({
              width: newWidth
          });
      });        
}//expandToFit

function resultFileRow(e){
	 var dataItem = $("#grid").data("kendoGrid").dataItem($(e).closest("tr"));
	 var key = dataItem.education_id;
	 $('#popupTitle').text(dataItem.education_name)
	 var data = {
				keyId : key,	
				fileName : 'tpf_education'
		}
	 $('#resultEduFileDiv').empty();
	 $.ajax({
			url: _g_contextPath_+"/common/fileList",
			dataType : 'json',
			data : data,
			type : 'POST',
			success: function(result){
				
				
				if (result.list.length > 0) {
					for (var i = 0 ; i < result.list.length ; i++) {
						
						if(i==0) {	
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th>첨부파일 목록</th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);		
						} else {
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th></th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);
						}
					}
				} else {
					$('#resultEduFileDiv').append(
						'<tr id="test">'+
						'<th>첨부파일 목록</th>'+
						'<td class="le">'+
						'<span class="mr20">'+	
						'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
						'<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이	없습니다.'+
						'</a>'+
						'</span>'+
						'</td>'+
						'</tr>'
					);
				}
				
			}
		});
	 
	 $.ajax({
			url: _g_contextPath_+"/educationManagement/eduResultFileList",
			dataType : 'json',
			data : data,
			type : 'POST',
			success: function(result){
				if (result.list.length > 0) {
					for (var i = 0 ; i < result.list.length ; i++) {
						
						if(i==0) {	
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th>결과보고서</th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="resultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
									'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);		
						} else {
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th></th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="resultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
									'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);
						}
					}
				} else {
					$('#resultEduFileDiv').append(
						'<tr id="test">'+
						'<th>결과보고서</th>'+
						'<td class="le">'+
						'<span class="mr20">'+	
						'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
						'<a href="#n" style="color: #808080" id="fileText">&nbsp;결과보고서가 없습니다.'+
						'</a>'+
						'</span>'+
						'</td>'+
						'</tr>'
					);
				}
				
			}
		});
	 $('#resultEduPop').data("kendoWindow").open();
	 
}

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        dataBound : function(e)
        {
            //console.log(this.dataSource.data());
            this.fitColumns();
            gridDataBound(e);
          },
        height: 500,
        scrollable:{
            endless: true
        },
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
            },	
        {
            	template: completeState,
            title: "상태",
            width : 110
        }, {
        	
            field: "education_name",
            title: "교육명",
           
        }, {
            field: "education_agency",
            title: "교육기관",
           
        }, {
        	
            field: "education_cost_support_yn",
            title: "교육비지원여부",
			width : 110
        }, {
            field: "complete_hour",
            title: "이수시간",
            width : 110
        }, {
            field: "education_cost",
            title: "교육비 (원)",
            format: "{0:n0}",
            width : 110
        }, {
            field: "eduStDt",
            title: "교육시작일",
            width : 120
            
        }, {
            field: "eduEdDt",
            title: "교육종료일",          
            width : 120
        }, {
            title: "결과보고서",
            template: '<input type="button" id="" class="text_blue" onclick="resultFileRow(this);" value="결과보고서">',
        }, {
            field: "return_cause",
            title: "반려사유",
        }],
        change: function (e){
        	gridClick(e)
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
		
		checkedIds[dataItem.education_id] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	function gridClick(){
		
		
	}
}

		 function searchBtn() {
			 gridReload();
			
			}
		
	</script>
	
