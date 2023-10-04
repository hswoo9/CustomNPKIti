<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>

<script>

	$(document).ready(function() {
		gridInit();
		
	}); 
	 
	function gridRead() {
		 var grid = $("#grid").data("kendoGrid");
			grid.dataSource.read();
			grid.refresh();
	 }
	
	function gridInit() {
		var dataSource = new kendo.data.DataSource({
			serverPaging: true,
				pageSize: 10,
		     transport: { 
		         read:  {
		             url: '../patch/moduleSourceListData',
		             dataType: 'json',
		             type: 'post'
		         },
		         parameterMap: function(options, operation) {
		           /*   options.groupSeq = '1';
		             options.mainDeptYn = 'Y';
		             options.nameAndLoginId = $("#searchKeyword").val();
		             options.positionCode = $("#positionCode").val();
		             options.dutyCode = $("#dutyCode").val();
		             options.deptName = $("#deptName").val();
		             options.workStatus = $("#workStatus").val();
		             options.useYn = $("#useYn").val();
		             options.workTeam = $("#workTeam").val();
		             options.compSeq = $("#com_sel").val(); */
		             
		                
		             if (operation !== "read" && options.models) {
		                 return {models: kendo.stringify(options.models)};
		             }
		             
		             return options;
		         }
		     }, 
		     schema:{
					data: function(response) {
			  	      return response.list;
			  	    },
			  	    total: function(response) {
			  	      return response.totalCount;
			  	    }
			  	  }
		 });
		
		var grid = $("#grid").kendoGrid({
			 dataSource: dataSource,
		     sortable: false ,
			     selectable: true,
		     navigatable: true,
		     pageable: true,
		 		scrollable: true,
		 		columnMenu: false,
		 		autoBind: true,
		 		columns: [
		                { field: "pSeq", title: "번호", headerAttributes: {style: "text-align: center;"}, attributes: {style: "text-align: center;"},sortable: false  },
		                { field: "moduleSeq", title: "모듈", headerAttributes: {style: "text-align: center;"}, attributes: {style: "text-align: center;"},sortable: false  },
		                { field: "moduleVersion", title: "모듈버전", headerAttributes: {style: "text-align: center;"}, attributes: {style: "text-align: center;"},sortable: false } 
		              
		       		]
		     /* ,
		     selectable:"row",
		     change: function(e) { 
		     	var selectedDataItem = e != null ? e.sender.dataItem(e.sender.select()) : null;
		       } */
		
		 }).data("kendoGrid");
		  
		//	 $("#grid").data("kendoGrid").table.on("click", ".checkbox" , selectRow);
		/*  grid.table.on("click", ".k-checkbox" , function (e) {CommonKendo.setChecked(grid, this);});      
		 
		 $("#grid").on("dblclick", "tr.k-state-selected", function (e) {
			 var selectedItem = $("#grid").data("kendoGrid").dataItem(this);
			 empInfoPop(selectedItem.compSeq, selectedItem.empSeq);
		 }); */
	}
</script>
<div id="" class="controll_btn"> 
	<button id="" class="k-button" type="button">로그인 ID변경</button>
	<button id="" class="k-button" type="button">입사처리</button>
	<button id="" class="k-button" type="button">퇴사처리</button>
	<button id="" class="k-button" type="button">일괄등록</button>
	<button id="" class="k-button" type="button">근무조지정</button>
	<button id="" class="k-button" type="button">삭제</button>
</div>
<div id="grid"></div>
