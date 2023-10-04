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

<!--Kendo ui css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common-custom.min.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.mobile.all.min.css' />">

<!-- Theme -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

<!--Kendo UI customize css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css' />">

<script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/js/Scripts/jqueryui/jquery-ui.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>"/>

<!--jsTree css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/jstree/style.min.css'/>">

<!--js-->
<script type="text/javascript" src="<c:url value='/js/Scripts/jquery-1.9.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/jqueryui/jquery-ui.min.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/Scripts/common.js'/>"></script>

<!--jsTree js-->
<script type="text/javascript" src="<c:url value='/js/Scripts/jstree/jstree.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/cultures/kendo.culture.ko-KR.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/js/common/ctCommon.js'/>"></script>
<script src="<c:url value='/js/common/moment.min.js' /> "></script>

<style type="text/css">
	.btn_lg {
		width: 100px;
		height: 36px !important;
		font-size: 15px;
	}
	.k-header .k-link {
		text-align: center;
		font-size: 12px;
	}
	.k-grid-content>table>tbody>tr {
		text-align: center;
		font-size: 12px;
	}
	.k-grid th.k-header, .k-grid-header {
		background: #F0F6FD;
		font-size: 12px;
	}
	.master-col {
		width: 160px;
	}
	.iframe_wrap {
		padding: 0px !important;
		font-size: 12px;
	}
	.sub_contents_wrap {
		min-height: 0px !important;
	}
	body {
		overflow-y: hidden; 
		overflow-x: hidden;
	}
	img {
		cursor: pointer;
	}
</style>

<script type="text/javascript">
	$(function(){
		//console.log('${empInfo}');
		//console.log('${nowDateToServer}');
		/* var data = {};
		data.cid = '200914';
		data.cpw = "#!@klti" + "${nowDateToServer}";
		data.Pw_type = "4";
		data.Cdomain = "mail.klti.or.kr";
		data.Return_url = "/webmail/lists";
		var formData = new FormData();
		formData.append('cid', '200914');
		formData.append('cpw', "#!@klti" + "${nowDateToServer}");
		formData.append('Pw_type',  "4");
		formData.append('Cdomain', "mail.klti.or.kr");
		formData.append('Return_url', "/webmail/lists");
		$.ajax({
			type : 'POST',
			async: false,
			url : 'https://mail.klti.or.kr/lw_api/auth_sso',
			//dataType: 'json',
			data: formData,
			cache: false,
			contentType: false,
			processData: false,
			success : function(result) {
				console.log('result', result);
			},
			error: function(req, status, error){
				console.log('req', req);
				console.log('status', status);
				console.log('error', error);
			}
		}); */
		$(document).on('click', '#mail-sso-banner', function(){
			//$('[name="cid"]').val("100301");
			$('[name="cid"]').val("${empInfo.id}");
			$('[name="cpw"]').val("#!@klti" + "${nowDateToServer}");
			$('[name="pw_type"]').val("4");
			$('[name="cdomain"]').val("mail.klti.or.kr");
			$('[name="return_url"]').val("/webmail/lists");
			window.open("", "kltiMailSSO");
			$('#kltiMailSSO').submit();
			//이화균 차장님
			//010-3648-1794
		});
	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>일일근태현황</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap" style="background-color: #f0f3f3; width: 226px; height: 226px;">	
		
		<img alt="mail-sso-banner" id="mail-sso-banner" src="<c:url value='/Images/temp/klti_mail.JPG'/>">
		<!--  
		https://mail.klti.or.kr/lw_api/auth_sso
		https://mc16.mailplug.co.kr/lw_api/auth_sso
		-->
		<form id="kltiMailSSO" name="kltiMailSSO" method="post" action="https://mail.klti.or.kr/lw_api/auth_sso" target="kltiMailSSO">
			<input type="hidden" name="cid"/>
			<input type="hidden" name="cpw"/>
			<input type="hidden" name="pw_type"/>
			<input type="hidden" name="cdomain"/>
			<input type="hidden" name="return_url"/>
		</form>
	</div>	
</div>




