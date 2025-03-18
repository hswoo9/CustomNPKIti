<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
<title>Home</title>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>
<body>
<script type="text/javascript">
	
	$(function(){
		$('#excelUp').on('click', function() {
			$.ajax({
				url: "${pageContext.request.contextPath}/personInfo/excelUploadAjax2",
				dataType : 'text',
				type : 'POST',
				success : function(result){
					
					
				}
			})
		})
		
		$('button[type=submit]').click(function(e) {
			e.preventDefault();
			
			$(this).prop('disabled', true);
			
			var form = document.forms[0];
			var formData = new FormData(form);
			
			var ajaxReq = $.ajax({
				url : '${pageContext.request.contextPath}/fileUpload' ,
				type : 'POST' ,
				data : formData ,
				cache : false ,
				contentType : false ,
				processData : false ,
				xhr : function() {
					
					var xhr = $.ajaxSettings.xhr();
					
					xhr.upload.onprogress = function(event) {
						var perc = Math.round((event.loaded / event.total) * 100);
						$('#progressBar').text(perc + '%');
						$('#progressBar').css('width', perc + '%');
					};
					return xhr;
					
				},
				beforeSend : function( xhr ) {
					
					$('#alertMsg').text(' ');
					$('#progressBar').text(' ');
					$('#progressBar').css('width' , '0%');
				}
				
			});
			
			ajaxReq.done(function(msg) {
				
				$('#alertMsg').text(msg);
				$('input[type=file]').val(' ');
				$('button[type=submit]').prop('disabled' , false);
				
			});
			
		});
			
	});

</script>


<style>
table {
	width: 1000px;
	border: 1px;
	border-style: solid;
}

table tr td {
	border: 1px;
	border-style: solid;
	height: 40px;
}

.k-header .k-link {
	text-align: center;
}

.k-grid-content>table>tbody>tr {
	text-align: center;
}
</style>


	<h1>커스텀개발</h1>
	<p>휴가</p>
	<table>
		<tr>
			<th>화면경로</th>
			<th>url(xxxx.jsp)</th>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>외출/복귀</td>
			<td><a href="/enrollment/outReturnInfo.do">outReturnInfo.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>휴가 종류 등록</td>
			<td><a href="/enrollment/enrollment.do">enrollment.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>연가 설정</td>
			<td><a href="/enrollment/vacationSet.do">vacationSet.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>장기근속휴가 설정</td>
			<td><a href="/longVacSet/longVacSet.do">longVacSet.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>특별휴가 설정</td>
			<td><a href="/enrollment/specialVacSet.do">specialVacSet.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>기타휴가 설정</td>
			<td><a href="/etc/specialVacSetEtc.do">specialVacSetEtc.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>연가 생성</td>
			<td><a href="/enrollment/vacationCr.do">vactionCr.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>특별휴가 생성</td>
			<td><a href="/enrollment/specialVacCr.do">specialVacCr.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>기타휴가 생성</td>
			<td><a href="/etc/specialVacCrEtc.do">specialVacCrEtc.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>휴가현황관리</td>
			<td><a href="/enrollment/adminVacList.do">adminVacList.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>개인휴가현황(사용자)</td>
			<td><a href="/vcatn/myVacation.do">myVacation.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>개인휴가현황(관리자)</td>
			<td><a href="/vcatn/adminVacation.do">adminVacation.jsp</a></td>
		</tr>
		<tr>
			<td><p style="color: red"> * new</p>장기근속휴가(유효기간)</td>
			<td><a href="/etc/etcJsp.do">etcJsp.jsp</a></td>
		</tr>
		<!-- <tr>
			<td><p style="color: red"> * new</p>휴가 신청</td>
			<td><a href="/enrollment/vacationApp.do">vacationApp.jsp</a></td>
		</tr>  -->
		<tr>
			<td><p style="color: red"> * new</p>휴가 신청서</td>
			<td><a href="javascript: fn_popup('/other/online/vacationPop.do');">vacationPop.jsp</a></td>
			<script>
				function fn_popup(name){
					window.open("<c:url value='"+name+"'/>");
				}
			</script>
		</tr>
	</table>
	<br />
	<table>
		<tr>
			<th>화면경로</th>
			<th>URL(xxxx.jsp)</th>
		</tr>
		<tr>
			<td>공통코드</td>
			<td><a href="${pageContext.request.contextPath}/commcode/commCodeView">commCodeView.jsp</a></td>
		</tr>
		<tr>
			<td>*마일리지 조회(관리자)</td>
			<td><a href="${pageContext.request.contextPath }/airlineMileage/mileageAdminView">mileageAdminView.jsp</a></td>
		</tr>
		<tr>
			<td>*마일리지 조회(사용자)</td>
			<td><a href="${pageContext.request.contextPath }/airlineMileage/mileageUserView">mileageUserView.jsp</a></td>
		</tr>
		<tr>
			<td>*마일리지 등록</td>
			<td><a href="${pageContext.request.contextPath }/airlineMileage/mileageReq">mileageReq.jsp</a></td>
		</tr>
		<tr>
			<td>*시간외/휴일근무 설정</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/overWkAdmin">overWkAdmin.jsp</a></td>
		</tr>
		<tr>
			<td>*시간외근무 신청</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/overWkReq">overWkReq.jsp</a></td>
		</tr>
		<tr>
			<td>*휴일근무 신청</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/holidayWkReq">holidayWkReq.jsp</a></td>
		</tr>
		<tr>
			<td>시간외근무  승인</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/overWkAdminApp">overWkAdminApp.jsp</a></td>
		</tr>
		<tr>
			<td>휴일근무  조회(개인)</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/holidayWkPrivateView">holidayWkPrivateView.jsp</a></td>
		</tr>
		<tr>
			<td>휴일근무  조회(인사)</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/holidayWkAdminView">holidayWkAdminView.jsp</a></td>
		</tr>
		<tr>
			<td>휴일근무 승인</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/holidayWkAdminApp">holidayWkAdminApp.jsp</a></td>
		</tr>
		<tr>
			<td>시간외근무 개인 조회</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/overWkPrivateView">overWkPrivateView.jsp</a></td>
		</tr>
		<tr>
			<td>시간외근무 인사 조회</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/overWkAdminView">overWkAdminView.jsp</a></td>
		</tr>
		<tr>
			<td>*보상휴가 현황&신청</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/subHolidayReq">subHolidayReq.jsp</a></td>
		</tr>
		<tr>
			<td>보상휴가 승인</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/subHoliAdminApp">subHoliAdminApp.jsp</a></td>
		</tr>
		<tr>
			<td>보상휴가 조회(인사)</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/subHoliAdminView">subHoliAdminView.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 근무유형 관리자 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workTypeAdmin">workTypeAdmin.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 개인 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workPlanUser">workPlanUser.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 신청 승인 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workPlanReqAdmin">workPlanReqAdmin.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 변경신청 승인 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workPlanChangeAdmin">workPlanChangeAdmin.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 개인 조회 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workPlanListPrivateView">workPlanListPrivateView.jsp</a></td>
		</tr>
		<tr>
			<td>유연근무 전체 조회 화면</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/workPlanListView">workPlanListView.jsp</a></td>
		</tr>
		<tr>
			<td>근태기록현황 (개인)</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/scheduleUser">scheduleUser.jsp</a></td>
		</tr>
		<tr>
			<td>근태기록현황 (부서)</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/scheduleDept">scheduleDept.jsp</a></td>
		</tr>
		<tr>
			<td>근태기록현황 (인사)</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/scheduleAdmin">scheduleAdmin.jsp</a></td>
		</tr>
		<tr>
			<td>신청현황(인사)</td>
			<td><a href="${pageContext.request.contextPath }/subHoliday/reqList">reqList.jsp</a></td>
		</tr>
<%--		<tr>
			<td>집합교육 신청</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/groupEduRegView">groupEduRegView.jsp</a></td>
		</tr>
		<tr>
			<td>집합교육 승인</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/groupEduAppView">groupEduAppView.jsp</a></td>
		</tr>
		<tr>
			<td>집합교육 이수 등록</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/groupEduFinView">groupEduFinView.jsp</a></td>
		</tr>
		<tr>
			<td>개별교육 이수 신청</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/privateEduRegView">privateEduRegView.jsp</a></td>
		</tr>
		<tr>
			<td>개별교육 이수 승인</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/privateEduAdminView">privateEduAdminView.jsp</a></td>
		</tr>
		<tr>
			<td>온라인교육 이수 등록</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/onlineEduUploadView">onlineEduUploadView.jsp</a></td>
		</tr>
		<tr>
			<td>교육현황(개인)</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/privateEduStsView">privateEduStsView.jsp</a></td>
		</tr>
		<tr>
			<td>교육현황(전체)</td>
			<td><a href="${pageContext.request.contextPath }/educationManagement/adminEduStsView">adminEduStsView.jsp</a></td>
		</tr>
		<tr>
			<td>가족의날</td>
			<td><a href="${pageContext.request.contextPath }/workPlan/dayOfFamilyAdmin">dayOfFamilyAdmin.jsp</a></td>
		</tr>
		
 		<tr><th colspan="2">여기부터 출장</th></tr>
		<tr>
			<td>출장지관리</td>
			<td><a href="${pageContext.request.contextPath }/trip/manageTripArea">manageTripArea.jsp</a></td>
		</tr>
		<tr>
			<td>직책그룹관리</td>
			<td><a href="${pageContext.request.contextPath }/trip/manageTripPositionGroup">manageTripPositionGroup.jsp</a></td>
		</tr>
		<tr>
			<td>교통수단관리</td>
			<td><a href="${pageContext.request.contextPath }/trip/manageTripTrans">manageTripTrans.jsp</a></td>
		</tr>
		<tr>
			<td>출장비단가관리</td>
			<td><a href="${pageContext.request.contextPath }/trip/manageTripCost">manageTripCost.jsp</a></td>
		</tr> --%>
		
	</table>
	<iframe src="${pageContext.request.contextPath }/layout/defaultIframe" width="100%">
	
	</iframe>
	<iframe src="${pageContext.request.contextPath }/layout/defaultIframeMailSso" width="100%">
	
	</iframe>
	<iframe src="${pageContext.request.contextPath }/layout/defaultIframeReqList" width="100%">
	
	</iframe>
	
	
</body>
</html>
