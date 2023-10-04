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
<style>
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
	cursor: pointer;
	border-bottom: 1px solid #e7e7e7
}

h2 span{
	color: #000000;
	font-family: NSR;
	cursor: pointer;
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
<body>

<script type="text/javascript">

	$(function(){
		console.log("${approvalList}");
		$(".location_info").remove();

		var width = $(this).width();
		var height = $(this).height();
		
		$(".iframeBox").addClass("col"+Math.floor(width/108)+" row"+Math.floor(height/108));
		
		$("body").width(width);
		$("body").height(height);
		
		$(".iframe_wrap").width(width);
		$(".iframe_wrap").height(height);
		
		$("#portletView").width(width);
		$("#portletView").height(height);
		
		$(".portletDiv").width(width);
		$(".portletDiv").height(height);

		$(".ptl_board").height(height-44);
		
	});
	
	function empListPop(){
		
		var undo = $("#popLink");

		undo.click(function(){
			
			var win = window.open("mainPageUserChartPop","popup","width=1000px,height=800px,scrollbars=yes,resizable=yes");
			
		});

	};
	
	function mainPage(url){
		
		var left = (screen.width - 1200)/2;
        var top = (screen.height - 800)/2;
		var windowFeatures = "width= 1200,height=800,status,resizable,scrollbars,left=" + left + ",top=" + top +
        ",screenX=" + left + ",screenY=" + top;

		var win = window.open(url, '필요승인건수', windowFeatures);
	}
	
	 function detail(url) 
     {                        
         getListWin('1200', '800', '', '', url, '', '', '', '', '');
     }
     function getListWin(widthSize, heightSize, winNM, winTitle, url, formObjNM, nextObjNM, cdObjNM, nmObjNM, val) {
         var width = widthSize;
         var height = heightSize;
         var left = (screen.width - width)/2;
         var top = (screen.height - height)/2;
         var windowFeatures = "width=" + width + ",height=" + height +
         ",status,resizable,scrollbars,left=" + left + ",top=" + top +
         ",screenX=" + left + ",screenY=" + top;                    
         var win = window.open(url);
     }
     
 	function testSubmit(){
 		
 		$("body", parent.document).find("#no").val(400000000);
		$("body", parent.document).find("#name").val("업무관리");
		$("body", parent.document).find("#url").val("");
		$("body", parent.document).find("#urlGubun").val("project");
		
		$("body", parent.document).find("#form").action="bizbox.do";
 		
		$("body", parent.document).find("#form").submit();
 		
	}
     


</script> 
	<div id="portletView" class="portletGrid grid10 nonGrid" style="position: relative;">
		<div class="portletDiv">
			<div class="iframeBox">	
			<h2 name="portletTemplete_board_more" style="cursor:pointer;" class="bd" onclick="">
				<span name="portletTitle">필요승인건수</span>
<!-- 				<a href="javascript:mainPage('https://www.ntis.go.kr/rndgate/eg/un/ra/mng.do')" class="more" title="더보기"></a> -->
			</h2>
				<div name="portletTemplete_board_list" class="ptl_content nocon">
					<div class="ptl_board freebScrollY">
						<ul>
							<c:forEach var = "list" items = "${approvalList}">
							<li>
								<dl>
									<dt class="title">
										<a title="${list.category} " href = "javascript:detail('${list.url}')">${list.category}</a>
<%-- 										<a title="${list.category} " href = "javascript:detail('${list.url}')" style="text-align:right;">${list.cnt} 건</a> --%>
									</dt>
<%-- 									<dd class="date"><a title="${list.cnt} " href = "javascript:detail('${list.url}')">${list.cnt} 건</a></dd>  --%>
									<dd class="date">${list.cnt} 건</dd>
<%-- 												<dd class="date" style="font-family: '돋움',Dotum,'굴림',Gulim,sans-serif;direction: ltr;list-style: none;font-size: 12px;line-height: 27px;padding: 0;float: right;text-align: right;color: #8d8d8d;margin: 0 0px 0 0;">${list.write_date} </dd> --%>
								</dl>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

