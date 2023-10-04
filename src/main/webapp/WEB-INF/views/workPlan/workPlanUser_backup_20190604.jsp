<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>

<html>

<style>
table tr td {text-align: center;}
</style>
<body>
<div class="ifram_wrap" style="min-width: 1070px;">
	<div class="btn_div mt10 cl">
		<div class="left_div">
			<p class="tit_p mt5 mb0">개인 유연근무 조회</p>
		</div>
	</div>
	<div class="sub_contents_wrap">
		<div class="com_ta">
			<div class="top_box">
				<dl>
					<dt style="width: 35px;">
						년월
					</dt>
					<dd>
						<input type="text" id="searchDt" style="width: 100px; text-align: center;" onchange="setData();">
					</dd>
					<dt style="width: 65px; margin-left: 55px;">
						부서/이름
					</dt>
					<dd style="line-height: 25px;">
						<input type="text" id="empNm" value=" ${userInfo.orgnztNm} / ${userInfo.empName }" style="text-align: ;width: 180px" disabled="disabled">
						<input type="hidden" id="empSeq" value="${userInfo.empSeq }">

					</dd>
					<dt style="width:80px;">
						<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
						승인권자
					</dt>
					<dd>
						<input type="text" value="${getHeader.nameDuty }" 
						id="headerName" style="width:160px;" disabled="disabled">
						<input type="hidden" name="approval_emp_seq" value="${getHeader.emp_seq }">
						<input type="button" id="headerListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
					</dd>
				</dl>
				<dl>
					<dt style="width: 80px;">
						신청 유형
					</dt>
					<dd>
						<input id="planType" class="select-box" >
					</dd>
				</dl>
				<dl id="flexSelect" style="display:none;">
					<dt style="width: 80px;">
						탄력근무제
					</dt>
					<dd>
						<input id="flexType" class="select-box">
						<input type="hidden" name="flex_code_id">
					</dd>
				</dl>
				<dl id="flexTemplate" style="display:none;">
				</dl>
			</div>
			<br>
			<div class="btn_div mt10 cl">
				<div class="left_div">
					<p class="tit_p mt5 mb0" style="display: inline;">근무유형 변경&nbsp; </p>
					<select name="" id="work_type" class="" style="width: 160px"></select>
					
					<span class="controll_btn p0">
						<button type="button" id="" onclick="workTypeModify();">일괄변경</button>
					</span>
					
				</div>
				
				<div class="right_div">
					
					<p class="tit_p mt5 mb0" style="display: inline;">기본 근무유형&nbsp; </p>
					<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="checkIcon" />
					<select name="" id="default_work_type" class="" style="width: 160px"></select>
					<span class="controll_btn p0">
						<button type="button" id="defaultBtn" onclick="defaultMod();">기본근무유형 변경</button>
						<button type="button" id="" onclick="setData();">새로고침</button>
					</span>
					
				</div>
				
			</div>
			
			<table id="addTable">
				<colgroup>
					<col width="50px;">
					<col width="100px;">
					<col width="120px;">
					<col width="80px;">
					<col width="200px;">
					<col width="120px;">
					<col width="120px;">
					<col width="">
				</colgroup>
				<tbody id="addTbody">
				</tbody>
			</table>
		</div>
	
	</div>
	<!-- 승인권자 검색 팝업 -->
	<div class="pop_wrap_dir" id="headerListPop" style="width:600px;">
		<div class="pop_head">
			<h1>승인권자리스트</h1>
		</div>
		<div class="pop_con">
			<div class="top_box">
				<dl>
					<dt class="ar" style="width:65px;">성명</dt>
					<dd>
						<input type="text" id="header_name" class="grid_reload2" style="width:120px;">
					</dd>
					<dt>부서</dt>
					<dd>
						<input type="text" id="header_dept_name" class="grid_reload2" style="width:180px;">
						<input type="button" id="headerSearchBtn" value="검색">
					</dd>
				</dl>
			</div>
			<div class="com_ta mt15">
				<div id="gridHeaderList"></div>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" id="headerListPopClose" value="닫기">
			</div>
		</div>
	</div>	
</div>

<div style="display: none;">
	<input type="file" id="excelFile" onchange="excelFileChange(this);" accept=".xls, .xlsx">
</div>

<div id="addWorkPlanType" style="display: none;">
<select class="selectMenu addWorkPlanType" id="WK_PN_SEQ" onchange="selectType(this);" style="width: 90%;">
	<c:forEach items="${workPlanType }" var="list">
		<option value="${list.work_type_id }" data-s="${list.attend_time }" data-e="${list.leave_time }" data-m="${list.work_min }">${list.work_type }</option>
	</c:forEach>
</select>
</div>
<script id="flexTypeTemplate" type="text/template">
	<dt id="flexLable" style="width:80px;">
		asdasd
	</dt>
	<dd id="flexInput">
	</dd>
</script>
<script>
var test = '${userInfo}';
var monthLimit = '';
var weekLimit = {};

$(function(){
	/*
		탄력근무유형 - KendoComboBox(#flexType)
	*/
	var comboBox0 = $("#planType").kendoComboBox({
		dataSource: [
			{planTypeCode: 'normal', planType_kr: '일반'},
			{planTypeCode: 'flex', planType_kr: '탄력'}
		],
		dataTextField: 'planType_kr',
		dataValueField: 'planTypeCode',
		index: 0,
		change: function(e){
			if(this.value() === 'normal'){
				$("#flexSelect").hide();
				setData();
			}else if(this.value() === 'flex'){
				$("#flexSelect").show();
			}
		}
	});
	var comboBox = $("#flexType").kendoComboBox({
		dataSource: new kendo.data.DataSource({
			transport: {
				read: {
					url: _g_contextPath_+ '/subHoliday/getCommCodeList',
					dataType: 'json',
					type: 'post'
				},
				parameterMap: function(data, operation){
					data.group_code = 'FLEX_TYPE';
					return data;
				}
			},
			schema: {
				data: function(response){
					return response.list;
				}
			}
		}),
		dataTextField: 'code_kr',
		dataValueField: 'common_code_id',
		change: function(e){
			var rows = comboBox.select();
			var record = comboBox.dataItem(rows);
			//console.log(record);
			$("[name='flex_code_id']").val(record.common_code_id);
			
			$("#flexTemplate").empty();
			html = document.querySelector("#flexTypeTemplate").innerHTML;
			$("#flexTemplate").append(html);
			if(record.code === '3M'){
				$("#flexLable").html("진행 확인");
				var startMonth = parseInt($("#searchDt").val().split("-")[1]);
				var msg = "탄력근무제 신청 대상 기간은 ";
				for(var i=0;i<3;i++){
					if(i !== 2){
						msg += startMonth++ + "월, "
					}else{
						msg += startMonth++ + "월 입니다. 진행하시겠습니까?";
						msg += "<input type='button' id='flexOkBtn' class='file_input_button ml4 normal_btn2' value='확인'>";
					}
				}
				$("#flexInput").html(msg);
			}else if(record.code === '2W'){
				$("#flexLable").html("주차 선택");
				var selectObject = document.createElement("select");
				$(selectObject).addClass("weeks_select");
				for(var i=1;i<=5-1;i++){
					var option = document.createElement("option");
					option.text = i;
					option.value = i;
					selectObject.add(option);
				}
				$("#flexInput").append(selectObject);
			}
			$("#flexTemplate").show();
		}
	}).data("kendoComboBox");
	
	$(document).on('click', "#flexOkBtn", function(e){
		setFlexData();
	});
	
	$('#searchDt').kendoDatePicker({
    	culture : "ko-KR",
	    format : "yyyy-MM",
	    start: "year",
	    depth: "year",
	    value: new Date()
	});
	
	list = workTypeCodeList('all');
	list2 = workTypeCodeList('nAll');
	
	$("#work_type").kendoDropDownList({
	    dataTextField: "work_type",
	    dataValueField: "work_type_id",
	    dataSource: list2
	});
	
	$("#default_work_type").kendoDropDownList({
	    dataTextField: "work_type",
	    dataValueField: "work_type_id",
	    dataSource: list2
	});
	
	$("#searchDt").attr("readonly","readonly");
	
	var myWindow2 = $("#headerListPop"),
	undo2 = $("#headerListPopBtn");
	undo2.click(function(){
		myWindow2.data("kendoWindow").open();
		undo2.fadeOut();
		headerGrid();
	});
	
	getMonthLimit()
	
	$("#headerListPopClose").click(function(){
		myWindow2.data("kendoWindow").close();
	});
	myWindow2.kendoWindow({
		width: "600px",
		height: "665px",
		visible: false,
		modal: true,
		actions: [
			"Close"
		],
		close: function(){
			undo2.fadeIn();
			$("#header_name").val("");
			$("#header_dept_name").val("");
		}
	}).data("kendoWindow").center();
	
	function headerGridReload(){
		$("#gridHeaderList"/* popUpGrid2 */).data("kendoGrid").dataSource.read();
	}
	$("#headerSearchBtn").click(function(){
		headerGridReload();
	});
	$(document).on({
		'keyup': function(event){
			if(event.keyCode===13){//enterkey
				headerGridReload();
			}
		}
	},".grid_reload2");
	
	var headerGrid = function(){
		var grid = $("#gridHeaderList"/* popUpGrid2 */).kendoGrid({
			dataSource: new kendo.data.DataSource({
				serverPaging: true,
				pageSize: 10,
				transport: {
					read: {
						url: _g_contextPath_ + '/common/empInformation',
						dataType: 'json',
						type: 'post'
					},
					parameterMap: function(data, operation){
						data.deptSeq = '';//"${empInfo.deptSeq}";
						data.emp_name = $("#header_name").val();
						data.dept_name = $("#header_dept_name").val();
						data.notIn = '';
						return data;
					}
				},
				schema: {
					data: function(response){
						return response.list;
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
				pageSizes: true,
				buttonCount: 5
			},
			persistSelection: true,
			selectable: "multiple",
			columns: [{
				field: "emp_name",
				title: "이름",
				attributes: {
					style: "padding-left: 0 !important"
				}
			},{
				field: "dept_name",
				title: "부서"
			},{
				field: "position",
				title: "직급"
			},{
				field: "duty",
				title: "직책"
			},{
				title: "선택",
				template: '<input type="button" class="text_blue header_select" value="선택">',
				attributes: {
					style: "padding-left: 0 !important"
				}
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
		$(document).on('click', ".header_select", function(){
			var row = $("#gridHeaderList").data("kendoGrid").dataItem($(this).closest("tr"));
			$("#headerName").val(row.dept_name + " " +row.emp_name + " " + row.duty);
			$("[name='approval_emp_seq']").val(row.emp_seq);
			$("[name='approval_emp_name']").val(row.emp_name);
			myWindow2.data("kendoWindow").close();
		});
	}
	
	setData();
	
});

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

function getMonthLimit() {
	
	var data = {
			month : $('#searchDt').val().replace(/-/gi , '')
	}
	
	$.ajax({
		url: _g_contextPath_+"/workPlan/getMonthLimit",
		type : 'POST',
		async: false,
		data: data,
		success: function(result){
			monthLimit = result.monthLimit.MONTH_LIMIT;
			weekLimit = result.weekLimit;

		}
	});
	
}

function selectAll(e) {
	$(e).select();
}

function workTypeModify(){
	
	var list = workTypeCodeList('all');
	var attTime = '';
    var leaveTime = '';
    
    for (var i = 0; i < list.length; i++ ) {
    	if ($("#work_type").data("kendoDropDownList").value() == list[i].work_type_id) {
    		attTime = list[i].attend_time;
    		leaveTime = list[i].leave_time;
    		workMin = list[i].work_min;
    	}
    }
    
	if ( $('#workPlanPk').val() == '0' ) {
		$.each($('#addTbody tr select'), function(i,v){
			var row = v.closest('tr');
			var weekday = $(row).find('#weekday').hasClass('text_black');
			if ($(row).find('#sts').attr('nowYn') == 'Y') {
				if(weekday){
					$(v).data('kendoDropDownList').value($("#work_type").data("kendoDropDownList").value());
					$(v).closest('tr').find('#rStart').text(attTime);
					$(v).closest('tr').find('#rEnd').text(leaveTime);
					$(v).closest('tr').find('#work_min').val(workMin);
					selectType(v);
				}
			}
		})
		
	} else {
		var ch = $('.checkbox:checked');
		$.each(ch, function(i,v){
			var row = $(v).closest("tr");
			var select = row.find('select');
			$(select).data('kendoDropDownList').value($("#work_type").data("kendoDropDownList").value());
			row.find('#rStart').text(attTime);
			row.find('#rEnd').text(leaveTime);
			row.find('#work_min').val(workMin);
			selectType(select[0]);
			
		})
	}
}

function headerCheckbox(){
	if($("#headerCheckbox").is(":checked")){
    	$(".checkbox").prop("checked", "checked");
    	
    }else{
    	$(".checkbox").removeProp("checked");
    }
}

function setFlexData(){
	$("#flexTemplate").empty();
	$("#flexTemplate").hide();
	
	unCheck();
	getMonthLimit();
	
	flexDropDownList();
	
	$('#addTbody').empty();
	
	var sD = $('#searchDt').val().replace(/-/gi , '');
	
	var data = {
		empSeq		: $('#empSeq').val(),
		searchDt	: sD,
		type		: 'normal',
		flex_code_id : $("[name='flex_code_id']").val(),
		startMonth  : sD,
		endMonth : parseInt(sD) + 2
	}
	
	dataGrid(data, 'v', 'flex');
}

function setData(){
	$("#flexTemplate").empty();
	$("#flexTemplate").hide();
	$("[name='flex_code_id']").val("");
	
	unCheck();
	getMonthLimit();
	
	$('#addTbody').empty();

	var data = {
		empSeq		: $('#empSeq').val(),
		searchDt	: $('#searchDt').val().replace(/-/gi , ''),
		type		: 'normal',
	}
	
	dataGrid(data);
	
}

function flexDropDownList () {
	$("#work_type").data('kendoDropDownList').setDataSource(workTypeCodeList('all'));
}

function workTypeCodeList(e){
	var workTypeCodeList = [];
	var data = {
			
	}
	$.ajax({
		url: _g_contextPath_+"/workPlan/workTypeCodeList",
		type : 'POST',
		async: false,
		data: data,
		success: function(result){
			
			var resultVal = [];
			
			if ( e == 'nAll' ) {
								
				$.each(result.list, function(i, v){
					
					if ( parseInt(v.work_min) == 480 ) {
						
						resultVal.push(v);
					}
					
				})
				workTypeCodeList = resultVal;
			} else {
				workTypeCodeList = result.list;
			}
			
		}
	});
	return workTypeCodeList;
}

function dataGrid(data, val, planType){
	var nDay = moment(new Date()).format('YYYY-MM-DD');
	var txt = ['일', '월', '화', '수', '목', '금', '토'];
	var selectHtml = $('#addWorkPlanType').html();
	if(planType === undefined){
		selectHtml = selectHtml
						.replace(
							'<option value="11" data-s="" data-e="" data-m="">탄력근무</option>'
							, ""
						);
	}

	$.ajax({
		url: "<c:url value='/workPlan/setDataSearch' />",
		data : data,
		async : false,
		type : 'POST',
		success: function(result){
			
			var planSts = '';
			var checkHtml = '';
			var btnHtml = '';
			var btnHtml2 = '';
			var color = '';
			switch (result.status.STATUS) {
			case '0':
				planSts = '미신청';
				color = 'red';
				btnHtml = '<input type="button" onclick="saveBtn();" class="btnClass" style="float: right" value="유연근무 신청">';
				$('#defaultBtn').css({'display':'none'});
				break;
			case '1':
// 				planSts = '신청';
				color = 'gray';
				btnHtml2 = '<input type="button" onclick="reqCancelBtn();" style="float: right" value="신청 취소">';
				btnHtml = '<span style="display: inline-block;" class="text_gray">승인 대기 상태</span>';
				$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				$('#defaultBtn').css({'display':'none'});
				break;
			case '2':
				planSts = '승인';
				color = 'blue';
				btnHtml = '<input type="button" onclick="modBtn();" class="btnClass" style="float: right" value="변경신청">';
				btnHtml2 = '<input type="button" onclick="modCancelBtn();" style="float: right" value="변경신청 취소">';
				checkHtml = '<input type="checkbox" id="headerCheckbox" onchange="headerCheckbox();" class="k-checkbox header-checkbox"><label class="k-checkbox-label" for="headerCheckbox"></label>';
				$('#default_work_type').data('kendoDropDownList').value(result.status.WORK_TYPE);
				$('#defaultBtn').css({'display':'inline-block'});
				break;
			default:
				break;
			}
			
			$('#addTbody')
				.append(	'<tr>'+
				'	<th colspan="10" style="text-align: left;"><span id="mSts" style="margin-left: 15px;" class="text_'+color+'">'+planSts+'</span><input type="hidden" id="workPlanPk" value="'+result.status.PK+'"/>'+
				btnHtml2+
				btnHtml+
				'</th>'+
				'</tr>'+
				'<tr>'+
				'	<th style="text-align: ;">'+checkHtml+'</th>'+	
				'	<th>상태</th>'+		
				'	<th>근무일자</th>'+				
				'	<th>요일</th>	'+			
				'	<th>근무유형</th>'+				
				'	<th>출근시간</th>'+				
				'	<th>퇴근시간</th>'+				
				'	<th>비고</th>'+				
				'</tr>');
			
			if( result.status.STATUS != '0' ){
				var checkHtml = '';
				
				$.each(result.list, function(i, v){
					var html;
					var textColor = '';
					var status = '';
					var color = '';
					switch (v.status) {
					case '1':
						status = '신청';
						color = 'gray';
						break;
					case '2':
						status = '승인';
						color = 'blue';
						break;
					case '3':
						status = '변경신청';
						color = 'gray';
						break;
					default:
						break;
					}
					
					if ( v.weekday == '토요일' ) {
						textColor = 'text_blue';
					} else if ( v.weekday == '일요일' ) {
						textColor = 'text_red';
					} else if ( v.HOLIDAY_STATUS == 'Y' ) {
						textColor = 'text_red';
					} else {
						textColor = 'text_black';
					}
					
					if ( result.status.STATUS == '1') {
						checkHtml = '<td></td>';
					} else {
						checkHtml = '<td><input type="checkbox" id="plan'+v.work_date+'" class="k-checkbox checkbox"/><label for="plan'+v.work_date+'" class="k-checkbox-label"></label></td>';
					}
					var dayNo = moment(v.WK_DT).day();
					
						html = '<tr>';
					
					if(v.NOWSTS == 'Y'){
						html +='<input type="hidden" id="work_plan_detail_id" value="'+v.work_plan_detail_id+'">'
						+checkHtml
						+'<td><span id="sts" dataYn="Y" class="text_'+color+'">'+status+'</span><input type="hidden" id="status" value="'+v.status+'"/></td>'
						+'<td id="work_date"><input type="hidden" id="change_degree" class="change_degree" value="'+v.change_degree+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
						+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+selectHtml+'<input type="hidden" id="beforeWkTp" value="'+v.work_type_id+'"/><input type="hidden" id="work_type_id" value="'+v.work_type_id+'"/><input type="hidden" id="work_plan_history_id" value="'+v.work_plan_history_id+'"/></td>'
						+'<td id="rStart">'+v.attend_time+'</td>'
						+'<td id="rEnd">'+v.leave_time+'</td>'
						+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;"><input type="hidden" class="week_no" value="'+v.week_no+'"/><input type="hidden" id="work_min" value="'+v.work_min+'"/></td>'
						+'</tr>';
					}else{
						html +='<input type="hidden" id="work_plan_detail_id" value="'+v.work_plan_detail_id+'">' 
						+'<td></td>'
						+'<td><span id="sts" dataYn="Y" class="text_'+color+'">'+status+'</span></td>'
						+'<td id="work_date">'+v.work_date+'</td>'
						+'<td class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+v.work_type+'<input type="hidden" id="work_type_id" value="'+v.work_type_id+'"/></td>'
						+'<td id="rStart">'+v.attend_time+'</td>'
						+'<td id="rEnd">'+v.leave_time+'</td>'
						+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;" disabled="disabled"><input type="hidden" class="week_no" value="'+v.week_no+'"/><input type="hidden" id="work_min" value="'+v.work_min+'"/></td>'
						+'</tr>';
					}
					
					$('#addTbody').append(html);
					var row = $('#addTbody').children()[i+2]
					var select = $(row).find('select');
					var workTpId = '';
					var list;
					
					if ( select.length > 0 ) {
						
						var sTime = {};
						var eTime = {};
						var workMin = {};
						
						$.each($(row).find('select option'), function(ii, vv){
							
							sTime[ii] = $(this).attr('data-s');
							eTime[ii] = $(this).attr('data-e');
							workMin[ii] = $(this).attr('data-m');
							
							if ( v.work_type_id == $(vv).val() ) {
// 								$(row).find('#rStart').text($(this).attr('data-s'));
// 								$(row).find('#rEnd').text($(this).attr('data-e'));
// 								$(row).find('#work_min').val($(this).attr('data-m'));
							}
							
						});
						
						select.kendoDropDownList({
							value: v.work_type_id
						});
						
						$.each(select.children(), function(ii, vv){
							$(vv).attr('data-s', sTime[ii]);
							$(vv).attr('data-e', eTime[ii]);
							$(vv).attr('data-m', workMin[ii]);
						});
						
						if ( result.status.STATUS == '1' || v.status == '3' ) {
							$( select ).kendoDropDownList({
								  enable: false
							});
						}
						
					} 
					
				});
				
			}else{
				
				// 유연근무 신규
				$.each(result.list, function(i, v){
					var html;
					var textColor = '';
					var dayNo = moment(v.WK_DT).day();

					if(i == 0){
						html = '<tr class="WK_PN_MS_SEQ" data-seq="'+v.WK_PN_MS_SEQ+'">';
					}else{
						html = '<tr>';
					}
					
					if ( v.weekday == '토요일' ) {
						textColor = 'text_blue';
					} else if ( v.weekday == '일요일' ) {
						textColor = 'text_red';
					} else if ( v.HOLIDAY_STATUS == 'Y' ) {
						textColor = 'text_red';
					} else {
						textColor = 'text_black';
					}
					
					if(v.NOWSTS == 'Y'){
						html +='<input type="hidden" id="WK_PN_NO" value="'+v.work_plan_detail_id+'">'
						+'<td></td>'
						+'<td><span id="sts" dataYn="Y" nowYn="Y" class="text_blue">신청가능</span></td>'
						+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
						+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
						+'<td id="rStart">'+$('.addWorkPlanType option:selected').attr('data-s')+'</td>'
						+'<td id="rEnd">'+$('.addWorkPlanType option:selected').attr('data-e')+'</td>'
						+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;"><input type="hidden" class="week_no" value="'+v.week_no+'"/><input type="hidden" id="work_min" value="'+$('.addWorkPlanType option:selected').attr('data-m')+'"/></td>'
						+'</tr>';
					}else{

						html += '<td></td>'
						+'<td><span id="sts" dataYn="Y" nowYn="N" class="text_blue">신청가능</span></td>'
						+'<td id="work_date" class="'+v.work_date+'"><input type="hidden" id="WK_PN_NO" class="wkPnNoData" value="'+v.work_plan_detail_id+'"><input type="hidden" id="ot_yn" class="" value="'+v.ot_yn+'">'+v.work_date+'</td>'
						+'<td id="weekday" class="'+textColor+'">'+v.weekday+'</td>'
						+'<td>'+selectHtml+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
							//+'<td>'+$('.addWorkPlanType option:selected').text()+'<input type="hidden" id="work_type_id" value="'+$('.addWorkPlanType option:selected').val()+'"></td>'
						+'<td id="rStart">'+$('.addWorkPlanType option:selected').attr('data-s')+'</td>'
						+'<td id="rEnd">'+$('.addWorkPlanType option:selected').attr('data-e')+'</td>'
						+'<td><input type="text" id="MEMO" value="'+v.remark+'" style="width:90%;" disabled="disabled"><input type="hidden" class="week_no" value="'+v.week_no+'"/><input type="hidden" id="work_min" value="'+$('.addWorkPlanType option:selected').attr('data-m')+'"/></td>'
						+'</tr>';
					}
					
					$('#addTbody').append(html);
					
					var row = $('#addTbody').children()[i+2]
					var select = $(row).find('select');
					var workTpId = '';
					var list;
					
					if ( select.length > 0 ) {
						
						var sTime = {};
						var eTime = {};
						var workMin = {};
						
						$.each($(row).find('select option'), function(ii, vv){
							sTime[ii] = $(this).attr('data-s');
							eTime[ii] = $(this).attr('data-e');
							workMin[ii] = $(this).attr('data-m');
						});
						
						select.kendoDropDownList();
						
						$.each(select.children(), function(ii, vv){
							$(vv).attr('data-s', sTime[ii]);
							$(vv).attr('data-e', eTime[ii]);
							$(vv).attr('data-m', workMin[ii]);
						});
						
						if(v.HOLIDAY_STATUS == 'Y'){
							$(row).find('#rStart').text('');
							$(row).find('#rEnd').text('');
							$(row).find('#work_min').val('0');
							$(select).data('kendoDropDownList').value('6');
							
						} else {
							$(row).find('#rStart').text(sTime[0]);
							$(row).find('#rEnd').text(eTime[0]);
							$(row).find('#work_min').val(workMin[0]);
							
						}
						$(row).find('#work_type_id').val($(select).data('kendoDropDownList').value());
						
						if ( v.NOWSTS == 'N' ) {
							$( select ).kendoDropDownList({
								  enable: false
							});
						}
					}
					
				});
			}
		}
	});
}

function workPlanTypeChange(){
	
	var checkInput = $('#addTbody input[type=checkbox]:checked');
	
	$.each(checkInput, function(i, v){
		if($(v).attr('id') != 'ms'){
			selectType($(v).closest('tr').find('.addWorkPlanType').val($('#topWorkPlanType').val())[0]);
		}
	});
	
	unCheck();
	
}

var weekNo = '';

function selectType(v){
	
	var row = $(v).closest('tr');
	var before = row.find('#beforeWkTp').val();
	var workTypeId = $(v).val();
	weekNo = row.find('.week_no').val();
	
	if ( $(v).val() == before && $(v).val() != '11' ) {
		row.find(".checkbox").removeProp("checked");
	} else {
		row.find(".checkbox").prop("checked", "checked");
	}
	
	$(v).closest('tr').find('input#work_type_id').val(workTypeId);
	
	if ( workTypeId == '11' ) {
		
		$.each($('.week_no'), function(i, v){
			var row = $(v).closest('tr');
			if ($(v).val() == weekNo) {
					row.find('#sts').attr('class', 'text_red');
					row.find('#sts').attr('dataYn', 'N');
					row.find('#sts').text('신청 불가');
		    }	
		})
		$(v).closest('tr').find('#work_min').val('');
		$(v).closest('tr').find('#rStart').text('');
		$(v).closest('tr').find('#rEnd').text('');
		
		$(v).closest('tr').find('#rStart').append('<input type="text" id="attend_time_mod" ondblclick="selectAll(this);" onkeyup="timeCheck(this);" onkeydown="timeCheck(this);" onfocusout="timeCheck(this);" onchange="timeCheck(this);" name="" check="must" style="width: 90%" value="" opt="time"/>');
		$(v).closest('tr').find('#rEnd').append('<input type="text" id="leave_time_mod" ondblclick="selectAll(this);" onkeyup="timeCheck(this);" onkeydown="timeCheck(this);" onfocusout="timeCheck(this);" onchange="timeCheck(this);" name="" check="must" style="width: 90%" value="" opt="time" />');
		
		var att = $(v).closest('tr').find('#attend_time_mod');
		var lvt = $(v).closest('tr').find('#leave_time_mod');
		
		$(att).kendoTimePicker({
    		//format: "tt HH:mm",
    		format: "HH:mm",
    		culture : "ko-KR",
    		interval : 10,
            dateInput: true,
            
        });
        
        $(lvt).kendoTimePicker({
    		//format: "tt HH:mm",
    		format: "HH:mm",
    		culture : "ko-KR",
    		interval : 10,
            dateInput: true,
        });
		
	} else {
		
		$(v).closest('tr').find('#rStart').text($(v[v.options.selectedIndex]).attr('data-s'));
		$(v).closest('tr').find('#rEnd').text($(v[v.options.selectedIndex]).attr('data-e'));
		$(v).closest('tr').find('#work_min').val($(v[v.options.selectedIndex]).attr('data-m'));
		
		var weekSum = 0;
		var monthSum = 0;
		var weekNoLimit = 0;
		var weekNoYn = 'N';		
		
		$.each($('.week_no'), function(i, v){
			var row = $(v).closest('tr');
			monthSum += parseInt(row.find('#work_min').val())
			
			if ($(v).val() == weekNo) {
				weekSum += parseInt(row.find('#work_min').val())
		    }	

		})
		
		$.each(weekLimit, function(i, v){
			if ( v.WEEK_NO == parseInt(weekNo) ) {
				weekNoLimit = parseInt(v.WEEK_LIMIT);
				weekNoYn = 'Y';
				return false;
			} 
		});
		
		if ( weekNoYn == 'Y' ) {
			
			if (weekSum != weekNoLimit) {
				$.each($('.week_no'), function(i, v){
					var row = $(v).closest('tr');
					
					if ($(v).val() == weekNo) {
						if (weekSum < weekNoLimit) {
							row.find('#sts').attr('class', 'text_red');
							row.find('#sts').attr('dataYn', 'N');
							row.find('#sts').text((weekNoLimit-weekSum)/60+'시간 부족');
						} else {
							row.find('#sts').attr('class', 'text_red');
							row.find('#sts').attr('dataYn', 'N');
							row.find('#sts').text((weekSum-weekNoLimit)/60+'시간 초과');
						}
				    }	
				})
				
			} else {
				$.each($('.week_no'), function(i, v){
					var row = $(v).closest('tr');
					if ($(v).val() == weekNo) {
						row.find('#sts').attr('class', 'text_blue');
						row.find('#sts').attr('dataYn', 'Y');
						if ( workTypeId == before ) {
							row.find('#sts').text($('#mSts').text());
						} else {
							row.find('#sts').text('신청가능');
						}
					}
				})
			}
			
		} else {
			
//	 		월 첫째 주가 주말 또는 공휴여서 weekLimit를 못가져올때 해당 주차 신청가능한 기준근로시간은 무조건 0 
			if (weekSum != 0) {
				$.each($('.week_no'), function(i, v){
					var row = $(v).closest('tr');
					if ($(v).val() == weekNo) {
						row.find('#sts').attr('class', 'text_red');
						row.find('#sts').attr('dataYn', 'N');
						row.find('#sts').text(weekSum/60+'시간 초과');
					}
				})
			} else {
				$.each($('.week_no'), function(i, v){
					var row = $(v).closest('tr');
					if ($(v).val() == weekNo) {
						row.find('#sts').attr('dataYn', 'Y');
						row.find('#sts').attr('class', 'text_blue');
						if ( workTypeId == before ) {
							row.find('#sts').text($('#mSts').text());
						} else {
							row.find('#sts').text('신청가능');
						}
					}
				})
			}
		}
	}
	
	var bEmpty = true;
	
	$.each($('.week_no'), function(i, v){
		var row = $(v).closest('tr');
		if (row.find('#sts').attr('dataYn') == 'N') {
			row.find('#WK_PN_SEQ').focus();
			bEmpty = false;
			return false;
		}

	});
	
	if (!bEmpty) {
		$('.btnClass').attr('disabled', true);
	} else {
		$('.btnClass').attr('disabled', false);
	}
	
}


function timeCheck(e) {
	var row = $(e).closest('tr');
	var dateArr = row.find('#work_date').text().split('-');
	var year = dateArr[0];
	var month = dateArr[1];
	var date = dateArr[2];
	
	if (event.keyCode == 8) 
    {
        return;
    } 
	
	$(e).val($(e).val().replace(/[^0123456789:]/g,""));
	
	var leaveTimeInput = row.find('#leave_time_mod');
	
	var attArr = row.find('#attend_time_mod').val().split(':');
	var attTime = new Date(year, month-1, date, attArr[0], attArr[1], 00);
	
	if ($(e).val().length == 2) {
		$(e).val($(e).val()+':');
	} else if ( $(e).val().length == 5 ) {
		var leaveArr = $(e).val().split(':');
		var leaveTime = new Date(year, month-1, date, leaveArr[0], leaveArr[1], 00);
				
		if(attTime > leaveTime){
			leaveTimeInput.data('kendoTimePicker').value(null);
		} 
		
		if ($('#attend_time_mod').val() != '' && $('#leave_time_mod').val() != '') {
			console.log(row.find('#attend_time_mod').val());
			console.log(row.find('#leave_time_mod').val());
			
			var data = {
					attend_time : row.find('#attend_time_mod').val(),
					leave_time : row.find('#leave_time_mod').val(),
					year : year,
					month : month,
					date : date,
				} 
			getWorkMin(data, row);
		}
	} else if ($(e).val().length > 5) {
		$(e).val($(e).val().slice(0, 5))
	}
}

function getWorkMin(e, row) {
	
	$.ajax({
		url: _g_contextPath_+"/workPlan/getWorkMin",
		type : 'POST',
		data : e,
		async: false,
		success: function(result){
			var workTypeId = row.find('.addWorkPlanType').val($('#topWorkPlanType').val())[0];
			console.log(result);
			row.find('#work_min').val(result)
			weekNo = row.find('.week_no').val();
			
			var weekSum = 0;
			var monthSum = 0;
			var weekNoLimit = 0;
			var weekNoYn = 'N';		
			
			$.each($('.week_no'), function(i, v){
				var row = $(v).closest('tr');
				monthSum += parseInt(row.find('#work_min').val())
				
				if ($(v).val() == weekNo) {
					weekSum += parseInt(row.find('#work_min').val())
			    }	

			})
			
			$.each(weekLimit, function(i, v){
				
				if ( v.WEEK_NO == parseInt(weekNo) ) {
					weekNoLimit = parseInt(v.WEEK_LIMIT);
					weekNoYn = 'Y';
					return false;
				} 
				
			});
			
			if ( weekNoYn == 'Y' ) {
				
				if (weekSum != weekNoLimit) {
					
					$.each($('.week_no'), function(i, v){
						var row = $(v).closest('tr');
						
						if ($(v).val() == weekNo) {
							if (weekSum < weekNoLimit) {
								row.find('#sts').attr('class', 'text_red');
								row.find('#sts').attr('dataYn', 'N');
								row.find('#sts').text((weekNoLimit-weekSum)/60+'시간 부족');
							} else {
								row.find('#sts').attr('class', 'text_red');
								row.find('#sts').attr('dataYn', 'N');
								row.find('#sts').text((weekSum-weekNoLimit)/60+'시간 초과');
							}
					    }	
					})
					
				} else {
					$.each($('.week_no'), function(i, v){
						var row = $(v).closest('tr');
						if ($(v).val() == weekNo) {
							row.find('#sts').attr('class', 'text_blue');
							row.find('#sts').attr('dataYn', 'Y');
							row.find('#sts').text('신청가능');
						}
					})
				}
			} else {
//		 		월 첫째 주가 주말 또는 공휴여서 weekLimit를 못가져올때 해당 주차 신청가능한 기준근로시간은 무조건 0 
				if (weekSum != 0) {
					$.each($('.week_no'), function(i, v){
						var row = $(v).closest('tr');
						if ($(v).val() == weekNo) {
							row.find('#sts').attr('class', 'text_red');
							row.find('#sts').attr('dataYn', 'N');
							row.find('#sts').text(weekSum/60+'시간 초과');
						}
					})
				} else {
					$.each($('.week_no'), function(i, v){
						var row = $(v).closest('tr');
						if ($(v).val() == weekNo) {
							row.find('#sts').attr('dataYn', 'Y');
							row.find('#sts').attr('class', 'text_blue');
							if ( workTypeId == before ) {
								row.find('#sts').text($('#mSts').text());
							} else {
								row.find('#sts').text('신청가능');
							}
						}
					})
				}
			}
			
			var bEmpty = true;
			
			$.each($('.week_no'), function(i, v){
				var row = $(v).closest('tr');
				if (row.find('#sts').attr('dataYn') == 'N') {
					row.find('#WK_PN_SEQ').focus();
					bEmpty = false;
					
					return false;
				}

			});
			
			if (!bEmpty) {
				
				$('.btnClass').attr('disabled', true);
				
			} else {
				
				$('.btnClass').attr('disabled', false);
				
			}
		}
	});
	
}

function saveBtn(){
	
	if(!confirm('신청 하시겠습니까?')){
		return
	};
	
	var array = new Array();
	var wkPnMsSeq = new Array();
	var step = true;
	$.each($('.wkPnNoData'), function(i, v){
		
		var tr = $(v).closest('tr');
		var select = $(tr).find('.addWorkPlanType')[1];
		var attSelect = $(tr).find('#attend_time_mod')[1];
		var leaveSelect = $(tr).find('#leave_time_mod')[1];
		var workTypeId = $(tr).find('input#work_type_id').val();
		
		var attendTime = '';
		var leaveTime = '';
		if ( workTypeId == '11' ) {
			attendTime = $(tr).find('#attend_time_mod').val();
			leaveTime = $(tr).find('#leave_time_mod').val();
		} else {
			attendTime = $(tr).find('#rStart').text();
			leaveTime = $(tr).find('#rEnd').text();
		}
		
		var data = {
				work_date : $(tr).find('#work_date').text().replace(/-/gi , ''),
				weekday : $(tr).find('#weekday').text(),
				attend_time : attendTime,
				leave_time : leaveTime,
				work_type_id	: workTypeId,
				remark		: $(tr).find('#MEMO').val(),
				work_min : $(tr).find('#work_min').val(),
		}
		
		array.push(data);
		
		if ( $(tr).find('#ot_yn').val() == 'Y') {
			
			alert($(tr).find('#work_date').text()+' : 시간외 근무 신청자료가 있습니다. 취소하고 신청해주세요.');
			step = false;
			return false;
		}
		
	});
	
	if (!step) return;

	$.ajax({
		url: "<c:url value='/workPlan/workPlanUserSave' />",
		data : {apply_month : $('#searchDt').val().replace(/-/gi , ''), empSeq : $('#empSeq').val(), default_work_type : $('#default_work_type').val(),pk : $('#workPlanPk').val(),approval_emp_seq : $('[name="approval_emp_seq"]').val(), data : JSON.stringify(array)},
		async : false,
		type : 'POST',
		success: function(result){
			setData();
			alert('신청 되었습니다.')
		}
	});	
	
}

function reqCancelBtn() {
	var data = {
			work_plan_id :	$('#workPlanPk').val()
			
	};
	var result = confirm('취소 하시겠습니까?');
	
	if (result) {
		
		$.ajax({
			url: _g_contextPath_+"/workPlan/workPlanCancel",
			dataType : 'text',
			data : data,
			type : 'POST',
			success : function(result){
				setData();
				alert('취소 되었습니다.')
			}
		})
	} else {
		setData();
	} 
}

function modBtn() {
	
	var ch = $('.checkbox:checked');
	if (ch.length < 1) {
		alert('변경할 목록을 체크해주세요');
	} else {
		
		var data = {};
		var step = true;
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}
			var tr = $(v).closest("tr");
			var attendTime = '';
			var leaveTime = '';
			var workTypeId = $(tr).find('input#work_type_id').val();
			
			if ( workTypeId == '11' ) {
				attendTime = $(tr).find('#attend_time_mod').val();
				leaveTime = $(tr).find('#leave_time_mod').val();
			} else {
				attendTime = $(tr).find('#rStart').text();
				leaveTime = $(tr).find('#rEnd').text();
			}

			tem['work_type_id'] = workTypeId;
			tem['work_plan_detail_id'] = $(v).closest("tr").find('#work_plan_detail_id').val();
			tem['work_date'] = $(v).closest("tr").find('#work_date').text().replace(/-/gi , '');
			tem['weekday'] = $(v).closest("tr").find('#weekday').text();
			tem['attend_time'] = attendTime;
			tem['leave_time'] = leaveTime;
			tem['work_min'] = $(v).closest("tr").find('#work_min').val();
			tem['change_degree'] = (parseInt($(v).closest("tr").find('#change_degree').val())+1).toString();
			tem['remark'] = $(v).closest("tr").find('#MEMO').val();
			tem['work_plan_id'] = $('#workPlanPk').val();
			tem['approval_emp_seq'] = $('[name="approval_emp_seq"]').val()
			
			data[index] = tem;
			
			
			if ( $(v).closest("tr").find('#status').val() != '2') {
				alert('승인된 건만 체크해주세요.');
				step = false;
				return false;
			} else {
				if (  $(v).closest("tr").find('#beforeWkTp').val() == $(tr).find('input#work_type_id').val() ) {
					if ( $(v).closest("tr").find('select').val() != '11' ) {
						
					} else {
						alert('근무유형이 동일한 건이 있습니다.');
						step = false;
						return false;
					}
					
				}
			}
			
			if ( $(v).closest("tr").find('#ot_yn').val() == 'Y') {
				alert('시간외 근무 신청된 날짜는 변경이 불가능 합니다.');
				step = false;
				return false;
			}
			
		})
		
		if (!step) return;
		
		var result = confirm('신청 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/workPlanChange",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					setData();
					alert('신청 되었습니다.')
				}
			})
		} else {
			setData();
		} 
	}
	
}

function modCancelBtn() {
	
	var ch = $('.checkbox:checked');
	if (ch.length < 1) {
		alert('취소할 목록을 체크해주세요');
	} else {
		
		var data = {};
		var step = true;
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}

			tem['work_plan_detail_id'] = $(v).closest("tr").find('#work_plan_detail_id').val();
			tem['work_plan_history_id'] = $(v).closest("tr").find('#work_plan_history_id').val();
			
			data[index] = tem;
			
			if ( $(v).closest("tr").find('#status').val() != '3') {
				alert('변경신청 건만 체크해주세요.');
				step = false;
				return false;
			}
			
		})
		
		if (!step) return;
		
		var result = confirm('취소 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/workPlanChangeCancel",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					setData();
					alert('취소 되었습니다.')
				}
			})
		} else {
			setData();
		} 
	}
	
}

function unCheck(){
	$('input[type=checkbox]').prop("checked", false);
}

function msCheck(e){
	
	if($(e).prop("checked")){
		$('input[type=checkbox]').prop("checked", true);
	}else{
		$('input[type=checkbox]').prop("checked", false);
	}
}

function excelBtn(){
	$('#excelFile').click();
}

function excelFileChange(){
	
	var filePath = $('#excelFile').val();

	var fileExt = filePath.slice(filePath.lastIndexOf('.') + 1).toLowerCase();

	if(fileExt == 'xlsx' || fileExt == 'xls'){
		excelRead();
		
	}else if(filePath != ''){
		alert('파일을 선택해 주세요.');
		$('#excelFile').val('');
		return
	}
	
}

function excelRead(){

	var formData = new FormData();
	
	formData.append('excelFile', $('#excelFile')[0].files[0]);

	$.ajax({
        url: "<c:url value='/workPlan/excelToJson' />",
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        success: function(result){

        	$('#excelFile').val('');
        	
        	unCheck();
        	
        	$('#addTbody').empty();
        	
        	//그리기
        	var data = {
				login		: '',
				searchDt	: moment(result.appDt).format('YYYY-MM'),
				type		: 'excel',
			}
        	$.each(result.body, function(i, v){

        		var addTr = '<tr>'+
							'	<th colspan="7" style="text-align: left;"><span style="margin-left: 15px;">'+v.title_4+' / '+v.title_2+'</span></th>'+
							'</tr>'+
							'<tr>';
				if(i == 0){
					addTr += '<th><input type="checkbox" id="ms" onclick="msCheck(this);" style="visibility: hidden;"><label for="ms"></label></th>';
				}else{
					addTr += '<th></th>';
				}		
					addTr += '	<th>근무일자</th>'+				
							'	<th>요일</th>	'+			
							'	<th>근무유형</th>'+				
							'	<th>출근시간</th>'+				
							'	<th>퇴근시간</th>'+				
							'	<th>비고</th>'+				
							'</tr>';
        		
        		if(v.title_1 != 0){
        			$('#addTbody').append(addTr);
	        		data.login = v.title_1;
	       			dataGrid(data, v);
        		};
        		
        		$.each(v, function(ii, vv){
	        		$('.'+v.title_1+ii).closest('tr').find('#WK_PN_SEQ').val(vv);
        		});
        	
        	});
        		
        }
    });

}

function empUserPopupBtn(e){
	window.open( _g_contextPath_ +'/common/deptPopup', '조직도', 'scrollbars=yes, resizeble=yes, menubar=no, toolbar=no, location=no, directories=yes, status=yes, width=910, height=430');
}

function setUserData(seq, name, dept){
	$('#OV_M_TIME').val(dept + ' / ' + name);
	$('#empSeq').val(seq);
	
}

function defaultMod() {
	var data = {
		default_type : $('#default_work_type').val(),
		empSeq		: $('#empSeq').val(),
		month	: $('#searchDt').val().replace(/-/gi , ''),
	}
	
	$.ajax({
		url: _g_contextPath_+"/workPlan/defaultMod",
		dataType : 'text',
		data : data,
		type : 'POST',
		success : function(result){
			setData();
			alert('기본근무유형이 변경되었습니다.')
		}
	})
}


</script>

</body>
</html>