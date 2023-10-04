<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript" src="<c:url value='/js/educationManagement/onlineEduRegPop.js' />"></script>

<style type="text/css">
.k-header .k-link {
	text-align: center;
}

.k-grid-content>table>tbody>tr {
	text-align: center;
}

th {
	background: #F0F6FD;
}
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>근무계획</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">

		<div class="top_box">
			<dl>
				<dt class="ar" style="width: 65px">등록년월</dt>
				<dd>
					<input type="text" value="${nowDate}" name="" id="monthpicker"
						placeholder="" />

				</dd>
				
				
			</dl>

		</div>

		<!-- 버튼 -->
		<div class="btn_div mt10 cl">

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="excelDownload" onclick="">양식 다운로드</button>
					<button type="button" id="excelUpload" onclick="">엑셀 업로드</button>
					<button type="button" id="eduSave" onclick="">저장</button>
					<button type="button" id="eduUpdate" onclick="">수정</button>
					<button type="button" id="eduDelete" onclick="">삭제</button>
					<button type="button" id="searchBtn" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>

		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0"></p>
			</div>

		</div>
		<div class="com_ta2 mt15" style="height: 520px;overflow-y: scroll;">
			<div id="grid" style="width: 2500px"></div>
			<div id="onlineEdu" class="" >
				<form method="post" action="" name="onlineEduVO">
						<table style="width: 3000px">
							<colgroup>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col style="width:500px">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th style="background: #F0F6FD;">구분</th>
									<th style="background: #F0F6FD;">대분류</th>
									<th style="background: #F0F6FD;">중분류</th>
									<th style="background: #F0F6FD;">소분류</th>
									<th style="background: #F0F6FD;">과정코드</th>
									<th style="background: #F0F6FD;">교육명</th>
									<th style="background: #F0F6FD;">학습시간</th>
									<th style="background: #F0F6FD;">교육비</th>
									<th style="background: #F0F6FD;">학습시작일</th>
									<th style="background: #F0F6FD;">학습종료일</th>
									<th style="background: #F0F6FD;">이름</th>
									<th style="background: #F0F6FD;">취득점수</th>
									<th style="background: #F0F6FD;">수료여부<input type="hidden" id="enroll_date" name="enroll_date"/></th>
								</tr>
							</thead>	
							<tbody id="appendTbody">
								
							</tbody>
						</table>
					</form>
				</div>
			</div>
			</br>
			<span class="text_blue">( 오른쪽으로 스크롤 하세요. )</span>
		
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->


<input type="hidden" id="rejectKey" />


<script type="text/javascript">
function initPage() {
	debugger
	$('#grid').css({'display':'none'});
	$('#onlineEdu').css({'display':'none'});
	$('#eduSave').css({'display':'none'});
	$('#eduUpdate').css({'display':'none'});
	$('#eduDelete').css({'display':'none'});
	$('#excelUpload').css({'display':'none'});
	$('#excelDownload').css({'display':'none'});
	$('#searchBtn').css({'display':'none'});
	var enrollDate = $("#monthpicker").val().replace(/-/gi,"");
	$('#enroll_date').val(enrollDate);
	var month = $('#enroll_date').val();
	var data = {
			month : month
	}
	$.ajax({
		url: _g_contextPath_+"/educationManagement/onlineEduMonthYn",
		dataType : 'text',
		data : data,
		type : 'POST',
		success : function(result){
			if (result == 'Y') {
				$('#grid').css({'display':'block'});
				$('#eduUpdate').css({'display':'inline-block'});
				$('#eduDelete').css({'display':'inline-block'});
				$('#searchBtn').css({'display':'inline-block'});
				mainGrid();
				$("#headerCheckbox").prop('checked', false);
				$("#headerCheckbox").change(function(){
					debugger
					var checkedIds = {};
				    if($("#headerCheckbox").is(":checked")){
				    	$(".row-checkbox").prop("checked", "checked");
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
				    	$(".row-checkbox").removeProp("checked");
				    }
				});
			} else {
				$('#appendTbody').empty();
				$('#onlineEdu').css({'display':'inline-block'});
				$('#eduSave').css({'display':'inline-block'});
				$('#excelUpload').css({'display':'inline-block'});
				$('#excelDownload').css({'display':'inline-block'});
			}
		}
	})
	
}
$(document).ready(function() {
	initPage();
	
	
	$('#eduSave').on('click', function(){
		debugger
		var length = $('#appendTbody tr').length;
		console.log(length);
		if ( length == 0 ) {
			alert('엑셀양식을 업로드해주세요');
		} else {
			
			var typeObj = $('#appendTbody input').not($('input[name=middle_categorys]'))
																.not($('input[name=small_categorys]'))
																.not($('input[name=education_costs]'))
																.not($('input[name=education_process_codes]'))
			var bEmpty = true;
		    var focus;
		    typeObj.each(function(index) {
		        if ($(this).val() == '') {
		            focus = $(this);
		            bEmpty = false;
		 
		            alert("필수항목을 채워주세요.");
		            focus.focus();
		 
		            // 여기서는 each문을 탈출
		            return false;
		        }
		    });
		    
		    if (!bEmpty) return;
		    
		    console.log('저장')
			var queryString = $("form[name=onlineEduVO]").serialize() ;
			 
	        $.ajax({
	            type : 'post',
	            url :  _g_contextPath_+'/educationManagement/onlineEduSave',
	            data : queryString,
	            dataType : 'json',
	            error: function(xhr, status, error){
	                alert(error);
	            },
	            success : function(json){
	            	alert('저장하였습니다.')
	            	initPage();
	            	gridReload();
	            },
	        });
		}
		


	});
	
	$('#eduUpdate').on('click', function(){
		debugger
		var ch = $('.row-checkbox:checked');
		var data = new Array();
		grid = $('#grid').data("kendoGrid");
		$.each(ch, function(i,v){
			dataItem = grid.dataItem($(v).closest("tr"));
			
		});
		if ( ch.length > 1 ) {
			alert('하나만 체크해주세요.');
		} else if ( ch.length == 0 ) {
			alert('수정할 건을 체크해주세요.');
		} else {
			$('#popUp').data("kendoWindow").open();
		}
	})
	$('#eduDelete').on('click', function(){
		debugger
		var ch = $('.row-checkbox:checked');
		if (ch.length < 1) {
			alert('삭제할 목록을 체크해주세요');
		} else {
			var result = confirm('삭제 하시겠습니까?');
			
			if (result) {
				var ch = $('.row-checkbox:checked');
				var data = new Array();
				var subData = new Array();
				grid = $('#grid').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_id);
					subData.push(dataItem.education_person_id);
				});
				var aaa = {};
				aaa = data.join(',');
				var bbb = {};
				bbb = subData.join(',');
				
				var total = {};
				total = {
						aaa:aaa, 
						bbb:bbb
						};
				
				$.ajax({
					url: _g_contextPath_+"/educationManagement/onlineEduDel",
					dataType : 'text',
					data : total,
					type : 'POST',
					success : function(result){
						searchBtn();
						initPage();
					}
				})
			} else {
				searchBtn();
			}
		}
		
	})
	
	
	$("#excelUpload").click(function() {
		$('#fileID').val('');
		$('#fileID1').val('');
		$("#excelUploadForm").data("kendoWindow").open();

	});
	$('#excelDownload').on('click', function(){
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_ + '/educationManagement/onlineEduExcelDown';
	});
	function onClose() {

	}

	$("#uploadSave").click(function() {
		debugger
		var file = $("#fileNm").val();
		var options = {
			success : function(data) {
				debugger			
				$('#appendTbody').empty();
				for ( var i = 0; i < data.length ; i++ ) {
					
					$('#appendTbody').append(
							'<tr>'+
							'<td>'+
								'<input type="text" id="online_education_types" name="online_education_types" style="width: 120px" value="'+data[i].A+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="main_categorys" name="main_categorys" style="width: 120px" value="'+data[i].B+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="middle_categorys" name="middle_categorys" style="width: 120px" value="'+data[i].C+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="small_categorys" name="small_categorys" style="width: 120px" value="'+data[i].D+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_process_codes" name="education_process_codes" style="width: 120px" value="'+data[i].E+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_names" name="education_names" style="width: 485px" value="'+data[i].F+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_hours" name="education_hours" style="width: 120px" value="'+data[i].G+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_costs" name="education_costs" style="width: 120px" value="'+data[i].H+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_start_dates" name="education_start_dates" style="width: 120px" value="'+data[i].I+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_end_dates" name="education_end_dates" style="width: 120px" value="'+data[i].J+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_emp_names" name="education_emp_names" style="width: 120px" value="'+data[i].K+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_login_ids" name="scores" style="width: 120px" value="'+data[i].L+'"/>'+
							'</td>'+
							'<td>'+
								'<input type="text" id="education_erp_emp_nums" name="complete_states" style="width: 120px" value="'+data[i].M+'"/>'+
							'</td>'+
							'</tr>'
					
					);
					
				}
				$("#excelUploadForm").data("kendoWindow").close();
				/* location.reload(); */
			},
			type : "POST"
		};
		$("#excelUploadForm").ajaxSubmit(options);
	});

	$("#uploadCancle").click(function() {
		$("#excelUploadForm").data("kendoWindow").close();
	});

	$("#excelUploadForm").kendoWindow({
		width : "540px",
		height : "220px",
		visible : false,
		actions : [ "Close" ],
		close : onClose
	}).data("kendoWindow").center();
	
	
	$('.top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			searchBtn();
		};
	});
	/* kendo datepicker 년월 처리 년월 From */
	$("#monthpicker").kendoDatePicker({
		// defines the start view
		start : "year",

		// defines when the calendar should return date
		depth : "year",

		// display month and year in the input
		format : "yyyy-MM",
		parseFormats : [ "yyyy-MM" ],

		// specifies that DateInput is used for masking the input element
		culture : "ko-KR",
		dateInput : true
	});
	
	$("#monthpicker").attr("readonly", true);
});
	
	
	

var dataSource = new kendo.data.DataSource({
	serverPaging: false,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/onlineEduExcelList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.date = $('#monthpicker').val().replace('-','');
        	data.notIn = '';
     	return data;
     	}
    },
    schema: {
      data: function(response) {
        return response.list;
      },
      
      model: {
          fields: {

        	  education_cost: { type: "number" },
        	  education_id: { type: "string" },
       
          }
      }
    }

});
function getFileNm(e) {
	if ($('#fileID').val() != null || $('#fileID').val() != '') {
		var index = $(e).val().lastIndexOf('\\') + 1;
		var valLength = $(e).val().length;
		$('#fileID1').val($(e).val().substr(index, valLength));
	}
	
}

function uploadBtn(e) {
	$(e).next().click();
}

$(function(){
	
	
	
	$("#monthpicker").on('change', function() {
		var chgDate = $("#monthpicker").val().replace(/-/gi,"");
		$('#enroll_date').val(chgDate);
		initPage();
	});
	
	
});



function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
}

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        height: 500,
        scrollable:{
            endless: true
        },
        sortable: true,       
        persistSelection: true,
        selectable: "multiple",
        
        columns: [
        	
        	{
        		headerTemplate: "<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",
            	template: "<input type='checkbox' id='private#=education_id#'   class='k-checkbox row-checkbox'/><label for='private#=education_id#' class='k-checkbox-label'></label>",
                title: "선택",
               	width : 60,
             },{
                field: "online_education_type",
                title: "구분",
            },{
                field: "main_category",
                title: "대분류",
                width : 110
            }, {
            	
                field: "middle_category",
                title: "중분류",
               
            }, {
                field: "small_category",
                title: "소분류",
            }, {
            	
                field: "education_process_code",
                title: "과정코드",
            }, {
                field: "education_name",
                title: "교육명",
               	width : 500
            },{
                field: "education_hour",
               title: "학습시간",
                
            }, {
                field: "education_cost",
                title: "교육비",
                format: "{0:n0}",
            }, {
                field: "education_start_date",
                title: "학습시작일",          
            }, {
            	field: "education_end_date",
                title: "학습종료일",
            },{
                field: "emp_name",
                title: "이름",
           	},{
                field: "login_id",
                title: "ID",
            },{
                field: "education_erp_emp_num",
                title: "사번",
            },{
                field: "education_dept_name",
                title: "부서",
            },{
                field: "score",
                title: "취득점수",
            },{
                field: "complete_yn",
                title: "수료여부",
            }],
        change: function (e){
        	gridClick(e)
        }
    }).data("kendoGrid");
	
	grid.table.on("click", ".row-checkbox", selectRow);
	
	var checkedIds = {};
	
	// on click of the checkbox:
	function selectRow(){
		
		var checked = this.checked,
		row = $(this).closest("tr"),
		grid = $('#grid').data("kendoGrid"),
		dataItem = grid.dataItem(row);
		
		checkedIds[dataItem.education_id] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	function gridClick(){
		var rows = grid.select();
		var record;
		rows.each(function() {
			record = grid.dataItem($(this));
			console.log(record);
		});
		$('#education_id').val(record.education_id);
		$('#online_education_type').val(record.online_education_type);
		$('#main_category').val(record.main_category);
		$('#middle_category').val(record.middle_category);
		$('#small_category').val(record.small_category);
		$('#education_process_code').val(record.education_process_code);
		$('#education_name').val(record.education_name);
		$('#education_hour').val(record.education_hour);
		$('#education_cost').val(record.education_cost);
		$('#eduCostInput').val(record.education_cost);
		$('#education_start_date').val(record.education_start_date);
		$('#education_end_date').val(record.education_end_date);
		$('#education_person_id').val(record.education_person_id);
		$('#education_erp_emp_num').val(record.education_erp_emp_num);
		$('#education_dept_name').val(record.education_dept_name);
		$('#score').val(record.score);
		if (record.complete_yn == 'Y') {
			$('#completeStatetYn').prop('checked', true);
			$('#complete_state_code_id').val('EC04');
			$('#complete_state').val('수료');
		} else {
			$('#completeStatetYn').prop('checked', false);
			$('#complete_state_code_id').val('EC05');
			$('#complete_state').val('미수료');
		}
		
		
     
		
	}
}

		function searchBtn() {
			 gridReload();
			 $('#deptName').val('all');
			 $('#empName').val('');
			 $('#userSeq').val('');
			 $('#deptName2').val('');
			 
			
			}
 
	
	
	
	
	</script>




<form class="pop_wrap_dir" id="excelUploadForm"
				name="excelUploadForm" style="width: 540px;"
				enctype="multipart/form-data" method="post" action= "<c:url value="/educationManagement/onlineEduExcelUploadAjax"/>">
				<div class="pop_head">
					<h1>업로드</h1>
				</div>
				<div class="pop_con">

					<p class="mb10">
						<span class="text_red">10MB</span>이하의 파일만 등록 할 수 있습니다. <span
							class="text_red"></span>엑셀 파일만 업로드 가능합니다.
					</p>
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="120" />
								<col width="" />
							</colgroup>
							<tr>
								<th>파일첨부</th>
								<td class="le">
									<div class="clear">
										<input type="text" id="fileID1"
											class="file_input_textbox clear" readonly="readonly"
											style="width: 280px;" />

										<div class="file_input_div">
											<input type="button" onclick="uploadBtn(this);" value="업로드"
												class="file_input_button ml4 normal_btn2"> <input
												type="file" id="fileID" name="fileNm" class="hidden"
												onchange="getFileNm(this);" />
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<!-- //pop_con -->
				<div class="pop_foot">
					<div class="btn_cen pt12">
						<input type="button" id="uploadSave" value="가져오기" /> <input
							type="button" class="gray_btn" id="uploadCancle" value="취소" />
					</div>
				</div>
			</form>
			
			
			<div class="pop_wrap_dir" id="popUp" style="width:1000px;">
		<div class="pop_head">
			<h1>온라인교육 수정</h1>
			
		</div>
		
		<div class="pop_con">
			<div class="com_ta" style="">
				<div class="top_box gray_box">
							<form action="" method="post" name="onlineData" id="onlineData" enctype="multipart/form-data">
							<dl >
							<dt style="width:80px;">교육명</dt>
							<dd>
								<input style="width:683px" type="text" id="education_name" name="education_name" />
								<input type="hidden" id="education_person_id" name="education_person_id" value="" />
								<input type="hidden" id="education_id" name="education_id" value="" />
								
							</dd>
															
							</dl>
							<dl class="next2">
								<dt style="width:80px;">구분</dt>
								<dd>
									<input type="text" id="online_education_type" name="online_education_type" style="width: 150px" value="" />
									
								</dd>
								<dt style="width:80px;">과정코드</dt>
								<dd>
									<input type="text" id="education_process_code" name="education_process_code" style="width: 150px" value="" />
								</dd>
								<dt style="width:80px;">학습시간</dt>
								<dd>
									<input type="text" id="education_hour" name="education_hour" style="width: 150px" value="" />
								</dd>
								
								<dd>
									<input type="hidden" id="education_type_code_id" name="education_type_code_id" value="ED03"/>
									<input type="hidden" id="education_type" name="education_type" value="온라인교육" />
								</dd>	
								
							</dl>
							<dl class="next2">
								<dt style="width:80px;">대분류</dt>
								<dd>
									<input type="text" id="main_category" name="main_category" style="width: 150px" value="" />
								</dd>
								<dt style="width:80px;">중분류</dt>
								<dd>
									<input type="text" id="middle_category" name="middle_category" style="width: 150px" value="" />
								</dd>
								<dt style="width:80px;">소분류</dt>
								<dd>
									<input type="text" id="small_category" name="small_category" style="width: 150px" value="" />
								</dd>
							</dl>
							
							
							
							<dl class="next2">
								<dt style="width:80px;">학습시작일</dt>
								<dd>
									<input type="text" id="education_start_date" name="education_start_date" class="w113 datePickerInput" style="width: 152px" value="" />
								</dd>
								<dt style="width:80px;">학습종료일</dt>
								<dd>
									<input type="text" id="education_end_date" name="education_end_date" class="w113 datePickerInput" style="width: 152px" value="" />
								</dd>
								<dt style="width:80px;">사번</dt>
								<dd>
									<input type="text" id="education_erp_emp_num" name="education_erp_emp_num" style="width: 150px" value="" />
								</dd>
								
							</dl>
							
							<dl class="next2">
								<dt style="width:80px;">교육비</dt>
								<dd>
									<input type="text" id="eduCostInput" name="" class="inputNumber"  style="width: 150px"/>
									<input type="hidden" id="education_cost" name="education_cost" class="inputNumber"  style="width: 150px"/>
								</dd>
								<dt style="width:80px;">취득점수</dt>
								<dd>
									<input type="text" id="score" name="score" style="width: 150px" value="" />
								</dd>				
								<dt style="margin-left: ;width:80px;">
								
								수료여부
								</dt>
								<dd style="margin-left: 3px">
									<input type="checkbox" id="completeStatetYn" value="" checked="checked"/><label for="completeStatetYn"></label>		
									<input type="hidden" id="complete_state_code_id" name="complete_state_code_id" value="EC04" />
									<input type="hidden" id="complete_state" name="complete_state" value="수료" />					
								</dd>
								
							</dl>
							
							
							</form>
						</div>
					</div>	
						
		</div><!-- //pop_con -->
		
		<div class="pop_foot">
			<div class="btn_cen pt12">

				<input type="button" class="blue_btn" id="fn_privateEduReg" onclick="" value="수정" />
			</div>
		</div>
		<!-- //pop_foot -->
	
	</div><!-- //pop_wrap -->
			