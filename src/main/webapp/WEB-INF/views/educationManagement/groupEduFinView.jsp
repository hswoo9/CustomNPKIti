<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="nowDate" class="java.util.Date" />
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src="<c:url value='/js/jquery.form.js' />"></script>
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
				<dt class="ar" style="width: 65px">기간</dt>
				<dd>
					<input type="text" value="${year }-01" name="" id="monthpicker"
						placeholder="" />&nbsp;~ <input type="text" value="${nowDate}" name=""
						id="monthpicker2" placeholder="" />

				</dd>
				<dt class="ar" style="width: 65px">시행부서</dt>
				<dd>
					<input type="text" id="deptName" />
				</dd>
				<dt class="ar" style="width: 65px">교육명</dt>
				<dd>
					<input type="text" id="eduName" 
						value="" style="width: 200px"/>
				</dd>
			</dl>

		</div>

		<!-- 버튼 -->
		<div class="btn_div mt10 cl">

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="eduFinApproval" onclick="" style="display: none;">이수처리</button>
					<button type="button" id="" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>

		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0"></p>
			</div>

		</div>
		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">교육 대상자</p>
			</div>

		</div>
		<div class="com_ta2 mt15">
			<div id="grid2"></div>
			
		</div>
		<div class="com_ta2 mt15">
			<div id="fileDiv" style="display: none;">
				<form id="fileForm" method="post" enctype="multipart/form-data">	
					<table>
						<colgroup>
							<col width="100"/>
							<col width=""/>								
						</colgroup>
						<tr  id="fileTr">
							<th>파일</th>
							<td class="le">
								<input type="text" id="fileID1" class="file_input_textbox clear" value="" readonly="readonly" style="text-align: center;" placeholder="파일 선택" /> 
								<input type="button" onclick="" 	value="업로드" class="file_input_button ml4 normal_btn2" /> 
								<input type="file" id="fileID" name="file_name" value="" class="hidden" onchange="getFileNm(this);" />
								<input type="hidden" name="mainKey" id="mainKey" />
								<input type="hidden" name="checked" id="checked" />
								<input type="hidden" name="notChecked" id="notChecked" />
								
								(출석부 증빙자료)
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->





<script type="text/javascript">
$(document).ready(function() {
	fnTpfDeptComboBoxInit('deptName');
	$('#eduFinApproval').on('click', function(){
		var fileYn = new Array();
		$('#fileKey').each(function(i){
			var value = $(this).val();
			fileYn.push(value);
		});
		if ( $('#fileID1').val() == null || $('#fileID1').val() == '' && fileYn.length == 0) {
			alert('출석부 증빙자료를 선택해주세요');
		} else {
			debugger
			
			var result = confirm('이수처리 하시겠습니까?');
			if (result) {
				var ch = $('.checkbox:checked');
				var unCh = $('.checkbox:not(:checked)');
				var data = new Array();
				var data2 = new Array();
		   		grid = $('#grid2').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_person_id);
				});
				$.each(unCh, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data2.push(dataItem.education_person_id);
				});
		   		$('#checked').val(data.join(','));
		   		$('#notChecked').val(data2.join(','));
		   		
// 		   		var formData = new FormData($("#fileForm")[0]);
		   		
// 		   		$.ajax({
// 					url : _g_contextPath_+"/educationManagement/eduFinApproval",

// 					data : formData,
// 					type : 'post',
// 					processData : false,
// 					contentType : false,
// 					async: false,
// 					success : function(result) {
// 						alert("저장 되었습니다.");
// 						searchBtn();
// 					},
// 					error : function(error) {

// 						console.log(error);
// 						console.log(error.status);
// 					}
// 				});
		   		
		   		$("#fileForm").ajaxSubmit({
					url : _g_contextPath_+"/educationManagement/eduFinApproval",
			
					data : {},
					type : 'post',
					processData : false,
					async: false,
					contentType : false,
					success : function(result) {
						alert("저장 되었습니다.");
						location.reload();
					},
					error : function(error) {
			
						console.log(error);
						console.log(error.status);
					}
				});
		   		
			} else {
				
			}
		}
			
		
   		
	})
	
	$(".file_input_button").on("click",function(){
		$(this).next().click();
	});
	
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
	/* kendo datepicker 년월 처리 년월 To */
	$("#monthpicker2").kendoDatePicker({
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
	$("#monthpicker2").attr("readonly", true);
	
	
	
});


function fnTpfDeptComboBoxInit(id){
	debugger
		if($('#'+id)){
			var deptList = fnTpfGetDeptList();
			deptList.unshift({dept_name : "전체", dept_name : "전체"});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : deptList,
				dataTextField: "dept_name",
				dataValueField: "dept_name",
				index: 0,
// 				value: '<c:out value="${deptList.dept}"/>',
// 				enable: false,
				change:function(){
					fnDeptChange();
				}
		    });
		}
	}
 function fnTpfGetDeptList(){
	 debugger
		var result = {};
		var params = {};
	    var opt = {
	    		url     : _g_contextPath_ + "/common/getDeptList",
	            async   : false,
	            data    : params,
	            successFn : function(data){
	            	result = data.allDept;
	            }
	    };
	    acUtil.ajax.call(opt);
		return result;
	}
 
 function fnDeptChange(){
		var obj = $('#deptName').data('kendoComboBox');
		/* $('#txtDeptCd').val(obj._old);
		$('#txtDeptName').val(obj._prev); */
		$('#deptSeq').val(obj._old);
	}

	function gridDataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	
	
    function grid2DataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	
	
	
	

var dataSource = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/eduList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.dateFr = $('#monthpicker').val();
      		data.dateTo = $('#monthpicker2').val();
      		data.deptName = $('#deptName').val();
        	data.eduName = $('#eduName').val();
        	data.eduDn = 'G';
        	data.approval = 'Y';
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
        	  education_id : {type:"string"},	
        	  required_yn: { type: "string" },
        	  education_hour: { type: "string"}
       
          }
      }
    }

       
});


$(function(){
	
	mainGrid();
	

});

function gridReload(){
	/* $('#grid').data('kendoGrid').dataSource.read(); */
	$("#grid").data("kendoGrid").dataSource.page(1);
}

function eduStep(row) {
	var html;
	
	if ( row.education_step_code_id == 'ES01' ) {
		html = '<span class="">'+row.eduStep+'</span>';
	} else if ( row.education_step_code_id == 'ES04' ){
		html = '<span class="text_red">'+row.eduStep+'</span>';
	} else {
		html = '<span class="text_blue">'+row.eduStep+'</span>';
	}
	
	return html;
	
}

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        dataBound: gridDataBound,
        height: 250,
        scrollable:{
            endless: true
        },
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        persistSelection: true,
        selectable: "multiple",
        
        columns: [
        	
        	 {
            template: eduStep,
            title: "단계",
           
        }, {
        	
            field: "enforcement_dept_name",
            title: "시행부서",
            
        }, {
            field: "education_name",
            title: "교육명",
           
        }, {
        	
            field: "education_place",
            title: "교육장소",

        }, {
        	
	    	template: "#=education_hour#시간",
            field: "education_hour",
            title: "교육시간",
        }, {
            field: "eduStDt",
            title: "교육시작일",
            
        }, {
            field: "eduEdDt",
            title: "교육종료일",
          

        }, {
        	template : "<input type='checkbox' id='required_yn#=education_id#' disabled='disabled' #= required_yn != 'Y' ? '' : \'checked=checked\' # class='k-checkbox checkbox2'/><label for='required_yn#=education_id#' class='k-checkbox-label'></label>",
            field: "required_yn",
            title: "필수",
        }],
        change: function (e){
        	gridClick(e)
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
		debugger
		$('#eduFinApproval').css({'display':'none'});
		var rows = grid.select();
		var record;
		rows.each(function() {
			record = grid.dataItem($(this));
			console.log(record);
		});
		$('#mainKey').val(record.education_id);
		if ( record.education_step_code_id == 'ES02' ) {
			
			$('#eduFinApproval').css({'display':'inline-block'});
			$('#fileDiv').css({'display':'block'});
			$('#fileID1').val('');
			fileList($('#mainKey').val());
			
		} else if ( record.education_step_code_id == 'ES04' ) {
			
			$('#fileDiv').css({'display':'none'});
			$('#fileID1').val('');
			
		} else if ( record.education_step_code_id == 'ES03' ) {
			
			$('#fileDiv').css({'display':'block'});
			$('#fileID1').val('');
			fileList($('#mainKey').val());
			
		}
		
		
		
		gridReload2();
		$("#headerCheckbox").prop('checked',false);
	}
}




var dataSource2 = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 200,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/groupEduDetailList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		
        	data.education_id = $('#mainKey').val();
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
        	  education_person_id: { type: "string" },
        	  complete_state_code_id: { type: "string" },
             
       
          }
      }
    }

       
});


$(function(){
	
	mainGrid2();
	
	$("#headerCheckbox").change(function(){
		debugger
		var checkedIds = {};
        if($("#headerCheckbox").is(":checked")){
        	$(".checkbox").prop("checked", "checked");
        	var checked = this.checked,
            row = $(this).closest("tr"),
            grid = $("#grid2").data("kendoGrid"),
            dataItem = grid.dataItem(row);

            checkedIds[dataItem.emp_seq] = checked;

            if (checked) {
                row.addClass("k-state-selected");

            } else {
                row.removeClass("k-state-selected");
               
            }
        }else{
        	$(".checkbox").removeProp("checked");
        }
    });

});

function gridReload2(){
	/* $('#grid2').data('kendoGrid').dataSource.read(); */
	$("#grid2").data("kendoGrid").dataSource.page(1);
}
function fn_workStep(row) {
	var step = row.complete_state_code_id;
	var key = row.education_person_id;
	switch (step) {
		
		case 'EC02' : return '<input type="checkbox" id="finEdu'+key+'" checked="checked" disabled="disabled" class="k-checkbox checkbox"/><label for="finEdu'+key+'" class="k-checkbox-label"></label>'; 
			break;
		case 'EC03' : return ''; 
			break;
		case 'EC04' : return ''; 
			break;
		default  : return '<input type="checkbox" id="finEdu'+key+'" class="k-checkbox checkbox"/><label for="finEdu'+key+'" class="k-checkbox-label"></label>';
			break;

	}
	
}
function mainGrid2(){
	//캔도 그리드 기본
	var grid2 = $("#grid2").kendoGrid({
        dataSource: dataSource2,
        dataBound: grid2DataBound,
        height: 250,
        scrollable:{
            endless: true
        },
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        persistSelection: true,
        selectable: "multiple",
        
        columns: [        	
        	{	
        		headerTemplate: "<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",
            	template: fn_workStep,
               	width : 50,
             },{
            field: "education_dept_name",
            title: "부서",
        }, {
            field: "empName",
            title: "성명",
        }, {
            field: "education_position",
            title: "직급",
        }, {
            field: "education_duty",
            title: "직책",
            
        }
        
        ],
        change: function (e){
        	
        }
    }).data("kendoGrid");
	
	grid2.table.on("click", ".checkbox", selectRow2);
	
	var checkedIds = {};
	
	// on click of the checkbox:
	function selectRow2(){
		
		var checked = this.checked,
		row = $(this).closest("tr"),
		grid2 = $('#grid2').data("kendoGrid"),
		dataItem = grid2.dataItem(row);
		
		checkedIds[dataItem.education_person_id] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	
}



function getFileNm(e) {
	
	var index = $(e).val().lastIndexOf('\\') + 1;
	var valLength = $(e).val().length;
	var row = $(e).closest('tr');
	var fileNm = $(e).val().substr(index, valLength);
	row.find('#fileID1').val(fileNm);
	row.find('#fileText').text(fileNm).css({'color':'#0033FF','margin-left':'5px'});
}


function searchBtn() {
	$('#mainKey').val('');
	$('#fileID1').val('');
	$('#fileDiv').css({'display':'none'});
	gridReload();
	gridReload2();
}


function fileList(e) {
	
	var data = {
			keyId : e,	
			fileName : 'tpf_education'
	}
	$.ajax({
		url: _g_contextPath_+"/common/fileList",
		dataType : 'json',
		data : data,
		type : 'POST',
		success: function(result){
			$('#fileTr').nextAll().empty();
			if (result.list.length > 0) {
				for (var i = 0 ; i < result.list.length ; i++) {
					$('#test').eq(i).empty();
					if(i==result.list.length-1) {
						$('#fileTr').after(
								'<tr id="test">'+
								'<th>첨부파일 목록</th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="fileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<input type="hidden" id="fileKey" value="'+result.list[i].attach_file_id+'" />'+
								'<input type="hidden" id="fileSeq" value="'+result.list[i].file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);		
					} else {
						$('#fileTr').after(
								'<tr id="test">'+
								'<th></th>'+
								'<td class="le">'+
								'<span style=" display: block;" class="mr20">'+
								'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
								'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="fileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
								'<input type="hidden" id="fileKey" value="'+result.list[i].attach_file_id+'" />'+
								'<input type="hidden" id="fileSeq" value="'+result.list[i].file_seq+'" />'+
								'</span>'+
								'</td>'+
								'</tr>'
						);
					}
								
				}
			} else {
				$('#fileTr').after(
					'<tr id="test">'+
					'<th>첨부파일 목록</th>'+
					'<td class="le">'+
					'<span class="mr20">'+	
					'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
					'<a href="#n" style="color: #808080" id="fileText">&nbsp;첨부파일이	없습니다.'+
					'</a>'+
					'</span>'+
					'</td>'+
					'</tr>'
				);
			}
		}
	});
}

function fileDown(e){
	
	var row = $(e).closest("tr");
	var attach_file_id = row.find('#fileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			attach_file_id : row.find('#fileKey').val(),
			file_seq : row.find('#fileSeq').val()
			
	}
	
	$.ajax({
		url : _g_contextPath_+'/common/fileDown',
		type : 'GET',
		data : data,
	}).success(function(data) {
		
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_+'/common/fileDown?attach_file_id='+attach_file_id;
	});
	
}

function fileDel(e) {
	var row = $(e).closest('tr');
	var data = {
			attach_file_id : row.find('#fileKey').val()
	}
	
	$.ajax({
		url : _g_contextPath_+'/common/fileDelete',
		type : 'POST',
		data : data
	}).success(function(data) {
		searchBtn();
	});
	
}
	</script>
	
