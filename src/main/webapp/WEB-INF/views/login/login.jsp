<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Bizbox A</title>
    
    <!--Kendo ui css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/kendoui/kendo.common.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/kendoui/kendo.dataviz.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/kendoui/kendo.mobile.all.min.css' />">
    
    <!-- Theme -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/kendoui/kendo.silver.min.css' />" />

	<!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css' />">
	
	<!--Kendo UI customize css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/reKendo.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/resources/js/Scripts/jquery-1.9.1.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/Scripts/common.js' />"></script>
    
    <!--Kendo ui js-->
    <script type="text/javascript" src="<c:url value='/resources/js/kendoui/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/resources/js/kendoui/kendo.all.min.js' />"></script>
    
    <script>
    	$(document).ready(function(){
    
		    /*리사이즈*/
		    var loginWidth = $('#login_a2_type').width();
		    var loginHeight = $('#login_a2_type').height();
		    $('#login_a2_type').css("margin-top",-loginHeight*0.5);
		    $('#login_a2_type').css("margin-left",-loginWidth*0.5);
		    
		    $(window).resize(function(){
		        var loginWidth = $('#login_a2_type').width();
			    var loginHeight = $('#login_a2_type').height();
			    $('#login_a2_type').css("margin-top",-loginHeight*0.5);
			    $('#login_a2_type').css("margin-left",-loginWidth*0.5);
		    });
		    
		});
		
		
		//focus이벤트
		function focusInput(id) {
		    $("#" + id + "_label").text("");
		}
		
		//blur이벤트
		function blurInput(id) {
		    if ($("#" + id).val() == "") {
		        var msg = "";
		        switch (id) {
		            case "userId":
		                msg = "아이디";
		                break;
		            case "userPw":
		                msg = "비밀번호";
		                break;
		        }
		        $("#" + id + "_label").text(msg + " 입력");
		    }
		}
    </script>
    
</head>

<body class="login_a2_type_bg">
	
	<div id="login_a2_type">
        <div class="login_wrap">
        	<div class="company_logo">
				<img src="<c:url value='/resources/Images/temp/duzon_logo2.png' />" alt="" id="">
			</div>
            <div class="login_form_wrap">
                <p class="log_tit">더존 그룹웨어에 오신것을 환영합니다.</p>
                <form method="post" action="loginProc">
                    <fieldset>
                        <label class="i_label" for="loginId" id="userId_label" onclick="javascript:focusInput('userId');" style="font-size: 12px;">아이디 입력</label>
                        <input type="text" class="inp" id="loginId" name="loginId" onfocus="focusInput('userId');" onblur="blurInput('userId');">
                        
                        <label class="i_label" for="loginPassword" id="userPw_label" onclick="javascript:focusInput('userPw');" style="font-size: 12px;">비밀번호 입력</label>
                        <input type="password" class="inp" id="loginPassword" name="loginPassword" onfocus="focusInput('userPw');" onblur="blurInput('userPw');">
                        
                        <div class="chk">
                            <input type="checkbox" id="chk_id"/>
                            <label for="chk_id">아이디저장</label>
                        </div>
                        <div class="log_btn">
                            <input type="image" value="로그인" src="<c:url value='/resources/Images/btn/login_b2_type_btn.png' />" onclick="">
                        </div>
                    </fieldset>
                </form>
            </div>
            <div class="copy">Copyright duzon IT GROUP. All right reserved.</div>
        </div>
    </div>
    
</body>
</html>