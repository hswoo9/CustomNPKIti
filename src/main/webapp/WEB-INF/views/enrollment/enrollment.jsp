<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>


<style type="text/css">
.k-header .k-link {
	text-align: center;
}

.k-grid-content>table>tbody>tr {
	text-align: center;
}

.k-grid th.k-header, .k-grid-header {
	background: #F0F6FD;
}

.k-dropdown-wrap.k-state-default {
	overflow: hidden;
}

select {
	height:24px;
	border:1px solid #c3c3c3;
	padding-left:7px;
	padding-right:20px;
	color:#515967;
	-webkit-appearance: none;  /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
	background:#fff url("../Images/ico/sele_arw01.png") no-repeat right center;
}
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>휴가 종류 등록</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">휴가 종류 등록</p>
		<div class="top_box">
			<dl style="height: 40px;">
				<dt class="ar" style="width: 65px">구분</dt>
				<dd>
					<select style="width: 120px; height: 24px;" id="vcatnGbnName"
						name="vcatnGbnName">
						<optgroup label="휴가구분">
						</optgroup>
					</select> <input type="text" id="vcatnKndName" name="vcatnKndName"
						placeholder="휴가명" />
				</dd>
				<dt class="ar" style="width: 65px">사용단위</dt>
				<dd>
					<select style="width: 80px; height: 24px;" id="useUnit"
						name="useUnit">
						<option value="HOUR">시간</option>
						<option value="MIN">분</option>
					</select>
				</dd>
				<!-- <dt class="ar" style="width: 65px">기본값(일)</dt>
				<dd>
					<input type="text" id="bsicVal" name="bsicVal" value="0" />
				</dd> -->
			</dl>
			<dl>
				<dt class="ar" style="width: 65px">비고</dt>
				<dd>
					<input type="text" id="rmk" name="rmk" style="width: 660px;" />
				</dd>
			</dl>
		</div>

		<div class="btn_div" style="margin-top: 20px;">
			<div class="left_div">
				<p class="tit_p mt5 mb0">휴가종류</p>
			</div>

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="btnSave">등록</button>
					<button type="button" id="btnMod">수정</button>
					<button type="button" id="btnDel">삭제</button>
				</div>
			</div>
		</div>

		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

<div class="pop_wrap_dir" id="enrollPop"
	style="width: 430px; height: 380px;" hidden>
	<div class="pop_head">
		<h1>휴가종류 수정</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="3">구분</th>
					<td style="width: 75%;" class="le"><input type="hidden"
						id="vcatnKndSn2" name="vcatnKndSn2" /> <select
						style="width: 120px; height: 24px;" id="vcatnGbnName2"
						name="vcatnGbnName2">
							<optgroup label="휴가구분">
							</optgroup>
					</select></td>
				</tr>
				<tr>
					<th colspan="3">휴가명</th>
					<td class="le"><input type="text" name="vcatnKndName2"
						id="vcatnKndName2" value="" style="width: 100%;" /></td>
				</tr>
				<tr>
					<th colspan="3">사용단위</th>
					<td class="le"><select style="width: 80px; height: 24px;"
						id="useUnit2" name="useUnit2">
							<option value="HOUR">시간</option>
							<option value="MIN">분</option>
					</select></td>
				</tr>
				<tr>
					<th colspan="3">기본값(일)</th>
					<td class="le"><input type="text" name="bsicVal2"
						id="bsicVal2" value="" style="width: 40%;" /></td>
				</tr>
				<tr>
					<th colspan="3">비고</th>
					<td class="le"><input type="text" name="rmk2" id="rmk2"
						value="" style="width: 100%;" /></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="popRegister"
				onclick="enrollUpdate();" value="등록" /> <input type="button"
				class="gray_btn" id="enrollPopCancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->
<script type="text/javascript">
	$(function() {
		fn_codeListComboBoxInit('vcatnGbnName');
		fn_codeListComboBoxInit('vcatnGbnName2');
		mainGrid();
		
		$("#btnSave")
				.click(
						function() {

							if ($("#vcatnGbnName option:selected").val() == ""
									|| $("#vcatnGbnName option:selected").val() == null) {
								alert("휴가 구분을 선택해주세요.");
								return;
							}

							if ($("#vcatnKndName").val() == ""
									|| $("#vcatnKndName").val() == null) {
								alert("휴가명을 입력해주세요.");
								return;
							}

							fn_save();
						});

		$("#checkboxAll").click(function(e) {
			if ($("#checkboxAll").is(":checked")) {
				$(".checkbox").prop("checked", true);
			} else {
				$(".checkbox").prop("checked", false);
			}
		});

		$("#btnDel").click(function() {
			fn_del();
		});

		enrollModPop();
	});

	var dataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : "<c:url value='/enrollment/enrollList'/>",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.group_code_kr = $('#searchGCode').val();
				data.empSeq = $('#use_emp_seq').val();
				data.code_kr = $('#searchCode').val();
				var vcatnGbnCmmnCd = $("#vcatnGbnName option:selected").val();
				var vcatnType = "";
				for(var i = 0 ; i < codeList.length ; i++){
					if(Number(codeList[i].common_code_id) == Number(vcatnGbnCmmnCd)){
						vcatnType = codeList[i].remark;
					}
				}
				data.vcatnType = vcatnType;
				data.notIn = '';
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				return response.list.length;
			},
			model : {
				fields : {

					weekDay : {
						type : "string"
					},

				}
			}
		}
	});
	/* 토요일 일요일 그리드 색깔 처리 함수 */
	function fn_weekDay(row) {
		var key = row.weekDay;

		switch (key) {
		case '토':
			return '<span style="color:blue">' + key + '</span>';
			break;
		case '일':
			return '<span style="color:red">' + key + '</span>';
			break;
		default:
			return '<span>' + key + '</span>';
			break;
		}

	}
	function fn_workStep(row) {
		var step = row.replace_holi_step;
		switch (step) {
		case 'OS01':
			return '<input type="button" id="" class="text_blue" onclick="replaceHoliCancle(this);" value="신청취소">';
			break;
		default:
			return '';
			break;
		}
	}

	/* 데이터 없을 시 첫번째 그리드 처리 함수 */
	function gridDataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.data.length == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append(
							'<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

	/* 데이터 없을 시 두번째 그리드 처리 함수 */
	function grid2DataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.total() == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append(
							'<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

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
	}//fitColumns

	kendo.ui.Grid.fn.expandToFit = function() {
		var $gridHeaderTable = this.thead.closest('table');
		var gridDataWidth = $gridHeaderTable.width();
		var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap')
				.innerWidth();
		// Since this is called after column auto-fit, reducing size
		// of columns would overflow data.
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
	}//expandToFit

	function gridReload() {
		$('#grid').data('kendoGrid').dataSource.read();
	}

	function mainGrid() {
		//캔도 그리드 기본
		var grid = $("#grid")
				.kendoGrid(
						{
							dataSource : dataSource,
							height : 550,
							dataBound : function(e) {
								this.fitColumns();
								gridDataBound(e);
							},
							sortable : true,
							pageable : {
								refresh : true,
								pageSizes : [ 10, 20, 30, 50, 100 ],
								buttonCount : 5
							},
							persistSelection : true,
							selectable : "multiple",
							columns : [
									{
										headerTemplate : "<input type='checkbox' id='checkboxAll' />",
										template : function(e) {
											return '<input type="checkbox" id = "checkbox'+e.VCATN_KND_SN+'" class = "checkbox" value="'+e.VCATN_KND_SN+'">';
										}
									}, {
										field : "VCATN_GBN_NAME",
										title : "구분",

									}, {
										field : "VCATN_KND_NAME",
										title : "휴가명",
										width : 100
									}, {
										field : "BSIC_VAL",
										title : "기본값(일)",
										width : 220
									}, {
										title : "사용단위",
										width : 220,
										template : function(e) {
											if (e.USE_UNIT == "HOUR") {
												return "시간";
											} else {
												return "분";
											}
										}
									}, {
										field : "RMK",
										title : "비고",
										width : 220
									}, ],
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
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
				console.log(record);
			});

		}
	}

	/* 대체휴무 신청현황 개인조회 리스트 */
	var reqDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : _g_contextPath_ + '/subHoliday/subHolidayReqList',
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.group_code_kr = $('#searchGCode').val();
				data.empSeq = $('#use_emp_seq').val();
				data.code_kr = $('#searchCode').val();
				data.notIn = '';
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				return response.totalCount;
			},
			model : {
				fields : {

					weekDay : {
						type : "string"
					},
					replace_holi_step : {
						type : "string"
					},

				}
			}
		}
	});

	function fn_codeListComboBoxInit(id) {
		if ($('#' + id)) {
			var codeList = fn_codeList();
			codeList.unshift({
				code_kr : '전체',
				common_code_id : ""
			});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : codeList,
				dataTextField : "code_kr",
				dataValueField : "common_code_id",
				index : 0,
				change : function() {
					fnDeptChange();
				}
			});
			$(".k-input").attr("readonly", "readonly");
		}
	}
	var codeList = new Array();
	function fn_codeList() {
		var result = {};
		var params = {
			"group_code" : "VACATION"
		};
		var opt = {
			url : "<c:url value='/commcode/getCommCodeList'/>",
			async : false,
			data : params,
			successFn : function(data) {
				result = data;
				codeList = [];
				codeList = result;
			}
		};
		acUtil.ajax.call(opt);
		return result;
	}
	function fnDeptChange() {
		var obj = $('#vcatnGbnName').data('kendoComboBox');
		gridReload();
	}

	function enrollModPop() {

		var myWindow2 = $("#enrollPop");
		undo2 = $("#btnMod");

		undo2.click(function() {

			if (!$(".checkbox").is(':checked')) {
				alert("체크여부를 확인해주세요.");
				return false;
			}

			if ($("input:checkbox[class=checkbox]:checked").length > 1) {
				alert("1개 이상 체크되어 있습니다.");
				return false;
			}

			if ($("input:checkbox[class=checkbox]:checked").length == 0) {
				alert("수정할 데이터를 체크해주세요.");
				return false;
			}

			if ($("input:checkbox[class=checkbox]:checked").length == 1) {
				var data = {
					vcatnKndSn : $("input:checkbox[class=checkbox]:checked")
							.val(),
				};

				$.ajax({
					url : _g_contextPath_ + "/enrollment/enrollSelectRow",
					data : data,
					dataType : "json",
					type : "post",
					success : function(rs) {
						var rs = rs.rs;
						console.log(rs);
						var kendoCombo = $("#vcatnGbnName2").data(
								"kendoComboBox");
						var codeId;
						/*
						
						if(rs != null){
							for(var i = 0 ; i < codeList.length ; i++){
								if(Number(codeList[i].common_code_id) == Number(rs.vcatnGbnCmmnCd)){
									codeId = Number(rs.vcatnGbnCmmnCd);
								}
							}
						}
						
						if (rs.vcatnGbnCmmnCd == 678) {
							kendoCombo.select(1);
						} else if (rs.vcatnGbnCmmnCd == 679) {
							kendoCombo.select(2);
						} else if (rs.vcatnGbnCmmnCd == 680) {
							kendoCombo.select(3);
						} else if (rs.vcatnGbnCmmnCd == 681) {
							kendoCombo.select(4);
						} else if (rs.vcatnGbnCmmnCd == 682) {
							kendoCombo.select(5);
						} else if (rs.vcatnGbnCmmnCd == 683) {
							kendoCombo.select(6);
						}
						*/
						if (rs.useUnit == 'HOUR') {
							$("#useUnit2").val("HOUR").prop("selected", true);
						} else {
							$("#useUnit2").val("MIN").prop("selected", true);
						}

						$("#vcatnKndName2").val(rs.vcatnKndName);
						$("#bsicVal2").val(rs.bsicVal);
						$("#rmk2").val(rs.rmk);
						$("#vcatnKndSn2").val(rs.vcatnKndSn);
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
		$("#enrollPopCancle").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
			width : "430px",
			height : "500px",
			visible : false,
			modal : true,
			actions : [ "Close" ],
			close : onClose3
		}).data("kendoWindow").center();
	}

	function fn_save() {
		var vcatnGbnCmmnCd = $("#vcatnGbnName option:selected").val();
		var vcatnType = "";
		for(var i = 0 ; i < codeList.length ; i++){
			if(Number(codeList[i].common_code_id) == Number(vcatnGbnCmmnCd)){
				vcatnType = codeList[i].remark;
			}
		}
		var data = {
			vcatnGbnName : $("#vcatnGbnName option:selected").text(),
			vcatnGbnCmmnCd : vcatnGbnCmmnCd,
			vcatnKndName : $("#vcatnKndName").val(),
			useUnit : $("#useUnit option:selected").val(),
			bsicVal : $("#bsicVal").val(),
			rmk : $("#rmk").val(),
			useYn : 'Y',
			vcatnType : vcatnType
		}
		$.ajax({
			url : _g_contextPath_ + "/enrollment/enrollSave",
			data : data,
			dataType : "json",
			type : "post",
			async : false,
			success : function(rs) {
				alert(rs.check.message);
				//fn_fieldReSet();
				mainGrid();
				console.log(rs.check.message);
				$("#vcatnKndName").val('');
				$("#rmk").val('');
			}
		});
	}

	function enrollUpdate() {
		var vcatnGbnCmmnCd = $("#vcatnGbnName2 option:selected").val();
		if(vcatnGbnCmmnCd == null || vcatnGbnCmmnCd == ''){
			alert("선택된 구분이 없습니다.");
			return;
		}
		var vcatnType = "";
		for(var i = 0 ; i < codeList.length ; i++){
			if(Number(codeList[i].common_code_id) == Number(vcatnGbnCmmnCd)){
				vcatnType = codeList[i].remark;
			}
		}
		var data = {
			vcatnKndSn : $("#vcatnKndSn2").val(),
			vcatnGbnName : $("#vcatnGbnName2 option:selected").text(),
			vcatnGbnCmmnCd : $("#vcatnGbnName2 option:selected").val(),
			vcatnKndName : $("#vcatnKndName2").val(),
			useUnit : $("#useUnit2 option:selected").val(),
			bsicVal : $("#bsicVal2").val(),
			rmk : $("#rmk2").val(),
			vcatnType : vcatnType,
			useYn : 'Y'
		}

		$.ajax({
			url : _g_contextPath_ + "/enrollment/enrollMod",
			data : data,
			dataType : "json",
			type : "post",
			async : false,
			success : function() {

				location.reload();
			}
		});
	}

	function fn_del() {
		if (!$(".checkbox").is(':checked')) {
			alert("체크여부를 확인해주세요.");
			return false;
		}

		$(".checkbox").each(function() {
			if ($(this).is(":checked")) {
				var data = {
					vcatnKndSn : $(this).val(),
				};

				$.ajax({
					url : _g_contextPath_ + "/enrollment/enrollDel",
					data : data,
					dataType : "json",
					type : "post",
					async : false,
					success : function() {
						//fn_fieldReSet();
						mainGrid();
					}
				});
			}
		});

	}
	function fn_fieldReSet() {
		fn_codeListComboBoxInit('vcatnGbnName');
		fn_codeListComboBoxInit('vcatnGbnName2');
		var kendoCombo = $("#vcatnGbnName").data("kendoComboBox");
		kendoCombo.select(0);
		$("#rmk").val("");
		$("#bsicVal").val("5");
		$("#vcatnKndName").val("");
	}
</script>