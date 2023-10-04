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
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script>
	var langCode = "<%=langCode%>";
</script>
<script type="text/javascript" src="<c:url value='/js/neos/neos/NeosUtil.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src="<c:url value='/js/common_vacation.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/common/outProcessUtil3.js?v=1' /> "></script>

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

/*
.k-grid-header tr th{
	border-color: #dbdbde !important;
	border-style: solid !important;
	border-width: 0 0 1px 1px !important;
	background-color: #f3f3f4 !important;
	
}
.k-grid th.k-header, .k-grid-header{
	background-color: #f3f3f4 !important;
}
*/

.appDocClass{
	text-decoration: revert;
}
/*
	input[type="file"]{
		position:absolute;
		width:1px;
		height:1px;
		padding:0;
		margin:-1px;
		overflow:hidden;
		clip:rect(0,0,0,0);
		border:0;
	}
	#dropZone{
		width: 248px;
		height: 25px;
		border: 1px solid #00000047;
		display: inline-block;
		background: white;
		vertical-align: middle;
	}
	
	.fileLabel{
	    background: #fff;
	    border-radius: 0px;
	    box-shadow: none;
	    padding: 0px 12px;
	    height: 24px !important;
	    line-height: 24px;
	    border: 1px solid #c9cac9;
	    outline: 0;
	    color: #4a4a4a !important;
	}
	*/
</style>
	
	<!-- iframe wrap -->
	<div class="iframe_wrap" style="min-width:1100px">
	
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			
			<div class="title_div">
				<h4>개인휴가현황</h4>
			</div>
		</div>
		
		<div class="sub_contents_wrap">
			<p class="tit_p mt5 mt20">개인휴가현황</p>
			<div class="top_box" style="margin-bottom: 5px;">
				<dl id="individualInfo">
					<dt class="ar" style="width: 65px">적용년도</dt>
					<dd>
						<input type="text" id="dateInput" name="dateInput" value="${year}"
							style="width: 100px"/> 
					</dd>
					<dt class="ar" style="">미등록 증빙파일</dt>
					<dd style='line-height: 24px;'>
						<a href='javascript: fileCountPopUp();' style='color: red;' class='appDocClass' id='fileCount'></a>
					</dd>
					<dt class="ar" style="width: 65px">시작일</dt>
					<dd>
						<input type="text" id="sDt" value="${year}-01-01" style="width: 100px"/> 
					</dd>
					<dt class="ar" style="width: 65px">종료일</dt>
					<dd>
						<input type="text" id="eDt" value="${year}-12-31" style="width: 100px"/>
					</dd>
				</dl>
			</div>
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
	<!-- 파일업로드 -->
	<div class="pop_wrap_dir" id="filePopUp" style="width: 450px; text-align: center;">
		<form id="fileFrm" name="fileFrm">
			<input type="hidden" id="vcatnUseHistSn" name="vcatnUseHistSn" value=""/>
			<div class="pop_head">
				<h1>증빙파일 제출</h1>
			</div>
			<div class="pop_con">
				<div class="top_box">
					<table>
						<tr>
							<th>파일첨부</th>
							<td>
								<div id="dropZone">
								</div>
								<input type="file" id="fileUp" name="files" class="fileInput">
								<label for="fileUp" class="file_btn fl_r fileLabel">파일선택</label>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="pop_foot">
				<div class="btn_cen pt12">
					<input type="button" id="fileUpload" value="등록" />
					<input type="button" class="gray_btn" id="fileCancle" value="닫기" />
				</div>
			</div>
		</form>
	</div>
	<!-- 미제출 증빙파일 리스트 -->
	<div class="pop_wrap_dir" id="fileCountPopUp" style="width: 1000px; text-align: center;">
		<div class="pop_head">
			<h1>미등록 목록</h1>
		</div>
		<div class="pop_con">
			<div class="top_box">
			</div>
			<div class="com_ta mt15" style="">
				<div id="fileGrid"></div>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" id="countCancle" value="닫기" />
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/templates/common/commonForm.jsp" flush="true"></jsp:include>
	
<script type="text/javascript">
	//var empSeq = "<c:out value='${loginVO.uniqId}'/>";
	var empSeq = "<c:out value='${loginVO.empSeq}'/>";
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
		
		
		var fileWindow = $("#filePopUp");
		fileWindow.kendoWindow({
			 width:  "450px",
			 height: "200px",
		     visible:  false,
		     actions: ["Close"]
		}).data("kendoWindow").center();
		//팝업 X 닫기버튼 이벤트
		function onClose() {
			fileWindow.fadeIn();
		}
		//닫기 이벤트
		$("#fileCancle").click(function() {
			fileWindow.data("kendoWindow").close();
		});
		
		$("#fileUpload").on("click", function(){
			if(!$("#fileUp").val()){
				alert("파일이 없습니다.");
				return false;
			}else{
				fn_fileUploadAction();
			}
			
			
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
		selectFileUploadList('N');
		
		
		
		var myfileCount = $("#fileCountPopUp");
		myfileCount.kendoWindow({
			 width:  "1000px",
			 height: "400px",
		     visible:  false,
		     actions: ["Close"]
		}).data("kendoWindow").center();
		//팝업 X 닫기버튼 이벤트
		function onClose() {
			myfileCount.fadeIn();
		}
		//닫기 이벤트
		$("#countCancle").click(function() {
			myfileCount.data("kendoWindow").close();
		});
	});
	
	var check;
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
					data.empSeq = empSeq;
					data.isAdmin = "true";
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
					this.fitColumns();
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
							}
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
							}
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
					data.empSeq = empSeq;
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
					this.fitColumns();
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
							field : "USE_DAY",
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
									str = "<span style='text-decoration: line-through; color: red;'>"+ row.doc_title +"</span>";										
								}
								return str;
							},
						}, {
							field : "",
							title : "비고",
							
						}, {
							field : "",
							title : "결재취소",
							template : function(row){
								var str = "";
								var dikeycode = row.c_dikeycode;
								if(row.USE_YN == "C"){
									if(dikeycode != null && dikeycode != ''){
										str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
									}else{
										str = "";
									}										
								}else if(row.USE_YN == "A"){
									str += "결재 진행중";
								}else{
									str += "<input type='button' onclick=\"formOpen('"+ row.doc_title +"','"+ row.APPRO_KEY +"','"+ row.appDocNo +"');\" value='취소신청'/>";
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
					data.empSeq = empSeq;
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
					data.empSeq = empSeq;
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
						this.fitColumns();
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
											str += "<span style='text-decoration: line-through; color: red;'>" + row.doc_title + "</span>";
										}else{
											str = "";
										}
									}else if(row.state == "A"){
										str += "결재 진행중";
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
								field : "",
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
												str += "<input type='button' onclick=\"fn_fileUpload('"+ row.VCATN_USE_HIST_SN +"')\" value='증빙파일 업로드'>";
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
							}, {
								field : "",
								title : "결재취소",
								template : function(row){
									var str = "";
									var dikeycode = row.c_dikeycode;
									if(row.state == "C"){
										if(dikeycode != null && dikeycode != ''){
											str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ row.doc_title +"</a>";
										}else{
											str = "";
										}										
									}else{
										str += "<input type='button' onclick=\"formOpen('"+ row.doc_title +"','"+ row.APPRO_KEY +"','"+ row.appDocNo +"');\" value='취소신청'/>";
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
				selectFileUploadList('N');
				$("#fileCountPopUp").data("kendoWindow").close();
			}
		});	
		
	}
	
	function subGridReload(){
		$("#grid").data('kendoGrid').dataSource.read();
	}
	var totalTime = 0;
	function fn_useTime(useTime){
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
					data.empSeq = empSeq;
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
	}
	kendo.ui.Grid.fn.expandToFit = function() {
		var $gridHeaderTable = this.thead.closest('table');
		var gridDataWidth = $gridHeaderTable.width();
		var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap')
				.innerWidth();
		if (gridDataWidth >= gridWrapperWidth) {
			return;
		}

		var $headerCols = $gridHeaderTable.find('colgroup > col');
		var $tableCols = this.table.find('colgroup > col');

		var sizeFactor = (gridWrapperWidth / gridDataWidth);
		$headerCols.add($tableCols).not('.k-group-col').each(function() {
			var currentWidth = $(this).width();
			var newWidth = (currentWidth * sizeFactor);
			$(this).css({
				width : newWidth
			});
		});
	}
	var check1;
	function formOpen(title, approKey, docNo, dikeycode, vcatnUseHistSn){
		
		var subData = {};
		subData.dikeycode = dikeycode;
		subData.vcatnUseHistSn = vcatnUseHistSn;
		
		$.ajax({
			url:"<c:url value='/vcatn/vcatnUseHistSnEtc'/>",
			data: subData,
			type: 'POST',
			dataType: 'json',
			async: false,
			success:function(result){
				
				var data = {};
				var docTitle = title;
				data.mod = 'W';
				data.outProcessCode = "VAC02";
				data.contentsStr = makeContentStr(docNo);
				data.compSeq = "${loginVO.compSeq}";
				//data.empSeq = "${loginVO.uniqId}";
				data.empSeq = "${loginVO.empSeq}";
				data.title = docTitle;
				data.approKey = approKey;
				
				
				//window.open("",  "viewer", "width=1000px, height=900px, resizable=no, scrollbars = yes, status=no, top=50, left=50", "newWindow");
				
				
				outProcessLogOn(data);
				window.close();
			}
		});	
		
	}
	
	function makeContentStr(docNo){
		var html = "";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;line-height:160%;'>1. " + docNo + "호와 관련입니다.</SPAN></P>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;line-height:160%;'>2. (변경작성)아래와 같이 취소하고자 합니다.</SPAN></P><br/><br/><br/>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;line-height:160%;'>&nbsp;&nbsp;&nbsp;    가. 건&nbsp;&nbsp;&nbsp;명 :</SPAN></P>";
		html += "	<P CLASS=HStyle0><SPAN STYLE='font-size:12.0pt;line-height:160%;'>&nbsp;&nbsp;&nbsp;    나. 변경사유 :</SPAN></P>";
		return html;
	}
	function selectFileUploadList(useYn){
		var fileDataSource = new kendo.data.DataSource({
			serverPaging : true,
			pageSize : 10,
			transport : {
				read : {
					url : "<c:url value='/vcatn/selectFileUploadList'/>",
					dataType : "json",
					type : 'post'
				},
				parameterMap : function(data, operation) {
					data.empSeq = empSeq;
					data.evidenceFileSn = useYn;
					return data;
				}
			},
			schema : {
				data : function(response) {
					return response.list;
				},
				total : function(response) {
					var str = "[ " + response.list.length + " 건 ]";
					$("#fileCount").text(str);
					return response.list.length;
				}
			}
		});
		var grid = $("#fileGrid").kendoGrid({
			dataSource : fileDataSource,
			height : 253,
			sortable : false,
			pageable : {
				refresh : true,
				pageSizes : true,
				buttonCount : 5
			},
			persistSelection : true,
			columns : [
				{
					field : "VCATN_KND_NAME",
					title : "근태구분"
				}, {
					field : "",
					title : "사용기간",
					columns : [ {
						field : "stDt",
						title : "시작일자",
					},{
						field : "stDtTime",
						title : "시작시간",
					},{
						field : "enDt",
						title : "종료일자",
					},{
						field : "enDtTime",
						title : "종료시간",
					}]
				}, {
					field : "USE_DAY",
					title : "사용일수"
				}, {
					field : "",
					title : "비고",
					template : function(row){
						var str = "";
						var aftfatYn = row.AFTFAT_MNT_YN;
						if(aftfatYn == 'Y'){
							str = "<div class='fileBtnUpload'>";
							str += "<input type='button' onclick=\"fn_fileUpload('"+ row.VCATN_USE_HIST_SN +"')\" value='증빙파일 업로드'>";
							str += "</div>";
						}
						return str;
					}
				}]
		}).data("kendoGrid");
	}	
	
	function fileCountPopUp(){
		$("#fileCountPopUp").data("kendoWindow").open();
	}
	
	
</script>