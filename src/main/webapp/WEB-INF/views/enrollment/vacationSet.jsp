<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
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
</style>
	
	<!-- iframe wrap -->
	<div class="iframe_wrap" style="min-width:1100px">
	
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			
			<div class="title_div">
				<h4>연가 설정</h4>
			</div>
		</div>
		<form id="vacationSetFrm" name="vacationSetFrm">
			<input type="hidden" 				id="atmcCreatYn" 				name="atmcCreatYn" 		value="N"				/>
			<input type="hidden" 				id="vcatnKndSn" 				name="vcatnKndSn" 		value="${vcation.vcatnKndSn}"				/>	<!-- 휴가종류코드 -->
			<input type="hidden" 				id="vcatnType" 					name="vcatnType" 		value="${vcation.vcatnType}"				/>	<!-- 휴가종류코드 구분값 -->
			<input type="hidden" 				id="useYn"						name="useYn"			value="Y"				/>
			<input type="hidden" 				id="crtrEmplSn" 				name="crtrEmplSn" 		value="${sessionScope.loginVO.uniqId == null ? '100000178' : sessionScope.loginVO.uniqId}"			/>	<!-- 사번 임시 -->
			<div class="sub_contents_wrap">
			<p class="tit_p mt5 mt20">연가 설정</p>
				<div class="top_box">
					<dl style="height:40px;">
						<dt class="ar" style="width: 65px">구분</dt>
						<dd>
							<input type="text" disabled="disabled" value="연가"/>
						</dd>
						<dt  class="ar" style="width:65px" >재직기간</dt>
						<dd>
							<input type="text" id="hffcPdStrYr" name="hffcPdStrYr" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년이상
							<input type="text" id="hffcPdEndYr" name="hffcPdEndYr" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년미만
						</dd>
							<dt  class="ar" style="width:65px" >부여휴가</dt>
						<dd>
							<input type="text" id="alwncVcatn" name="alwncVcatn" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일/년
							<input type="checkbox" id="atmcCreatCheck" style="margin-left: 30px; margin-right: 5px;"/>자동생성
						</dd>
					</dl>
					<dl>
						<dt  class="ar" style="width:65px" >비고</dt>
						<dd>
							<input type="text" id="rmk" name="rmk" style="width:660px;" />
						</dd>
					</dl>				
				</div>
				<div class="btn_div" style="margin-top:20px;">	
					<div class="left_div">
						<p class="tit_p mt5 mb0">휴가종류</p>
					</div>

					<div class="right_div">
						<div class="controll_btn p0">										
							<button type="button" id="btnSave"	>등록</button>
							<button type="button" id="btnPopup"	>수정</button>
							<button type="button" id="btnDelete">삭제</button>
						</div>
					</div>
				</div>					
				<div class="com_ta2 mt15">
				    <div id="grid"></div>
				</div>	
			</div>
		</form>
	</div>
	<!-- fn_save('delete'); -->
	<!--수정팝업 -->
	<div class="pop_wrap_dir" id="vacationPopUp" style="width:900px;">
		<div class="pop_head">
			<h1>연가설정</h1>
		</div>
		<form id="vacationSetPopupFrm" name="vacationSetPopupFrm">
			<input type="hidden" 				id="yrvacSetupSn"				name="yrvacSetupSn"		value=""				/>
			<input type="hidden" 				id="atmcCreatYn2" 				name="atmcCreatYn" 		value="N"				/>
			<div class="com_ta mt15" style="">
				<div>
					<div class="top_box">
						<dl style="height:40px;">
							<dt class="ar" style="width: 65px">구분</dt>
							<dd>
								<input type="text" disabled="disabled" value="연가"/>
							</dd>
							<dt  class="ar" style="width:65px" >재직기간</dt>
							<dd>
								<input type="text" id="hffcPdStrYr2" name="hffcPdStrYr" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년이상
								<input type="text" id="hffcPdEndYr2" name="hffcPdEndYr" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년미만
							</dd>
								<dt  class="ar" style="width:65px" >부여휴가</dt>
							<dd>
								<input type="text" id="alwncVcatn2" name="alwncVcatn" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>일/년
								<input type="checkbox" id="atmcCreatCheck2" style="margin-left: 30px; margin-right: 5px;"/>자동생성
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
				<button type="button" id="btnUpdate"	onclick="fn_save('update');">수정</button>
				<input type="button" class="gray_btn" id="changeCancle" value="닫기" />
			</div>
		</div>
	</div>
	
<script type="text/javascript">
 	$(function(){
 		if(!$("#vcatnKndSn").val() && !$("#vcatnType").val()){
 			alert("등록된 연가가 없습니다.");
 			
 		}
		mainGrid();
		var myWindow = $("#vacationPopUp");
		myWindow.kendoWindow({
			  width:  "900px",
			  height: "350px",
		     visible:  false,
		     actions: ["Close"],close: workChangeHistory
		 }).data("kendoWindow").center();
		
		
		
		$("#atmcCreatCheck").on("click", function(){
			if($(this).is(":checked")){
				$("#atmcCreatYn").val("Y");
			}else{
				$("#atmcCreatYn").val("N");
			}
		});
		
		$("#atmcCreatCheck2").on("click", function(){
			if($(this).is(":checked")){
				$("#atmcCreatYn2").val("Y");
			}else{
				$("#atmcCreatYn2").val("N");
			}
		});
		
		$("#changeCancle").click(function(){
			fn_popupReset();
			$("#grid").data('kendoGrid').dataSource.read();
			myWindow.data("kendoWindow").close();
		 });
		
		
		
		$("#btnPopup").on("click", function(){
			var checkGroup = $(".checkbox_group:checked");
			if(checkGroup.length == 0){
				alert("선택된 휴가가 없습니다.");
				return false;
			}
			if(checkGroup.length > 1){
				alert("선택이 잘못 되었습니다.");
				$("#atmcCreatCheck").prop("checked",false);
				$("#topCheckbox").prop("checked", false);
				fn_reset();
				return false;
			}
			fn_dateSet(checkGroup[0].value);
			myWindow.data("kendoWindow").open();
			$("#grid").data('kendoGrid').dataSource.read();
		});
		
		$("#topCheckbox").change(function(){
			
			var checkedIds = {};
		    if($("#topCheckbox").is(":checked")){
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
		
		$("#btnDelete").on("click", function(){
			var checkBoxGroup = $(".checkbox_group:checked").not("#topCheckbox");
			if(checkBoxGroup.length == 0){
				alert("체크여부를 확인하세요.");
				return false;
			}
			if(checkBoxGroup.length > 0){
				for(var i = 0 ; i < checkBoxGroup.length ; i++){
					deleteList[i] = checkBoxGroup[i].value;
				}
			}
			fn_save('delete');
		});
		
		$("#btnSave").on("click", function(){
			if($("#hffcPdStrYr").val() == null || $("#hffcPdStrYr").val() == ""){
				$("#hffcPdStrYr").val(0);
			}
			if($("#hffcPdEndYr").val() == null || $("#hffcPdEndYr").val() == ""){
				$("#hffcPdEndYr").val(0);
			}
			if($("#alwncVcatn").val() == null || $("#alwncVcatn").val() == ""){
				alert("부여휴가가 없습니다.");
				$("#alwncVcatn").focus();
				return false;
			}
			fn_save('write');
		});
		
	});
 	
 	var deleteList = new Array();
 	
 	function workChangeHistory(){
 		fn_popupReset();
 		$("#grid").data('kendoGrid').dataSource.read();
    }
 	
 	
	 var dataSource = new kendo.data.DataSource({
		serverPaging: true,
		pageSize: 10,
	    transport: { 
	        read:  {
	            url: "<c:url value='/enrollment/yrvacSetupList.do'/>",
	            dataType: "json",
	            type: 'post'
	        },
	      	parameterMap: function(data, operation) {
	      		//data.vcatnKndSn = $("#vcatnKndSn").val();
	      		data.vcatnType = $("#vcatnType").val();
	     	return data;
	     	}
	    },
	    schema: {
	      data: function(response) {
				return response.list;
	      },
	      total: function(response) {
				return response.totalCount;
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





	kendo.ui.Grid.fn.fitColumns = function(parentColumn)
	{
	  var grid = this;
	  var columns = grid.columns;
	  if(parentColumn && parentColumn.columns)
	    	columns = parentColumn.columns;
	  columns.forEach(function(col) {
	    if(col.columns)
	      	return grid.fitColumns(col);
	    grid.autoFitColumn(col);
	  });
	  grid.expandToFit();
	}
	
	kendo.ui.Grid.fn.expandToFit = function()
	{
		  var $gridHeaderTable = this.thead.closest('table');
	      var gridDataWidth = $gridHeaderTable.width();
	      var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap').innerWidth();
	      if (gridDataWidth >= gridWrapperWidth) {
	          return;
	      }
	
	      var $headerCols = $gridHeaderTable.find('colgroup > col');
	      var $tableCols = this.table.find('colgroup > col');
	
	      var sizeFactor = (gridWrapperWidth / gridDataWidth);
	      $headerCols.add($tableCols).not('.k-group-col').each(function () {
	          var currentWidth = $(this).width();
	          var newWidth = (currentWidth * sizeFactor);
	          $(this).css({
	              width: newWidth
	          });
	      });        
	}//expandToFit
	
	function gridReload(){
		$('#grid').data('kendoGrid').dataSource.read();
	}
	
	/* 대체휴무 발생현황 개인조회 리스트 */
	function mainGrid(){
		//캔도 그리드 기본
		var grid = $("#grid").kendoGrid({
	        dataSource: dataSource,
	        height: 600,
	        dataBound: function(e)
	        {
	            //console.log(this.dataSource.data());
	            this.fitColumns();
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
	       		headerTemplate: "<input type='checkbox' id='topCheckbox' class='checkbox_group'>",
	       		template : fn_checkBox,
	            width : 50,
	        },{
	            template : fn_workTerm,
	            title: "재직기간",
	            width: 100
	        }, {
	        	template : fn_atmcCreatYn,
	            title: "자동생성여부",
	            width : 220
	        }, {
	            field: "alwncVcatn",
	            title: "부여휴가(일/년)",
	            width : 220
	        }, {
	            field: "rmk",
	            title: "비고",
	            width : 220
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
			$("#headerCheckbox"+record.yrvacSetupSn).click();
			if($("#headerCheckbox"+record.yrvacSetupSn).is(":checked")){
				$(".checkbox_group").not("#headerCheckbox"+record.yrvacSetupSn).prop("checked", false);
				fn_dateSet(record.yrvacSetupSn);
			}else{
				fn_popupReset();
			}
			
		}
	}
	
	
	function fn_save(mode){
		if(mode == "update"){
			var formData = new FormData(document.getElementById("vacationSetPopupFrm"));
		}else if(mode == "write"){
			var formData = new FormData(document.getElementById("vacationSetFrm"));
		}else if(mode == "delete"){
			var formData = new FormData();
			formData.append("deleteList", deleteList);
		}
		formData.append("mode", mode);
		$.ajax({
			url:"<c:url value='/enrollment/vacationSave'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				if(mode == "update"){
					$("#changeCancle").click();
				}
				deleteList = new Array();
				if(result.state != null){
					alert(result.message);
					fn_reset();
				}
			}
		});	
	}
	
	//체크박스
	function fn_checkBox(row){
		var str = "<input type='checkbox' id='headerCheckbox"+row.yrvacSetupSn+"' class='checkbox_group' value="+row.yrvacSetupSn+">";
		return str;
	}
	//재직기간
	function fn_workTerm(row){
		var str = "";
		if(Number(row.hffcPdStrYr) == 0){
			str = row.hffcPdEndYr + "년미만";
		}else if(Number(row.hffcPdEndYr) == 0){
			str = row.hffcPdStrYr + "년이상";
		}else{
			str = row.hffcPdStrYr + "년이상 ~ " + row.hffcPdEndYr + "년미만";
		}
		
		return str;
	}
	//자동생성
	function fn_atmcCreatYn(row){
		var creatYn = row.atmcCreatYn;
		if(creatYn == 'Y'){
			return "자동";
		}else{
			return "수동";
		}
	}
	//필드 리셋
	function fn_reset(){
		$("#grid").data('kendoGrid').dataSource.read();
		$("#atmcCreatCheck").prop("checked",false);
		$("#topCheckbox").prop("checked", false);
		$("#atmcCreatYn").val("N");
		$("#alwncVcatn").val("");
		$("#hffcPdStrYr").val("");
		$("#hffcPdEndYr").val("");
		$("#rmk").val("");
		$("#atmcCreatCheck").prop("checked",false);
		$("#topCheckbox").prop("checked", false);
		$("#atmcCreatYn2").val("N");
		$("#alwncVcatn2").val("");
		$("#hffcPdStrYr2").val("");
		$("#hffcPdEndYr2").val("");
		$("#rmk2").val("");
		$("#yrvacSetupSn").val("");
		
	}
	//팝업창 리셋
	function fn_popupReset(){
		$("#atmcCreatCheck").prop("checked",false);
		$("#topCheckbox").prop("checked", false);
		$("#atmcCreatYn").val("N");
		$("#alwncVcatn").val("");
		$("#hffcPdStrYr").val("");
		$("#hffcPdEndYr").val("");
		$("#rmk").val("");
		$("#atmcCreatCheck").prop("checked",false);
		$("#topCheckbox").prop("checked", false);
		$("#atmcCreatYn2").val("N");
		$("#alwncVcatn2").val("");
		$("#hffcPdStrYr2").val("");
		$("#hffcPdEndYr2").val("");
		$("#rmk2").val("");
		$("#yrvacSetupSn").val("");
	}
	
	//필드 데이터 추가
	function fn_dateSet(key){
		var formData = new FormData();
		formData.append("yrvacSetupSn", key);
		formData.append("vcatnType", "V001");
		$.ajax({
			url:"<c:url value='/enrollment/getVacation'/>",
			data: formData,
			type: 'POST',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				//필드
				var atmcCreatYn = result.atmcCreatYn;
				if(atmcCreatYn == 'Y'){
					$("#atmcCreatCheck").prop("checked",true);
				}else{
					$("#atmcCreatCheck").prop("checked",false);
				}
				$("#atmcCreatYn").val(atmcCreatYn);
				$("#alwncVcatn").val(result.alwncVcatn);
				$("#hffcPdStrYr").val(result.hffcPdStrYr);
				$("#hffcPdEndYr").val(result.hffcPdEndYr);
				$("#rmk").val(result.rmk);
				$("#yrvacSetupSn").val(result.yrvacSetupSn);
				
				var atmcCreatYn = result.atmcCreatYn;
				if(atmcCreatYn == 'Y'){
					$("#atmcCreatCheck2").prop("checked",true);
				}else{
					$("#atmcCreatCheck2").prop("checked",false);
				}
				//팝업창
				$("#atmcCreatYn2").val(atmcCreatYn);
				$("#alwncVcatn2").val(result.alwncVcatn);
				$("#hffcPdStrYr2").val(result.hffcPdStrYr);
				$("#hffcPdEndYr2").val(result.hffcPdEndYr);
				$("#rmk2").val(result.rmk);
				$("#yrvacSetupSn").val(result.yrvacSetupSn);
				
			}
		});	
	}
</script> 