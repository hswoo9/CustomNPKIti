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
<fmt:formatDate value="${weekDay}" var="weekDay" pattern="E" type="date" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/budget/budgetUtil.js' />"></script>

<script type="text/javascript">

	var empSeq = "${empSeq}";

	$(function() {
		Init.ajax();
		
		Init.kendoFunction();
		Init.kendoGrid();
		Init.eventListener();
	})
	
	var Init = {
			ajax : function() {
				
			},
			kendoFunction : function() {
				
				var now = new Date();
				
				now.setDate(now.getDate() - 7);
				
				$("#fromDate").kendoDatePicker({
				    depth: "month",
				    start: "month",
				    culture : "ko-KR",
					format : "yyyy-MM-dd",
					value : moment(now).format("YYYY-MM-DD"),
				});
				
				$("#toDate").kendoDatePicker({
				    depth: "month",
				    start: "month",
				    culture : "ko-KR",
					format : "yyyy-MM-dd",
					value : moment(new Date()).format("YYYY-MM-DD"),
				});
			},
			
			kendoGrid : function() {
				/* 상단 그리드 */
				var mainGrid = $("#mainGrid").kendoGrid({
					dataSource : new kendo.data.DataSource({
						transport : {
							read : {
								url : _g_contextPath_+"/budget/selectLoginHistory",
								dataType : "json",
								type : 'post'
							},
							parameterMap: function(data, operation) {
		  	      				data.fromDate = $("#fromDate").val().replace(/-/gi,'');
			  	      			data.toDate = $("#toDate").val().replace(/-/gi,'');
			  	      			data.empSeq = empSeq;
		    	     			return data;
		    	     		}
						},
						schema : {
							data : function(response) {
								return response.loginHistoryList;
							},
							total : function(response) {
								return response.loginHistoryList.length;
							},
						}
					}),
					height : 700,
					dataBound : mainGridDataBound,
			        columns: [
			        	{	
			        		field : "yyyymmdd",				title : "일자",							width : 40,
			        		template : function(e) {
			        			return e.yyyymmdd + " " + e.hhii;
			        		}
			        	},
			        	{	field : "access_ip",				title : "접속 IP",						width : 160 },
			        	{	
			        		title : "접속국가",				width : 40, 
			        		template : function(e) {
			        			return '대한민국 (KR)';
			        		}
			        	},
			        	{	
			        		field : "device_type",				title : "접속 경로",				width : 40,
			        		template : function(e) {
			        			
			        			if (e.device_type === 'WEB_LOGIN' || e.device_type === 'WEB_LOGOUT') {
			        				return "웹";
			        			} else if (e.device_type === 'MESSENGER_LOGIN') {
			        				return "메신저";
			        			} else {
			        				return "모바일";
			        			}
			        		}
			        	}
		        	]
			    }).data("kendoGrid");
				/* 상단 그리드 */
				
			},
			eventListener : function() {
				
				$("#searchBtn").on("click", function() {
					mainGridReload();
				});
			}
	}
	
	function mainGridDataBound(e) {
		var grid = e.sender;

		if (grid.dataSource.total() == 0) {
			var colCount = grid.columns.length + 3;
			$(e.sender.wrapper).find('tbody').append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		}
	}
	
	function mainGridReload() {
		$('#mainGrid').data('kendoGrid').dataSource.read();
	}
</script>

<body>
<div class="iframe_wrap">
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>로그인 히스토리</h4>
		</div>
	</div>
	
	<div class="sub_contents_wrap">
		<div class="com_ta">
			<div class="top_box gray_box" id = "dataBox">
				<dl>
					<dt>기간</dt>
					<dd style="width:22%">
						<input type="text" style="" id = "fromDate" style = "" value=""/>
						~
						<input type="text" style="" id = "toDate" style = "" value=""/>
					</dd>
					<dd style="width:30%">
						<button type="button" class="blue_btn" id = "searchBtn">검색</button>
					</dd>
				</dl>
			</div>
		</div>
				
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">로그인 히스토리</p>
			</div>
		</div>
		
		<div class="com_ta2" style="">
			<div  id = "mainGrid">
			</div>
		</div>
	</div>
</div>

</body>