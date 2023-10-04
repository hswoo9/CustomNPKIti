<!-- /**
 * 메뉴명:결재작성>결재양식>근태신청서>연차사용
 * jsp명:typeAnnv2.jsp
 * 작성자:김동영
 * 생성일자:2016.09.22.
 * 수정일자:2019.12.13.
 * 비고: 전자결재 연동
 *        연차고도화 연차환경설정에 따른 마이너스 연차 사용 적용 2018.12 Jun Park
 * 최신 수정 내역 : inter값 부서, 이름, 신청시간 및 한글코드값 신청시간 추가
 * [2019-12-13] 전자결재 상신시 selectSql 파라미터 server로 변경 YoungMin Bang
 */
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="main.web.BizboxAMessage" %> 

<!DOCTYPE html>
<!--수정 배포된 Js파일 캐시 방지  -->
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHH");
	String strDate = simpleDate.format(date);
%>
<c:set var="rDate" value="<%=strDate%>" />
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
	String langCode = (String) session.getAttribute("langCode");
	langCode = langCode == null ? "kr" : langCode.toLowerCase();
	
	String culture = "ko-KR";
	
	if (langCode.equals("en")) {
		culture = "en-US";
	} else if (langCode.equals("jp")) {
		culture = "ja-JP";
	} else if (langCode.equals("cn")) {
		culture = "zh-CN";
	}
%>

<script>
	var langCode = "<%=langCode%>";
</script>
<!--Kendo ui css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common-custom.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.mobile.all.min.css' />">
    
    <!-- Theme -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />
	
	<!-- 파비콘 -->
<%--     <link rel="icon" href="<c:url value='/Images/ico/favicon.ico'/>" type="image/x-ico" /> --%>
<%--     <link rel="shortcut icon" href="<c:url value='/Images/ico/favicon.ico'/>" type="image/x-ico" /> --%>
	
	<!--css-->
<%--     <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />">  --%>
	
	<!--Kendo UI customize css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css' />">
    
    <!--css-->
<!--     <link rel="stylesheet" type="text/css" href="/js/Scripts/jqueryui/jquery-ui.css"/> -->
    
    <!--jsTree css-->
<!--     <link rel="stylesheet" type="text/css" href="/css/jstree/style.min.css"> -->
    
   
<%--     <script type="text/javascript" src="<c:url value='/js/Scripts/jquery-1.9.1.min.js'/>"></script>      --%>
<%--     <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script><!-- 요청 --> --%>
    
<%--     <script type="text/javascript" src="<c:url value='/js/neos/common.js' />"></script> --%>
<%--     <script type="text/javascript" src="<c:url value='/js/neos/common.kendo.js' />"></script> --%>

	<script type="text/javascript" src="<c:url value='/js/common/outProcessUtil3.js?v=1' /> "></script>
    <script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
<%--     <script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script><!-- 요청 --> --%>

    
    <!-- 메인 js -->
<%--     <script type="text/javascript" src="<c:url value='/js/Scripts/jquery.alsEN-1.0.min.js' />"></script> --%>
<%-- 	<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.bxslider.min.js' />"></script> --%>
	
    <!--js-->
<%--     <script type="text/javascript" src="<c:url value='/js/Scripts/common.js' />"></script> --%>
    
    <!--js-->
<!-- 	<script type="text/javascript" src="/js/Scripts/jqueryui/jquery-ui.min.js"></script>  -->
	
	<!--jsTree js-->
<!-- 	<script type="text/javascript" src="/js/Scripts/jstree/jstree.min.js"></script> -->

	<link rel="stylesheet" type="text/css" href="<c:url value='/js/Scripts/jqueryui/jquery-ui.css'/>"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>"/>
	
	<!--jsTree css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/jstree/style.min.css'/>">

    <!--js-->
	<script type="text/javascript" src="<c:url value='/js/Scripts/jquery-1.9.1.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/Scripts/jqueryui/jquery-ui.min.js'/>"></script> 
	<script type="text/javascript" src="<c:url value='/js/Scripts/common.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/moment.min.js'/>"></script>

	<!--jsTree js-->
	<script type="text/javascript" src="<c:url value='/js/Scripts/jstree/jstree.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/cultures/kendo.culture.ko-KR.min.js'/>"></script>
	<script type="text/javascript" src='<c:url value="/js/common/commUtil.js"></c:url>'></script>
	<script type="text/javascript" src='<c:url value="/js/common/popup/commonPopup.js"></c:url>'></script>
	
	<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
<style>
	.k-window div.k-window-content {
		overflow: hidden;
	}
	.k-selectable th{
		text-align: center;
	}
	.k-selectable td{
		text-align: center;
	}
	
	.vacationType{
		height: 100%;
		width: 100px;
		background: #fff;
	    border-radius: 0px;
	    box-shadow: none;
	    padding: 0px 12px;
	    height: 24px;
	    line-height: 24px;
	    border: 1px solid #c9cac9;
	    outline: 0;
	    color: #4a4a4a !important;
	}
	.empListDD{
		float: left;
	    clear: none;
	    margin: 1px !important;
	    padding: 2px;
	    border: 1px solid #accfff;
	    background-color: #eff7ff;
	    color: #4a4a4a;
	}
</style>

<!--script-->
<script type="text/javascript">



	$(document).ready(function(){
		
		window.resizeTo(1070, 870);
		empGrid();
		$(".vacationType").on("click", function(){
			var numb = $(this).attr("key");
			if(Number(numb) == 3){
				fn_getSpecialList();
			}
			$(".vacationTR").hide();
			$(".vacationType"+numb).show();	
		});
		
		//사원검색
		var empWindow = $("#empPopUp");
		//검색ID
		empSearch = $("#empSearch");
		//검색 클릭(팝업호출)
		empSearch.click(function() {
			empWindow.data("kendoWindow").open();
			//$("#emp_name").val($("#empNameSearch").val());
			//$("#empSeq").val("");
			empGridReload();
			empSearch.fadeOut();
		});
		//팝업 X 닫기버튼 이벤트
		function onClose() {
			empSearch.fadeIn();
		}

		//닫기 이벤트
		$("#cancle").click(function() {
			empWindow.data("kendoWindow").close();
		});

		//팝업 초기화
		empWindow.kendoWindow({
			width : "700px",
			height : "750px",
			visible : false,
			actions : [ "Close" ],
			close : onClose
		}).data("kendoWindow").center();
		
		$("#selectList").on("click", function(){
			var checkGroup = $(".empBox_group:checked").not("#headerEmpBox");
			if(checkGroup.length == 0){
				alert("선택된 사원이 없습니다.");
				return false;
			}
			saveEmpSeq = [];
			var str = "";
			str += "<dl>";
			for(var i = 0 ; i < checkGroup.length ; i++){
				var row = $("#empGrid").data("kendoGrid").dataItem(checkGroup[i].closest("tr"));
				str += "<dd class='empListDD'>";
				str += "[" + row.dept_name + "] "+ row.emp_name;
				//str += "<a href='javascript:;'>X</a>";
				str += "</dd>";
				saveEmpSeq[i] = checkGroup[i].value;
				
			}
			str += "</dl>";
			$("#headerEmpBox").prop("checked", false);
			$("#multiDiv").html(str);
			$("#empSeq").val("");
			empWindow.data("kendoWindow").close();
		});
	});
	
	var url = '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}';
	kendo.culture("<%=culture%>");
	
	console.log("${loginVO}");
	var agent = '';
	var eaAttReqList = [];
	var divCodeList = [];
	var schCodeList = [];
	var calType = "";
	var getApproKey = "";
	var dayCnt1Day = 0;
	//var deptSeq = "<c:out value='${deptSeq}'/>";
	var deptSeq = "<c:out value='${loginVO.dept_seq}'/>";
	//var empSeq = "<c:out value='${empSeq}'/>";
	var empSeq = "<c:out value='${loginVO.uniqId}'/>";
	//var groupSeq = "<c:out value='${groupSeq}'/>";
	var groupSeq = "<c:out value='${loginVO.groupSeq}'/>";
	var compSeq = "<c:out value='${loginVO.compSeq}'/>";
	var formId = "<c:out value='${formId}'/>";
	formId = "85";
	var docId = "<c:out value='${docId}'/>" || "";
	
	//var attTimeReq = '08:00';
	var attTimeReq = [];
	
	var approKey = "<c:out value='${approKey}'/>" || "";
	var minusYn = "<c:out value='${minusYn}'/>"; // 마이너스연차 허용여부 Y:허용 N:미허용
	
	var compName = '';
	var deptName = "<c:out value='${loginVO.orgnztNm}'/>";
	var empName = "<c:out value='${loginVO.name}'/>";
	var positionName = '';
	var dutyName = '';
	var names = '';
	var attItemCode = "<c:out value='${attItemCode}'/>"; //근태코드
	var eaType = "<c:out value='${eaType}'/>" || "ea"; //영리/비영리 구분
	var approve = 'N';
	var codeListApprove = {};
	var reqDate = '';
	var reqSqno = '';
	var annvUseYn = 'Y';
	var delegateHoliResult = []; //상신용 리스트
	
	
	var annvYear = new Date().getFullYear();
	var minusAnnvCnt = 0.000;
	var minusAnnualLeaveConfig;
	
	if (!window.location.origin) {
		window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
	}
	
	var origin = document.location.origin;
	var eadocPop;
	var applicantSeq = "<c:out value='${empSeq}'/>";
	var agentSeq = "";
	var nowDate = "";
	var selAgentCompName = "";
	var selAgentDeptName = "";
	var selAgentEmpName = "";
	var selAgentPositionName = "";
	var processId = '<%=request.getParameter("processId")%>';
	processId = "VAC01";
	var annvExhaustCnt = 0;
	var annvOverOnedayYn = 'N';
	var holidayAttDateList = [];
	var scheduleRegCheck = '';
	var compBaseComeTime = "";
	var compBaseLeaveTime = "";
	
	$(document).ready(function() {
		$("#selectMember").hide();
		
		var names = "[" + compName + "/" + deptName + "]" + empName;
		$("#names").val(names);
		
		//initEmpInfo();
		
		
		$("#gt_sel").kendoComboBox({
			dataTextField : "VCATN_KND_NAME",
			//dataValueField : "VCATN_GBN_CMMN_CD",
			dataValueField : "VCATN_KND_SN",
			select : onSelect,
			placeholder : "<%=BizboxAMessage.getMessage("TX000000265","선택", langCode)%>",
			dataSource : divCodeList,
			filter: "contains",
            suggest: true,
		});
		var stateCombo = $("#gt_sel").data("kendoComboBox").input.prop("readonly", true);
		initCombobox();
		
		//시작날짜
		$("#from_date").kendoDatePicker({
			format: "yyyy-MM-dd",
			change: onChangeFrom
		});
		
		//종료날짜
		$("#to_date").kendoDatePicker({
			format: "yyyy-MM-dd",
			change: onChangeTo
		});
		
		$("#from_date").attr("readonly", true);
		$("#to_date").attr("readonly", true);
		
		$('#from_date').data("kendoDatePicker").value(new Date());
		$('#to_date').data("kendoDatePicker").value(new Date());
		nowDate = $('#from_date').val();
		//시간 셀렉트
		var hourDatas = [];
		
		for (var addHour = 0; addHour < 24; addHour++) {
			var addHourData = addHour.toString();
			if (addHour < 10) {
				addHourData = '0' + addHourData;
			}
			
			hourDatas.push(addHourData);
		}
		//분 셀렉트
		var minDatas = [];
		
		for (var minData = 0; minData < 60; minData++) {
			var addMinData = minData.toString();
			if (minData < 10) {
				addMinData = '0' + addMinData;
			}
			
			minDatas.push(addMinData);
		}
		/* 시간 셀렉트 */
		$( "#hour_sel_1" ).kendoComboBox({
			dataSource : { data : hourDatas },
			value : "09",
			change : timeCalc
		});
		
		$( "#hour_sel_2" ).kendoComboBox({
			dataSource : { data : hourDatas },
			value : "18",
			change : timeCalc
		});
		/* 분 셀렉트 */
		$( "#min_sel_1" ).kendoComboBox({
			dataSource : { data : minDatas },
			value : "00",
			change : timeCalc
		});
		
		$( "#min_sel_2" ).kendoComboBox({
			dataSource : { data : minDatas },
			value : "00",
			change : timeCalc
		});
		
		
		//상세내역
		$("#grid").kendoGrid({
			columns: [
				{
					field:"<%=BizboxAMessage.getMessage("TX000000265","선택", langCode)%>",
					width:34,
					headerTemplate: '<input type="checkbox" name="inp_chk" id="grid_all_chk" class="k-checkbox" onchange="javascript:allCheck(this)"><label class="k-checkbox-label chkSel2" for="grid_all_chk"></label>', 
					headerAttributes: {style: "text-align:center;vertical-align:middle;"},
					//그리드안의 체크박스는 로우별로 아이디가 달라야합니다. 개발 시 아이디를 다르게 넣어주세요.
					template: '<input type="checkbox" name="inp_chk" id="grid_chk#=index#" class="k-checkbox" onchange="javascript:onCheck(this)"><label class="k-checkbox-label chkSel2" for="grid_chk#=index#"></label>', 
					attributes: {style: "text-align:center;vertical-align:middle;"},
					sortable: false
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX900001727","근태구분", langCode)%>",
					width:150,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=divCodeName(attDivCode) #"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX000003213","시작일자", langCode)%>",
					width:130,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=dateFormat(reqStartDt, startTime)#"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX000000858","종료일자", langCode)%>",
					width:130,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=dateFormat(reqEndDt, endTime)#"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX900001728","신청일수", langCode)%>",
					width:130,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=dayCnt#"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX900001729","신청시간", langCode)%>",
					width:100,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=timeFormat(attTime)#"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX000012941","연차차감", langCode)%>",
					width:100,
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: center;"},
					template: "#=annvUseDayCnt#"
				},
				{
					field:"<%=BizboxAMessage.getMessage("TX000000644","비고", langCode)%>(<%=BizboxAMessage.getMessage("TX000000966","사유", langCode)%>)",
					headerAttributes: {style: "text-align: center;"},
					attributes: {style: "text-align: left;"},
					template: "#=reqRemark#"
				}
			],
			dataSource: [],
			height:203,
			scrollable: true,
			selectable: "single",
			groupable: false,
			columnMenu: false,
			editable: false,
			sortable: false,
			pageable: false
		});
		
	});
	//상세구분 코드변경
	function divCodeName(data) {
		var result = '';
		var attDivCode = $('#gt_sel').data("kendoComboBox").value();
		for (var i in divCodeList) {
			if (divCodeList[i].attDivCode == data) {
				result = divCodeList[i].attDivName;
				return result;
			}
		}
	}
	//날짜포맷변경
	function dateFormat(day, time) {
		return dayFormat(day) + "<br />" + timeFormat(time);
	}
	
	function dayFormat(day) {
		return day.substring(0, 4) + '-' + day.substring(4, 6) + '-' + day.substring(6, 8);
	}
	
	//날짜포맷변경
	function timeFormat(time) {
		return time.substring(0, 2) + ':' + time.substring(2, 4);
	}
	//시작일자변경이벤트
	function onChangeFrom() {
		var attDivCode = $('#gt_sel').data("kendoComboBox").value();
		
		if (!attDivCode) {
			$('#from_date').data("kendoDatePicker").value(new Date());
			$('#to_date').data("kendoDatePicker").value(new Date());
			alert("<%=BizboxAMessage.getMessage("TX000012711","근태구분 값을 선택하여 주십시오", langCode)%>");
			return;
		}
		
		var startTime = new Date($("#from_date").val());
		var endTime = new Date($("#to_date").val());
		
		var interval = endTime - startTime;
		
		if (interval < 0) {
			$("#to_date").val($("#from_date").val());
			$("#to_date").data("kendoDatePicker").value($("#from_date").data("kendoDatePicker").value());
		}
		
		countDate();
		timeCalc();
		
		$("#from_date").blur();
		$("#to_date").blur();
		
		//날짜마다 대상자 조회 변경 추가 18.12.28
		//searchTable1();
		//날짜 변경시 대상자 초기화
		//deleteMemberDiv();
	}
	//종료일자변경이벤트
	function onChangeTo() {
		var attDivCode = $('#gt_sel').data("kendoComboBox").value();
		
		if (!attDivCode) {
			$('#from_date').data("kendoDatePicker").value(new Date());
			$('#to_date').data("kendoDatePicker").value(new Date());
			alert("<%=BizboxAMessage.getMessage("TX000012711","근태구분 값을 선택하여 주십시오", langCode)%>");
			return;
		}
		
		var startTime = new Date($("#from_date").val());
		var endTime = new Date($("#to_date").val());
		
		var interval2 = startTime - endTime;
		
		if (interval2 > -1) {
			$("#from_date").val($("#to_date").val());
			$("#from_date").data("kendoDatePicker").value($("#to_date").data("kendoDatePicker").value());
		}
		
		countDate();
		timeCalc();
		
		$("#from_date").blur();
		$("#to_date").blur();
		
		//날짜마다 대상자 조회 변경 추가 18.12.28
		//searchTable1();
		//날짜 변경시 대상자 초기화
		//deleteMemberDiv();
	}
	//시간
	function timeCalc() {
		if ($("#chk_time").prop("checked")) {
			var sTime = new Date($("#from_date").val() + "T" + $("#hour_sel_1").val() + ":" + $("#min_sel_1").val()); //시작시간
			var eTime = new Date($("#to_date").val() + "T" + $("#hour_sel_2").val() + ":" + $("#min_sel_2").val()); //종료시간
			
			var msecPerMinute = 1000 * 60; //1분
			var msecPerHour = msecPerMinute * 60; //1시간
			
			var interval = eTime - sTime;
			
			if (interval <= 0) {
				alert("신청 시간이 0보다 커야합니다.");
				hourReset();
				return;
			}
			
			var hours = Math.floor(interval / msecPerHour);
			interval = interval - (hours * msecPerHour);
			var minute = Math.floor(interval / msecPerMinute);
			interval = interval - (hours * msecPerMinute);
			
			var onlyStartTime = $("#hour_sel_1").val();
			var onlyStartMinute = $("#min_sel_1").val();
			var onlyEndTime = $("#hour_sel_2").val();
			var onlyEndMinute = $("#min_sel_2").val();
			
			if (hours < 0) {
				hours = "00";
			} else if (hours < 10) {
				hours = "0" + hours;
			}
			
			if (minute < 0) {
				minute = "00";
			} else if (minute < 10) {
				minute = "0" + minute;
			}
			
			$("#time").text(hours + "<%=BizboxAMessage.getMessage("TX000020499","시간",langCode)%> "+ minute +"<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			attTimeReq = hours + ":" + minute;
		} else {
			var onlyStartTime = $("#hour_sel_1").val();
			var onlyStartMinute = $("#min_sel_1").val();
			var onlyEndTime = $("#hour_sel_2").val();
			var onlyEndMinute = $("#min_sel_2").val();
			
			//신청 시작시간 끝시간 값 체크 
			if (onlyStartTime == onlyEndTime) {
				var minS = $("#min_sel_1").val();
				var minE = $("#min_sel_2").val();
				
				if (minS >= minE) {
					alert("신청 시작 시각보다 커야 합니다.");
					hourReset();
					return;
				}
			} else if (onlyStartTime > onlyEndTime) {
				alert("신청 시작 시각보다 커야 합니다.");
				hourReset();
				return;
			}
			
			// 시작시간
			var startTime = new Date($("#from_date").val() + "T" + onlyStartTime + ":" + onlyStartMinute);
			
			// 종료시간
			// 같은 from_date에서 값을 가져오는 이유는 끝나는 시간과 시작시간을 빼서 근무한 시간을 산출하기 위함으로 보임
			var endTime = new Date($("#from_date").val() + "T" + onlyEndTime + ":" + onlyEndMinute);
			var useDays = $("#dayCnt").val();
			
			// 점심시간 차감
			// 제외 시작시간
			var excludeStartTime = new Date($("#from_date").val() + "T" + "12:00");
			
			// 제외 종료시간
			var excludeEndTime = new Date($("#from_date").val() + "T" + "13:00");
			
			var msecPerMinute = 1000 * 60; //1분
			var msecPerHour = msecPerMinute * 60; //1시간
			
			// 휴게시간
			var restTime = 0;
			
			if (startTime >= excludeStartTime && startTime <= excludeEndTime) {
				startTime = excludeEndTime;
			}
			
			if (endTime >= excludeStartTime && endTime <= excludeEndTime) {
				endTime = excludeStartTime;
			}
			
			if (startTime < excludeStartTime && endTime > excludeEndTime) {
				restTime += msecPerHour;
			}
			
			var interval = endTime - startTime - restTime;
			
			var hours = Math.floor(interval / msecPerHour);
			
			interval -= hours * msecPerHour;
			
			var minute = Math.floor(interval / msecPerMinute);
			
			//신청일수 곱하기
			hours *= useDays;
			minute *= useDays;
			
			if (minute > 59) {
				hours += Math.floor(minute / 60);
				minute = Math.floor(minute % 60);
			}
			
			if (hours < 0) {
				hours = "00";
			} else if (hours < 10) {
				hours = "0" + hours;
			}
			
			if (minute < 0) {
				minute = "00";
			} else if (minute < 10) {
				minute = "0" + minute;
			}
			
			$("#time").text(hours + "<%=BizboxAMessage.getMessage("TX000020499","시간",langCode)%> " + minute + "<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			attTimeReq = hours + ":" + minute;
		}
	}
	
	//일수계산
	<%--
	function countDate() {
		var reqStartDate = $("#from_date").val().replace(/-/gi, "");
		var reqEndDate = $("#to_date").val().replace(/-/gi, "");
		//var attDivCode = $('#gt_sel').val();
		var attDivCode = 1;
		
		var betweenDay = searchAttWorkDays(attItemCode, attDivCode, reqStartDate, reqEndDate);
		return betweenDay;
	}
	--%>
	//일수계산
	function countDate() {
		var fd = $("#from_date").data("kendoDatePicker").value();
		var td = $("#to_date").data("kendoDatePicker").value();
		
		/* 신청일수 계산 */
		var dayCnt = Math.floor( ( ( td.getTime() - fd.getTime() ) / ( 1000 * 3600 * 24 ) ) ) + 1;
		
		if (dayCnt < 1) {
			var alertMsg = "<%=BizboxAMessage.getMessage("TX000012931","시작일과 종료일을 정상적으로 입력바랍니다", langCode)%>."
				+ "\n\n* <%=BizboxAMessage.getMessage("TX900001774", "근무조에 포함되어 있을 경우 해당 신청일자에 휴일 등록이 되어 있을 수 있습니다.", langCode)%>";
			
			alert(alertMsg);
			$("#from_date").data("kendoDatePicker").value(td);
			//onChangeDate();
			return;
		}
		
		$("#dayCnt").val(dayCnt);
	}
	
	
	
	function searchAttWorkDays(attItemCode, attDivCode, reqStartDate, reqEndDate) {
		var betweenDay = '';
		var vcatnKndSn = $('#gt_sel').data("kendoComboBox").value();
		//해당 사원의 일수 계산하기
		
		$.ajax({
			type:"POST",
			dataType:"json",
			url: "<c:url value='/vcatn/getVcatnCreatHist'/>",
			async: false,
			data: {
				empSeq : empSeq,
				vcatnKndSn : vcatnKndSn
				
			},
			success:function(e) {
				
				betweenDay = e.obj;
				holidayAttDateList = reqStartDate;
				annvExhaustCnt = reqEndDate;
			}
		});
		
		return betweenDay;
	}
	//상세구분
	function initCombobox() {
		$.ajax({
			type: 'POST',
			//url:'${pageContext.request.contextPath}/WebCommon/GetCommonCdAttDivList',
			
			url: "<c:url value='/enrollment/enrollList'/>",
			
			async: false,
			data:JSON.stringify({ attItemCode : attItemCode }), 
			dataType:'json',
			contentType:'application/json; charset=utf-8',
			success: function(e) {
				var tempdata = e.list;
				divCodeList = tempdata;
				console.log(tempdata);
				for (var i = 0; i < divCodeList.length; i++) {
					//codeListApprove[divCodeList[i].VCATN_GBN_CMMN_CD] = divCodeList[i].VCATN_KND_NAME;
					codeListApprove[divCodeList[i].VCATN_KND_SN] = divCodeList[i].VCATN_KND_NAME;
				}
				
				var gtCombo = $("#gt_sel").data("kendoComboBox");
				gtCombo.dataSource.data(divCodeList);
				gtCombo.dataSource.query();
			}
		});
	}
	//콤보박스선택이벤트
	function onSelect(e) {
		var dataItem = this.dataItem(e.item.index());
		
		if (groupSeq == "kicpa" || groupSeq == "kicpa_dev") {
			if (dataItem.attDivCode == "13") { // 오후반차 (14시 ~ 18시)
				$("#hour_sel_1").data("kendoComboBox").value('14');
				$("#min_sel_1").data("kendoComboBox").value('00');
				$("#hour_sel_2").data("kendoComboBox").value('18');
				$("#min_sel_2").data("kendoComboBox").value('00');
				$("#hour_sel_1").data("kendoComboBox").enable(false);
				$("#min_sel_1").data("kendoComboBox").enable(false);
				$("#hour_sel_2").data("kendoComboBox").enable(false);
				$("#min_sel_2").data("kendoComboBox").enable(false);
				$("#time").text("04시간 00<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			} else if (dataItem.attDivCode == "12") { // 오전반차 (09시 ~ 14시)
				$("#hour_sel_1").data("kendoComboBox").value('09');
				$("#min_sel_1").data("kendoComboBox").value('00');
				$("#hour_sel_2").data("kendoComboBox").value('14');
				$("#min_sel_2").data("kendoComboBox").value('00');
				$("#hour_sel_1").data("kendoComboBox").enable(false);
				$("#min_sel_1").data("kendoComboBox").enable(false);
				$("#hour_sel_2").data("kendoComboBox").enable(false);
				$("#min_sel_2").data("kendoComboBox").enable(false);
				$("#time").text("04시간 00<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			} else {
				$("#hour_sel_1").data("kendoComboBox").value('09');
				$("#min_sel_1").data("kendoComboBox").value('00');
				$("#hour_sel_2").data("kendoComboBox").value('18');
				$("#min_sel_2").data("kendoComboBox").value('00');
				$("#hour_sel_1").data("kendoComboBox").enable(true);
				$("#min_sel_1").data("kendoComboBox").enable(true);
				$("#hour_sel_2").data("kendoComboBox").enable(true);
				$("#min_sel_2").data("kendoComboBox").enable(true);
				$("#time").text("08시간 00<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			}
		}
		
		var fd = $("#from_date").data("kendoDatePicker").value();
		var td = $("#to_date").data("kendoDatePicker").value();
		var dayCnt = parseInt( (td - fd) / (60 * 60 * 1000 * 24) ) + 1;
		
		if (dayCnt < 1) {
			var msg = "<%=BizboxAMessage.getMessage("TX000012931","시작일과 종료일을 정상적으로 입력바랍니다", langCode)%>.";
			msg += "\n\n* <%=BizboxAMessage.getMessage("TX900001774", "근무조에 포함되어 있을 경우 해당 신청일자에 휴일 등록이 되어 있을 수 있습니다.", langCode)%>";
			
			alert(msg);
			$("#from_date").data("kendoDatePicker").value(td);
			return;
		}
		
		$("#dayCnt").val(dayCnt);
		//searchTable1(dataItem.attDivCode);
		//deleteMemberDiv();
	}
	
	
	
	
	var objectChk;
	/* 연차정보 가져오기 */
	function fnGetUserAnnvMstInfo() {
		var retValue = false;
		var fromDate = $( "#from_date" ).val( ).replace(/-/gi, "");
		var toDate = $( "#to_date" ).val( ).replace(/-/gi, "");
		var returnValue = true;
		var vcatnKndSn = $('#gt_sel').data("kendoComboBox").value();
		$.ajax({
			type:"POST",
			dataType:"json",
			//url: "${pageContext.request.contextPath}/pop/searchAnnvMst",
			url: "<c:url value='/vcatn/getVcatnCreatHist'/>",
			async: false,
			data: {
				empSeq : empSeq,
				vcatnKndSn : vcatnKndSn
			},
			success:function( result ) {
				var list = result.list;
				if(list.length == 0){
					alert("부여받은 해당 휴가가 없습니다.");
					returnValue = false;
				}else{
					/* 연차정보 내역 갱신 */
					$('#person_basicAnnvDayCnt').text( result.obj.yrvacRemndrDaycnt );
					$('#person_restAnnvDayCnt').text( result.obj.yrvacRemndrDaycnt );
					$('#person_useDayCnt').text( result.obj.yrvacUseDaycnt );
					$('#person_minusAnnvCnt').text( minusAnnvCnt );
					objectChk = result.obj;
					check = list;
				}
				
			}, error:function(e) {
				alert('Data Load Error');
				location.reload();
			}
		});
		
		return returnValue;
	}
	
	var check;
	//사원 휴가현황 가져오기
	function initEmpInfo(){
		var param = { empSeq : empSeq};
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "<c:url value='/vcatn/checkVcatn'/>",
			async: false,
			data: {
				empSeq : empSeq,
			},
			success:function( result ){
				var obj = result.object;
				$("#yrvacRemndrDaycnt").val(obj.yrvacRemndrDaycnt);
				$("#yrvacUseDaycnt").val(obj.yrvacUseDaycnt);
				
				$("#lnglbcVcatnRemndrDaycnt").val(obj.lnglbcVcatnRemndrDaycnt);
				$("#lnglbcVcatnUseDaycnt").val(obj.lnglbcVcatnUseDaycnt);
				
			}
		});
		
	}
	
	//사원 특별휴가 가져오기
	function fn_getSpecialList(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "<c:url value='/vcatn/getSpecialList'/>",
			async: false,
			data: {
				"empSeq" : empSeq,
			},
			success:function( result ){
				var obj = result.list;
				var html = "";
				for(var i = 0 ; i < obj.length ; i++){
					html += '<tr><td style="text-align: center;">';
					html += '[특별휴가] ' + obj[i].VCATN_KND_NAME;
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="text" id="" name="" disabled="disabled" value="'+obj[i].ALWNC_DAYCNT+'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="text" id="" name="" disabled="disabled" value="'+obj[i].useDate+'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="text" id="" name="" disabled="disabled" value="2999-12-31"/>';
					html += '</td></tr>';
				}
				$("#vacationType3").html(html);
			}
		});
	}
	
	//결재상신
	function save() {
		var displayedData = $("#grid").data("kendoGrid").dataSource.data();
		var eaAttTitle = $("#eaTitle").val();
		var reqSeqNo = $("#reqSeqNo").val();

		var mcalSeq = $('#sch_sel').val();

		if (!mcalSeq) {
			mcalSeq = "0";
		}

		for (var i = 0; i < displayedData.length; i++) {
			var displayStartDt = displayedData[i].reqStartDt;
			var displayEndDt = displayedData[i].reqEndDt;

			for (var j = 0; j < eaAttReqList.length; j++) {
				if (eaAttReqList[j].reqStartDt == displayStartDt && eaAttReqList[j].reqEndDt == displayEndDt) {
					eaAttReqList[j].schmSeq = mcalSeq;
				}
			}
		}

		if (!eaAttTitle) {
			alert('<%=BizboxAMessage.getMessage("TX000012936","제목을 입력바랍니다", langCode)%>.');
			$( "#send_btn" ).attr( 'disabled', false );
			return;
		}

		eadocPop = window.open('','_blank','scrollbars=yes, resizable=yes, width=900, height=900');
		if (approve == 'Y') {
			eadocPop = window.open('','_blank','scrollbars=yes, resizable=yes, width=900, height=900');
		}

		if (approKey != "") getApproKey = approKey;



		var params = {};

		params.compSeq = compSeq;
		params.empSeq = empSeq;
		params.title= $("#eaTitle").val();

		var data = {
			title : params.title,
			rmk : $("#reqRemark").val()
		}

		var key = 0;
		$.ajax({
			url : "/CustomNPJif/vacation/insDocCert",
			data : data,
			dataType : "json",
			type : "post",
			async : false,
			success: function(rs){
				console.log(rs);
				key = rs.rs.doc_id;
			}
		});

		params.mod = 'W';
		params.approKey = "VAC01_" + key;
		params.outProcessCode = "VAC01";
		params.contentsStr = makeContentStr(data);
		outProcessLogOn(params);
	}

	function makeContentStr(e){
		var html = "";
		html +='<h2 style="margin-left: 260px;">휴가 신청서</h2>'
		html +='<p style="font-size:13px;margin-bottom:5px; margin-left:10px;">시행</p>'
		html +='<table border="3" cellspacing="0" cellpadding="0" style="border-collapse:collapse; width:600px;">';
		html +='<tbody><tr>';
		html +='	<td rowspan="2" colspan="2" valign="middle" style="width:120px;height:75px;border-left:solid #000000 0.4pt;border-right:solid #b2b2b2 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #5d5d5d 0.9pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600;">신청자</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:30px;border-left:solid #b2b2b2 0.4pt;border-right:solid #b2b2b2 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #b2b2b2 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600;">부 서 명</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:30px;border-left:none;border-right:solid #b2b2b2 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #b2b2b2 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600;">직위(직책)</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:30px;border-left:solid #b2b2b2 0.4pt;border-right:none;border-top:solid #000000 0.4pt;border-bottom:solid #b2b2b2 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600;">성 명</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:30px;border-left:solid #b2b2b2 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #b2b2b2 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600;">비고</span></p>';
		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:45px;border-left:solid #b2b2b2 0.4pt;border-right:solid #b2b2b2 0.4pt;border-top:solid #b2b2b2 0.4pt;border-bottom:solid #5d5d5d 0.9pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">부서명val</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:45px;border-left:none;border-right:solid #b2b2b2 0.4pt;border-top:solid #b2b2b2 0.4pt;border-bottom:solid #5d5d5d 0.9pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">직위(직책).val</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:45px;border-left:none;border-right:solid #b2b2b2 0.4pt;border-top:solid #b2b2b2 0.4pt;border-bottom:solid #5d5d5d 0.9pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">성명.val</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="2" style="width:120px;height:45px;border-left:none;border-right:solid #000000 0.4pt;border-top:solid #b2b2b2 0.4pt;border-bottom:solid #5d5d5d 0.9pt;">';
		html +='	<p class="HStyle0" style="text-align:center;margin:0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">비고.val</span></p>';
		html +='	</td>';
        html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" colspan="2" style="width:74px;height:65px;border-left:solid #000000 0.4pt;border-right:solid #b2b2b2 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;font-weight: 600; white-space:pre-wrap;">기  간</span></p>';
		html +='	</td>';
		html +='	<td colspan="8" valign="middle" style="width:120px;height:65px;border-left:solid #b2b2b2 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:none;">';

		html +='	<p class="HStyle0" style="margin:5px 0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp;1. 시작일자 시작 시간 ~ 종료일자 종료시간 일 신청(연가 일 소진)&nbsp;&nbsp; </span></p>';
		html +='	<p class="HStyle0" style="margin:5px 0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp;2. 시작일자 시작 시간 ~ 종료일자 종료시간 일 신청(연가 일 소진)&nbsp;&nbsp; </span></p>';
		html +='	<p class="HStyle0" style="margin:5px 0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp;3. 시작일자 시작 시간 ~ 종료일자 종료시간 일 신청(연가 일 소진)&nbsp;&nbsp; </span></p>';
		html +='	<p class="HStyle0" style="margin:5px 0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp;4. 시작일자 시작 시간 ~ 종료일자 종료시간 일 신청(연가 일 소진)&nbsp;&nbsp; </span></p>';
		html +='	<p class="HStyle0" style="margin:5px 0;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp;5. 시작일자 시작 시간 ~ 종료일자 종료시간 일 신청(연가 일 소진)&nbsp;&nbsp; </span></p>';

		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" colspan="2" style="width:74px;height:120px;border-left:solid #000000 0.4pt;border-right:solid #b2b2b2 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;">';
		html +='	<p class="HStyle0" style="text-align:center;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:160%;font-weight: 600; white-space:pre-wrap;">사  유</span></p>';
		html +='	</td>';
		html +='	<td colspan="8" valign="middle" style="width:206px;height:120px;border-left:solid #b2b2b2 0.4pt;border-right: solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:none;">';
		html +='	<p class="HStyle0"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;">&nbsp;&nbsp; '+e.rmk+'</span></p>';
		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td colspan="10" valign="middle" style="width:74px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;margin-top:30px;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"><b>위와 같이 신청하고자 합니다.</b></span></p>';
		html +='	<p class="HStyle0" style="text-align:left;line-height:120%;margin-left: 160px;margin-top: 60px;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%">신청일 : 신청년도.val. 신청월.val. 기안일.val.</span></p>';
		html +='	<p class="HStyle0" style="text-align:left;line-height:120%;margin-left: 160px;margin-bottom: 60px;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%">신청자 : 신청자.val</span></p>';
		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" colspan="4" rowspan="3" style="width:74px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	<td valign="middle" rowspan="3" colspan="1"  style="width:32px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%;font-weight: 600;">결<br><br>재</span></p>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:32px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:32px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:32px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:32px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" style="width:75px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='	<td valign="middle" style="width:75px;height:87px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%"></span></p>';
		html +='	</td>';
		html +='</tr>';
		html +='<tr>';
		html +='	<td valign="middle" colspan="1" style="width:75px;height:52px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%;font-weight: 600;">협조</span></p>';
		html +='	</td>';
		html +='	</td>';
		html +='	<td valign="middle" colspan="3" style="width:75px;height:52px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #5d5d5d 0.4pt;border-bottom:solid #5d5d5d 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt">';
		html +='	<p class="HStyle0" style="text-align:center;line-height:120%;"><span style="font-size:10.7pt;font-family:&quot;돋움&quot;;letter-spacing:-7%;line-height:120%">협조.val</span></p>';
		html +='	</td>';
		html +='</tr>';



		html +='</tbody></table>';

		return html;
	}
	
	
	function addAnnualLeave() {
		var str = '';
		if(delegateHoliResult.length == 0){
			//임시 데이터 시작
			delegateHoliResult[0] = '';
			var data = {};
			
			delegateHoliResult[0].reqStartDate = $("#from_date").val();
			delegateHoliResult[0].reqEndDate = $("#to_date").val();
			delegateHoliResult[0].compSeq = compSeq;
			delegateHoliResult[0].empSeq = empSeq;
			delegateHoliResult[0].attItemCode = attItemCode;
			delegateHoliResult[0].attDivCode = $('#gt_sel').data("kendoComboBox").value();
			delegateHoliResult[0].basicAnnvDayCnt = '0';
			delegateHoliResult[0].annvUseDayCnt = '0';
			delegateHoliResult[0].deptName = deptName;
			delegateHoliResult[0].empName = empName;
			delegateHoliResult[0].attDivName = '구분명';
			delegateHoliResult[0].startTime = $("#hour_sel_1").val();
			delegateHoliResult[0].endTime = $("#hour_sel_2").val();
			delegateHoliResult[0].attReqDayCnt = '';
			delegateHoliResult[0].reqRemark = '';
			delegateHoliResult[0].attTime = attTimeReq;//신청일자 날짜비교 값 넣어주기
			delegateHoliResult[0].restDayCnt = '';
			delegateHoliResult[0].startMin = $("#min_sel_1").val();
			delegateHoliResult[0].endMin = $("#min_sel_2").val();
			
			
			
			
			//임시 데이터 끝
		}
		
		for (var i = 0; i < delegateHoliResult.length; i++) {
			var resultTemp = delegateHoliResult[i];
			
			//20180504 soyoung 삭세시 처리를 위해 저장
			var value = {};
			value.reqStartDate = resultTemp.reqStartDate;
			value.reqEndDate = resultTemp.reqEndDate;
			value.compSeq = resultTemp.compSeq;
			value.empSeq = resultTemp.empSeq;
			value.attItemCode = resultTemp.attItemCode;
			value.attDivCode = resultTemp.attDivCode;
			
			var id = i + "sel_" + resultTemp.compSeq + "_" + resultTemp.empSeq;
			var basicAnnvDayCnt = resultTemp.basicAnnvDayCnt || '-';
			var useDayCnt = resultTemp.useDayCnt || 0;
			var useDayCntPro = resultTemp.useDayCntPro || 0;
			var annvUseDayCnt = resultTemp.annvUseDayCnt || 0;
			var deptName = resultTemp.deptName;
			var empName = resultTemp.empName;
			var attDivName = resultTemp.attDivName;
			var reqStartDate = resultTemp.reqStartDate;
			var startTime = resultTemp.startTime;
			var reqEndDate = resultTemp.reqEndDate;
			var endTime = resultTemp.endTime;
			var attReqDayCnt = resultTemp.attReqDayCnt || 0;
			var reqRemark = resultTemp.reqRemark;
			var attTime = resultTemp.attTime;
			var restDayCnt = resultTemp.restDayCnt || 0;
			
			if (annvUseYn == 'Y') {
				str += '<tr><td rowspan="2">';
			} else {
				str += '<tr><td>';
			}
			
			str += '<input type="checkbox" name="inp_chk" id="' + id + '" class="k-checkbox tbl2" value=\'' + JSON.stringify(value)
				+ '\'/><label class="k-checkbox-label chkSel" for="' + id + '" ></label>';
			str += '</td><td>';
			str += deptName;
			str += '</td><td>';
			str += empName;
			str += '</td><td>';
			str += attDivName;  //근태구분명
			str += '</td><td>';
			str += reqStartDate + startTime + startMin;
			str += '</td><td>';
			str += reqEndDate + endTime + endMin
			str += '</td><td>';
			str += attReqDayCnt; //신청일수
			str += '</td><td>';
			str += annvUseDayCnt;  //연차차감
			str += '</td><td>';
			str += attTime;  //신청시간
			str += '</td><td>';
			str += reqRemark;
			str += '</td></tr>';
			
			if (annvUseYn !== 'Y') {
				continue;
			}
			
			str += '<tr><td colspan="9" class="le not_fir"><div class="rest_info_div mt0 fl"><ul>';
			str += '<li><dl><dt>&emsp;<%=BizboxAMessage.getMessage("TX000012962", "총 연차일수", langCode)%> : </dt><dd>' + basicAnnvDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000000860", "사용일수", langCode)%> : </dt><dd>' + useDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000012963", "잔여연차", langCode)%> : </dt><dd>' + restDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt>|&emsp;<%=BizboxAMessage.getMessage("TX900001645", "결재 진행 연차", langCode)%> : </dt><dd>' + useDayCntPro + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000012941", "연차차감", langCode)%> : </dt><dd>' + annvUseDayCnt + '</dd></dl></li>';
			str += '</ul></div></td></tr>';
		}
		if (delegateHoliResult.length > 0) {
			var annvUseDayCntList = {};
			
			for (var i = 0; i < delegateHoliResult.length; i++) {
				var item = delegateHoliResult[i].annvUseDayCnt;
				
				if (typeof annvUseDayCntList[item] == "undefined") {
					annvUseDayCntList[item] = 1;
				} else {
					annvUseDayCntList[item] = annvUseDayCntList[item]+1;
				}
			}
			
			var annvUseDayCntTxt
			var tmpLenCnt = 0;
			
			for (var key in annvUseDayCntList) {
				tmpLenCnt++;
			}
			
			annvUseDayCntList.length = tmpLenCnt;
			
			if (annvUseDayCntList.length == 1) {
				annvUseDayCntTxt = delegateHoliResult[0].annvUseDayCnt;
			} else {
				annvUseDayCntTxt = "" + delegateHoliResult[0].annvUseDayCnt + " <%=BizboxAMessage.getMessage("TX000005613", "외", langCode)%> " + (annvUseDayCntList.length - 1);
			}
			
			$("#useDayCnt").val(annvUseDayCntTxt);
		}
		
		$("#searchTable2").html(str);
		
	}
	
	<%--
	특별휴가 일 떄 사후관리 체크 -> 전자결재인지 증빙파일인지 구분해야함.
	function cdEaInterLockYn() {
		$.ajax({
			type: 'POST',
			url:'${pageContext.request.contextPath}/WebCommon/GetCommonCdEaInterLockYn',
			dataType:'json',
			data:JSON.stringify({ attItemCode : attItemCode }),
			contentType:'application/json; charset=utf-8',
			success: function(e) {
				approve = e.result; //Y 결재연동, N 결재미연동
				if (approve == 'Y') {
					$('#send_btn').val('<%=BizboxAMessage.getMessage("TX000005722","결재상신", langCode)%>');
				}
			}
		});
	}
	--%>
	
</script>
</head>
<!-- 등록확인 팝업 -->
<div class="pop_wrap_dir" id="complete_pop" style="display:none;">
	<div class="pop_con">
		<table class="fwb ac" style="width:100%;">
			<tr>
				<td>
					<span class="completionbg"><%=BizboxAMessage.getMessage("TX000012937","신청이 완료되었습니다", langCode)%>.</span>
				</td>
			</tr>
		</table>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" value="<%=BizboxAMessage.getMessage("TX000000078","확인", langCode)%>" onclick="javascript:completeClose()"/>
		</div>
	</div>
</div>
<div class="pop_wrap" style="width:1050px;">
	<div class="pop_sign_head posi_re">
		<h1><%=BizboxAMessage.getMessage("TX000000479","전자결재", langCode)%></h1>
		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input type="button" class="psh_btn" id="send_btn" onclick="javascript:save();" value="<%=BizboxAMessage.getMessage("TX000018131","결재상신", langCode)%>" />
					<%-- <input type="button" class="psh_btn" id="send_btn" onclick="javascript:save();" value="<%=BizboxAMessage.getMessage("TX000018131","승인요청", langCode)%>" /> --%>
				</div>
			</div>
		</div>
	</div><!-- //pop_head -->
	<div class="pop_con">
		<p class="step_p"><span>Step01.</span><%=BizboxAMessage.getMessage("TX000004661","기본정보", langCode)%></p>
		<div class="com_ta">
			<table width="100%">
				<colgroup>
					<col width="90"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><%=BizboxAMessage.getMessage("TX000003779","신청자", langCode)%></th>
					<td>
						<input type="text" id="names" style="width:99%" disabled/>
						<div class="controll_btn p0"></div>
					</td>
				</tr>
				<tr>
					<th><img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" /> <%=BizboxAMessage.getMessage("TX000000493","제목", langCode)%></th>
					<td>
						<input id="eaTitle" type="text" style="width:99%" style="ime-mode:active;"/>
					</td>
				</tr>
				<tr id="trSch" style="display: none;">
					<th id="thSch"><%=BizboxAMessage.getMessage("TX000002870","일정등록", langCode)%></th>
					<td class="text_gray2"><input id="sch_sel" style="width:300px"/></td>
				</tr>
			</table>
		</div>
		<p class="step_p mt20 fl"><span>Step02.</span><%=BizboxAMessage.getMessage("TX000004661","휴가현황", langCode)%></p>
		<div class="com_ta">
			<table width="100%">
				<colgroup>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="25%"/>
				</colgroup>
				<thead>
					<tr>
						<th colspan="100%" style="text-align: left; padding-left: 1%;">
							<button type="button" class="vacationType" key="1">연가</button>
							<button type="button" class="vacationType" key="2">장기근속휴가</button>
							<button type="button" class="vacationType" key="3">특별휴가</button>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="text-align: center;">구분</th>
						<th style="text-align: center;">잔여일</th>
						<th style="text-align: center;">사용일</th>
						<th style="text-align: center;">유효기간</th>
					</tr>
					<tr class="vacationType1 vacationTR">
						<th><%=BizboxAMessage.getMessage("TX000003779","연가", langCode)%></th>
						<td style="text-align: center;">
							<input type="text" id="yrvacRemndrDaycnt" name="yrvacRemndrDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacUseDaycnt" name="yrvacUseDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacUseDaycnt" name="yrvacUseDaycnt" disabled="disabled"/>
						</td>
					</tr>
					<tr style="display: none;" class="vacationType2 vacationTR">
						<th><%=BizboxAMessage.getMessage("TX000020501","장기근속휴가", langCode)%></th>
						<td style="text-align: center;">
							<input type="text" id="lnglbcVcatnRemndrDaycnt" name="lnglbcVcatnRemndrDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="lnglbcVcatnUseDaycnt" name="lnglbcVcatnUseDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="" name="" disabled="disabled"/>
						</td>
					</tr>
					<tr style="display: none;" class="vacationType3 vacationTR">
						<td colspan="100%">
							<div style="width: 100%; height: 130px; overflow-y: scroll;">
								<table style="width: 100%;">
									<tbody id="vacationType3">
										
									</tbody>	
								</table>
							</div>
						</td>
					</tr>
						<%-- <th><%=BizboxAMessage.getMessage("TX000020501","특별휴가", langCode)%></th>
						<td style="text-align: center;">
							<input type="text" id="speclVcatnRemndrDaycnt" name="speclVcatnRemndrDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="speclVcatnUseDaycnt" name="speclVcatnUseDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="" name="" disabled="disabled"/>
						</td> --%>
					<%--
					<tr>
						<th><img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" /> <%=BizboxAMessage.getMessage("TX000000493","비고", langCode)%></th>
						<td>
						</td>
					</tr>
					<tr id="trSch">
						<th id="thSch"><%=BizboxAMessage.getMessage("TX000002870","비고2", langCode)%></th>
						<td class="text_gray2">
						</td>
					</tr>
					--%>
				</tbody>
			</table>
		</div>
		<!-- 신청정보 -->
		<p class="step_p mt20 fl"><span>Step03.</span><%=BizboxAMessage.getMessage("TX000018654","신청정보", langCode)%></p>
		<div class="controll_btn fr mt7">
			<input type="checkbox" name="chk_time" id="chk_time" class="k-checkbox" >
			<label class="k-checkbox-label chkSel2" for="chk_time"><%=BizboxAMessage.getMessage("TX900001635", "전체시간계산", langCode)%></label>
			<button style="width:95px;line-height:18px;" onclick="javascript:addAnnualLeave();">
				<%=BizboxAMessage.getMessage("TX000000621","내역", langCode)%><%=BizboxAMessage.getMessage("TX000000446","추가", langCode)%>
			</button>
		</div>
		<table style="width:100%">
			<colgroup>
				<col width=""/>
				<col width="80"/>
			</colgroup>
			<tr>
				<td>
					<div class="com_ta">
						<table style="width:1018px;">
							<colgroup>
								<col width="110"/>
								<col width="130"/>
								<col width="110"/>
								<col width="110"/>
								<col width="110"/>
								<col width="0"/>
							</colgroup>
							<tr>
								<th>
									<img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" /> <%=BizboxAMessage.getMessage("TX900001727","근태구분", langCode)%>
								</th>
								<td><input id="gt_sel" style="width:200px" /></td>
								<th width="95px">
									<img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" />
									<%=BizboxAMessage.getMessage("TX000000981","신청일자", langCode)%>/<%=BizboxAMessage.getMessage("TX000000481","시간", langCode)%>
								</th>
								<td colspan="3">
								<input id="from_date" value="" class="dpWid"/>
								<input type="text" id="hour_sel_1" class="kendoComboBox" style="width:50px;"/> : 
								<input type="text" id="min_sel_1" class="kendoComboBox" style="width:50px;"/>
								 ~ 
								<input id="to_date" value="" class="dpWid"/>
								<input type="text" id="hour_sel_2" class="kendoComboBox" style="width:50px;"/> : 
								<input type="text" id="min_sel_2" class="kendoComboBox" style="width:50px;"/>
								</td>
							</tr>
							<tr id="selectMember">	
								<th>
									<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000005018","대상자", langCode)%>
								</th>
								<td colspan="5">
									<div id="multiDiv" style="width: 85%; display: inline-block; vertical-align: middle;"></div>
									<div class="controll_btn" style="padding:4px 0px;">
										<button id="empSearch"><%=BizboxAMessage.getMessage("TX000000265","선택", langCode)%></button>
									</div>
								</td>
							</tr>
							<tr>
								<th><%=BizboxAMessage.getMessage("TX900001728","신청일수", langCode)%></th>
								<td colspan="2">
									<input type="text" id="dayCnt" style="width:70px;text-align:right;padding-right:7px;" disabled/>
									<%=BizboxAMessage.getMessage("TX000000437", "일", langCode)%>
								</td>
								<%--
								<th><%=BizboxAMessage.getMessage("TX000012941", "연차차감", langCode)%></th>
								<td>
									<input type="text" id="useDayCnt" style="width:40px;text-align:right;padding-right:7px;" disabled/>
									<%=BizboxAMessage.getMessage("TX000001633", "개", langCode)%>
								</td>
								--%>
								<th><%=BizboxAMessage.getMessage("TX900001729", "신청시간", langCode)%></th>
								<td id="time" colspan="2"> 08<%=BizboxAMessage.getMessage("TX000020499", "시간", langCode)%> 00<%=BizboxAMessage.getMessage("TX000020500", "분", langCode)%></td>
							</tr>
							<tr>
								<th><%=BizboxAMessage.getMessage("TX000000644","비고", langCode)%>(<%=BizboxAMessage.getMessage("TX000000966","사유", langCode)%>)</th>
								<td colspan="5"><input type="text" id="reqRemark" style="width:95%;ime-mode:active;"/></td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<!-- 신청내역 -->
		<p class="step_p mt20 fl">
			<span>Step03.</span> <%=BizboxAMessage.getMessage("TX000004709","신청내역", langCode)%>
		</p>
		<div class="controll_btn fr mt7">
			<button onclick="javascript:preView()"><%=BizboxAMessage.getMessage("TX000003080","미리보기", langCode)%></button>
			<button onclick="javascript:delBtnClick();"><%=BizboxAMessage.getMessage("TX000000424","삭제", langCode)%></button>
		</div>
		<div class="com_ta2">
			<table>
				<colgroup>
					<col width="34"/>
					<col width="100"/>
					<col width="90"/>
					<col width="90"/>
					<col width="90"/>
					<col width="90"/>
					<col width="60"/>
					<col width="60"/>
					<col width="60"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>
						<input type="checkbox" name="inp_chk" id="table2AllCheck" onclick="javascript:allCheck(this);" class="k-checkbox"/>
						<label class="k-checkbox-label chkSel" for="table2AllCheck" ></label>
					</th>
					<th><%=BizboxAMessage.getMessage("TX000000098","부서", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX000000277","이름", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX900001727","근태구분", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX000003213","시작일자", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX000000858","종료일자", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX900001728","신청일수", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX000012941","연차차감", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX900001729","신청시간", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX000000644","비고", langCode)%>(<%=BizboxAMessage.getMessage("TX000000966","사유", langCode)%>)</th>
				</tr>
			</table>
		</div>
		<div class="com_ta2 ova_sc hover_no bg_lightgray" style="height:185px">
			<table>
				<colgroup>
					<col width="34"/>
					<col width="100"/>
					<col width="90"/>
					<col width="90"/>
					<col width="90"/>
					<col width="90"/>
					<col width="60"/>
					<col width="60"/>
					<col width="60"/>
					<col width=""/>
				</colgroup>
				<tbody id="searchTable2"></tbody>
			</table>
		</div>
		<!-- 테이블 -->
		<%--
		<div id="grid"></div>
		--%>
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->
<div class="" id="preView" style="display:none;">
	<div class="" style="text-align: right;padding: 10px;">
		<span>&emsp;<%=BizboxAMessage.getMessage("TX000012962","총 연차일수", langCode)%> : </span>
		<span id="person_basicAnnvDayCnt2"></span>
		<span>&emsp;<%=BizboxAMessage.getMessage("TX000000860","사용일수", langCode)%> : </span>
		<span id="person_useDayCnt2"></span>
		<span>&emsp;<%=BizboxAMessage.getMessage("TX000012963","잔여연차", langCode)%> : </span>
		<span id="person_restAnnvDayCnt2"></span>
		<span>&emsp;|&emsp;<%=BizboxAMessage.getMessage("TX900001645", "결재 진행 연차", langCode)%> : </span>
		<span id="person_useDayCntPro2"></span>
		<span>&emsp;<%=BizboxAMessage.getMessage("TX000012941","연차차감", langCode)%> : </span>
		<span id="person_minusAnnvCnt2"></span>
	</div>
	<div id="grid2"></div>
</div>
<input type="hidden" id="reqSeqNo" value="0"/>
<input type="hidden" id="" value=""/>

<form id="frmPop" name="frmPop">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="<c:url value='/systemx/orgChart.do'/>">
	<input type="hidden" name="selectMode" width="500" value="u" />
	<!-- value : [u : 사용자 선택], [d : 부서 선택], [ud : 사용자 부서 선택], [od : 부서 조직도 선택], [oc : 회사 조직도 선택]  --> 
	<input type="hidden" name="selectItem" width="500" value="s" />
	<input type="hidden" name="callback" width="500" value="callbackSel" />
	<input type="hidden" name="compSeq" id="compSeq" value="" />
	<input type="hidden" name="compFilter" id="compFilter" value="" />
	<input type="hidden" name="initMode" id="initMode" value="true" />
	<input type="hidden" name="noUseDefaultNodeInfo" id="noUseDefaultNodeInfo" value="true" />
	<input type="hidden" name="selectedItems" id="selectedItems" value="" />
</form>

<form id="formTotal" name="formTotal"
	action="https://gw.kbsc.ac.kr/attend/Views/Common/pop/eaPop.do?processId=ATTProc18&form_id=<c:out value='${formId}'/>&form_tp=ATTProc18&doc_width=1201&eaType=ea" method="POST"
>
</form>
<!-- 사원검색팝업 -->
<div class="pop_wrap_dir" id="empPopUp" style="width: 600px; margin: auto;">
	<div class="pop_head">
		<h1>사원 선택</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" style="width: 120px" />
				</dd>
				<dd>
					<input type="button" onclick="empGridReload();" id="searchButton"
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
			<button type="button" id="selectList" class="gray_btn">선택</button>
			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<script type="text/javascript">
	var groupSeqSec = '${groupSeq}';
	
	$(window).load(function() {
		if (groupSeqSec == "kbsc") {
			var locationUrl = location.href;
			if (locationUrl.indexOf("https") > -1) {
			} else {
				document.forms[1].submit();
			}
		}
		
		$("#headerEmpBox").on("click", function(){
			 if($("#headerEmpBox").is(":checked")){
			    	$(".empBox_group").prop("checked", "checked");
			    	var checked = this.checked,
			        row = $(this).closest("tr"),
			        grid = $("#empGrid").data("kendoGrid"),
			        dataItem = grid.dataItem(row);
					console.log(dataItem);
			        checkedIds[dataItem.emp_seq] = checked;

			        if (checked) {
			            row.addClass("k-state-selected");

			        } else {
			            row.removeClass("k-state-selected");
			           
			        }
			    }else{
			    	$(".empBox_group").removeProp("checked");
			    }
		});
		
	});
	var empDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : "<c:url value='/common/empInformation'/>",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.dept_name = $('#requestDeptSeq').val();
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
	//사원 체크박스
 	function fn_empBoxGroup(row){
 		var str = "";
 		str += "<input type='checkbox' class='empBox_group emp"+row.emp_seq+"' value='"+row.emp_seq+"'>";
 		str += "</div>";
 		return str;
 	}
	function empGrid() {
		//사원 팝업그리드 초기화
		var grid = $("#empGrid")
				.kendoGrid(
						{
							dataSource : empDataSource,
							height : 500,
							sortable : true,
							pageable : {
								refresh : true,
								pageSizes : true,
								buttonCount : 5
							},
							persistSelection : true,
							selectable : "multiple",
							columns : [
									{
										headerTemplate: "<input type='checkbox' id='headerEmpBox' class='empBox_group'>",
						            	template : fn_empBoxGroup,
						                width : 50,										
									},
									{
										field : "dept_name",
										title : "부서",
									},
									{
										field : "emp_name",
										title : "이름",
										template : fn_empName,
									},
									{
										field : "",
										title : "잔여연차",
										template : function(e){
											
											return 0;
										}
										
									}
									
									/*,
									{
										title : "선택",
										template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
									}*/ ],
							change : function(e) {
								codeGridClick(e)
							}
						}).data("kendoGrid");

		grid.table.on("click", ".checkbox", selectRow);

		var checkedIds = {};
		function selectRow() {

			var checked = this.checked, row = $(this).closest("tr"), grid = $(
					'#grid').data("kendoGrid"), dataItem = grid.dataItem(row);

			checkedIds[dataItem.emp_seq] = checked;
			if (checked) {
				//-select the row
				row.addClass("k-state-selected");
			} else {
				//-remove selection
				row.removeClass("k-state-selected");
			}

		}
		//사원팝업 grid 클릭이벤트
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
			});
			subReload(record);
		}
	}
	function fn_empName(row){
		var str = "<input type='hidden' class='empName' value='"+row.emp_name+"'/>" + row.emp_name;
		return str;
	}
	function subReload(record) {
		$('#keyId').val(record.if_info_system_id);
	}
	function empGridReload() {
		$("#empGrid").data('kendoGrid').dataSource.read();
	}
</script>