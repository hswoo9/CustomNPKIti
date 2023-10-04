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
					<button type="button" id="eduApproval" onclick="">승인</button>
					<button type="button" id="eduCancle" onclick="">승인 취소</button>
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
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">교육 대상자</p>
			</div>

		</div>
		<div class="com_ta2 mt15">
			<div id="grid2"></div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

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

<input type="hidden" id="mainKey" />


<script type="text/javascript">
function fnTpfDeptComboBoxInit(id){
	
		if($('#'+id)){
			var deptList = fnTpfGetDeptList();
			deptList.unshift({dept_name : "전체", dept_name : "전체"});
			var itemType = $("#" + id).kendoComboBox({
				dataSource : deptList,
				dataTextField: "dept_name",
				dataValueField: "dept_name",
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
	}
 
$(document).ready(function() {
	
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
	
	 function onClose() {
	     undo.fadeIn();		    
		
	 }
	 
	fnTpfDeptComboBoxInit('deptName');
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
        	  education_step_code_id: { type: "string" },
        	  education_hour: { type: "string"},
        	  eduStep: {type: "string"}
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
	/* $('#grid').data('kendoGrid').dataSource.read(); */
	$("#grid").data("kendoGrid").dataSource.page(1);
}
function fn_workStep(row) {
	var step = row.education_step_code_id;
	var key = row.education_id;
	switch (step) {
		case 'ES03' : return '';
			break;
		case 'ES04' : return '';
			break;
		default  : return '<input type="checkbox" id="appGrid'+key+'" class="k-checkbox checkbox"/><label for="appGrid'+key+'" class="k-checkbox-label"></label>';
			break;

	}
	
}

function eduStep(row) {
	var html;
	
	if ( row.education_step_code_id == 'ES01' ) {
		html = '<span>'+row.eduStep+'</span>';
	} else if ( row.education_step_code_id == 'ES04' ) {
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
        	headerTemplate: "<input type='checkbox' id='headerCheckbox' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",
        	template: fn_workStep,
            title: "승인",
           	width : 100,
         },{
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
		$('#mainKey').val(record.education_id);
		gridReload2();
		
	}
}




var dataSource2 = new kendo.data.DataSource({
	serverPaging: true,
	pageSize: 10,
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

              weekDay: { type: "string" },
             
       
          }
      }
    }

       
});


$(function(){
	
	mainGrid2();
	

});

function gridReload2(){
	/* $('#grid2').data('kendoGrid').dataSource.read(); */
	$("#grid2").data("kendoGrid").dataSource.page(1);
}

function mainGrid2(){
	//캔도 그리드 기본
	var grid2 = $("#grid2").kendoGrid({
        dataSource: dataSource2,
        dataBound: grid2DataBound,
        height: 300,
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
		subReload2(record);
	}
}

function subReload2(record){
	
	
}

$(function(){
	$('#eduApproval').on('click', function(){
		
		var ch = $('.checkbox:checked');
		if (ch.length < 1) {
			alert('승인할 목록을 체크해주세요');
		}else if (ch.length > 1){
			alert('한 건만 체크해주세요');
		} else {
			var result = confirm('승인 하시겠습니까?');
			
			if (result) {
				var ch = $('.checkbox:checked');
				var data = new Array();
				grid = $('#grid').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_id);
				});
				
				$.ajax({
					url: _g_contextPath_+"/educationManagement/groupEduApproval",
					dataType : 'text',
					data : {data : data.join(',')},
					type : 'POST',
					success : function(result){
						searchBtn();
					}
				})
			} else {
				searchBtn();
			}
		}
		
	});
	
	$('#rejectBtn').on('click', function() {
		debugger
		var ch = $('.checkbox:checked');
		var result = confirm('반려 하시겠습니까?');
		if(result) {
			var ch = $('.checkbox:checked');
			var data = new Array();
			var return_cause = $('#return_cause').val();
	   		grid = $('#grid').data("kendoGrid");
			$.each(ch, function(i,v){
				dataItem = grid.dataItem($(v).closest("tr"));
				data.push(dataItem.education_id);
			});
			var allData = {
	   				data : data.join(','),
	   				return_cause : return_cause
	   		}
			$.ajax({
				url : _g_contextPath_+"/educationManagement/groupEduReject",
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
	
	$('#eduCancle').on('click', function(){
		
		var ch = $('.checkbox:checked');
		if (ch.length < 1) {
			alert('취소할 목록을 체크해주세요');
		} else if ( ch.length > 1 ) {
			alert('한 건만 체크해주세요');
			
		} else {
			var result = confirm('취소 하시겠습니까?');
			
			if (result) {
				var ch = $('.checkbox:checked');
				var data = new Array();
				grid = $('#grid').data("kendoGrid");
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_id);
				});
				
				$.ajax({
					url: _g_contextPath_+"/educationManagement/groupEduCancle",
					dataType : 'text',
					data : {data : data.join(',')},
					type : 'POST',
					success : function(result){
						searchBtn();
					}
				})
			} else {
				searchBtn();
			}
		}
		
	});
})



function searchBtn() {
	 $('#mainKey').val('');
	 gridReload();
	 gridReload2();
}
		
	</script>
	
