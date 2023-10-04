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
				<dt class="ar" style="width: 65px">년도</dt>
				<dd>
					<input type="text" value="${nowDate}" name="" id="monthpicker"
						placeholder="" />
				</dd>
				
				<dt class="ar" style="width: 65px">성명</dt>
				<dd>
					<input type="text" id="empName" 
						value="${userName }" style="" disabled="disabled"/>
				</dd>
			</dl>

		</div>

		<!-- 버튼 -->
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">교육 이수 현황</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>

		<div class="com_ta2 mt15">
			<div id="grid"></div>
		</div>
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">교육 이수 상세</p>
			</div>

		</div>
		<div class="com_ta2 mt15">
			<div id="grid2"></div>
		</div>
	</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->
<div class="pop_wrap_dir" id="resultEduPop" style="width:400px; display: none;">
		<div class="pop_con">
			<!-- 타이틀/버튼 -->
			<div class="btn_div mt0">
				<div class="left_div">
					<h5><span id="popupTitle"></span> 결과보고서</h5>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
					</div>
				</div>
			</div>
	<div class="com_ta" style="" id="">
		<table id="resultEduFileDiv"></table>
	</div>
	</div>
	<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" class="gray_btn" value="닫기" onclick="popCancel();"/>
			</div>
		</div><!-- //pop_foot -->
	</div>

<input type="hidden" id="userSeq" value="${userSeq }"/>


<script type="text/javascript">
$(document).ready(function() {
	
	
	$('.top_box input[type=text]').on('keypress', function(e) {
		if (e.key == 'Enter') {
			searchBtn();
		};
	});
	/* kendo datepicker 년월 처리 년월 From */
	$("#monthpicker").kendoDatePicker({
		// defines the start view
		start : "decade",

		// defines when the calendar should return date
		depth : "decade",

		// display month and year in the input
		format : "yyyy",
		parseFormats : [ "yyyy" ],

		// specifies that DateInput is used for masking the input element
		culture : "ko-KR",
		dateInput : true
	});
	/* kendo datepicker 년월 처리 년월 From */
	$("#monthpicker").attr("readonly", true);
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
    
    function gridDataBound2(e) {
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
            url: _g_contextPath_+'/educationManagement/privateEduStsList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.year = $('#monthpicker').val();
      		data.education_emp_seq = $('#userSeq').val();
      		data.education_dept_name = '전체';
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

        	  privateEduCostTotal: { type: "number" },
        	  educationEduCostTotal: { type: "number" }
       
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

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
		dataSource: dataSource,
        dataBound: gridDataBound,
        scrollable:{
            endless: true
        },
        sortable: true,
       /*  pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        }, */
        persistSelection: true,
        selectable: "multiple",
        
        columns: [
        	
        	 {
            field: "yearlyEduTime",
            title: "연간교육</br>이수시간",
        }, {
        	
            field: "groupEduTotal",
            title: "공통집합교육</br>이수시간",
           
        }, {
            field: "onlineEduTotal",
            title: "온라인교육</br>이수시간",
           
        }, {
        	
            field: "privateEduTotal",
            title: "개인선택교육</br>이수시간",
        }, {
            field: "eduTotal",
            title: "교육 이수시간 총합",
        }, {
            field: "requiredOnline",
            title: "온라인 필수</br>이수여부",
        }, {
            field: "customerService",
            title: "필수교육</br>(스포츠안전교육)</br>이수여부",
            
        }, {
            field: "fourViolence",
            title: "필수교육</br>(법정의무교육(3개))</br>이수여부",
            
        }, {
            field: "antiCorruption",
            title: "전문교육</br>(전문가 양성)</br>이수여부",          
        }, {
            field: "onlineEduCostTotal",
            title: "온라인교육비",
            format: "{0:n0}",
        }, {
            field: "privateEduCostTotal",
            title: "개별교육비 (원)",
            format: "{0:n0}",
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
		
		
	}
}

var dataSource2 = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/privateEduStsDetailList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.year = $('#monthpicker').val();
      		data.education_emp_seq = $('#userSeq').val();   
      		data.education_dept_name = '전체';
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
        	  education_id: { type: "string" },
        	  education_person_id: { type: "string" },
        	  complete_hour: { type: "string" },
        	  required_yn: { type: "string" },
        	  education_type_code_id: { type: "string" },
        	  education_cost: { type: "number" },
        	  
          }
      }
    }

       
});
function popCancel(){
	$('#resultEduPop').data("kendoWindow").close();
}

$(function(){
	$('#resultEduPop').kendoWindow({
	    width: "400px",
	    title: '결과보고서 확인',
	    visible: false,
	    modal : true,
	    actions: [
	        "Close"
	    ],
	}).data("kendoWindow").center();
	mainGrid2();
	

});

function gridReload2(){
	/* $('#grid2').data('kendoGrid').dataSource.read(); */
	$("#grid2").data("kendoGrid").dataSource.page(1);
}
function resultReport(row) {
	var type = row.education_type_code_id;
	switch (type) {
	case 'ED02':
			return '<input type="button" id="" class="text_blue" onclick="resultFileRow(this);" value="결과보고서">';
		break;

	default:
			return '';
		break;
	}
	
}
function resultFileRow(e){
	 var dataItem = $("#grid2").data("kendoGrid").dataItem($(e).closest("tr"));
	 var key = dataItem.education_id;
	 $('#popupTitle').text(dataItem.education_name)
	 var data = {
				keyId : key,	
				fileName : 'tpf_education'
		}
	 $('#resultEduFileDiv').empty();
	 $.ajax({
			url: _g_contextPath_+"/common/fileList",
			dataType : 'json',
			data : data,
			type : 'POST',
			success: function(result){
				
				
				if (result.list.length > 0) {
					for (var i = 0 ; i < result.list.length ; i++) {
						
						if(i==0) {	
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th>첨부파일 목록</th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
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
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="eduFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									'<input type="hidden" id="eduFileKey" value="'+result.list[i].attach_file_id+'" />'+
									'<input type="hidden" id="eduFileSeq" value="'+result.list[i].file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);
						}
					}
				} else {
					$('#resultEduFileDiv').append(
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
	 
	 $.ajax({
			url: _g_contextPath_+"/educationManagement/eduResultFileList",
			dataType : 'json',
			data : data,
			type : 'POST',
			success: function(result){
				if (result.list.length > 0) {
					for (var i = 0 ; i < result.list.length ; i++) {
						
						if(i==0) {	
							$('#resultEduFileDiv').append(
									'<tr id="test">'+
									'<th>결과보고서</th>'+
									'<td class="le">'+
									'<span style=" display: block;" class="mr20">'+
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="resultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
									'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
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
									'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />&nbsp;'+								
									'<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF" id="fileText" onclick="resultFileDown(this);" class="file_name">'+result.list[i].real_file_name+'.'+result.list[i].file_extension+'</a>&nbsp;'+
									'<input type="hidden" id="resultEduFileKey" value="'+result.list[i].education_result_id+'" />'+
									'<input type="hidden" id="resultEduFileSeq" value="'+result.list[i].education_file_seq+'" />'+
									'</span>'+
									'</td>'+
									'</tr>'
							);
						}
					}
				} else {
					$('#resultEduFileDiv').append(
						'<tr id="test">'+
						'<th>결과보고서</th>'+
						'<td class="le">'+
						'<span class="mr20">'+	
						'<img src="<c:url value="/Images/ico/ico_clip02.png"/>" alt="" />'+
						'<a href="#n" style="color: #808080" id="fileText">&nbsp;결과보고서가 없습니다.'+
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
function eduFileDown(e){
	debugger
	var row = $(e).closest("tr");
	var attach_file_id = row.find('#eduFileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			attach_file_id : row.find('#eduFileKey').val(),
			file_seq : row.find('#eduFileSeq').val()
			
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
function resultFileDown(e){
	debugger
	var row = $(e).closest("tr");
	var education_result_id = row.find('#resultEduFileKey').val();
	var data = {
			fileNm : row.find('#fileText').text(),
			education_result_id : row.find('#resultEduFileKey').val(),
			file_seq : row.find('#resultEduFileSeq').val()
			
	}
	
	$.ajax({
		url : _g_contextPath_+'/educationManagement/fileDown',
		type : 'GET',
		data : data,
	}).success(function(data) {
		
		var downWin = window.open('','_self');
		downWin.location.href = _g_contextPath_+'/educationManagement/fileDown?education_result_id='+education_result_id;
	});
	
}
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
function mainGrid2(){
	//캔도 그리드 기본
	var grid2 = $("#grid2").kendoGrid({
        dataSource: dataSource2,
        dataBound: function(e)
        {
            //console.log(this.dataSource.data());
            this.fitColumns();
            gridDataBound2(e);
          },
        height: 400,
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
            field: "educationType",
            title: "교육구분",
        }, {
            field: "enforcement_dept_name",
            title: "주관부서",
        }, {
            field: "onlineEduDiv",
            title: "온라인 교육구분",
        }, {
            field: "education_name",
            title: "교육명",
            width: 200
        }, {
            field: "education_place",
            title: "교육장소",
        },{
//         	template: "#= complete_hour # 시간", 
            field: "complete_hour",
            title: "이수시간",
        }, {
            field: "eduStart",
            title: "교육시작일",
        }, {
            field: "eduEnd",
            title: "교육종료일",
        }, {
        	template : "<input type='checkbox' id='required_yn#=education_id#' disabled='disabled' #= required_yn != 'Y' ? '' : \'checked=checked\' # class='k-checkbox checkbox'/><label for='required_yn#=education_id#' class='k-checkbox-label'></label>",
            field: "required_yn",
            title: "필수/전문",
        },{
            field: "score",
            title: "취득점수",
        }, {
            field: "education_cost",
            title: "교육비 (원)",
            format: "{0:n0}",
        }, {
            template: resultReport,
            title: "결과보고서",
        }],
        change: function (e){
        	gridClick2(e)
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
		
		checkedIds[dataItem.CODE_CD] = checked;
		if (checked) {
			//-select the row
			row.addClass("k-state-selected");
		} else {
			//-remove selection
			row.removeClass("k-state-selected");
		}
		
	}
	function gridClick2(){
		 var rows = grid2.select();
		var record;
		rows.each( function(){
			record = grid2.dataItem($(this));
			console.log(record);
		}); 
	}
}

	
	


function searchBtn() {
	$('#mainKey').val('');
	gridReload();
	gridReload2();
}
		
	</script>
	
