<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
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

<c:set var="loginVO" value="${sessionScope.loginVO}" />

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
	var now = new Date();
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

	<script type="text/javascript" src="<c:url value='/js/common/outProcessUtil3.js?v=${rDate}' /> "></script>
    <script type="text/javascript" src="<c:url value='/js/neos/neos/neos_common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/neos/NeosUtil.js' />"></script>
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
	<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
	
	<jsp:useBean id="year" class="java.util.Date" />
	<jsp:useBean id="mm" class="java.util.Date" />
	<jsp:useBean id="dd" class="java.util.Date" />
	<jsp:useBean id="weekDay" class="java.util.Date" />
	<jsp:useBean id="nowDate" class="java.util.Date" />
	<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
	<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
	<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
	<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
	<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
	<%--
	<script type="text/javascript" src="<c:url value='/js/myVacation.js?v=${nowDate}'/>"></script>
	--%>
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
	
	.active{
		background: #1385db;
		color: white !important;
		cursor: auto;
	}
	
	.specialTr{
		cursor: pointer;
	}
	.specialTr:hover{
		background : #1385db61;	
	}
	
	.numberTable{
		width: 100px;
	}
	
	.com_ta table td input[type="text"]{width:100%;}
	.com_ta table td{border-right:1px solid #eaeaea;}
	
/*팝업 : 전자결재연동 (전자결재-결재문서명)*/
.step_p {font-weight:bold;margin-bottom:13px;}
.step_p span{font-size:14px;font-style: italic;color:#8d8d8d}
.rest_info_div {float:right;margin-top:22px;}
.rest_info_div ul {}
.rest_info_div ul li{float:left;margin-right:15px;}
.rest_info_div ul dt {float:left;}
.rest_info_div ul dd {float:left;margin-left:4px;}

.pop_side_con {border-right:1px solid #dcdcdc; overflow: hidden;float:left;padding:10px;}
.pop_side_con .ps_box {}
.ps_box .record_tabSearch { height: 24px;  padding: 15px;  border: 1px solid #dcdcdc;}
.ps_box .treeCon { border: 1px solid #dcdcdc;border-top:none;}
.pop_side_con .ps_list {border: 1px solid #dcdcdc;overflow:hidden; padding:10px; margin-top:10px;}
.pop_side_con .ps_list .step_p {margin-top:12px;}

/* 테이블 */
.com_ta table td, .com_ta2 table td, .com_ta3 table td, .com_ta4 table td, .com_ta5 table td, .com_ta6 table td{word-break:break-all;}, .com_ta7 table td
.com_ta table{width:100%;}
.com_ta table th,.com_ta table td {height:26px;color:#4a4a4a;border:1px solid #eaeaea;padding:5px 0;}
.com_ta table th {background:#f9f9f9;/*background:#f9fafc;*/font-weight:normal;text-align:right;padding-right:15px;}
.com_ta table td {border-right:none;padding-left:13px;padding-right:13px;/*background:#fff;*/}/*테이블보더 오류로 인해 배경 삭제함 필요시 요청바람*/
.com_ta table td input[type="text"] {height:22px;border:1px solid #c3c3c3;text-indent:8px;}
.com_ta table td input[type="text"].k-input {border:none;}
.com_ta table td li {clear:both;overflow:hidden;}
.com_ta table td li dl {float:left;}
.com_ta table td li dl dt {float:left;line-height:22px;}
.com_ta table td li dl dd {float:left;line-height:22px;}
.com_ta table td .txt{color:#8d8d8d;font-size:11px;line-height:22px;}
.com_ta table td textarea {overflow-y:auto;}
.com_ta table .cen {text-align:center !important;padding-left:0px;padding-right:0px;}
.com_ta table .ri {text-align:right !important;}
.com_ta table input.ri {text-align:right !important; padding-right:5px;}
.com_ta table .le {text-align:left !important;}
.com_ta table td.td_cen {text-align:center !important;padding-left:0px;padding-right:0px;}
.com_ta table td.td_ri {text-align:right !important; padding-right:10px;}
.com_ta table td.td_le {text-align:left !important;}
.com_ta table td.bln{border-left:none;}
.com_ta table tr.big_tr td {padding:10px 13px;}
.com_ta table .so_txt {color:#8d8d8d; font-size:11px;}
.com_ta table .so_txt2 {color:#4a4a4a; font-size:11px;font-weight:normal;}
.com_ta table .so_txt3 {color:#4a4a4a; font-size:11px;font-weight:normal; line-height:17px;}
.com_ta table .ver {float: right;  font-weight: normal;  color: #8d8d8d;  margin-right:0px;}
.com_ta table .date {float: right;  font-weight: normal;}
.com_ta table ul.down_ul {margin:7px 0;}
.com_ta table ul.down_ul li {line-height:20px;}
.com_ta table .texta {min-height:200px;position:relative;padding:40px 0 10px 0;}
.com_ta table .texta .dat {position:absolute; top:13px; right:0px; color:#8d8d8d;font-size:11px;}
.com_ta table.hover tr:hover td, .com_ta table.hover tr.on td {background:#e6f4ff; cursor:pointer;} 
.com_ta table .comp_type{display:none;}
.com_ta table .comp_type th{text-align:center;}

/* checkbox style */
input[type="checkbox"]{margin-left:1px;vertical-align: middle;}
input[type="checkbox"]:before{padding-right:10px !important;}
input[type="checkbox"] + label {margin-left:-18px !important;display: inline-block;min-height:12px;height:auto;background: url("../Images/bg/checkbox01.png") no-repeat left center;padding: 2px 0 0px 14px !important;overflow: hidden;vertical-align: middle;text-indent:4px;}
input[type="checkbox"]:checked + label{background: url("../Images/bg/checkbox02.png") no-repeat left center;}
input[type="checkbox"]:disabled + label{background: url("../Images/bg/checkbox03.png") no-repeat left center;}

input[type="checkbox"].chkBack{margin-left:1px;vertical-align: middle;}
input[type="checkbox"].chkBack:before{padding-right:10px !important;}
input[type="checkbox"].chkBack + label {margin-left:-18px !important;display: inline-block;min-height:12px;height:auto;background: url("../Images/bg/checkbox01.png") no-repeat right center; padding:2px 20px 0px 0 !important;overflow: hidden;vertical-align: middle;}
input[type="checkbox"].chkBack:checked + label{background: url("../Images/bg/checkbox02.png") no-repeat right center;}
input[type="checkbox"].chkBack:disabled + label{background: url("../Images/bg/checkbox03.png") no-repeat right center;}
@media screen and (-webkit-min-device-pixel-ratio:0) {input[type="checkbox"].chkBack + label {padding:0 20px 0px 0 !important;}}
input.k-checkbox+label {margin-left:-4px !important;}

/* background */
.bgn{background:none !important;}
.bg_skyblue{background:#f0f6fd !important;}
.bg_skyblue2{background:#e6f4ff !important;}
.bg_lightgray{background:#fcfcfc !important;}
.bg_normalgray{background:#e8e8e8 !important;}
.bg_normalgray2{background:#dfdfdf !important;}
.bg_green2{background:#3d9100 !important;}
.bg_blue{background:#56a8f4 !important;}
.bg_orange{background:#ff9b59 !important;}
.bg_red2{background:#f33e51 !important;}
.bg_darkgray{background:#888 !important;}
.bg_brown{background:#c9632f !important;}
.bg_sb{background:#f0f6fd;}/*20160516 수정*/
.bg_sb2{background:#e6f4ff;}
.bg_lt{background:#fcfcfc;}
.bg_statement{background:#f1f1f1;}
.bg_yellow2{background:#d9b302 !important;}
.bg_total{background:#f1f1f1 !important;}
.bg_total2{background:#f9f9f9;}
</style>

<!--script-->
<script type="text/javascript">



	$(document).ready(function(){
		
		window.resizeTo(1100, 900);
	});
	var testEmpSeq = '${loginVO.uniqId}';
	
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
				<tr id="selectEmpInput">
					<th><img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" /> <%=BizboxAMessage.getMessage("TX000000493","대상자", langCode)%></th>
					<td>
						<input id="selectEmp" type="text" style="width:93%" style="ime-mode:active;" disabled/>
						<input id="selectEmpHidden" type="hidden" value="${loginVO.uniqId}"/>
						<input id="compSeqHidden" type="hidden" value="${loginVO.compSeq}"/>
						<input id="deptNameHidden" type="hidden" value="${loginVO.orgnztNm}"/>
						<input id="empNameHidden" type="hidden" value="${loginVO.name}"/>
						<input id="deptSeqHidden" type="hidden" value="${loginVO.dept_seq}"/>
						<input id="dutyHidden" type="hidden" value=""/>
						<input id="titleHidden" type="hidden" value=""/>
						<input type="button" id="empPopupShow" value="선택"/>
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
			<table style="width:100%;">
				<thead>
					<tr>
						<th colspan="100%" style="text-align: left; padding-left: 1%;">
							<button type="button" class="vacationType active thopen" key="1">연가</button>
							<!-- <button type="button" class="vacationType thopen" key="2">장기근속휴가</button> -->
							<%--<button type="button" class="vacationType" key="3">특별휴가</button>--%>
							<%--<button type="button" class="vacationType" key="4">기타</button>--%>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr id="theaderTh">
						<th style="text-align: center;padding-right: 0; width:150px;">구분</th>
						<th style="text-align: center;padding-right: 0;">연차일수</th>
						<th style="text-align: center;padding-right: 0;">조정일수</th>
						<th style="text-align: center;padding-right: 0;">사용일수</th>
						<th style="text-align: center;padding-right: 0;">잔여일수</th>
						<th style="text-align: center;padding-right: 0;">유효기간</th>
					</tr>
					<tr id="theaderTh2" style="display: none;">
						<th style="text-align: center;padding-right: 0; width:150px;">구분</th>
						<th style="text-align: center;padding-right: 0;">부여일수</th>
						<th style="text-align: center;padding-right: 0;">사용일수</th>
						<th style="text-align: center;padding-right: 0;">잔여일수</th>
						<th style="text-align: center;padding-right: 0;">유효기간</th>
					</tr>
					<tr class="vacationType1 vacationTR">
						<th style="text-align: center;padding-right: 0;"><%=BizboxAMessage.getMessage("TX000003779","연가", langCode)%></th>
						<td style="text-align: center;">
							<input type="text" id="yrvacFrstAlwncDaycnt" name="yrvacFrstAlwncDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacMdtnAlwncDaycnt" name="yrvacMdtnAlwncDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacUseDaycnt" name="yrvacUseDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacRemndrDaycnt" name="yrvacRemndrDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="yrvacUseDate" name="yrvacUseDate" disabled="disabled"/>
						</td>
					</tr>
					<%-- <tr style="display: none;" class="vacationType2 vacationTR">
						<th style="text-align: center;padding-right: 0;"><%=BizboxAMessage.getMessage("TX000020501","장기근속휴가", langCode)%></th>
						<td style="text-align: center;">
							<input type="text" id="lnglbcVcatnFrstAlwncDaycnt" name="lnglbcVcatnFrstAlwncDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="lnglbcVcatnUseDaycnt" name="lnglbcVcatnUseDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="lnglbcVcatnRemndrDaycnt" name="lnglbcVcatnRemndrDaycnt" disabled="disabled"/>
						</td>
						<td style="text-align: center;">
							<input type="text" id="lastDate" name="lastDate" disabled="disabled"/>
						</td>
					</tr> --%>
					<tr style="display: none;" class="vacationType3 vacationTR">
						<td colspan="100%" style="padding:0 !important;">
							<div style="width: 100%; height: 130px; overflow-y: scroll;">
								<table>
									<tbody id="vacationType3">
									</tbody>	
								</table>
							</div>
						</td>
					</tr>
					<tr style="display: none;" class="vacationType4 vacationTR">
						<td colspan="100%" style="padding:0 !important;">
							<div style="width: 100%; height: 130px; overflow-y: scroll;">
								<table style="width: 100%;">
									<tbody id="vacationType4">
									</tbody>	
								</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- 신청정보 -->
		<p class="step_p mt20 fl"><span>Step03.</span><%=BizboxAMessage.getMessage("TX000018654","신청정보", langCode)%></p>
		<div class="controll_btn fr mt7">
			<input type="checkbox" name="chk_time" id="chk_time" class="k-checkbox" >
			<label class="k-checkbox-label chkSel2" for="chk_time"><%=BizboxAMessage.getMessage("TX900001635", "전체시간계산", langCode)%></label>
			<button style="width:95px;line-height:18px;" onclick="addAnnualLeave();">
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
								<col width=""/>
							</colgroup>
							<tr>
								<th>
									<img src="<c:url value='/Images/ico/ico_check01.png'/> " alt="" /> <%=BizboxAMessage.getMessage("TX900001727","근태구분", langCode)%>
								</th>
								<td>
									<input id="gt_sel" style="margin-bottom:5px; width:200px" />
									<select id="gt_sel2" style="width:200px; display: none" >
										<optgroup label="선택"></optgroup>
									</select>
								</td>
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
							<tr>
								<th><%=BizboxAMessage.getMessage("TX900001728","신청일수", langCode)%></th>
								<td>
									<input type="text" id="dayCnt" style="width:70px;text-align:right;padding-right:7px;" disabled/>
									<%=BizboxAMessage.getMessage("TX000000437", "일", langCode)%>
								</td>
								<th><%=BizboxAMessage.getMessage("TX000012941", "차감일수", langCode)%></th>
								<td>
									<input type="text" id="useDayCnt" style="width:40px;text-align:right;padding-right:7px;" disabled/>
									<%=BizboxAMessage.getMessage("TX000001633", "일", langCode)%>
								</td>
								<th><%=BizboxAMessage.getMessage("TX900001729", "신청시간", langCode)%></th>
								<td id="time"> 08<%=BizboxAMessage.getMessage("TX000020499", "시간", langCode)%> 00<%=BizboxAMessage.getMessage("TX000020500", "분", langCode)%></td>
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
			<span>Step04.</span> <%=BizboxAMessage.getMessage("TX000004709","신청내역", langCode)%>
		</p>
		<div class="controll_btn fr mt7">
			<button onclick="javascript:delBtnClick();"><%=BizboxAMessage.getMessage("TX000000424","삭제", langCode)%></button>
		</div>
		<div class="rest_info_div">
			<ul>
				<li><dl><dt>&emsp;<%=BizboxAMessage.getMessage("TX000012962", "총 부여일수", langCode)%> : </dt><dd id="totalDay"></dd></dl></li>
				<li><dl><dt>|&emsp;<%=BizboxAMessage.getMessage("TX000000860", "사용일수", langCode)%> : </dt><dd id="useDay"></dd></dl></li>
				<li><dl><dt>|&emsp;<%=BizboxAMessage.getMessage("TX000012963", "잔여일수", langCode)%> : </dt><dd id="remainingDays"></dd></dl></li>
				<li><dl><dt>|&emsp;<%=BizboxAMessage.getMessage("TX000012941", "차감일수", langCode)%> : </dt><dd id="minusDay"></dd></dl></li>
			</ul>
		</div>
		
		<div class="com_ta2">
			<table>
				<colgroup>
					<col width="34"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
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
					<th><%=BizboxAMessage.getMessage("TX000012941","차감일수", langCode)%></th>
					<th><%=BizboxAMessage.getMessage("TX900001729","신청시간", langCode)%></th>
					<%--<th><%=BizboxAMessage.getMessage("TX000000644","비고", langCode)%>(<%=BizboxAMessage.getMessage("TX000000966","사유", langCode)%>)</th>--%>
				</tr>
			</table>
		</div>
		<div class="com_ta2 ova_sc hover_no bg_lightgray" style="height:185px">
			<table>
				<colgroup>
					<col width="34"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
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
	<div id="grid"></div>
</div>
<input type="hidden" id="reqSeqNo" value="0"/>
<input type="hidden" id="vcatnSn" value=""/>

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

<!-- 사원검색 -->
<div class="pop_wrap_dir" id="empPopUp" style="width: 600px; margin: auto;">
	<div class="pop_head">
		<h1>사원 선택</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px">부서</dt>
				<dd>
					<input type="text" id="requestDeptSeq" />

				</dd>
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
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
</div>

<script>
	var ccheck = '${loginVO}';
		var url = '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}';
		kendo.culture("<%=culture%>");
		
		var agent = '';
		var eaAttReqList = [];
		var divCodeList = [];
		var schCodeList = [];
		var calType = "";
		var getApproKey = "";
		var dayCnt1Day = 0;
		//var deptSeq = "<c:out value='${deptSeq}'/>";
		//var deptSeq = "<c:out value='${loginVO.dept_seq}'/>";
		var deptSeq = $("#deptSeqHidden").val();
		//var empSeq = "<c:out value='${empSeq}'/>";
		//var empSeq = "<c:out value='${loginVO.uniqId}'/>";
		var empSeq = $("#selectEmpHidden").val();
		//var groupSeq = "<c:out value='${groupSeq}'/>";
		var groupSeq = "<c:out value='${loginVO.groupSeq}'/>";
		//var compSeq = "<c:out value='${loginVO.compSeq}'/>";
		var compSeq = $("#compSeqHidden").val();
		var formId = "<c:out value='${formId}'/>";
		formId = "85";
		var docId = "<c:out value='${docId}'/>" || "";
		
		//var attTimeReq = '08:00';
		var attTimeReq = [];
		
		var approKey = "<c:out value='${approKey}'/>" || "";
		var minusYn = "<c:out value='${minusYn}'/>"; // 마이너스연차 허용여부 Y:허용 N:미허용
		
		var compName = '';
		//var deptName = "<c:out value='${loginVO.orgnztNm}'/>";
		var deptName = $("#deptNameHidden").val();
		//var empName = "<c:out value='${loginVO.name}'/>";
		var empName = $("#empNameHidden").val();
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

		
		// var annvYear = new Date().getFullYear();
		var annvYear = '';
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
		
	$(function(){
		
		
		$("#selectMember").hide();
		
		var names = "[" + compName + "/" + deptName + "]" + empName;
		$("#names").val(names);
		
		
		//시작날짜
		$("#from_date").kendoDatePicker({
			format: "yyyy-MM-dd",
			change: onChangeFrom,
			/*min : new Date(),*/
			value : new Date()
		});
		
		//종료날짜
		$("#to_date").kendoDatePicker({
			format: "yyyy-MM-dd",
			change: onChangeTo,
			/*min : new Date(),*/
			value : new Date()
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
		
		$("#gt_sel").kendoComboBox({
			dataTextField : "dataView",
			dataValueField : "dataValue",
			select : onSelect,
			placeholder : "<%=BizboxAMessage.getMessage("TX000000265","선택", langCode)%>",
			dataSource : divCodeList,
			filter: "contains",
	        suggest: true,
	        change: function(e){
	        	fn_vacationInfo($("#gt_sel").select().val());
	        }
		});
		
		var stateCombo = $("#gt_sel").data("kendoComboBox").input.prop("readonly", true);	
		
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
				}
				<%--,--%>
				<%--{--%>
				<%--	field:"<%=BizboxAMessage.getMessage("TX000000644","비고", langCode)%>(<%=BizboxAMessage.getMessage("TX000000966","사유", langCode)%>)",--%>
				<%--	headerAttributes: {style: "text-align: center;"},--%>
				<%--	attributes: {style: "text-align: left;"},--%>
				<%--	template: "#=reqRemark#"--%>
				<%--}--%>
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
		
		
		
		initCombobox(1);
		$("#gt_sel2").css("display", "");
		$("#gt_sel2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : [
				/*{text : "연차", value : "0"},
				{text : "오전반차", value : "1"},
				{text : "오후반차", value : "2"},*/
				{text : "외출", value : "3"}
			],
			change : function(e) {
				var toDate = $("#to_date").data("kendoDatePicker");
				var hourSel1 = $("#hour_sel_1").data("kendoComboBox");
				var minSel1 = $("#min_sel_1").data("kendoComboBox");
				var hourSel2 = $("#hour_sel_2").data("kendoComboBox");
				var minSel2 = $("#min_sel_2").data("kendoComboBox");

				if (e.sender.selectedIndex == 0) {
					toDate.enable(true);
					hourSel1.enable(true);
					minSel1.enable(true);
					hourSel2.enable(true);
					minSel2.enable(true);
					hourSel1.select(9);
					hourSel2.select(18);
				} else if(e.sender.selectedIndex == 1) {
					$("#to_date").data("kendoDatePicker").value($("#from_date").data("kendoDatePicker").value());
					toDate.enable(false);
					hourSel1.enable(false);
					minSel1.enable(false);
					hourSel2.enable(false);
					minSel2.enable(false);
					hourSel1.select(9);
					hourSel2.select(14);
				}else if(e.sender.selectedIndex == 2) {
					$("#to_date").data("kendoDatePicker").value($("#from_date").data("kendoDatePicker").value());
					toDate.enable(false);
					hourSel1.enable(false);
					minSel1.enable(false);
					hourSel2.enable(false);
					minSel2.enable(false);
					hourSel1.select(14);
					hourSel2.select(18);
				}else if(e.sender.selectedIndex == 3){
					$("#to_date").data("kendoDatePicker").value($("#from_date").data("kendoDatePicker").value());
					toDate.enable(true);
					hourSel1.enable(true);
					minSel1.enable(true);
					hourSel2.enable(true);
					minSel2.enable(true);
					hourSel1.select(9);
					hourSel2.select(18);
				}

				countDate();
				timeCalc();
			}
		
		
		});

		$(".vacationType").on("click", function(){
			$("#totalDay").text("");
			$("#remainingDays").text("");
			$("#useDay").text("");
			$("#minusDay").text("");
			var gtSel2 = $("#gt_sel2").data("kendoComboBox");
			if($(this).text() != "연가"){
				gtSel2.wrapper.hide();
				gtSel2.select(0);
				initDate();
				$("#gt_sel2").css("display", "none");
			} else {
				gtSel2.wrapper.show();
			}

			var gtCombo = $("#gt_sel").data("kendoComboBox");
			gtCombo.value("");
			$(".vacationType").removeClass("active");
			$(this).addClass("active");
			var numb = $(this).attr("key");
			if(Number(numb) == 3){
				fn_headerSet(1);
				fn_getSpecialList();
				$("#theaderTh").hide();
				$("#theaderTh2").hide();
			}
			if(Number(numb) == 4){
				fn_headerSet(1);
				fn_getEtcVcatnList();
				$("#theaderTh").hide();
				$("#theaderTh2").hide();
			}
			$(".vacationTR").hide();
			$(".vacationType"+numb).show();
			initCombobox(Number(numb));
			
			if(Number(numb) == 1){
				fn_headerSet(0);
				gtCombo.select(0);
				fn_vacationInfo(numb);
				$("#theaderTh").show();
				$("#theaderTh2").hide();
			}
			if(Number(numb) == 2){
				fn_headerSet(0);
				gtCombo.select(0);
				fn_vacationInfo(numb);
				$("#theaderTh").hide();
				$("#theaderTh2").show();
			}
			$("#dayCnt").val(1);
			$("#useDayCnt").val(1);
		});
		
		
		
		
		var gtCombo = $("#gt_sel").data("kendoComboBox");
		gtCombo.select(0);
		fn_vacationInfo(0);
		
		
		
		$("#empPopupShow").click(function(){
			$("#empPopUp").data("kendoWindow").open();
		});
		
		
		var empWindow = $("#empPopUp");
		empWindow.kendoWindow({
			width : "700px",
			height : "750px",
			visible : false,
			actions : [ "Close" ],
		}).data("kendoWindow").center();
		$("#cancle").click(function() {
			empWindow.data("kendoWindow").close();
		});
		fnTpfDeptComboBoxInit('requestDeptSeq');
		//반영전 풀엉
		/*fn_checkAuthority();*/
		empGrid();
		
		$("#emp_name").keydown(function(keyNum) {
			if (keyNum.keyCode == 13) {
				$("#searchButton").click();
			}
		});
		
		$("#dayCnt").val(1);
		$("#useDayCnt").val(1);
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

		var gtSel2 = $("#gt_sel2").data("kendoComboBox");
		if(gtSel2.select() != 0){
			$("#to_date").data("kendoDatePicker").value($("#from_date").data("kendoDatePicker").value());
		}

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
			$("#useDayCnt").val(hours * 0.125);
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

			$("#useDayCnt").val(hours * 0.125);
			$("#time").text(hours + "<%=BizboxAMessage.getMessage("TX000020499","시간",langCode)%> " + minute + "<%=BizboxAMessage.getMessage("TX000001229","분",langCode)%>");
			attTimeReq = hours + ":" + minute;
		}
	}
	
	//일수계산
	function countDate() {
		//var fd = $("#from_date").data("kendoDatePicker").value();
		//var td = $("#to_date").data("kendoDatePicker").value();
		var fd = new Date($("#from_date").val());
		var td = new Date($("#to_date").val());
		console.log("fd => " + fd);
		console.log("td => " + td);
		
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
				empSeq : $("#selectEmpHidden").val(),
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
	function fn_nullCheck(string){
		if(string != null){
			return string;
		}else{
			return "0";
		}
	}
	//상세구분
	function initCombobox(type) {
		$.ajax({
			type: 'POST',
			//url:'${pageContext.request.contextPath}/WebCommon/GetCommonCdAttDivList',
			url: "<c:url value='/vacation/getMyVcation'/>",
			async: false,
			data: {
				type : type,
				empSeq : $("#selectEmpHidden").val(),
				//empSeq : '100000178',
				//year : '${year}',
				annvYear : $( "#from_date" ).val().split("-")[0],
				isAdmin : "special"
			}, 
			dataType:'json',
			async : false,
			success: function(e) {
				var tempdata = e.list;
				divCodeList = tempdata;
				console.log("tempData", tempdata);
				if(divCodeList.length > 0){
					$("#vcatnSn").val(divCodeList[0].annv_sqno);
					for (var i = 0; i < divCodeList.length; i++) {
						codeListApprove[divCodeList[i].dataValue] = divCodeList[i].dataView;
						if(Number(type) == 1){
							var yrvacRemndrDaycnt = divCodeList[i].remnCnt;
							if(yrvacRemndrDaycnt == null || yrvacRemndrDaycnt == ''){
								yrvacRemndrDaycnt = divCodeList[i].useCnt;
							}
							var yrvacUseDaycnt = divCodeList[i].useCnt;
							if(yrvacUseDaycnt == null || yrvacUseDaycnt == ''){
								yrvacUseDaycnt = divCodeList[i].remnCnt;
							}
							if(Number(divCodeList[i].YRVAC_MDTN_ALWNC_DAYCNT) > 0){
								yrvacRemndrDaycnt = Number(yrvacRemndrDaycnt) + Number(divCodeList[i].YRVAC_MDTN_ALWNC_DAYCNT);
							}
							//YRVAC_MDTN_ALWNC_DAYCNT
							$("#yrvacFrstAlwncDaycnt").val(divCodeList[i].basic_annv_day_cnt);
							$("#yrvacMdtnAlwncDaycnt").val(Number(divCodeList[i].add_annv_day_cnt) + Number(divCodeList[i].annv_abjust_day_cnt));
							$("#yrvacRemndrDaycnt").val(yrvacRemndrDaycnt);
							$("#yrvacUseDaycnt").val(yrvacUseDaycnt);
							$("#yrvacUseDate").val("${year}-12-31");
						}
						if(Number(type) == 2){
							var remnCnt = divCodeList[i].remnCnt;
							var useCnt = fn_nullCheck(divCodeList[i].useCnt);
							if(remnCnt == null){
								remnCnt = divCodeList[i].LNGLBC_VCATN_FRST_ALWNC_DAYCNT;
							}
							$("#lnglbcVcatnFrstAlwncDaycnt").val(divCodeList[i].LNGLBC_VCATN_FRST_ALWNC_DAYCNT);
							$("#lnglbcVcatnRemndrDaycnt").val(remnCnt);
							$("#lnglbcVcatnUseDaycnt").val(useCnt);
							$("#lastDate").val(divCodeList[i].lastDate);
							
						}
					}
					var gtCombo = $("#gt_sel").data("kendoComboBox");
					gtCombo.dataSource.data(divCodeList);
					gtCombo.dataSource.query();
				}else{
					if(Number(type) == 1){
						$("#yrvacRemndrDaycnt").val("");
						$("#yrvacUseDaycnt").val("");
						$("#yrvacUseDate").val("");
					}
					if(Number(type) == 2){
						$("#lnglbcVcatnRemndrDaycnt").val("");
						$("#lnglbcVcatnUseDaycnt").val("");
						$("#lastDate").val("");
					}
					$("#dayCnt").val("");
				}
				
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


		console.log("td = ", td);
		console.log("fd = ", fd);
		console.log("td - fd", td-fd);
		console.log(60 * 60 * 1000 * 24);

		console.log("parseInt( (td - fd) / (60 * 60 * 1000 * 24) )", parseInt( (td - fd) / (60 * 60 * 1000 * 24) ));
		console.log("dayCnt = ", dayCnt);
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
				empSeq : $("#selectEmpHidden").val(),
				vcatnKndSn : vcatnKndSn,
				annvYear : $("#from_date").val().split("-")[0]
			},
			success:function( result ) {
				var list = result.list;
				if(list.length == 0){
					alert("부여받은 휴가가 없습니다.");
					returnValue = false;
				}else{
					/* 연차정보 내역 갱신 */
					$('#person_basicAnnvDayCnt').text( result.obj.yrvacRemndrDaycnt );
					$('#person_restAnnvDayCnt').text( result.obj.yrvacRemndrDaycnt );
					$('#person_useDayCnt').text( result.obj.yrvacUseDaycnt );
					$('#person_minusAnnvCnt').text( minusAnnvCnt );
					objectChk = result.obj;
				}
				
			}, error:function(e) {
				alert('Data Load Error');
				location.reload();
			}
		});
		
		return returnValue;
	}
	
	//사원 특별휴가 가져오기
	function fn_getSpecialList(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "<c:url value='/vcatn/getSpecialList'/>",
			async: false,
			data: {
				type : "3",
				empSeq : $("#selectEmpHidden").val(),
				isAdmin : "special"
				//empSeq : '100000178',
			},
			success:function( result ){
				
				$("#theaderTh").css("display", "none");
				$(".thopen").click(function(){
					//$("#theaderTh").css("display", "");
				});
				
				var obj = result.list;
				var html = "";
				html += '<tr style="position:sticky; top:-1px;">';
				html += '<th style="text-align: center; margin-left: 0;">구분</th>';
				html += '<th style="text-align: center; margin-left: 0;">부여일수</th>';
				html += '<th style="text-align: center; margin-left: 0;">사용일수</th>';
				html += '<th style="text-align: center; margin-left: 0;">잔여일수</th>';
				html += '<th style="text-align: center; margin-left: 0;">유효기간</th>';
				html += '<th style="text-align: center; margin-left: 0;">유/무급</th>';
				html += '<th style="text-align: center; margin-left: 0;">비고</th>';
				html += '</tr>';

				for(var i = 0 ; i < obj.length ; i++){
					html += "<tr class='specialTr' onclick=\"fn_specialClick('"+ i +"', '"+ obj[i].SPECL_SN +"');\"><td style='text-align: center;'>";
					html += '[특별휴가] ' + obj[i].VCATN_KND_NAME;
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="'+obj[i].ALWNC_DAYCNT+'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';
					var useDate = 0;
					if(obj[i].useDate != null){
						useDate = obj[i].useDate;
					}
					html += '<input type="text" id="sub'+ i +'" name="" disabled="disabled" value="'+ useDate +'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="text" name="" disabled="disabled" value="'+ (Number(obj[i].ALWNC_DAYCNT) - Number(useDate))+'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';

					var maxDay = obj[i].maxDay;
					if(maxDay == "-"){
						maxDay = "${year}-12-31";
					}
					html += '<input type="text" id="" name="" disabled="disabled" value="'+ maxDay +'"/>';
					
					html += '</td>';
					html += '<td style="text-align: center;">';
					if(obj[i].PAY_YN == 'Y'){
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="유급"/>';
					}else{
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="무급"/>';
					}
					html += '</td>';
					html += '<td style="text-align: center;">';
					if(obj[i].BRMK != null || obj[i].BRMK != ""){
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="'+obj[i].BRMK+'"/>';
					}else{
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="-"/>';
					}
					html += '</td>';
					html += '</tr>';
				}
				$("#dayCnt").val(1);
				$("#useDayCnt").val(1);
				$("#vacationType3").html(html);
			}
		});
	}
	
	function fn_getEtcVcatnList(){
		$.ajax({
			type: "POST",
			dataType: "json",
			url: "<c:url value='/etc/getEtcVcatnList'/>",
			async: false,
			data: {
				type : "4",
				empSeq : $("#selectEmpHidden").val(),
				//empSeq : '100000178',
			},
			success:function( result ){
				
				$("#theaderTh").css("display", "none");
				$(".thopen").click(function(){
					//$("#theaderTh").css("display", "");
				});
				
				var obj = result.list;
				var html = "";
				
				html += '<tr style="position:sticky; top:-1px;">';
				html += '<th style="text-align: center;">구분</th>';
				html += '<th style="text-align: center;">사용일수</th>';
				html += '<th style="text-align: center;">유효기간</th>';
				html += '<th style="text-align: center;">유/무급</th>';
				html += '<th style="text-align: center;">비고</th>';
				html += '</tr>';
				
				for(var i = 0 ; i < obj.length ; i++){
					html += "<tr class='specialTr' onclick=\"fn_specialClick('"+ i +"', '"+ obj[i].SPECL_SN +"');\"><td style='text-align: center;'>";
					html += '[기타] ' + obj[i].VCATN_KND_NAME;
					html += '</td>';
					html += '<td style="text-align: center;">';
					html += '<input type="hidden" id="subMain'+ i +'" name="" disabled="disabled" value="'+obj[i].ALWNC_DAYCNT+'"/>';
					var useDate = 0;
					if(obj[i].useDate != null){
						useDate = obj[i].useDate;
					}
					html += '<input type="text" id="sub'+ i +'" name="" disabled="disabled" value="'+ useDate +'"/>';
					html += '</td>';
					html += '<td style="text-align: center;">';
					
					var maxDay = obj[i].maxDay;
					if(maxDay == "-"){
						maxDay = "${year}-12-31";
					}
					html += '<input type="text" id="" name="" disabled="disabled" value="'+ maxDay +'"/>';
					
					
					html += '</td>';
					html += '<td style="text-align: center;">';
					if(obj[i].PAY_YN == 'Y'){
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="유급"/>';
					}else{
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="무급"/>';
					}
					html += '</td>';
					html += '<td style="text-align: center;">';
					if(obj[i].BRMK != null){
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="'+obj[i].BRMK+'"/>';
					}else{
						html += '<input type="text" id="subMain'+ i +'" name="" disabled="disabled" value="-"/>';
					}
					html += '</td>';
					html += '</tr>';
				}
				$("#vacationType4").html(html);
			}
		});
	}
	
	//결재상신
	function save() {
		if(delegateHoliResult.length == 0){
			alert("신청내역이 없습니다.");
			return;
		}
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

		/*
		eadocPop = window.open('','_blank','scrollbars=yes, resizable=yes, width=900, height=900');
		if (approve == 'Y') {
			eadocPop = window.open('','_blank','scrollbars=yes, resizable=yes, width=900, height=900');
		}
		*/
		if (approKey != "") getApproKey = approKey;



		var params = {};

		params.compSeq = compSeq;
		params.empSeq = empSeq;
		params.targetEmpSeq = $("#selectEmpHidden").val();
		
		params.title= $("#eaTitle").val();
		var rRmk = "";
		for(var i = 0 ; i < delegateHoliResult.length ; i++){
			console.log("[ "+delegateHoliResult[i].reqRemark);
			console.log("[ "+delegateHoliResult[i]);
			rRmk = delegateHoliResult[i].reqRemark;
		}
		var duty = $("#dutyHidden").val();
		if(duty == null || duty == ""){
			duty = "${loginVO.classNm}";	
		}
		
		var data = {
			title : params.title,
			rmk : $("#reqRemark").val(),
			reRmk : rRmk,
			classNm : '${loginVO.classNm}',
			orgnztNm : $("#deptNameHidden").val(),
			empName : $("#empNameHidden").val(),
			dataList : delegateHoliResult,
			duty : duty
		}
		var key = 0;
		$.ajax({
			url : "/CustomNPKlti/vacation/insDocCert",
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
		//params.title = $("#titleHidden").val() + " 신청서";
		
		
		newVacSet(params);
		outProcessLogOn(params);
		window.close();

	}

	function newVacSet(e){
		for(var i = 0 ; i < delegateHoliResult.length ; i++){
			var speclSn = 0;
			var vcatnKndSn = 0;
			var vcatnSn = 0;
			if(delegateHoliResult[i].vacationType == 3){
				speclSn = delegateHoliResult[i].attDivCode;
			}else if(delegateHoliResult[i].vacationType == 4){
				speclSn = delegateHoliResult[i].attDivCode;
			} else {
				vcatnKndSn = delegateHoliResult[i].attDivCode;
				vcatnSn = delegateHoliResult[i].vcatnSn;
			}

			var startDate = delegateHoliResult[i].reqStartDate + " " + delegateHoliResult[i].startTime + ":" + delegateHoliResult[i].startMin;
			var endDate = delegateHoliResult[i].reqEndDate + " " + delegateHoliResult[i].endTime + ":" + delegateHoliResult[i].endMin;
			var data = {
				vcatnSn : vcatnSn,
				speclSn : speclSn,
				vcatnKndSn : vcatnKndSn,
				vcatnUseStdt : new Date(startDate.replace(/[.-]/gi, "/")),
				vcatnUseEndt : new Date(endDate.replace(/[.-]/gi, "/")),
				useDay : delegateHoliResult[i].annvUseDayCnt,
				approKey : e.approKey,
				rmk : delegateHoliResult[i].reqRemark,
				targetEmpSeq : e.targetEmpSeq,
				attTime : delegateHoliResult[i].attTime.replace(":",'')
			}


			$.ajax({
				url : '<c:url value="/vacation/newVacSet"/>',
				data : data,
				dataType : "json",
				type : "post",
				async : false
			});
		}
	}
	var check;
	function makeContentStr(e){

		var headHtml = document.querySelector('#EDIcontentsHead').innerHTML;
		headHtml =  headHtml.replace('{orgnztNm}', '${empInfo.orgnztNm}');
		headHtml =	headHtml.replace('{apply_position}', '${empInfo.classNm}');
		headHtml =  headHtml.replace('{apply_emp_name}', e.empName);


		/*var bodyHtml = document.querySelector('#EDIcontentsBody').innerHTML;*/
		var bodyHtml = "";

		for(var i=0; i < e.dataList.length ; i++){

			bodyHtml += '<TR>'
			bodyHtml += '<TD valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml +=	'<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">${empInfo.orgnztNm}</SPAN></P>';
			bodyHtml += '</TD>'
			bodyHtml += '<TD colspan="2" valign="middle" style="width:51px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml +=	'<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.empName+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '<TD valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">외출</SPAN></P>';
			bodyHtml +=	'</TD>';
			bodyHtml +=	'<TD valign="middle" style="width:84px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.dataList[i].reqStartDate + " " + e.dataList[i].startTime + ":00"+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '<TD colspan="2" valign="middle" style="width:83px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.dataList[i].reqEndDate + " " + e.dataList[i].endTime +":00  "+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '<TD colspan="2" valign="middle" style="width:76px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.dataList[i].attReqDayCnt+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '<TD valign="middle" style="width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.dataList[i].attTime+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '<TD valign="middle" style="width:106px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt">';
			bodyHtml += '<P CLASS=HStyle0 STYLE="text-align:center;line-height:130%;"><SPAN STYLE="font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%">'+e.dataList[i].reqRemark+'</SPAN></P>';
			bodyHtml += '</TD>';
			bodyHtml += '</TR>';
		}

		var footHtml = document.querySelector('#EDIcontentsFoot').innerHTML;
		footHtml = footHtml.replace('{all}', Math.floor($("#totalDay").text()));
		footHtml = footHtml.replace('{use2}', $("#useDay").text());
		footHtml = footHtml.replace('{rest}', $("#remainingDays").text());
		footHtml = footHtml.replace('{use4}', $("#minusDay").text());

		footHtml = footHtml.replace('{year}', "${nowDateToServer}".substring(0,4));
		footHtml = footHtml.replace('{month}', "${nowDateToServer}".substring(4,6))
		footHtml = footHtml.replace('{day}', "${nowDateToServer}".substring(6,8))

		check = e;
		return headHtml + bodyHtml + footHtml;
	}
	
	function addAnnualLeave() {
		var str = '';
		var attDivCode = $('#gt_sel').data("kendoComboBox").value();
		
		if (!attDivCode) {
			$('#from_date').data("kendoDatePicker").value(new Date());
			$('#to_date').data("kendoDatePicker").value(new Date());
			alert("<%=BizboxAMessage.getMessage("TX000012711","근태구분 값을 선택하여 주십시오", langCode)%>");
			return;
		}
		var remainingDays = $("#remainingDays").text();
		//var useDay = $("#dayCnt").val();
		var useDay = $("#useDayCnt").val();
		
		var vcationType = $(".vacationType.active").attr("key");
		if(Number(vcationType) != 4){
			if(Number(remainingDays) < useDay){
				alert("잔여일을 확인하세요.");
				return;
			}
		}
		
		//임시 데이터 시작
		var data = {

		};
		
		data.startDate = $("#from_date").val();
		data.startTime = $("#hour_sel_1").val();
		data.endDate = $("#to_date").val();
		data.endTime = $("#hour_sel_2").val();
		data.vcatnSn = $("#vcatnSn").val();
		data.vacationType = $(".vacationType.active").attr("key");
		data.startMin = $("#min_sel_1").val();
		data.endMin = $("#min_sel_2").val();
		data.attDivCode = $('#gt_sel').data("kendoComboBox").value();
		data.targetEmpSeq = $("#selectEmpHidden").val();
		
		for(var i = 0 ; i < delegateHoliResult.length ; i++){
			console.log("reqStartDate@" + delegateHoliResult[i].reqStartDate);
			console.log("startTime@" + delegateHoliResult[i].startTime);
			console.log("reqEndDate@" + delegateHoliResult[i].reqEndDate);
			console.log("endTime@" + delegateHoliResult[i].endTime);
			if($("#from_date").val() == delegateHoliResult[i].reqStartDate && $("#to_date").val() == delegateHoliResult[i].reqEndDate){
				if($("#hour_sel_1").val() == delegateHoliResult[i].startTime && $("#hour_sel_2").val() == delegateHoliResult[i].endTime){
					alert("해당 시간에 신청내역이 존재합니다.");
					return;
				}
				if($("#hour_sel_1").val() >= delegateHoliResult[i].startTime && ($("#hour_sel_2").val() == delegateHoliResult[i].endTime || $("#hour_sel_2").val() <= delegateHoliResult[i].endTime)){
					alert("해당 시간에 신청내역이 존재합니다.");
					return;
				}
				if($("#hour_sel_1").val() <= delegateHoliResult[i].startTime && ($("#hour_sel_2").val() <= delegateHoliResult[i].endTime || $("#hour_sel_2").val() >= delegateHoliResult[i].endTime || $("#hour_sel_2").val() == delegateHoliResult[i].endTime)){
					alert("해당 시간에 신청내역이 존재합니다.");
					return;
				}
			}
			/*
			if($("#to_date").val() == delegateHoliResult[i].reqEndDate){
				if($("#hour_sel_2").val() == delegateHoliResult[i].endTime){
					alert("해당 시간에 신청내역이 존재합니다.");
					return;
				}
			}
			*/
			/*
			if($("#hour_sel_1").val() == delegateHoliResult[i].startTime){
				alert("해당 시간에 신청내역이 존재합니다.");
				return;
			}
			if($("#hour_sel_2").val() == delegateHoliResult[i].endTime){
				alert("해당 시간에 신청내역이 존재합니다.");
				return;
			}
			*/
		}
		var vacationCheck = fn_vacationUseCheck(data);
		if(Number(vacationCheck) == 0){
			return;
		}
		if(Number(vcationType) == 4){
			$("#dayCnt").val("0");
			$("#useDayCnt").val("0");
		}
		data = {};
		var minusDay = $("#minusDay").text();
		var useDayCnt = $("#useDayCnt").val();
		$("#minusDay").text(Number(minusDay) + Number(useDayCnt));
		//$("#remainingDays").text(Number(remainingDays) - Number(useDayCnt));
		var listSize = Number(delegateHoliResult.length);
		
		data.vcatnSn = $("#vcatnSn").val();
		data.vacationType = $(".vacationType.active").attr("key");
		data.reqStartDate = $("#from_date").val();
		data.reqEndDate = $("#to_date").val();
		
		//data.compSeq = "${loginVO.compSeq}";
		//data.deptName = "${loginVO.orgnztNm}";
		//data.empName = "${loginVO.name}";
		//data.empSeq = "${loginVO.uniqId}";
		data.compSeq = $("#compSeqHidden").val();
		data.deptName = $("#deptNameHidden").val();
		data.empName = $("#empNameHidden").val();
		data.empSeq = $("#selectEmpHidden").val();
		
		
		data.attItemCode = attItemCode;
		data.attDivCode = $('#gt_sel').data("kendoComboBox").value();
		data.basicAnnvDayCnt = $("#useDayCnt").val();
		data.annvUseDayCnt = $("#useDayCnt").val();
		data.attDivName = $('#gt_sel').data("kendoComboBox").text();
		data.startTime = $("#hour_sel_1").val();
		data.endTime = $("#hour_sel_2").val();
		data.attReqDayCnt = $("#dayCnt").val();
		data.reqRemark = $("#reqRemark").val();
		data.attTime = attTimeReq;//신청일자 날짜비교 값 넣어주기
		data.restDayCnt = '';
		data.startMin = $("#min_sel_1").val();
		data.endMin = $("#min_sel_2").val();
		
		$("#titleHidden").val(data.attDivName);
		
		//삭제 및 중복 신청관련
		data.applyTypeStartDt = "" + $("#from_date").val() + $("#hour_sel_1").val() + $("#min_sel_1").val();
			console.log("" + $("#from_date").val() + $("#hour_sel_1").val() + $("#min_sel_1").val());
		data.applyTypeEndDt = "" + $("#to_date").val() + $("#hour_sel_2").val() + $("#min_sel_2").val();
			console.log( "" + $("#to_date").val() + $("#hour_sel_2").val() + $("#min_sel_2").val());
		data.key = "" + $("#from_date").val() + $("#hour_sel_1").val() + $("#min_sel_1").val() + $("#to_date").val() + $("#hour_sel_2").val() + $("#min_sel_2").val();
		delegateHoliResult[listSize] = data;
		
		
		//임시 데이터 끝
		
		for(var i = 0 ; i < (Number(listSize)+1) ; i++){
			//20180504 soyoung 삭세시 처리를 위해 저장
			var value = {};
			value.reqStartDate = delegateHoliResult[i].reqStartDate;
			value.reqEndDate = delegateHoliResult[i].reqEndDate;
			value.compSeq = delegateHoliResult[i].compSeq;
			value.empSeq = delegateHoliResult[i].empSeq;
			value.attItemCode = delegateHoliResult[i].attItemCode;
			value.attDivCode = delegateHoliResult[i].attDivCode;
			
			
			var basicAnnvDayCnt = delegateHoliResult[i].basicAnnvDayCnt || '-';
			var useDayCnt = delegateHoliResult[i].useDayCnt || 0;
			var useDayCntPro = delegateHoliResult[i].useDayCntPro || 0;
			var annvUseDayCnt = delegateHoliResult[i].annvUseDayCnt || 0;
			var deptName = delegateHoliResult[i].deptName;
			var empName = delegateHoliResult[i].empName;
			var attDivName = delegateHoliResult[i].attDivName;
			var reqStartDate = delegateHoliResult[i].reqStartDate;
			var startTime = delegateHoliResult[i].startTime;
			var reqEndDate = delegateHoliResult[i].reqEndDate;
			var endTime = delegateHoliResult[i].endTime;
			var attReqDayCnt = delegateHoliResult[i].attReqDayCnt || 0;
			var reqRemark = delegateHoliResult[i].reqRemark;
			var attTime = delegateHoliResult[i].attTime;
			var restDayCnt = delegateHoliResult[i].restDayCnt || 0;
			var startMin = delegateHoliResult[i].startMin;
			var endMin = delegateHoliResult[i].endMin;
			
			var keyOne = delegateHoliResult[i].applyTypeStartDt;
			var keyTwo = delegateHoliResult[i].applyTypeEndDt;
			//var id = i + "sel_" + delegateHoliResult[i].compSeq + "_" + delegateHoliResult[i].empSeq;
			var id = keyOne + keyTwo;
			if (annvUseYn == 'Y') {
				str += '<tr class="applyDataList" id="'+id+'a"><td>';
			} else {
				str += '<tr class="applyDataList" id="'+id+'a"><td>';
			}
			
			str += '<input type="checkbox" name="inp_chk" id="' + id + '" class="k-checkbox tbl2" value=\'' + annvUseDayCnt//JSON.stringify(value)
				+ '\'/><label class="k-checkbox-label chkSel" for="' + id + '" ></label>';
			str += '</td><td>';
			str += deptName;
			str += '</td><td>';
			str += empName;
			str += '</td><td>';
			str += attDivName;  //근태구분명
			str += '</td><td>';
			str += reqStartDate + "<br/>" + startTime + ":" +  startMin;
			str += '</td><td>';
			str += reqEndDate + "<br/>" + endTime + ":" +  endMin
			str += '</td><td>';
			str += attReqDayCnt; //신청일수
			str += '</td><td>';
			str += annvUseDayCnt;  //연차차감
			str += '</td><td>';
			str += attTime + " 시간";  //신청시간
			str += '</td></tr>';
			<%--
			str += '<tr><td colspan="8" class="le not_fir"><div class="rest_info_div mt0 fl"><ul>';
			str += '<li><dl><dt>&emsp;<%=BizboxAMessage.getMessage("TX000012962", "총 연차일수", langCode)%> : </dt><dd>' + basicAnnvDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000000860", "사용일수", langCode)%> : </dt><dd>' + attReqDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000012963", "잔여연차", langCode)%> : </dt><dd>' + restDayCnt + '</dd></dl></li>';
			str += '<li><dl><dt>|&emsp;<%=BizboxAMessage.getMessage("TX900001645", "결재 진행 연차", langCode)%> : </dt><dd>' + useDayCntPro + '</dd></dl></li>';
			str += '<li><dl><dt><%=BizboxAMessage.getMessage("TX000012941", "연차차감", langCode)%> : </dt><dd>' + annvUseDayCnt + '</dd></dl></li>';
			str += '</ul></div></td></tr>';
			--%>
		}
		var gtCombo = $("#gt_sel").data("kendoComboBox");
		gtCombo.value("");
		initCombobox($(".active").attr("key"));
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
	function allCheck(whoAreYou){
		if($("#"+whoAreYou.id).is(":checked")){
			$(".k-checkbox").not("#chk_time").prop("checked", true);
		}else{
			$(".k-checkbox").not("#chk_time").prop("checked", false);
		}
	}
	//신청내역삭제
	function delBtnClick(){
		var deleteGroup = $(".k-checkbox:checked").not("#chk_time, #table2AllCheck, #grid_all_chk");
		var deleteKey = [];
		for(var j = 0 ; j < deleteGroup.length; j++){
			deleteKey[j] = deleteGroup[j].id;
			for(var i = 0 ; i < delegateHoliResult.length ; i++){
				if(delegateHoliResult[i].key == deleteKey[j]){
					delegateHoliResult.splice(i, 1);
					var minusDay = $("#minusDay").text();
					minusDay = Number(minusDay) - Number(deleteGroup[j].value);
					$("#minusDay").text(minusDay);
					$("#"+deleteKey[j]+"a").remove();
				}
			}
		}
		$("#table2AllCheck").prop("checked", false);
	}
	//선택된 휴가정보 조회
	function fn_vacationInfo(pk){
		var keyType = $(".active").attr("key");
		var searchType = "";
		if(Number(keyType) == 1){
			//연가
			searchType = "V001";
			$("#theaderTh2").hide();
			$("#theaderTh").show();
		}
		if(Number(keyType) == 2){
			//장기근속인데.. 음..
			searchType = "V006";
			$("#theaderTh").hide();
			$("#theaderTh2").show();
		}
		if(Number(keyType) == 3){
			//특별휴가
			searchType = "V004";
		}
		if(Number(keyType) == 4){
			//특별휴가
			searchType = "V004";
		}
		var formData = {
				searchType : searchType,
				searchKey : pk,
				empSeq : $("#selectEmpHidden").val(),
				annvYear : $( "#from_date" ).val().split("-")[0]
		};
		$.ajax({
			type: 'POST',
			url: "<c:url value='/enrollment/vacationInfo'/>",
			data: formData,
			dataType: 'json',
			async: false,
			success: function(e) {
				var obj = e.obj;
				$("#totalDay").text("");
				$("#remainingDays").text("");
				$("#useDay").text("");
				$("#minusDay").text("");
				if(obj != null){
					console.log(obj);
					//부여일수
					var totalDay = obj.totalDay;
					//잔여일수
					var remainingDays = obj.remainingDays;
					//사용일수
					var useDay = obj.useDay;
					//결재진행연차 임시 0
					var ingDay = 0;
					var minusDay = 0;
					if(delegateHoliResult.length > 0){
						for(var i = 0 ; i < delegateHoliResult.length ; i++){
							minusDay += Number(delegateHoliResult[i].basicAnnvDayCnt);
							//useDay = Number(useDay) + Number(delegateHoliResult[i].annvUseDayCnt);
							//remainingDays = (Number(remainingDays) - Number(delegateHoliResult[i].annvUseDayCnt));
						}
					}
					if(Number(obj.YRVAC_MDTN_ALWNC_DAYCNT) > 0){
						remainingDays = Number(remainingDays) + Number(obj.YRVAC_MDTN_ALWNC_DAYCNT);
					}
					$("#totalDay").text(totalDay);
					$("#remainingDays").text(remainingDays);
					$("#useDay").text(useDay);
					$("#minusDay").text(minusDay);
					
					timeCalc();
				}
			}
		});
	}

	function initDate(){
		var toDate = $("#to_date").data("kendoDatePicker");
		var hourSel1 = $("#hour_sel_1").data("kendoComboBox");
		var minSel1 = $("#min_sel_1").data("kendoComboBox");
		var hourSel2 = $("#hour_sel_2").data("kendoComboBox");
		var minSel2 = $("#min_sel_2").data("kendoComboBox");

		toDate.enable(true);
		hourSel1.enable(true);
		minSel1.enable(true);
		hourSel2.enable(true);
		minSel2.enable(true);
		hourSel1.select(9);
		hourSel2.select(18);
	}

	function fn_specialClick(rowNumber, key){
		var gtCombo = $("#gt_sel").data("kendoComboBox");
		gtCombo.select(Number(rowNumber));
		fn_vacationInfo(key);
	}
	function fn_checkAuthority(){
		var loginEmpSeq = empSeq;
		var authorityList = fn_authorityCheck();
		if(authorityList.length > 0){
			
			empGrid();
			var grid = $("#requestDeptSeq").data("kendoComboBox");
			var rows = grid.options.dataSource;
			var record;
			var masterKey = "100000024";
			/*
			for(var i = 0 ; i < authorityList.length ; i++){
				for(var j = 0 ; j < rows.length ; j++){
					if(authorityList[i].deptSeq != rows[j].dept_seq){
						$("#requestDeptSeq_listbox > li:eq("+ j +")").hide(); 
					}else{
						$("#requestDeptSeq_listbox > li:eq("+ j +")").show();
					}
				}
			}
			grid.select(1);
			*/
		}else{
			$("#selectEmpInput").hide();
			$("#selectEmpHidden").val(empSeq);
		}
	}
	

	function fnTpfDeptComboBoxInit(id) {
		if ($('#' + id)) {
			var deptList = fnTpfGetDeptList();
			deptList.unshift({
				dept_name : '전체',
				dept_value : ""
			});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : deptList,
				dataTextField : "dept_name",
				dataValueField : "dept_value",
				index : 0,
				change : function() {
					fnDeptChange(this.value());
					$("#deptSeq").val(this.value());
					$("#requestDeptSeq").val(this.value());
				}
			});
			$(".k-input").attr("readonly", "readonly");
		}
	}
	function fnDeptChange(e) {
		var obj = $('#requestDeptSeq').data('kendoComboBox');
	}
	function fnTpfGetDeptList() {
		var result = {};
		var params = {};
		var opt = {
			url : "<c:url value='/vcatn/getAllDept'/>",
			async : false,
			data : params,
			successFn : function(data) {
				result = data.list;
			}
		};
		acUtil.ajax.call(opt);
		return result;
	}

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
				data.emp_name = $("#emp_name").val();
				data.dept_name = $("#requestDeptSeq").val();
				data.notIn = 'ok';
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


	function empGrid() {
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
									}/*,
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

			checkedIds[dataItem.CODE_CD] = checked;
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
				var str = "[" + record.dept_name + "]" + record.emp_name;
				$("#selectEmp").val(str);
				$('#requestDeptSeq').data('kendoComboBox').select(0);
				$("#selectEmpHidden").val(record.emp_seq);
				$("#empNameHidden").val(record.emp_name);
				$("#deptSeqHidden").val(record.dept_seq);
				$("#compSeqHidden").val(record.comp_seq);
				$("#deptNameHidden").val(record.dept_name);
				$("#dutyHidden").val(record.duty);
				
				$("#emp_name").val("");
				console.log(record);
				
				fn_vacationInfo(0);
				var gtCombo = $("#gt_sel").data("kendoComboBox");
				gtCombo.value("");
				initCombobox($(".vacationType.active").attr("key"));
				
				$("#cancle").click();
			});
		}
	}
	
	function empGridReload() {
 		$("#selectListDiv").empty();
		$("#empGrid").data('kendoGrid').dataSource.read();
	}
	
	
	function fn_authorityCheck(){
		var authority = new Array();
		var data = {
			"mgEmpSeq" : "${loginVO.uniqId}",
			"mgCompSeq" : "10163",
			"mgDeptSeq" : "${loginVO.dept_seq}",
			"mgGroupSeq" : "klti",
			"attManagerCode" : "210"
		};
		
		$.ajax({
			type: 'POST',
			url: "/attend/api/config/searchAttManagingTargets",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:'application/json; charset=utf-8',
			async: false,
			success: function(e) {
				var authorityList = e.result;
				if(authorityList.length > 0){
					authority = authorityList;
				}
			}
		});
		return authority;
	}
	
	function fn_vacationUseCheck(data){
		var vacationUseCheck = "0";
		var vcatnSn = "";
		if(data.vcatnSn != null || data.vcatnSn != ""){
			vcatnSn = data.vcatnSn;
		}
		
		var params = {
				startDate : data.startDate + " " + data.startTime + ":" + data.startMin,
				endDate : data.endDate + " " + data.endTime + ":" + data.endMin,
				vacationType : data.vacationType,
				attDivCode : data.attDivCode,
				vcatnSn : vcatnSn,
				targetEmpSeq : data.targetEmpSeq
		}
		
		$.ajax({
			type: 'POST',
			url: "<c:url value='/vcatn/vacationUseCheck'/>",
			data: params,
			dataType: 'json',
			async: false,
			success: function(result) {
				var obj = result.object;
				if(obj.state == "500"){
					alert(obj.message);
				}
				if(obj.state == "200"){
					vacationUseCheck = "1";
				}
			}
		});
		
		return vacationUseCheck;
	}
	
	function fn_headerSet(type){
		var html = "";
		/*
		if(Number(type) == 0){
			html += "<th style='text-align: center;padding-right: 0;'>구분</th>";
			html += '<th style="text-align: center;padding-right: 0;">부여일</th>';
			html += "<th style='text-align: center;padding-right: 0;'>사용일</th>";
			html += "<th style='text-align: center;padding-right: 0;'>잔여일</th>";
			html += "<th style='text-align: center;padding-right: 0;'>유효기간</th>";
			$("#theaderTh").empty();
			$("#theaderTh").append(html);
		}else{
			html += "<th style='text-align: center;padding-right: 0;'>구분</th>";
			html += "<th style='text-align: center;padding-right: 0;'>잔여일</th>";
			html += "<th style='text-align: center;padding-right: 0;'>사용일</th>";
			html += "<th style='text-align: center;padding-right: 0;'>유효기간</th>";
			html += "<th style='text-align: center;padding-right: 0;'>유/무급</th>";
			html += "<th style='text-align: center;padding-right: 0;'>비고</th>";
			$("#theaderTh").empty();
			$("#theaderTh").append(html);
		}
		*/
	}
	
	function hourReset(){
		var hourDatas = [];
		
		for (var addHour = 0; addHour < 24; addHour++) {
			var addHourData = addHour.toString();
			if (addHour < 10) {
				addHourData = '0' + addHourData;
			}
			
			hourDatas.push(addHourData);
		}
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
	}
</script>

<%-- 신청서 양식 --%>
<script id="EDIcontentsHead" type="text/template">
	<STYLE type="text/css">
		p.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		li.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		div.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		p.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
	</STYLE>
	<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>부 서</SPAN></P>
			</TD>
			<TD colspan="4" valign="middle" style='width:247px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{orgnztNm}</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:64px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-6%;line-height:160%'>직 위</SPAN></P>
			</TD>
			<TD colspan="3" valign="middle" style='width:217px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_position}</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>성 명</SPAN></P>
			</TD>
			<TD colspan="9" valign="middle" style='width:528px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_emp_name}</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>휴가의</SPAN></P>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>종 류</SPAN></P>
			</TD>
			<TD colspan="9" valign="middle" style='width:528px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>외출</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>부서</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:51px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>이름</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>근태구분</SPAN></P>
			</TD>
			<TD valign="middle" style='width:84px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>시작일자</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:83px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>종료일자</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:76px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청일수</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청시간</SPAN></P>
			</TD>
			<TD valign="middle" style='width:106px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>비고</SPAN></P>
			</TD>
		</TR>
</script>

<script id="EDIcontentsFoot" type="text/template">
	<TR>
		<TD colspan="11" valign="middle" style='width:640px;height:28px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
			<P CLASS=HStyle0 STYLE='text-align:right;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>총 연차일수 : {all}&#160; 사용일수 : {use2}&#160; 잔여일수 : {rest}&#160; 차감일수 : {use4}&#160; </SPAN></P>
		</TD>
	</TR>
	</TABLE>
	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'><BR><BR></SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";line-height:160%'>위와 같이 휴(공)가원을 제출하오니 허락하여 주시기 바랍니다.</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;&#160;&#160;&#160;&#160;&nbsp;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>
	<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
		<TR>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:71px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{year}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:23px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>년</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{month}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:16px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>월</SPAN></P>
			</TD>
			<TD valign="middle" style='width:49px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{day}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:17px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>일</SPAN></P>
			</TD>
			<TD valign="middle" style='width:107px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
		</TR>
	</TABLE>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>

	<P CLASS=HStyle0><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:18.0pt;font-family:"바탕";font-weight:bold;line-height:160%'>한국문학번역원</SPAN><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&nbsp;</SPAN></P>
</script>

<%--
<script id="EDIcontents" type="text/template">
	<STYLE type="text/css">
		p.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle0
		{style-name:"바탕글"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle1
		{style-name:"본문"; margin-left:15.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle2
		{style-name:"개요 1"; margin-left:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle3
		{style-name:"개요 2"; margin-left:20.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle4
		{style-name:"개요 3"; margin-left:30.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle5
		{style-name:"개요 4"; margin-left:40.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle6
		{style-name:"개요 5"; margin-left:50.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle7
		{style-name:"개요 6"; margin-left:60.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle8
		{style-name:"개요 7"; margin-left:70.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle9
		{style-name:"쪽 번호"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle10
		{style-name:"머리말"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle11
		{style-name:"각주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle12
		{style-name:"미주"; margin-left:13.1pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.1pt; line-height:130%; font-size:9.0pt; font-family:함초롬바탕; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle13
		{style-name:"메모"; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:130%; font-size:9.0pt; font-family:함초롬돋움; letter-spacing:-5%; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		li.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		div.HStyle14
		{style-name:"차례 제목"; margin-top:12.0pt; margin-bottom:3.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#2e74b5;}
		p.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle15
		{style-name:"차례 1"; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle16
		{style-name:"차례 2"; margin-left:11.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		p.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		li.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
		div.HStyle17
		{style-name:"차례 3"; margin-left:22.0pt; margin-top:0.0pt; margin-bottom:7.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:11.0pt; font-family:함초롬돋움; letter-spacing:0; font-weight:normal; font-style:normal; color:#000000;}
	</STYLE>
	<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>부 서</SPAN></P>
			</TD>
			<TD colspan="4" valign="middle" style='width:247px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{orgnztNm}</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:64px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-6%;line-height:160%'>직 위</SPAN></P>
			</TD>
			<TD colspan="3" valign="middle" style='width:217px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_position}</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>성 명</SPAN></P>
			</TD>
			<TD colspan="9" valign="middle" style='width:528px;height:39px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>{apply_emp_name}</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD colspan="2" valign="middle" style='width:111px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>휴가의</SPAN></P>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";letter-spacing:-2%;line-height:160%'>종 류</SPAN></P>
			</TD>
			<TD colspan="9" valign="middle" style='width:528px;height:46px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-10%;line-height:120%'>외출</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>부서</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:51px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>이름</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>근태구분</SPAN></P>
			</TD>
			<TD valign="middle" style='width:84px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>시작일자</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:83px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>종료일자</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:76px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청일수</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>신청시간</SPAN></P>
			</TD>
			<TD valign="middle" style='width:106px;height:24px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>비고</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD valign="middle" style='width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{orgnztNm2}</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:51px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{apply_emp_name2}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>외출</SPAN></P>
			</TD>
			<TD valign="middle" style='width:84px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{apply_start}</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:83px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{apply_end}</SPAN></P>
			</TD>
			<TD colspan="2" valign="middle" style='width:76px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{use}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:80px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{req_time}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:106px;height:35px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:130%'>{rmk}</SPAN></P>
			</TD>
		</TR>
		<TR>
			<TD colspan="11" valign="middle" style='width:640px;height:28px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='text-align:right;'><SPAN STYLE='font-size:8.5pt;font-family:"돋움";letter-spacing:-8%;line-height:160%'>총 연차일수 : {all}&#160; 사용일수 : {use2}&#160; 잔여일수 : {rest}&#160; 차감일수 : {use4}&#160; </SPAN></P>
			</TD>
		</TR>
	</TABLE>
	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'><BR><BR></SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-family:"바탕";line-height:160%'>위와 같이 휴(공)가원을 제출하오니 허락하여 주시기 바랍니다.</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;&#160;&#160;&#160;&#160;&nbsp;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&#160;&#160;</SPAN></P>

	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>
	<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-left: auto;margin-right: auto;'>
		<TR>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:71px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{year}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:23px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>년</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{month}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:16px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>월</SPAN></P>
			</TD>
			<TD valign="middle" style='width:49px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"굴림"'>{day}</SPAN></P>
			</TD>
			<TD valign="middle" style='width:17px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-family:"바탕체"'>일</SPAN></P>
			</TD>
			<TD valign="middle" style='width:107px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
			<TD valign="middle" style='width:47px;height:20px;border-left:solid #ece9d8 0.4pt;border-right:solid #ece9d8 0.4pt;border-top:solid #ece9d8 0.4pt;border-bottom:solid #ece9d8 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-family:"바탕체"'>&#8203;</SPAN></P>
			</TD>
		</TR>
	</TABLE>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:120%;'></P>

	<P CLASS=HStyle0><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><BR></P>

	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:18.0pt;font-family:"바탕";font-weight:bold;line-height:160%'>한국문학번역원</SPAN><SPAN STYLE='font-size:12.0pt;font-family:"바탕";line-height:160%'>&nbsp;</SPAN></P>
</script>--%>
