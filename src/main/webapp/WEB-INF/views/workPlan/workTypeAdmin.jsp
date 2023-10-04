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
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<fmt:formatDate value="${weekDay}" var="weekDay" pattern="E" type="date" />
<script type="text/javascript" src="<c:url value='/js/jquery.number.min.js' />"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
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
<body>
	<input type="hidden" id="kendoYear" value="${year }" />
	<input type="hidden" id="kendoMonth" value="${mm }" />
	<input type="hidden" id="kendoDate" value="${dd }" />

	<script type="text/javascript">
	
		$(function(){
			$('#work_min, #break_min').on('keyup', function() {
				$(this).val($(this).val().replace(/[^0123456789.]/g,""));
			});
			
			mainGrid();
			$('select').kendoDropDownList();
// 			$('[opt="time"]').kendoTimePicker({
// 				//format: "tt HH:mm",
// 				format: "HH:mm",
// 				culture : "ko-KR",
// 				interval : 10,
// 		        dateInput: true
// 		    });
			
			ct2KendoTimePicker($('#attend_time'), $('#leave_time'));
			
			function ct2KendoTimePicker(a, b){
				
				var startTime = $(a).kendoTimePicker({
					format: "HH:mm",
					culture : "ko-KR",
					interval : 10,
			        dateInput: true,
				    change: startChange
				}).data("kendoTimePicker");

				var endTime = $(b).kendoTimePicker({
					format: "HH:mm",
					culture : "ko-KR",
					interval : 10,
			        dateInput: true
				}).data("kendoTimePicker");

				function startChange(){
					if(startTime.value() > endTime.value()){
						endTime.value('');
					}
					endTime.min(startTime.value());
				}
				
			}
			
			
			$('[opt="time"]').on({
				
				keyup: function() {
					
					if (event.keyCode == 8) 
			        {
			            return;
			        } 
					
					$(this).val($(this).val().replace(/[^0123456789:]/g,""));
					
					var attendTime = $('#attend_time').val().replace(/:/g,"");
					var leaveTime = $('#leave_time').val().replace(/:/g,"");
					
					if ( $(this).val().length == 5 ) {
						if(parseInt(attendTime) > parseInt(leaveTime)){
							$('#leave_time').data('kendoTimePicker').value('');
						}
					}
					
					
					if ($(this).val().length == 2) {
						$(this).val($(this).val()+':');
					} else if ($(this).val().length > 5) {
						$(this).val($(this).val().slice(0, 5))
					}
				},
				
				keydown: function() {
					
					if (event.keyCode == 8) 
			        {
			            return;
			        } 
					
					$(this).val($(this).val().replace(/[^0123456789:]/g,""));
					
					var attendTime = $('#attend_time').val().replace(/:/g,"");
					var leaveTime = $('#leave_time').val().replace(/:/g,"");

					if ( $(this).val().length == 5 ) {
						if(parseInt(attendTime) > parseInt(leaveTime)){
							$('#leave_time').data('kendoTimePicker').value('');
						}
					}
					
					if ($(this).val().length == 2) {
						$(this).val($(this).val()+':');
					} else if ($(this).val().length > 5) {
						$(this).val($(this).val().slice(0, 5))
					}
				},
				
				focusout: function() {
					$(this).val($(this).val().replace(/[^0123456789:]/g,""));
					if ($(this).val().length == 2) {
						$(this).val($(this).val()+':');
					} else if ($(this).val().length > 5) {
						$(this).val($(this).val().slice(0, 5))
					}
				}
				
			});
			
			$('#food_fee').number( true, 0 );
			
// 			$('[opt="time"]').attr("readonly", true);
			
			$('#dataSave').on('click', function() {
				
				dataSave();
				
			});
			
			$('[dType="number"]').on({
				
				keyup: function() {
					$(this).val($(this).val().replace(/[^0123456789]/g,""));
					
				},
				
				keydown: function() {
					$(this).val($(this).val().replace(/[^0123456789]/g,""));
					
				},
				
				focusout: function() {
					$(this).val($(this).val().replace(/[^0123456789]/g,""));
					
				}
				
			});
			
			$('#dataMod').on('click', function() {
				
				if ( $('#workTypeId').val() == '0' ) {
					alert('수정 할 근무유형을 클릭해주세요.');
				} else {
					dataSave();
				}
				
			});
			
			$('#dataReset').on('click', function() {
				
				$('#workTypeId').val('0');
				
				var inputData = $('#dataBox input,select');
				
				inputData.each(function(i, v) {
					
					$(this).val('');
					
					
				});
				
			});
			
			
		});
		
		var dataSource = new kendo.data.DataSource({
			serverPaging: true,
			pageSize: 10,
		    transport: { 
		        read:  {
		            url: _g_contextPath_+'/workPlan/workTypeList',
		            dataType: "json",
		            type: 'post'
		        },
		      	parameterMap: function(data, operation) {

		        	data.empId = $('#empId').val();
		        	
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

			          }
			      }
		    }
		});
		
		function dataSave() {
			
			var mustData = $('[check="must"]');
			var bEmpty = true;
			var focus;
			
			mustData.each(function(){
				
				if ( $(this).val() == '' ) {
					focus = $(this);
					bEmpty = false;
					
					alert("필수항목을 채워주세요.");
		            focus.focus();
		 
		            // 여기서는 each문을 탈출
		            return false;
					
				} else {
					
// 					if ( $(this).attr('opt') == 'time' && $(this).val().length != 5 ) {
// 						focus = $(this);
// 						bEmpty = false;
						
// 						alert("시간을 모두 입력해주세요.");
// 			            focus.focus();
			 
// 			            // 여기서는 each문을 탈출
// 			            return false;
// 					};
					
				};
				
			});

			
			if (!bEmpty) return;
			
			var data = {};
			
			var inputData = $('#dataBox input,select');
			
			inputData.each(function(i, v) {
				
				var id = $(inputData[i]).attr('id');
				console.log($(inputData[i]).attr('dType'));
				
				if ( $(inputData[i]).attr('dType') == 'date' ) {
					data[id]  = $(inputData[i]).val().replace(/-/gi,"");	
				} else if ( $(inputData[i]).attr('dType') == 'money' ) {
					data[id]  = $(inputData[i]).val().replace(/,/gi,"");	
				} else if ( $(inputData[i]).attr('dType') == 'min' ) {
					data[id]  = $(inputData[i]).val()*60;	
				} else {
					data[id]  = $(inputData[i]).val();	
				}
				
			});
			
			data['work_type_id'] = $('#workTypeId').val();
			
			$.ajax({
				url: _g_contextPath_+"/workPlan/workTypeSave",
				data : data,
				type : 'POST',
				async: false,
				success: function(result){
					
					location.reload();
					
				}
			});
			
		}
		
		function gridReload(){
			$('#grid').data('kendoGrid').dataSource.read();
		}
		
		/* 데이터 없을 시 그리드 처리 함수 */
		function gridDataBound(e) {
	        var grid = e.sender; 
			var gridID = grid.element.context.getAttribute('id');
	        var text = '근무유형';
	        
	        if (grid.dataSource.total() == 0) {
	            var colCount = grid.columns.length;
	            $(e.sender.wrapper)
	                .find('tbody')
	                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">'+text+' 데이터가 없습니다.</td></tr>');
	        }
	    };

		
		function mainGrid(){
			//캔도 그리드 기본
			var grid = $("#grid").kendoGrid({
		        dataSource: dataSource,
		        height: 400,
		         dataBound: gridDataBound,
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
		       		field: "work_type",
		            title: "근무유형",
		       	},{
		       		field: "attend_time",
		            title: "출근시간",
		       	},{
		            field: "leave_time",
		            title: "퇴근시간",
		       	},{
		       		field: "workTime",
		       		title: "근무시간",
		       	},{
		       		field: "break_min",
		       		title: "휴게시간",
		       		template: function(row){
		       			return row.break_min === undefined ? '' : row.break_min + '분';
		       		}
		       	},{
		        	width: 100,
		        	template : '<input type="button" id="" class="text_blue" onclick="workTypeDel(this);" value="삭제">'
		        }],
		        change: function (e){
		        	gridClick(e);
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
				
				checkedIds[dataItem.CODE_CD] = checked;
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
				});
				var biz_code = '';
				if ( record.biz_code == undefined ) {
					biz_code = null;
				} else {
					biz_code = record.biz_code;
				}
				
				$('#workTypeId').val(record.work_type_id);
				$('#work_type').val(record.work_type);
				$('#attend_time').val(record.attend_time);
				$('#leave_time').val(record.leave_time);
				$('#work_min').val(record.work_min/60);
				$('#break_min').val(record.break_min);
				
			}
		}
		
		function workTypeDel(e) {
			
			var row = $(e).closest('tr');
			var grid = $('#grid').data("kendoGrid");
			var dataItem = grid.dataItem(row);
			var key = dataItem.work_type_id;
			
			var result = confirm('삭제하시겠습니까?');
			if (result) {
				var data = {};
				data = {
						work_type_id : key
						};
				
				$.ajax({
					url: _g_contextPath_+"/workPlan/workTypeDel",
					dataType : 'text',
					data : data,
					type : 'POST',
					success : function(result){
						location.reload();
					}
				})
				
			}
			
		}
		
			</script>
	<!-- 날짜변경에 따라 바꿔줘야할 key id : holiDn, endWkTm, monthAgreeHour, weekAgreeHour -->

	<div class="iframe_wrap" style="min-width: 1070px;">
		<div class="sub_title_wrap">

			<div class="title_div">
				<h4>근무유형 설정</h4>
			</div>
		</div>
		<div class="sub_contents_wrap">

			<div class="btn_div mt10 cl">
				<div class="left_div">
					<p class="tit_p mt5 mb0">근무유형 설정</p>
				</div>

				<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="dataReset" onclick="">초기화</button>
					</div>
				</div>

			</div>

			<div class="com_ta">

				<div class="top_box gray_box" style="padding-top: 10px;padding-bottom: 10px" id="dataBox">
					<dl>
						<dt style="width: 80px;">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							근무유형
						</dt>
						<dd>
							<input type="text" id="work_type" name="" check="must" style="width: 142px" value="" />
						</dd>
						
						<dt style="width: 80px;margin-left: 8px">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							출근시간
						</dt>
						<dd>
							<input type="text" id="attend_time" name="" check="must" style="width: 142px" value="" opt="time" />
						</dd>
						
						<dt style="width: 80px;margin-left: 8px">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							퇴근시간
						</dt>
						<dd>
							<input type="text" id="leave_time" name="" check="must" style="width: 142px" value="" opt="time" />
						</dd>
						
						<dt style="width: 80px;margin-left: 8px">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							근무시간
						</dt>
						<dd>
							<input type="text" id="work_min" name="" check="must" style="width: 80px" value="" dType="min" /> 시간
						</dd>
						
						<dt style="width: 80px;margin-left: 8px">
							<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
							휴게시간
						</dt>
						<dd>
							<input type="text" id="break_min" name="" check="must" style="width: 80px" value="" /> 분
						</dd>
						
					</dl>

					
				</div>
			</div>

			<div style="margin: 0 auto;">
				<!-- 버튼 -->
				<div class="btn_div mt10 cl">
					<div class="left_div">
						<div class="controll_btn p0">
						<p class="tit_p mt5 mb0" style="display: inline;">
						근무유형 리스트
						</p>
						
						</div>
						
					</div>
					<div class="right_div">
					<div class="controll_btn p0">
						<button type="button" id="dataSave" onclick="">입력</button>
						<button type="button" id="dataMod" onclick="">수정</button>
					</div>
				</div>
				</div>
			</div>



					<div class="com_ta2">
						<div id="grid"></div>
					</div>

			
		</div>
	</div>
	
	<input type="hidden" value="0" id="workTypeId" />

</body>

</html>