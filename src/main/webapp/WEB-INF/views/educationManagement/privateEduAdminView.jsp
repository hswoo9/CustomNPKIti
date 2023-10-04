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
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>


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
				
				<dt class="ar" style="width: 65px">부서</dt>
				<dd>
					<input type="text" id="deptName" />
				</dd>
				<dt class="ar" style="width: 65px">성명</dt>
				<dd>
					<input type="text" id="empName" disabled="disabled" value="" /> 
					<input type="hidden" id="userSeq" disabled="disabled" value="" /> 
					<input type="hidden" id="deptName2" value="" /> 
					<input type="hidden" id="deptSeq" value="" />
				</dd>
				<dd>
					<input type="button" id="emp" value="검색" />
				</dd>
			</dl>

		</div>

		<!-- 버튼 -->
		<div class="btn_div mt10 cl">

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="eduComplete" onclick="">이수</button>
					<button type="button" id="eduReject" onclick="">반려</button>
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
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->


<input type="hidden" id="rejectKey" />


<script type="text/javascript">
$(document).ready(function() {
	fnTpfDeptComboBoxInit('deptName');
	$('#rejectBtn').on('click', function() {
		var result = confirm('반려 하시겠습니까?');
		if(result) {
			var ch = $('.checkbox:checked');
			var data = new Array();
			var return_cause = $('#return_cause').val();
	   		grid = $('#grid').data("kendoGrid");
			$.each(ch, function(i,v){
				dataItem = grid.dataItem($(v).closest("tr"));
				data.push(dataItem.education_person_id);
			});
			var allData = {
	   				data : data.join(','),
	   				return_cause : return_cause
	   		}
			$.ajax({
				url : _g_contextPath_+"/educationManagement/privateFinReject",
				dataType : 'text',
				data : allData,
				type : 'post',			
				success : function(result) {
					alert("저장 되었습니다.");
					$("#popUp").data("kendoWindow").close();
					searchBtn();
				},
				error : function(error) {

					console.log(error);
					console.log(error.status);
				}
			});
		} else {
			
		}
	});
	
	$('#eduComplete').on('click', function() {
		
		var ch = $('.checkbox:checked');
		var data = new Array();
		if ( ch.length == 0 ) {
			alert('이수할 목록을 체크해주세요.');
		} else {
			grid = $('#grid').data("kendoGrid");
			$.each(ch, function(i,v){
				dataItem = grid.dataItem($(v).closest("tr"));
				data.push(dataItem.education_person_id);
			});
	   		var allData = {
	   				data : data.join(','),
	   		}
	   		$.ajax({
				url : _g_contextPath_+"/educationManagement/privateFinApproval",
				dataType : 'text',
				data : allData,
				type : 'post',			
				success : function(result) {
					alert("저장 되었습니다.");
					searchBtn();
				},
				error : function(error) {

					console.log(error);
					console.log(error.status);
				}
			});
		}
		
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
	function gridDataBound(e) {
        var grid = e.sender;         
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };	
	
    function fnTpfDeptComboBoxInit(id){
    	
    		if($('#'+id)){
    			var deptList = fnTpfGetDeptList();
    			deptList.unshift({dept_name : "전체", dept_seq : "all"});
    			var itemType = $("#" + id).kendoComboBox({
    				dataSource : deptList,
    				dataTextField: "dept_name",
    				dataValueField: "dept_seq",
    				index: 0,
    				change:function(){
    					fnDeptChange();
    				}
    		    });
    		}
    	}
     function fnTpfGetDeptList(){
    	 
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
    		empGridReload();
    		
    		
    	}	
	

var dataSource = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/educationManagement/privateEduList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
      		data.dateFr = $('#monthpicker').val();
      		data.dateTo = $('#monthpicker2').val();
      		data.education_emp_seq = $('#userSeq').val();
      		data.complete_state_code_id = '';
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

        	  education_cost: { type: "number" },
        	  education_id: { type: "string" },
       
          }
      }
    }

       
});


$(function(){
	
	mainGrid();
	
$("#headerCheckbox").change(function(){
		
		var checkedIds = {};
	    if($("#headerCheckbox").is(":checked")){
	    	$(".checkbox").prop("checked", "checked");
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
	    	$(".checkbox").removeProp("checked");
	    }
	});

});

function gridReload(){
	$('#grid').data('kendoGrid').dataSource.read();
}

function completeState(row) {
	var html;
	
	if ( row.complete_state_code_id == 'EC03' ) {
		html = '<span class="text_red">'+row.completeState+'</span>';
	} else if ( row.complete_state_code_id == 'EC02' ){
		html = '<span class="text_blue">'+row.completeState+'</span>';
	} else {
		html = '<span class="">'+row.completeState+'</span>';
	}
	
	
	return html;
	
}

function fn_workStep(row) {
	var step = row.complete_state_code_id;
	var key = row.education_person_id;
	switch (step) {
		case 'EC01' : return '<input type="checkbox" id="private'+key+'" class="k-checkbox checkbox"/><label for="private'+key+'" class="k-checkbox-label"></label>'; 
			break;
		default  : return ''; 
			break;

	}
	
}

//켄도그리드 컬럼 autoFit 함수
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

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
        dataBound : function(e)
        {
            //console.log(this.dataSource.data());
            this.fitColumns();
            gridDataBound(e);
          },
        height: 500,
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
                title: "",
               	width : 100,
             },	
             {
            	 template: completeState,
                 title: "상태",
                 width : 110
             },{
                field: "education_dept_name",
                title: "부서",
                width : 110
            },{
                field: "EMP_NAME",
                title: "이수 신청자",
                width : 110
            }, {
            	
                field: "education_name",
                title: "교육명",
               
            }, {
                field: "education_agency",
                title: "교육기관",
               
            }, {
            	
                field: "education_cost_support_yn",
                title: "교육비지원여부",
    			width : 110
            }, {
                field: "complete_hour",
                title: "이수시간",
                width : 110
            }, {
                field: "education_cost",
                title: "교육비 (원)",
                format: "{0:n0}",
                width : 110
            }, {
                field: "eduStDt",
                title: "교육시작일",
                width : 120
                
            }, {
                field: "eduEdDt",
                title: "교육종료일",          
                width : 120
            }, {
                title: "결과보고서",
                template: '<input type="button" id="" class="text_blue" onclick="resultFileRow(this);" value="결과보고서">',
            }, {
                field: "return_cause",
                title: "반려사유",
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

function searchBtn() {
	gridReload();
	$('#deptName').val('all');
	$('#empName').val('');
	$('#userSeq').val('');
	$('#deptName2').val('');
	fnTpfDeptComboBoxInit('deptName');

}
function eduFileDown(e){
	
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
function resultFileRow(e){
	 var dataItem = $("#grid").data("kendoGrid").dataItem($(e).closest("tr"));
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
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
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
									//'<a href="#n" onclick="eduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
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
									//'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
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
									//'<a href="#n" onclick="resultEduFileDel(this);"><img src="<c:url value="/Images/btn/btn_del_reply.gif"/>" alt="" /></a>'+
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

 function resultFileDown(e){
		
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
 
 /* 부서선택시 사원선택 그리드 처리 */
function deptList(e) {
	var seq = $(e).val();
	console.log($('#deptName option:selected').text());
	$('#deptSeq').val(seq);
	$('#deptName2').val($('#deptName option:selected').text());
	empGridReload();

}
 
	$(document).ready(function() {
		$('#resultEduPop').kendoWindow({
		    width: "400px",
		    title: '결과보고서 확인',
		    visible: false,
		    modal : true,
		    actions: [
		        "Close"
		    ],
		}).data("kendoWindow").center();
		
		var myWindow = $("#popUp");
	    undo = $("#eduReject");
		
		 undo.click(function() {
			 	var ch = $('.checkbox:checked');
				var data = new Array();
		   		grid = $('#grid').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_person_id);
				});
			 if (ch.length < 1) {
				 
				 alert('반려할 목록을 체크해주세요');
			 } else {
				 myWindow.data("kendoWindow").open();
				    
			     undo.fadeOut();
			 }
		     
		 });
		
		 function onClose() {
		     undo.fadeIn();		    
			
		 }
		 $("#cancle").click(function(){
			 myWindow.data("kendoWindow").close();
		 });
		 myWindow.kendoWindow({
		     width: "900px",
		    height: "200px",
		     visible: false,
		     modal : true,
		     actions: [
		    	 "Close"
		     ],
		     close: onClose
		 }).data("kendoWindow").center();
		
		
		
		var myWindow2 = $("#popUp2");
		undo2 = $("#emp, #emp2");

		undo2.click(function() {
			if ($('#deptName').val() == 'all') {
				alert('부서를 선택하세요');
			} else {
				myWindow2.data("kendoWindow").open();
				undo2.fadeOut();
			}

		});

		function onClose2() {
			undo2.fadeIn();

		}
		$("#cancle").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		myWindow2.kendoWindow({
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
				data.deptSeq = $('#deptSeq').val();
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
	$(function() {

		empGrid();

	});
	
	/* 사원팝업 kendo 그리드 refresh */
	function empGridReload() {
		/* $('#empGrid').data('kendoGrid').dataSource.read(); */
		$("#empGrid").data("kendoGrid").dataSource.page(1);
	}
	
	/* 사원팝업 kendo 그리드 */
	function empGrid() {
		//캔도 그리드 기본
		var empGrid = $("#empGrid")
				.kendoGrid(
						{
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
									} ],
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
				console.log(record);
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
		$('#deptName2').val(row.dept_name);
		$('#popUp2').data("kendoWindow").close();
	}
	
	function popCancel(){
		$('#resultEduPop').data("kendoWindow").close();
	}
	</script>
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
<div class="pop_wrap_dir" id="popUp" style="width:900px;">
		<div class="pop_head">
			<h1>반려 사유</h1>
			
		</div>
		
		<div class="pop_con">
			<div class="com_ta" style="">
				<div class="top_box gray_box">
							
							<dl >
								<dt style="width:80px;">	반려사유</dt>
								<dd>
									<input style="width:700px" type="text" id="return_cause" name="return_cause"/>
								</dd>																
							</dl>
							
						</div>
					</div>	
						
		</div><!-- //pop_con -->
		
		<div class="pop_foot">
			<div class="btn_cen pt12">

				<input type="button" class="blue_btn" id="rejectBtn" onclick="" value="반려" />
			</div>
		</div>
		<!-- //pop_foot -->
	
	</div><!-- //pop_wrap -->



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