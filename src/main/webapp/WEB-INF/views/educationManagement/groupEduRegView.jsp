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
<script type="text/javascript" src="<c:url value='/js/educationManagement/groupEduRegPop.js' />"></script>		<!-- 집합교육 등록 팝업 관련 javascript -->
<script type="text/javascript" src='<c:url value="/js/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript">
	$(function() {
		
		$(".yhtime").kendoTimePicker({
			format: "tt HH:mm",
			culture : "ko-KR",
			interval : 10,
	        dateInput: true
	    });
		
		$(".yhtime").attr("readonly", true);
		
		$('#required_yn').on('change', function() {
			if ($('#required_yn').is(':checked')) {
				$('#requiredDiv').css({'display':'block'});
			} else {
				$('#requiredDiv').css({'display':'none'});
			}
		})
		
		/* $('#mod').on('click', function() {
			var ch = $('.checkbox:checked');
			var data = new Array();
			grid = $('#grid').data("kendoGrid");
			$.each(ch, function(i,v){
				dataItem = grid.dataItem($(v).closest("tr"));
			});
			if ( ch.length <= 0 ) {
				alert('수정할 건을 체크하세요.');
			} else if ( ch.length > 1 ) {
				alert('하나의 건만 체크하세요.');
			} else {
				console.log(dataItem);
				$('#enforcement_dept_name').val(dataItem.enforcement_dept_name);
				$("#manager_emp_seq").data("kendoComboBox").value(dataItem.manager_emp_seq);
				$('#education_type_code_id').val(dataItem.education_type_code_id);
				$('#education_type').val(dataItem.education_type);
				$('#education_name').val(dataItem.education_name);
				$('#education_hour').val(dataItem.education_hour);
				if(dataItem.required_yn == 'Y'){
					$('#required_yn').prop('checked', true);
					$('#requiredDiv').css({'display':'block'});
					$("#required_dn").data("kendoComboBox").value(dataItem.required_code_id);
				} else {
					$('#required_yn').prop('checked', false);
					$('#requiredDiv').css({'display':'none'});
				}  
				$('#education_start_date').val(dataItem.education_start_date);
				$('#education_end_date').val(dataItem.education_end_date);
				$('#education_place').val(dataItem.education_place);
				$("#popUp").data("kendoWindow").open();
				
			}
		}) */
		
		$("#detailDn").kendoComboBox({
		      dataTextField: "text",
		      dataValueField: "value",
		      dataSource: [
		    	  { text: "전체", value: "all" },			    	  
		      ],
		      value : "all"
		});
		
		var empDeptList = JSON.parse('${empDept}');
		console.log(empDeptList)
		empDeptList.unshift({emp_name : "선택", emp_seq : ""});
		$("#manager_emp_seq").kendoComboBox({
		      /* dataTextField: "text",
		      dataValueField: "value", */
		      dataSource: empDeptList,
		      dataTextField: "emp_name",
				dataValueField: "emp_seq",
				index: 0,
		});
		
		var requiredDn = JSON.parse('${requiredDn}');
		$("#required_dn").kendoComboBox({
		      /* dataTextField: "text",
		      dataValueField: "value", */
		      dataSource: requiredDn,
		      dataTextField: "code_kr",
				dataValueField: "code",
				index: 0,
		});
		
		$("#empDn").kendoComboBox({
		      dataTextField: "text",
		      dataValueField: "value",
		      dataSource: [
		    	  { text: "전체", value: "all" },
		    	  { text: "직급", value: "position" },
		    	  { text: "직책", value: "duty" },
			      { text: "부서", value: "dept" }
		      ],
		      value : "all"
		});
		
		$('#manager_emp_seq').data('kendoComboBox').value('<c:out value="${userSeq}"/>');
		
		
	});
</script>
<div class="pop_wrap_dir" id="popUp" style="width:1000px;">
		<div class="pop_head">
			<h1>집합교육등록</h1>
			
		</div>
		<div class="pop_con">
			<div class="com_ta" style="">
				<div class="top_box gray_box">
							
							<dl >
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	시행부서</dt>
								<dd>
									<input type="text" id="enforcement_dept_name" value="${deptName }" disabled="disabled"/>
								</dd>
								<dt style="margin-left: 250px;width:80px;">담당자</dt>
								<dd>
									<%-- <select id="manager_emp_seq" class="selectmenu" style="width: 102px; height: 24px; margin-top: 0px; margin-left:">
										<option value="">전체</option>
										<c:forEach items="${empDept }" var="list">
											<option value="${list.emp_seq }">${list.emp_name }</option>
										</c:forEach>											
									</select> --%>
									<input type="text" id="manager_emp_seq" style="width: 127px; height: 24px;"/>
								</dd>								
							</dl>
							<dl class="next2">
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육구분</dt>
								<dd>
									<input type="hidden" id="education_type_code_id" value="ED01"/>
									<input type="text" id="education_type" value="집합교육" disabled="disabled"/>
								</dd>
								<dt style="margin-left: 250px;width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 교육명</dt>
								<dd>
									<input style="width: 350px" type="text" id="education_name" />
								</dd>
							</dl>
							<dl class="next2">
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />	교육시간</dt>
								<dd>
									<input type="text" id="education_hour" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="width: 68px"/>&nbsp;시간&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="checkbox" id="required_yn"/><label for="required_yn"></label>&nbsp;필수
								</dd>
								<div id="requiredDiv" style="display: none;">
									<dt style="margin-left: 214px;width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 필수교육</dt>
									<dd>
										<input type="text" id="required_dn" style="width: 200px"/>
									</dd>
								</div>
															
							</dl>
							<dl class="next2">
								
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 교육기간</dt>
								<dd>
									<input type="text" value="" style="text-align: ;" class="w113" name="education_start_date" id="education_start_date" onchange="fn_changeEndDt('education_end_date', this); fn_dateCheck();" placeholder="교육시작일" />&nbsp;~&nbsp;
									<input type="text" value="" style="text-align: ;" class="w113" name="education_end_date" id="education_end_date" onchange="fn_dateCheck();" placeholder="교육종료일" />
								</dd>
							</dl>
							<dl class="next2">
								<dt style="width:80px;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> 교육시간</dt>
								<dd>
									<input type="text" value="" style="text-align: ;" class="w113 yhtime" name="education_start_time" id="education_start_time" onchange="" placeholder="교육시작시간" />&nbsp;~&nbsp;
									<input type="text" value="" style="text-align: ;" class="w113 yhtime" name="education_end_time" id="education_end_time" onchange="" placeholder="교육종료시간" />
								</dd>
							
							</dl>
							
							<dl class="next2">
								<dt style="width:80px;">교육장소</dt>
								<dd>
									<input type="text" id="education_place" style="width: 300px"/>
								</dd>
														
							</dl>
						</div>
					</div>	
			<div class="com_ta" style="margin-top: 20px;height: 350px">		
		<div class="twinbox" style="height: 400px">
			<table>
					<colgroup>
						<col width="45%"/>
						<col width="10%"/>
						<col width="45%"/>
					</colgroup>
					<tr>
						<td class="twinbox_td">
						<!-- 버튼 -->
							<div class="btn_div">
								<div class="left_div">
									<div class="controll_btn p0">
										<!-- <select id="empDn" class="selectmenu" onchange="empDnChange('detailDn',this);"	style="width: 102px; height: 24px; margin-top: 0px; margin-left:">
											<option value="all">전체</option>
											<option value="position">직급</option>
											<option value="duty">직책</option>
											<option value="dept">부서</option>
										</select> -->
										<input type="text" id="empDn" onchange="empDnChange('detailDn',this);"	style="width: 127px; height: 24px; margin-top: 0px; margin-left:"/>
										<!-- <select id="detailDn" class="selectmenu" style="width: 102px; height: 24px; margin-top: 0px; margin-left:">
											<option value="all">전체</option>											
										</select> -->
										<input type="text" id="detailDn" style="width: 127px; height: 24px; margin-top: 0px; margin-left:"/>
									</div>
								</div>
								<div class="right_div">
									<div class="controll_btn p0">
										
									</div>
								</div>
							</div>
							<div class="first">
								<div id="empGrid"></div>
							</div>
						</td>
						<td class="twinbox_td" style=" padding-top: 180px">
							<div class="second" style="position: relative">
								<a href="#n" onclick="" style="display: block;width:100%; margin: 10px auto;text-align: center;" id="arrowRight"><img style="width:40px;" src="<c:url value='/Images/btn/btn_arr01.png'/>" alt="" /></a>
								<a href="#n" onclick="" style="display: block;width:100%; margin: 10px auto;text-align: center;" id="arrowLeft"><img style="width:40px;" src="<c:url value='/Images/btn/btn_arr02.png'/>" alt="" /></a>
							</div>							
						</td>
						<td class="twinbox_td">
						<!-- 버튼 -->
							<div class="btn_div">
								<div class="left_div">
									<div class="controll_btn p0">
										
									</div>
								</div>
								
							</div>
							<div class="third" style="position: relative">
								<div id="selectEmp"></div>
							</div>
							
						</td>
					</tr>
			</table>
			
		
	</div>
		</div>				
						
						
						
		</div><!-- //pop_con -->
		<div class="pop_foot">
			<div class="btn_cen pt12">

				<input type="button" class="blue_btn" id="fn_groupEduReg" onclick="fn_groupEduReg();" value="승인요청" />
			</div>
		</div>
		<!-- //pop_foot -->
	<input type="hidden" style="width: 1000px" id="keyVal" />
	<input type="hidden" id="deptKey" />
	<input type="hidden" id="positionKey" />
	<input type="hidden" id="dutyKey" />
	<input type="hidden" id="empSeq" value="${userSeq }" />
	<input type="hidden" id="year" value="${year }" />
	<input type="hidden" id="mm" value="${mm }" />
	<input type="hidden" id="dd" value="${dd }" />
	
	</div><!-- //pop_wrap -->

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
					<button type="button" id="add" onclick="">집합교육 등록</button>
					<button type="button" id="del" onclick="">삭제</button>
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


<input type="hidden" id="mainKey" />


<script type="text/javascript">
$(document).ready(function() {
	
	
	fnTpfDeptComboBoxInit('deptName');
	$("#deptName").data("kendoComboBox").value('<c:out value="${deptList.dept}"/>');
	$('#del').on('click', function(){
		debugger
		var ch = $('.checkbox:checked');
		var data = new Array();
		var userYn = new Array();
		grid = $('#grid').data("kendoGrid");
		$.each(ch, function(i,v){
			dataItem = grid.dataItem($(v).closest("tr"));
			if ( $('#empSeq').val() == dataItem.write_emp_seq ) {
				userYn.push(dataItem.write_emp_seq);
			}
		});
		if ( ch.length != userYn.length ) {
			alert('자신이 등록한 계획만 삭제할 수 있습니다.');
		} else {
			
				$.each(ch, function(i,v){
					dataItem = grid.dataItem($(v).closest("tr"));
					data.push(dataItem.education_id);
				});
				debugger
				if (ch.length < 1) {
					alert('삭제할 건을 체크하세요');
				} else {
					var result = confirm('삭제하시겠습니까?');
					if (result) {
						$.ajax({
							url: _g_contextPath_+'/educationManagement/eduReqDel',
							dataType : 'text',
							data : {data : data.join(',')},
							type : 'POST',
							success : function(result){
								mainGrid();
							}
						})
					} else {
						
					}
					
				}
			
		}
		
		
	})
	
	var year = $('#year').val();
	var mm = $('#mm').val();
	var dd = $('#dd').val();
	var currentDate = new Date(year,mm-1,dd);
	$('#education_start_date, #education_end_date').kendoDatePicker({
		
	    culture : "ko-KR",
	    format : "yyyy-MM-dd",
	});
	
	$("#education_start_date, #education_end_date").attr("readonly", true);
	
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
        	  education_id: { type: "string" },
        	  required_yn: { type: "string" },
        	  education_hour: { type: "string"},
        	  education_step_code_id: { type: "string"}
          }
      }
    }

       
});


$(function(){
	
	mainGrid();
	$("#headerCheckbox2").change(function(){
		debugger
		var checkedIds = {};
	    if($("#headerCheckbox2").is(":checked")){
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
function fn_workStep(row) {
	var step = row.education_step_code_id;
	var key = row.education_id;
	switch (step) {
		case 'ES01' : return '<input type="checkbox" id="over'+key+'" class="k-checkbox checkbox"/><label for="over'+key+'" class="k-checkbox-label"></label>'; 
			break;
		default  : return ''; 
			break;

	}
	
}

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
      		headerTemplate: "<input type='checkbox' id='headerCheckbox2' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox2'></label>",
          	template: fn_workStep,
           	width : 50,
        }, {
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




		 function searchBtn() {
			 $('#mainKey').val('');
			 gridReload();
			 gridReload2();
			}
		
	</script>
	
