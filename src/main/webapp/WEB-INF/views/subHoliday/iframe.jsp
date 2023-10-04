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
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>

<style type="text/css">
	.btn_lg {
		width: 100px;
		height: 36px !important;
		font-size: 15px;
	}
	.k-header .k-link {
		text-align: center;
	}
	.k-grid-content>table>tbody>tr {
		text-align: center;
	}
	.k-grid th.k-header, .k-grid-header {
		background: #F0F6FD;
	}
	.master-col {
		width: 160px;
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
					pageSize: 100,
					transport: {
						read: {
							url: "http://gw.ltikorea.or.kr/attend/AttendReqManage/SearchAttReqMainMgrList",
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
							return response.resultList;
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
					pageSizes: [10, 50, 100], //true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: "multiple",
				columns: [{
					field: "deptName",
					title: "부서"
				},{
					field: "empName",
					title: "이름"
				},{
					field: "attItemName",
					title: "근태항목"
				},{
					field: "attDivNameKr",
					title: "근태구분"
				},{
					field: "startDt",
					title: "시작일"
				},{
					field: "endDt",
					title: "종료일"
				},{
					field: "reason",
					title: "사유"
				},{
					field: "attReqTitle",
					title: "신청내역"
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
		}
		iframeGrid();
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
		
		<div class="com_ta2 mt5" id="grid"></div><!-- Mapping1 -->

	</div>	
</div>




