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
	<div class="iframe_wrap" style="min-width:1100px">
	
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			
			<div class="title_div">
				<h4>장기근속휴가 설정</h4>
			</div>
		</div>
		<form id="longVacSetFrm" name="longVacSetFrm">
			<input type="hidden" 				id="atmcCreatYn" 				name="atmcCreatYn" 		value="N"				/>
			<input type="hidden" 				id="vcatnKndSn" 				name="vcatnKndSn" 		value="0"				/>	<!-- 휴가종류코드 -->
			<input type="hidden" 				id="useYn"						name="useYn"			value="Y"				/>
			<input type="hidden" 				id="crtrEmplSn" 				name="crtrEmplSn" 		value="${sessionScope.loginVO.uniqId == null ? '100000178' : sessionScope.loginVO.uniqId}"			/>	<!-- 사번 임시 -->
			<div class="sub_contents_wrap">
			<p class="tit_p mt5 mt20">장기근속휴가 설정</p>
				<div class="top_box">
					<dl style="height:40px;">
						<dt class="ar" style="width: 65px">구분</dt>
						<dd>
							<input type="text" disabled="disabled" value="장기근속휴가"/>
						</dd>
						<dt  class="ar" style="width:65px" >근속년수</dt>
						<dd>
							<input type="text" id="cnwkYycnt" name="cnwkYycnt" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년
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
								<button type="button" id="btnAllSave">일괄등록</button>
								<button type="button" id="btnSave"	>등록</button>
								<button type="button" id="btnPopup"	>수정</button>
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
	<!--수정팝업 -->
	<div class="pop_wrap_dir" id="vacationPopUp" style="width:900px;">
		<div class="pop_head">
			<h1>연가설정</h1>
		</div>
		<form id="longVacSetPopupFrm" name="longVacSetPopupFrm">
			<input type="hidden" 				id="lnglbcCnwkVcatnSetupSn"				name="lnglbcCnwkVcatnSetupSn"		value=""				/>
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
								<input type="text" id="cnwkYycnt2" name="cnwkYycnt" style="width:40px; margin-right:5px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"/>년
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
<!-- loading bar -->
<div id="loadingDiv" style="display: none;">
	<div class="loading-container">
	    <div class="loading"></div>
	    <div id="loading-text">등록중</div>
	</div>
</div>
	<script type="text/javascript">
		$(function(){
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
					$(".checkbox_group").prop("checked",false);
					$("#topCheckbox").prop("checked", false);
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
				if($("#cnwkYycnt").val() == null || $("#cnwkYycnt").val() == ""){
					alert("근속년수가 없습니다.");
					$("#cnwkYycnt").focus();
					return false;
				}
				if($("#alwncVcatn").val() == null || $("#alwncVcatn").val() == ""){
					alert("부여휴가가 없습니다.");
					$("#alwncVcatn").focus();
					return false;
				}
				fn_save('write');
			});
			
			$("#btnAllSave").on("click", function(e){
				if(confirm("일괄 등록 하시겠습니까?")){
					$("#loadingDiv").show();
					e.preventDefault();
					fn_allSave();
				}else{
					return false;
				}
				
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
		            url: "<c:url value='/longVacSet/longVacSetList'/>",
		            dataType: "json",
		            type: 'post'
		        },
		      	parameterMap: function(data, operation) {
		      		data.vcatnKndSn = $("#vcatnKndSn").val();
		     	return data;
		     	}
		    },
		    schema: {
		      data: function(response) {
					return response.list;
		      },
		      total: function(response) {
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
		            template : fn_cnwkYycnt,
		            title: "근속년수",
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
				$("#headerCheckbox"+record.lnglbcCnwkVcatnSetupSn).click();
				if($("#headerCheckbox"+record.lnglbcCnwkVcatnSetupSn).is(":checked")){
					$(".checkbox_group").not("#headerCheckbox"+record.lnglbcCnwkVcatnSetupSn).prop("checked", false);
					fn_dateSet(record.lnglbcCnwkVcatnSetupSn);
				}else{
					fn_popupReset();
				}
			}
		}
		
		
		function fn_save(mode){
			if(mode == "update"){
				var formData = new FormData(document.getElementById("longVacSetPopupFrm"));
			}else if(mode == "write"){
				var formData = new FormData(document.getElementById("longVacSetFrm"));
			}else if(mode == "delete"){
				var formData = new FormData();
				formData.append("deleteList", deleteList);
			}
			formData.append("mode", mode);
			$.ajax({
				url:"<c:url value='/longVacSet/longVacSetSave'/>",
				data: formData,
				type: 'POST',
				processData: false,
				contentType: false,
				dataType: 'json',
				cache: false,
				async: false,
				success:function(data){
					if(mode == "update"){
						$("#changeCancle").click();
					}
					deleteList = new Array();
					if(data.result.state != null){
						alert(data.result.message);
						fn_reset();
					}
				}
			});	
		}
		
		//체크박스
		function fn_checkBox(row){
			var str = "<input type='checkbox' id='headerCheckbox"+row.lnglbcCnwkVcatnSetupSn+"' class='checkbox_group' value="+row.lnglbcCnwkVcatnSetupSn+">";
			console.log(row);
			return str;
		}
		//근속년수
		function fn_cnwkYycnt(row){
			return row.cnwkYycnt + "년";
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
			$("#cnwkYycnt").val("");
			$("#hffcPdEndYr").val("");
			$("#rmk").val("");
			
		}
		//팝업창 리셋
		function fn_popupReset(){
			$("#atmcCreatCheck").prop("checked",false);
			$("#topCheckbox").prop("checked", false);
			$("#atmcCreatYn").val("N");
			$("#alwncVcatn").val("");
			$("#cnwkYycnt").val("");
			$("#hffcPdEndYr").val("");
			$("#rmk").val("");
			$("#atmcCreatCheck").prop("checked",false);
			$("#topCheckbox").prop("checked", false);
			$("#atmcCreatYn2").val("N");
			$("#alwncVcatn2").val("");
			$("#cnwkYycnt2").val("");
			$("#hffcPdEndYr2").val("");
			$("#rmk2").val("");
			$("#lnglbcCnwkVcatnSetupSn").val("");
		}
		
		//필드 데이터 추가
		function fn_dateSet(key){
			var formData = new FormData();
			formData.append("lnglbcCnwkVcatnSetupSn", key);
			$.ajax({
				url:"<c:url value='/longVacSet/getLongVacSet'/>",
				data: formData,
				type: 'POST',
				processData: false,
				contentType: false,
				dataType: 'json',
				cache: false,
				async: false,
				success:function(data){
					console.log(data);
					var result = data.object;
					var atmcCreatYn = result.atmcCreatYn;
					//필드용
					if(atmcCreatYn == 'Y'){
						$("#atmcCreatCheck").prop("checked",true);
					}else{
						$("#atmcCreatCheck").prop("checked",false);
					}
					$("#atmcCreatYn").val(atmcCreatYn);
					$("#alwncVcatn").val(result.alwncVcatn);
					$("#cnwkYycnt").val(result.cnwkYycnt);
					$("#hffcPdEndYr").val(result.hffcPdEndYr);
					$("#rmk").val(result.rmk);
					
					//팝업용
					if(atmcCreatYn == 'Y'){
						$("#atmcCreatCheck2").prop("checked",true);
					}else{
						$("#atmcCreatCheck2").prop("checked",false);
					}
					$("#atmcCreatYn2").val(atmcCreatYn);
					$("#alwncVcatn2").val(result.alwncVcatn);
					$("#cnwkYycnt2").val(result.cnwkYycnt);
					$("#hffcPdEndYr2").val(result.hffcPdEndYr);
					$("#rmk2").val(result.rmk);
					$("#lnglbcCnwkVcatnSetupSn").val(result.lnglbcCnwkVcatnSetupSn);
					
				}
			});	
		}
		function fn_allSave(){
			
			setTimeout(function(){
				$.ajax({
					url:"<c:url value='/longVacSet/makeLongVac'/>",
					data: "",
					type: 'POST',
					dataType: 'json',
					cache: false,
					async: false,
					success:function(data){
						alert("등록되었습니다.");
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
	</script> 