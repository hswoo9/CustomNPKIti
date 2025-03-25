<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>

<style>
table tr td {text-align: center;}

.popup {
  position: absolute;
  left: 220px;
  display: inline-block;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

.popup .popuptext {
  visibility: hidden;
  width: 160px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 8px 4px;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -80px;
}

.popup .popuptext::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

.popup .show {
  visibility: visible;
  -webkit-animation: fadeIn 1s;
  animation: fadeIn 1s;
}

@-webkit-keyframes fadeIn {
  from {opacity: 0;} 
  to {opacity: 1;}
}

@keyframes fadeIn {
  from {opacity: 0;}
  to {opacity:1 ;}
}

#snackbar {
  /*visibility: hidden;*/
  min-width: 500px;
  /*background-color: #333;*/
  background-color: rgba(51, 3, 0, 0.7);
  color: #fff;
  text-align: center;
  border-radius: 2px;
  padding: 46px;
  position: fixed;
  /*z-index: 1;*/
  z-index: -1;
  left: 50%;
  transform: translateX(-50%);
  bottom: 30px;
  font-size: 17px;
  bottom: 0; 
  opacity: 0;
}

#snackbar.show {
  visibility: visible;
  -webkit-animation: snackfadein 0.5s, snackfadeout 0.5s 4.5s;
  animation: snackfadein 0.5s, snackfadeout 0.5s 4.5s;
}

#snackbar p {
	text-align: left;
}

#snackbar span {
	margin-left: 5px;
}

@-webkit-keyframes snackfadein {
  from {bottom: 0; opacity: 0;} 
  to {bottom: 30px; opacity: 1;}
}

@keyframes snackfadein {
  from {bottom: 0; opacity: 0;}
  to {bottom: 30px; opacity: 1;}
}

@-webkit-keyframes snackfadeout {
  from {bottom: 30px; opacity: 1;} 
  to {bottom: 0; opacity: 0;}
}

@keyframes snackfadeout {
  from {bottom: 30px; opacity: 1;}
  to {bottom: 0; opacity: 0;}
}

#weekProgress {
	width: 100%;
	background-color: #ddd;
}

#weekBar {
	width: 1%;
	height: 30px;
	background-color: #4CAF50;
}

#totalProgress {
	width: 100%;
	background-color: #ddd;
}

#totalBar {
	width: 1%;
	height: 30px;
	background-color: #4CAF50;
}

.split {
  height: 100%;
  width: 45%;
  position: absolute;
  z-index: inherit;
  top: 0;
  overflow-x: hidden;
  margin-top: 10px;
}

.left {
  left: 0;
  margin-left: 12px;
}

.right {
  right: 0;
  margin-right: 12px;
}

.verticalLine{
  border-left: 3px solid green;
  height: 100%;
  position: absolute;
  left: 50%;
  margin-left: -3px;
  top: 0;
}

</style>

<input type="hidden" id="flex_3m_week_min" value="${master.flex_3m_week_min }">
<input type="hidden" id="flex_2w_week_min" value="${master.flex_2w_week_min }">
<input type="hidden" id="isFlex" value="">
<input type="hidden" id="max_work_day" value="">
<div class="ifram_wrap" style="min-width: 1070px;">
	<div class="btn_div mt10 cl">
		<div class="left_div">
			<p class="tit_p mt5 mb0">개인 유연근무 조회(<span id="work_type_kr"></span>)</p>
		</div>
	</div>
	<div class="sub_contents_wrap">
		<div class="com_ta">
			<div class="top_box">
				<dl>
					<dt style="width: 80px;">
						신청년월
					</dt>
					<dd>
						<input type="text" id="searchDt" style="width: 100px; text-align: center;" onchange="setData();">
					</dd>

					<dt style="width: 65px; margin-left: 55px;">
						부서/이름
					</dt>
					<dd style="line-height: 25px;">
						<input type="text" id="empNm" value=" ${userInfo.orgnztNm} / ${userInfo.empName }" style="text-align: ;width: 180px" disabled="disabled">
						<input type="hidden" id="empSeq" value="${userInfo.empSeq }">

					</dd>
					<dt style="width:80px;" class="approvalDiv">
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
						승인권자
					</dt>
					<dd class="approvalDiv">
						<input type="text" value="${getHeader.nameDuty }" 
						id="headerName" style="width:160px;" disabled="disabled">
						<input type="hidden" name="approval_emp_seq" value="${getHeader.emp_seq }">
						<input type="button" id="headerListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
					</dd>
				</dl>
				<dl id="planTypeSelect">
					<dt style="width: 80px;">
						신청 유형
					</dt>
					<dd>
						<input id="planType" class="select-box" >
					</dd>
				</dl>
				<dl id="flexSelect" style="display:none;">
					<dt style="width: 80px;">
						탄력근무제
					</dt>
					<dd>
						 <input id="flexType" class="select-box"> 
					</dd>
					<%--<input type="hidden" name="flex_code_id">
					<input type="hidden" name="start_week_no">--%>
				</dl>
				<dl id="endMonth" style="display:none;">
					<dt style="width: 80px;">
						기간
					</dt>
					<dd>
						<input id="workTermType" class="select-box">
					</dd>
				</dl>
				<input type="hidden" name="flex_code_id">
				<input type="hidden" name="start_week_no">
				<dl id="flexTemplate" style="display:none;">
				</dl>
			</div>
			<br>
			<div class="popup">
				<span class="popuptext" id="myPopup">※ 바로 옆 일괄변경버튼을 <br>누르셔야 전체 날짜에 <br>대해 적용이 됩니다.</span>
			</div>
			<div class="btn_div mt10 cl">
				<div class="left_div" onclick="myFunction()">
					<p class="tit_p mt5 mb0" style="display: inline;">근무유형 변경&nbsp; </p>
					<select name="" id="work_type" class="" style="width: 160px"></select>
					<span class="controll_btn p0">
						<button type="button" id="" onclick="workTypeModify();">일괄변경</button>
					</span>
					
				</div>
				
				<div class="right_div">
					
					<p class="tit_p mt5 mb0" style="display: inline;">기본 근무유형&nbsp; </p>
					<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon"/>
					<select name="" id="default_work_type" class="" style="width: 160px;"></select>
					<span class="controll_btn p0">
						<button type="button" id="defaultBtn" onclick="defaultMod();">기본근무유형 변경</button>
						<button type="button" id="" onclick="setData();">새로고침</button>
					</span>
				</div>
			</div>
            	<strong> <span style="color: rgb(0, 0, 255); float: right;"> ※ '기본 근무유형'은 앞으로 다가올 월의 근무 유형을 해당 값으로 자동 설정되게 하는 기능입니다. </span></strong><br />
            		
			<table id="addTable">
				<colgroup>
					<col width="50px;">
					<col width="100px;">
					<col width="120px;">
					<col width="80px;">
					<col width="200px;">
					<col width="120px;">
					<col width="120px;">
					<col width="">
				</colgroup>
				<tbody id="addTbody">
				<div class="popup" id="changeBubblePop">
					<span class="popuptext" id="myPopup2">※ 변경할 일자만 <br>체크박스 선택하시어 <br>신청해주세요.</span>
				</div>	
				</tbody>
			</table>
		</div>
	
	</div>
	<!-- 승인권자 검색 팝업 -->
	<div class="pop_wrap_dir" id="headerListPop" style="width:600px;display:none;">
		<div class="pop_head">
			<h1>승인권자리스트</h1>
		</div>
		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt class="ar" style="width:65px;">성명</dt>
					<dd>
						<input type="text" id="header_name" class="grid_reload2" style="width:120px;">
					</dd>
					<dt>부서</dt>
					<dd>
						<input type="text" id="header_dept_name" class="grid_reload2" style="width:180px;">
						<input type="button" id="headerSearchBtn" value="검색">
					</dd>
				</dl>
			</div>
			<div class="com_ta mt15">
				<div id="gridHeaderList"></div>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" id="headerListPopClose" value="닫기">
			</div>
		</div>
	</div>
	
	<!-- SnackBar -->
	<div id="snackbar">
		<div class="split left">
			<p>최대주평균:<span id="barMaxWeek">123123</span></p>
			<p>해당주신청:<span id="barReqWeek"></span></p>
			<div id="weekProgress">
				<div id="weekBar"></div>
			</div>
		</div>
		<div class="verticalLine"></div>
		<div class="split right">
			<p>총기준근로:<span id="barMaxTotal"></span></p>
			<p>총신청근로:<span id="barReqTotal"></span></p>
			<div id="totalProgress">
				<div id="totalBar"></div>
			</div>
		</div>
	</div>
</div>

<div style="display: none;">
	<input type="file" id="excelFile" onchange="excelFileChange(this);" accept=".xls, .xlsx">
</div>

<div id="addWorkPlanType" style="display: none;">
<select class="selectMenu addWorkPlanType" id="WK_PN_SEQ" onchange="selectType(this);" style="width: 90%;">
	<c:forEach items="${workPlanType }" var="list">
		<c:choose>
			<c:when test="${workType.work_type_code == 633 and list.work_type_id == 15 }">
			<option selected value="${list.work_type_id }" data-s="${list.attend_time }" data-e="${list.leave_time }" data-m="${list.work_min }" data-b="${list.break_min }">${list.work_type }</option>
			</c:when>
			<c:when test="${workType.work_type_code == 632 and list.work_type_id == 2 }">
			<option selected value="${list.work_type_id }" data-s="${list.attend_time }" data-e="${list.leave_time }" data-m="${list.work_min }" data-b="${list.break_min }">${list.work_type }</option>
			</c:when>

			<c:otherwise>
			<option value="${list.work_type_id }" data-s="${list.attend_time }" data-e="${list.leave_time }" data-m="${list.work_min }" data-b="${list.break_min }">${list.work_type }</option>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
</div>
<script id="flexTypeTemplate" type="text/template">
	<dt id="flexLable" style="width:80px;">
	</dt>
	<dd id="flexInput">
	</dd>
	<dt id="workTypeLable" style="width: 90px; margin-left: 10px;">
		근무유형 선택
	</dt>
	<dd id="workTypeSelect" style="display: flex;margin-left: 5px">
		<div class="left_div">
			<select name="" id="work_type_s" class="" style="width: 160px"></select>
		</div>
	</dd>
</script>
<script>
var test = '${userInfo}';
var monthLimit = '';
var weekLimit = {};

$(function(){
	console.log("${workType}");
	console.log("${workPlanType}");
	console.log("${userInfo}");
	var work_type_code = "${workType.work_type_code}";
	var work_type_code_kr = "";
	if(work_type_code === '632'){
		work_type_code_kr = "전일제";
		$('.btnClass').attr('disabled', false);
	}else if(work_type_code === '633'){
		work_type_code_kr = "반일제";
		$('.btnClass').attr('disabled', false);
	}else{
		work_type_code_kr = "근무유형을 먼저 지정해주세요";
		alert('유연근무 신청시 전일제/반일제 근무유형이 설정되어 있어야 합니다. 관리자에게 문의하여 주세요.');
		setTimeout(function(){
			$('.btnClass').attr('disabled', true);
			$('[onclick="workTypeModify();"]').attr('disabled', true);
			$( 'select' ).kendoDropDownList({
				  enable: false
			});
			$('#planTypeSelect').hide();
			$('#endMonth').hide();
		}, 1500);
	}
	$("#work_type_kr").text(work_type_code_kr);
	/*
		탄력근무유형 - KendoComboBox(#flexType)
	*/
	var comboBox0 = $("#planType").kendoComboBox({
		dataSource: [
			{planTypeCode: 'normal', planType_kr: '일반'},
			{planTypeCode: 'flex', planType_kr: '탄력'}
		],
		dataTextField: 'planType_kr',
		dataValueField: 'planTypeCode',
		index: 0,
		change: function(e){
			if(this.value() === 'normal'){
				$("#flexSelect").hide();
				$("#endMonth").show();
				setData();
			}else if(this.value() === 'flex'){
				$("#flexSelect").show();
				$("#workTypeSelect").hide();
				$("#workTypeLable").hide();
				$("#endMonth").hide();
			}
		}
	});

	var comboBox = $("#flexType").kendoComboBox({
		dataSource: new kendo.data.DataSource({
			transport: {
				read: {
					url: _g_contextPath_+ '/subHoliday/getCommCodeList',
					dataType: 'json',
					type: 'post'
				},
				parameterMap: function(data, operation){
					data.group_code = 'FLEX_TYPE';
					return data;
				}
			},
			schema: {
				data: function(response){
					return response.list;
				}
			}
		}),
		dataTextField: 'code_kr',
		dataValueField: 'common_code_id',
		change: function(e){
			var rows = comboBox.select();
			var record = comboBox.dataItem(rows);
			//console.log(record);
			$("[name='flex_code_id']").val(record.common_code_id);
			
			$("#flexTemplate").empty();
			html = document.querySelector("#flexTypeTemplate").innerHTML;
			$("#flexTemplate").append(html);
			if(record.code === '3M'){
				$("#flexLable").html("진행 확인");
				var sD = $('#searchDt').val().replace(/-/gi , '');
				var sYear = parseInt(sD.substring(0, 4));//앞에서 4번째 자리까지 자르기
				var sMonth = parseInt(sD.substr(sD.length-2, 2));//뒤에서 2번째 자리까지 자르기
				var eD = 0;
				var eMonth = sMonth + 2;
				var eYear = sYear;
				if(sMonth > 10){
					eMonth = (sMonth + 2 - 12).toString();
					eMonth.length > 1 ? eMonth = eMonth : eMonth = '0' + eMonth;
					eYear = (sYear + 1).toString();
					eD = eYear + eMonth;
				}else {
					eD = parseInt(sD) + 2;
				}
				
				$.getJSON(_g_contextPath_ + '/workPlan/checkFlexPlan',
						{'searchDt': sD, 'empSeq': '${userInfo.empSeq}'},
						function(json){
							var result = parseInt(json.cnt);
							if(result > 0){
								var msg = "탄력근무제 신청 대상 기간(" + sYear + "년" + sMonth + "월~" + eYear + "년" + eMonth	+ "월) 중 이미 신청된 건이 존재합니다.";
							}else{
								var msg = "탄력근무제 신청 대상 기간은 " + sYear + "년" + sMonth + "월~" + eYear + "년" + eMonth + "월입니다. 진행하시겠습니까?" + 
								  "<input type='button' id='flexOkBtn' class='file_input_button ml4 normal_btn2' value='확인'>";
							}
							$("#flexInput").html(msg);
						});
			}else if(record.code === '2W'){
				var firstDate = $("#searchDt").val() + '-01';
				var dateObject = new Date(firstDate);
				var lastDate = new Date(dateObject.getYear(), dateObject.getMonth()+1, 0);
				var firstWeek = Math.ceil(dateObject.getDate()/7);
				var lastWeek = Math.ceil(lastDate.getDate()/7)
				var weeks = lastWeek - firstWeek;
				
				$.getJSON(_g_contextPath_ + '/workPlan/getWeekNo',
						{'firstDate': firstDate},
						function(json){
							var firstWeekNo = 0;
							firstWeekNo = json.week_no;
							$("#flexLable").html("주차 선택");
							var selectObject = document.createElement("select");
							$(selectObject).addClass("weeks_select");
							selectObject.id = 'start_week_no';
							for(var i=0;i<weeks;i++){
								var option = document.createElement("option");
								option.text = i + 1;
								option.value = firstWeekNo + i;
								selectObject.add(option);
							}
							$("#flexInput").append(selectObject);
							$("#flexInput").append("<input type='button' id='flexOkBtn' class='file_input_button ml4 normal_btn2' value='확인'>");
							$(".weeks_select").kendoComboBox();
						});
			}
			$("#flexTemplate").show();
		}
	}).data("kendoComboBox");




	var comboBox1 = $("#workTermType").kendoComboBox({
		dataSource: new kendo.data.DataSource({
			transport: {
				read: {
					url: _g_contextPath_+ '/subHoliday/getCommCodeList',
					dataType: 'json',
					type: 'post'
				},
				parameterMap: function(data, operation){
					data.group_code = 'WORK_TERM_TYPE';
					return data;
				}
			},
			schema: {
				data: function(response){
					return response.list;
				}
			}
		}),
		dataTextField: 'code_kr',
		dataValueField: 'common_code_id',
		change: function(e){
			var rows = comboBox1.select();
			var record = comboBox1.dataItem(rows);
			//console.log(record);
			$("[name='flex_code_id']").val(record.common_code_id);

			$("#flexTemplate").empty();
			html = document.querySelector("#flexTypeTemplate").innerHTML;
			$("#flexTemplate").append(html);
			if(record.code === '12M'){
				$("#workTypeSelect").hide();
				$("#workTypeLable").hide();
				$("#flexLable").html("진행 확인");
				var sD = $('#searchDt').val().replace(/-/gi , '');
				var sYear = parseInt(sD.substring(0, 4));//앞에서 4번째 자리까지 자르기
				var sMonth = parseInt(sD.substr(sD.length-2, 2));//뒤에서 2번째 자리까지 자르기
				var eD = 0;
				var eMonth = sMonth + 11;
				var eYear = sYear;
				if(sMonth > 1){
					eMonth = (sMonth + 11 - 12).toString();
					eMonth.length > 1 ? eMonth = eMonth : eMonth = '0' + eMonth;
					eYear = (sYear + 1).toString();
					eD = eYear + eMonth;
				}else {
					eD = parseInt(sD) + 2;
				}

				$.getJSON(_g_contextPath_ + '/workPlan/checkFlexPlan',
						{'searchDt': sD, 'empSeq': '${userInfo.empSeq}'},
						function(json){
							var result = parseInt(json.cnt);
							if(result > 0){
								var msg = "유연근무제 신청 대상 기간(" + sYear + "년" + sMonth + "월~" + eYear + "년" + eMonth	+ "월) 중 이미 신청된 건이 존재합니다.";
							}else{
								var msg = "유연근무제 신청 대상 기간은 " + sYear + "년" + sMonth + "월~" + eYear + "년" + eMonth + "월입니다. 진행하시겠습니까?" +
										"<input type='button' id='flexOkBtn' class='file_input_button ml4 normal_btn2' value='확인'>";
							}
							$("#flexInput").html(msg);
						});
			}else if(record.code === '1W'){
				$("#work_type_s").kendoDropDownList({
					dataTextField: "work_type",
					dataValueField: "work_type_id",
					dataSource: workTypeCodeList('nAll')
				});

				var firstDate = $("#searchDt").val() + '-01';
				var dateObject = new Date(firstDate);
				var lastDate = new Date(dateObject.getYear(), dateObject.getMonth()+1, 0);
				var firstWeek = Math.ceil(dateObject.getDate()/7);
				var lastWeek = Math.ceil(lastDate.getDate()/7)
				var weeks = lastWeek - firstWeek;

				$.getJSON(_g_contextPath_ + '/workPlan/getWeekNo',
						{'firstDate': firstDate},
						function(json) {
							var firstWeekNo = 0;
							firstWeekNo = json.week_no;
							$("#flexLable").html("주차 선택");
							$("#workTypeSelect").show();
							$("#workTypeSelect").css("display", "flex");
							$("#workTypeLable").show();

							var selectObject = document.createElement("select");
							$(selectObject).addClass("weeks_select");
							selectObject.id = 'start_week_no';
							for (var i = 0; i < weeks; i++) {
								var option = document.createElement("option");
								option.text = i + 1;
								option.value = firstWeekNo + i;
								selectObject.add(option);
							}
							$("#flexInput").append(selectObject);

							$("#workTypeSelect").append("<input type='button' id='flexOkBtn' class='file_input_button ml4 normal_btn2' value='확인'>");
							$(".weeks_select").kendoComboBox();
						});
			}else{
				$("#workTypeSelect").hide();
				$("#workTypeLable").hide();
			}
			$("#flexTemplate").show();
		}
	}).data("kendoComboBox");




	$(document).on('click', "#flexOkBtn", function(e){
		setFlexData();
		$(this).fadeOut();
	});

	$('#searchDt').kendoDatePicker({
		culture : "ko-KR",
		format : "yyyy-MM",
		start: "year",
		depth: "year",
		value: new Date(),
		change: function () {
			$("#flexSelect").hide();
			$("#planType").data("kendoComboBox").value('');
		}
	});
	
	list = workTypeCodeList('all');
	list2 = workTypeCodeList('nAll');

	$("#work_type").kendoDropDownList({
		dataTextField: "work_type",
	    dataValueField: "work_type_id",
	    dataSource: list2
	});
	
	/* $(document).on('click', '.left_div .k-dropdown-wrap', function(e){
		e.preventDefault();
		var result = confirm(
	    		'바로 옆 일괄변경버튼을 누르셔야 전체 날짜에 대해 적용이 됩니다. \n'  +
	    		'최초 신청 후 매월 자동으로 해당 유형이 적용되도록 하려면 \n' +
	    		'오른쪽 상단의 기본 근무유형을 해당 월 신청 유형과 동일하게 변경 후 신청해 주세요'
	    	);
		if(result){
			var dd = $("#work_type").data("kendoDropDownList");
			dd.open();
		}
	}); */
	
 	$("#default_work_type").kendoDropDownList({
	    dataTextField: "work_type",
	    dataValueField: "work_type_id",
	    dataSource: list2
	});
	
	$("#searchDt").attr("readonly","readonly");
	
	var myWindow2 = $("#headerListPop"),
	undo2 = $("#headerListPopBtn");
	undo2.click(function(){
		myWindow2.data("kendoWindow").open();
		undo2.fadeOut();
		headerGrid();
	});
	
	getMonthLimit()
	
	$("#headerListPopClose").click(function(){
		myWindow2.data("kendoWindow").close();
	});
	myWindow2.kendoWindow({
		width: "600px",
		height: "665px",
		visible: false,
		modal: true,
		actions: [
			"Close"
		],
		close: function(){
			undo2.fadeIn();
			$("#header_name").val("");
			$("#header_dept_name").val("");
		}
	}).data("kendoWindow").center();
	
	function headerGridReload(){
		$("#gridHeaderList"/* popUpGrid2 */).data("kendoGrid").dataSource.read();
	}
	$("#headerSearchBtn").click(function(){
		headerGridReload();
	});
	$(document).on({
		'keyup': function(event){
			if(event.keyCode===13){//enterkey
				headerGridReload();
			}
		}
	},".grid_reload2");
	
	var headerGrid = function(){
		var grid = $("#gridHeaderList"/* popUpGrid2 */).kendoGrid({
			dataSource: new kendo.data.DataSource({
				serverPaging: true,
				pageSize: 10,
				transport: {
					read: {
						url: _g_contextPath_ + '/common/empInformation',
						dataType: 'json',
						type: 'post'
					},
					parameterMap: function(data, operation){
						data.deptSeq = '';//'${userInfo.deptSeq}';//"${empInfo.deptSeq}";
						data.emp_name = $("#header_name").val();
						data.dept_name = $("#header_dept_name").val();
						data.notIn = '';
						return data;
					}
				},
				schema: {
					data: function(response){
						return response.list;
					},
					total: function(response){
						return response.totalCount;
					}
				}
			}),
			height: 460,
			dataBound: gridDataBound,
			sortable: true,
			pageable: {
				refresh: true,
				pageSizes: true,
				buttonCount: 5
			},
			persistSelection: true,
			selectable: "multiple",
			columns: [{
				field: "emp_name",
				title: "이름",
				attributes: {
					style: "padding-left: 0 !important"
				}
			},{
				field: "dept_name",
				title: "부서"
			},{
				field: "position",
				title: "직급"
			},{
				field: "duty",
				title: "직책"
			},{
				title: "선택",
				template: '<input type="button" class="text_blue header_select" value="선택">',
				attributes: {
					style: "padding-left: 0 !important"
				}
			}],
			change: function(e){
				//codeGridClick(e);
			}
		}).data("kendoGrid");
		
		function codeGridClick(){
			var rows = grid.select();
			var record;
			rows.each(function(){
				record = grid.dataItem($(this));
				console.log(record);
			}); 
		}
		$(document).on('click', ".header_select", function(){
			var row = $("#gridHeaderList").data("kendoGrid").dataItem($(this).closest("tr"));
			$("#headerName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
			$("[name='approval_emp_seq']").val(row.emp_seq);
			$("[name='approval_emp_name']").val(row.emp_name);
			myWindow2.data("kendoWindow").close();
		});
	}
	
	setData();
	
});

function myFunction() {
	var popup = document.getElementById('myPopup');
	popup.classList.toggle('show');
}
function myFunction2() {
	var offset = $('[value="변경신청"]').offset(); //여기하는중
	//console.log('offset', offset);
	$('#changeBubblePop').css({
		'position': 'absolute',
		'left': parseInt(offset.left) + 20 + 'px',
		'top': parseInt(offset.top) - 10 + 'px'
	});
	var popup = document.getElementById('myPopup2');
	popup.classList.toggle('show');
}

function gridDataBound(e){
	var grid = e.sender;
	if(grid.dataSource.total()==0){
		var colCount = grid.columns.length;
		$(e.sender.wrapper)
			.find('tbody')
			.append('<tr class="kendo-data-row">' + 
					'<td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
	}
}

function getMonthLimit() {
	
	var data = {
			month : $('#searchDt').val().replace(/-/gi , '')
	}
	
	$.ajax({
		url: _g_contextPath_+"/workPlan/getMonthLimit",
		type : 'POST',
		async: false,
		data: data,
		success: function(result){
			monthLimit = result.monthLimit.MONTH_LIMIT;
			weekLimit = result.weekLimit;

		}
	});
	
}

function selectAll(e) {
	$(e).select();
}

function workTypeModify(){
	
	var list = workTypeCodeList('all');
	var attTime = '';
    var leaveTime = '';
    
    for (var i = 0; i < list.length; i++ ) {
    	if ($("#work_type").data("kendoDropDownList").value() == list[i].work_type_id) {
    		attTime = list[i].attend_time;
    		leaveTime = list[i].leave_time;
    		workMin = list[i].work_min;
    		breakMin = list[i].break_min;
    	}
    }
    
	if ( $('#workPlanPk').val() == '0' ) {
		$.each($('#addTbody tr select'), function(i,v){
			var row = $(v).closest('tr');
			var weekday = $(row).find('#weekday').hasClass('text_black');
			if ($(row).find('#sts').attr('nowYn') == 'Y') {
				if(weekday){
					$(v).data('kendoDropDownList').value($("#work_type").data("kendoDropDownList").value());
					$(v).closest('tr').find('#rStart').text(attTime);
					$(v).closest('tr').find('#rEnd').text(leaveTime);
					$(v).closest('tr').find('#work_min').val(workMin);
					$(v).closest('tr').find('#break_min').val(breakMin);
					selectType(v);
				}
			}
		})
		
	} else {
		var ch = $('.checkbox:checked');
		$.each(ch, function(i,v){
			var row = $(v).closest("tr");
			var weekday = $(row).find('#weekday').hasClass('text_black');
			var select = row.find('select');
			if(weekday){
				$(select).data('kendoDropDownList').value($("#work_type").data("kendoDropDownList").value());
				row.find('#rStart').text(attTime);
				row.find('#rEnd').text(leaveTime);
				row.find('#work_min').val(workMin);
				row.find('#break_min').val(breakMin);
				selectType(select[0]);
			}
		})
	}
}

function headerCheckbox(){
	if($("#headerCheckbox").is(":checked")){
    	$(".checkbox").prop("checked", "checked");
    	
    }else{
    	$(".checkbox").removeProp("checked");
    }
}

function setFlexData(){
	//$("#flexTemplate").empty();
	//$("#flexTemplate").hide();
	
	unCheck();
	getMonthLimit();
	
	flexDropDownList();
	
	$('#addTbody').empty();
	
	var sD = $('#searchDt').val().replace(/-/gi , '');
	var sYear = parseInt(sD.substring(0, 4));//앞에서 4번째 자리까지 자르기
	var sMonth = parseInt(sD.substr(sD.length-2, 2));//뒤에서 2번째 자리까지 자르기
	var eD = 0;
	var eMonth = '';
	var yearTerm = '';
	if($("#planType").val() == "normal"){
		if(sMonth > 1){
			eMonth = (sMonth + 11 - 12).toString();
			eMonth.length > 1 ? eMonth = eMonth : eMonth = '0' + eMonth;
			eD = (sYear + 1).toString() + eMonth;
		}else{
			eD = parseInt(sD) + 11;
		}
		if($("[name='flex_code_id']").val() == '713'){
			eD = sD;
		}
	}else{
		if(sMonth > 10){
			eMonth = (sMonth + 2 - 12).toString();
			eMonth.length > 1 ? eMonth = eMonth : eMonth = '0' + eMonth;
			eD = (sYear + 1).toString() + eMonth;
		}else{
			eD = parseInt(sD) + 2;
		}
		if($("[name='flex_code_id']").val() == '634'){
			eD = sD;
		}
	}

	
	var data = {
		empSeq		: $('#empSeq').val(),
		searchDt	: sD,
		type		: 'normal',
		flex_code_id : $("[name='flex_code_id']").val(),
		startMonth  : sD,
		endMonth : eD,
		year_term : yearTerm
	}
	
	dataGrid(data, 'v', 'flex');
}

function setData(){
	$("#flexTemplate").empty();
	$("#flexTemplate").hide();
	$("[name='flex_code_id']").val("");
	
	$("#flexType").data("kendoComboBox").value('');
	
	unCheck();
	getMonthLimit();
	
	$('#addTbody').empty();

	var data = {
		empSeq		: $('#empSeq').val(),
		searchDt	: $('#searchDt').val().replace(/-/gi , ''),
		type		: 'normal',
	}
	
	dataGrid(data);
	
}

function flexDropDownList () {
	$("#work_type").data('kendoDropDownList').setDataSource(workTypeCodeList('all'));
}

function workTypeCodeList(e){
	var workTypeCodeList = [];
	var data = {
			
	}
	$.ajax({
		url: _g_contextPath_+"/workPlan/workTypeCodeList",
		type : 'POST',
		async: false,
		data: data,
		success: function(result){
			var resultVal = [];
			if ( e == 'nAll' ) {
				$.each(result.list, function(i, v){
					var workMin = parseInt(v.work_min);
					var work_type_code = "${workType.work_type_code}";
					if(work_type_code === '633'){//반일제
						if ( workMin == 240) {
							resultVal.push(v);
						}
					}else{
						if ( workMin >= 180 ) {
							resultVal.push(v);
						}
					}
					
				})
				workTypeCodeList = resultVal;
			} else {
				workTypeCodeList = result.list;
			}
		}
	});
	return workTypeCodeList;
}

function dataGrid(data, val, planType){
	var nDay = moment(new Date()).format('YYYY-MM-DD');
	var txt = ['일', '월', '화', '수', '목', '금', '토'];
	var selectHtml = $('#addWorkPlanType').html();
	if(planType === undefined){
		selectHtml = selectHtml
						.replace(/* IE에서 작동 안하는거 해결... 특수문자 - 이거때문인듯 */
							/* /<option value="11" data-s="" data-e="" data-m="">탄력근무<\/option>/gi */
							'<option value="11"'
							, '<option value="11" disabled'
						);
	}
	var work_type_code = "${workType.work_type_code}";
	if(work_type_code === '633'){//반일제
		selectHtml = selectHtml
						.replace('<option value="1"', '<option value="1" disabled')
						.replace('<option value="2"', '<option value="2" disabled')
						.replace('<option value="3"', '<option value="3" disabled')
						.replace('<option value="12"', '<option value="12" disabled');
	}

	$.ajax({
		url: "<c:url value='/workPlan/setDataSearch' />",
		data : data,
		async : false,
		type : 'POST',
		success: function(result){
			console.log(result)
			var planSts = '';
			var checkHtml = '';
			var btnHtml = '';
			var btnHtml2 = '';
			var color = '';
			var stsBackColor = '';
			switch (result.status.STATUS) {
			case '0':
				planSts = '[[ 미신청 ]]';
				color = 'red';
				stsBackColor = 'bisque';
				btnHtml = '<input type="button" onclick="saveBtn();" class="btnClass" style="float: right" value="유연근무 신청">';
				$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				$('#defaultBtn').css({'display':'none'});
				$("#planTypeSelect").show();
				// $("#endMonth").show();
				$('.approvalDiv').show();
				break;
			case '1':
// 				planSts = '신청';
				color = 'gray';
				stsBackColor = 'whitesmoke';
				btnHtml2 = '<input type="button" onclick="reqCancelBtn();" style="float: right" value="신청 취소">';
				btnHtml = '<span style="display: inline-block;font-weight: bold;padding: 5px 0;">[[ 승인 대기 상태 ]]</span>';
				$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				$('#defaultBtn').css({'display':'none'});
				$("#planTypeSelect").hide();
				$('#endMonth').hide();
				$('.approvalDiv').show();
				break;
			case '2':
				planSts = '[[ 승인 ]]';
				color = 'blue';
				stsBackColor = 'aliceblue';
				if(result.status.flex_code_id != 0){
					btnHtml = '<input type="button" onclick="modBtn();" onmouseover="myFunction2();" class="btnClass" style="float: right" value="변경신청">';
					btnHtml2 = '<input type="button" onclick="modCancelBtn();" style="float: right" value="변경신청 취소">';
				}else{
					//일반신청의 경우 변경신청 못하도록
					//btnHtml = '<input type="button" onclick="modBtn();" class="btnClass" style="float: right" value="탄력근무의경우에만 변경신청 가능" disabled>'; //wook
					//btnHtml2 = ''; //wook
					btnHtml = '<input type="button" onclick="modBtn();" onmouseover="myFunction2();" class="btnClass" style="float: right" value="변경신청">';
					btnHtml2 = '<input type="button" onclick="modCancelBtn();" style="float: right" value="변경신청 취소">';
				}
				//$('.approvalDiv').hide(); //wook
				checkHtml = '<input type="checkbox" id="headerCheckbox" onchange="headerCheckbox();" class="k-checkbox header-checkbox"><label class="k-checkbox-label" for="headerCheckbox"></label>';	
				$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				$('#defaultBtn').css({'display':'inline-block'});
				$("#planTypeSelect").hide();
				$('#endMonth').hide();
				break;
			default:
				break;
			}
			
			if(result.status.flex_code_id != 0){
				flexDropDownList();
				selectHtml = $('#addWorkPlanType').html();
				$("#isFlex").val('true');
				$("[name='flex_code_id']").val(result.status.flex_code_id);
				$("[name='start_week_no']").val(result.status.start_week_no);
			}
			
			$('#addTbody')
				.append(	'<tr>'+
				'	<th colspan="10" style="text-align: center;background-color:'+ stsBackColor +'"><span id="mSts" style="margin-left: 15px;font-weight: bold;display: inline-block;padding: 5px 0;" class="text_'+color+'">'+planSts+'</span><input type="hidden" id="workPlanPk" value="'+result.status.PK+'"/>'+
				btnHtml2+
				btnHtml+
				'</th>'+
				'</tr>'+
				'<tr>'+
				'	<th style="text-align: ;">'+checkHtml+'</th>'+	
				'	<th style="text-align: center;padding-right: 0px;">상태</th>'+		
				'	<th style="text-align: center;padding-right: 0px;">근무일자</th>'+				
				'	<th style="text-align: center;padding-right: 0px;">요일</th>	'+			
				'	<th style="text-align: center;padding-right: 0px;">근무유형</th>'+				
				'	<th style="text-align: center;padding-right: 0px;">출근시간</th>'+				
				'	<th style="text-align: center;padding-right: 0px;">퇴근시간</th>'+				
				'	<th style="text-align: center;padding-right: 0px;">비고</th>'+				
				'</tr>');
			
			if( result.status.STATUS != '0' ){
				var checkHtml = '';
				$.each(result.list, function(i, v){
					var html;
					var textColor = '';
					var status = '';
					var color = '';
					var memo = '';
					
					switch (v.status) {
					case '1':
						status = '신청';
						color = 'gray';
						memo = v.remark;
						break;
					case '2':
						status = '승인';
						color = 'blue';
						memo = v.remark;
						break;
					case '3':
						status = '변경신청';
						color = 'gray';
						memo = '[변경승인대기]' + v.change_work_type + ' ' + v.remark
						break;
					default:
						break;
					}
					
					if(result.status.flex_code_id == '634'){
						selectHtml = $('#addWorkPlanType').html();
						if(v.week_no != result.status.start_week_no && v.week_no != result.status.start_week_no + 1){
							selectHtml = selectHtml
											.replace(/* IE에서 작동 안하는거 해결... 특수문자 - 이거때문인듯 */
												/* /<option value="11" data-s="" data-e="" data-m="">탄력근무<\/option>/gi */
												'<option value="11"'
												, '<option value="11" disabled'
											);
						}
					}

					if(result.status.flex_code_id == '713'){
						selectHtml = $('#addWorkPlanType').html();
						if(v.week_no != result.status.start_week_no){
							selectHtml = selectHtml
									.replace(/* IE에서 작동 안하는거 해결... 특수문자 - 이거때문인듯 */
											/* /<option value="11" data-s="" data-e="" data-m="">탄력근무<\/option>/gi */
											'<option value="11"'
											, '<option value="11" disabled'
									);
						}
					}
					
					if ( v.weekday == '토요일' ) {
						textColor = 'text_blue';
					} else if ( v.weekday == '일요일' ) {
						textColor = 'text_red';
					} else if ( v.HOLIDAY_STATUS == 'Y' ) {
						textColor = 'text_red';
					} else {
						textColor = 'text_black';
					}
					
					if ( result.status.STATUS == '1') {
						checkHtml = '<td></td>';
					} else {
						checkHtml = '<td><input type="checkbox" id="plan'+v.work_date+'" class="k-checkbox checkbox"/><label for="plan'+v.work_date+'" class="k-checkbox-label"></label></td>';
					}
					//wook
					//if(result.status.flex_code_id == 0){
					//	checkHtml = '<td></td>';
					//}
					
					var dayNo = moment(v.WK_DT).day();
					
						html = '<tr>';
					
					if(v.NOWSTS == 'Y'){
						html +='<input type="hidden" id="work_plan_detail_id" value="'+v.work_plan_detail_id+'">'
						+checkHtml
						+'<td><span id="sts" dataYn="Y" class="text_'+color+'">'+status+'</span><input type="hidden" id="status" value="'+v.status+'"/></td>'
						+'<td id="work_date"><input type="hidden" id="change_degree" class="change_degree" value="'+v.change_degree+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
						+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+selectHtml+'<input type="hidden" id="beforeWkTp" value="'+v.work_type_id+'"/><input type="hidden" id="work_type_id" value="'+v.work_type_id+'"/><input type="hidden" id="work_plan_history_id" value="'+v.work_plan_history_id+'"/></td>'
						+'<td id="rStart">'+v.attend_time+'</td>'
						+'<td id="rEnd">'+v.leave_time+'</td>'
						+'<td><input type="text" id="MEMO" value="'+memo+'" style="width:90%;">'
						+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
						+'<input type="hidden" id="work_min" value="'+v.work_min+'"/>'
						+'<input type="hidden" id="break_min" value="'+v.break_min+'"/>'
						+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
						+'</tr>';
					}else{
						html +='<input type="hidden" id="work_plan_detail_id" value="'+v.work_plan_detail_id+'">' 
						+'<td></td>'
						+'<td><span id="sts" dataYn="Y" class="text_'+color+'">'+status+'</span></td>'
						+'<td id="work_date">'+v.work_date+'</td>'
						+'<td class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+v.work_type+'<input type="hidden" id="work_type_id" value="'+v.work_type_id+'"/></td>'
						+'<td id="rStart">'+v.attend_time+'</td>'
						+'<td id="rEnd">'+v.leave_time+'</td>'
						+'<td><input type="text" id="MEMO" value="'+memo+'" style="width:90%;" disabled="disabled">'
						+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
						+'<input type="hidden" id="work_min" value="'+v.work_min+'"/>'
						+'<input type="hidden" id="break_min" value="'+v.break_min+'"/>'
						+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
						+'</tr>';
					}
					
					$('#addTbody').append(html);
					var row = $('#addTbody').children()[i+2]
					var select = $(row).find('select');
					var workTpId = '';
					var list;
					
					if ( select.length > 0 ) {
						
						var sTime = {};
						var eTime = {};
						var workMin = {};
						var breakMin = {};
						
						$.each($(row).find('select option:not(:disabled)'), function(ii, vv){
							
							sTime[ii] = $(this).attr('data-s');
							eTime[ii] = $(this).attr('data-e');
							workMin[ii] = $(this).attr('data-m');
							breakMin[ii] = $(this).attr('data-b');
							
							if ( v.work_type_id == $(vv).val() ) {
// 								$(row).find('#rStart').text($(this).attr('data-s'));
// 								$(row).find('#rEnd').text($(this).attr('data-e'));
// 								$(row).find('#work_min').val($(this).attr('data-m'));
							}
							
						});
						
						select.kendoDropDownList({
							value: v.work_type_id
						});
						
						$.each(select.children(), function(ii, vv){
							$(vv).attr('data-s', sTime[ii]);
							$(vv).attr('data-e', eTime[ii]);
							$(vv).attr('data-m', workMin[ii]);
							$(vv).attr('data-b', breakMin[ii]);
						});
						
						if ( result.status.STATUS == '1' || v.status == '3' ) {
							$( select ).kendoDropDownList({
								  enable: false
							});
						}
						//wook
						//if(result.status.flex_code_id == 0){
						//	$( select ).kendoDropDownList({
						//		  enable: false
						//	});
						//}
						
					} 
					
				});
				
			}else{
				if(work_type_code === '633'){//반일제
					$('#default_work_type').data('kendoDropDownList').value("15");
				}else{
					/*$('#default_work_type').data('kendoDropDownList').value("2");*/
					$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				}
				
				// 유연근무 신규
				$.each(result.list, function(i, v){
					var html;
					var textColor = '';
					var dayNo = moment(v.WK_DT).day();
					var start_week_no = $("#start_week_no").val();
					var week_flex_yn = '';
					var work_type_s = '';
					

					if(i == 0){
						html = '<tr class="WK_PN_MS_SEQ" data-seq="'+v.WK_PN_MS_SEQ+'">';
					}else{
						html = '<tr>';
					}
					
					if($("[name='flex_code_id']").val() == '634'){
						selectHtml = $('#addWorkPlanType').html();
						if(v.week_no != start_week_no && v.week_no != parseInt(start_week_no) + 1){
							selectHtml = selectHtml
											.replace(/* IE에서 작동 안하는거 해결... 특수문자 - 이거때문인듯 */
												/* /<option value="11" data-s="" data-e="" data-m="">탄력근무<\/option>/gi */
												'<option value="11"'
												, '<option value="11" disabled'
											);
						}else{
							week_flex_yn = 'Y';
						}
					}

					if($("[name='flex_code_id']").val() == '713'){
						selectHtml = $('#addWorkPlanType').html();
						if(v.week_no != start_week_no){
							selectHtml = selectHtml
									.replace(/* IE에서 작동 안하는거 해결... 특수문자 - 이거때문인듯 */
											/* /<option value="11" data-s="" data-e="" data-m="">탄력근무<\/option>/gi */
											'<option value="11"'
											, '<option value="11" disabled'
									);
						}else{
							week_flex_yn = 'Y';
							work_type_s = $("#work_type_s").data("kendoDropDownList").value()

						}
					}
					
					if ( v.weekday == '토요일' ) {
						textColor = 'text_blue';
					} else if ( v.weekday == '일요일' ) {
						textColor = 'text_red';
					} else if ( v.HOLIDAY_STATUS == 'Y' ) {
						textColor = 'text_red';
					} else {
						textColor = 'text_black';
					}

					if($("[name='flex_code_id']").val() == '713'){
						if (v.NOWSTS == 'Y') {

							html +='<input type="hidden" id="WK_PN_NO" value="'+v.work_plan_detail_id+'">'
									+'<td></td>'
									+'<td><span id="sts" dataYn="Y" nowYn="Y" class="text_blue">신청가능</span></td>'
									+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
									+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>';
									if(work_type_s != null && work_type_s != ''){
										html += '<td>'+selectHtml+'<input type="hidden" class="work_type_id" id="work_type_id" value="'+work_type_s+'"></td>';
									}else{
										html += '<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+$('#addWorkPlanType select option:selected').val()+'"></td>';
									}
									html +=
									'<td id="rStart">'+$('#work_type_s select option:selected').attr('data-s')+'</td>'
									+'<td id="rEnd">'+$('#work_type_s select option:selected').attr('data-e')+'</td>'
									+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;">'
									+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
									+'<input type="hidden" id="work_min" value="'+$('#work_type_s select option:selected').attr('data-m')+'"/>'
									+'<input type="hidden" id="break_min" value="'+$('#work_type_s select option:selected').attr('data-b')+'"/>'
									+'<input type="hidden" id="week_flex_yn" value="'+ week_flex_yn +'"/>'
									+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
									+'</tr>';
						} else {

							html += '<td></td>'
									+'<td><span id="sts" dataYn="Y" nowYn="N" class="text_blue">신청가능</span></td>'
									+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
									+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
									+'<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+work_type_s+'"></td>'
									//+'<td>'+$('.addWorkPlanType option:selected').text()+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
									+'<td id="rStart">'+$('#work_type_s select option:selected').attr('data-s')+'</td>'
									+'<td id="rEnd">'+$('#work_type_s select option:selected').attr('data-e')+'</td>'
									+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;" disabled="disabled">'
									+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
									+'<input type="hidden" id="work_min" value="'+$('#work_type_s select option:selected').attr('data-m')+'"/>'
									+'<input type="hidden" id="break_min" value="'+$('#work_type_s select option:selected').attr('data-b')+'"/>'
									+'<input type="hidden" id="week_flex_yn" value="'+ week_flex_yn +'"/>'
									+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
									+'</tr>';
						}
					}else{

						if (v.NOWSTS == 'Y') {
							html +='<input type="hidden" id="WK_PN_NO" value="'+v.work_plan_detail_id+'">'
									+'<td></td>'
									+'<td><span id="sts" dataYn="Y" nowYn="Y" class="text_blue">신청가능</span></td>'
									+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
									+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
									+'<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+$('#addWorkPlanType select option:selected').val()+'"></td>'
									+'<td id="rStart">'+$('#addWorkPlanType select option:selected').attr('data-s')+'</td>'
									+'<td id="rEnd">'+$('#addWorkPlanType select option:selected').attr('data-e')+'</td>'
									+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;">'
									+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
									+'<input type="hidden" id="work_min" value="'+$('#addWorkPlanType select option:selected').attr('data-m')+'"/>'
									+'<input type="hidden" id="break_min" value="'+$('#addWorkPlanType select option:selected').attr('data-b')+'"/>'
									+'<input type="hidden" id="week_flex_yn" value="'+ week_flex_yn +'"/>'
									+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
									+'</tr>';
						} else {
							html += '<td></td>'
									+'<td><span id="sts" dataYn="Y" nowYn="N" class="text_blue">신청가능</span></td>'
									+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
									+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
									+'<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
									//+'<td>'+$('.addWorkPlanType option:selected').text()+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
									+'<td id="rStart">'+$('#addWorkPlanType select option:selected').attr('data-s')+'</td>'
									+'<td id="rEnd">'+$('#addWorkPlanType select option:selected').attr('data-e')+'</td>'
									+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;" disabled="disabled">'
									+'<input type="hidden" class="week_no" value="'+v.week_no+'"/>'
									+'<input type="hidden" id="work_min" value="'+$('#addWorkPlanType select option:selected').attr('data-m')+'"/>'
									+'<input type="hidden" id="break_min" value="'+$('#addWorkPlanType select option:selected').attr('data-b')+'"/>'
									+'<input type="hidden" id="week_flex_yn" value="'+ week_flex_yn +'"/>'
									+'<input type="hidden" name="holiday_yn" value="'+v.HOLIDAY_STATUS+'"/></td>'
									+'</tr>';
						}
					}
					
					$('#addTbody').append(html);
					
					var row = $('#addTbody').children()[i+2]
					var select = $(row).find('select');
					var workTpId = '';
					var list;
					
					if ( select.length > 0 ) {
						
						var sTime = {};
						var eTime = {};
						var workMin = {};
						var breakMin = {};
						var workId = {};
						
						$.each($(row).find('select option:not(:disabled)'), function(ii, vv){
							sTime[ii] = $(this).attr('data-s');
							eTime[ii] = $(this).attr('data-e');
							workMin[ii] = $(this).attr('data-m');
							breakMin[ii] = $(this).attr('data-b');
							workId[ii] = $(this).val();

						}); 
						select.kendoDropDownList();
						
						$.each(select.children(), function(ii, vv){
							$(vv).attr('data-s', sTime[ii]);
							$(vv).attr('data-e', eTime[ii]);
							$(vv).attr('data-m', workMin[ii]); 
							$(vv).attr('data-b', breakMin[ii]);
						});
						
						if(v.HOLIDAY_STATUS == 'Y'){
							$(row).find('#rStart').text('');
							$(row).find('#rEnd').text('');
							$(row).find('#work_min').val('0');
							$(row).find('#break_min').val('0');
							$(select).data('kendoDropDownList').value('6');
							
						} else if(v.HOLIDAY_STATUS == 'N'){

							if ($("[name='flex_code_id']").val() == '713' && $(row).find('#week_flex_yn').val() == 'Y') {
								$(select).data('kendoDropDownList').value(work_type_s);
							}else{
								$(select).data('kendoDropDownList').value(result.status.WORK_TYPE);
							}
							$(row).find('#rStart').text($(row).find('select option:selected').attr("data-s"));
							$(row).find('#rEnd').text($(row).find('select option:selected').attr("data-e"));
							$(row).find('#work_min').val($(row).find('select option:selected').attr("data-m"));
							$(row).find('#break_min').val($(row).find('select option:selected').attr("data-b"));

						} else {
							var wId = $('#addWorkPlanType select option:selected').val();
							for(var j = 0; j < workId.length; j++){
								if(workId[j] == wId){
									$(row).find('#rStart').text(sTime[0]);
									$(row).find('#rEnd').text(eTime[0]);
									$(row).find('#work_min').val(workMin[0]); 
									$(row).find('#break_min').val(breakMin[0]);
								}
							}
						}
						if($("[name='flex_code_id']").val() != '713') {
							$(row).find('#work_type_id').val($(select).data('kendoDropDownList').value());
						}

						if ( v.NOWSTS == 'N' ) {
							$( select ).kendoDropDownList({
								  enable: false
							});
						}
					}
					
				});
			}
		}
	});  // 시간표 생성
}

function workPlanTypeChange(){
	
	var checkInput = $('#addTbody input[type=checkbox]:checked');
	
	$.each(checkInput, function(i, v){
		if($(v).attr('id') != 'ms'){
			selectType($(v).closest('tr').find('.addWorkPlanType').val($('#topWorkPlanType').val())[0]);
		}
	});
	
	unCheck();
	
}

var weekNo = '';

function selectType(v){
	var row = $(v).closest('tr');
	var before = row.find('#beforeWkTp').val();
	var workTypeId = $(v).val();
	weekNo = row.find('.week_no').val();
	
	if($(v).val() == before && $(v).val() != '11'){
		row.find(".checkbox").removeProp("checked");
	}else{
		row.find(".checkbox").prop("checked", "checked");
	}
	
	row.find('input#work_type_id').val(workTypeId);
	// 탄력근무라면
	if(workTypeId == '11'){
		$.each($('.week_no'), function(i, v){
			var row = $(v).closest('tr');
			if ($(v).val() == weekNo) {
					row.find('#sts').attr('class', 'text_red');
					row.find('#sts').attr('dataYn', 'N');
					row.find('#sts').text('신청 불가');
		    }	
		})
		$(v).closest('tr').find('#work_min').val('');
		$(v).closest('tr').find('#break_min').val('');
		$(v).closest('tr').find('#rStart').text('');
		$(v).closest('tr').find('#rEnd').text('');
		
		//Datepicker disable typing -> onkeydown="return false;"
		$(v).closest('tr').find('#rStart').append(
				'<input type="text" id="attend_time_mod" ' + 
					'ondblclick="selectAll(this);" onkeyup="return false;" ' + //timeCheck(this); 
					'onkeydown="return false;" onfocusout="timeCheck(this);" ' + //timeCheck(this);
					'onchange="timeCheck(this);" name="" check="must" ' + 
					'style="width: 90%" value="" opt="time"/>'
		);
		//Datepicker disable typing -> onkeydown="return false;"
		$(v).closest('tr').find('#rEnd').append(
				'<input type="text" id="leave_time_mod" ' + 
				'ondblclick="selectAll(this);" onkeyup="return false;" ' + //timeCheck(this);
				'onkeydown="return false;" onfocusout="timeCheck(this);" ' + //timeCheck(this);
				'onchange="timeCheck(this);" name="" check="must" ' + 
				'style="width: 90%" value="" opt="time"/>'
		);
		
		var att = $(v).closest('tr').find('#attend_time_mod');
		var lvt = $(v).closest('tr').find('#leave_time_mod');
		
		$(att).kendoTimePicker({
    		format: "HH:mm",
    		culture : "ko-KR",
    		interval : 30,
            dateInput: true,
        });
        
        $(lvt).kendoTimePicker({
    		format: "HH:mm",
    		culture : "ko-KR",
    		interval : 30,
            dateInput: true,
        });
        
    // 탄력근무가 아니라면    
	}else{
		
		$(v).closest('tr').find('#rStart').text($(v[v.options.selectedIndex]).attr('data-s'));
		$(v).closest('tr').find('#rEnd').text($(v[v.options.selectedIndex]).attr('data-e'));
		$(v).closest('tr').find('#work_min').val($(v[v.options.selectedIndex]).attr('data-m'));
		$(v).closest('tr').find('#break_min').val($(v[v.options.selectedIndex]).attr('data-b'));
		$(v).closest('tr').find("#MEMO").val("");
		
		var before = row.find('#beforeWkTp').val();
		var workTypeId = row.find('select').val();
		var week_no = row.find(".week_no").val();
		var weekSum = 0;
		var flex_3m_week_min = parseInt($("#flex_3m_week_min").val());
		var flex_2w_week_min = parseInt($("#flex_2w_week_min").val());
		var flex_code_id = $("[name='flex_code_id']").val();
		
		$.each($('.week_no'), function(i, v){
			if($(v).val() === week_no){
				weekSum += parseInt($(v).closest('tr').find("#work_min").val());
			}
		});
		var max_week_min = 0;
		if(flex_code_id == '629') {
			max_week_min = flex_3m_week_min;
		}else if(flex_code_id == '634'){
			max_week_min = flex_2w_week_min;
		}else{
			max_week_min = "${master.week_law_work_min}";
		}
		
		var work_type_code = "${workType.work_type_code}";
		if(work_type_code === '632'){//전일제
			max_week_min = max_week_min * 1;
		}else if(work_type_code === '633'){//반일제
			max_week_min = max_week_min / 2;
		}
		
		if(flex_code_id !== '') timeShowingBar(weekSum, max_week_min);
		
		console.log('max_week_min', max_week_min, 'weekSum', weekSum, 'flex_code_id', flex_code_id);
		if(weekSum > max_week_min){
			weekOver = weekSum - max_week_min;
			$.each($('.week_no'), function(i, v){
				var eachRow = $(v).closest('tr');
				if($(v).val() === week_no){
					eachRow.find('#sts').attr('class', 'text_red');
					eachRow.find('#sts').attr('dataYn', 'N');
					eachRow.find('#sts').text(weekOver/60 + '시간 초과');
				}
			});
		}else{
			$.each($('.week_no'), function(i, v){
				var eachRow = $(v).closest('tr');
				if($(v).val() === week_no){
					eachRow.find('#sts').attr('dataYn', 'Y');
					eachRow.find('#sts').attr('class', 'text_blue');
					if ( workTypeId == before ) {
						eachRow.find('#sts').text($('#mSts').text());
					} else {
						eachRow.find('#sts').text('신청가능');
					}
				}
			});
		}
		
	}
	sendBtnValidation();
}

var st;
function timeShowingBar(weekSum, max_week_min) {
	
	var sumMaxRatio = (weekSum / max_week_min) * 100;
	var totalMaxRatio = 0;
	
	var flex_code_id = $("[name='flex_code_id']").val();
	var total_work_day = 0;
	var work_min_sum = 0;
	var total_max_min = 0;
	var max_work_day = 0;
	
	var work_type_code = "${workType.work_type_code}";
	var flex_max_min = 0; 
	if(work_type_code === '632'){//전일제
		flex_max_min = 8 * 60;
	}else if(work_type_code === '633'){//반일제
		flex_max_min = 4 * 60;
	}
	
	if(flex_code_id != undefined){
		if(flex_code_id == '629') { //3개월
			$.each($('.week_no'), function(i, v){
				var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
				work_min_sum += work_min;
				if(work_min !== 0){
					total_work_day++;
				}
				var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
				if(holiday_yn !== 'Y'){
					max_work_day++;
				}
			});
		}else if(flex_code_id == '634'){ //2주
			var start_week_no = $("#start_week_no").val() || $('[name="start_week_no"]').val();
			$.each($('.week_no'), function(i, v){
				if(this.value == start_week_no || this.value == parseInt(start_week_no) + 1){
					var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
					work_min_sum += work_min;
					if(work_min !== 0){
						total_work_day++;
					}
					var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
					if(holiday_yn !== 'Y'){
						max_work_day++;
					}
				}
			});
		}
		total_max_min = flex_max_min * max_work_day; //처음 달력상 찍히는 날짜를 기준으로 최대 근무가능 시간 계산
		totalMaxRatio = (work_min_sum / total_max_min) * 100;
		
		//스낵바 프로그레시브 바 - totalBar
		var totalBar = document.getElementById('totalBar'),
			width2 = 1;
		var id2 = setInterval(frame2, 10);
		console.log('totalMaxRatio', totalMaxRatio, 'total_max_min', total_max_min,	'work_min_sum', work_min_sum);
		function frame2(){
			if(width2 >= totalMaxRatio){
				clearInterval(id2);
			}else{
				width2++;
				totalBar.style.width = width2 + '%';
			}
		}
		$('#barMaxTotal').text(total_max_min/60 + '시간');
		$('#barReqTotal').text(work_min_sum/60 + '시간');
		if(work_min_sum === total_max_min){
			$('#barReqTotal').css({
				'color': 'skyblue',
				'font-weight': 'bold'
			});
		}else{
			$('#barReqTotal').css({
				'color': 'orangered',
				'font-weight': 'bold'
			});
		}
	}
	
	//스낵바 팝업
	var bar = document.getElementById('snackbar');
	//bar.className = 'show';
	clearTimeout(st);
	$('#snackbar').css({'top': 'auto', 'z-index': '1'});
	$('#snackbar').stop().animate({
		'bottom': '30px',
		'opacity': '1'
	}, 500);
	st = setTimeout(function(){
		//bar.className = bar.className.replace('show', '');
		$('#snackbar').stop().animate({
			'bottom': '0px',
			'opacity': '0',
			'z-index': '-1'
		}, 500);
	}, 5000);
	
	//스낵바 프로그레시브 바 - weekBar
	var weekBar = document.getElementById('weekBar'),
		width = 1;
	var id = setInterval(frame, 10);
	function frame(){
		if(width >= sumMaxRatio){
			clearInterval(id);
		}else{
			width++;
			weekBar.style.width = width + '%';
		}
	}
	$('#barMaxWeek').text(max_week_min/60 + '시간');
	$('#barReqWeek').text(weekSum/60 + '시간');
	if(weekSum > max_week_min){
		$('#barReqWeek').css({
			'color': 'orangered',
			'font-weight': 'bold'
			});
	}else{
		$('#barReqWeek').css({
			'color': 'skyblue',
			'font-weight': 'bold'
			});
	}
	
}

function timeCheck(e){
	$(e).val($(e).val().replace(/[^0123456789:]/g,""));
	var row = $(e).closest('tr');
	var before = row.find('#beforeWkTp').val();
	var workTypeId = row.find('select').val();
	var week_no = row.find(".week_no").val();
	var attend_time = '';
	var leave_time = '';
	var weekSum = 0;
	var weekOver = 0;
	var flex_3m_week_min = parseInt($("#flex_3m_week_min").val());
	var flex_2w_week_min = parseInt($("#flex_2w_week_min").val());
	var flex_code_id = $("[name='flex_code_id']").val();
	var work_type_code = "${workType.work_type_code}";
	var workMinUrl = '';
	if($(e).val().length === 2){
		$(e).val($(e).val()+':');
	}else if($(e).val().length === 5){
		if(work_type_code === '632'){//전일제
			workMinUrl = '/workPlan/getWorkPlanMin';
		}else if(work_type_code === '633'){//반일제
			workMinUrl = '/workPlan/getWorkMin';
		}
		
		attend_time = row.find("#attend_time_mod").val();
		leave_time = row.find("#leave_time_mod").val();		
		if(attend_time !== '' && leave_time !==''){			
			var data = {
					"attend_time"	: attend_time,
					"leave_time"	: leave_time
			}
			$.ajax({
				url	: _g_contextPath_+ workMinUrl, //"/workPlan/getWorkPlanMin", 20190930 전일제/반일제분기처리 //"/workPlan/getWorkMin", 20190925 8시간초과시 휴게시간 1시간 차감으로 변경
				type: 'POST',
				data: data,
				async: false,
				success: function(result){
					row.find("#work_min").val(result.work_min);
					row.find("#break_min").val(result.rest_min);
					$.each($('.week_no'), function(i, v){
						if($(v).val() === week_no){
							weekSum += parseInt($(v).closest('tr').find("#work_min").val());
						}
					});
					var max_week_min = 0;
					if(flex_code_id == '629') {
						max_week_min = flex_3m_week_min;
					}else if(flex_code_id == '634'){
						max_week_min = flex_2w_week_min;
					}else{
						max_week_min = "${master.week_law_work_min}";
					}
					if(work_type_code === '632'){//전일제
						max_week_min = max_week_min * 1;
					}else if(work_type_code === '633'){//반일제
						max_week_min = max_week_min / 2;
					}
					
					row.find('#MEMO').val(
							'근무시간: ' + parseInt(result.work_min/60) + '시간' 
									  + parseInt(result.work_min%60) + '분, '
						  + '휴게시간: ' + result.rest_min + '분'
						);
					console.log('max_week_min', max_week_min, 'weekSum', weekSum, 'flex_code_id', flex_code_id);
					
					if(flex_code_id !== '') timeShowingBar(weekSum, max_week_min);
					
					if(weekSum > max_week_min){
						weekOver = weekSum - max_week_min;
						$.each($('.week_no'), function(i, v){
							var eachRow = $(v).closest('tr');
							if($(v).val() === week_no){
								eachRow.find('#sts').attr('class', 'text_red');
								eachRow.find('#sts').attr('dataYn', 'N');
								eachRow.find('#sts').text(weekOver/60 + '시간 초과');
							}
						});
					}else{
						$.each($('.week_no'), function(i, v){
							var eachRow = $(v).closest('tr');
							if($(v).val() === week_no){
								eachRow.find('#sts').attr('dataYn', 'Y');
								eachRow.find('#sts').attr('class', 'text_blue');
								if ( workTypeId == before ) {
									eachRow.find('#sts').text($('#mSts').text());
								} else {
									eachRow.find('#sts').text('신청가능');
								}
							}
						});
					}
				}
			});
		}
	}
	sendBtnValidation();
	
}

//bEmpty가 하나라도 펄스면 유연근무 신청 버튼 잠그기
function sendBtnValidation (){
	var bEmpty = true;
	$.each($('.week_no'), function(i, v){
		var row = $(v).closest('tr');
		if (row.find('#sts').attr('dataYn') == 'N') {
			row.find('#WK_PN_SEQ').focus();
			bEmpty = false;
			return false;
		}
	});
	if (!bEmpty) {
		$('.btnClass').attr('disabled', true);
	} else {
		$('.btnClass').attr('disabled', false);
	}
}

function saveBtn(){
	if($("#planType").val() == ''){
		alert("신청 유형을 선택해주세요.")
		return;
	}else if($("#planType").val() != '' && $("#planType").val() == 'normal'){
		if($("#workTermType").val() == ''){
			alert("기간을 선택해주세요.")
			return;
		}
	}else if($("#planType").val() != '' && $("#planType").val() == 'flex'){
		if($("#flexType").val() == ''){
			alert("탄력근무제를 선택해주세요.")
			return;
		}
	}

	if(!confirm('신청 하시겠습니까?')){
		return
	};
	
	var flex_code_id = $("[name='flex_code_id']").val();
	var total_work_day = 0;
	var work_min_sum = 0;
	var total_max_min = 0;
	var max_work_day = 0;
	
	var work_type_code = "${workType.work_type_code}";
	var workTypeKr = "";
	var flex_max_min = 0; //8 * 60;
	if(work_type_code === '632'){//전일제
		workTypeKr = "전일제";
		flex_max_min = 8 * 60;
	}else if(work_type_code === '633'){//반일제
		workTypeKr = "반일제";
		flex_max_min = 4 * 60;
	}
	
	if(flex_code_id != undefined){
		var type = '';
		if(flex_code_id == '629') {
			$.each($('.week_no'), function(i, v){
				var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
				work_min_sum += work_min;
				if(work_min !== 0){
					total_work_day++;
				}
				var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
				if(holiday_yn !== 'Y'){
					max_work_day++;
				}
			});
			type = '3개월';
		}else if(flex_code_id == '634'){
			var start_week_no = $("#start_week_no").val();
			$.each($('.week_no'), function(i, v){
				if(this.value == start_week_no || this.value == parseInt(start_week_no) + 1){
					var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
					work_min_sum += work_min;
					if(work_min !== 0){
						total_work_day++;
					}
					var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
					if(holiday_yn !== 'Y'){
						max_work_day++;
					}
				}
			});
			type = '2주';
		}/*else if(flex_code_id == '713'){
			var start_week_no = $("#start_week_no").val();
			$.each($('.week_no'), function(i, v){
				if(this.value == start_week_no || this.value == parseInt(start_week_no) + 1){
					var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
					work_min_sum += work_min;
					if(work_min !== 0){
						total_work_day++;
					}
					var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
					if(holiday_yn !== 'Y'){
						max_work_day++;
					}
				}
			});
			type = '1주';
		}*/
		//total_max_min = flex_max_min * total_work_day;
		total_max_min = flex_max_min * max_work_day; //처음 달력상 찍히는 날짜를 기준으로 최대 근무가능 시간 계산
		console.log('total_work_day', total_work_day, 'work_min_sum', work_min_sum, 'total_max_min', total_max_min);
		/* if(total_work_day > max_work_day){
			alert('[' + type + '탄력근로제] 신청한 총 근로일수 = ' + total_work_day + '일, \n' +
				' 신청 가능한 최대 근로일수 = ' + max_work_day + '일, \n' +
				' 신청 가능한 최대 근로일수를 초과하였습니다.'
				);
				return;
		} */
		if(work_min_sum > total_max_min){
			alert(workTypeKr + '사원의 '+ type +
				' 최대 주평균 근로시간은 '+ flex_max_min/60*5 +'시간입니다. \n' + 
				'탄력근로 기준 근로일수 = ' + max_work_day + '일, \n' +
				'신청 해야하는 총 근로시간 = ' + total_max_min/60 + '시간, \n' + 
				'신청한 총 근로시간 = ' + work_min_sum/60 + '시간, \n' +
				'초과한 근로시간은 ['+ (work_min_sum - total_max_min)/60 + '시간]입니다'
			);
			return;
		}else if(work_min_sum < total_max_min){
			alert(workTypeKr + '사원의 '+ type +
					' 최대 주평균 근로시간은 '+ flex_max_min/60*5 +'시간입니다. \n' + 
					'탄력근로 기준 근로일수 = ' + max_work_day + '일, \n' +
					'신청 해야하는 총 근로시간 = ' + total_max_min/60 + '시간, \n' + 
					'신청한 총 근로시간 = ' + work_min_sum/60 + '시간, \n' +
					'부족한 근로시간은 ['+ (total_max_min - work_min_sum)/60 + '시간]입니다'
				);
				return;
		}	
	}
	
	var array = new Array();
	var wkPnMsSeq = new Array();
	var step = true;
	
	$.each($('.wkPnNoData'), function(i, v){
		
		var tr = $(v).closest('tr');
		var workTypeId = $(tr).find('input#work_type_id').val();
		
		var attendTime = '';
		var leaveTime = '';
		if ( workTypeId == '11' ) {
			attendTime = $(tr).find('#attend_time_mod').val();
			leaveTime = $(tr).find('#leave_time_mod').val();
		} else {
			attendTime = $(tr).find('#rStart').text();
			leaveTime = $(tr).find('#rEnd').text();
		}
		
		var data = {
				work_date : $(tr).find('#work_date').text().replace(/-/gi , ''),
				weekday : $(tr).find('#weekday').text(),
				attend_time : attendTime,
				leave_time : leaveTime,
				work_type_id	: workTypeId,
				remark		: $(tr).find('#MEMO').val(),
				work_min : $(tr).find('#work_min').val(),
				break_min : $(tr).find('#break_min').val(),
				'week_flex_yn' : $(tr).find('#week_flex_yn').val()
		}
		
		array.push(data);
		
		if ( $(tr).find('#ot_yn').val() == 'Y' && $(tr).find('#sts').attr('nowYn') == 'Y' && parseInt($(tr).find("#work_min").val()) !== 0) {
			
			alert($(tr).find('#work_date').text()+' : 시간외 근무 신청자료가 있습니다. 취소하고 신청해주세요.');
			step = false;
			return false;
		}
		
	});
	
	if (!step) return;

	$.ajax({
		url: "<c:url value='/workPlan/workPlanUserSave' />",
		data : {
			apply_month : $('#searchDt').val().replace(/-/gi , ''),
			empSeq : $('#empSeq').val(),
			default_work_type : $('#default_work_type').val(),
			pk : $('#workPlanPk').val(),
			approval_emp_seq : $('[name="approval_emp_seq"]').val(),
			data : JSON.stringify(array), 
			flex_code_id : flex_code_id,
			work_min_sum : work_min_sum,
			total_work_day : total_work_day,
			start_week_no : $("#start_week_no").val()
			
		},
		async : false,
		type : 'POST',
		success: function(result){
			setData();
			alert('신청 되었습니다.')
		}
	});	
	
}

function reqCancelBtn() {
	var data = {
			work_plan_id :	$('#workPlanPk').val()
			
	};
	var result = confirm('취소 하시겠습니까?');
	
	if (result) {
		
		$.ajax({
			url: _g_contextPath_+"/workPlan/workPlanCancel",
			dataType : 'text',
			data : data,
			type : 'POST',
			success : function(result){
				setData();
				alert('취소 되었습니다.')
			}
		})
	} else {
		setData();
	} 
}

function modBtn() {
	
	var ch = $('.checkbox:checked');
	if (ch.length < 1) {
		alert('변경할 목록을 체크해주세요');
	} else {
		
		var flex_code_id = $("[name='flex_code_id']").val();
		var total_work_day = 0;
		var work_min_sum = 0;
		var total_max_min = 0;
		var max_work_day = 0;
		
		var work_type_code = "${workType.work_type_code}";
		var workTypeKr = "";
		var flex_max_min = 0; //8 * 60;
		if(work_type_code === '632'){//전일제
			workTypeKr = "전일제";
			flex_max_min = 8 * 60;
		}else if(work_type_code === '633'){//반일제
			workTypeKr = "반일제";
			flex_max_min = 4 * 60;
		}
		
		if(flex_code_id != undefined){
			var type = '';
			if(flex_code_id == '629') {
				$.each($('.week_no'), function(i, v){
					var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
					console.log('work_min', work_min);
					work_min_sum += work_min;
					if(work_min !== 0){
						total_work_day++;
					}
					var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
					if(holiday_yn !== 'Y'){
						max_work_day++;
					}
				});
				type = '3개월';
			}else if(flex_code_id == '634'){
				var start_week_no = $("[name='start_week_no']").val();
				$.each($('.week_no'), function(i, v){
					if(this.value == start_week_no || this.value == parseInt(start_week_no) + 1){
						var work_min =  parseInt($(v).closest('tr').find("#work_min").val());
						work_min_sum += work_min;
						if(work_min !== 0){
							total_work_day++;
						}
						var holiday_yn = $(v).closest('tr').find("[name='holiday_yn']").val();
						if(holiday_yn !== 'Y'){
							max_work_day++;
						}
					}
				});
				type = '2주';
			}
			//total_max_min = flex_max_min * total_work_day;
			total_max_min = flex_max_min * max_work_day; //처음 달력상 찍히는 날짜를 기준으로 최대 근무가능 시간 계산
			console.log('total_work_day', total_work_day, 'work_min_sum', work_min_sum, 'total_max_min', total_max_min);
			/* if(total_work_day > max_work_day){
				alert('[' + type + '탄력근로제] 신청한 총 근로일수 = ' + total_work_day + '일, \n' +
					' 신청 가능한 최대 근로일수 = ' + max_work_day + '일, \n' +
					' 신청 가능한 최대 근로일수를 초과하였습니다.'
					);
					return;
			} */
			if(work_min_sum > total_max_min){
				alert(workTypeKr + '사원의 '+ type +
					' 최대 주평균 근로시간은 '+ flex_max_min/60*5 +'시간입니다. \n' + 
					'탄력근로 기준 근로일수 = ' + max_work_day + '일, \n' +
					'신청 가능한 총 근로시간 = ' + total_max_min/60 + '시간, \n' + 
					'신청한 총 근로시간 = ' + work_min_sum/60 + '시간, \n' +
					'초과한 근로시간은 ['+ (work_min_sum - total_max_min)/60 + '시간]입니다'
				);
				return;
			}else if(work_min_sum < total_max_min){
				alert(workTypeKr + '사원의 '+ type +
					' 최대 주평균 근로시간은 '+ flex_max_min/60*5 +'시간입니다. \n' + 
					'탄력근로 기준 근로일수 = ' + max_work_day + '일, \n' +
					'신청 해야하는 총 근로시간 = ' + total_max_min/60 + '시간, \n' + 
					'신청한 총 근로시간 = ' + work_min_sum/60 + '시간, \n' +
					'부족한 근로시간은 ['+ (total_max_min - work_min_sum)/60 + '시간]입니다'
				);
				return;
			}	
		}
		
		var data = {};
		var step = true;
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}
			var tr = $(v).closest("tr");
			var attendTime = '';
			var leaveTime = '';
			var workTypeId = $(tr).find('input#work_type_id').val();
			
			if ( workTypeId == '11' ) {
				attendTime = $(tr).find('#attend_time_mod').val();
				leaveTime = $(tr).find('#leave_time_mod').val();
			} else {
				attendTime = $(tr).find('#rStart').text();
				leaveTime = $(tr).find('#rEnd').text();
			}

			tem['work_type_id'] = workTypeId;
			tem['work_plan_detail_id'] = $(v).closest("tr").find('#work_plan_detail_id').val();
			tem['work_date'] = $(v).closest("tr").find('#work_date').text().replace(/-/gi , '');
			tem['weekday'] = $(v).closest("tr").find('#weekday').text();
			tem['attend_time'] = attendTime;
			tem['leave_time'] = leaveTime;
			tem['work_min'] = $(v).closest("tr").find('#work_min').val();
			tem['break_min'] = $(v).closest("tr").find('#break_min').val();
			tem['change_degree'] = (parseInt($(v).closest("tr").find('#change_degree').val())+1).toString();
			tem['remark'] = $(v).closest("tr").find('#MEMO').val();
			tem['work_plan_id'] = $('#workPlanPk').val();
			tem['approval_emp_seq'] = $('[name="approval_emp_seq"]').val()
			
			data[index] = tem;
			
			
			if ( $(v).closest("tr").find('#status').val() != '2') {
				alert('승인된 건만 체크해주세요.');
				step = false;
				return false;
			} else {
				if (  $(v).closest("tr").find('#beforeWkTp').val() == $(tr).find('input#work_type_id').val() ) {
					if ( $(v).closest("tr").find('select').val() != '11' ) {
						alert('근무유형이 동일한 건이 있습니다.');
						step = false;
						return false;
					} 
					
				}
			}
			
			if ( $(v).closest("tr").find('#ot_yn').val() == 'Y') {
				alert('시간외 근무 신청된 날짜는 변경이 불가능 합니다.');
				step = false;
				return false;
			}
			
		})
		
		if (!step) return;
		
		var result = confirm('신청 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/workPlanChange",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					setData();
					alert('신청 되었습니다.')
				}
			})
		} else {
			setData();
		} 
		
	}
	
}

function modCancelBtn() {
	
	var ch = $('.checkbox:checked');
	if (ch.length < 1) {
		alert('취소할 목록을 체크해주세요');
	} else {
		
		var data = {};
		var step = true;
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}

			tem['work_plan_detail_id'] = $(v).closest("tr").find('#work_plan_detail_id').val();
			tem['work_plan_history_id'] = $(v).closest("tr").find('#work_plan_history_id').val();
			
			data[index] = tem;
			
			if ( $(v).closest("tr").find('#status').val() != '3') {
				alert('변경신청 건만 체크해주세요.');
				step = false;
				return false;
			}
			
		})
		
		if (!step) return;
		
		var result = confirm('취소 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/workPlanChangeCancel",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					setData();
					alert('취소 되었습니다.')
				}
			})
		} else {
			setData();
		} 
	}
	
}

function unCheck(){
	$('input[type=checkbox]').prop("checked", false);
}

function msCheck(e){
	
	if($(e).prop("checked")){
		$('input[type=checkbox]').prop("checked", true);
	}else{
		$('input[type=checkbox]').prop("checked", false);
	}
}

function excelBtn(){
	$('#excelFile').click();
}

function excelFileChange(){
	
	var filePath = $('#excelFile').val();

	var fileExt = filePath.slice(filePath.lastIndexOf('.') + 1).toLowerCase();

	if(fileExt == 'xlsx' || fileExt == 'xls'){
		excelRead();
		
	}else if(filePath != ''){
		alert('파일을 선택해 주세요.');
		$('#excelFile').val('');
		return
	}
	
}

function excelRead(){

	var formData = new FormData();
	
	formData.append('excelFile', $('#excelFile')[0].files[0]);

	$.ajax({
        url: "<c:url value='/workPlan/excelToJson' />",
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(result){

        	$('#excelFile').val('');
        	
        	unCheck();
        	
        	$('#addTbody').empty();
        	
        	//그리기
        	var data = {
				login		: '',
				searchDt	: moment(result.appDt).format('YYYY-MM'),
				type		: 'excel',
			}
        	$.each(result.body, function(i, v){

        		var addTr = '<tr>'+
							'	<th colspan="7" style="text-align: left;"><span style="margin-left: 15px;">'+v.title_4+' / '+v.title_2+'</span></th>'+
							'</tr>'+
							'<tr>';
				if(i == 0){
					addTr += '<th><input type="checkbox" id="ms" onclick="msCheck(this);" style="visibility: hidden;"><label for="ms"></label></th>';
				}else{
					addTr += '<th></th>';
				}		
					addTr += '	<th>근무일자</th>'+				
							'	<th>요일</th>	'+			
							'	<th>근무유형</th>'+				
							'	<th>출근시간</th>'+				
							'	<th>퇴근시간</th>'+				
							'	<th>비고</th>'+				
							'</tr>';
        		
        		if(v.title_1 != 0){
        			$('#addTbody').append(addTr);
	        		data.login = v.title_1;
	       			dataGrid(data, v);
        		};
        		
        		$.each(v, function(ii, vv){
	        		$('.'+v.title_1+ii).closest('tr').find('#WK_PN_SEQ').val(vv);
        		});
        	
        	});
        		
        }
    });

}

function empUserPopupBtn(e){
	window.open( _g_contextPath_ +'/common/deptPopup', '조직도', 'scrollbars=yes, resizeble=yes, menubar=no, toolbar=no, location=no, directories=yes, status=yes, width=910, height=430');
}

function setUserData(seq, name, dept){
	$('#OV_M_TIME').val(dept + ' / ' + name);
	$('#empSeq').val(seq);
	
}

function defaultMod() {
	var data = {
		default_type : $('#default_work_type').val(),
		empSeq		: $('#empSeq').val(),
		month	: $('#searchDt').val().replace(/-/gi , ''),
	}
	
	$.ajax({
		url: _g_contextPath_+"/workPlan/defaultMod",
		dataType : 'text',
		data : data,
		type : 'POST',
		success : function(result){
			setData();
			alert('기본근무유형이 변경되었습니다.')
		}
	})
}


</script>

