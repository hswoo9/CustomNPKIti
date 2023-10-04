<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-" />
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
					<input type="text" value="${nowDate}01" name="" id="monthpicker"
						placeholder="" />&nbsp;~ <input type="text" value="${nowDate}12" name=""
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
				<dt class="ar" style="width: 65px">직급</dt>
				<dd>
					<select type="text" id="detailDn" multiple="multiple" style="width: 250px" data-placeholder="직급을 선택하세요">
						<c:forEach items="${getPosition }" var="list">
							<option value="${list.dp_name }">${list.dp_name }</option>
						</c:forEach>
					</select>
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



<script type="text/javascript">

var required = $("#detailDn").kendoMultiSelect().data("kendoMultiSelect");

$(document).ready(function() {
	
	$('#detailDn').on('change', function(){
		$('#userSeq').val('');
	})
	
	$("#get").click(function() {
        alert("Attendees:\n\nRequired: " + required.value());
    });
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
	$("#monthpicker").attr("readonly", true);
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
	$("#monthpicker2").attr("readonly", true);
});

function fnTpfDeptComboBoxInit(id){
	debugger
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
	 debugger
		var obj = $('#deptName').data('kendoComboBox');
		/* $('#txtDeptCd').val(obj._old);
		$('#txtDeptName').val(obj._prev); */
		$('#deptSeq').val(obj._old);
		empGridReload();
		
		
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
      		data.dateFr = $('#monthpicker').val();
      		data.dateTo = $('#monthpicker2').val();
      		data.education_emp_seq = $('#userSeq').val();
      		data.education_dept_name = $("#deptName").data("kendoComboBox").text();
      		var education = "";
      		$.each(required.value(), function(inx){
      			if(inx == 0){
	      			education += this;
      			}else{
      				education += "," + this; 
      			}
      		});
      		
      		console.log(education);
      		data.education_duty =education;
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
        dataBound: function(e)
        {
            //console.log(this.dataSource.data());
            this.fitColumns();
            gridDataBound(e);
          },
        scrollable:{
            endless: true
        },
        height: 280,
        sortable: true,
       pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        resizable: true,
        persistSelection: true,
        selectable: "multiple",
        
        columns: [
        	
        	{
                field: "education_dept_name",
                title: "부서",
            }, {
            	
                field: "emp_name",
                title: "성명",
               
            }, {
                field: "education_position",
                title: "직급",
               
            }, {
            field: "education_duty",
            title: "직책",
        }, {
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
		var rows = grid.select();
		var record;
		rows.each(function() {
			record = grid.dataItem($(this));
			console.log(record);
		});
		$('#userSeq').val(record.education_emp_seq);
		gridReload2();
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
      		data.dateFr = $('#monthpicker').val();
      		data.dateTo = $('#monthpicker2').val();
      		data.education_emp_seq = $('#userSeq').val();
      		data.education_dept_name = $("#deptName").data("kendoComboBox").text();
      		var education = "";
      		$.each(required.value(), function(inx){
      			if(inx == 0){
	      			education += this;
      			}else{
      				education += "," + this; 
      			}
      		});
      		
      		console.log(education);
      		data.education_duty =education;
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
        	  complete_hour: { type: "string" },
        	  required_yn: { type: "string" },
        	  education_cost: { type: "number" },
        	  
          }
      }
    }

       
});
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
        dataBound: function(e)
        {
            //console.log(this.dataSource.data());
            this.fitColumns();
            gridDataBound2(e);
          },
        height: 280,
        scrollable:{
            endless: true
        },
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 20, 50, 100],
            buttonCount: 5
        },
        
        resizable: true,
        persistSelection: true,
        selectable: "multiple",
        
        columns: [    
       	{
            field: "emp_name",
            title: "성명",
           },
        	  {
            field: "education_type",
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
//         	template: "#= education_cost != null ? education_cost : 0 #원 ",
            field: "education_cost",
            title: "교육비",
            format: "{0:n0}",
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
	
	gridReload();
	gridReload2();
	$('#deptName').data('kendoComboBox').value('all');
	 $('#empName').val('');
// 	 $('#userSeq').val('');
	 $('#deptName2').val('');
	 
// 	 required = $("#detailDn").kendoMultiSelect().data("kendoMultiSelect");
// 	required.value('');
// 	$("#detailDn").data("kendoMultiSelect").value('');
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

	</script>
	
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