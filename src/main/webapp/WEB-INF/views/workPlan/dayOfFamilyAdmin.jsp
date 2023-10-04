<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>

<html>

<style>
table tr td {text-align: center;}
</style>
<body>
<div class="ifram_wrap" style="min-width: 1100px;">
	<div class="btn_div mt10 cl">
		<div class="left_div">
			<p class="tit_p mt5 mb0">빠른DAY 관리자</p>
		</div>
	</div>
	<div class="sub_contents_wrap">
			<div class="top_box">
				<dl>
					<dt style="width: 35px;">
						년월
					</dt>
					<dd>
						<input type="text" id="searchDt" style="width: 100px; text-align: center;" onchange="gridReload();">
					</dd>
				</dl>
			</div>
			<div class="btn_div mt10 cl">
				<div class="left_div">
					<p class="tit_p mt5 mb0">빠른DAY 현황</p>
				</div>
				<div class="right_div">
					<p class="tit_p mt5 mb0" id="statusSpan"></p>
					
				</div>

				
			</div>
			<div class="com_ta2 mt15">
							    <div id="grid"></div>
							</div>	

	
	</div>
	
	<div class="twinbox" style="">
			<table>
					<colgroup>
						<col width="50%"/>
						<col width="50%"/>
					</colgroup>
					<tr>
						<td class="twinbox_td">
							<div class="btn_div">
								<div class="left_div">
									<div class="controll_btn p0">
										<input type="text" id="empDn" onchange="empDnChange('detailDn',this);"	style="width: 127px; height: 24px; margin-top: 0px; margin-left:"/>
										<input type="text" id="detailDn" style="width: 127px; height: 24px; margin-top: 0px; margin-left:"/>
									</div>
								</div>
								<div class="right_div">
									<div class="controll_btn p0">
										<input type="button" class="text_blue header_select" value="신청" id="reqBtn" onclick="reqBtn();">
									</div>
								</div>
							</div>
							<div class="left">
								<div id="restEmpGrid"></div>
							</div>
						</td>
						<td class="twinbox_td">
							<div class="btn_div">
								<div class="left_div">
									<div class="controll_btn p0">
									</div>
								</div>
								<div class="right_div">
									<div class="controll_btn p0">
										<input type="button" class="text_blue header_select" value="신청 취소" id="reqCancelBtn" onclick="reqCancelBtn();">
									</div>
								</div>
							</div>
							<div class="right">
								<div id="reqEmpGrid"></div>
							</div>
							
						</td>
					</tr>
			</table>
	</div>
	<input type="hidden" id="dateVal" />	
	<input type="hidden" id="deptKey" />	
	<input type="hidden" id="positionKey" />	
	<input type="hidden" id="dutyKey" />	
	
	<input type="hidden" id="deptKr" />	
	<input type="hidden" id="positionKr" />	
	<input type="hidden" id="dutyKr" />	
</div>



<script>
var test = '${userInfo}';

$(function(){
	
	$('#searchDt').kendoDatePicker({
    	culture : "ko-KR",
	    format : "yyyy-MM",
	    start: "year",
	    depth: "year",
	    value: new Date()
	});
	
	$("#searchDt").attr("readonly","readonly");
	
	mainGrid();
	
	$('.twinbox').kendoWindow({
		width : "1200px",
		height : "600px",
		visible : false,
		modal : true,
		title: "빠른DAY 신청 현황",
		actions : [ "Close" ],
	}).data("kendoWindow").center();
	
	restEmpGrid();
	
$('#detailDn').on('change', function(){
		
		var key = $('#empDn').val();
		var subKey = $(this).val();
		var subKey2 = $(this).data('kendoDropDownList').text();
		
		switch (key) {
		case 'all':  	//	첫 번째 select Box 선택이 '전체' 일 경우
			$('#deptKey').val('');
			$('#positionKey').val('');
			$('#dutyKey').val('');
			
			$('#deptKr').val('');
			$('#positionKr').val('');
			$('#dutyKr').val('');
			break;
		case 'position':  	//	첫 번째 select Box 선택이 '직급' 일 경우	
			if (subKey == 'all') {  	//	첫 번째 select Box 선택이 '직급' 이고 두 번째 select Box 선택이 '전체' 일 경우
				$('#deptKey').val('');
				$('#positionKey').val('');
				$('#dutyKey').val('');
				
				$('#deptKr').val('');
				$('#positionKr').val('');
				$('#dutyKr').val('');
				
			} else {  	//	첫 번째 select Box 선택이 '직급' 이고 두 번째 select Box 선택이 '전체' 가 아닐 경우
				$('#deptKey').val('');
				$('#positionKey').val(subKey);
				$('#dutyKey').val('');
				
				$('#deptKr').val('');
				$('#positionKr').val(subKey2);
				$('#dutyKr').val('');
				
			}
			break;
		case 'duty':  	//	첫 번째 select Box 선택이 '직책' 일 경우	
			if (subKey == 'all') {  	//	첫 번째 select Box 선택이 '직책' 이고 두 번째 select Box 선택이 '전체' 일 경우
				$('#deptKey').val('');
				$('#positionKey').val('');
				$('#dutyKey').val('');
				
				$('#deptKr').val('');
				$('#positionKr').val('');
				$('#dutyKr').val('');
				
			} else {  	//	첫 번째 select Box 선택이 '직책' 이고 두 번째 select Box 선택이 '전체' 가 아닐 경우
				$('#deptKey').val('');
				$('#positionKey').val('');
				$('#dutyKey').val(subKey);
				
				$('#deptKr').val('');
				$('#positionKr').val('');
				$('#dutyKr').val(subKey2);
				
			}
			
			break;
		case 'dept':  	//	첫 번째 select Box 선택이 '부서' 일 경우	
			if (subKey == 'all') {  	//	첫 번째 select Box 선택이 '부서' 이고 두 번째 select Box 선택이 '전체' 일 경우
				$('#deptKey').val('');
				$('#positionKey').val('');
				$('#dutyKey').val('');
				
				$('#deptKr').val('');
				$('#positionKr').val('');
				$('#dutyKr').val('');
				
			} else {  	//	첫 번째 select Box 선택이 '부서' 이고 두 번째 select Box 선택이 '전체' 가 아닐 경우
				$('#deptKey').val(subKey);
				$('#positionKey').val('');
				$('#dutyKey').val('');
				
				$('#deptKr').val(subKey2);
				$('#positionKr').val('');
				$('#dutyKr').val('');
				
			}
			
			break;
		default:
			break;
		}
		$('#restEmpGrid').data('kendoGrid').dataSource.read();
		$('#reqEmpGrid').data('kendoGrid').dataSource.read();
	})
	
});

var dataSource = new kendo.data.DataSource({
	serverPaging: false,
	info: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/dayOfFamilyList',
            dataType: "json",
            type: 'post',

        },
      	parameterMap: function(data, operation) {
      		data.date = ($('#searchDt').val()+'01').replace(/-/gi,"");
     	return data;
     	}
    },
    schema: {
      data: function(response) {
        return response.list;
      },
      model: {
          fields: {
        	  HOURLY_WAGE: { type: "number"},
        	  WORK_APPLY_AMT: { type: "number"},
          }
      }
    }, group: {	// 신청인 별로 그룹화하고 인정시간 sum 구하기
        field: "년도별주차", aggregates: [
        	
         ]
      }
       
});

function reqListPop(e) {
	
	debugger
	
	var grid = $('#grid').data("kendoGrid");
	dataItem = grid.dataItem($(e).closest("tr"));
	
	if ( dataItem.ACTIVE == 'N' ) {
		$('#reqBtn').css({'display':'none'});
		$('#reqCancelBtn').css({'display':'none'});
	} else {
		$('#reqBtn').css({'display':'inline-block'});
		$('#reqCancelBtn').css({'display':'inline-block'});
	}
	
	$('#dateVal').val(dataItem.WORK_DATE)
 	restEmpGrid();
	$('#restEmpGrid').data('kendoGrid').dataSource.read();
	reqEmpGrid();
	$('#reqEmpGrid').data('kendoGrid').dataSource.read();
	$(".twinbox").data("kendoWindow").open();
	$("#empDn").kendoDropDownList({
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
	
	$("#detailDn").kendoDropDownList({
	      dataTextField: "text",
	      dataValueField: "value",
	      dataSource: [
	    	  { text: "전체", value: "all" },			    	  
	      ],
	      value : "all"
	});

	
}

function reqBtn() {
	
	var ch = $('.leftCheck:checked');
	if (ch.length < 1) {
		alert('신청할 목록을 체크해주세요');
	} else {
		
		var data = {};
		var grid = $('#restEmpGrid').data("kendoGrid");
		
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}
			dataItem = grid.dataItem($(v).closest("tr"));
			
			tem['type'] = 'N';
			tem['dateVal'] = $('#dateVal').val().replace(/-/gi , '');
			tem['apply_emp_seq'] = dataItem.emp_seq;
			tem['apply_dept'] = dataItem.dept_name;
			tem['apply_position'] = dataItem.position;
			tem['apply_duty'] = dataItem.duty;
			var cnt = parseInt(dataItem.CNT)-1;
			data[index] = tem;
			
		})
				
		var result = confirm('신청 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/dayOfFamilyApply",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					$('#restEmpGrid').data('kendoGrid').dataSource.read();
					$('#reqEmpGrid').data('kendoGrid').dataSource.read();
					alert('신청 되었습니다.')
				}
			})
		} else {
			$('#restEmpGrid').data('kendoGrid').dataSource.read();
			$('#reqEmpGrid').data('kendoGrid').dataSource.read();
		} 
	}
	
};

function reqCancelBtn() {
	
	var ch = $('.rightCheck:checked');
	if (ch.length < 1) {
		alert('취소할 목록을 체크해주세요');
	} else {
		
		var data = {};
		var grid = $('#reqEmpGrid').data("kendoGrid");
		
		$.each(ch, function(i,v){
			var index = i;
			var tem = {}
			dataItem = grid.dataItem($(v).closest("tr"));
			
			tem['type'] = 'C';
			tem['dateVal'] = dataItem.apply_date;
			tem['apply_emp_seq'] = dataItem.apply_emp_seq;
			tem['key'] = dataItem.day_of_family_id;
			data[index] = tem;
			
		})
				
		var result = confirm('취소 하시겠습니까?');
		
		if (result) {
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/dayOfFamilyApply",
				dataType : 'text',
				data : {data : JSON.stringify(data)},
				type : 'POST',
				success : function(result){
					$('#restEmpGrid').data('kendoGrid').dataSource.read();
					$('#reqEmpGrid').data('kendoGrid').dataSource.read();
					alert('취소 되었습니다.')
				}
			})
		} else {
			$('#restEmpGrid').data('kendoGrid').dataSource.read();
			$('#reqEmpGrid').data('kendoGrid').dataSource.read();
		} 
	}
	
};

function gridReload(){
	
	$('#grid').data('kendoGrid').dataSource.read();
	
	/* $("#grid").data("kendoGrid").dataSource.page(1); */
}

function mainGrid(){
	//캔도 그리드 기본
	var grid = $("#grid").kendoGrid({
        dataSource: dataSource,
		dataBound: function (e) {
			$('#statusSpan').empty();
			var grid = e.sender;
			var items = grid.items();
			var status = true;
			
			items.each(function (idx, row) {
	              var dataItem = grid.dataItem(row);
	            if ( dataItem.DAY_OF_FAMILY_ID != '' ) {
	            	status = false;
					return false;
				}

	        });
			
			if (!status) {
				$('#statusSpan').append(
					'<span class="text_blue">빠른DAY 등록</span>'	
				);
			} else {
				$('#statusSpan').append(
					'<span class="text_red">빠른DAY 미등록</span>'	
				);
			}

		},
        height: 500,
        scrollable:{
            endless: true
        },
        sortable: true,
        persistSelection: true,
        selectable: "multiple",
        
        columns: [
        	
       	{
            title: "상태",
            template: activeFunc,
            width:150
        },{
            title: "날짜",
            template: workDateFn,
            width:150
        },{
            title: "요일",
            template: weekDayFn,
            width:150
        },{
            field: "H_DAY",
            title: "휴일명",
            template: hDayFn,
            width:150
        },{
            title: "비고",
            template: remarkFn,
        },{
            title: "버튼",
            template: btnFn,
            width:150
        }],
        change: function (e){
//         	gridClick(e)
        }
    }).data("kendoGrid");
	
	
}

var restEmpDataSource = new kendo.data.DataSource({
	serverPaging: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/familyDayReqLeftList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
        	data.dateVal = $('#dateVal').val();
        	data.deptKey = $('#deptKey').val();
        	data.positionKey = $('#positionKey').val();
        	data.dutyKey = $('#dutyKey').val();
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
    }
});

function restEmpGrid(){
	//캔도 그리드 기본
	var grid = $("#restEmpGrid").kendoGrid({
        dataSource: restEmpDataSource,
         height: 500,
        
        columns: [
        	{ 
	        	headerTemplate: "<input type='checkbox' id='headerCheckbox' onchange='headerCheckbox();' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox'></label>",	
	        	template: "<input type='checkbox' id='leftCheck#=emp_seq#' class='k-checkbox leftCheck'/><label for='leftCheck#=emp_seq#' class='k-checkbox-label'></label>",
	        	width:50,	
			},
			{		
	            field: "emp_name",
	            title: "이름",
	            
	        }, {
	        	
	            field: "dept_name",
	            title: "부서",
	            
	        }, {
	            field: "position",
	            title: "직급",
	           
	        }, {
	            field: "duty",
	            title: "직책",
	            
	        }],
        change: function (e){
        	
        }
    }).data("kendoGrid");
	
}

var reqEmpDataSource = new kendo.data.DataSource({
	serverPaging: false,
    transport: { 
        read:  {
            url: _g_contextPath_+'/workPlan/familyDayReqRightList',
            dataType: "json",
            type: 'post'
        },
      	parameterMap: function(data, operation) {
        	data.dateVal = $('#dateVal').val();
        	data.deptKr = $('#deptKr').val();
        	data.positionKr = $('#positionKr').val();
        	data.dutyKr = $('#dutyKr').val();
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
    }
});

function reqEmpGrid(){
	//캔도 그리드 기본
	var grid = $("#reqEmpGrid").kendoGrid({
        dataSource: reqEmpDataSource,
         height: 500,
        
        columns: [
        	{ 
	        	headerTemplate: "<input type='checkbox' id='headerCheckbox2' onchange='headerCheckbox2();' class='k-checkbox header-checkbox'><label class='k-checkbox-label' for='headerCheckbox2'></label>",	
	        	template: "<input type='checkbox' id='rightCheck#=day_of_family_id#' class='k-checkbox rightCheck'/><label for='rightCheck#=day_of_family_id#' class='k-checkbox-label'></label>",
	        	width:50,	
			},
			{		
	            field: "emp_name",
	            title: "이름",
	            
	        }, {
	        	
	            field: "apply_dept",
	            title: "부서",
	            
	        }, {
	            field: "apply_position",
	            title: "직급",
	           
	        }, {
	            field: "apply_duty",
	            title: "직책",
	            
	        }, {
	            field: "reqDate",
	            title: "신청일자",
	            
	        }
	        
	        ],
        change: function (e){
        	
        }
    }).data("kendoGrid");
	
}

function applyBtn(e) {
	var type = '';	
	var grid = $('#grid').data("kendoGrid");
	var row = $(e).closest("tr");
	var dataItem = grid.dataItem($(e).closest("tr"));
	
	if ( dataItem.APPLY_DATE == '' ) {
		type = 'N';
	} else {
		type = 'C';
	}
	console.log(data);
	var text='';
	if ( type == 'N' ) {
		text = '등록';
	} else {
		text = '취소';
	}
	
	var data = {
			apply_date : dataItem.WORK_DATE.replace(/-/gi , ''),
			remark : row.find('#remark').val(),
			key : dataItem.DAY_OF_FAMILY_ID,
			type : type
	};
	
	var result = confirm(text+' 하시겠습니까?');
	
	if (result) {
		
		$.ajax({
			url: _g_contextPath_+"/workPlan/dayOfFamilyApply",
			dataType : 'text',
			data : data,
			type : 'POST',
			success : function(result){
				gridReload();
				alert(text+' 되었습니다.')
			}
		})
	} else {
		gridReload();
	} 
}


function btnFn(row) {
	var html = '';
	if ( row.ACTIVE == 'Y' ) {
		html = '<input type="button" class="text_blue header_select" value="신청" onclick="reqListPop(this);">';
	} else {
		
// 		if ( row.APPLY_DATE != '' ) {
// 			html = '<input type="button" class="text_red header_select" value="신청 취소" onclick="applyBtn(this);">';
// 		} else {
// 			html = '';
// 		}
		html = '<input type="button" class="text_blue header_select" value="조회" onclick="reqListPop(this);">';
	}
	return html;
}

function workDateFn(row) {
	var color = '';
	if ( row.HOLIDAY_STATUS == 'Y' ) {
		if ( row.WEEKDAY == '토요일' ) {
			color = 'text_blue';
		} else {
			color = 'text_red';
		}
	} else {
		color = '';
	}
	
	return '<span class="'+color+'">'+row.WORK_DATE+'</span>';
}

function weekDayFn(row) {
	var color = '';
	if ( row.HOLIDAY_STATUS == 'Y' ) {
		if ( row.WEEKDAY == '토요일' ) {
			color = 'text_blue';
		} else {
			color = 'text_red';
		}
	} else {
		color = '';
	}
	
	return '<span class="'+color+'">'+row.WEEKDAY+'</span>';
}

function hDayFn(row) {
	var color = 'text_red';
	
	return '<span class="'+color+'">'+row.H_DAY+'</span>';
}

function workDateFn(row) {
	var color = '';
	if ( row.HOLIDAY_STATUS == 'Y' ) {
		if ( row.WEEKDAY == '토요일' ) {
			color = 'text_blue';
		} else {
			color = 'text_red';
		}
	} else {
		color = '';
	}
	
	return '<span class="'+color+'">'+row.WORK_DATE+'</span>';
}

function activeFunc(row) {
	var html = '';
	if (row.ACTIVE == 'Y') {
		html = '<span class="text_blue">신청 가능</span>';
	} else {
		
// 		if ( row.HOLIDAY_STATUS == 'Y' ) {
// 			html = '';
// 		} else {
// 			if ( row.CNT == 0 ) {
				
// 				if ( row.APPLY_DATE != '' ) {
					
// 					html = '<span class="text_green">가족의 날</span>';
// 				} else {
// 					html = '<span class="text_gray">가족의 날 신청 주</span>';
// 				}
				
// 			} else {
// 				html = '<span class="text_red">신청 불가능</span>';	
// 			}
// 		}
		
		html = '<span class="text_red">신청 불가능</span>';
		
	}
	return html;
}

function remarkFn(row) {
	active = '';
	if ( row.ACTIVE == 'N' ) {
		active = 'disabled="disabled"';
	} else {
		active = '';
	}
	
	return '<input type="text" id="remark" value="'+row.REMARK+'" '+active+' style="width: 90%"/>';
}

function headerCheckbox(){
	if($("#headerCheckbox").is(":checked")){
    	$(".leftCheck").prop("checked", "checked");
    	
    }else{
    	$(".leftCheck").removeProp("checked");
    }
	
}

function headerCheckbox2(){
	if($("#headerCheckbox2").is(":checked")){
    	$(".rightCheck").prop("checked", "checked");
    	
    }else{
    	$(".rightCheck").removeProp("checked");
    }
	
}

function empDnChange(id, e) {
	var key = $(e).val();
	var subKey;
	switch(key) {
		case 'all' :	//	선택이 '전체' 일 경우
			$("#detailDn").kendoDropDownList({
			      dataTextField: "text",
			      dataValueField: "value",
			      dataSource: [
			    	  { text: "전체", value: "all" },			    	  
			      ],
			      value : "all"
			});
			$('#deptKey').val('');
			$('#positionKey').val('');
			$('#dutyKey').val('');
			
			$('#deptKr').val('');
			$('#positionKr').val('');
			$('#dutyKr').val('');
			$('#restEmpGrid').data('kendoGrid').dataSource.read();
			$('#reqEmpGrid').data('kendoGrid').dataSource.read();
		break;
		case 'position' : 	//	선택이 '직급' 일 경우
			subKey = 'POSITION'; 
			
			var data = {
					subKey : subKey
				}
			
			var html = '<option value="all">전체</option>';
			
			$.ajax({
				url: _g_contextPath_+"/common/getDutyPosition",
				dataType : 'json',
				data : data,
				async : false,
				type : 'POST',
				success: function(result){
					var dutyPosition = result.getDutyPosition;										
					dutyPosition.unshift({dp_name : "전체", dp_seq : "all"});
					$("#detailDn").kendoDropDownList({
						dataSource : dutyPosition,
						dataTextField: "dp_name",
						dataValueField: "dp_seq",
						index: 0,
				    });
				
				}
			})
			
			break;
		case 'duty' :  	//	선택이 '직책' 일 경우
			subKey = 'DUTY'; 
			
			var data = {
					subKey : subKey
				}
			
			var html = '<option value="all">전체</option>';
			
			$.ajax({
				url: _g_contextPath_+"/common/getDutyPosition",
				dataType : 'json',
				data : data,
				async : false,
				type : 'POST',
				success: function(result){
					var dutyPosition = result.getDutyPosition;										
					dutyPosition.unshift({dp_name : "전체", dp_seq : "all"});
					$("#detailDn").kendoDropDownList({
						dataSource : dutyPosition,
						dataTextField: "dp_name",
						dataValueField: "dp_seq",
						index: 0,
				    });
				
				}
			})
			
			break;
		case 'dept' :  	//	선택이 '부서' 일 경우
			
			var html = '<option value="all">전체</option>';
			
			$.ajax({
				url: _g_contextPath_+"/common/getDeptList",
				dataType : 'json',
				data : data,
				async : false,
				type : 'POST',
				success: function(result){
					var deptList = result.allDept;										
					deptList.unshift({dept_name : "전체", dept_seq : "all"});
					$("#detailDn").kendoDropDownList({
						dataSource : deptList,
						dataTextField: "dept_name",
						dataValueField: "dept_seq",
						index: 0,
				    });
					
				
				}
			})	; 
			break;		
	}
}
</script>

</body>
</html>