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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css2/common.css">
	    
    <!--js-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	$("#searchButton").click(function() {		
		f_search();
	});
	
	$("#confirmButton").click(function() {		
		f_confirm();
	});
	
	$("#closeButton").click(function() {		
		self.close();
	});
	
	$(".clo").click(function() {		
		self.close();
	});
});

function f_search(){	
	var form1 = document.searchForm;
	form1.action = "${pageContext.request.contextPath}/trip/pop/tripAreaPop";
	form1.submit();	
}

function f_confirm(){
	
	if($("#areaSeq").val() == ""){
		alert("<%=DJMessage.getMessage("TX000020677","출장지를 선택해주세요.", langCode)%>");
		return;
	}
	
	var opener = window.opener;
	var form = eval("opener.regForm" + $("#costDiv").val());	
	eval("form.area_seq_" + $("#costDiv").val()).value = $("#areaSeq").val();
	eval("form.areaname_" + $("#costDiv").val()).value = $("#areaname").val();
	self.close();
}

function f_select(seq, title, type){
	$("#areaSeq").val(seq);
	$("#areaname").val(title);
	$("#areaTable > tbody > tr").removeClass("on");
	document.getElementById("row_" + seq).className = "on";
	
	if(type == 'dbl'){
		f_confirm();
	}	
}
</script>
</head>
<body>
	<div class="pop_wrap">
		<div class="pop_head">
			<h1><%=DJMessage.getMessage("TX000004662","출장지", langCode)%> <%=DJMessage.getMessage("TX000019777","선택", langCode)%><c:if test="${domesticDiv == 'L' }">(<%=DJMessage.getMessage("TX000015728","국내", langCode)%>)</c:if><c:if test="${domesticDiv == 'F' }">(<%=DJMessage.getMessage("TX000020684","국외", langCode)%>)</c:if></h1>
			<a href="#n" class="clo"><img src="${pageContext.request.contextPath}/Images/btn/btn_pop_clo02.png" alt="" /></a>
		</div>			
			
		<div class="pop_con">
			<div class="top_box">
			<form name="searchForm" id="searchForm" method="post" action="${pageContext.request.contextPath}/trip/pop/tripAreaPop">
				<input type="hidden" id="domesticDiv" name="domesticDiv" value="${domesticDiv }" />
				<input type="hidden" id="costDiv" name="costDiv" value="${costDiv }" />
				<input type="hidden" id="localYn" name="localYn" value="${localYn }" />
				<input type="hidden" id="areaSeq" name="areaSeq" />
				<input type="hidden" id="areaname" name="areaname" />
				<dl>
					<dt><%=DJMessage.getMessage("","출장지명", langCode)%></dt>
					<dd><input type="text" name="searchWord" id="searchWord" value="${searchWord }" style="width:200px;"/></dd>
					<dd><input type="button" id="searchButton" value="<%=DJMessage.getMessage("TX000001289","검색", langCode)%>" /></dd>
				</dl>
			</form>
			</div>

			<div class="com_ta2 sc_head mt15">
				<table>
					<colgroup>				
						<col width="34" />
						<col width="35%" />
						<col width="" />
					</colgroup>
					<thead>
						<tr>
							<th>no</th>
							<th><%=DJMessage.getMessage("","출장지명", langCode)%></th>
							<th><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
						</tr>
					</thead>
				</table>
			</div>
			
			<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height:333px;">
				<table id="areaTable">
					<colgroup>				
						<col width="34" />
						<col width="35%" />
						<col width="" />
					</colgroup>
					<tbody>						
						<c:choose>			
							<c:when test="${not empty tripAreaListPop}">
								<c:forEach items="${tripAreaListPop}" var="list" varStatus="status">
									<tr id="row_${list.areaSeq}" onclick="f_select('${list.areaSeq}', '${list.areaname}', 'one')" ondblclick="f_select('${list.areaSeq}', '${list.areaname}', 'dbl')"><!-- 선택 로우 클래스 on -->	
										<td>${status.count}</td>
										<td>${list.areaname}</td>
										<td class="le">${list.note}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3"><%=DJMessage.getMessage("TX000017974","데이터가 존재하지 않습니다.", langCode)%></td>
								</tr>
							</c:otherwise>						
						</c:choose>
					</tbody>
				</table>								
			</div>
		</div><!--// pop_con -->
		
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" id="confirmButton" value="<%=DJMessage.getMessage("TX000000078","확인", langCode)%>" />
				<input type="button" id="closeButton" class="gray_btn" value="<%=DJMessage.getMessage("TX000002947","취소", langCode)%>" />
			</div>
		</div><!-- //pop_foot -->
	</div><!--// pop_wrap -->
</body>
</html>