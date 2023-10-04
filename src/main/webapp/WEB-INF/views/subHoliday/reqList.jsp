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
<jsp:useBean id="nowTime" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
<fmt:formatDate value="${nowTime}" var="nowTime" pattern="HHmm" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>

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
	.a_btn {
		padding: 0 12px;
	    background: #1088e3;
	    height: 24px;
	    color: #fff;
	    border: 0px !important;
	    font-weight: bold;
	    vertical-align: middle;
	    font: 400 13.3333px Arial;
	    display: inline-block;
	    line-height: 1.8;
	}

</style>

<script type="text/javascript">
$(function(){
	function gridDataBound(e){
		/* var grid = e.sender;
		if(grid.dataSource.total()==0){
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
				.find('tbody')
				.append('<tr class="kendo-data-row">' + 
						'<td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		} */
	}
	var iframeGrid = function(){
		var grid = $("#grid").kendoGrid({
			dataSource: new kendo.data.DataSource({
				serverPaging: true,
				pageSize: 50,
				transport: {
					read: {
						url: '${pageContext.request.contextPath}/subHoliday/defaultIframeReqList',
						dataType: 'json',
						type: 'post'
					},
					parameterMap: function(data, operation){
						//data.approval_emp_seq = "${empInfo.empSeq}";
						data.startDt = $('#startDt').val().replace(/-/gi , '');
						data.endDt = $('#endDt').val().replace(/-/gi , '');
						return data;
					}
				},
				schema: {
					data: function(response){
						return response.list.map(function(list){
							var cate = list.category;
							if(cate === '유연근무 월별신청' || cate === '유연근무 일별변경신청') {
								list.rejectCnt = '-';
							}
							return list;
						});
					}
				}
			}),
			height: 580,//460,
			dataBound: gridDataBound,
			scrollable:{
	            endless: true
	        },
	        sortable: true,
	        persistSelection: true,
			selectable: "multiple",
	        toolbar: [{name: 'excel', text: '엑셀 다운로드'}],
	        excel: {
	            fileName: $('#startDt').val().replace(/-/gi , '') + "~" + $('#endDt').val().replace(/-/gi , '') + "신청승인현황.xlsx",
	        },
	        excelExport: function(e) {
	        	var sheet = e.workbook.sheets[0];
	            for (var i = 1; i < sheet.rows.length; i++) {
	              var row = sheet.rows[i];             
	              if ( sheet.rows[i].type == 'data' ) {
		              row.cells[4].value = '-';
	              }
	            }
	        },
			columns: [{
				field: "category",
				title: "분류",
				width: 250
			},{
				field: "reqCnt",
				title: "신청",
				width: 100
			},{
				field: "appCnt",
				title: "승인",
				width: 120
			},{
				field: "rejectCnt",
				title: "반려",
				width: 100
			},{
				field: "url",
				title: "링크",
				width: 100,
				template: function(row){
					var url = row.url;
					return '<a href="${pageContext.request.contextPath}'+ url +'" class="a_btn" target="_blank">승인페이지</a>';
				}
			}
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
});
function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
}
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
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 75px">기간</dt>
				<dd>
					<input type="text" value="" id="startDt" name="startDt" class="w113 datePickerInput"/>
					&nbsp;~&nbsp;
					<input type="text" value="" id="endDt"	name="endDt" class="w113 datePickerInput" />
				</dd>
				<dd>
					<input type="button" onclick="gridReload();" id="searchButton" value="조회" />
				</dd>
			</dl>
		</div>
		
	
		<div class="com_ta2 mt15" id="grid"></div><!-- Mapping1 -->
	</div>	
</div>



