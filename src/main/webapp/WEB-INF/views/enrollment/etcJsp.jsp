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
      
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>유효기간</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">유효기간</p>
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
		</form>
			<div class="btn_div" style="margin-top: 20px;">
			<table>
				<thead>
				</thead>
				<tbody>
					<tr style="display: none;">
						<td>
							<form id="etcFrm1" style="margin: 10px;" border="1">
								휴가종류1<input type="text" id="etc1_1" name="etc1_1">
								휴가종류2<input type="text" id="etc1_2" name="etc1_2">
								휴가종류3<input type="text" name="etc1_3">
								사용일수<input type="text" id="etc1_4" name="etc1_4">
								사원번호<input type="text" id="etc1_5" name="etc1_5">
								<input type="button" id="etc1" onclick="fn_etc1();" value="사용일수">						
							</form>
						</td>
					</tr>
					<tr>
						<td>
							<form id="etcFrm2" style="margin: 10px;"  border="1">
								사원번호 : <input type="text" id="etc2_1" name="etc2_1" readonly="readonly">
								유효기간 : <input type="text" id="etc2_2" name="etc2_2">
								<input type="button" id="etc2" onclick="fn_etc2();" value="저장">						
							</form>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="com_ta2 mt15">
			<div id="etcDiv1"></div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
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
		empGrid()
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

		$("#empSearch").on("click", function(){
			$('#etcDiv1').data('kendoGrid').dataSource.read();
		});
		
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
		
		$("#etc2_2").kendoDatePicker({
			 // defines the start view
	        start : "month",

	        // defines when the calendar should return date
	        depth : "month",

	        // display month and year in the input
	        format : "yyyy-MM-dd",
	        parseFormats : [ "yyyy-MM-dd" ],

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
			if($("#lnglbcVcatnFrstAlwncDaycnt").val() == null || $("#lnglbcVcatnFrstAlwncDaycnt").val() == ''){
				alert("장기근속휴가 최초부여일이 없습니다.");
				$("#lnglbcVcatnFrstAlwncDaycnt").focus();
				return false;
			}
			//연가 조정부여일
			if($("#yrvacMdtnAlwncDaycnt").val() == null || $("#yrvacMdtnAlwncDaycnt").val() == ''){
				$("#yrvacMdtnAlwncDaycnt").val(0);
			}
			//장기근속휴가 조정부여일
			if($("#lnglbcVcatnMdtnAlwncDaycnt").val() == null || $("#lnglbcVcatnMdtnAlwncDaycnt").val() == ''){
				$("#lnglbcVcatnMdtnAlwncDaycnt").val(0);
			}
			
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
		        grid = $("#etcDiv1").data("kendoGrid"),
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
		
		
		
		$(".k-input").attr("readonly", "readonly");
		
		
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
		$('#etcDiv1').data('kendoGrid').dataSource.read();
	}

	/* 대체휴무 발생현황 개인조회 리스트 */
	
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
				data.emp_name = $('#empNameSearch').val();
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

	function subReload(record) {
		$('#keyId').val(record.if_info_system_id);
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
				//$("#etcDiv1").data('kendoGrid').dataSource.read();
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
		$("#lnglbcVcatnFrstAlwncDaycnt").val("");//장기근속최초부여
		$("#lnglbcVcatnMdtnAlwncDaycnt").val("");//장기근속조정부여
		$("#lnglbcVcatnCreatResn").val("");//장기근속조정사유
		$("#yrvacRemndrDaycnt").val(0);//연가잔여일
		$("#lnglbcVcatnRemndrDaycnt").val(0);//장기근속잔여일
		$("#rmk").val("");//비고
		$("#applyYr").val("${year}");//적용년도
		$("#empNameSearch").val("");//이름
		$("#deptSeq").val("");//부서키
		fnTpfDeptComboBoxInit('requestDeptSeq');
		$("#etcDiv1").data('kendoGrid').dataSource.read();
	}
	//필드 초기화
	function fn_fieldReSet2(){
		//부서콤보박스 초기화
		$("#yrvacFrstAlwncDaycnt").val("");//연가최초부여
		$("#yrvacMdtnAlwncDaycnt").val("");//연가조정부여
		$("#yrvacCreatResn").val("");//연가조정사유
		$("#lnglbcVcatnFrstAlwncDaycnt").val("");//장기근속최초부여
		$("#lnglbcVcatnMdtnAlwncDaycnt").val("");//장기근속조정부여
		$("#lnglbcVcatnCreatResn").val("");//장기근속조정사유
		$("#yrvacRemndrDaycnt").val(0);//연가잔여일
		$("#lnglbcVcatnRemndrDaycnt").val(0);//장기근속잔여일
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
				$("#lnglbcVcatnFrstAlwncDaycnt").val(obj.lnglbcVcatnFrstAlwncDaycnt);//장기근속최초부여
				$("#lnglbcVcatnMdtnAlwncDaycnt").val(obj.lnglbcVcatnMdtnAlwncDaycnt);//장기근속조정부여
				$("#lnglbcVcatnCreatResn").val(obj.lnglbcVcatnCreatResn);//장기근속조정사유
				$("#rmk").val(obj.rmk);//비고
				$("#applyYr").val(obj.applyYr);//적용년도
				$("#empNameSearch").val(obj.empName);//이름
				$("#deptSeq").val(obj.deptSeq);//부서키	
				$("#yrvacRemndrDaycnt").val(obj.yrvacRemndrDaycnt);//연가잔여일
				$("#lnglbcVcatnRemndrDaycnt").val(obj.lnglbcVcatnRemndrDaycnt);//장기근속잔여일
				$("#empSeq").val(obj.empSeq);//사원고유키
				var requestDeptSeq = $('#requestDeptSeq').data('kendoComboBox');
				requestDeptSeq.value(obj.deptName);//부서명
				
				//팝업용
				$("#yrvacFrstAlwncDaycnt2").val(obj.yrvacFrstAlwncDaycnt);//연가최초부여
				$("#yrvacMdtnAlwncDaycnt2").val(obj.yrvacMdtnAlwncDaycnt);//연가조정부여
				$("#yrvacCreatResn2").val(obj.yrvacCreatResn);//연가조정사유
				$("#lnglbcVcatnFrstAlwncDaycnt2").val(obj.lnglbcVcatnFrstAlwncDaycnt);//장기근속최초부여
				$("#lnglbcVcatnMdtnAlwncDaycnt2").val(obj.lnglbcVcatnMdtnAlwncDaycnt);//장기근속조정부여
				$("#lnglbcVcatnCreatResn2").val(obj.lnglbcVcatnCreatResn);//연가조정사유
				$("#rmk2").val(obj.rmk);//비고
				$("#vcatnSn").val(obj.vcatnSn);//휴가 기본키
				$("#yrvacRemndrDaycnt2").val(obj.yrvacRemndrDaycnt);//연가잔여일
				$("#lnglbcVcatnRemndrDaycnt2").val(obj.lnglbcVcatnRemndrDaycnt);//장기근속잔여일
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
		$("#lnglbcVcatnFrstAlwncDaycnt2").val("");//장기근속최초부여
		$("#lnglbcVcatnMdtnAlwncDaycnt2").val("");//장기근속조정부여
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
	
	
	//////////////////////////////////
	
	function empGrid() {
		//사원 팝업그리드 초기화
		var grid = $("#etcDiv1")
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
					'#etcDiv1').data("kendoGrid"), dataItem = grid.dataItem(row);

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
		//$("#etc1_5").val(record.emp_seq);
		$("#etc2_1").val(record.emp_seq);
		//$('#keyId').val(record.if_info_system_id);
	}
	
	
	function fn_etc1(){
		var formData = new FormData(document.getElementById("etcFrm1"));
		$.ajax({
			url:"<c:url value='/etc/etc1'/>",
			data: formData,
			type: 'POST',
			dataType: 'json',
			processData: false,
			contentType: false,
			cache: false,
			async: false,
			success:function(data){
				$("#etc1_2").val("");
				$("#etc1_4").val("");
				$("#etc1_5").val("");
				
			}
		});
	}
	
	function fn_etc2(){
		var formData = new FormData(document.getElementById("etcFrm2"));
		$.ajax({
			url:"<c:url value='/etc/etc2'/>",
			data: formData,
			type: 'POST',
			dataType: 'json',
			processData: false,
			contentType: false,
			cache: false,
			async: false,
			success:function(data){
				$("#etc2_1").val("");
				$("#etc2_2").val("");
			}
		});
	}
</script>
