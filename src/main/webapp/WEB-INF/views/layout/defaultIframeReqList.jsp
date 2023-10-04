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

<script type="text/javascript" src="<c:url value='/js/Scripts/jquery-1.9.1.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/common.js'/>"></script>

<script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script>

<script type="text/javascript" src="<c:url value='/js/neos/systemx/systemx.main.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/systemx/systemx.menu.js' />"></script>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/layout_freeb.css?ver=20190807'/>"/>

<!-- portlet  -->

<link rel="stylesheet" type="text/css" href="<c:url value='/css/portlet/common.css?ver=20190807'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/portlet/animate.css'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/portlet/pudd.css?ver=20190807'/>"/>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/portlet/portlet.css?ver=20190807'/>"/>

<!--js-->
<script type="text/javascript" src="<c:url value='/js/pudd-1.1.84.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/jqueryui/jquery-ui.min.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/moment.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common_freeb.js?ver=20190807'/>"></script>

<!-- mCustomScrollbar -->
 <link rel="stylesheet" type="text/css" href="<c:url value='/js/mCustomScrollbar/jquery.mCustomScrollbar.css'/>">
 <script type="text/javascript" src="<c:url value='/js/mCustomScrollbar/jquery.mCustomScrollbar.js'/>"></script>

<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>

<script src="http://malsup.github.com/jquery.form.js"></script>

<style type="text/css">
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
.a_btn {
	padding: 0 12px;
    background: #1088e3;
    height: 24px;
    color: #fff;
    border: 0px !important;
    font-weight: bold;
    vertical-align: middle;
    font: 400 13.3333px Arial;
    display: inline-block;
    line-height: 1.8;
}
h2{
	position: relative;
	color: #000000;
	font-size: 0px;
	height: 29px;
	width : 100%
	border-bottom: 1px solid #e7e7e7;
	margin: 0;
	font-family: NSR;
	background: #f1faff url('../Images/portlet_tit_s.png') no-repeat 14px -132px;
	padding: 14px 0 0 42px;
	/*cursor: pointer;*/
	border-bottom: 1px solid #e7e7e7
}

h2 span{
	color: #000000;
	font-family: NSR;
	/*cursor: pointer;*/
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	display: inline-block;
	margin-left: 6px;
	font-size: 14px;
}

h2 a.more{
 	display: block;
    position: absolute;
    top: 16px;
    right: 9px;
    width: 7px;
    height: 12px;
 	background:url('../Images/portlet_titleBox_more.png') no-repeat; 
}

.iframe_wrap{
	padding : 0px;
	overflow : hidden;
	min-width : 0px;
}
</style>

<script type="text/javascript">
	$(function(){		
		$(".location_info").remove();

		var width = $(this).width();
		var height = $(this).height();
		
		//$(".iframeBox").addClass("col"+Math.floor(width/108)+" row"+Math.floor(height/108));
		$(".iframeBox").addClass('col6 row2');
		$("body").width(width);
		$("body").height(height);
		
		$(".iframe_wrap").width(width);
		$(".iframe_wrap").height(height);
		
		$("#portletView").width(width);
		$("#portletView").height(height);
		
		$(".portletDiv").width(width);
		$(".portletDiv").height(height);

		$(".ptl_board").height(height-44);
		
		$.getJSON('${pageContext.request.contextPath}/subHoliday/defaultIframeReqList',
				{'approval_emp_seq': '${empInfo.empSeq}'},
				function(json){
					var reqList = json.list,
						html = '';
					$.each(reqList, function(i, v){
						if(v.category !== '유연근무 일별변경신청' && v.category !== '보상휴가 신청'){
							html += '<li>';
							html += '<dl>';
							html += '<dt class="title">';
							html += '<a href="${pageContext.request.contextPath}'+ v.url +'" target="_blank">' + v.category + '</a>';
							html += '</dt>';
							html += '<dd class="date">' + v.reqCnt + '건</dd>';
							html += '</dl></li>';
						}
					});
					
					$('#appendReqList').empty().append(html);
				});		
	});
</script>
<div id="portletView" class="portletGrid grid10 nonGrid" style="position: relative;">
	<div class="portletDiv">
		<div class="iframeBox">	
		<h2 name="portletTemplete_board_more" style="" class="bd" onclick="">
			<span name="portletTitle">필요승인건수</span>
		</h2>
			<div name="portletTemplete_board_list" class="ptl_content nocon">
				<div class="ptl_board freebScrollY">
					<ul id="appendReqList">
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>



