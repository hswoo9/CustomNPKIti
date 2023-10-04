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
			<h4>외출/복귀</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">외출/복귀 조회</p>
		<div class="top_box">
			<dl style="height: 40px;">
				<dt class="ar" style="width: 65px">날짜</dt>
				<dd>
					<input type="text" value="" id="startDt" class="w113"/>
					&nbsp;~&nbsp;
					<input type="text" value="" id="endDt"	class="w113" />
				</dd>
				<dt  class="ar" style="width:65px" >부서</dt>
				<dd>
					<input id="deptListBox" class="select-box">
					<input type="hidden" name="request_dept_name">
				</dd>
				<dt class="ar" style="width: 65px">성명</dt>
				<dd>
					<input type="text" id="empName" disabled="disabled" value="" />
					<input type="hidden" id="userSeq" disabled="disabled" value="" />
					<input type="hidden" id="deptName2" value="" />
				</dd>
				<dd>
					<input type="button" id="emp" value="검색" />
				</dd>
			</dl>
		</div>

		<div class="btn_div" style="margin-top: 20px;">
			<div class="left_div">
				<p class="tit_p mt5 mb0">외출/복귀 리스트</p>
			</div>

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="" onclick="gridReload()">조회</button>
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

<div class="pop_wrap_dir" id="infoModPop" style="width: 430px; height: 400px; display: none;">
	<div class="pop_head">
		<h1>시간 조정</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="3">외출신청일자</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="oTargetDate" readonly/>
						</span>
					</td>
				</tr>
				<tr>
					<th colspan="3">외출신청시간</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="oOutTime" readonly/>
						</span>
					</td>
				</tr>
				<tr>
					<th colspan="3">복귀신청시간</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="oReturnTime" readonly />
						</span>
					</td>
				</tr>
			</table>
			<p style=" margin: 10px 0 5px; font-weight: bold;">변경 후</p>
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="3">변경 복귀시간</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="returnDatePicker" name="out_time" class="inputFrm"/>
							<input id="returnTimePicker" name="out_time" class="inputFrm"/>
						</span>
					</td>
				</tr>
				<tr>
					<th colspan="3">상태</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input type="radio" id="normal" name="status" value="정상" /> 정상
							<input type="radio" id="over" name="status" value="초과" /> 초과
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="popRegister" value="등록" />
			<input type="button" class="gray_btn" id="outInfoPopCancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<%-- 사원검색 --%>
<input type="hidden" id="userSeq" value=""/>

<div class="pop_wrap_dir" id="popUp2" style="width: 600px;">
	<div class="pop_head">
		<h1>사원 리스트</h1>

	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" style="width: 120px" />
				</dd>
				<dt>부서</dt>
				<dd>
					<input type="text" id="dept_name" style="width: 180px" /> <input
						type="button" onclick="empGridReload();" id="searchButton"
						value="검색" />
				</dd>
			</dl>
		</div>
		<div class="com_ta mt15" style="">
			<div id="empGrid"></div>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">

			<input type="button" class="gray_btn" id="cancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->


<script type="text/javascript">

	console.log('${loginVO}');

	$(function() {
		var date = new Date(), y = date.getFullYear(), m = date.getMonth();
		var firstDay = new Date(y, m, 1);
		var lastDay = new Date(y, m + 1, 0);
		$("#startDt").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value: firstDay
		});
		$("#endDt").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value : lastDay
		});

		$("#startDt").attr("readonly", true);
		$("#endDt").attr("readonly", true);

		//팝업창 복귀 날짜/시간 선택
		$("#returnDatePicker").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
		});
		$("#returnTimePicker").kendoTimePicker({
			culture: "kr-KR",
			value: new Date(),
			format: "HH:mm",
			interval: 1
		});

		$("#oTargetDate").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
		}).attr("disabled", true).data("kendoTimePicker");

		$("#oOutTime").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			interval: 30
		}).attr("disabled", true).data("kendoTimePicker");

		$("#oReturnTime").kendoTimePicker({
			culture: "kr-KR",
			format: "HH:mm",
			interval: 30,
		}).attr("disabled", true).data("kendoTimePicker");

		mainGrid();

	});


	var dataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : "<c:url value='/enrollment/outReturnListAdmin'/>",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.empSeq = $('#userSeq').val();
				data.deptName = $("[name='request_dept_name']").val();
				data.to = $("#startDt").val();
				data.from = $("#endDt").val();

				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				record = response.list.length;

				return record;
			}
		}
	});

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

	function mainGrid() {
		//캔도 그리드 기본
		var grid = $("#grid").kendoGrid(
				{
					dataSource : dataSource,
					height : 550,
					dataBound : function(e) {
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
							field: "EMP_NAME",
							title: "사용자명",
							width: 50
						}, {
							field : "ORI_TARGET_DATE",
							title : "일자",
							width : 50
						}, {
							field : "ORI_OUT_TIME",
							title : "시작시간",
							width : 50
						}, {
							field : "ORI_RETURN_TIME",
							title : "종료시간",
							width : 50
						}, {
							field : "OUT_TIME",
							title : "총 신청시간",
							width : 50
						}, /*{
                            field : "ORI_UPDT_DGRE",
                            title : "수정차수",
                            width : 100
                        }, */
						{
							field : "VCATN_RET_TIME",
							title : "실제 복귀시간",
							width : 50
						},{
							field : "STATUS",
							title : "기타",
							width : 50,
							template: function(dataItem){
								if(dataItem.STATUS == "초과"){
									return "<div style=\"color: red;\">" + dataItem.STATUS + "</div>";
								} else if (dataItem.STATUS == "정상"){
									return "<div style=\"color: blue;\">" + dataItem.STATUS + "</div>";
								} else {
									return "";
								}
							}
						},{
							field: "",
							title: "조정",
							width: 50,
							template: function (dataItem){
								return '<div class="controll_btn p0" style="text-align: center;"><button type="button" id="" onclick="updReturnInfo(' + dataItem.ORI_ID + ');">시간 조정</button></div>';
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
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
				console.log(record);
			});

		}
	}

	function gridReload() {
		$('#grid').data('kendoGrid').dataSource.read();
	}

	//수정팝업
	var myWindow2 = $("#infoModPop");
	function updReturnInfo(pk){
		myWindow2.data("kendoWindow").open();
		$.getJSON(_g_contextPath_ + '/enrollment/outReturnModPop',
				{'oriId': pk},
				function(jj){
					$("#infoModPop").find('[class="inputFrm"]').show();
					console.log(jj.obj);
					$("#oTargetDate").val(jj.obj.ORI_TARGET_DATE);
					$("#oOutTime").val(jj.obj.ORI_OUT_TIME);
					$("#oReturnTime").val(jj.obj.ORI_RETURN_TIME);
					$("#returnDatePicker").val(jj.obj.VCATN_RET_DATE);
					$("#returnTimePicker").val(jj.obj.VCATN_RET_TIME);
					if(jj.obj.STATUS == "초과"){
						$("#over").prop("checked", true);
					} else if (jj.obj.STATUS == "정상"){
						$("#normal").prop("checked", true);
					}
					$(document).off('click').on('click', "[id='popRegister']", function(){
						var data = new FormData();
						data.append('oriId', jj.obj.ORI_ID);
						data.append('returnTime', $("#returnDatePicker").val() + " " + $("#returnTimePicker").val() + ":00");
						data.append('modEmpSeq', <c:out value='${loginVO.empSeq}'/>);
						data.append('status', $('input[name=status]:checked').val());
						$.ajax({
							url: _g_contextPath_ + '/enrollment/UpdOutReturnTimeInfo',
							type: 'post',
							dataType: 'json',
							data: data,
							contentType: false,
							processData: false,
							success: function(){
								alert("수정되었습니다.");
								myWindow2.data("kendoWindow").close();
								gridReload();
							}
						});
					});
				});

	};
	myWindow2.kendoWindow({
		width: "430px",
		visible: false,
		modal: true,
		actions: [
			"Close"
		],
		close: function(){

		}
	}).data("kendoWindow").center();
	//end

	$(document).ready(function() {

		/*
            부서목록 - KendoComboBox(#deptListBox)
        */
		var comboBox = $("#deptListBox").kendoComboBox({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: _g_contextPath_+ '/common/getDeptList',
						dataType: 'json',
						type: 'post'
					},
					parameterMap: function(data, operation){
						return data;
					}
				},
				schema: {
					data: function(response){
						response.allDept.unshift({dept_name: "전체", dept_seq: ""});
						return response.allDept;
					}
				}
			}),
			dataTextField: 'dept_name',
			dataValueField: 'dept_seq',
			change: function(e){
				var rows = comboBox.select();
				var record = comboBox.dataItem(rows);
				//console.log(record);
				$("[name='request_dept_name']").val(record.dept_name);
				$("[name='request_dept_name2']").val(record.dept_name);
			},
			index: 0,
			open: function(e){
				$("#empName").val("");
				$("#userSeq").val("");
			}
		}).data("kendoComboBox");

		$('.sub_contents_wrap .top_box input[type=text]').on('keypress', function(e) {
			if (e.key == 'Enter') {
				searchBtn();
			};
		});

		$('#popUp2 .top_box input[type=text]').on('keypress', function(e) {
			if (e.key == 'Enter') {
				empGridReload();
			};
		});
	});
	function gridDataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.total() == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

	function searchBtn() {
		gridReload();
		$('#headerCheckbox').prop('checked', false);
		$('#userSeq').val('');
		$('#empName').val('');

	}
	$(document).on('click', '#searchBtn', function(){
		gridReload();
		$('#userSeq').val('');
		$('#empName').val('');
	});
	/* 부서선택시 사원선택 그리드 처리 */
	function deptList(e) {
		var seq = $(e).val();
		console.log($('#deptName option:selected').text());
		$('#deptSeq').val(seq);
		$('#deptName2').val($('#deptName option:selected').text());
		empGridReload();

	}

	$(document).ready(function() {
		var myWindow99 = $("#popUp2");
		undo2 = $("#emp, #emp2");

		undo2.click(function() {
			empGrid();
			myWindow99.data("kendoWindow").open();
			undo2.fadeOut();
		});

		function onClose2() {
			$('#emp_name').val('');
			$('#dept_name').val('');
			empGridReload();
			undo2.fadeIn();

		}
		$("#cancle").click(function() {
			myWindow99.data("kendoWindow").close();
		});
		myWindow99.kendoWindow({
			width : "600px",
			height : "665px",
			visible : false,
			modal : true,
			actions : [ "Close" ],
			close : onClose2
		}).data("kendoWindow").center();

	});
	/* 사원팝업 kendo 그리드 */
	var empDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : _g_contextPath_+'/common/empInformation',
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.deptSeq = $("#deptListBox").val(); //$('#deptSeq').val();
				data.emp_name = $('#emp_name').val();
				data.dept_name = $('#dept_name').val();
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
			}
		}
	});

	/* 사원팝업 kendo 그리드 refresh */
	function empGridReload() {
		/* $('#empGrid').data('kendoGrid').dataSource.read(); */
		$("#empGrid").data("kendoGrid").dataSource.page(1);
	}

	/* 사원팝업 kendo 그리드 */
	function empGrid() {
		//캔도 그리드 기본
		var empGrid = $("#empGrid").kendoGrid({
			dataSource : empDataSource,
			height : 460,

			pageable : {
				refresh : true,
				pageSizes : true,
				buttonCount : 5
			},
			persistSelection : true,
			selectable : "multiple",
			columns : [
				/* { template: "<input type='checkbox' class='checkbox'/>"
                ,width:50,
                }, */
				{
					field : "emp_name",
					title : "이름",

				},
				{

					field : "dept_name",
					title : "부서",

				},
				{
					field : "position",
					title : "직급",

				},
				{
					field : "duty",
					title : "직책",

				},
				{
					title : "선택",
					template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
				}
			],
			change : function(e) {
				empGridClick(e)
			}
		}).data("kendoGrid");

		empGrid.table.on("click", ".checkbox", selectRow);

		var checkedIds = {};

		// on click of the checkbox:
		function selectRow() {

			var checked = this.checked, row = $(this).closest("tr"), empGrid = $(
					'#empGrid').data("kendoGrid"), dataItem = grid
					.dataItem(row);

			checkedIds[dataItem.emp_seq] = checked;
			if (checked) {
				//-select the row
				row.addClass("k-state-selected");
			} else {
				//-remove selection
				row.removeClass("k-state-selected");
			}

		}
		function empGridClick() {
			var rows = empGrid.select();
			var record;
			rows.each(function() {
				record = empGrid.dataItem($(this));
			});
			subReload(record);
		}
	}

	function subReload(record) {

		$('#use_emp_seq').val(record.emp_seq);
		$('#empDept').val(record.dept_name);
		$('#empName').val(record.emp_name);

	}
	/* 사원 선택 기능 */
	function empSelect(e) {
		var row = $("#empGrid").data("kendoGrid").dataItem($(e).closest("tr"));
		$('#empName').val(row.emp_name);
		$('#userSeq').val(row.emp_seq);
		$('[name="userSeq2"]').val(row.emp_seq);
		$('#deptName2').val(row.dept_name);
		$('#popUp2').data("kendoWindow").close();
	}
</script>
