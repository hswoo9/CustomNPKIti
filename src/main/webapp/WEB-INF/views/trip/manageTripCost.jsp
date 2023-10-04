<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="com.duzon.custom.common.utiles.DJMessage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%String langCode = (session.getAttribute("langCode") == null ? "kr" : (String)session.getAttribute("langCode")).toLowerCase();%>

<script>
   	var langCode = "<%=langCode%>";
</script>

<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css2/common.css"/>
	    
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ucgridtable.1.0.js"></script>

<script type="text/javascript">	

var d = new Date();
var today;
var month = d.getMonth()+1;
var day = d.getDate();

if(month < 10){
	month = '0' + month; 
}

if(day < 10){
	day = '0' + day; 
}

today = d.getFullYear() + "-" + month + "-" + day;
	
$(document).ready(function(){
	
	// 기초데이터 초기화
	$("#mode").val("I");			// 입력구분
	$("#cost_div").val("1");		// 단가구분
	$("#newYn").val("Y");			// 전체내역보기 구분
	
	// 기준일자 달력 설정
	<% if("kr".equals(langCode)){ %>
	$(".jcalendar1").datepicker({
		dateFormat:'yy-mm-dd',
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		changeMonth:true, // 월변경가능
		changeYear:true,  // 년변경가능
		showMonthAfterYear:true // 년 뒤에 월표시
	});
	$(".jcalendar2").datepicker({
		dateFormat:'yy-mm-dd',
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		changeMonth:true, // 월변경가능
		changeYear:true,  // 년변경가능
		showMonthAfterYear:true // 년 뒤에 월표시
	});
	$(".jcalendar3").datepicker({
		dateFormat:'yy-mm-dd',
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		changeMonth:true, // 월변경가능
		changeYear:true,  // 년변경가능
		showMonthAfterYear:true // 년 뒤에 월표시
	});
	$(".jcalendar4").datepicker({
		dateFormat:'yy-mm-dd',
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		changeMonth:true, // 월변경가능
		changeYear:true,  // 년변경가능
		showMonthAfterYear:true // 년 뒤에 월표시
	});
	$(".jcalendar5").datepicker({
		dateFormat:'yy-mm-dd',
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		changeMonth:true, // 월변경가능
		changeYear:true,  // 년변경가능
		showMonthAfterYear:true // 년 뒤에 월표시
	});
	<% } %>
	
	// 입력기준일 디폴트(현재일자) 세팅	
	$("#standard_date_1").val(today);
	
	//정렬하기 버튼 클릭
	$(".align_btn").on("click",function(e){
		$(".align_sel_pop").toggle();
	});
	//정렬팝업 종료
	$(".align_sel_pop li").on("click",function(e){
		$(".align_sel_pop").hide();
	});	
	
	// 신규버튼 클릭
	$("#newButton").click(function() {
		$("#mode").val("I");
		
		$("#area_seq_" + $("#cost_div").val()).val("");
		$("#pgroup_seq_" + $("#cost_div").val()).val("");
		
		$("form").each(function() { 
			if(this.id == "regForm" + $("#cost_div").val()) this.reset();
		});
		// 입력기준일 디폴트(현재일자) 세팅	
		$("#standard_date_" + $("#cost_div").val()).val(today);
		
		// 국내외 선택버튼 활성화
		$('input:radio[id="domestic_div_s_' + $("#cost_div").val() + '"]').prop("disabled", false);
		$('input:radio[id="domestic_div_l_' + $("#cost_div").val() + '"]').prop("disabled", false);
		$('input:radio[id="domestic_div_f_' + $("#cost_div").val() + '"]').prop("disabled", false);
		
		var fileDesc = "";
		fileDesc += '&nbsp;<img src="<c:url value='/Images/ico/ico_clip02.png'/>" alt="" />';
		fileDesc += '<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이 없습니다.</a>';
		
		$("#fileDesc").html(fileDesc);
	});
	
	$("#cost_type_1").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});
	$("#cost_type_2").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});
	$("#cost_type_3").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});
	$("#cost_type_4").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});
	$("#cost_type_5").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});	
	$("#cost_type_6").selectmenu({
		change : function(event, ui) {
			f_changeCostType(this.value, "");
		}
	});	
	
	// 저장버튼 클릭
	$("#saveButton").click(function() {		
		f_save();
	});
	
	// 저장버튼 클릭
	$("#deleteButton").click(function() {		
		f_delete();
	});		
	
	$("#searchButton").click(function() {		
		f_reload();
	});
	
	$("input[name=searchWord1]").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	f_reload();
        }
    });
	
	$("input[name=searchWord2]").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	f_reload();
        }
    });
	
	$(".file_input_button").on("click",function(){
		$(this).next().click();
	});
	
	$("#selectArea1").hide();
	$("#selectArea2").hide();
	
// 	f_reload();
});

function delCostFile(costSeq, groupSeq, compSeq, domesticDiv, costDiv) {
	if(confirm("파일을 삭제하시겠습니까?")){
		var data = {
			costSeq     : costSeq,
			groupSeq    : groupSeq,
			compSeq     : compSeq,
			domesticDiv : domesticDiv,
			costDiv     : costDiv
		}
		
		$.ajax({
			url:'${pageContext.request.contextPath}/Views/Common/pop/delCostFile',
			data : data,
			async : false,
			type : 'POST',
			success : function(result) {
				alert("파일삭제가 완료되었습니다.");
				
				var fileDesc = "&nbsp;<img src=\"<c:url value='/Images/ico/ico_clip02.png'/>\" />";
				fileDesc = fileDesc + '<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이 없습니다.</a>';
				
				$("#fileDesc").html(fileDesc);
			},
			error : function(error) {
				alert("파일삭제가 실패하였습니다.");
				console.log(error);
			}
		});
	}
};

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

function getFileNm(e) {
		
		var index = $(e).val().lastIndexOf('\\') + 1;
		var valLength = $(e).val().length;
		var row = $(e).closest('tr');
		var fileNm = $(e).val().substr(index, valLength);
		row.find('#fileID1').val(fileNm);
		row.find('#fileText').text(fileNm).css({'color':'#0033FF','margin-left':'5px'});
	}

function f_changeCostType(val, orgVal){
	if(val == 'R'){
		$("#cost_" + $("#cost_div").val()).val("-");
		$("#cost_" + $("#cost_div").val()).attr("disabled", true);
	}else{
		$("#cost_" + $("#cost_div").val()).val(orgVal);
		$("#cost_" + $("#cost_div").val()).attr("disabled", false);
	}
}

//출장비단가 저장
function f_save(){
	
	var saveUrl = "";

	$("#domestic_div").val($(":input:radio[name=domestic_div_" + $("#cost_div").val() + "]:checked").val());	
	$("#area_seq").val($("#area_seq_" + $("#cost_div").val()).val());
	$("#pgroup_seq").val($("#pgroup_seq_" + $("#cost_div").val()).val());
	$("#standard_date").val($("#standard_date_" + $("#cost_div").val()).val());
	$("#cost").val($("#cost_" + $("#cost_div").val()).val());
	$("#cost_type").val($("#cost_type_" + $("#cost_div").val()).val());
	$("#note").val($("#note_" + $("#cost_div").val()).val());
	
	if (!(($("#domestic_div").val() == "S" || $("#domestic_div").val() == "L") && ($("#cost_div").val() == "1" || $("#cost_div").val() == "2"))) {
		if($.trim($("#area_seq").val()) == ""){
			alert("<%=DJMessage.getMessage("TX000020676","출장지구분을 선택해주세요.", langCode)%>");
			$("#areaname_" + $("#cost_div").val()).focus();
			return;
		}
	}
	
	if ($("#cost_div").val() == "3") {
		$("#cost_type").val("M");
	}
	
	if($.trim($("#pgroup_seq").val()) == ""){
		alert("<%=DJMessage.getMessage("TX000020771","직책그룹을 선택해주세요.", langCode)%>");
		$("#pgroupname_" + $("#cost_div").val()).focus();
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000004920","입력한 내용으로 저장하시겠습니까?", langCode)%>")){
		if($("#mode").val() == "I"){
			saveUrl = '${pageContext.request.contextPath}/trip/insertTripCost';
		}else if($("#mode").val() == "U"){
			saveUrl = '${pageContext.request.contextPath}/trip/updateTripCost';
		}
		
		var formData = new FormData();
	    formData.append('uploadFile',   $('#fileID')[0].files[0]);
	    formData.append('costDiv',      $("#cost_div").val());
	    formData.append('domesticDiv',  $("#domestic_div").val());
	    formData.append('areaSeq',      $("#area_seq").val());
	    formData.append('pgroupSeq',    $("#pgroup_seq").val());
	    formData.append('standardDate', $("#standard_date").val());
	    formData.append('cost',         $("#cost").val());
	    formData.append('costType',     $("#cost_type").val());
	    formData.append('note',         $("#note").val());
	    formData.append('costSeq',      $("#cost_seq").val());
		
		$.ajax({
			url: saveUrl,
			data : formData,
			type : 'POST',
			processData : false,
	        contentType : false,
			success: function(e) {
				if (e.success) {
					alert("<%=DJMessage.getMessage("TX000002544","저장 되었습니다.", langCode)%>");
					f_reload();
					$("#mode").val("I");
					
					$("form").each(function() {  
						if(this.id == "regForm" + $("#cost_div").val()){
							this.reset(); 
							$("input[type=hidden]", this).val("");
						}
					});
					
					// 입력기준일 디폴트(현재일자) 세팅	
					$("#standard_date_" + $("#cost_div").val()).val(today);
				}
				else {
					if (e.isApply) {
						alert("<%=DJMessage.getMessage("TX000020772","동일 직책그룹, 출장지는 전과 동일한 기준일 등록이 불가합니다.", langCode)%>");
					}
					else {
						alert("<%=DJMessage.getMessage("TX000012787","저장을 실패하였습니다.", langCode)%>");
					}
				}
			},
			error : function(error) {
				alert("저장에 실패하였습니다.");
				console.log(error);
			}
		});
	}
}

//출장지 삭제
function f_delete(){
	if($("#cost_seq").val() == ""){
		alert("<%=DJMessage.getMessage("TX000006888","삭제할 데이터를 선택해주세요.", langCode)%>");
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000012275","삭제하시겠습니까?", langCode)%>")){
		$.ajax({
			type: 'POST',
			url:'${pageContext.request.contextPath}/trip/deleteTripCost',
			data:{
					"costDiv":$("#cost_div").val()
					,"costSeq":$("#cost_seq").val()
				},
			success: function(e){
				if(e){
					alert("<%=DJMessage.getMessage("TX000012947","데이터가 삭제 되었습니다.", langCode)%>");
					// 목록 reload
					f_reload();
					$("#mode").val("I");
					
					$("form").each(function() {  
						if(this.id == "regForm" + $("#cost_div").val()) this.reset();  
					});		
				}else{
					alert("<%=DJMessage.getMessage("TX000002106","삭제에 실패하였습니다.", langCode)%>");											
				}
			}
		});
	}	
}

//그리드 리로드
function f_reload(){
	
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripCostList',
		data:{
			"costDiv":$("#cost_div").val()
			,"searchWord1":$("#searchWord1").val()
			,"searchWord2":$("#searchWord2").val()
			,"searchOpt":$("#searchOpt").val()
			,"newYn":$("#newYn").val()	
			,"sortType":$("#sortType").val()
		},
		success: function(e){
			f_setGrid(e.tripCostList);
		}
	});
}

//그리드 Row 선택
function f_select(costSeq){

	$("#cost_seq").val(costSeq);	// 현재 선택한 출장비단가 시퀀스 저장
	$("#mode").val("U");;			// 업데이트 모드로 변경
	
	// 선택한 출장단가 상세정보 로드
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripCostDetail',
		data:{
				"costDiv":$("#cost_div").val()
				,"costSeq":$("#cost_seq").val()
			},
		success: function(e){
			// 로딩한 상세정보 출력
			f_select_callback(e);			
		}
	});	
}

function f_select_callback(result){
	
	if(result.domesticDiv == "S"){
		$('input:radio[id="domestic_div_s_' + $("#cost_div").val() + '"]').prop("checked", true);
	}
	
	if(result.domesticDiv == "L"){
		$('input:radio[id="domestic_div_l_' + $("#cost_div").val() + '"]').prop("checked", true);
	}
	
	if(result.domesticDiv == "F"){
		$('input:radio[id="domestic_div_f_' + $("#cost_div").val() + '"]').prop("checked", true);
	}
	
	$("#areaname_" + $("#cost_div").val()).val(result.areanameKr);
	$("#area_seq_" + $("#cost_div").val()).val(result.areaSeq);
	$("#pgroupname_" + $("#cost_div").val()).val(result.pgroupnameKr);
	$("#pgroup_seq_" + $("#cost_div").val()).val(result.pgroupSeq);
	$("#standard_date_" + $("#cost_div").val()).val(result.standardDate);
	$("#cost_" + $("#cost_div").val()).val(result.cost);
	$("#cost_type_" + $("#cost_div").val()).val(result.costType);
	$("#note_" + $("#cost_div").val()).val(result.note);
	
	$("#cost_type_" + $("#cost_div").val()).val(result.costType).prop("selected", true);
	$("#cost_type_" + $("#cost_div").val()).selectmenu("refresh");
	f_changeCostType(result.costType, result.cost);
	
	var fileDesc = "";
	if (result.attchFile == '' || result.attchFile === undefined) {
		fileDesc += '&nbsp;<img src="<c:url value='/Images/ico/ico_clip02.png'/>" alt="" />';
		fileDesc += '<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이 없습니다.</a>';
	}
	else {
		fileDesc += '&nbsp;<a href="${pageContext.request.contextPath}/Views/Common/pop/getTripCostFile?costSeq=' + result.costSeq + '&groupSeq=' + result.groupSeq + '&compSeq=' + result.compSeq + '&domesticDiv=' + result.domesticDiv + '&costDiv=' + result.costDiv + '" style="color: #808080">' + result.attchFile + '</a>';
		fileDesc += '&nbsp;<a href="javascript:delCostFile(\'' + result.costSeq + '\', \'' + result.groupSeq + '\', \'' + result.compSeq + '\', \'' + result.domesticDiv + '\', \'' + result.costDiv + '\');" style="color: #808080"><img src="<c:url value='/Images/btn/btn_del_reply.gif'/>" alt="" /></a>';
	}
	$("#fileDesc").html(fileDesc);
	
}

function f_setGrid(dataList){
	
	// 그리드 초기화(기존 데이터 삭제)	
	$("#divTestArea_" + $("#cost_div").val() + "").html("");
	$(".gt_paging").remove();
	
	if ($("#cost_div").val() == "3") {
		$("#divTestArea_" + $("#cost_div").val() + "").GridTable({
	        'tTablename': 'tableName_' + $("#cost_div").val()      // 자동 생성될 테이블 네임
	        , 'nHeight':'470'
	        , 'nTableType': '1'            // 테이블 타입
	        , 'oPage': {                   // 사용자 페이징 정보
	            'bPageOff': false          // 페이징 기능 사용여부
	            , 'nItemSize': 10          // 페이지별 아이템 갯수
	        }                
	        , 'oDetail': {                 // type 2 상세 페이지 정보
	            'bDetailOff': true         // 상세 페이지 사용여부
	        }
	        , 'oNoData': {                          //  데이터가 존재하지 않는 경우 
	        	'tText': '<%=DJMessage.getMessage("TX000017974","데이터가 존재하지 않습니다.", langCode)%>'      //  출력 텍스트 설정
	             //, 'tStyle': 'background:red;'      //  적용 스타일 설정
			}
	        , "data": dataList,
	        "aoHeaderInfo": [{
	            no: '0',
	            renderValue: function () {
	                return "no";
	            },
	            colgroup: '34'
	        }, {
	            no: '1',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000020680","국내외", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '2',
	            renderValue: function () {
	                return '<%=DJMessage.getMessage("TX000004662","출장지", langCode)%>';
	            },
	            colgroup: ''
	        }, {
	            no: '3',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '4',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000004252","기준일", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '5',
	            renderValue: function () {
	                return "상한액";
	            },
	            colgroup: ''
	        }],
	
	        "aoDataRender": [{
	            no: '0',           	
	            render: function (idx, item) {
	                // can use idx, item 
	                return idx+1;
	            },
	            height: '25'
	        }, {
	            no: '1',
	            render: function (idx, item) {
	            	if(item.domesticDiv == 'S'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>근무지내</a>";            		
	            	}
	            	
	            	if(item.domesticDiv == 'L'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>근무지외</a>";            		
	            	}
	            	
	            	if(item.domesticDiv == 'F'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')><%=DJMessage.getMessage("TX000020684","국외", langCode)%></a>";
	            	}            	
	            },        
	            height: '25'
	        }, {
	            no: '2',
	            render: function (idx, item) {
	            	return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.areanameKr+"</a>";            	
	            },
	            width: '',
	            height: '25',
	            style: 'margin-left:5px'
	        }, {
	            no: '3',
	            render: function (idx, item) {
	            	return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.pgroupnameKr+"</a>";
	            },
	            height: '25'
	        }, {
	            no: '4',
	            render: function (idx, item) {
	            	if(item.newYn == "Y"){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+"<span class='bul'>"+item.standardDate+"</span>"+"</a>";
	            	}else{
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.standardDate+"</a>";
	            	}
	            },
	            height: '25'
	        }, {
	            no: '5',
	            render: function (idx, item) {
            		return item.cost;
	            },
	            height: '25',
	        	align: 'right'
	        	//style: 'padding-right:10px'
	        }]
	        , "fnRowCallBack": function (row, aData) {
	        	$(row).click(function (){
	                //console.log(oData.user_nm + ' 선택 !!!');
	                f_select(aData.costSeq);
	            });    	
	        }
	    	, "tableOption": "testTable"
	    });
	}
	else {
		$("#divTestArea_" + $("#cost_div").val() + "").GridTable({
	        'tTablename': 'tableName_' + $("#cost_div").val()      // 자동 생성될 테이블 네임
	        , 'nHeight':'470'
	        , 'nTableType': '1'            // 테이블 타입
	        , 'oPage': {                   // 사용자 페이징 정보
	            'bPageOff': false          // 페이징 기능 사용여부
	            , 'nItemSize': 10          // 페이지별 아이템 갯수
	        }                
	        , 'oDetail': {                 // type 2 상세 페이지 정보
	            'bDetailOff': true         // 상세 페이지 사용여부
	        }
	        , 'oNoData': {                          //  데이터가 존재하지 않는 경우 
	        	'tText': '<%=DJMessage.getMessage("TX000017974","데이터가 존재하지 않습니다.", langCode)%>'      //  출력 텍스트 설정
	             //, 'tStyle': 'background:red;'      //  적용 스타일 설정
			}
	        , "data": dataList,
	        "aoHeaderInfo": [{
	            no: '0',
	            renderValue: function () {
	                return "no";
	            },
	            colgroup: '34'
	        }, {
	            no: '1',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000020680","국내외", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '2',
	            renderValue: function () {
	                return '<%=DJMessage.getMessage("TX000004662","출장지", langCode)%>';
	            },
	            colgroup: ''
	        }, {
	            no: '3',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '4',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000004252","기준일", langCode)%>";
	            },
	            colgroup: ''
	        }, {
	            no: '5',
	            renderValue: function () {
	                return "<%=DJMessage.getMessage("TX000000468","단가", langCode)%>";
	            },
	            colgroup: ''
	        }],
	
	        "aoDataRender": [{
	            no: '0',           	
	            render: function (idx, item) {
	                // can use idx, item 
	                return idx+1;
	            },
	            height: '25'
	        }, {
	            no: '1',
	            render: function (idx, item) {
	            	if(item.domesticDiv == 'S'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>근무지내</a>";            		
	            	}
	            	
	            	if(item.domesticDiv == 'L'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>근무지외</a>";            		
	            	}
	            	
	            	if(item.domesticDiv == 'F'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')><%=DJMessage.getMessage("TX000020684","국외", langCode)%></a>";
	            	}            	
	            },        
	            height: '25'
	        }, {
	            no: '2',
	            render: function (idx, item) {
	            	if ((item.domesticDiv == 'S' || item.domesticDiv == 'L') && ($("#cost_div").val() == "1" || $("#cost_div").val() == "2")) {
		            	return "";
	            	}
	            	else {
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.areanameKr+"</a>";
	            	}
	            },
	            width: '',
	            height: '25',
	            style: 'margin-left:5px'
	        }, {
	            no: '3',
	            render: function (idx, item) {
	            	return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.pgroupnameKr+"</a>";
	            },
	            height: '25'
	        }, {
	            no: '4',
	            render: function (idx, item) {
	            	if(item.newYn == "Y"){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+"<span class='bul'>"+item.standardDate+"</span>"+"</a>";
	            	}else{
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.standardDate+"</a>";
	            	}
	            },
	            height: '25'
	        }, {
	            no: '5',
	            render: function (idx, item) {
	            	if(item.costType == 'M'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>("+item.cost+")</a>";
	            	}else if(item.costType == 'R'){
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>-</a>";
	            	}else{
	            		return "<a href=javascript:f_select('"+item.costSeq+"')>"+item.cost+"</a>";            		
	            	}            	
	            },
	            height: '25',
	        	align: 'right'
	        	//style: 'padding-right:10px'
	        }]
	        , "fnRowCallBack": function (row, aData) {
	        	$(row).click(function (){
	                //console.log(oData.user_nm + ' 선택 !!!');
	                f_select(aData.costSeq);
	            });    	
	        }
	    	, "tableOption": "testTable"
	    });
	}
}

// 달력이미지 클릭시에도 달력 나타나도록 설정
function f_cal(type){
	if(type == '1') $(".jcalendar1").datepicker("show");
	if(type == '2') $(".jcalendar2").datepicker("show");
	if(type == '3') $(".jcalendar3").datepicker("show");
	if(type == '4') $(".jcalendar4").datepicker("show");
	if(type == '5') $(".jcalendar5").datepicker("show");
}

// 정렬방식 변경
function f_sort(sortType){
	// 1:기준일순, 2:직급그룹순, 3:출장지순
	if(sortType == '1') $("#sortName_" + $("#cost_div").val()).html("<%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%>"); 
	if(sortType == '2') $("#sortName_" + $("#cost_div").val()).html("<%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%>");
	if(sortType == '3') $("#sortName_" + $("#cost_div").val()).html("<%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%>");
	if(sortType == '4') $("#sortName_" + $("#cost_div").val()).html("국내외순");
	
	//정렬 적용한 검색 실행
	$("#sortType").val(sortType);
	f_reload();
}

// 출장지 팝업
function f_areaPop(){
	var width = 650 ;
	var height = 560;	
	var windowX = Math.ceil( (window.screen.width  - width) / 2 );
	var windowY = Math.ceil( (window.screen.height - height) / 2 );
	var strScroll = 0;
	var strResize = 0;
	var location = 0;
	
	var domesticDiv = $(":input:radio[name=domestic_div_" + $("#cost_div").val() + "]:checked").val();
	var localYn = "N";
	
	if (domesticDiv == "S") {
		domesticDiv = "L";
		localYn = "Y";
	}
	
	var costDiv = $("#cost_div").val();
	var url = "${pageContext.request.contextPath}/trip/pop/tripAreaPop?domesticDiv="+domesticDiv+"&costDiv="+costDiv+"&localYn="+localYn;
	pop = window.open(url, "searchWindow", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize+", location="+ location);
	try {pop.focus(); } catch(e){}
	return pop;
}

// 직급그룹 팝업
function f_pgroupPop(){
	var width = 650 ;
	var height = 560;	
	var windowX = Math.ceil( (window.screen.width  - width) / 2 );
	var windowY = Math.ceil( (window.screen.height - height) / 2 );
	var strScroll = 0;
	var strResize = 0;
	var location = 0;
	
	var domesticDiv = $(":input:radio[name=domestic_div_" + $("#cost_div").val() + "]:checked").val();
	
	if (domesticDiv == "S") {
		domesticDiv = "L";
	}
	
	var costDiv = $("#cost_div").val();
	var url = "${pageContext.request.contextPath}/trip/pop/tripPositionGroupPop?domesticDiv="+domesticDiv+"&costDiv="+costDiv;
	pop = window.open(url, "searchWindow", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize+", location="+ location);
	try {pop.focus(); } catch(e){}
	return pop;
}

// 국내외구분 변경시 히든값 변경(팝업에 사용)
function f_changeDomestic(domesticDiv){
	$("#domestic_div").val(domesticDiv);
	$("#area_seq_" + $("#cost_div").val()).val("");
	$("#areaname_" + $("#cost_div").val()).val("");
	$("#pgroup_seq_" + $("#cost_div").val()).val("");
	$("#pgroupname_" + $("#cost_div").val()).val("");
	
	if ((domesticDiv == "S" || domesticDiv == "L") && ($("#cost_div").val() == "1" || $("#cost_div").val() == "2")) {
		$("#selectArea" + $("#cost_div").val()).hide();
	}
	else {
		$("#selectArea" + $("#cost_div").val()).show();
	}
}

function f_checkAll(){
	if($(":input:checkbox[name=checkAll_" + $("#cost_div").val() + "]:checked").val() == "N"){
		$("#newYn").val("N");		
	}else{
		$("#newYn").val("Y");
	}
	f_reload();
}

//탭
function tab_nor_Fn(num){
	
	if(!num){
		num = 1;
	}
	
	if($("#cost_div").val() != num){
		$("#cost_seq").val("");			// 탭 이동시 선택했던 단가 시퀀스 초기화
		$("#newYn").val("Y");			// 탭 이동시 선택했던 전체내역보기 초기화
		$("#checkAll_" + $("#cost_div").val()).attr("checked", false);		
	}
				
	$("#cost_div").val(num);	
	$("#cost_seq").val("");
	$("#mode").val("I");
	
	//입력폼 초기화
	$("#area_seq_" + $("#cost_div").val()).val("");
	$("#pgroup_seq_" + $("#cost_div").val()).val("");
	
	$("form").each(function() { 
		if(this.id == "regForm" + $("#cost_div").val()) this.reset();
	});
	
	$("#standard_date_" + num).val(today);
	f_changeCostType("N", "");
	$(".tab"+num).show();
	$(".tab"+num).siblings().hide();
	
	var inx = num -1

	$(".tab_nor li").eq(inx).addClass("on");
	$(".tab_nor li").eq(inx).siblings().removeClass("on");
	
	f_reload();
}

</script> 
</head>
<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1000px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="location_info">
			 <ul>
			 </ul>
		</div>
		<div class="title_div">
			<h4><%=DJMessage.getMessage("TX000020667","출장비단가관리", langCode)%></h4>
		</div>	
	</div>
	
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt class="ar" style="width:71px;"><%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></dt>
			<dd><input type="text" name="searchWord1" id="searchWord1" style="width:110px;" /></dd>
			<dt><%=DJMessage.getMessage("TX000020680","국내외", langCode)%></dt>
			<dd>
				<select id="searchOpt" class="selectmenu" style="width:76px;">
					<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
					<option value="S">근무지내</option>
					<option value="L">근무지외</option>
					<option value="F"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></option>
				</select>
			</dd>
			<dt><%=DJMessage.getMessage("TX000004662","출장지", langCode)%></dt>
			<dd><input type="text" name="searchWord2" id="searchWord2" style="width:138px;" /></dd>
			<dd><input type="button" id="searchButton" value="<%=DJMessage.getMessage("TX000001289","검색", langCode)%>" /></dd>
		</dl>
	</div>
	
	
	<div class="sub_contents_wrap">
		<div class="posi_re mt20">
			<div class="tab_nor">
				<ul>
					<li class="mW100 ac on"><a href="javascript:tab_nor_Fn(1);"><%=DJMessage.getMessage("TX000009875","일비", langCode)%></a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(2)"><%=DJMessage.getMessage("TX000009874","식비", langCode)%></a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(3)"><%=DJMessage.getMessage("TX000004675","숙박비", langCode)%></a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(4)"><%=DJMessage.getMessage("TX000004677","교통비", langCode)%></a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(5)"><%=DJMessage.getMessage("TX000020685","기타여비", langCode)%>1</a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(6)"><%=DJMessage.getMessage("TX000020685","기타여비", langCode)%>2</a></li>
				</ul>
			</div>
			
			<div class="posi_ab" style="top:0;right:0;">
				<div id="" class="controll_btn p0">
					<button id="newButton">신규</button>
					<button id="saveButton"><%=DJMessage.getMessage("TX000001256","저장", langCode)%></button>
					<button id="deleteButton"><%=DJMessage.getMessage("TX000005668","삭제", langCode)%></button>
				</div>
			</div>
		</div>
		
		<div class="tab_area">
			<!-- 일비 탭 -->
			<div class="tab1">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_1" id="checkAll_1" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_1"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_1" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_1"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm1" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_1" id="domestic_div_s_1" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_1">근무지내</label>
													<input type="radio" name="domestic_div_1" id="domestic_div_l_1" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_1">근무지외</label>
													<input type="radio" name="domestic_div_1" id="domestic_div_f_1" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_1"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr id="selectArea1">
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_1" id="areaname_1" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_1" id="area_seq_1" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_1" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_1" id="pgroupname_1" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_1" id="pgroup_seq_1" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_1" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_1" id="standard_date_1" class="w113 jcalendar1" readonly />
														<a href="javascript:f_cal('1');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000000468","단가", langCode)%></th>
												<td>
													<input type="text" name="cost_1" id="cost_1" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> <%=DJMessage.getMessage("TX000000626","원", langCode)%>
													<select name="cost_type_1" id="cost_type_1" class="selectmenu" style="width:110px;">
														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option>
														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option>
														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option>
													</select>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_1" id="note_1" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 식비 탭 -->
			<div class="tab2" style="display:none;">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_2" id="checkAll_2" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_2"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_2" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_2"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm2" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_2" id="domestic_div_s_2" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_2">근무지내</label>
													<input type="radio" name="domestic_div_2" id="domestic_div_l_2" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_2">근무지외</label>
													<input type="radio" name="domestic_div_2" id="domestic_div_f_2" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_2"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr id="selectArea2">
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_2" id="areaname_2" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_2" id="area_seq_2" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_2" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_2" id="pgroupname_2" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_2" id="pgroup_seq_2" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_2" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_2" id="standard_date_2" class="w113 jcalendar2" readonly />
														<a href="javascript:f_cal('2');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000000468","단가", langCode)%></th>
												<td>
													<input type="text" name="cost_2" id="cost_2" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> 원
													<select name="cost_type_2" id="cost_type_2" class="selectmenu" style="width:110px;">
														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option>
														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option>
														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option>
													</select>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_2" id="note_2" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 숙박비 탭 -->
			<div class="tab3" style="display:none;">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_3" id="checkAll_3" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_3"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_3" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_3"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm3" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_3" id="domestic_div_s_3" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_3">근무지내</label>
													<input type="radio" name="domestic_div_3" id="domestic_div_l_3" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_3">근무지외</label>
													<input type="radio" name="domestic_div_3" id="domestic_div_f_3" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_3"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_3" id="areaname_3" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_3" id="area_seq_3" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_3" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_3" id="pgroupname_3" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_3" id="pgroup_seq_3" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_3" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_3" id="standard_date_3" class="w113 jcalendar3" readonly />
														<a href="javascript:f_cal('3');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th>상한액</th>
												<td>
													<input type="text" name="cost_3" id="cost_3" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> 원
<!-- 													<select name="cost_type_3" id="cost_type_3" class="selectmenu" style="width:110px;"> -->
<%-- 														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option> --%>
<%-- 														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option> --%>
<%-- 														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option> --%>
<!-- 													</select> -->
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_3" id="note_3" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 교통비 탭 -->
			<div class="tab4" style="display:none;">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_4" id="checkAll_4" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_4"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_4" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_4"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm4" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_4" id="domestic_div_s_4" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_4">근무지내</label>
													<input type="radio" name="domestic_div_4" id="domestic_div_l_4" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_4">근무지외</label>
													<input type="radio" name="domestic_div_4" id="domestic_div_f_4" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_4"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_4" id="areaname_4" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_4" id="area_seq_4" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_4" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_4" id="pgroupname_4" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_4" id="pgroup_seq_4" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_4" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_4" id="standard_date_4" class="w113 jcalendar4" readonly />
														<a href="javascript:f_cal('4');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000000468","단가", langCode)%></th>
												<td>
													<input type="text" name="cost_4" id="cost_4" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> 원
													<select name="cost_type_4" id="cost_type_4" class="selectmenu" style="width:110px;">
														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option>
														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option>
														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option>
													</select>
												</td>
											</tr>
											<tr>
												<th>교통비운임표</th>
												<td>
													<input type="text" id="fileID1" class="file_input_textbox clear" value="" readonly="readonly" style="" placeholder="파일 선택" /> 
													<input type="button" onclick="" value="업로드" class="file_input_button ml4 normal_btn2" />
													<input type="file" id="fileID" name="file_name" value="" class="hidden" onchange="getFileNm(this);" />
													<span class="mr20" id="fileDesc">
													</span>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_4" id="note_4" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 기타여비1 탭 -->
			<div class="tab5" style="display:none;">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_5" id="checkAll_5" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_5"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_5" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_5"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm5" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_5" id="domestic_div_s_5" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_5">근무지내</label>
													<input type="radio" name="domestic_div_5" id="domestic_div_l_5" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_5">근무지외</label>
													<input type="radio" name="domestic_div_5" id="domestic_div_f_5" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_5"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_5" id="areaname_5" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_5" id="area_seq_5" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_5" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_5" id="pgroupname_5" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_5" id="pgroup_seq_5" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_5" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_5" id="standard_date_5" class="w113 jcalendar5" readonly />
														<a href="javascript:f_cal('5');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000000468","단가", langCode)%></th>
												<td>
													<input type="text" name="cost_5" id="cost_5" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> 원
													<select name="cost_type_5" id="cost_type_5" class="selectmenu" style="width:110px;">
														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option>
														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option>
														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option>
													</select>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_5" id="note_5" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!-- 기타여비2 탭 -->
			<div class="tab6" style="display:none;">
				<div class="twinbox mt10">
					<table>
						<colgroup>
							<col />
							<col width="35%"/>
						</colgroup>
						<tr>
							<td class="twinbox_td posi_re">
								<div class="btn_div mt0">
									<div class="left_div">							
										<h5 class="fl"><%=DJMessage.getMessage("TX000020686","단가목록", langCode)%></h5>
										<p class="fl mt3"><input type="checkbox" name="checkAll_6" id="checkAll_6" value="N" onclick="f_checkAll();" /> <span class="mt2 dp_ib"><label for="checkAll_6"><%=DJMessage.getMessage("TX000020687","전체내역 보기", langCode)%></label></span></span></p>
									</div>
									<div class="right_div">
										<div id="" class="controll_btn p0">
											<button type="button" id="sortName_6" class="align_btn"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></button>
										</div>
									</div>
								</div>
								
								<div id="divTestArea_6"></div>
								
								<!-- 정렬팝업 -->
							    <div id="" class="align_sel_pop posi_ab" style="display:none;">
							    	<ul>
										<li><a href="javascript:f_sort(1);"><%=DJMessage.getMessage("TX000020681","기준일 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(2);"><%=DJMessage.getMessage("TX000020769","직책그룹 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(3);"><%=DJMessage.getMessage("TX000020683","출장지 순", langCode)%></a></li>
							    		<li><a href="javascript:f_sort(4);">국내외 순</a></li>
							    	</ul>
							    </div>
							</td>
							<!-- 상세내역 -->
							<td class="twinbox_td" style="min-width:350px;">
								<p class="tit_p fl mt5"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm6" method="post">
										<table>
											<colgroup>
												<col width="120"/>
												<col width=""/>
											</colgroup>
											<tr>
												<th><%=DJMessage.getMessage("TX000005254","국내외구분", langCode)%></th>
												<td><input type="radio" name="domestic_div_6" id="domestic_div_s_6" value="S" onchange="f_changeDomestic('S')" class="" checked="">
													<label for="domestic_div_s_6">근무지내</label>
													<input type="radio" name="domestic_div_6" id="domestic_div_l_6" value="L" onchange="f_changeDomestic('L')" class="">
													<label for="domestic_div_l_6">근무지외</label>
													<input type="radio" name="domestic_div_6" id="domestic_div_f_6" value="F" onchange="f_changeDomestic('F')" class="ml10">
													<label for="domestic_div_f_6"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020688","출장지구분", langCode)%></th>
												<td>
													<input type="text" name="areaname_6" id="areaname_6" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="area_seq_6" id="area_seq_6" />
													<div id="" class="controll_btn p0">
														<button id="areaPopButton_6" type="button" onclick="f_areaPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020764","직책그룹", langCode)%></th>
												<td>
													<input type="text" name="pgroupname_6" id="pgroupname_6" value="" style="width:113px;" readonly="" />
													<input type="hidden" name="pgroup_seq_6" id="pgroup_seq_6" />
													<div id="" class="controll_btn p0">
														<button id="pgroupPopButton_6" type="button" onclick="f_pgroupPop();"><%=DJMessage.getMessage("TX000019777","선택", langCode)%></button>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000004252","기준일", langCode)%></th>
												<td>
													<div class="dal_div">
														<input type="text" name="standard_date_6" id="standard_date_6" class="w113 jcalendar5" readonly />
														<a href="javascript:f_cal('5');" class="button_dal"></a>
													</div>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000000468","단가", langCode)%></th>
												<td>
													<input type="text" name="cost_6" id="cost_6" value="" class="ar pr5" style="width:31%;" onkeydown="onlyNumber(this)" /> 원
													<select name="cost_type_6" id="cost_type_6" class="selectmenu" style="width:110px;">
														<option value="N" selected="selected"><%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%></option>
														<option value="R"><%=DJMessage.getMessage("TX000020690","실비적용", langCode)%></option>
														<option value="M"><%=DJMessage.getMessage("TX000020691","금액수정가능", langCode)%></option>
													</select>
												</td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td><input type="text" name="note_6" id="note_6" value="" style="width:98%;"></td>
											</tr>
										</table>
									</form>
								</div>
								
								<div class="text_blue mt10 f11 lh16">- <%=DJMessage.getMessage("TX000020689","단가 고정금액", langCode)%> : <%=DJMessage.getMessage("TX000020692","입력한 단가 금액 적용되며 사용자 수정 불가", langCode)%>(ex, 1000)<br />- <%=DJMessage.getMessage("TX000020690","실비적용", langCode)%> : <%=DJMessage.getMessage("TX000020693","출장 신청 시 0원 적용되며 사용자 금액 직접 입력 가능", langCode)%>(ex, '-')<br />- 금액수정가능 : <%=DJMessage.getMessage("TX000020694","입력한 단가 금액 정용되며 사용자 수정 가능", langCode)%> (ex, (1,000))</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->
<form id="regForm" method="post">
	<input type="hidden" id="pgroup_seq" name="pgroup_seq" />
	<input type="hidden" id="area_seq" name="area_seq" />
	<input type="hidden" id="standard_date" name="standard_date" />
	<input type="hidden" id="cost" name="cost" />	
	<input type="hidden" id="cost_type" name="cost_type" />
	<input type="hidden" id="note" name="note" />	
	<input type="hidden" id="mode" name="mode" value="I" />
	<input type="hidden" id="domestic_div" name="domestic_div" />
	<input type="hidden" id="cost_div" name="cost_div" value="1" />
	<input type="hidden" id="cost_seq" name="cost_seq" />
	<input type="hidden" id="newYn" name="newYn" value="Y" />
	<input type="hidden" id="sortType" name="sortType" />
</form>