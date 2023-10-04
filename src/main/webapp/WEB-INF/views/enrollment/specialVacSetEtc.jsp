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
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
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

.k-dropdown-wrap.k-state-default {
	overflow: hidden;
}
</style>
	
	<!-- iframe wrap -->
	<div class="iframe_wrap" style="min-width:1100px">
	
		<!-- 컨텐츠타이틀영역 -->
		<div class="sub_title_wrap">
			
			<div class="title_div">
				<h4>기타휴가 설정</h4>
			</div>
		</div>
		
		<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">기타휴가 설정</p>
			<div class="top_box">
				<dl style="height:40px;">
					<dt class="ar" style="width: 65px">구분</dt>
					<dd>
						<input type="text" disabled="disabled" value="기타휴가"/>
						<input type="hidden" value="681" id="vcatnGbnCmmnCd" />
                        <input type="hidden" value="" id="vcatnKndRmk" />
						<select style="width:120px; height:24px;" id="vcatnGbnName" name="vcatnGbnName">
							<optgroup label="기타휴가구분">
							</optgroup>
						</select>
						<select style="width:100px; height:24px;" id="payYn" name="payYn">
							<optgroup label="유/무급구분" >
							</optgroup>
						</select>
					</dd>
					<dt  class="ar" style="width:65px" >적용대상</dt>
					<dd>
						<input type="checkbox" id="applyW" class="checkVal" value="F" style="margin-left: 10px; margin-right: 5px;"/>여직원
						<input type="checkbox" id="applyM" class="checkVal" value="M" style="margin-left: 10px; margin-right: 5px;"/>남직원
						<input type="checkbox" id="applyC" class="checkVal" value="C" style="margin-left: 10px; margin-right: 5px;"/>임직원
					</dd>
					<dt class="ar" style="width:65px" >부여휴가</dt>
					<dd>
						<input type="text" id="alwncVcatn" name="alwncVcatn" style="width:40px; margin-right:5px;"/>
					</dd>
					<dd>
						<select style="width:100px; height:24px;" id="alwncVcatnUnit" name="alwncVcatnUnit">
							<optgroup label="부여휴가단위">
							</optgroup>
						</select>
					</dd>
					
					<dd style="display: none;">/
						<select style="width:100px; height:24px;" id="alwncVcatnBase" name="alwncVcatnBase">
							<optgroup label="부여휴가기준">
							</optgroup>
						</select>
					</dd>
				</dl>
				<dl style="height:40px;">
					<dt  class="ar" style="width:110px" >
						<input type="checkbox" id="cnIndictYn" name="cnIndictYn" value="" style="margin-left: 10px; margin-right: 5px;"/>비고
					</dt>
					<dd>
						<input type="text" id="cn" name="cn" style="width:400px;"  placeholder="가족의 질병, 사고, 노령 또는 자녀 양육 등"/>
					</dd>
					<dd>	
						<dt  class="ar" style="width:110px" >
							<input type="checkbox" id="validPdYn" name="validPdYn" value="" style="margin-left: 10px; margin-right: 5px;"/>유효기간
						</dt>
					</dd>		
					<dd>
						<input type="text" id="validPd" name="validPd" value=""style="width:40px; margin-right:5px;"/>
					</dd>
					<dd>
						<select style="width:100px; height:24px;" id="validPdUnit" name="validPdUnit">
							<optgroup label="부여휴가단위">
							</optgroup>
						</select>
					</dd>
				</dl>	
				<dl>
					<dt  class="ar" style="width:136px" >
						<input type="checkbox" id="aftfatMntYn" name="aftfatMntYn" value="" style="margin-left: 10px; margin-right: 5px;"/>사후관리여부
					</dt>
					<dd>
						<select style="width:100px; height:24px;" id="aftfatMntMth" name="aftfatMntMth">
							<optgroup label="사후관리방법">
							</optgroup>
						</select>
					</dd>
					<dd>
						<select style="width:200px; height:24px;" id="aftfatMntFrmtName" name="aftfatMntFrmtName">
						<optgroup label="휴가사유서">
						</optgroup>
						</select>
					</dd>

				</dl>			
			</div>
			<div class="btn_div" style="margin-top:20px;">	
				<div class="left_div">
					<p class="tit_p mt5 mb0">휴가종류</p>
				</div>

				<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="btnReset">초기화</button>
						<button type="button" id="btnSave">등록</button>
						<button type="button" id="btnMod">수정</button>
						<button type="button" id="btnDel">삭제</button>
					</div>
				</div>
			</div>
			<div class="com_ta2 mt15">
			    <div id="grid"></div>
			</div>	
		</div><!-- //sub_contents_wrap -->
	</div><!-- iframe wrap -->

<div class="pop_wrap_dir" id="specialPop" style="width: 615px; height: 400px;" hidden>
	<div class="pop_head">
		<h1>휴가종류 수정</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th colspan="3">구분</th>
					<td style="width: 75%;" class="le">
						<input type="text" disabled="disabled" value="기타휴가">
						<input type="hidden" id="vcatnKndSn2" name="vcatnKndSn2" />
						<select style="width:120px; height:24px;" id="vcatnGbnName2" name="vcatnGbnName2">
							<optgroup label="기타휴가구분">
							</optgroup>
						</select>
						<select style="width:100px; height:24px;" id="payYn2" name="payYn2">
							<optgroup label="유/무급구분" >
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<th colspan="3">적용대상</th>
					<td class="le">
						<input type="checkbox" class="checkVal2" id="applyW2" value="F" style="margin-left: 10px; margin-right: 5px;"/>여직원
						<input type="checkbox" class="checkVal2" id="applyM2" value="M" style="margin-left: 10px; margin-right: 5px;"/>남직원
						<input type="checkbox" class="checkVal2" id="applyC2" value="C" style="margin-left: 10px; margin-right: 5px;"/>임직원
					</td>
				</tr>
				<tr>
					<th colspan="3">부여휴가</th>
					<td class="le">
						<input type="text" id="alwncVcatn2" name="alwncVcatn2" style="width:40px; margin-right:5px;"/>
						<select style="width:100px; height:24px;" id="alwncVcatnUnit2" name="alwncVcatnUnit2">
							<optgroup label="부여휴가단위">
							</optgroup>
						</select>
						<p style="display: none;">
							<select style="width:100px; height:24px;" id="alwncVcatnBase2" name="alwncVcatnBase2">
								<optgroup label="부여휴가기준">
								</optgroup>
							</select>
						</p>
					</td>
				</tr>
				<tr>
					<th colspan="3">내용표시</th>
					<td class="le">
						<input type="checkbox" id="cnIndictYn2" name="cnIndictYn2" value="" style="margin-left: 10px; margin-right: 5px;"/>내용표시
						<input type="text" id="cn2" name="cn2" style="width: 100%; margin-top: 7px;"  placeholder="가족의 질병, 사고, 노령 또는 자녀 양육 등"/>
					</td>

				</tr>
				<tr>
					<th colspan="3">유효기간</th>
					<td class="le">
						<input type="checkbox" id="validPdYn2" name="validPdYn2" value="" style="margin-left: 10px; margin-right: 5px;"/>유효기간
						<select style="width:100px; height:24px;" id="validPdUnit2" name="validPdUnit2">
							<optgroup label="부여휴가단위">
							</optgroup>
						</select>
					</td>
				</tr>
				<tr>
					<th colspan="3">사후관리여부</th>
					<td class="le">
						<input type="checkbox" id="aftfatMntYn2" name="aftfatMntYn2" value="" style="margin-left: 10px; margin-right: 5px;"/>사후관리여부
						<select style="width:100px; height:24px;" id="aftfatMntMth2" name="aftfatMntMth2">
							<optgroup label="사후관리방법">
							</optgroup>
						</select>
						<select style="width:200px; height:24px;" id="aftfatMntFrmtName2" name="aftfatMntFrmtName2">
							<optgroup label="휴가사유서">
							</optgroup>
						</select>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="popRegister" onclick= "specialUpdate();" value="수정" />
			<input type="button" class="gray_btn" id="specialPopCancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->
<script type="text/javascript">
var check;
	$(function(){

		$(".checkVal").click(function(){
			var checkBoxId = $(this).context.id;
			if($("#"+checkBoxId).is(":checked")){
				$(".checkVal").not("#"+checkBoxId).prop("checked", false);
				$(".checkVal").not("#"+checkBoxId).attr("disabled", true);
			}else{
				$(".checkVal").not("#"+checkBoxId).prop("checked", false);
				$(".checkVal").not("#"+checkBoxId).attr("disabled", false);
			}
		});

		$(".checkVal2").click(function(){
			var checkBoxId = $(this).context.id;
			if($("#"+checkBoxId).is(":checked")){
				$(".checkVal2").not("#"+checkBoxId).prop("checked", false);
				$(".checkVal2").not("#"+checkBoxId).attr("disabled", true);
			}else{
				$(".checkVal2").not("#"+checkBoxId).prop("checked", false);
				$(".checkVal2").not("#"+checkBoxId).attr("disabled", false);
			}
		});

		fn_codeListComboBoxInit('vcatnGbnName');
		fn_codeListComboBoxInit('vcatnGbnName2');
		fn_codeListComboBoxInit2('aftfatMntFrmtName');
		fn_codeListComboBoxInit2('aftfatMntFrmtName2');

		$("#payYn, #payYn2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : [
				{text : "유급", value: "Y"},
				{text : "무급", value: "N"}
			]
		});

		$("#alwncVcatnUnit, #alwncVcatnUnit2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource :[
				{text: "일", value: "DAY"},
				{text: "개월", value: "MONTH"},
				{text: "시간", value: "TIME"}
			]
		});

		$("#alwncVcatnBase, #alwncVcatnBase2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource :[
				{text: "해당없음", value: "B_NULL"},
				{text: "건", value: "B_UNIT"},
				{text: "년", value: "B_YEAR"},
				{text: "월", value: "B_MONTH"},
				{text: "일", value: "B_DAY"}
			]
		});

		$("#validPdUnit, #validPdUnit2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource :[
				{text: "일", value: "DAY"},
				{text: "개월", value: "MONTH"},
				{text: "시간", value: "TIME"}
			]
		});

		$("#aftfatMntMth, #aftfatMntMth2").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource :[
				{text: "전자결재", value: "0"},
				{text: "증빙파일", value: "1"}
			]
		});

		$(document).on("click","#checkboxAll", function(){
			if($(this).is(":checked")){
				$(".checkbox").prop("checked", true);
			}else{
				$(".checkbox").prop("checked", false);
			}
		});

		var aftfatMntMth = $("#aftfatMntMth").data("kendoComboBox");
		var aftfatMntFrmtName = $("#aftfatMntFrmtName").data("kendoComboBox");
		var aftfatMntMth2 = $("#aftfatMntMth2").data("kendoComboBox");
		var aftfatMntFrmtName2 = $("#aftfatMntFrmtName2").data("kendoComboBox");
		aftfatMntFrmtName.enable(false);
		aftfatMntMth.enable(false);

		$("#aftfatMntYn").click(function(){
			if($("#aftfatMntYn").is(":checked")){
				aftfatMntMth.enable(true)
				aftfatMntFrmtName.enable(true);
			} else {
				aftfatMntMth.enable(false);
				aftfatMntFrmtName.enable(false);
			}
		});
		$("#aftfatMntYn2").click(function(){
			if($("#aftfatMntYn2").is(":checked")){
				aftfatMntMth2.enable(true)
				aftfatMntFrmtName2.enable(true);
			} else {
				aftfatMntMth2.enable(false);
				aftfatMntFrmtName2.enable(false);
			}
		});

		$("#validPd").attr("disabled", "disabled");
		var validPdUnit = $("#validPdUnit").data("kendoComboBox");
		var validPdUnit2 = $("#validPdUnit2").data("kendoComboBox");
		validPdUnit.enable(false);

		$("#validPdYn").click(function(){
			if($("#validPdYn").is(":checked")){
				validPdUnit.enable(true);
				$("#validPd").removeAttr("disabled");
			} else{
				$("#validPd").attr("disabled", "disabled");
				validPdUnit.enable(false);
			}
		});

		$("#validPdYn2").click(function(){
			if($("#validPdYn2").is(":checked")){
				validPdUnit2.enable(true);
				$("#validPd2").removeAttr("disabled");
			} else{
				$("#validPd2").attr("disabled", "disabled");
				validPdUnit2.enable(false);
			}
		});

        $("#vcatnGbnName").change(function(){
            var vcatnKndSn = this.value;

            var data = {
                vcatnKndSn : vcatnKndSn
            }

            $.ajax({
               url : "<c:url value='/enrollment/getRmk'/>",
               data : data,
               dataType : "json",
               type : "post",
               success : function(rs){
				   var rs = rs.rs;
				   console.log(rs);
				   $("#vcatnKndRmk").val(rs.rmk);
				   $("#alwncVcatn").val(rs.bsicVal);
				   $("#cn").val(rs.rmk);
               }
            });
        });

		$("#aftfatMntMth").change(function(){
			if($("#aftfatMntMth").val() == 1){
				aftfatMntFrmtName.enable(false);
			} else {
				aftfatMntFrmtName.enable(true);
			}
		});

		// 내용 표시
		$("#cnIndictYn").click(function(){

		});

		$("#btnReset").click(function(){
			fn_reset();
		});

		$("#btnSave").click(function(){
			if(!$("#alwncVcatn").val()){
				$("#alwncVcatn").val("0");
			}
			fn_save();
		});

		speclModPop();

		$("#btnDel").click(function(){
			fn_del();
		});

		mainGrid();
		$(".k-input").attr("readonly", "readonly");

	});
	var dataSource = new kendo.data.DataSource({
		serverPaging: true,
		pageSize: 10,
		transport: {
			read:  {
				url: _g_contextPath_+'/etc/etcVacSetList',
				dataType: "json",
				type: 'post'
			},
			parameterMap: function(data, operation) {
				data.group_code_kr = $('#searchGCode').val();
				data.empSeq = $('#use_emp_seq').val();
				data.code_kr = $('#searchCode').val();
				data.notIn = '';
				return data;
			}
		},
		schema: {
			data: function(response) {
				return response.rs;
			},
			total: function(response) {
				return response.rs.length;
			},
			model: {
				fields: {

					weekDay: { type: "string" },


				}
			}
		}
	});
	/* 토요일 일요일 그리드 색깔 처리 함수 */
	function fn_weekDay(row) {
		var key = row.weekDay;

		switch (key) {
			case '토' : return '<span style="color:blue">'+key+'</span>';
				break;
			case '일' : return '<span style="color:red">'+key+'</span>';
				break;
			default  : return '<span>'+key+'</span>';
				break;
		}

	}
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
	}//fitColumns

	kendo.ui.Grid.fn.expandToFit = function()
	{
		var $gridHeaderTable = this.thead.closest('table');
		var gridDataWidth = $gridHeaderTable.width();
		var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap').innerWidth();
		// Since this is called after column auto-fit, reducing size
		// of columns would overflow data.
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
			height: 650,
			dataBound: function(e)
			{
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
					headerTemplate: "<input type='checkbox' id='checkboxAll' />",
					template: function(e){
						return '<input type="checkbox" id = "checkbox'+e.SPECL_VCATN_SETUP_SN+'" class = "checkbox" value="'+e.SPECL_VCATN_SETUP_SN+'">';
					}
				},{
					field: "VCATN_KND_NAME",
					title: "구분",
					width: 100,
					template: function(e){
						return "[기타] " + e.VCATN_KND_NAME;
					}
				}, {
					title: "적용대상",
					width : 100,
					template: function(e){
						var text = "";
						if(e.APPLY_C == "Y"){
							text += "임직원";
						}
						if(e.APPLY_W == "Y"){
							if(text != ""){
								text += " | ";
							}
							text += "여직원";
						}
						if(e.APPLY_M == "Y"){
							if(text != ""){
								text += " | ";
							}
							text += "남직원";
						}

						return text;
					}
				}, {
					title: "부여휴가",
					width : 100,
					template : function(e){
						var unit;
						if(e.ALWNC_VCATN_UNIT == "DAY"){
							unit = "일";
						}
						if(e.ALWNC_VCATN_UNIT == "MONTH"){
							unit = "개월";
						}
						if(e.ALWNC_VCATN_UNIT == "TIME"){
							unit = "시간";
						}
						var base;
						if(e.ALWNC_VCATN_BASE == "B_NULL"){
							base = "";
						}
						if(e.ALWNC_VCATN_BASE == "B_UNIT"){
							base = " / 건";
						}
						if(e.ALWNC_VCATN_BASE == "B_YEAR"){
							base = " / 년";
						}
						if(e.ALWNC_VCATN_BASE == "B_MONTH"){
							base = " / 월";
						}
						if(e.ALWNC_VCATN_BASE == "B_DAY"){
							base = " / 일";
						}

						return e.ALWNC_VCATN + unit + base;
					}
				}, {
					field: "AFTFAT_MNT_YN",
					title: "사후관리여부",
					template: function(e){
						var yn = e.AFTFAT_MNT_YN;
						var str = "";
						if(yn == 'Y'){
							str = "사용";
						}else{
							str = "미사용";
						}
						
						return str;
					}
				}, {
					field: "VALID_PD_YN",
					title: "유효기간",
					template: function(e){
						var yn = e.VALID_PD_YN;
						var str = "";
						if(yn == 'Y'){
							//str = e.VALID_PD + "이내";
							str = "사용";
						}else{
							str = "미사용";
						}
						
						return str;
					}
				}, {
					field: "CN",
					title: "비고",
					width : 220,
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

			dataSet(record);

		}
	}

	/* 대체휴무 신청현황 개인조회 리스트 */
	var reqDataSource = new kendo.data.DataSource({
		serverPaging: true,
		pageSize: 10,
		transport: {
			read:  {
				url: _g_contextPath_+'/subHoliday/subHolidayReqList',
				dataType: "json",
				type: 'post'
			},
			parameterMap: function(data, operation) {
				data.group_code_kr = $('#searchGCode').val();
				data.empSeq = $('#use_emp_seq').val();
				data.code_kr = $('#searchCode').val();
				data.notIn = '';
				return data;
			}
		},
		schema: {
			data: function(response) {
				return response.list;
			},
			total: function(response) {
				return response.totalCount;
			},
			model: {
				fields: {

					weekDay: { type: "string" },
					replace_holi_step: { type: "string" },

				}
			}
		}
	});

	function fn_codeList(){
		var result = {};
		var params = {
			//vcatnGbnCmmnCd : $("#vcatnGbnCmmnCd").val(),
			vcatnType : "",
		};
		var opt = {
			url     : "<c:url value='/etc/etcVacCode'/>",
			async   : false,
			data    : params,
			successFn : function(data){
				result = data.rs;
			}
		};
		acUtil.ajax.call(opt);
		return result;
	}

	function fn_codeList2(){
		var result = {};
		var params = {
			formDTp : "VAC01"
		};
		var opt = {
			url     : "<c:url value='/enrollment/enrollDocSel'/>",
			async   : false,
			data    : params,
			successFn : function(data){
				result = data.rs;
			}
		};
		acUtil.ajax.call(opt);
		return result;
	}

	function fn_codeListComboBoxInit2(id){
		if($('#'+id)){
			var codeList = fn_codeList2();
			codeList.unshift({c_tiname : '전체', c_tikeycode : ""});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : codeList,
				dataTextField: "c_tiname",
				dataValueField: "c_tikeycode",
				index: 0,
				change:function(){
					fnDeptChange();
				}
			});
		}
	}

	function fn_codeListComboBoxInit(id){
		if($('#'+id)){
			var codeList = fn_codeList();
			codeList.unshift({vcatnKndName : '전체', vcatnKndSn : ""});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : codeList,
				dataTextField: "vcatnKndName",
				dataValueField: "vcatnKndSn",
				index: 0,
				change:function(){
					fnDeptChange();
				}
			});
		}
	}

	function fnDeptChange(){
		var obj = $('#vcatnGbnName').data('kendoComboBox');
	}

	function fn_reset(){
		var vcatnGbnName = $("#vcatnGbnName").data("kendoComboBox").select(0);
		var payYn = $("#payYn").data("kendoComboBox").select(0);
		var alwncVcatnUnit = $("#alwncVcatnUnit").data("kendoComboBox").select(0);
		var alwncVcatnBase = $("#alwncVcatnBase").data("kendoComboBox").select(0);
		var validPdUnit = $("#validPdUnit").data("kendoComboBox").select(0);
		var aftfatMntMth = $("#aftfatMntMth").data("kendoComboBox").select(0);
		var aftfatMntFrmtName = $("#aftfatMntFrmtName").data("kendoComboBox").select(0);

		$("input:checkbox[id=applyW]").prop("checked", false);
		$("input:checkbox[id=applyM]").prop("checked", false);
		$("input:checkbox[id=applyC]").prop("checked", false);
		$("input:checkbox[id=cnIndictYn]").prop("checked", false);
		$("input:checkbox[id=validPdYn]").prop("checked", false);
		$("input:checkbox[id=validPdYn]").prop("checked", false);
		$("input:checkbox[id=aftfatMntYn]").prop("checked", false);

		$(".checkVal").attr("disabled", false);
		$(".checkVal2").attr("disabled", false);
		
		$("#validPd").val("");
		$("#cn").val("");
		$("#alwncVcatn").val("");
	}

	function fn_save(){

		if($("#vcatnGbnName").val() == null || $("#vcatnGbnName").val() == ""){
			alert("특별휴가 구분을 선택해주세요.");
			return false;
		}

		var applyW = "N";
		var applyM = "N";
		var applyC = "N";
		if($("#applyW").is(":checked")){
			applyW = "Y"
		}
		if($("#applyM").is(":checked")){
			applyM = "Y"
		}
		if($("#applyC").is(":checked")){
			applyC = "Y"
		}

		var cnIndictYn = "N";
		var validPdYn = "N";
		var aftfatMntYn = "N";
		var aftfatMntMth;
		var aftfatMntFrmtName;
        var cTikeycode;
		var validPd;
		var validPdUnit;
		if($("#cnIndictYn").is(":checked")){
			cnIndictYn = "Y"
		}
		if($("#validPdYn").is(":checked")){
			validPdYn = "Y";
			validPd = $("#validPd").val()
			validPdUnit = $("#validPdUnit option:selected").val();
		} else {
			validPd;
			validPdUnit;
		}
		if($("#aftfatMntYn").is(":checked")){
			aftfatMntYn = "Y";
			aftfatMntMth = $("#aftfatMntMth option:selected").val();
			aftfatMntFrmtName = $("#aftfatMntFrmtName option:selected").text();
            cTikeycode = $("#aftfatMntFrmtName option:selected").val();
		} else {
			aftfatMntMth = null;
			aftfatMntFrmtName = null;
		}

		var data = {
			vcatnGbnCmmnCd : $("#vcatnGbnCmmnCd").val(),
			vcatnKndSn : $("#vcatnGbnName").val(),
			payYn : $("#payYn").val(),
			applyW : applyW,
			applyM : applyM,
			applyC : applyC,
			alwncVcatn : $("#alwncVcatn").val(),
			alwncVcatnUnit : $("#alwncVcatnUnit option:selected").val(),
			alwncVcatnBase : $("#alwncVcatnBase option:selected").val(),
			cnIndictYn : cnIndictYn,
			cn : $("#cn").val(),
            cTikeycode : cTikeycode,
			validPd : validPd,
			validPdYn : validPdYn,
			validPdUnit : validPdUnit,
			aftfatMntYn : aftfatMntYn,
			aftfatMntMth : aftfatMntMth,
			aftfatMntFrmtName : aftfatMntFrmtName
		}

		$.ajax({
			url : _g_contextPath_+"/enrollment/specialVacSetIns",
			data : data,
			type : "post",
			dataType: "json",
			success:function(){
				location.reload();
			}
		});
	}

	function speclModPop(){
		var myWindow2 = $("#specialPop");
		undo2 = $("#btnMod");
		undo2.click(function() {

			if(!$(".checkbox").is(':checked')){
				alert("체크여부를 확인해주세요.");
				return false;
			}

			if($("input:checkbox[class=checkbox]:checked").length > 1){
				alert("1개 이상 체크되어 있습니다.");
				return false;
			}

			if($("input:checkbox[class=checkbox]:checked").length == 0){
				alert("수정할 데이터를 체크해주세요.");
				return false;
			}

			if($("input:checkbox[class=checkbox]:checked").length == 1){
				var data = {
					speclVcatnSetupSn : $("input:checkbox[class=checkbox]:checked").val(),
				};

				$.ajax({
					url : _g_contextPath_+"/enrollment/specialSelectRow",
					data: data,
					dataType : "json",
					type : "post",
					success : function (rs){
						var e = rs.rs;
						console.log(e);
						dataSet2(e);
					}
				});
			}

			myWindow2.data("kendoWindow").open();
			// versionCal();
			undo2.fadeOut();
		});

		function onClose3() {
			undo2.fadeIn();

		}
		$("#specialPopCancle").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
			width : "615",
			height : "400px",
			visible : false,
			modal: true,
			actions : [ "Close" ],
			close : onClose3
		}).data("kendoWindow").center();
	}

	function fn_del(){
		if(!$(".checkbox").is(':checked')){
			alert("체크여부를 확인해주세요.");
			return false;
		}

		$(".checkbox").each(function(){
			if($(this).is(":checked")){
				var data = {
					speclVcatnSetupSn : this.value,
				};

				$.ajax({
					url : "<c:url value='/enrollment/spVacationDel'/>",
					data : data,
					type : "post",
					dataType : "json",
					success : function(rs){
						mainGrid();
					}
				});
			}
		});
	}

	function dataSet(e){
		var vcatnGbnName = $("#vcatnGbnName").data("kendoComboBox");
		var payYn = $("#payYn").data("kendoComboBox");
		var alwncVcatnUnit = $("#alwncVcatnUnit").data("kendoComboBox");
		var alwncVcatnBase = $("#alwncVcatnBase").data("kendoComboBox");
		var validPdUnit = $("#validPdUnit").data("kendoComboBox");
		var aftfatMntMth = $("#aftfatMntMth").data("kendoComboBox");
		var aftfatMntFrmtName = $("#aftfatMntFrmtName").data("kendoComboBox");

		vcatnGbnName.value(e.VCATN_KND_SN);
		payYn.value(e.PAY_YN);
		alwncVcatnUnit.value(e.ALWNC_VCATN_UNIT);
		alwncVcatnBase.value(e.ALWNC_VCATN_BASE);
		validPdUnit.value(e.VALID_PD_UNIT);
		aftfatMntMth.value(e.AFTFAT_MNT_MTH);
		aftfatMntFrmtName.text(e.AFTFAT_MNT_FRMT_NAME);

		$(".checkVal").attr("disabled", false);
		if(e.APPLY_W == "Y"){
			$("input:checkbox[id=applyW]").prop("checked", true);
			$(".checkVal").not("#applyW").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyW]").prop("checked", false);
		}

		if(e.APPLY_M == "Y"){
			$("input:checkbox[id=applyM]").prop("checked", true);
			$(".checkVal").not("#applyM").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyM]").prop("checked", false);
		}

		if(e.APPLY_C == "Y"){
			$("input:checkbox[id=applyC]").prop("checked", true);
			$(".checkVal").not("#applyC").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyC]").prop("checked", false);
		}

		if(e.CN_INDICT_YN == "Y"){
			$("input:checkbox[id=cnIndictYn]").prop("checked", true);
		} else {
			$("input:checkbox[id=cnIndictYn]").prop("checked", false);
		}

		if(e.VALID_PD_YN == "Y"){
			$("input:checkbox[id=validPdYn]").prop("checked", true);
		} else {
			$("input:checkbox[id=validPdYn]").prop("checked", false);
		}

		if(e.VALID_PD_YN == "Y"){
			$("input:checkbox[id=validPdYn]").prop("checked", true);
		} else {
			$("input:checkbox[id=validPdYn]").prop("checked", false);
		}

		if(e.AFTFAT_MNT_YN == "Y"){
			$("input:checkbox[id=aftfatMntYn]").prop("checked", true);
		} else {
			$("input:checkbox[id=aftfatMntYn]").prop("checked", false);
		}



		$("#validPd").val(e.VALID_PD);
		$("#cn").val(e.CN);
		$("#alwncVcatn").val(e.ALWNC_VCATN);

	}

	function dataSet2(e){
		var vcatnGbnName = $("#vcatnGbnName2").data("kendoComboBox");
		var payYn = $("#payYn2").data("kendoComboBox");
		var alwncVcatnUnit = $("#alwncVcatnUnit2").data("kendoComboBox");
		var alwncVcatnBase = $("#alwncVcatnBase2").data("kendoComboBox");
		var validPdUnit = $("#validPdUnit2").data("kendoComboBox");
		var aftfatMntMth = $("#aftfatMntMth2").data("kendoComboBox");
		var aftfatMntFrmtName = $("#aftfatMntFrmtName2").data("kendoComboBox");

		vcatnGbnName.value(e.vcatnKndSn);
		payYn.value(e.payYn);
		alwncVcatnUnit.value(e.alwncVcatnUnit);
		alwncVcatnBase.value(e.alwncVcatnBase);
		validPdUnit.value(e.validPdUnit);
		aftfatMntMth.value(e.aftfatMntMth);
		aftfatMntFrmtName.text(e.aftfatMntFrmtName);

		$(".checkVal2").attr("disabled", false);
		if(e.applyW == "Y"){
			$("input:checkbox[id=applyW2]").prop("checked", true);
			$(".checkVal2").not("#applyW2").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyW2]").prop("checked", false);
		}

		if(e.applyM == "Y"){
			$("input:checkbox[id=applyM2]").prop("checked", true);
			$(".checkVal2").not("#applyM2").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyM2]").prop("checked", false);
		}

		if(e.applyC == "Y"){
			$("input:checkbox[id=applyC2]").prop("checked", true);
			$(".checkVal2").not("#applyC2").attr("disabled", true);
		} else {
			$("input:checkbox[id=applyC2]").prop("checked", false);
		}

		if(e.cnIndictYn == "Y"){
			$("input:checkbox[id=cnIndictYn2]").prop("checked", true);
		} else {
			$("input:checkbox[id=cnIndictYn2]").prop("checked", false);
		}

		if(e.validPdYn == "Y"){
			$("input:checkbox[id=validPdYn2]").prop("checked", true);
		} else {
			$("input:checkbox[id=validPdYn2]").prop("checked", false);
			validPdUnit.enable(false);
		}

		if(e.aftfatMntYn == "Y"){
			$("input:checkbox[id=aftfatMntYn2]").prop("checked", true);
		} else {
			$("input:checkbox[id=aftfatMntYn2]").prop("checked", false);
			aftfatMntMth.enable(false);
			aftfatMntFrmtName.enable(false);
		}



		$("#validPd2").val(e.validPd);
		$("#cn2").val(e.cn);
		$("#alwncVcatn2").val(e.alwncVcatn);
	}

	function specialUpdate(){
		if($("#vcatnGbnName2").val() == null || $("#vcatnGbnName2").val() == ""){
			alert("특별휴가 구분을 선택해주세요.");
			return false;
		}

		var applyW2 = "N";
		var applyM2 = "N";
		var applyC2 = "N";
		if($("#applyW2").is(":checked")){
			applyW2 = "Y"
		}
		if($("#applyM2").is(":checked")){
			applyM2 = "Y"
		}
		if($("#applyC2").is(":checked")){
			applyC2 = "Y"
		}

		var cnIndictYn2 = "N";
		var validPdYn2 = "N";
		var aftfatMntYn2 = "N";
		var aftfatMntMth2;
		var aftfatMntFrmtName2;
		var cTikeycode2;
		var validPd2;
		var validPdUnit2;
		if($("#cnIndictYn2").is(":checked")){
			cnIndictYn2 = "Y"
		}
		if($("#validPdYn2").is(":checked")){
			validPdYn2 = "Y";
			validPd2 = $("#validPd2").val()
			validPdUnit2 = $("#validPdUnit2 option:selected").val();
		} else {
			validPd2;
			validPdUnit2;
		}
		if($("#aftfatMntYn2").is(":checked")){
			aftfatMntYn2 = "Y";
			aftfatMntMth2 = $("#aftfatMntMth2 option:selected").val();
			aftfatMntFrmtName2 = $("#aftfatMntFrmtName2 option:selected").text();
			cTikeycode2 = $("#aftfatMntFrmtName2 option:selected").val();
		} else {
			aftfatMntMth2 = null;
			aftfatMntFrmtName2 = null;
		}

		if($("input:checkbox[class=checkbox]:checked").length == 1){
			var data = {
				speclVcatnSetupSn : $("input:checkbox[class=checkbox]:checked").val(),
				vcatnGbnCmmnCd : $("#vcatnGbnCmmnCd2").val(),
				vcatnKndSn : $("#vcatnGbnName2").val(),
				payYn : $("#payYn2").val(),
				applyW : applyW2,
				applyM : applyM2,
				applyC : applyC2,
				alwncVcatn : $("#alwncVcatn2").val(),
				alwncVcatnUnit : $("#alwncVcatnUnit2 option:selected").val(),
				alwncVcatnBase : $("#alwncVcatnBase2 option:selected").val(),
				cnIndictYn : cnIndictYn2,
				cn : $("#cn2").val(),
				cTikeycode : cTikeycode2,
				validPd : validPd2,
				validPdYn : validPdYn2,
				validPdUnit : validPdUnit2,
				aftfatMntYn : aftfatMntYn2,
				aftfatMntMth : aftfatMntMth2,
				aftfatMntFrmtName : aftfatMntFrmtName2
			};

			$.ajax({
				url : _g_contextPath_+"/enrollment/specialUpd",
				data : data,
				dataType : "json",
				type : "post",
				success:function(rs){
					location.reload();
				}
			});
		}
	}

</script>