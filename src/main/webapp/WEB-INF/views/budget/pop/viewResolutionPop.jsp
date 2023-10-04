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
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<fmt:formatDate value="${weekDay}" var="weekDay" pattern="E" type="date" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>

<script type="text/javascript">

var empSeq = "${empSeq}";

 $(function() {
	 
	 $.ajax({
			url : _g_contextPath_+ "/budget/selectLoginHistory",
			data : { empSeq : empSeq },
			type : "POST",
			success : function(result){				
				$("#access_ip").html(result.loginHistoryList[0].access_ip);
				$("#yyyymmdd").html(result.loginHistoryList[0].yyyymmdd + '<span style="margin-left: 5px;" id="hhii"></span>');
				$("#hhii").html("(" + result.loginHistoryList[0].hhii + ")");
			}
		});
 })
 
 function mvLnbMenu() {
	 parent.mainmenu.mainToLnbMenu('800000000', '마이페이지', '/CustomNPKlti/budget/loginHistory', '', '', 'main', '800000000', '2019042232', '로그인 기록조회', 'main');
 }

</script>
<!-- #f1faff -->
<body style="overflow: hidden;">
	<div style="background: #f1faff; cursor: pointer;" onclick="mvLnbMenu()">
		<div style="height:36px;  border-bottom: 1px solid #e7e7e7;">
			<span style="font-family: NSB; color: #1c90fb; top:11px; margin-left: 15px; position: relative;">마지막 로그인 기록</span>
		</div>
	</div>
	<div>
		<p style="margin-left: 10px; margin-top: 13px;     font-family: NSB;"></p>
		<p style="margin-left: 10px; font-family: NSB;" id="yyyymmdd"> <span style="margin-left: 2px;" id="hhii"></span></p>
		<p style="margin-left: 10px; font-family: NSB;" id="access_ip"></p>
	</div>
</body>