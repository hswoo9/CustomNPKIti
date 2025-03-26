<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<jsp:useBean id="weekDay" class="java.util.Date" />
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>

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

<style type="text/css">
	.btn_lg {
		width: 100px;
		height: 36px !important;
		font-size: 15px;
	}
	.k-header .k-link {
		text-align: center;
		font-size: 12px;
	}
	.k-grid-content>table>tbody>tr {
		text-align: center;
		font-size: 12px;
	}
	.k-grid th.k-header, .k-grid-header {
		background: #F0F6FD;
		font-size: 12px;
	}
	.master-col {
		width: 160px;
	}
	.iframe_wrap {
		padding: 0px !important;
		font-size: 12px;
	}
	.sub_contents_wrap {
		min-height: 0px !important;
	}
	body {
		overflow-y: hidden; 
		overflow-x: hidden;
	}

</style>

<script type="text/javascript">
	$(function(){
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
		var iframeGrid = function(){
			var grid = $("#grid").kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 50,
					transport: {
						read: {
							url: "https://gw.ltikorea.or.kr/CustomNPKlti/subHoliday/SearchAttReqMainMgrList",
							dataType: 'json',
							contentType: "application/json",
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.startDate = "${nowDateToServer}";
							data.endDate = "${nowDateToServer}";
							//data.eaType = "ea";
							return JSON.stringify(data);
						}
					},
					schema: {
						data: function(response){
							//console.log('resultList', response.resultList);
							return response.list.filter(function(list){
								return list.approveName == '결재종결' && list.empSeq != '200905';
								//20200306 이정근 팀장님 안보이도록 수정, 3월 지나면 위 라인으로 써주세요
								//return list.approveName === '결재종결' && list.empName !== '이정근';
							});
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 350,//460,
				dataBound: gridDataBound,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: [50, 100], //true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: "multiple",
				columns: [{
					field: "deptName",
					title: "부서",
					width: 250
				},{
					field: "empName",
					title: "이름",
					width: 100
				},/* {
					field: "attItemName",
					title: "근태항목",
					width: 120
				}, */{
					field: "attDivNameKr",
					title: "근태구분",
					width: 120
				},{
					field: "startDt",
					title: "시작일",
					width: 100
				},{
					field: "endDt",
					title: "종료일",
					width: 100
				},{
					field: "attReqTitle", //"reason",
					title: "신청내역"
				}/*,{
					field: "remark", //"reason",
					title: "사유"
				}*/
				],
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
		}
		iframeGrid();
		
		
		
		
		
		
		function gridDataBound2(e){
			var grid2 = e.sender;
			if(grid2.dataSource.total()==0){
				var colCount = grid2.columns.length;
				$(e.sender.wrapper)
					.find('tbody')
					.append('<tr class="kendo-data-row">' + 
							'<td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
			}
		}
		var iframeGrid2 = function(){
			var grid2 = $("#grid2").kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 50,
					transport: {
						read: {
							url: 'https://gw.ltikorea.or.kr/CustomNPKlti/subHoliday/gridSubHolidayReqListToday',
							dataType: 'json',
							contentType: "application/json",
							type: 'post'
						},
						parameterMap: function(data, operation){
							data.startDate = "${nowDateToServer}";
							data.endDate = "${nowDateToServer}";
							data.eaType = "ea";
							return JSON.stringify(data);
						}
					},
					schema: {
						data: function(response){
							console.log('resultList', response);
							return response.list;
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 230,//460,
				dataBound: gridDataBound2,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: [50, 100], //true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: "multiple",
				columns: [{
					field: "use_dept_name",
					title: "부서",
					width: 250
				},{
					field: "emp_name",
					title: "이름",
					width: 100
				},/* {
					field: "attItemName",
					title: "근태항목",
					width: 120
				}, */{
					field: "reward_type",
					title: "근태구분",
					width: 120
				},{
					field: "apply_start_date",
					title: "시작일",
					width: 100
				},{
					field: "apply_end_date",
					title: "종료일",
					width: 100
				},{
					field: "use_min",
					title: "신청시간",
					template: function(row){
						return row.use_min/60 + '시간';
					},
					width: 100
				},{
					field: "use_min",
					title: "신청시간",
					template: function(row){
						if(row.apply_start_time != null && row.apply_end_time != ''){
							return row.apply_start_time + '~' + row.apply_end_time;
						}else{
							return '';
						}
					},
					width: 150
				},{
					field: "attReqTitle", //"reason",
					title: "신청내역",
					template: "보상휴가신청"
				}
				],
				change: function(e){
					//codeGridClick(e);
				}
			}).data("kendoGrid");
			
			function codeGridClick2(){
				var rows2 = grid2.select();
				var record2;
				rows2.each(function(){
					record2 = grid2.dataItem($(this));
					console.log(record2);
				}); 
			}
		}
		iframeGrid2();
	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>일일근태현황</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap">	
		
		<div class="com_ta2" id="grid"></div><!-- Mapping1 -->
		<div class="com_ta2" id="grid2"></div><!-- Mapping1 -->

	</div>	
</div>




