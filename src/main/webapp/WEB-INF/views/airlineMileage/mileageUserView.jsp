<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<script type="text/javascript" src="<c:url value='/js/jszip.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>

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
.select-box {
	height: 24px;
	margin-top: 0px;
}
.inputFrm, .updateFrm {
	display: none;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	console.log("${userInfo}")
	console.log("${getUpDeptName}")
	/* kendo datepicker 년월 처리 */
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
	
	//메인그리드 호출
	mainGrid();
	//첨부파일 팝업 시작
	$('#resultEduPop').kendoWindow({
	    width: "400px",
	    title: '첨부파일 확인',
	    visible: false,
	    modal : true,
	    actions: [
	        "Close"
	    ],
	}).data("kendoWindow").center();
	
	/*
	신청자 검색 팝업(#empListPop)
*/
var myWindow = $("#empListPop"),
	undo = $("#empListPopBtn");
undo.click(function(){
	myWindow.data("kendoWindow").open();
	undo.fadeOut();
	empGrid();
});
$("#empListPopClose").click(function(){
	myWindow.data("kendoWindow").close();
});
myWindow.kendoWindow({
	width: "600px",
	height: "665px",
	visible: false,
	modal: true,
	actions: [
		"Close"
	],
	close: function(){
		undo.fadeIn();
		$("#emp_name").val("");
		$("#dept_name").val("");
	}
}).data("kendoWindow").center();

function empGridReload(){
	$("#gridEmpList"/* popUpGrid */).data("kendoGrid").dataSource.read();
}
$("#empSearchBtn").click(function(){
	empGridReload();
});
$(document).on({
	'keyup': function(event){
		if(event.keyCode===13){//enterkey
			empGridReload();
		}
	}
},".grid_reload");

var empGrid = function(){
	var grid = $("#gridEmpList"/* popUpGrid */).kendoGrid({
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
					data.emp_name = $("#emp_name").val();
					data.dept_name = $("#dept_name").val();
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
		//dataBound: gridDataBound,
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
			template: '<input type="button" class="text_blue emp_select" value="선택">',
			attributes: {
				style: "padding-left: 0 !important"
			}
		}],
		change: function(e){
			//codeGridClick(e)
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
	$(document).on('click', ".emp_select", function(){
		var row = $("#gridEmpList").data("kendoGrid").dataItem($(this).closest("tr"));
		$("#empName").val(row.emp_name);
		$("[name='apply_emp_seq']").val(row.emp_seq);
		$("[name='apply_dept_name']").val(row.dept_name);
		$("#deptSeq").val(row.dept_seq);
		$("[name='userSeq2']").val(row.emp_seq);
		myWindow.data("kendoWindow").close();
	});
}
});

//검색버튼 이벤트
function searchBtn() {
	//메인그리드 reload 호출
	gridReLoad();
	$('#deptSeq').val("");
	$('#deptName').val("");
	$('#empSeq').val("");
	$('#empName').val("");
}

//메인그리드 reload
function gridReLoad() {
	$('#grid').data('kendoGrid').dataSource.page(1);
}

function getFileNm(e) {
	var index = $(e).val().lastIndexOf('\\') + 1;
	var valLength = $(e).val().length;
	$('#fileID').val($(e).val().substr(index, valLength));
}

function uploadBtn(e) {
	$(e).next().click();
}

//메인그리드 ajax 
var dataSource = new kendo.data.DataSource({		
	serverPaging : true,
	pageSize : 20,
	transport : {
		read : {
			url : _g_contextPath_+'/airlineMileage/mileageListSearchAdmin',
			dataType : "json",
			type : 'POST'
		},			
		parameterMap : function(data, operation) {
			//부서
			data.deptSeq = $('#deptSeq').val();
			data.deptName = $('#deptName').val();
			//사원
			data.empSeq = $('#empSeq').val();
			data.empName = $('#empName').val();
			//날짜
			data.startDt = $('#startDt').val();
			data.endDt = $('#endDt').val();
			//사용자임으로 Y값을 줌.
			data.leaveDivision = "Y";
			
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
		model: {
			fields: {
				ISPC_PRC: { type: "string" },
			}
		}
	}
});

//메인그리드
function mainGrid() {		 
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
		dataSource : dataSource,
		height : 700,
		sortable : true,
		toolbar: [
            {name : "excel", text : "엑셀 내려받기"},
        ],
        excel: {
           fileName:  '마일리지내역.xlsx',
           allPages: true
        },
		pageable : {
			refresh : true,
			pageSizes : [10,20,30,50,100],
			buttonCount : 5
		},
		
		persistSelection : true,
		selectable : "multiple",			
		columns : [{field : "sdate",
						title : "출국일",}
					  ,{field : "edate",
						   title : "귀국일",}	
					  ,{field : "emp_name",
						   title : "성명",}
					  ,{field : "dept_name",
						   title : "부서",}
					  ,{field : "area",
						   title : "출장지",}	
					  ,{field : "division",
						   title : "구분",}
					  ,{field : "use_mileage_view",
						 title : "사용마일리지",}
					  ,{field : "lose_mileage_view",
						 title : "소멸마일리지",}
					  ,{field : "save_mileage_view",
						 title : "적립마일리지",}
					  ,{field : "total_mileage_view",
						 title : "보유마일리지",
							template: function(data){
								var status ="<span style='color:blue;'>"+data.total_mileage_view+"</span>";
								
								if(data.total_mileage >= 100000 ){
									status = "<span style='color:red;'>"+data.total_mileage_view+"</span>"
								};
								
								
								
								return status;
							},
					  }/* ,{field : "master_mileage_view",
							 title : "총 마일리지",
								template: function(data){
									var status ="<span style='color:blue;'>"+data.master_mileage_view+"</span>";
									
									if(data.master_mileage >= 100000 ){
										status = "<span style='color:red;'>"+data.master_mileage_view+"</span>"
									};
									
									
									
									return status;
								},
						  } */
					  ,{field : "flight",
							 title : "항공편",}
					  ,{field : "daily_expenses_view",
							 title : "일비",}
					  ,{field : "food_expenses_view",
							 title : "식비",}
					  ,{field : "room_expenses_view",
							 title : "숙박비",}
					  ,{field : "air_expenses_view",
							 title : "항공운임",}
					  ,{field : "travel_expenses_view",
							 title : "여행자보험",}
					  ,{field : "etc_expenses_view",
							 title : "기타",}
					  ,{field : "",
							title : "첨부파일",
							template: '<input type="button" id="" class="text_blue" onclick="resultFileRow(this);" value="첨부파일">',
							width : 100
						},
					 ],
		change: function (e) {
        	gridClick(e);
        }
	}).data("kendoGrid");
}

/* 파일 다운로드 시작 */

function resultFileRow(e){
	 var dataItem = $("#grid").data("kendoGrid").dataItem($(e).closest("tr"));

	 var fileName = dataItem.dj_mileage_detail_id

	 var key = dataItem.doc_common_seq;
	 $('#popupTitle').text(dataItem.draft_dept_name)
	 var data = {
				keyId : fileName,
		}

	 $('#resultEduFileDiv').empty();
	 $.ajax({
			url: _g_contextPath_+"/airlineMileage/fileList",
			dataType : 'json',
			data : data,
			type : 'POST',
			async: false,
			success: function(result){

				if (result.list.length > 0) {
					for (var i = 0 ; i < result.list.length ; i++) {
						
						if(i==0) {	
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th>문서첨부파일 목록</th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									//'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="doc_out_FileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="mileage_certificate_FileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="mileage_certificate_FileSeq" value="'+result.list[i].file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);		
						} else {
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th></th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									//'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="doc_out_FileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
									'<input type="hidden" id="mileage_certificate_FileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="mileage_certificate_FileSeq" value="'+result.list[i].file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);
						}
					}
					
				} else {
					
					$('#resultEduFileDiv').append(
						'<tr id="test">'+
						'<th>문서첨부파일 목록</th>'+
						'<td class="le">'+
						'<span class="mr20">'+	
						//'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
						'<a href="#n" style="color: #808080" id="fileText">&nbsp;문서첨부파일이	없습니다.'+
						'</a>'+
						'</span>'+
						'</td>'+
						'</tr>'
					);
					
				}
				
			}
		}); 

	 $('#resultEduPop').data("kendoWindow").open();
	 
}

function doc_out_FileDown(e){
	//debugger
	var row = $(e).closest("tr");
	var attach_file_id = row.find('#mileage_certificate_FileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			attach_file_id : row.find('#mileage_certificate_FileKey').val(),
			file_seq : row.find('#mileage_certificate_FileSeq').val()
			
	}
	
	$.ajax({
		url : _g_contextPath_+'/airlineMileage/fileDown',
		type : 'GET',
		data : data,
	}).success(function(data) {
		
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_+'/airlineMileage/fileDown?attach_file_id='+attach_file_id;
	});
	
}
function popCancel(){
	$('#resultEduPop').data("kendoWindow").close();
}
function tran_emp_name_popCancel(){
	$('#tran_emp_name_pop').data("kendoWindow").close();
}
/* 파일 다운로드 끝 */

</script> 



<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>마일리지 조회(사용자)</h4>
		</div>
	</div>
	<div class="sub_contents_wrap">
	<p class="tit_p mt5 mt20">마일리지 조회(사용자)</p>
		<div class="top_box">
			<dl>
				<dt  class="ar" style="width:65px" >년월</dt>
				<dd>
					<input type="text" value="" id="startDt" class="w113"/>
					&nbsp;~&nbsp;
					<input type="text" value="" id="endDt"	class="w113" />
				</dd>
				<dt  class="ar" style="width:65px;" >부서</dt>
				<dd>
					<input type="text" name="apply_dept_name" id="deptName" value="" disabled>
					<input type="hidden" name="deptSeq" id="deptSeq" value="" style="">
				</dd>
				<dt  class="ar" style="width:65px" >성명</dt>
				<dd>
					<input type="text" value="" id="empName" disabled>
					<input type="hidden" name="apply_emp_seq" id="empSeq" value="" style="">
					<input type="button" id="empListPopBtn" class="file_input_button ml4 normal_btn2" value="검색">
				</dd>
			</dl>
		</div>
		<div class="btn_div mt10 cl">
			<div class="right_div">
				<div class="controll_btn p0">
						<button type="button" id="searchBtn" onclick="searchBtn();">조회</button>
				</div>
			</div>			
		</div>		
		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>			
	</div><!-- //sub_contents_wrap -->
</div><!-- iframe wrap -->


	<!-- 파일 다운로드 -->
	<div class="pop_wrap_dir" id="resultEduPop" style="width:400px; display: none;">
		<div class="pop_con">
			<!-- 타이틀/버튼 -->
			<div class="btn_div mt0">
				<div class="left_div">
					<h5><span id="popupTitle"></span> 첨부파일</h5>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
					</div>
				</div>
			</div>
			<div class="com_ta" style="" id="">
				<table id="resultEduFileDiv">
			
				</table>
			</div>
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" value="닫기" onclick="popCancel();"/>
			</div>
		</div><!-- //pop_foot -->
	</div>
	<!-- 파일 다운로드 -->	
</form>

<!-- 신청자 검색 팝업  -->
<div class="pop_wrap_dir" id="empListPop" style="width:600px;">
	<div class="pop_head">
		<h1>사원리스트</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width:65px;">성명</dt>
				<dd>
					<input type="text" id="emp_name" class="grid_reload" style="width:120px;">
					<input type="button" id="empSearchBtn" value="검색">
				</dd>
			</dl>
		</div>
		<div class="com_ta mt15">
			<div id="gridEmpList"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" id="empListPopClose" value="닫기">
		</div>
	</div>
</div>