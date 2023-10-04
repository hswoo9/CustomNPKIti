<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"  %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>${title}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript">
    /* tiles : contents_tiles.jsp */ 
    </script>

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
    
    <script>
    
    $(document).ready(function(){
    	$(".k-combobox .k-input").addClass('kendoComboBox');
		$("#menuHistory li:last-child").addClass("on");
		
		// redirect msg 처리
		<c:if test="${not empty msg}">
			alert('${msg}');
		</c:if>
		
		 //datepicker
        $('.datePickerInput').kendoDatePicker({
        	culture : "ko-KR",
		    format : "yyyy-MM-dd",
		});
        
        $(".datePickerInput").attr("readonly", true);
    	
    });
    
        function init(){}
        
        _g_contextPath_ = "${pageContext.request.contextPath}";
        
		
    </script>


</head>

<body>
<div class="sub_wrap">
<div class="sub_contents">
	<div class="iframe_wrap">

		<!-- 컨텐츠타이틀영역 -->
<!-- 		<div class="sub_title_wrap"> -->
			<div class="location_info">
				 <ul id="menuHistory"></ul> 
			</div>
			<div class="title_div">
				<h4></h4>
			</div>  
			<script>
				try {
					
					var top = parent.getTopMenu();
					
					var hstHtml = '<li><a href="#n"><img src="'+_g_contextPath_+'/Images/ico/ico_home01.png" alt="홈">&nbsp;</a></li>';
					hstHtml += '<li><a href="#n">'+top.name+'&nbsp;</a></li>';  
					 
					var leftList = parent.getLeftMenuList();
					 
					if (leftList != null && leftList.length > 0) {
						for(var i = leftList.length-1; i >= 0; i--) {
							hstHtml += '<li><a href="#n">'+leftList[i].name+'&nbsp;</a></li>';
						} 
						
						$(".title_div").html('<h4>'+leftList[0].name+'&nbsp;</h4>');
					} else {
						$(".title_div").html('<h4>'+top.name+'&nbsp;</h4>');
					}
					
					$("#menuHistory").html(hstHtml);
					
				} catch (exception) {
				}
				
			   
			</script>
<!-- 		</div> -->
		
		<tiles:insertAttribute name="body" />
	
	</div><!-- //iframe wrap -->
</div>
</div>

</body>
</html>