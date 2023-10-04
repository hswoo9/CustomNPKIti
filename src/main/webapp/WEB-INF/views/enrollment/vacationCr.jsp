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
<input type="hidden" id="holiday" value="${holiday.h_day }" />
<script type="text/javascript"
	src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
<style type="text/css">
.k-header .k-link {
	text-align: center;
}

.k-grid-content>table>tbody>tr {
	text-align: center;
}

.k-grid th.k-header, .k-grid-header {
	background: #F0F6FD;
}
#requestDeptSeq_listbox{
	font-weight: 400 !important;
}
/** loading css **/
#link {color: #E45635;display:block;font: 12px "Helvetica Neue", Helvetica, Arial, sans-serif;text-align:center; text-decoration: none;}
#link:hover {color: #CCCCCC}

#link, #link:hover {-webkit-transition: color 0.5s ease-out;-moz-transition: color 0.5s ease-out;-ms-transition: color 0.5s ease-out;-o-transition: color 0.5s ease-out;transition: color 0.5s ease-out;}

/** BEGIN CSS **/
      #loadingDiv {
      	background: #3333336e;
		left: 50%;
		transform: translate(0%, -70%);
		width: 100%;
		height: 100vh;
		padding-top: 25%;
		
      }
      @keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-moz-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-webkit-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-o-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-moz-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-webkit-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @-o-keyframes rotate-loading {
          0%  {transform: rotate(0deg);-ms-transform: rotate(0deg); -webkit-transform: rotate(0deg); -o-transform: rotate(0deg); -moz-transform: rotate(0deg);}
          100% {transform: rotate(360deg);-ms-transform: rotate(360deg); -webkit-transform: rotate(360deg); -o-transform: rotate(360deg); -moz-transform: rotate(360deg);}
      }

      @keyframes loading-text-opacity {
          0%  {opacity: 0}
          20% {opacity: 0}
          50% {opacity: 1}
          100%{opacity: 0}
      }

      @-moz-keyframes loading-text-opacity {
          0%  {opacity: 0}
          20% {opacity: 0}
          50% {opacity: 1}
          100%{opacity: 0}
      }

      @-webkit-keyframes loading-text-opacity {
          0%  {opacity: 0}
          20% {opacity: 0}
          50% {opacity: 1}
          100%{opacity: 0}
      }

      @-o-keyframes loading-text-opacity {
          0%  {opacity: 0}
          20% {opacity: 0}
          50% {opacity: 1}
          100%{opacity: 0}
      }
      .loading-container,
      .loading {
          height: 100px;
          position: relative;
          width: 100px;
          border-radius: 100%;
      }


      .loading-container { margin: 40px auto }

      .loading {
          border: 2px solid transparent;
          border-color: transparent #fff transparent #FFF;
          -moz-animation: rotate-loading 1.5s linear 0s infinite normal;
          -moz-transform-origin: 50% 50%;
          -o-animation: rotate-loading 1.5s linear 0s infinite normal;
          -o-transform-origin: 50% 50%;
          -webkit-animation: rotate-loading 1.5s linear 0s infinite normal;
          -webkit-transform-origin: 50% 50%;
          animation: rotate-loading 1.5s linear 0s infinite normal;
          transform-origin: 50% 50%;
      }

      .loading-container:hover .loading {
          border-color: transparent #E45635 transparent #E45635;
      }
      .loading-container:hover .loading,
      .loading-container .loading {
          -webkit-transition: all 0.5s ease-in-out;
          -moz-transition: all 0.5s ease-in-out;
          -ms-transition: all 0.5s ease-in-out;
          -o-transition: all 0.5s ease-in-out;
          transition: all 0.5s ease-in-out;
      }

      #loading-text {
          -moz-animation: loading-text-opacity 2s linear 0s infinite normal;
          -o-animation: loading-text-opacity 2s linear 0s infinite normal;
          -webkit-animation: loading-text-opacity 2s linear 0s infinite normal;
          animation: loading-text-opacity 2s linear 0s infinite normal;
          color: #ffffff;
          font-family: "Helvetica Neue, "Helvetica", ""arial";
          font-size: 10px;
          font-weight: bold;
          margin-top: 45px;
          opacity: 0;
          position: absolute;
          text-align: center;
          text-transform: uppercase;
          top: 0;
          width: 100px;
      }     
.pop_foot .btn_cen input[type="button"], 
.pop_foot .btn_cen input[type="submit"], 
.pop_foot .btn_cen button {
    height: 27px;
    min-width: 50px;
}
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>연가 생성</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">연가 생성</p>
		<form id="vcatnFrm" name="vcatnFrm">
			
			<input type="hidden" id="crtrEmplSn"				name="crtrEmplSn"						value="111111" /><!-- 생성자seq -->
			<input type="hidden" id="deptSeq"					name="deptSeq"							value="" /><!-- 사원검색 선택 후 부서 seq -->
			<input type="hidden" id="deptName"					name="deptName"							value="" /><!-- 사원검색 선택 후 부서명 -->
			<input type="hidden" id="empSeq"					name="empSeq"							value="" /><!-- 사원검색 선택 후 사원 seq -->
			<input type="hidden" id="empName"					name="empName"							value="" /><!-- 사원검색 선택 후 사원이름 -->
			<input type="hidden" id="useYn"						name="useYn"							value="Y" /><!-- 사용여부 기본 Y -->
			<input type="hidden" id="vcatnKndSn"				name="vcatnKndSn"						value="${vcation.vcatnKndSn}" /><!-- 연가SN -->
			<div class="top_box" style="margin-bottom: 5px;">
				<dl>
					<dt class="ar" style="width: 65px">적용년도</dt>
					<dd>
						<input type="text" id="applyYr" name="applyYr" value="${year}"
							style="width: 100px" />
					</dd>
					<dt class="ar" style="width: 65px">부서</dt>
					<dt class="ar">
						<input type="text" id="requestDeptSeq" />
	
					</dt>
					<dt class="ar" style="width: 65px">이름</dt>
					<dt class="ar">
						<input type="text" id="empNameSearch" name="empNameSearch"
							style="width: 130px;"> <input type="hidden"
							id="empSeqSearch" name="empSeqSearch">
					</dt>
					<dd>
						<input type="button" id="empSearch" value="검색" />
					</dd>
				</dl>
			</div>
			<div class="top_box">
				<dl style="height: 40px;">
					<dt class="ar" style="width: 90px">연가</dt>
					<dt class="ar" style="width: 65px">최초부여일</dt>
					<dd>
						<input type="text" id="yrvacFrstAlwncDaycnt" name="yrvacFrstAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
					</dd>
					<dt class="ar" style="width: 65px">조정부여일</dt>
					<dd>
						<input type="text" id="yrvacMdtnAlwncDaycnt" name="yrvacMdtnAlwncDaycnt" style="width: 40px; margin-right: 5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />일
					</dd>
					<dt class="ar" style="width: 65px">조정사유</dt>
					<dd>
						<input type="text" id="yrvacCreatResn" name="yrvacCreatResn" style="width: 200px;" placeholder="전년도 이월" />
					</dd>
					<dt class="ar" style="width: 65px">잔여일</dt>
					<dd>
						<input type="text" disabled="disabled" id="yrvacRemndrDaycnt" value="0"
							style="width: 40px; margin-right: 5px;" />일
					</dd>
				</dl>
				<!-- <dl style="height: 40px; display: none;">
					<dt class="ar" style="width: 90px">장기근속휴가</dt>
					<dt class="ar" style="width: 65px">최초부여일</dt>
					<dd>
						<input type="text" id="lnglbcVcatnFrstAlwncDaycnt" name="lnglbcVcatnFrstAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
					</dd>
					<dt class="ar" style="width: 65px">조정부여일</dt>
					<dd>
						<input type="text" id="lnglbcVcatnMdtnAlwncDaycnt" name="lnglbcVcatnMdtnAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
					</dd>
					<dt class="ar" style="width: 65px">조정사유</dt>
					<dd>
						<input type="text" id="lnglbcVcatnCreatResn" name="lnglbcVcatnCreatResn" style="width: 200px;" placeholder="전년도 이월" />
					</dd>
					<dt class="ar" style="width: 65px">잔여일</dt>
					<dd>
						<input type="text" disabled="disabled" id="lnglbcVcatnRemndrDaycnt" value="0"
							style="width: 40px; margin-right: 5px;" />일
					</dd>
				</dl> -->
				<dl>
					<dt class="ar" style="width: 90px">비고</dt>
					<dd style="margin-left: 20px;">
						<input type="text" id="rmk" name="rmk" style="width: 500px;" />
					</dd>
				</dl>
			</div>
			<div class="btn_div" style="margin-top: 20px;">
				<div class="right_div">
					<div class="controll_btn p0">
						<%--
						<button type="button" id="btnAllSave">일괄생성</button>
						 --%>
						<button type="button" id="btnSave">생성</button>
						<button type="button" id="btnPopup">수정</button>
						<button type="button" id="btnDelete">삭제</button>
					</div>
				</div>
			</div>
		</form>
		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->
<!-- 사원검색팝업 -->
<div class="pop_wrap_dir" id="empPopUp" style="width: 600px;">
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
			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->
<!--수정팝업 -->
<div class="pop_wrap_dir" id="vacationPopUp" style="width:1000px;">
	<div class="pop_head">
		<h1>연가 수정</h1>
	</div>
	<form id="vcatnSetPopupFrm" name="vcatnSetPopupFrm">
		<input type="hidden" id="vcatnSn" name="vcatnSn" />
		<input type="hidden"     		  name="useYn"							value="Y" /><!-- 사용여부 기본 Y -->
		<div class="com_ta mt15" style="">
			<div>
				<div class="top_box">
					<dl style="height: 40px;">
						<dt class="ar" style="width: 90px">연가</dt>
						<dt class="ar" style="width: 65px">최초부여일</dt>
						<dd>
							<input type="text" id="yrvacFrstAlwncDaycnt2" name="yrvacFrstAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
						</dd>
						<dt class="ar" style="width: 65px">조정부여일</dt>
						<dd>
							<input type="text" id="yrvacMdtnAlwncDaycnt2" name="yrvacMdtnAlwncDaycnt" style="width: 40px; margin-right: 5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />일
						</dd>
						<dt class="ar" style="width: 65px">조정사유</dt>
						<dd>
							<input type="text" id="yrvacCreatResn2" name="yrvacCreatResn" style="width: 200px;" placeholder="전년도 이월" />
						</dd>
						<dt class="ar" style="width: 65px">잔여일</dt>
						<dd>
							<input type="text" disabled="disabled" id="yrvacRemndrDaycnt2" value="0"
								style="width: 40px; margin-right: 5px;" />일
						</dd>
					</dl>
					<!-- <dl style="height: 40px; display: none;">
						<dt class="ar" style="width: 90px">장기근속휴가</dt>
						<dt class="ar" style="width: 65px">최초부여일</dt>
						<dd>
							<input type="text" id="lnglbcVcatnFrstAlwncDaycnt2" name="lnglbcVcatnFrstAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
						</dd>
						<dt class="ar" style="width: 65px">조정부여일</dt>
						<dd>
							<input type="text" id="lnglbcVcatnMdtnAlwncDaycnt2" name="lnglbcVcatnMdtnAlwncDaycnt" style="width: 40px; margin-right: 5px;"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일
						</dd>
						<dt class="ar" style="width: 65px">조정사유</dt>
						<dd>
							<input type="text" id="lnglbcVcatnCreatResn2" name="lnglbcVcatnCreatResn" style="width: 200px;" placeholder="전년도 이월" />
						</dd>
						<dt class="ar" style="width: 65px">잔여일</dt>
						<dd>
							<input type="text" disabled="disabled" id="lnglbcVcatnRemndrDaycnt2" value="0"
								style="width: 40px; margin-right: 5px;" />일
						</dd>
					</dl> -->
					<dl>
						<dt class="ar" style="width: 90px">비고</dt>
						<dd style="margin-left: 20px;">
							<input type="text" id="rmk2" name="rmk" style="width: 500px;" />
						</dd>
					</dl>
				</div>
			</div>
		</div>			
	</form>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<button type="button" id="btnUpdate">수정</button>
			<input type="button" class="gray_btn" id="changeCancle" value="닫기" />
		</div>
	</div>
</div>
<!-- loading bar -->
<div id="loadingDiv" style="display: none;">
	<div class="loading-container">
	    <div class="loading"></div>
	    <div id="loading-text">등록중</div>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		mainGrid();
		empGrid();
		//사원 검색 엔터키
		$(document).keypress(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		});

		$("#empNameSearch").keydown(function(keyNum) { //현재의 키보드의 입력값을 keyNum으로 받음
			if (keyNum.keyCode == 13) { // keydown으로 발생한 keyNum의 숫자체크 // 숫자가 enter의 아스키코드 13과 같으면 // 기존에 정의된 클릭함수를 호출
				$("#empSearch").click();
			}
		});
		//사원 검색 팝업창
		$(document).keypress(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		});

		$("#emp_name").keydown(function(keyNum) { //현재의 키보드의 입력값을 keyNum으로 받음
			if (keyNum.keyCode == 13) { // keydown으로 발생한 keyNum의 숫자체크 // 숫자가 enter의 아스키코드 13과 같으면 // 기존에 정의된 클릭함수를 호출
				$("#searchButton").click();
			}
		});

		//사원검색
		var empWindow = $("#empPopUp");
		//검색ID
		empSearch = $("#empSearch");
		//검색 클릭(팝업호출)
		empSearch.click(function() {
			empWindow.data("kendoWindow").open();
			$("#emp_name").val($("#empNameSearch").val());
			empGridReload();
			empSearch.fadeOut();
		});

		//팝업 X 닫기버튼 이벤트
		function onClose() {
			gridReload();
			empSearch.fadeIn();
		}

		//닫기 이벤트
		$("#cancle").click(function() {
			gridReload();
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
		//사원검색끝

		//년월 달력 초기화
		$("#applyYr").kendoDatePicker({
			// defines the start view
			start : "decade",

			// defines when the calendar should return date
			depth : "decade",

			// display month and year in the input
			format : "yyyy",
			parseFormats : [ "yyyy" ],

			// specifies that DateInput is used for masking the input element
			culture : "ko-KR",
			dateInput : true
		});
		//부서 콤보박스 초기화
		fnTpfDeptComboBoxInit('requestDeptSeq');

		//저장
		$("#btnSave").on("click", function() {
			//사원
			if($("#empNameSearch").val() == null || $("#empNameSearch").val() == ''){
				alert("선택된 사원이 없습니다.");
				$("#empNameSearch").focus();
				return false;
			}
			//연가 최초부여일
			if($("#yrvacFrstAlwncDaycnt").val() == null || $("#yrvacFrstAlwncDaycnt").val() == ''){
				alert("연가 최초부여일이 없습니다.");
				$("#yrvacFrstAlwncDaycnt").focus();
				return false;
			}
			//장기근속휴가 최초부여일
			 /*if($("#lnglbcVcatnFrstAlwncDaycnt").val() == null || $("#lnglbcVcatnFrstAlwncDaycnt").val() == ''){
				//alert("장기근속휴가 최초부여일이 없습니다.");
				//$("#lnglbcVcatnFrstAlwncDaycnt").focus();
				//return false; 
				$("#lnglbcVcatnFrstAlwncDaycnt").val(0);
			} */
			//연가 조정부여일
			if($("#yrvacMdtnAlwncDaycnt").val() == null || $("#yrvacMdtnAlwncDaycnt").val() == ''){
				$("#yrvacMdtnAlwncDaycnt").val(0);
			}
			//장기근속휴가 조정부여일
			/*if($("#lnglbcVcatnMdtnAlwncDaycnt").val() == null || $("#lnglbcVcatnMdtnAlwncDaycnt").val() == ''){
				$("#lnglbcVcatnMdtnAlwncDaycnt").val(0);
			}*/
			
			fn_save();
		});
		
		//삭제
		$("#btnDelete").on("click", function(){
			var checkBoxGroup = $(".checkbox_group:checked").not("#headerCheckbox");
			var deleteList = new Array();
			if(checkBoxGroup.length == 0){
				alert("체크여부를 확인하세요.");
				return false;
			}
			if(checkBoxGroup.length > 0){
				for(var i = 0 ; i < checkBoxGroup.length ; i++){
					deleteList[i] = checkBoxGroup[i].value;
				}
			}
			fn_delete(deleteList);
		});
		
		//전체체크
		$("#headerCheckbox").change(function(){
			
			var checkedIds = {};
		    if($("#headerCheckbox").is(":checked")){
		    	$(".checkbox_group").prop("checked", "checked");
		    	var checked = this.checked,
		        row = $(this).closest("tr"),
		        grid = $("#grid").data("kendoGrid"),
		        dataItem = grid.dataItem(row);

		        checkedIds[dataItem.education_id] = checked;

		        if (checked) {
		            row.addClass("k-state-selected");

		        } else {
		            row.removeClass("k-state-selected");
		           
		        }
		    }else{
		    	$(".checkbox_group").removeProp("checked");
		    }
		});
		
		//수정팝업 열기
		$("#btnPopup").on("click", function(){
			var checkGroup = $(".checkbox_group:checked");
			if(checkGroup.length == 0){
				alert("선택된 사원이 없습니다.");
				return false;
			}
			if(checkGroup.length > 1){
				alert("선택이 잘못 되었습니다.");
				$(".checkbox_group").prop("checked",false);
				$("#headerCheckbox").prop("checked", false);
				return false;
			}
			fn_dateSet(checkGroup[0].value);
			$("#vcatnSn").val(checkGroup[0].value);
			myWindow.data("kendoWindow").open();
		});
		
		//수정팝업
		var myWindow = $("#vacationPopUp");
		myWindow.kendoWindow({
			  width:  "1000px",
			  height: "350px",
		     visible:  false,
		     actions: ["Close"],close: workChangeHistory
		 }).data("kendoWindow").center();
		
		//팝업창 닫기
		$("#changeCancle").click(function(){
			fn_popupReset();
			myWindow.data("kendoWindow").close();
		});
		
		//수정버튼
		$("#btnUpdate").on("click", function(){
			//연가 최초부여일
			if($("#yrvacFrstAlwncDaycnt2").val() == null || $("#yrvacFrstAlwncDaycnt2").val() == ''){
				alert("연가 최초부여일이 없습니다.");
				$("#yrvacFrstAlwncDaycnt2").focus();
				return false;
			}
			//장기근속휴가 최초부여일
			/*if($("#lnglbcVcatnFrstAlwncDaycnt2").val() == null || $("#lnglbcVcatnFrstAlwncDaycnt2").val() == ''){
				//alert("장기근속휴가 최초부여일이 없습니다.");
				//$("#lnglbcVcatnFrstAlwncDaycnt2").focus();
				//return false; 
				$("#lnglbcVcatnFrstAlwncDaycnt2").val(0);
			}*/
			//연가 조정부여일
			if($("#yrvacMdtnAlwncDaycnt2").val() == null || $("#yrvacMdtnAlwncDaycnt2").val() == ''){
				$("#yrvacMdtnAlwncDaycnt2").val(0);
			}
			//장기근속휴가 조정부여일
			/*if($("#lnglbcVcatnMdtnAlwncDaycnt2").val() == null || $("#lnglbcVcatnMdtnAlwncDaycnt2").val() == ''){
				$("#lnglbcVcatnMdtnAlwncDaycnt2").val(0);
			}
			*/
			fn_update();
		});
		
		
		$(".k-input").attr("readonly", "readonly");
		
		
		$("#btnAllSave").on("click", function(e){
			if(confirm("일괄 등록 하시겠습니까?")){
				$("#loadingDiv").show();
				e.preventDefault();
				fn_allSave();
			}else{
				return false;
			}
		});
	});
	//부서 콤보박스
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
					gridReload();
					$("#empNameSearch").val('');
				}
			});
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
	//부서 콤보박스 끝
	//사원 검색
	function empGridReload() {
		$("#empGrid").data('kendoGrid').dataSource.read();
	}
	//사원검색끝
	
	//메인그리드
	var dataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : "<c:url value='/vcatn/getVcatnList'/>",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.applyYr = $("#applyYr").val();
				data.empNameSearch = $("#empNameSearch").val();
				data.deptSeq = $("#deptSeq").val();
				
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				return response.list.length;
			}
		}
	});
	/* 데이터 없을 시 첫번째 그리드 처리 함수 */
	function gridDataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.total() == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append(
							'<tr class="kendo-data-row"><td colspan="100%" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

	/* 데이터 없을 시 두번째 그리드 처리 함수 */
	function grid2DataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.total() == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append(
							'<tr class="kendo-data-row"><td colspan="100%" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

	kendo.ui.Grid.fn.fitColumns = function(parentColumn) {
		var grid = this;
		var columns = grid.columns;
		if (parentColumn && parentColumn.columns)
			columns = parentColumn.columns;
		columns.forEach(function(col) {
			if (col.columns)
				return grid.fitColumns(col);
			grid.autoFitColumn(col);
		});
		grid.expandToFit();
	}//fitColumns

	kendo.ui.Grid.fn.expandToFit = function() {
		var $gridHeaderTable = this.thead.closest('table');
		var gridDataWidth = $gridHeaderTable.width();
		var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap')
				.innerWidth();
		// Since this is called after column auto-fit, reducing size
		// of columns would overflow data.
		if (gridDataWidth >= gridWrapperWidth) {
			return;
		}

		var $headerCols = $gridHeaderTable.find('colgroup > col');
		var $tableCols = this.table.find('colgroup > col');

		var sizeFactor = (gridWrapperWidth / gridDataWidth);
		console.log($(this));
		$headerCols.add($tableCols).not('.k-group-col').each(function() {
			check = $(this);
			var currentWidth = $(this).width();
			var newWidth = (currentWidth * sizeFactor);
			/*
			$(this).css({
				width : newWidth
			});
			*/
		});
	}//expandToFit
	var check;
	function gridReload() {
		$('#grid').data('kendoGrid').dataSource.read();
	}

	/* 대체휴무 발생현황 개인조회 리스트 */
	function mainGrid() {
		//캔도 그리드 기본
		var grid = $("#grid")
				.kendoGrid(
						{
							dataSource : dataSource,
							height : 500,
							dataBound : function(e) {
								//this.fitColumns();
								gridDataBound(e);
							},
							sortable : true,
							pageable : {
								refresh : true,
								pageSizes : [ 10, 20, 30, 50, 100 ],
								buttonCount : 5
							},
							persistSelection : true,
							selectable : "multiple",
							columns : [

									{
										headerTemplate : "<input type='checkbox' id='headerCheckbox' class='checkbox_group checkbox_group_top'>",
										template : fn_checkBox,
										width : 30,
									}, {
										field : "deptName",
										title : "부서",
										width : 100,
									}, {
										field : "empName",
										title : "이름",
										width : 70,
									}, {
										field : "",
										title : "연가",
										width : 150,
										columns : [ {
											field : "yrvacFrstAlwncDaycnt",
											title : "최초부여일",
											width : 50,
										}, {
											field : "yrvacMdtnAlwncDaycnt",
											title : "조정부여일",
											width : 50,
										}, {
											field : "",
											title : "자동생성",
											width : 50,
											//임시임.
											template : function(){
												return "자동"; 
											},
										} ],
									},
									/* {
										field : "",
										title : "장기근속휴가",
										width : 150,
										columns : [ {
											field : "lnglbcVcatnFrstAlwncDaycnt",
											title : "최초부여일",
											width : 50,
										}, {
											field : "lnglbcVcatnMdtnAlwncDaycnt",
											title : "조정부여일",
											width : 50,
										}, {
											field : "",
											title : "자동생성",
											width : 50,
											//임시임.
											template : function(){
												return "자동"; 
											},
										} ],
									},  */
									{
										field : "rmk",
										title : "비고",
										width : 130,
									}, ],
							change : function(e) {
								codeGridClick(e)
							}
						}).data("kendoGrid");

		grid.table.on("click", ".checkbox", selectRow);

		var checkedIds = {};

		// on click of the checkbox:
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
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
			});
			$("#headerCheckbox"+record.vcatnSn).click();
			if($("#headerCheckbox"+record.vcatnSn).is(":checked")){
				$(".checkbox_group").not("#headerCheckbox"+record.vcatnSn).prop("checked", false);
				fn_dateSet(record.vcatnSn);
			}/*else{
				fn_fieldReSet2();
			}*/
			
			
		}
	}
	//체크박스
	function fn_checkBox(row){
		var str = "<input type='checkbox' id='headerCheckbox"+row.vcatnSn+"' class='checkbox_group' value="+row.vcatnSn+">";
		//str += "<label class='k-checkbox-label' for='headerCheckbox"+row.vcatnSn+"'></label>";
		return str;
	}
	//사원팝업 ajax
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
				data.emp_name = $('#emp_name').val();
				data.dept_name = $('#requestDeptSeq').val();
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
	//사원팝업 ajax 끝
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
									},
									{
										title : "선택",
										template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
									} ],
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
			});
			subReload(record);
		}
	}

	function subReload(record) {
		$('#keyId').val(record.if_info_system_id);
	}

	//선택 클릭이벤트
	function empSelect(e) {
		//선택row
		var row = $("#empGrid").data("kendoGrid").dataItem($(e).closest("tr"));
		//사원명 셋팅
		$('#empNameSearch').val(row.emp_name);
		$("#empName").val(row.emp_name);
		//사원seq 셋팅
		$('#empSeqSearch').val(row.emp_seq);
		$("#empSeq").val(row.emp_seq);
		//사원부서seq 셋팅
		$("#deptSeq").val(row.dept_seq);
		//부서명 셋팅
		$("#deptName").val(row.dept_name);
		var requestDeptSeq = $('#requestDeptSeq').data('kendoComboBox');
		requestDeptSeq.value(row.dept_name);//부서명
		//팝업ID	
		var empWindow = $("#empPopUp");
		//닫기 이벤트
		empWindow.data("kendoWindow").close();
	}
	
	//저장
	function fn_save(){
		var formData = new FormData(document.getElementById("vcatnFrm"));
		
		$.ajax({
			url:"<c:url value='/vcatn/vcatnSave'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(data){
				//$("#grid").data('kendoGrid').dataSource.read();
				alert(data.object.message);
				location.reload();
			}
		});	
	}
	//필드 초기화
	function fn_fieldReSet(){
		//부서콤보박스 초기화
		$("#yrvacFrstAlwncDaycnt").val("");//연가최초부여
		$("#yrvacMdtnAlwncDaycnt").val("");//연가조정부여
		$("#yrvacCreatResn").val("");//연가조정사유
		//$("#lnglbcVcatnFrstAlwncDaycnt").val("");//장기근속최초부여
		//$("#lnglbcVcatnMdtnAlwncDaycnt").val("");//장기근속조정부여
		//$("#lnglbcVcatnCreatResn").val("");//장기근속조정사유
		$("#yrvacRemndrDaycnt").val(0);//연가잔여일
		//$("#lnglbcVcatnRemndrDaycnt").val(0);//장기근속잔여일
		$("#rmk").val("");//비고
		$("#applyYr").val("${year}");//적용년도
		$("#empNameSearch").val("");//이름
		$("#deptSeq").val("");//부서키
		fnTpfDeptComboBoxInit('requestDeptSeq');
		$("#grid").data('kendoGrid').dataSource.read();
	}
	//필드 초기화
	function fn_fieldReSet2(){
		//부서콤보박스 초기화
		$("#yrvacFrstAlwncDaycnt").val("");//연가최초부여
		$("#yrvacMdtnAlwncDaycnt").val("");//연가조정부여
		$("#yrvacCreatResn").val("");//연가조정사유
		//$("#lnglbcVcatnFrstAlwncDaycnt").val("");//장기근속최초부여
		//$("#lnglbcVcatnMdtnAlwncDaycnt").val("");//장기근속조정부여
		//$("#lnglbcVcatnCreatResn").val("");//장기근속조정사유
		$("#yrvacRemndrDaycnt").val(0);//연가잔여일
		//$("#lnglbcVcatnRemndrDaycnt").val(0);//장기근속잔여일
		$("#rmk").val("");//비고
		$("#applyYr").val("${year}");//적용년도
		$("#empNameSearch").val("");//이름
		$("#deptSeq").val("");//부서키
	}
	
	//필드 데이터 추가
	function fn_dateSet(key){
		var formData = new FormData();
		formData.append("vcatnSn", key);
		$.ajax({
			url:"<c:url value='/vcatn/getVcatnOne'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				var obj = result.object;
				$("#yrvacFrstAlwncDaycnt").val(obj.yrvacFrstAlwncDaycnt);//연가최초부여
				$("#yrvacMdtnAlwncDaycnt").val(obj.yrvacMdtnAlwncDaycnt);//연가조정부여
				$("#yrvacCreatResn").val(obj.yrvacCreatResn);//연가조정사유
				//$("#lnglbcVcatnFrstAlwncDaycnt").val(obj.lnglbcVcatnFrstAlwncDaycnt);//장기근속최초부여
				//$("#lnglbcVcatnMdtnAlwncDaycnt").val(obj.lnglbcVcatnMdtnAlwncDaycnt);//장기근속조정부여
				//$("#lnglbcVcatnCreatResn").val(obj.lnglbcVcatnCreatResn);//장기근속조정사유
				$("#rmk").val(obj.rmk);//비고
				$("#applyYr").val(obj.applyYr);//적용년도
				$("#empNameSearch").val(obj.empName);//이름
				$("#deptSeq").val(obj.deptSeq);//부서키	
				$("#yrvacRemndrDaycnt").val(obj.yrvacRemndrDaycnt);//연가잔여일
				//$("#lnglbcVcatnRemndrDaycnt").val(obj.lnglbcVcatnRemndrDaycnt);//장기근속잔여일
				$("#empSeq").val(obj.empSeq);//사원고유키
				var requestDeptSeq = $('#requestDeptSeq').data('kendoComboBox');
				requestDeptSeq.value(obj.deptName);//부서명
				
				//팝업용
				$("#yrvacFrstAlwncDaycnt2").val(obj.yrvacFrstAlwncDaycnt);//연가최초부여
				$("#yrvacMdtnAlwncDaycnt2").val(obj.yrvacMdtnAlwncDaycnt);//연가조정부여
				$("#yrvacCreatResn2").val(obj.yrvacCreatResn);//연가조정사유
				//$("#lnglbcVcatnFrstAlwncDaycnt2").val(obj.lnglbcVcatnFrstAlwncDaycnt);//장기근속최초부여
				//$("#lnglbcVcatnMdtnAlwncDaycnt2").val(obj.lnglbcVcatnMdtnAlwncDaycnt);//장기근속조정부여
				$("#lnglbcVcatnCreatResn2").val(obj.lnglbcVcatnCreatResn);//연가조정사유
				$("#rmk2").val(obj.rmk);//비고
				$("#vcatnSn").val(obj.vcatnSn);//휴가 기본키
				$("#yrvacRemndrDaycnt2").val(obj.yrvacRemndrDaycnt);//연가잔여일
				//$("#lnglbcVcatnRemndrDaycnt2").val(obj.lnglbcVcatnRemndrDaycnt);//장기근속잔여일
			}
		});	
	}
	
	//삭제
	function fn_delete(list){
		var formData = new FormData();
		formData.append("list", list);
		$.ajax({
			url:"<c:url value='/vcatn/deleteVcatn'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				alert(result.object.message);
				fn_fieldReSet();
			}
		});	
	}
	//팝업창 닫힘
	function workChangeHistory(){
 		fn_popupReset();
		fn_fieldReSet();
		
    }
	//팝업필드 초기화
	function fn_popupReset(){
		$("#yrvacFrstAlwncDaycnt2").val("");//연가최초부여
		$("#yrvacMdtnAlwncDaycnt2").val("");//연가조정부여
		$("#yrvacCreatResn2").val("");//연가조정사유
		//$("#lnglbcVcatnFrstAlwncDaycnt2").val("");//장기근속최초부여
		//$("#lnglbcVcatnMdtnAlwncDaycnt2").val("");//장기근속조정부여
		$("#rmk2").val("");//비고
		$("#vcatnSn").val("");//휴가 기본키
	}
	
	function fn_update(){
		var formData = new FormData(document.getElementById("vcatnSetPopupFrm"));
		formData.append("empSeq", $("#empSeq").val());
		formData.append("deptSeq", $("#deptSeq").val());
		formData.append("updusrEmplSn", $("#crtrEmplSn").val());
		formData.append("vcatnKndSn", $("#vcatnKndSn").val());
		$.ajax({
			url:"<c:url value='/vcatn/updateVcatn'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				alert(result.object.message);
				$("#changeCancle").click();
				
			}
		});	
	}
	
	function fn_allSave(){
		
		setTimeout(function(){
			var formData = new FormData(document.getElementById("vcatnFrm"));
			$.ajax({
				url:"<c:url value='/vcatn/makeVacation'/>",
				data: formData,
				type: 'POST',
				dataType: 'json',
				processData: false,
				contentType: false,
				cache: false,
				async: false,
				success:function(data){
					alert("등록되었습니다.");
					location.reload();
				},
				beforeSend: function(){
				},
				complete: function(){
					$("#loadingDiv").hide();
				},
				error: function(xhr, status, error){
					console.log("[Error] " + status);
					return;
				}
			});	
		},0);
	}
</script>
