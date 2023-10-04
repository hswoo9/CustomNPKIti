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
<!-- iframe wrap -->
<!-- 
<div class="iframe_wrap">
 -->
<div class="iframe_wrap" style="min-width: 1200px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap" style="padding-bottom: 10px;">

		<div class="title">
			<div>
				<h4>마일리지 등록</h4>
			</div>
			<div class="controll_btn p0">
				<button type="button" id="" onclick="window.location.reload()">초기화</button>
			</div>
		</div>
	</div>
	
	<div class="" style="padding-bottom: 10px;">
		<div class="top_box">
			<dl>
				<dt class="ar" style="">접수부서/접수자</dt>
				<dd style="width: 180px;">
					<div class="controll_btn p0">
						<input type="text" id="req_dept_name" style="width: 100%;border: 1px solid lightgray;text-align: center;text-indent: 0px;font-weight: bold;" value="자동입력" readonly="readonly">
						<input type="hidden" id="req_dept_seq">
					</div>
				</dd>				
				<dd style="">
					<div class="controll_btn p0" style="display: flex;">
						<div>
							<input type="text" id="req_emp_name" style="width: 100%;border: 1px solid lightgray;text-align: center;text-indent: 0px;" readonly="readonly">
							<input type="hidden" id="req_emp_seq">
						</div>
					</div>
				</dd>				
			</dl>
		</div>
	</div>
	
	<div class="sub_contents_wrap">

		<div class="top_box" style="background: white; min-height: 300px;">
			<dl>
				<dt class="ar">이름</dt>
				<dd style="">
					<input type="text" id="empName" value="" style="text-align: center; text-indent:0px;" disabled/>
					<input type="hidden" id="empSeq" value="" style="text-align: center; text-indent:0px;" disabled/>
					<input type="hidden" id="deptName" value="" style="text-align: center; text-indent:0px;" disabled/>
					<input type="hidden" id="deptSeq" value="" style="text-align: center; text-indent:0px;" disabled/>
					<input type="button" class="empListPopBtn file_input_button ml4 normal_btn2" value="검색">
				</dd>		
				
				<dt class="ar" style="">적립구분</dt>
				<dd >
					<input id="division"  type="text" class="dataInput">
				</dd>		
			</dl>
			<dl>
				<dt class="ar" style="">출장지</dt>
				<dd style="width: 535px;">
					<input type="text" id="area" style="width: 100%;" value="" placeholder="국가, 도시 순으로 입력(예: 미국, LA)"/>
				</dd>	
				<dt class="ar" style="">출발일</dt>
				<dd>
					<input type="text" id="startDt" value=""/>
				</dd>	
			</dl>
			<dl>
				<dt class="ar">항공편</dt>
				<dd style="width: 535px;">
					<input type="text" id="flight" style="width: 100%;" value="" placeholder="항공편명, 항공사명 순으로 입력(예: KE906, 대한항공)"/>
				</dd>
				<dt class="ar" style="">귀국일</dt>
				<dd style="width: 200px;">
					<input type="text" id="endDt" value="" />
				</dd>	
			</dl>
			<div id="" >
				<div style="display: flex;padding-left: 4px;padding-top: 10px;padding-bottom: 10px;">
					<div style="width: 140px;">
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:12px;">여비</span>
						</div>
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:12px;">(원화로 입력)</span>
						</div>	
					</div>
					
					<div style="width: 690px; border: 1px solid lightgrey;">
						<dl>
							<dt>일비</dt>
							<dd style="margin-left: 5.5%;">
								<input type="text" id="dailyExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt>식비</dt>
							<dd style="margin-left: 5.5%;">
								<input type="text" id="foodExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt>숙박비</dt>
							<dd style="margin-left: 3.7%;">
								<input type="text" id="roomExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt>항공운임</dt>
							<dd style="margin-left: 1.8%;">
								<input type="text" id="airExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt>여행자보험</dt>
							<dd style="">
								<input type="text" id="travelExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt>기타</dt>
							<dd style="margin-left: 5.5%;">
								<input type="text" id="etcExpenses"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
					</div>
				</div>
			</div>
			<div id="mileage_use_save_delete" >
				<div style="display: flex;padding-left: 4px;padding-top: 10px;padding-bottom: 10px;">
					<div style="width: 140px;">
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:12px;">마일리지</span>
						</div>
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:12px;">사용/적립/소멸</span>
						</div>	
					</div>
					
					<div style="width: 690px; border: 1px solid lightgrey;">
						<dl>
							<dt><span style="color: red;">*</span>사용</dt>
							<dd>
								<input type="text" id="use_mileage"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt><span style="color: red;">*</span>적립</dt>
							<dd>
								<input type="text" id="save_mileage"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
						<dl>
							<dt><span style="color: red;">*</span>소멸</dt>
							<dd>
								<input type="text" id="lose_mileage"  class="file_input_textbox clear" value="" style="width: 480px; text-align: center;" placeholder=",를 제외한 금액입력 / 해당없을경우 0 입력" /> 
							</dd>
						</dl>
					</div>
				</div>
			</div>
			<div id="file_div" >
				<div style="display: flex;padding-left: 4px;padding-top: 10px;padding-bottom: 10px;">
					<div style="width: 140px;">
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:12px;">첨부파일등록</span>
						</div>
						<div style="padding-left: 17px; margin-bottom: 5px;">
							<span style="font-weight: bold; color:#4a4a4a; font-size:11px;">(항공마일리지신고서)</span>
						</div>	
						
					</div>
					
					<div style="width: 690px; border: 1px solid lightgrey;">
						<dl>
							<dt><span style="color: red;">*</span>첨부파일</dt>
							<dd>
								<form class="pop_wrap_dir" id="dataForm" style="width: 568px;" enctype="multipart/form-data" method="post" action= "<c:url value="/airlineMileage/fileUpload"/>">
									<input type="text" id="fileID1"  class="file_input_textbox clear" value="" readonly="readonly" style="width: 480px; text-align: center; " placeholder="파일 선택" /> 
									<input type="button" onclick="uploadBtn(this);" value="추가" class="file_input_button ml4 normal_btn2" style="width: 70px; background: lightgray;">
									<input multiple="multiple" type="file" id="fileID" name="file_name" value="" class="" onchange="getFileNm(this);" style="display:none;"/>
									<input type="button" id="" class="" onclick="fileRegister(this);" value="등록" style="display:none;">
									<input type="" name = "receive_no" value="" style="display:none;">
									<input type="" name = "targetKey" id="targetKey" value="" style="display:none;">
									<input type="" name="data" id="data" value="" style="display:none;">
									<input type="" name="fileActive" id="fileActive" value="" style="display:none;">
								</form>
							</dd>
						</dl>
					</div>
				</div>
				<div class="controll_btn" style="padding: 0px 25px 10px 20px; text-align: left;">
					<button type="button" id="" onclick="mileageReq()">등록</button>
				</div>
			</div>
		</div>
	</div>

</div>

<!-- 등록자 검색 팝업  -->
<div class="pop_wrap_dir" id="empListPop" style="width:600px;">
	<div class="pop_head">
		<h1>사원리스트</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dt class="ar" style="width:65px;">성명</dt>
				<dd>
					<input type="text" id="search_emp_name" class="grid_reload" style="width:120px;">
				</dd>
				<dt>부서</dt>
				<dd>
					<input type="text" id="search_dept_name" class="grid_reload" style="width:180px;">
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
<!-- iframe wrap -->




<script type="text/javascript">
//적립구분
var division =[
	{"code": "스타얼라이언스","code_kr": "스타얼라이언스"}, 
	{"code": "스카이팀","code_kr": "스카이팀"}, 
	{"code": "기타","code_kr": "기타"},
];
$(function() {
    console.log("${userInfo}");
	/* 데이터 없을시 그리드 처리 함수 */
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
	$('#req_dept_name').val("${userInfo.orgnztNm}");
	$('#req_dept_seq').val("${userInfo.deptSeq}");
	$('#req_emp_name').val("${userInfo.empName}");
	$('#req_emp_seq').val("${userInfo.empSeq}");
	
	//퇴사자구분 드랍다운리스트
	$("#division").kendoDropDownList({
		dataTextField : "code_kr",
		dataValueField : "code",
		dataSource : division,
		index : 0,
		change : function(e) {
			console.log(e.sender._old);
		}
	});
	
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
	/*
	대체휴무 신청 - 신청자 검색 팝업(#empListPop)
	*/
	var myWindow = $("#empListPop"),
		undo = $(".empListPopBtn");
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
	 					/* data.deptSeq = $("#deptListBox").val(); */ 
						data.emp_name = $("#search_emp_name").val();
						data.dept_name = $("#search_dept_name").val();
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
			console.log(row);
			$("#empName").val(row.emp_name);
			$("#empSeq").val(row.emp_seq);
			$("#deptName").val(row.dept_name);
			$("#deptSeq").val(row.dept_seq);
			myWindow.data("kendoWindow").close();
		});
	};
});


	/* 파일 업로드 */
	function getFileNm(e) {
	
		var files=$('input[name="file_name"]')[0].files;
		
		var fileNm = '';
	    for(var i= 0; i<files.length; i++){
	    	
	    	var nm = files[i].name;
	    	
	    	var index = nm.lastIndexOf('\\') + 1;
	    	var valLength = nm.length;
	    	
	    	if ( i == 0 ) {
	    		fileNm = files[i].name.substr(index, valLength);
	
	    	} else {
	    		fileNm = fileNm+' , '+files[i].name.substr(index, valLength);
	    		
	    	}
	    }
	    
	    if(files.length == '0'){
			$('#fileActive').val('');
	    }else{
			$('#fileActive').val('Y');
	    }
		$('#fileID1').val(fileNm).css({'color':'#0033FF','margin-left':'5px'});
	
	
	}
	function uploadBtn(e) {
				$(e).next().click();
	}
	function fileRegister(e){
		
			if($('input[name="file_name"]')[0].files.length == "0"){
				location.reload();
				return false;
			}
	
			var files=$('input[name="file_name"]')[0].files;
	 		var data = files
	 		$("#data").val(JSON.stringify(data));
	
			//$(e).parent().find('[name="data"]').val(JSON.stringify(data));
			
			var options = {
				success : function(data) {
						location.reload();
				},
				error : function(err){
						location.reload();
				},
				type : "POST"
				
			};
			$("#dataForm").ajaxSubmit(options);
	}


	/* 파일 업로드 끝 */
	
	//등록하기
	function mileageReq(){
		var today = new Date();
		console.log(today)
		//벨리데이션에 쓸 값
		var req_emp_name = $('#req_emp_name').val();
		var req_division = $('#division').val();
		var req_area = $('#area').val();
		var req_flight = $('#flight').val();
		var req_use_mileage = $('#use_mileage').val();
		var req_save_mileage = $('#save_mileage').val();
		var req_lose_mileage = $('#lose_mileage').val();
		var req_file_name = $('#fileID1').val();
		var emp_name = $('#empName').val();
		var daily_expenses = $('#dailyExpenses').val();
		var food_expenses = $('#foodExpenses').val();
		var room_expenses = $('#roomExpenses').val();
		var air_expenses = $('#airExpenses').val();
		var travel_expenses = $('#travelExpenses').val();
		var etc_expenses = $('#etcExpenses').val();
			
		var data = {
				//접수자정보
				req_dept_seq : $('#req_dept_seq').val(),
				req_dept_name : $('#req_dept_name').val(),
				req_emp_seq : $('#req_emp_seq').val(),
				req_emp_name : $('#req_emp_name').val(),
				//등록자정보
				dept_seq : $('#deptSeq').val(),
				dept_name : $('#deptName').val(),
				emp_seq : $('#empSeq').val(),
				emp_name : $('#empName').val(),
				//여비
				daily_expenses : $('#dailyExpenses').val(),
				food_expenses : $('#foodExpenses').val(),
				room_expenses : $('#roomExpenses').val(),
				air_expenses : $('#airExpenses').val(),
				travel_expenses : $('#travelExpenses').val(),
				etc_expenses : $('#etcExpenses').val(),
				//적립구분
				division : $('#division').val(),
				//출장지
				area : $('#area').val(),
				//항공편
				flight : $('#flight').val(),
				//날짜
				startDt : $('#startDt').val(),
				endDt : $('#endDt').val(),
				//마일리지
				use_mileage : $('#use_mileage').val(),
				save_mileage : $('#save_mileage').val(),
				lose_mileage : $('#lose_mileage').val(),
				sum_mileage : Number($('#save_mileage').val()) - Number($('#use_mileage').val()) - Number($('#lose_mileage').val()),
			}
		
		//console.log("접수",data)
		if(req_emp_name != '' && req_division != '' && req_area != '' && req_flight != '' && req_use_mileage != '' && req_save_mileage != '' && req_lose_mileage != '' && req_file_name != '' &&
				emp_name != '' && daily_expenses != '' && food_expenses != '' && room_expenses != '' && air_expenses != '' && travel_expenses != '' && etc_expenses != ''){

			$.ajax({
				url: _g_contextPath_ + '/airlineMileage/mileageRequest',
				type: 'post',
				dataType: 'json',
				data: data,
				async: false,
				success: function(result){
						alert("등록했습니다.");

						$.each(result,function(key, value){
							var targetKey = value;
							$('#targetKey').val(targetKey)
						});
						var fileActive =$('#fileActive').val();
					
						if( fileActive == "Y"){
							fileRegister()						
						}else{
							location.reload();
						}
					
				}
			});	
		}else{
			alert("필수항목을 입력해주세요");

		}
		
		
	}
	
</script>



