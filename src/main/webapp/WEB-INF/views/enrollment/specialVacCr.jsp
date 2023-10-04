<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<style type="text/css">
	.k-header .k-link{
	   text-align: center;
	 
	}
	.k-grid-content>table>tbody>tr
	{
	   text-align: center;
	}  
	.k-grid th.k-header,
	.k-grid-header
	{
	     background : #F0F6FD;
	}
	#div_ajax_load_image{
    	z-index:9999;
    	position: fixed;
    	top: 0%;
    	text-align: center;
    	width: 100%;
    	height: 100%;
    	boackground: #c1b9b9a6;
    	display: none;
    }
    
	.empListDD{
		float: left;
	    clear: none;
	    margin: 1px !important;
	    padding: 2px;
	    border: 1px solid #accfff;
	    background-color: #eff7ff;
	    color: #4a4a4a;
	}
	.k-dropdown-wrap.k-state-default {
		overflow: hidden;
	}
</style>
<jsp:useBean id="nowDate" class="java.util.Date" />
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/FileSaver2.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jszip2.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/special2.js?v=${nowDate}"></c:url>'></script>
	<!-- iframe wrap -->
	<div class="iframe_wrap" style="min-width:1100px">
		<form id="vcatnFrm" name="vcatnFrm">
			<input type="hidden" id="crtrEmplSn" 				name="crtrEmplSn" 						value="${sessionScope.loginVO.uniqId == null ? '100000178' : sessionScope.loginVO.uniqId}"/>
			<input type="hidden" id="deptSeq"					name="deptSeq"							value="" /><!-- 사원검색 선택 후 부서 seq -->
			<input type="hidden" id="deptName"					name="deptName"							value="" /><!-- 사원검색 선택 후 부서명 -->
			<input type="hidden" id="empSeq"					name="empSeq"							value="" /><!-- 사원검색 선택 후 사원 seq -->
			<input type="hidden" id="empName"					name="empName"							value="" /><!-- 사원검색 선택 후 사원이름 -->
			<input type="hidden" id="useYn"						name="useYn"							value="Y" /><!-- 사용여부 기본 Y -->
			<input type="hidden" id="speclVcatnSetupSn"				name="speclVcatnSetupSn"						value="" /><!-- 휴가종류 -->
			<input type="hidden" value="681" id="vcatnGbnCmmnCd" />
			<!-- 컨텐츠타이틀영역 -->
			<div class="sub_title_wrap">
				
				<div class="title_div">
					<h4>특별휴가 생성</h4>
				</div>
			</div>
			
			<div class="sub_contents_wrap">
			<p class="tit_p mt5 mt20">특별휴가 생성</p>
				<div class="top_box">
					<dl style="height:40px;">
						<dt class="ar" style="width: 65px">구분</dt>
						<dd>
							<input type="text" disabled="disabled" value="특별휴가"/>
							<select style="width:120px; height:24px;" id="vcatnGbnName" > 
							<optgroup label="특별휴가">
							</optgroup>
							</select>
						</dd>
						<dt  class="ar" style="width:65px" >부여휴가</dt>
						<dd>
							<input type="text" id="speclVcatnRemndrDaycnt" name="speclVcatnRemndrDaycnt" style="width:40px; margin-right:5px;"/>일
						</dd>
					</dl>
					<dl>
						<dt  class="ar" style="width:65px" >비고</dt>
						<dd>
							<input type="text" id="rmk" name="rmk" style="width:660px;" />
						</dd>
					</dl>
					<dl>
						<dt class="ar" style="width: 65px">부서</dt>
						<dd>
							<input type="text" id="requestDeptSeq" />
		
						</dd>
						<dt class="ar" style="width: 65px">이름</dt>
						<dd>
							<input type="text" id="empNameSearch" name="empNameSearch"
								style="width: 130px;"> <input type="hidden"
								id="empSeqSearch" name="empSeqSearch">
						</dd>
					</dl>
					<dl>
						<dt class="ar" style="width: 65px">대상자</dt>
						<dd>
							<dl id="selectListDiv" style="height: 23px; border: 1px solid #c3c3c3; padding-left: 2%; padding-right: 2%; width: 400px; background: white; display: table;"></dl>
						</dd>
						<dd style="margin-left: 1%;">
							<input type="button" id="empSearch" value="검색" />
						</dd>
					</dl>
				</div>
				<div class="btn_div" style="margin-top:20px;">	
					<div class="left_div">
						<p class="tit_p mt5 mb0">휴가종류</p>
					</div>
	
					<div class="right_div">
						<div class="controll_btn p0">
							<button type="button" id="excelUpload">엑셀 업로드</button>
							<button type="button" id="btnSearch">조회</button>									
							<button type="button" id="btnSave">등록</button>
							<button type="button" id="btnPopup">수정</button>
							<button type="button" id="btnDelete">삭제</button>
						</div>
					</div>
				</div>						
				<div class="com_ta2 mt15">
				    <div id="grid"></div>
				</div>	
			</div><!-- //sub_contents_wrap -->
		</form>
	</div><!-- iframe wrap -->
	
<!-- 사원검색팝업 -->
<div class="pop_wrap_dir" id="empPopUp" style="width: 600px; margin: auto;">
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
			<button type="button" id="selectList" class="gray_btn">선택</button>
			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--수정팝업 -->
<div class="pop_wrap_dir" id="vacationPopUp" style="width:800px;">
	<div class="pop_head">
		<h1>특별휴가 수정</h1>
	</div>
	<form id="vcatnSetPopupFrm" name="vcatnSetPopupFrm">
		<input type="hidden" 		id="speclSn" 				name="speclSn" 									 />
		<input type="hidden" 		id="vcatnCreatHistSn" 		name="vcatnCreatHistSn" 				value="" />
		<input type="hidden" 		id="creatGbn" 				name="creatGbn" 						value="U" />
		<input type="hidden"     		  						name="useYn"							value="Y" /><!-- 사용여부 기본 Y -->
		<input type="hidden" 		id="speclVcatnSetupSn2" 			name="speclVcatnSetupSn" 						value="" />
		<div class="com_ta mt15" style="">
			<div>
				<div class="top_box">
					<dl style="height:40px;">
						<dt class="ar" style="width: 65px">구분</dt>
						<dd>
							<input type="text" disabled="disabled" value="특별휴가"/>
							<select style="width:120px; height:24px;" id="vcatnGbnName2">
							<optgroup label="특별휴가">
							</optgroup>
							</select>
						</dd>
						<dt  class="ar" style="width:65px" >부여휴가</dt>
						<dd>
							<input type="text" id="speclVcatnRemndrDaycnt2" name="alwncDaycnt" style="width:40px; margin-right:5px;"/>일
						</dd>
					</dl>
					<dl>
						<dt  class="ar" style="width:65px" >비고</dt>
						<dd>
							<input type="text" id="rmk2" name="rmk" style="width:660px;" />
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
<div id="div_ajax_load_image">
	<div style="margin-top: 25%;">
		<img src="<c:url value='/egov_cms/images/img_loading.gif'/>" alt="로딩 이미지">
	</div>	
</div>

<form class="pop_wrap_dir" id="excelUploadForm"	name="excelUploadForm" style="width: 540px;" enctype="multipart/form-data" method="post">
	<input type="hidden" id="" 				name="crtrEmplSn" 						value="${sessionScope.loginVO.uniqId == null ? '100000178' : sessionScope.loginVO.uniqId}"/>
	<div class="pop_head">
		<h1>업로드</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 75px;">구분</dt>
				<dd>
					<input type="text" disabled="disabled" value="특별휴가"/>
					<select style="width:120px; height:24px;" id="vcatnGbnNameExcel" name="vcatnGbnNameExcel"> 
					<optgroup label="특별휴가">
					</optgroup>
					</select>
				</dd>
			</dl>
			<dl>
				<dt class="ar" style="width: 75px;">비고</dt>
				<dd style="width: 350px;">
				
					<input type="text" id="remark" name ="remark" style="width: 265px" /> <input
						type="button" id="excelDown" onclick="excelFormDown();"
						value="양식다운"  style="width: 50px"/>
				</dd>
			</dl>
		</div>
		<p class="mb10">
			<span class="text_red">10MB</span>이하의 파일만 등록 할 수 있습니다. 
			<span class="text_red"></span>엑셀 파일만 업로드 가능합니다.
		</p>
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th>파일첨부</th>
					<td class="le">
						<div class="clear">
							<input type="text" id="fileID" class="file_input_textbox clear" readonly="readonly" style="width: 280px;" />
							<div class="file_input_div">
								<input type="button" onclick="uploadBtn(this);" value="업로드"	class="file_input_button ml4 normal_btn2" style="height: 22px;"> 
								<input type="file" id="excelFile" name="excelFile" class="hidden" onchange="getFileNm(this);" />
								<input type="hidden" name = "emp_seq" value="${sessionScope.loginVO.uniqId}">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="uploadSave" value="등록" /> 
			<input type="button" class="gray_btn" id="uploadCancle" value="취소" />
		</div>
	</div>
</form>

<script type="text/javascript">
	var saveEmpSeq = new Array();
	
 	$(function(){
		mainGrid();
		empGrid();
		//휴가 구분
		fn_codeListComboBoxInit('vcatnGbnName');
		//휴가 구분 팝업
		fn_codeListComboBoxInit('vcatnGbnName2');
		vcatnGbnNameExcelComboBoxInit('vcatnGbnNameExcel');
		//부서 콤보박스 초기화
		fnTpfDeptComboBoxInit('requestDeptSeq');
		//사원검색 시작
		$(document).keypress(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		});

		$("#empNameSearch").keydown(function(keyNum) { //현재의 키보드의 입력값을 keyNum으로 받음
			if (keyNum.keyCode == 13) { // keydown으로 발생한 keyNum의 숫자체크 // 숫자가 enter의 아스키코드 13과 같으면 // 기존에 정의된 클릭함수를 호출
				$("#btnSearch").click();
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
		
		$("#btnSearch").on("click", function(){
			gridReload();
		});

		//사원검색
		var empWindow = $("#empPopUp");
		//검색ID
		empSearch = $("#empSearch");
		//검색 클릭(팝업호출)
		empSearch.click(function() {
			empWindow.data("kendoWindow").open();
			$("#emp_name").val($("#empNameSearch").val());
			$("#empSeq").val("");
			empGridReload();
			$("#headerEmpBox").prop("checked", false);
			empSearch.fadeOut();
		});

		//팝업 X 닫기버튼 이벤트
		function onClose() {
			fn_fieldReSet2();
			gridReload();
			empSearch.fadeIn();
		}
		
		//팝업 X 닫기버튼 이벤트
		function onExcelClose() {
			$("#vcatnGbnNameExcel").empty();
			vcatnGbnNameExcelComboBoxInit('vcatnGbnNameExcel');
			$("#remark").val("");
			$("#excelFile").val("");
			$("#fileID").val("");
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
		//사원검색 끝
		
		//저장
		$("#btnSave").on("click", function(){
			
			if(saveEmpSeq.length == 0){
				if($("#empNameSearch").val() == null || $("#empNameSearch").val() == ""){
					alert("선택된 사원이 없습니다.");
					return false;
				}
			}
			if($("#vcatnGbnName").val() == null || $("#vcatnGbnName").val() == ""){
				alert("선택된 휴가 구분이 없습니다.");
				return false;
			}
			if($("#speclVcatnRemndrDaycnt").val() == null || $("#speclVcatnRemndrDaycnt").val() == ""){
				alert("부여휴가 일이 없습니다.");
				return false;
			}
			
			
			
			fn_save("write");
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
			$("#speclSn").val(checkGroup[0].value);
			myWindow.data("kendoWindow").open();
		});
		//수정팝업
		var myWindow = $("#vacationPopUp");
		myWindow.kendoWindow({
			  width:  "800px",
			  height: "350px",
		     visible:  false,
		     actions: ["Close"],
		     close: onClose
		 }).data("kendoWindow").center();
		
		//팝업창 닫기
		$("#changeCancle").click(function(){
			myWindow.data("kendoWindow").close();
		});
		
		//전체체크		headerEmpBox
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
		
		
		//사원팝업 전체 선택	 find사원
		$("#headerEmpBox").change(function(){
			var checkedIds = {};
		    if($("#headerEmpBox").is(":checked")){
		    	$(".empBox_group").prop("checked", "checked");
		    }else{
		    	$(".empBox_group").removeProp("checked");
		    }
		});
		//사원팝업 전체 선택 종료
		
		//사원팝업 다중선택
		$("#selectList").on("click", function(){
			var checkGroup = $(".empBox_group:checked").not("#headerEmpBox");
			if(checkGroup.length == 0){
				alert("선택된 사원이 없습니다.");
				return false;
			}
			saveEmpSeq = [];
			var str = "";
			for(var i = 0 ; i < checkGroup.length ; i++){
				var row = $("#empGrid").data("kendoGrid").dataItem(checkGroup[i].closest("tr"));
				str += "<dd class='empListDD'>";
				str += "[" + row.dept_name + "] "+ row.emp_name;
				//str += "<a href='javascript:;'>X</a>";
				str += "</dd>";
				saveEmpSeq[i] = checkGroup[i].value;
				
			}
			$("#selectListDiv").html(str);
			$("#empSeq").val("");
			empWindow.data("kendoWindow").close();
		});
		//사원팝업 다중선택 종료
		
		//수정
		$("#btnUpdate").on("click", function(){
			fn_update();
		});
		
		//03-28 엑셀  업로드
		$("#excelUpload").click(function() {
			$("#excelUploadForm").data("kendoWindow").open();
		});
		
		$("#excelUploadForm").kendoWindow({
			width : "540px",
			height : "350px",
			visible : false,
			actions : [ "Close" ],
			close : onExcelClose
		}).data("kendoWindow").center();
		
		$("#uploadCancle").click(function() {
			$("#excelUploadForm").data("kendoWindow").close();
		});
		
		$("#uploadSave").on("click" , function(e){
			if(!$("#vcatnGbnNameExcel").val()){
				alert("부여하는 휴가가 없습니다.");
				return false;
			}
			fileCheck(e);
			fn_codeListComboBoxInit('vcatnGbnName');
			fn_codeListComboBoxInit('vcatnGbnName2');
			vcatnGbnNameExcelComboBoxInit('vcatnGbnNameExcel');
			$("#uploadCancle").click();
			
		});
		
	});
 	function vcatnGbnNameExcelComboBoxInit(id){
		if($('#'+id)){
			var codeList = fn_codeList();
			codeList.unshift({VCATN_KND_NAME : '전체', SPECL_VCATN_SETUP_SN : ""});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : codeList,
				dataTextField: "VCATN_KND_NAME",
				dataValueField: "SPECL_VCATN_SETUP_SN",
				index: 0,
				change:function(){
					$("#speclVcatnSetupSn2").val(this.value());
					fnDeptChange();
				}
			});
			$(".k-input").attr("readonly", "readonly");			
		}
	}

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
					$("#requestDeptSeq").val(this.value());
					gridReload();
				}
			});
			$(".k-input").attr("readonly", "readonly");
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
 	// 휴가구분 시작
 	function fn_codeListComboBoxInit(id){
		if($('#'+id)){
			var codeList = fn_codeList();
			codeList.unshift({VCATN_KND_NAME : '전체', SPECL_VCATN_SETUP_SN : ""});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : codeList,
				dataTextField: "VCATN_KND_NAME",
				dataValueField: "SPECL_VCATN_SETUP_SN",
				index: 0,
				change:function(){
					$("#speclVcatnSetupSn").val(this.value());
					$("#speclVcatnSetupSn2").val(this.value());
					fn_fieldDivision(this.value());
					fnDeptChange();
					gridReload();
				}
			});
			$(".k-input").attr("readonly", "readonly");			
		}
	}
	var check;
 	function fn_codeList(){
		var result = {};
		var params = {
			vcatnGbnCmmnCd : $("#vcatnGbnCmmnCd").val(),
			isAdmin : "special"
		};
		var opt = {
			url     : "<c:url value='/enrollment/specialVacSetList'/>",
			async   : false,
			data    : params,
			successFn : function(data){
				result = data.rs;
			}
		};
		acUtil.ajax.call(opt);
		return result;
	}
 	function fnDeptChange(){
		var obj = $('#vcatnGbnName').data('kendoComboBox');
	}
 	// 휴가구분 종료
 	
 	
 	//사원 팝업
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
 	
 	//사원 체크박스
 	function fn_empBoxGroup(row){
 		var str = "";
 		str += "<input type='checkbox' class='empBox_group emp"+row.emp_seq+"' value='"+row.emp_seq+"'>";
 		str += "</div>";
 		return str;
 	}
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
								pageSizes : [10,20,30,50,100],
								buttonCount : 5
							},
							persistSelection : true,
							selectable : "multiple",
							columns : [
									{
										headerTemplate: "<input type='checkbox' id='headerEmpBox' class='empBox_group'>",
						            	template : fn_empBoxGroup,
						                width : 50,										
									},
									{
										field : "emp_name",
										title : "이름",
										template : fn_empName,
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
									}/*,
									{
										title : "선택",
										template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
									}*/ ],
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
 	
 	function empGridReload() {
 		$("#selectListDiv").empty();
 		saveEmpSeq = [];
		$("#empGrid").data('kendoGrid').dataSource.read();
	}
 	
 	//선택 클릭이벤트
	function empSelect(e) {
		//선택row
		var row = $("#empGrid").data("kendoGrid").dataItem($(e).closest("tr"));
		
		/*
		$('#empNameSearch').val(row.emp_name);
		$("#empName").val(row.emp_name);
		$('#empSeqSearch').val(row.emp_seq);
		$("#empSeq").val(row.emp_seq);
		$("#deptSeq").val(row.dept_seq);
		$("#deptName").val(row.dept_name);
		var requestDeptSeq = $("#requestDeptSeq").data("kendoComboBox");
		requestDeptSeq.value(row.dept_name);
		*/
		var indexNum = Number(saveEmpSeq.length);
		console.log(indexNum);
		saveEmpSeq[0] = row.emp_seq;
		console.log(saveEmpSeq);
		var str = "";
		str += "<dd class='empListDD'>";
		//str += ""+row.emp_name+"";
		str += "[" + row.dept_name + "] "+ row.emp_name;
		str += "</dd>";
		
		$("#selectListDiv").html(str);
		
		//팝업ID	
		var empWindow = $("#empPopUp");
		//사원리스트 초기화
		saveEmpSeq = [];
		//닫기 이벤트
		empWindow.data("kendoWindow").close();
	}
	//사원팝업 끝
 	
	 var dataSource = new kendo.data.DataSource({
		serverPaging: true,
		pageSize: 10,
	    transport: { 
	        read:  {
	            url: "<c:url value='/vcatn/getSpecialList'/>",
	            dataType: "json",
	            type: 'post'
	        },
	      	parameterMap: function(data, operation) {
	        	data.empSeq = $('#use_emp_seq').val();
	        	data.empNameSearch = $("#empNameSearch").val();
	        	data.deptName = $("#requestDeptSeq").val();
	        	data.speclVcatnSetupSn = $("#speclVcatnSetupSn").val();
	        	data.isAdmin = "special";
	     	return data;
	     	}
	    },
	    schema: {
	      data: function(response) {
	        return response.list;
	      },
	      total: function(response) {
		        return response.list.length;
		      },
		      model: {
		          fields: {

		        	  weekDay: { type: "string" },
		              
		       
		          }
		      }
	    }
	});
	/* 토요일 일요일 그리드 색깔 처리 함수 */
	function fn_weekDay(row) {
		var key = row.weekDay;
		
		switch (key) {
			case '토' : return '<span style="color:blue">'+key+'</span>'; 
				break;
			case '일' : return '<span style="color:red">'+key+'</span>'; 
				break;
			default  : return '<span>'+key+'</span>'; 
				break;
		}
		
	}
	/* 데이터 없을 시 첫번째 그리드 처리 함수 */
	function gridDataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	
	
    /* 데이터 없을 시 두번째 그리드 처리 함수 */
	function grid2DataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	







function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
}

/* 대체휴무 발생현황 개인조회 리스트 */
function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        height: 500,
        dataBound: function(e)
        {
            //console.log(this.dataSource.data());
            //this.fitColumns();
            gridDataBound(e);
          },
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes : [10,20,30,50,100],
            buttonCount: 5
        },
        persistSelection: true,
        selectable: "multiple",
        columns: [
        	
           	{
            	headerTemplate: "<input type='checkbox' id='headerCheckbox' class='checkbox_group'>",
            	template : fn_checkBox,
                width : 30,
            },{
            	field: "VCATN_KND_NAME",
            	title: "구분",
            	width: 100,
            	template : function(row){
            		return "[특별휴가] " + row.VCATN_KND_NAME;
            	},
            },{
            	field: "DEPT_NAME",
            	title: "부서",
            	width: 100,
            },{
            	field: "EMP_NAME",
                title: "이름",
                width: 70,
               
            },{
            	field: "ALWNC_DAYCNT",
                title: "잔여일",
                width : 50,
            },{
                
                field: "useDate",
                title: "사용일",
                width : 50,
            },{
                field: "RMK",
                title: "비고",
                width : 200,
            },],
        change: function (e){
        	codeGridClick(e)
        }
    }).data("kendoGrid");
	
	grid.table.on("click", ".checkbox", selectRow);
	
	var checkedIds = {};
	
	// on click of the checkbox:
	function selectRow(){
		
		var checked = this.checked,
		row = $(this).closest("tr"),
		grid = $('#grid').data("kendoGrid"),
		dataItem = grid.dataItem(row);
		
		checkedIds[dataItem.CODE_CD] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	function codeGridClick(){
		 var rows = grid.select();
		var record;
		rows.each( function(){
			record = grid.dataItem($(this));
		});
		$("#headerCheckbox"+record.SPECL_SN).click();
		if($("#headerCheckbox"+record.SPECL_SN).is(":checked")){
			//$(".checkbox_group").not("#headerCheckbox"+record.SPECL_SN).prop("checked", false);
			//fn_dateSet(record.SPECL_SN);
		}
		
	}
}
//체크박스
function fn_checkBox(row){
	var str = "<input type='checkbox' id='headerCheckbox"+row.SPECL_SN+"' class='checkbox_group' value="+row.SPECL_SN+">";
	return str;
}
function fn_empName(row){
	var str = "<input type='hidden' class='empName' value='"+row.emp_name+"'/>" + row.emp_name;
	return str;
}
//구분데이터 넣기
function fn_fieldDivision(key){
	$("#speclVcatnRemndrDaycnt").val("");
	$("#rmk").val("");
	var formData = new FormData();
	formData.append("speclVcatnSetupSn", key);
	$.ajax({
		url: "<c:url value='/vcatn/getSpecialVacCode'/>",
		data: formData,
		type: 'POST',
		processData: false,
		contentType: false,
		dataType: 'json',
		cache: false,
		async: false,
		success:function(result){
			var obj = result.object;
			if(obj != null){
				$("#speclVcatnRemndrDaycnt").val(obj.alwncVcatn);
				$("#rmk").val(obj.cn);
			}
		}
	});	
}
function fn_save(mode){
	var formData = new FormData(document.getElementById("vcatnFrm"));
	formData.append("mode" , mode);
	formData.append("vcatnGbnName" , $("#speclVcatnSetupSn").val());
	if(saveEmpSeq.length > 0){
		formData.append("saveEmpList", saveEmpSeq);
	}
	$.ajax({
		url:"<c:url value='/vcatn/specialSave'/>",
		data: formData,
		type: 'POST',
		processData: false,
		contentType: false,
		dataType: 'json',
		cache: false,
		async: false,
		success:function(result){
			if(result.object.message2 != null){
				alert(result.object.message2);
			}
			alert(result.object.message);
			var vcatnGbnName = $("#vcatnGbnName").kendoComboBox();
			vcatnGbnName.select(0);
			fn_fieldReSet();
		},beforeSend: function(){
            $("#div_ajax_load_image").show();
		},complete: function(){
			$("#div_ajax_load_image").hide();
		}
	});	
}
//수정
function fn_update(){
	var formData = new FormData(document.getElementById("vcatnSetPopupFrm"));
	formData.append("vcatnGbnName", $("#vcatnGbnName").val());
	formData.append("crtrEmplSn" ,$("#crtrEmplSn").val());
	formData.append("deptName", $("#deptName").val());
	formData.append("deptSeq", $("#deptSeq").val());
	formData.append("empSeq", $("#empSeq").val());
	formData.append("empName", $("#empName").val());
	
	$.ajax({
		url:"<c:url value='/vcatn/specialUpdate'/>",
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
			fn_fieldReSet();
		}
	});	
	
}
//삭제
function fn_delete(list){
	var formData = new FormData();
	formData.append("list", list);
	formData.append("empSeq", $("#empSeq").val());
	$.ajax({
		url:"<c:url value='/vcatn/deleteSpecialVcatn'/>",
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
function fn_fieldReSet(){
	$("#headerCheckbox").prop("checked", false);
	fnTpfDeptComboBoxInit('requestDeptSeq');
	fn_codeListComboBoxInit('vcatnGbnName');
	fn_codeListComboBoxInit('vcatnGbnName2');
	$("#speclVcatnRemndrDaycnt").val("");	
	$("#deptSeq").val("");
	$("#deptName").val("");
	$("#empSeq").val("");
	$("#empName").val("");
	$("#empNameSearch").val("");
	$("#empSeqSearch").val("");
	$("#rmk").val("");
	$("#vcatnCreatHistSn").val("");
	$("#speclVcatnSetupSn").val("");
	$("#speclVcatnRemndrDaycnt2").val("");
	$("#rmk2").val("");
	$("#speclSn").val("");
	$("#selectListDiv").empty();
	$("#grid").data('kendoGrid').dataSource.read();
}

function fn_fieldReSet2(){
	$("#headerCheckbox").prop("checked", false);
	fnTpfDeptComboBoxInit('requestDeptSeq');
	fn_codeListComboBoxInit('vcatnGbnName2');
	$("#deptSeq").val("");
	$("#deptName").val("");
	$("#empSeq").val("");
	$("#empName").val("");
	$("#empNameSearch").val("");
	$("#empSeqSearch").val("");
	$("#vcatnCreatHistSn").val("");
	$("#speclVcatnRemndrDaycnt2").val("");
	$("#rmk2").val("");
	$("#speclSn").val("");
}

//필드 데이터 추가
function fn_dateSet(key){
	var formData = new FormData();
	formData.append("speclSn", key);
	formData.append("vcatnGbnCmmnCd", $("#vcatnGbnCmmnCd").val());
	$.ajax({
		url:"<c:url value='/vcatn/getSpecialOne'/>",
		data: formData,
		type: 'POST',
		processData: false,
		contentType: false,
		dataType: 'json',
		cache: false,
		async: false,
		success:function(result){
			var obj = result.object;
			if(obj != null){
				var requestDeptSeq = $('#requestDeptSeq').data('kendoComboBox');
				var vcatnGbnName = $('#vcatnGbnName').data('kendoComboBox');
				requestDeptSeq.value(obj.DEPT_NAME);//부서명
				vcatnGbnName.value(obj.VCATN_KND_NAME);//휴가명
				$("#rmk").val(obj.RMK);//비고
				$("#empNameSearch").val(obj.EMP_NAME);//이름
				$("#deptSeq").val(obj.DEPT_SEQ);//부서키	
				$("#empSeq").val(obj.EMP_SEQ);//사원고유키
				$("#speclVcatnRemndrDaycnt").val(obj.ALWNC_DAYCNT);
				$("#deptName").val(obj.DEPT_NAME);//부서키	
				$("#empName").val(obj.EMP_NAME);//사원고유키
				
				
				//팝업창용
				var vcatnGbnName2 = $('#vcatnGbnName2').data('kendoComboBox');
				vcatnGbnName2.value(obj.VCATN_KND_NAME);//휴가명
				//fn_kendoComboBoxChange
				$("#vcatnCreatHistSn").val(obj.SPECL_SN);
				$("#speclSn").val(obj.VCATN_SN);
				$("#speclVcatnRemndrDaycnt2").val(obj.ALWNC_DAYCNT);
				$("#rmk2").val(obj.RMK);//비고
				$("#speclVcatnSetupSn2").val(obj.SPECL_VCATN_SETUP_SN);
			}else{
				fn_fieldReSet();
			}
		}
	});	
}

function getFileNm(e) {
	var index = $(e).val().lastIndexOf('\\') + 1;
	var valLength = $(e).val().length;
	$('#fileID').val($(e).val().substr(index, valLength));
	vacation.global.fileList = new Array();
	console.log(e);
	vacation.global.fileList[0] = e;
	
}
function uploadBtn(e) {
	$(e).next().click();
}
</script> 