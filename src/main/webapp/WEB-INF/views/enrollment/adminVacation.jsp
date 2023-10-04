<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="main.web.BizboxAMessage" %>
<%
	String langCode = (String) session.getAttribute("langCode");
	langCode = langCode == null ? "kr" : langCode.toLowerCase();
	
	String culture = "ko-KR";
	
	if (langCode.equals("en")) {
		culture = "en-US";
	} else if (langCode.equals("jp")) {
		culture = "ja-JP";
	} else if (langCode.equals("cn")) {
		culture = "zh-CN";
	}
%>
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<jsp:useBean id="weekDay" class="java.util.Date" />
<jsp:useBean id="nowDate" class="java.util.Date" />
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script>
	var langCode = "<%=langCode%>";
</script>
<script type="text/javascript" src="<c:url value='/js/neos/neos/NeosUtil.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jszip2.min.js"></c:url>'></script>
<script type="text/javascript" src="<c:url value='/js/common_vacation.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common/outProcessUtil3.js?v=1' /> "></script>
<script type="text/javascript" src="<c:url value='/js/adminVacation.js?v=${today}' /> "></script>

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

.appDocClass{
	text-decoration: revert;
}

.vacationType{
	height: 100%;
	width: 100px;
	background: #fff;
    border-radius: 0px;
    box-shadow: none;
    padding: 0px 12px;
    height: 24px;
    line-height: 24px;
    border: 1px solid #c9cac9;
    outline: 0;
    color: #4a4a4a !important;
}

.vacationKnds{
	height: 100%;
	width: 100px;
	background: #fff;
    border-radius: 0px;
    box-shadow: none;
    padding: 0px 12px;
    height: 24px;
    line-height: 24px;
    border: 1px solid #c9cac9;
    outline: 0;
    color: #4a4a4a !important;
}

.vacationChild{
	height: 100%;
	width: 130px;
	background: #fff;
    border-radius: 0px;
    box-shadow: none;
    padding: 0px 12px;
    height: 24px;
    line-height: 24px;
    border: 1px solid #c9cac9;
    outline: 0;
    color: #4a4a4a !important;
}

.active{
	background: #1385db;
	color: white !important;
	cursor: auto;
}
</style>
	
	<!-- iframe wrap -->
	<div class="iframe_wrap" style="min-width:1100px">
	
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			
			<div class="title_div">
				<h4>개인휴가현황(관리자)</h4>
			</div>
		</div>
		<input type="hidden" id="empSeq" value="${loginVO.empSeq}"/>		
		<div class="sub_contents_wrap">
			<p class="tit_p mt5 mt20">개인휴가현황</p>
			<div class="top_box" style="margin-bottom: 5px;">
				<dl>
					<dt class="ar" style="width: 65px">적용년도</dt>
					<dd>
						<input type="text" id="dateInput" name="dateInput" value="${year}"
							style="width: 100px"/> 
					</dd>
					<dt class="ar" style="width: 65px">시작일</dt>
					<dd>
						<input type="text" id="sDt" value="${year}-01-01" style="width: 100px"/> 
					</dd>
					<dt class="ar" style="width: 65px">종료일</dt>
					<dd>
						<input type="text" id="eDt" value="${year}-12-31" style="width: 100px"/>
					</dd>
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
					<dd>
						<input type="button" id="empSearch" value="검색" />
					</dd>
				</dl>
				<dl id="vacationDl">
					<dt>타입</dt>
					<dd>
						<button type="button" class="vacationType active" key="1">개인별</button>						
					</dd>
					<dd>
						<button type="button" class="vacationType" key="2">휴가별</button>						
					</dd>
				</dl>
				<dl id="vacationKnds" style="display: none;">
					<dt>종류</dt>
					<dd>
						<button type="button" class="vacationKnds" key="1">연가</button>						
					</dd>
					<!-- <dd>
						<button type="button" class="vacationKnds" key="2">장기근속</button>						
					</dd> -->
					<dd>
						<button type="button" class="vacationKnds" key="3">특별휴가</button>						
					</dd>
					<dd>
						<button type="button" class="vacationKnds" key="4">기타</button>						
					</dd>
				</dl>
				<dl id="vacationKndsSub" style="display: none;">
					<dt id="vacationKndsSubDt"></dt>
				</dl>
			</div>
			<div id="vacationType1">
				<div class="top_box">
					<div id="topGrid"></div>
				</div>
				<div class="com_ta2 mt15">
					<p class="tit_p mt5 mt20"><span style="color: #058df5;" id="searchYear"></span>년도 상세 사용일수 내역 (전체건수 <span style="color: #058df5;" id="searchTotal"></span>건 / 사용일수 <span style="color: #058df5;" id="totalTime"></span>일)</p>
					<div class="top_box">
				    	<div id="grid"></div>
				    </div>
				</div>	
			</div>	
			<div id="vacationType2" style="display: none;">
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="" onclick="excelDown();">엑셀</button>
					</div>
				</div>
				<div id="subMainGrid"></div>
			</div>				
		</div>
	</div>
	<div class="pop_wrap_dir" id="vacationPopUp" style="width: 800px; text-align: center;">
		<div class="pop_head">
			<h1>변경이력</h1>
		</div>
		<div class="pop_con">
			<div class="top_box">
			</div>
			<div class="com_ta mt15" style="">
				<div id="empGrid"></div>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" id="cancle" value="닫기" />
			</div>
		</div>
	</div>
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
				<div id="empAllList"></div>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" id="empCancle" value="닫기" />
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/templates/common/commonForm.jsp" flush="true"></jsp:include>
	
<script type="text/javascript">
	//var empSeq = "<c:out value='${loginVO.uniqId}'/>";
	var year = '${year}';
	//var eaType = '${eaType}';
	var eaType = 'ea';
	$(function(){
		mainGrid();
		
		subGrid();
		
		
		var myWindow = $("#vacationPopUp");
		myWindow.kendoWindow({
			 width:  "800px",
			 height: "400px",
		     visible:  false,
		     actions: ["Close"]
		}).data("kendoWindow").center();
		//팝업 X 닫기버튼 이벤트
		function onClose() {
			myWindow.fadeIn();
		}
		//닫기 이벤트
		$("#cancle").click(function() {
			myWindow.data("kendoWindow").close();
		});
		
		
		
		//년월 달력 초기화
		$("#dateInput").kendoDatePicker({
			// defines the start view
			start : "decade",

			// defines when the calendar should return date
			depth : "decade",

			// display month and year in the input
			format : "yyyy",
			parseFormats : [ "yyyy" ],

			// specifies that DateInput is used for masking the input element
			culture : "ko-KR",
			dateInput : true,
			change : function(e){
				mainGrid();
				subSpGrid('all');
			}
		});
	    $("#sDt").kendoDatePicker({
	        // defines the start view
	        start : "month",

	        // defines when the calendar should return date
	        depth : "month",

	        // display month and year in the input
	        format : "yyyy-MM-dd",
	        parseFormats : [ "yyyy-MM-dd" ],

	        // specifies that DateInput is used for masking the input element
	        culture : "ko-KR",
	        dateInput : true,
	        change : function(e){
	        	subGridReload();
			}
	    });
	  	var check;
	    $("#eDt").kendoDatePicker({
	        // defines the start view
	        start : "month",

	        // defines when the calendar should return date
	        depth : "month",

	        // display month and year in the input
	        format : "yyyy-MM-dd",
	        parseFormats : [ "yyyy-MM-dd" ],

	        // specifies that DateInput is used for masking the input element
	        culture : "ko-KR",
	        dateInput : true,
	        change : function(e){
	        	subGridReload();
			}
	    });
		
		
		$(".k-input").attr("readonly", "readonly");
		
		
		callFnTpfDeptComboBoxInit('requestDeptSeq');
		var empWindow = $("#empPopUp");
		
		empWindow.kendoWindow({
			width : "600px",
			height : "702px",
			visible : false,
			actions : [ "Close" ],
			close : onClose
		}).data("kendoWindow").center();
		
		$("#empCancle").click(function() {
			empWindow.data("kendoWindow").close();
		});
		
		empSearch = $("#empSearch");
		empSearch.click(function() {
			empWindow.data("kendoWindow").open();
			$("#emp_name").val($("#empNameSearch").val());
			$("#empSeq").val("");
			callEmpAllList('empAllList');
			empSearch.fadeOut();
		});
		callEmpAllList('empAllList');
		function onClose() {
			empSearch.fadeIn();
		}
		
		$("#empNameSearch").keydown(function(keyNum) {
			if (keyNum.keyCode == 13) {
				$("#empSearch").click();
			}
		});
		
		$("#emp_name").keydown(function(keyNum) {
			if (keyNum.keyCode == 13) {
				$("#searchButton").click();
			}
		});
		
		
		
		$(".vacationType").on("click", function(){
			$(".vacationType").removeClass("active");
			$(this).addClass("active");
			var key = $(this).attr("key");
			if(Number(key) == 1){
				$("#vacationKndsSubDt").empty();
				$("#vacationType2").hide();
				$("#vacationKnds").hide();
				$("#vacationType1").show();
			}
			if(Number(key) == 2){
				$("#vacationType1").hide();
				$("#vacationKnds").show();
				$("#vacationType2").show();
			}
		});
		
		$(".vacationKnds").on("click", function(){
			$(".vacationKnds").removeClass("active");
			$(this).addClass("active");
			var key = $(this).attr("key");
			$("#vacationKndsSubDt").empty();
			if(Number(key) == 1){
				callSelectVacationList("subMainGrid", $("#dateInput").val(), $("#sDt").val(), $("#eDt").val(), key);
				$("#vacationKndsSub").hide();
			}
			if(Number(key) == 2){
				callSelectVacationList("subMainGrid", $("#dateInput").val(), $("#sDt").val(), $("#eDt").val(), key);
				$("#vacationKndsSub").hide();
			}
			if(Number(key) == 3){
				$("#subMainGrid").empty();
				callVacationKnds("vacationKndsSubDt", key);
				$("#vacationKndsSub").show();
			}
			if(Number(key) == 4){
				$("#subMainGrid").empty();
				callVacationKnds("vacationKndsSubDt", key);
				$("#vacationKndsSub").show();
			}
		});
		
		$(document).on("click", ".vacationChild", function(){
			$(".vacationChild").removeClass("active");
			$(this).addClass("active");
			var vcatnKndSn = $(this).attr("key");
			var btntype = $(this).attr("btntype");
			callSelectSpVacationList("subMainGrid", $("#dateInput").val(), $("#sDt").val(), $("#eDt").val(), vcatnKndSn);
		});
		
	});
	
	var check;
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
	function mainGrid() {
		var dataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : "<c:url value='/vacation/getList'/>",
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = $("#empSeq").val();
					data.year = $("#dateInput").val() == null ? ${year} : $("#dateInput").val();
					data.type = '1';
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
		$("#topGrid").empty();
		//캔도 그리드 기본
		var grid = $("#topGrid").kendoGrid(
			{
				dataSource : dataSource,
				height : 250,
				dataBound : function(e) {
					gridDataBound(e);
				},
				sortable : false,
				pageable : {
					refresh : false,
					pageSizes : [ 10, 20, 30, 50, 100 ],
					buttonCount : 5,
					messages: {
						itemsPerPage : "",
						display: "total : {2}"
					}
				},
				persistSelection : true,
				selectable : "multiple",
				columns : [
						{
							field : "",
							title : "구분",
							template : function(row){
								var str = "";
								var vcatnType = row.SPECL_SN;
								if(vcatnType != null){
									str = "[특별휴가] "+ row.VCATN_KND_NAME;
								}else if(row.TYPE != null){
									str = "장기근속휴가";
								}else{
									str = "연가";
								}
								return str;
							},
							//width : 200
						},
						{
							field : "APPLY_YR",
							title : "귀속년도",
							template : function(row){
								var str = "";
								var applyYr = row.APPLY_YR;
								var vcatnType = row.SPECL_SN;
								if(vcatnType != null){
									str = String(row.APPLY_YR);
									str = str.substr(0,4);
								}else{
									str = applyYr;
								}
								return str;
							},
							//width : 100
						}, {
							field : "",
							title : "휴가적용기간",
							columns : [ {
								field : "",
								title : "시작일자",
								template : function(row){
									var year = row.APPLY_YR;
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return year;
									}else{
										return year + "0101";
									}
								},
							},{
								field : "",
								title : "종료일자",
								template : function(row){
									var year = row.APPLY_YR;
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										var str = String(row.maxDay);
										if(str != '-'){
											str = str.substr(0,10);
											str = str.split("-")[0] + str.split("-")[1] + str.split("-")[2];
										}else{
											str = year.substr(0,4) + "1231";	
										}
										return str;
									}else if(row.TYPE != null){
										if(row.lnglbcLastDt != null){
											str = String(row.lnglbcLastDt);
											str = str.substr(0,10);
											str = str.split("-")[0] + str.split("-")[1] + str.split("-")[2];
											return str;
										}else{
											return year + "1231";
										}
									}else{
										return year + "1231";
									}
								},
							}]
						}, {	//ALWNC_DAYCNT
							field : "",
							title : "부여<span style='color: #058df5;'>(A)</span>",
							columns : [ {
								field : "YRVAC_FRST_ALWNC_DAYCNT",
								title : "기본",
								template : function(row){
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return row.ALWNC_DAYCNT;
									}else if(row.TYPE != null){
										return row.LNGLBC_VCATN_FRST_ALWNC_DAYCNT;
									}else{
										return row.YRVAC_FRST_ALWNC_DAYCNT;
									}
								}
							}, {
								field : "YRVAC_MDTN_ALWNC_DAYCNT",
								title : "기본조정",
								template : function(row){
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return "0";
									}else if(row.TYPE != null){
										return row.LNGLBC_VCATN_MDTN_ALWNC_DAYCNT;
									}else{
										return row.YRVAC_MDTN_ALWNC_DAYCNT;
									}
								}
							}, {
								field : "YRVAC_REMNDR_DAYCNT",
								title : "소계",
								template : function(row){
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return row.ALWNC_DAYCNT;
									}else if(row.TYPE != null){
										return row.LNGLBC_VCATN_REMNDR_DAYCNT;
									}else{
										return row.YRVAC_REMNDR_DAYCNT;
									}
								}
							}]
						}, {
							field : "",
							title : "소진<span style='color: #058df5;'>(B)</span>",
							columns : [ {
								field : "YRVAC_USE_DAYCNT",
								title : "사용",
								template : function(row){
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return row.useDate;
									}else{
										if(row.useDay != null){
											return row.useDay;	
										}else{
											return "0";
										}
										
									}
								}
							}, {
								field : "YRVAC_USE_DAYCNT",
								title : "소계",
								template : function(row){
									var vcatnType = row.SPECL_SN;
									if(vcatnType != null){
										return row.useDate;
									}else{
										if(row.useDay != null){
											return row.useDay;	
										}else{
											return "0";
										}
									}
								}
							}]
						}, {
							field : "YRVAC_REMNDR_DAYCNT",
							title : "잔여휴가<br/><span style='color: #058df5;'>(A-B)</span>",
							template : function(row){
								var vcatnType = row.SPECL_SN;
								if(vcatnType != null){
									var countDay = 0;
									if(row.useDate != null){
										countDay = Number(row.ALWNC_DAYCNT) - Number(row.useDate);
									}else{
										countDay = Number(row.ALWNC_DAYCNT);
									}
									return countDay;
								}else if(row.TYPE != null){
									var countDay = 0;
									if(row.useDay != null){
										countDay = Number(row.LNGLBC_VCATN_REMNDR_DAYCNT) - Number(row.useDay);
									}else{
										countDay = Number(row.LNGLBC_VCATN_REMNDR_DAYCNT);
									}
									return countDay;
								}else{
									var countDay = 0;
									if(row.useDay != null){
										countDay = Number(row.YRVAC_REMNDR_DAYCNT) - Number(row.useDay);
									}else{
										countDay = Number(row.YRVAC_REMNDR_DAYCNT);
									}
									return countDay;
								}
							}
						}, {
							field : "",
							title : "변경이력",
							template : function(row){
								var vcatnType = row.SPECL_SN;
								if(vcatnType != null){
									return "<a href=\"javascript: fn_creatHist('"+ row.SPECL_SN +"','V004');\" class='appDocClass'>[ 보기 ]</a>"; 
								}else{
									return "<a href=\"javascript: fn_creatHist('"+ row.VCATN_SN +"','V001');\" class='appDocClass'>[ 보기 ]</a>"; 
								}
							}
						}],
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
			totalDay = 0;
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
				var speclSn = record.SPECL_SN;
				if(speclSn != null){
					subSpGrid(speclSn);
				}else if(record.TYPE != null){
					year = record.APPLY_YR;
					subGrid("V006");
				}else{
					year = record.APPLY_YR;
					subGrid();
				}
			});
			
		}
	}
	
	
	
	
	
	function subGrid(type) {
		var subDataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : "<c:url value='/vacation/getUseList'/>",
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = $("#empSeq").val();
					data.year = year;
					data.type = type;
					
					data.startDate = $("#sDt").val();
					data.endDate = $("#eDt").val();
					
					$("#searchYear").text(year);
					$("#totalTime").text("");
					totalTime = 0;
					return data;
				}
			},
			schema : {
				data : function(response) {
					
					return response.list;
				},
				total : function(response) {
					$("#searchTotal").text(response.list.length);
					return response.list.length;
				}
			}
		});
		$("#grid").empty();
		var grid = $("#grid").kendoGrid(
			{
				dataSource : subDataSource,
				height : 350,
				dataBound : function(e) {
					gridDataBound(e);
				},
				sortable : false,
				pageable : {
					refresh : false,
					pageSizes : [ 10, 20, 30, 50, 100 ],
					buttonCount : 5,
					position : "top",
					messages: {
						itemsPerPage : "",
						display: "total : {2}"
					}
				},
				persistSelection : true,
				selectable : "multiple",
				columns : [

					{
						field : "VCATN_GBN_NAME",
						title : "근태항목",
						template : function(row){
							var str = "";
							var vcatnGbnName = row.VCATN_GBN_NAME;
							if(vcatnGbnName != null){
								str += "휴가";
							}else{
								str = "휴가";
							}
							
							return str;
						}
					}, {
						field : "VCATN_KND_NAME",
						title : "근태구분",
						template : function(row){
							var useTime = row.USE_DAY;
							return fn_vcatnKnd(useTime);
						},
					}, {
						field : "",
						title : "사용기간",
						columns : [ {
							field : "stDt",
							title : "시작일자",
							template : function(row){
								var str = row.stDt;
								if(row.USE_YN == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDt +"</span>";										
								}
								return str;
							}
						},{
							field : "stDtTime",
							title : "시작시간",
							template : function(row){
								var str = row.stDtTime;
								if(row.USE_YN == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDtTime +"</span>";										
								}
								return str;
							}
						},{
							field : "enDt",
							title : "종료일자",
							template : function(row){
								var str = row.enDt;
								if(row.USE_YN == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDt +"</span>";										
								}
								return str;
							}
						},{
							field : "enDtTime",
							title : "종료시간",
							template : function(row){
								var str = row.enDtTime;
								if(row.USE_YN == "C"){
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDtTime +"</span>";										
								}
								return str;
							}
						}]
					}, {
						field : "",
						title : "사용일수",
						template : function(row){
							var useTime = row.USE_DAY;
							useTime = fn_useTime(useTime);
							if(row.USE_YN == "C"){
								useTime = "<span style='text-decoration: line-through; color: red;'>"+ useTime +"</span>";										
							}
							return useTime;
						},
						
					}, {
						field : "",
						title : "문서번호",
						template : function(row){
							var dikeycode = row.c_dikeycode;
							var str = "";
							if(dikeycode != null && dikeycode != ''){
								str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>" + row.appDocNo + "</a>";
							}else{
								str = "";
							}
							if(row.USE_YN == "C"){
								str = "<span style='text-decoration: line-through; color: red;'>"+ row.appDocNo +"</span>";										
							}
							return str;
						},
					}, {
						field : "",
						title : "신청내역",
						template : function(row){
							var dikeycode = row.c_dikeycode;
							var str = "";
							if(dikeycode != null && dikeycode != ''){
								str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
							}else{
								str = "";
							}
							if(row.USE_YN == "C"){
								str = "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";										
							}
							return str;
						},
					}, {
						field : "",
						title : "비고",
						
					}],
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
				row.addClass("k-state-selected");
			} else {
				row.removeClass("k-state-selected");
			}

		}
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
			});
			
		}
	}
	
	
	function subMainGrid() {
		subDataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : "<c:url value='/vacation/getUseList'/>",
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = $("#empSeq").val();
					data.year = $("#dateInput").val();
					$("#searchYear").text($("#dateInput").val());
					$("#totalTime").text("");
					totalTime = 0;
					return data;
				}
			},
			schema : {
				data : function(response) {
					
					return response.list;
				},
				total : function(response) {
					$("#searchTotal").text(response.list.length);
					return response.list.length;
				}
			}
		});
		subGridReload();
	}
	
	function subSpGrid(key) {
		var subSpDataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : "<c:url value='/vcatn/getSpecialUseHist'/>",
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = $("#empSeq").val();
					data.year = $("#dateInput").val();
					data.speclSn = key;
					
					data.startDate = $("#sDt").val();
					data.endDate = $("#eDt").val();
					$("#searchYear").text($("#dateInput").val());
					$("#totalTime").text("");
					totalTime = 0;
					return data;
				}
			},
			schema : {
				data : function(response) {
					
					return response.list;
				},
				total : function(response) {
					$("#searchTotal").text(response.list.length);
					return response.list.length;
				}
			}
		});
		$("#grid").empty();
		var grid = $("#grid").kendoGrid(
				{
					dataSource : subSpDataSource,
					height : 350,
					dataBound : function(e) {
						gridDataBound(e);
					},
					sortable : false,
					pageable : {
						refresh : false,
						pageSizes : [ 10, 20, 30, 50, 100 ],
						buttonCount : 5,
						position : "top",
						messages: {
							itemsPerPage : "",
							display: "total : {2}"
						}
					},
					persistSelection : true,
					selectable : "multiple",
					columns : [

							{
								field : "VCATN_GBN_NAME",
								title : "근태항목",
								template : function(row){
									var str = "특별휴가";
									if(row.state == "C"){
										str = "<span style='text-decoration: line-through; color: red;'>특별휴가</span>";										
									}
									return str;
								}
							}, {
								field : "VCATN_KND_NAME",
								title : "근태구분",
								template : function(row){
									var str = row.VCATN_KND_NAME;
									if(row.state == "C"){
										str = "<span style='text-decoration: line-through; color: red;'>"+ row.VCATN_KND_NAME +"</span>";										
									}
									return str;
								}
							}, {
								field : "",
								title : "사용기간",
								columns : [ {
									field : "stDt",
									title : "시작일자",
									template : function(row){
										var str = row.stDt;
										if(row.state == "C"){
											str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDt +"</span>";										
										}
										return str;
									}
								},{
									field : "stDtTime",
									title : "시작시간",
									template : function(row){
										var str = row.stDtTime;
										if(row.state == "C"){
											str = "<span style='text-decoration: line-through; color: red;'>"+ row.stDtTime +"</span>";										
										}
										return str;
									}
								},{
									field : "enDt",
									title : "종료일자",
									template : function(row){
										var str = row.enDt;
										if(row.state == "C"){
											str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDt +"</span>";										
										}
										return str;
									}
								},{
									field : "enDtTime",
									title : "종료시간",
									template : function(row){
										var str = row.enDtTime;
										if(row.state == "C"){
											str = "<span style='text-decoration: line-through; color: red;'>"+ row.enDtTime +"</span>";										
										}
										return str;
									}
								}]
							}, {
								field : "",
								title : "사용일수",
								template : function(row){
									return fn_useDay(row);
								},
								
							}, {
								field : "",
								title : "문서번호",
								template : function(row){
									var dikeycode = row.c_dikeycode;
									var str = "";
									if(row.state == "C"){
										if(dikeycode != null && dikeycode != ''){
											str += "<span style='text-decoration: line-through; color: red;'>" + row.appDocNo + "</span>";
										}else{
											str = "";
										}
									}else{
										if(dikeycode != null && dikeycode != ''){
											str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>" + row.appDocNo + "</a>";
										}else{
											str = "";
										}
									}
									return str;
								},
							}, {
								field : "",
								title : "신청내역",
								template : function(row){
									var dikeycode = row.c_dikeycode;
									var str = "";
									if(row.state == "C"){
										if(dikeycode != null && dikeycode != ''){
											str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
										}else{
											str = "";
										}
									}else{
										if(dikeycode != null && dikeycode != ''){
											str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
										}else{
											str = "";
										}
									}
									return str;
								},
							}, {
								field : "EVIDENCE_FILE_SN",
								title : "비고",
								template : function(row){
									var str = "";
									var aftfatYn = row.AFTFAT_MNT_YN;
									if(row.state == "C"){
										str = "";
									}else{
										if(aftfatYn == 'Y'){
											str += "<div>";
											if(Number(row.AFTFAT_MNT_MTH) == 1 && row.EVIDENCE_FILE_SN == null){
												str = "<div class='fileBtnUpload'>";
												str += "<span style='color: red;'>증빙파일 미등록</span>";
											}else if(row.EVIDENCE_FILE_SN != null){
												str = "<div class='fileBtnDown'>";
												str += "<input type='button' onclick=\"fn_fileDownload('"+ row.FILE_MASK +"','"+ row.FILE_NAME +"')\" value='다운로드'>";
											}else{
												str += "전자결재";
											}
											str += "</div>";
										}
									}
									return str;
								}
							}],
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
					row.addClass("k-state-selected");
				} else {
					row.removeClass("k-state-selected");
				}

			}
			function codeGridClick() {
				var rows = grid.select();
				var record;
				rows.each(function() {
					record = grid.dataItem($(this));
				});
			}
			
	}
	
	
	function fn_fileUpload(key){
		$("#vcatnUseHistSn").val(key);
		$("#filePopUp").data("kendoWindow").open();
	}
	
	function fn_fileDownload(mask, name){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/vacationDownloadFile.do'/>");
		comSubmit.addParam("fileName", name);
		comSubmit.addParam("fileMask", mask);
		comSubmit.addParam("pathNum", "8");
		comSubmit.submit();
	}
	
	function fn_fileUploadAction(){
		var formData = new FormData(document.getElementById("fileFrm"));
		$.ajax({
			url:"<c:url value='/vcatn/fileUpload'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				alert(result.obj.message);
				$("#fileUp").val("");
				$("#vcatnUseHistSn").val("");
				$('#grid').data('kendoGrid').dataSource.read();
				$("#filePopUp").data("kendoWindow").close();
			}
		});	
		
	}
	
	function subGridReload(){
		$("#grid").data('kendoGrid').dataSource.read();
	}
	var totalTime = 0;
	function fn_useTime(useTime){
		var oneTime = 0.125;
		/*
		var oneTime = 0.125;
		//점심시간 1시간 제외
		var usTm = (Number(useTime)/60) -1;
		usTm = usTm * oneTime;
		*/
		totalTime += Number(useTime);
		$("#totalTime").text(totalTime);
		return useTime;
	}
	var totalDay = 0;
	function fn_useDay(row){
		var useDay = row.USE_DAY;
		var str = useDay;
		
		if(row.state == "C"){
			str = "<span style='text-decoration: line-through; color: red;'>"+ useDay +"</span>";										
		}else{
			totalDay += Number(useDay);
		}
		
		$("#totalTime").text(totalDay);
		return str;
	}
	
	function fn_vcatnKnd(useTime){
		var oneTime = 0.125;
		//점심시간 1시간 제외
		//var usTm = (Number(useTime)/60)-1;
		var str = "연차";
		//usTm = usTm * oneTime;
		
		var usTm = Number(useTime);
		if(usTm == 1){
			str = "연차";
		}
		if(usTm == 0.5){
			str = "반차";
		}
		if(usTm == 0.125){
			str = "외출(1시간)";
		}
		if(usTm == 0.25){
			str = "외출(2시간)";
		}
		if(usTm == 0.375){
			str = "외출(3시간)";
		}
		return str;
	}
	//생성이력보기
	function fn_creatHist(key, type){
		var url = "";
		if(type == "V001"){
			console.log("V001");
			url = "<c:url value='/vcatn/getVcatnCreatHistList'/>";
		}
		if(type == "V002"){
			console.log("V002");
			url = "";
		}
		if(type == "V003"){
			console.log("V00#");
			url = "";
		}
		if(type == "V004"){
			console.log("V004");
			url = "<c:url value='/vcatn/getMyHistList'/>";
		}
		if(type == "V005"){
			console.log("V005");
			url = "";
		}
		var empDataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : url,
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = $("#empSeq").val();
					if(type == "V001"){
						data.vcatnSn = key;
					}
					if(type == "V002"){
					}
					if(type == "V003"){
					}
					if(type == "V004"){
						data.speclSn = key;
					}
					if(type == "V005"){
					}				
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
		var grid = $("#empGrid").kendoGrid({
			dataSource : empDataSource,
			height : 200,
			sortable : false,
			pageable : {
				refresh : true,
				pageSizes : true,
				buttonCount : 5
			},
			persistSelection : true,
			selectable : "multiple",
			columns : [
					{
						field : "",
						title : "No",
						template : function(row){
							return Number(row.sortSn) + 1;
						}
					},
					{
						field : "",
						title : "변경일자",
						template : function(row){
							var creatDt = String(row.creatDt);
							if(creatDt != null){
								creatDt = creatDt.substr(0,10);
							}
							return creatDt;
						},
					},
					{
						field : "",
						title : "변경자",
						template : function(row){
							return "관리자";
						}
					},
					{
						field : "alwncDaycnt",
						title : "기본일수",
					},
					{
						field : "rmk",
						title : "사유",
					}]
		}).data("kendoGrid");
		
		$("#vacationPopUp").data("kendoWindow").open();
	}
	
	
	/* 문서 키코드 기반 전자결재 문서 띄우기 */
	function fnViewAppDoc(c_dikeycode, formId) {
		if (!window.location.origin) {
			window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
		}
		
		var origin = document.location.origin;
		
		var thisX = parseInt(document.body.scrollWidth);
		var thisY = parseInt(document.body.scrollHeight);
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;
		
		if (maxThisX > 1000) {
			maxThisX = 1000;
		}
		
		var marginY = 0;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45; // IE 6.x
		else if (navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75; // IE 7.x
		
		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}
		
		// 센터 정렬
		var windowX = (screen.width - maxThisX + 10) / 2;
		var windowY = (screen.height - maxThisY) / 2 - 20;
		var strScroll = 0;
		var strResize = 0;
		var location = 0;
		
		//test
		origin = "http://gw.jif.re.kr/";
		
		if (eaType == "ea") {
			var url = origin + "/ea/edoc/eapproval/docCommonDraftView.do?diKeyCode=" + c_dikeycode;
		} else if (formId || formId === 0) {
			var url = origin + "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + c_dikeycode + "&form_id=" + formId;
		} else {
			return;
		}
		
		pop = window.open(
			url, "EaViewPop",
			"width=" + maxThisX + ", height=" + maxThisY + ", top=" + windowY + ", left=" + windowX + ", scrollbars=yes, resizable=" + strResize + ", location=" + location
		);
		
		try {
			pop.focus();
		} catch(e) {}
	}
	
	function formOpen(title, approKey, docNo){
		
		
		var data = {};
		data.mod = 'W';
		data.outProcessCode = "VAC02";
		data.contentsStr = makeContentStr(docNo);
		data.compSeq = "${loginVO.compSeq}";
		data.empSeq = $("#empSeq").val();
		data.title = title + " 취소";
		data.approKey = approKey;
		
		
		window.open("",  "viewer", "width=1000px, height=900px, resizable=no, scrollbars = yes, status=no, top=50, left=50", "newWindow");
		
		
		outProcessLogOn(data);
		window.close();
	}
	
	function makeContentStr(docNo){
		var html = "<br/><br/><br/><br/>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;line-height:160%;'>1. " + docNo + "호와 관련입니다.</SPAN></P><br/><br/>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;line-height:160%;'>2. 아래와 같이 취소하고자 합니다.</SPAN></P><br/><br/><br/><br/>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;line-height:160%;'>가. 건&nbsp;&nbsp;&nbsp;명 :</SPAN></P><br/><br/>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:14.0pt;line-height:160%;'>나. 변경사유 :</SPAN></P><br/><br/>";
		return html;
	}
	
	function excelDown(){
		$("#subMainGrid").getKendoGrid().saveAsExcel();
	}
</script>