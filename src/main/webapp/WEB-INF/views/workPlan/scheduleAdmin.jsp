<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<jsp:useBean id="weekDay" class="java.util.Date" />
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/common/bizDeptCombo.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jszip.min.js"></c:url>'></script>

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
.top-search-btn {
    background: #fff;
    border-radius: 0px;
    box-shadow: none;
    padding: 0px 12px;
    height: 24px;
    line-height: 24px;
    border: 1px solid #c9cac9;
    outline: 0
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
				<dt class="ar" style="width: 30px">년월</dt>
				<dd>
					<input type="text" value="${nowDate}" name="" id="monthpicker"
						placeholder="" />
				</dd>
				<!-- <dt class="ar" style="width: 65px">사업장</dt>
				<dd>
					<input type="text" id="bizName" name="bizName" />
				</dd> -->
				<dt class="ar" style="width: 65px">부서</dt>
				<dd>
					<input type="text" id="deptName" name="deptName" />
				</dd>
				<dt class="ar" style="width: 30px">성명</dt>
				<dd>
					<input type="text" id="empName" disabled="disabled" value="" /> 
					<input type="hidden" id="userSeq" disabled="disabled" value="" /> 
					<input type="hidden" id="deptName2" value="" /> 
				</dd>
				<dd>
					<input type="button" id="emp" value="검색" />
					<!-- <button type="button" id="" class="top-search-btn ml4" onclick="searchBtn();">조회</button> -->
				</dd>
				
			</dl>

		</div>
		
		<div class="btn_div mt10 cl">
			<div class="left_div">
				<p class="tit_p mt5 mb0">근태현황</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="" onclick="gridExcel();">엑셀 다운로드</button>
					<button type="button" id="" onclick="searchBtn();">조회</button>
				</div>
			</div>
		</div>
		
		<div class="com_ta2 mt20" id="grid2">
		</div>
		
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->


<input type="hidden" id="rejectKey" />


<script type="text/javascript">


$(function(){
	
	$('select').kendoDropDownList();
	/* fnBizComboBoxInit('bizName');
	$('#bizName').data('kendoComboBox').value('${userInfo.bizSeq}'); */
	fnTpfDeptComboBoxInit('deptName');
	$('#deptName').data('kendoComboBox').value('${userInfo.orgnztNm}');
	
});

function gridReload2(){
	$('#grid2').data('kendoGrid').dataSource.read();
}

/* 데이터 없을 시 그리드 처리 함수 */
function gridDataBound(e) {
    var grid = e.sender;         
    if (grid.dataSource.total() == 0) {
        var colCount = grid.columns.length;
        $(e.sender.wrapper)
            .find('tbody')
            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
    }
};

/* 토요일 일요일 그리드 색깔 처리 함수 */
function fn_weekDay(row) {
	var key = row.weekDay;
	
	switch (key) {
		case '토' : return '<span style="color:blue">'+key+'</span>'; 
			break;
		case '일' : return '<span style="color:red">'+key+'</span>'; 
			break;
		default  : return '<span>'+key+'</span>'; 
			break;
	}
	
}

function searchBtn() {
	gridReload2();
	
}

function weekDay(row) {
	var color = '';
	
	if ( row.HOLIDAY_STATUS == 'Y' ) {
		if ( row.weekday == '토요일' ) {
			color = 'text_blue';
		} else {
			color = 'text_red';
		}
	} 
	
	return '<span class="'+color+'">'+row.weekday+'</span>';
	
}

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
		searchBtn();
	}
	
	$(document).ready(function() {
		
		var dataSource2 = new kendo.data.DataSource({
			serverPaging: false,
		    transport: { 
		        read:  {
		            url: _g_contextPath_+'/workPlan/scheduleList',
		            dataType: "json",
		            type: 'post'
		        },
		      	parameterMap: function(data, operation) {
		      		var deptName = $('#deptName').val();
		      		if ( deptName == '전체' ) {
		      			deptName = '';
		      		}
		      		data.deptName = deptName;
		        	data.userSeq = $('#userSeq').val();
		        	//data.bizSeq = $('#bizName').val();
		        	data.month = $('#monthpicker').val().replace(/-/gi , '');
		     	return data;
		     	}
		    },
		    schema: {
		      data: function(response) {
		        return response.list;
		      },
			      model: {
			          fields: {

			          }
			      }
		    }, group: {	// 신청인 별로 그룹화하고 인정시간 sum 구하기
		        field: "empName", aggregates: [
		        	{ field: "empName", aggregate: "max" }		            
		         ]
		      }
		});
		
		function mainGrid2(){
			//캔도 그리드 기본
			var grid = $("#grid2").kendoGrid({
		        dataSource: dataSource2,
		        height: 600,
		        columns: [
		           	{
		                field: "work_date",
		                title: "근무일자",
		           	},{
		                field: "empName",
		                title: "성명",
		            },{
		                template: weekDay,
		                title: "요일",
		            },{
		                field: "work_type",
		                title: "근무유형",
		            },{
		                field: "attend_time",
		                title: "설정출근",
		            },{
		                field: "leave_time",
		                title: "설정퇴근",
		            },{
		                field: "come_dt",
		                title: "실제출근",
		            },{
		                field: "leave_dt",
		                title: "실제퇴근",
		                
		            },{//
		            	field: "attCheck",
		            	title: "출근체크"
		            },{//
		            	field: "overWk",
		            	title: "OT구분"
		            },{//
		            	field: "apply_start_time",
		            	title: "OT시작"
		            },{//
		            	field: "apply_end_time",
		            	title: "OT종료"
		            },/* {
		            	field: "reqWorkTime",
		            	title: "신청총근무시간"
		            }, */{//
		            	field: "applyHour",
		            	title: "OT신청시간"
		            },{//
		            	field: "occurHour",
		            	title: "OT발생시간"
		            },{//
		            	field: "agreeHour",
		            	title: "OT인정시간"
		            },{
		            	field: "night_min_occur",
		            	title: "NT발생시간"
		            },{
		            	field: "night_min_agree",
		            	title: "NT인정시간"
		            },{
		                field: "holiSts",
		                title: "대체휴무",
		            },{
		                field: "remark",
		                title: "비고",
		            }],
		        change: function (e){
		        	
		        }
		    }).data("kendoGrid");

		}
		
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
		
		var myWindow2 = $("#popUp2");
		undo2 = $("#emp, #emp2");

		undo2.click(function() {
			
				myWindow2.data("kendoWindow").open();
				undo2.fadeOut();
			

		});

		function onClose2() {
			$('#emp_name').val('');
			$('#dept_name').val('');
			empGridReload();
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
		
		mainGrid2();
		
		empGrid();
		
	});
	
	function gridExcel() {
		 
		var deptName = $('#deptName').val();
  		if ( deptName == '전체' ) {
  			deptName = '';
  		}
		
		var data = {
				userSeq : $('#userSeq').val(),
				month : $('#monthpicker').val().replace(/-/gi , ''),
				bizSeq : $('#bizName').val(),
				deptName : deptName,
			}
		
		var ds = new kendo.data.DataSource({
			transport : {
				read : {
					url : _g_contextPath_+'/workPlan/scheduleList',
					dataType : "json",
					data : data,
					type : 'POST'
				}
			},
			schema : {
				data : function(response) {
					return response.list;
				},
				model: {
		            fields: {
		            	
		            }
		         }
			}
	    });
		var rows = [];
		
		rows.push({
			cells: [
				{
					value : deptName,
					colSpan : 17,
					 vAlign: "center",
		             hAlign: "center",
		             background : "#dcdcdc",
		             borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
				}
			]
		});
		
		rows.push({
	        cells: [
	          { value: "근무일자",
	        	 vAlign: "center",
	             hAlign: "center",
	             background : "#dcdcdc",
	             borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	           },
	          { value: "성명",
	        	 vAlign: "center",
	             hAlign: "center",
	             background : "#dcdcdc",
	             borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	           },
	          { value: "요일",
	        	 vAlign: "center",
	             hAlign: "center",
	             background : "#dcdcdc",
	             borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	           },
	          { value: "근무유형",
	        	 vAlign: "center",
		         hAlign: "center",  
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "설정출근",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "설정퇴근",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "실제출근",
	        	 vAlign: "center",
		         hAlign: "center",  
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "실제퇴근",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "출근체크",//
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT구분",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT시작",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT종료",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT신청시간",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT발생시간",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "OT인정시간",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "NT발생시간",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "NT인정시간",
	        	 vAlign: "center",
		         hAlign: "center",   
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "대체휴무",
	        	 vAlign: "center",
		         hAlign: "center",  
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          },
	          { value: "비고",
	        	 vAlign: "center",
		         hAlign: "center", 
		         background : "#dcdcdc",
		         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
	          }
	        ]
	      });
			
	      //using fetch, so we can process the data when the request is successfully completed
	      ds.fetch(function(){
	        var data = this.data();
	        for (var i = 0; i < data.length; i++){
	        	
	          //push single row for every record
	          rows.push({
	            cells: [
	            	
	              { value: data[i].work_date, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].empName, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].weekday, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].work_type, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].attend_time, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].leave_time, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].come_dt, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].leave_dt, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              //
	              { value: data[i].attCheck, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].overWk, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].apply_start_time, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].apply_end_time, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].applyHour, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].occurHour, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].agreeHour, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].night_min_occur, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].night_min_agree, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              //
	              { value: data[i].holiSts, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              { value: data[i].remark, vAlign: "center", hAlign: "center", borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" } },
	              
	            ]
	          })
	        }
	        
	        
	        var workbook = new kendo.ooxml.Workbook({
	          sheets: [
	            {
	            	 freezePane: {
	 	    	        rowSplit: 2
	 	    	      },
	              columns: [
	                // Column settings (width)
	                { width: 150 },
	                { width: 120 },
	                { width: 100 },
	                { width: 150 },
	                { width: 100 },
	                { width: 100 },
	                { width: 110 },
	                { width: 110 },
	                //
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                { width: 110 },
	                //
	                /* { width: 120 }, */
	                { width: 120 },
	                { width: 300 },
	              ],
	              // Title of the sheet
	              title: "근태기록현황",
	              // Rows of the sheet
	              rows: rows
	            }
	          ]
	        });
	        
	        var fileNameEmp = $('#empName').val()+'_';
	        if ( $('#empName').val() == '' ) {
	        	fileNameEmp = '';
	        }
	        //save the file as Excel file with extension xlsx
	        kendo.saveAs({dataURI: workbook.toDataURL(), fileName: deptName+'_'+fileNameEmp+$('#monthpicker').val()+"월 근태현황.xlsx"});
		
	      })

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