<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<fmt:formatDate value="${weekDay}" var="nowDateToServer" pattern="yyyyMMdd" />
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

<script type="text/javascript">
	$(function(){
		//console.log("${empInfo}");
		/* 데이터 없을시 그리드 처리 함수 */
		function gridDataBound(e){
			var grid = e.sender;
			if(grid.dataSource.total()==0){
				var colCount = grid.columns.length;
				$(e.sender.wrapper)
					.find('tbody')
					.append('<tr class="kendo-data-row">' + 
							'<td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
			}
		}
		
		/*
			휴일근무 - 승인 [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기]
		*/
		$("#approvalBtn").click(function(){
			var ch = $(".checkbox:checked");
			var notApproved = true;
			if(ch.length < 1){
				alert("승인할 목록을 체크해주세요");
				return;
			}else{
				var jsonArray = new Array();
				var grid = $("#gridOverWkReqList").data("kendoGrid");
				$.each(ch, function(i,v){
					var row = grid.dataItem($(v).closest("tr"));
					var json = row.toJSON();
					if(json.approval_status === '2'){
						notApproved = false;
						return;
					}
					json.update_emp_seq = "${empInfo.empSeq}";
					json.approval_status = "2";
					jsonArray.push(json);
				});
				if(!notApproved) {
					alert("이미 승인된 항목입니다");
					return;
				}
				var list = JSON.stringify(jsonArray);
				var result = confirm('승인 하시겠습니까?');
				if(result){
					$.ajax({
						url: _g_contextPath_ + '/subHoliday/overWkApprovalUpdate',
						type: 'post',
						dataType: 'json',
						data: list,
						headers: { 
							/*
								JSON.stringify로 json배열 보낼때는 이거 써줘야함! 
								컨트롤러에서는 @RequestBody로 받아야됨!
							*/
					        'Accept': 'application/json',
					        'Content-Type': 'application/json' 
					    },
						success: function(json){
							if(json.code==='success'){
								mainGridReload();
								alert("서버 반영 성공!!");
							}else{
								alert("서버 반영 실패..");
							}
						}
					});
				}
			}
		});
		
		/*
			휴일근무 - 보고서 등록 팝업(#fileUploadPop) 
		*/
		var myWindow2 = $("#fileUploadPop");
		$(document).off('click').on('click', '[value="보고서등록"]', function(){
			var row = $("#gridOverWkReqList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			myWindow2.data("kendoWindow").open();
			$(document).off('submit').on('submit', "[name='fileUploadFrm']", function(e){
				e.preventDefault();
				var formData = new FormData($(this).get(0));
				formData.append('apply_start_date', json.apply_start_date);
				formData.append('apply_emp_name', json.apply_emp_name);
				formData.append('target_table_name', 'after_action_report_id');
				formData.append('target_id', json.ot_work_apply_id);
				formData.append('ot_work_apply_id', json.ot_work_apply_id);
				formData.append('update_emp_seq', "${empInfo.empSeq}");
				//formData.append('approval_status', '5');/* [0:변경신청, 1:신청, 2:승인, 4:반려, 5:휴일근무승인대기] */
				//formData.append('approval_status', '1');/* 한국문학번역원: 초과근무보고서 올리기 전에 승인절차 진행하고, 초과근무보고서는 사후에 볼 수 있도록 */
				//formData.append('remark', '초과근무보고서업로드');
				$.ajax({
					url: _g_contextPath_ + '/subHoliday/holiWkApprovalUpdate',
					type: 'post',
					dataType: 'json',
					data: formData,
					contentType: false,
					processData: false,
					success: function(json){
						if(json.code === 'success'){
							mainGridReload();
							myWindow2.data("kendoWindow").close();
							alert("서버 저장 성공!!");
							//document.fileUploadFrm.reset(); 나중에 사용가능한지 확인 multipart reset
							//location.reload(); //$(document).off('submit').on('submit', 으로 해결
						}else{
							alert("서버 저장 실패..");
						}
					}
				})
			});
		}); 
		myWindow2.kendoWindow({
			width: "620px",
			title: "초과근무보고서",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				$("[name='file']").val('');
			}
		}).data("kendoWindow").center();
		
		/*
			휴일근무 - 보고서 등록 파일업로드
		*/
		$(".file_input_button").on("click", function(){
			$(this).next().click();
		});
		$(document).on('change', "[name='file']", function(){
			var index = $(this).val().lastIndexOf('\\') + 1;
			var valLength = $(this).val().length;
			var row = $(this).closest('tr');
			var fileNm = $(this).val().substr(index, valLength);
			row.find('#fileID1').val(fileNm).css({'color':'#0033FF'});
		});
		
		/*
			보고서 양식 다운로드 
		*/
		$("#formDown").on('click', function(e){
			e.preventDefault();
			var downWin = window.open('','_self');
			downWin.location.href = 'http://gw.ltikorea.or.kr/gw/cmm/file/fileDownloadProc.do?fileId=3607&fileSn=&moduleTp=board&pathSeq=500';
		});
		
		/*
			휴일근무 - 보고서 다운로드 팝업(#fileDownloadPop)
		*/
		var myWindow = $("#fileDownloadPop");
		$(document).on('click', "[value='초과근무보고서']", function(){
			$("#report_name").html($(this).val());
			var row = $("#gridOverWkReqList")
						.data("kendoGrid")
						.dataItem($(this).closest("tr"));
			var json = row.toJSON();
			var target_table_name = '';
			if($(this).val() === '근무계획서'){
				target_table_name = "work_plan_report_id";
			}else if($(this).val() === '초과근무보고서'){
				target_table_name = "after_action_report_id";
			}
			myWindow.data("kendoWindow").open();
			$.getJSON(_g_contextPath_ + '/subHoliday/getFileInfo',
					{'target_table_name': target_table_name, 'target_id': json.ot_work_apply_id},
					function(data){
						$("#fileDownloadDiv").empty();
						var real_file_name = data.real_file_name,
							file_extension = data.file_extension
							attach_file_id = data.attach_file_id;
						html = document.querySelector("#fileDownloadTemplate").innerHTML;
						var resultHTML = html.replace("{real_file_name}", real_file_name)
											 .replace("{file_extension}", file_extension)
											 .replace("{attach_file_id}", attach_file_id);
						$("#fileDownloadDiv").append(resultHTML);
					});
		});
		myWindow.kendoWindow({
			width: "400px",
			title: "첨부파일 다운로드",
			visible: false,
			modal: true,
			actions: [
				"Close"
			],
			close: function(){
				
			}
		}).data("kendoWindow").center();
		
		/*
			휴일근무 - 초과근무보고서 파일 다운로드
		*/
		$(document).on('click', '#fileText', function(e){
			e.preventDefault();
			var attach_file_id = $("[name='attach_file_id']").val();
			$.ajax({
				url: _g_contextPath_ + '/common/fileDown',
				type: 'get',
				data: {'attach_file_id': attach_file_id}
			}).success(function(data){
				var downWin = window.open('','_self');
				downWin.location.href = _g_contextPath_+'/common/fileDown?attach_file_id='+attach_file_id;
			});
		});
		
		/*
			휴일근무 - 조회
		*/
		var mainGridReload = function(){
			$("#gridOverWkReqList"/* Mapping1 */).data("kendoGrid").dataSource.read();
		}
		$(document).on('submit', "[name='overWkReqListFrm']", function(e){
			e.preventDefault();
			mainGridReload();
		});
		var mainGrid = function(){
			var grid = $("#gridOverWkReqList"/* Mapping1 */).kendoGrid({
				dataSource: new kendo.data.DataSource({
					serverPaging: true,
					pageSize: 10,
					transport: {
						read: {
							url: _g_contextPath_+ '/subHoliday/gridOverWkReqList',/* Mapping1 */
							dataType: 'json',
							type: 'post',
							cache: false,
							contentType: false,
							processData: false
						},
						parameterMap: function(data, operation){
							var formData = new FormData($("[name='overWkReqListFrm']").get(0));;
							formData.append('take', data.take);
							formData.append('skip', data.skip);
							formData.append('page', data.page);
							formData.append('pageSize', data.pageSize);
							formData.append('group_code', 'OVERWK_TYPE');
							formData.append('code', '02');
							return formData;
						}
					},
					schema: {
						data: function(response){
							return response.list;
						},
						total: function(response){
							return response.totalCount;
						}
					}
				}),
				height: 436,
				dataBound: gridDataBound,
				sortable: true,
				pageable: {
					refresh: true,
					pageSizes: true,
					buttonCount: 5
				},
				persistSelection: true,
				selectable: 'multiple',
				columns: [
				{
					field: "approval_status_kr",
					title: "진행단계",
					template: function(row){
						var status = row.approval_status;
						var status_kr = '';
						switch(status){
						case '0': status_kr = '변경신청'; break;
						case '1': status_kr = '신청'; break;
						case '2': status_kr = '승인'; break;
				 		//case '3': status_kr = '승인취소'; break;
						case '4': status_kr = '반려'; break;
						case '5': status_kr = '승인대기'; break;
						}
						return status_kr;
					}
				},{
		            field: "str_to_date",
		            title: "신청일자"
		        },{
		            field: "weekday",/* 쿼리필요 */
		            title: "요일",
		            template : function(row){
		            	var key = '';
		            	if ( row.weekday == undefined ) {
		            		key = '대체휴무 데이터 이관';
		            	} else {
		            		key = row.weekday;
		            	}
		            	switch(key){
		            	case '토': return "<span style='color:blue'>"+ key +"</span>"; break;
		            	case '일': return "<span style='color:red'>"+ key +"</span>"; break;
		            	default : return "<span>"+ key +"</span>"; break; 
		            	}
		            },
		            width: 50
		        },{
		            field: "apply_dept_name",
		            title: "부서"
		        },{
		            field: "apply_emp_name",/* 쿼리필요 */
		            title: "성명"
		        },{
		            field: "apply_position",
		            title: "직급"
		        },{
		            field: "apply_duty",
		            title: "직책"
		        },{
		          	field: "apply_start_time",
		          	title: "시작시간"
		        },{
		            field: "apply_end_time",
		            title: "종료시간"
		        },/* {
		        	field: "work_type",
		        	title: "휴일근무유형"
		        }, */{
			        field: "work_dscr",
			        title: "업무내용",
		        },/* {
		        	field: "action_plan",
		        	title: "근무계획서",
		        	template: function(row){
		        		return "<input type='button' class='fileDownLoad text_blue' value='근무계획서'>";
		        	}
		        }, */{
		        	field: "work_start_time",
		        	title: "실제출근시간"
		        },{
		        	field: "work_end_time",
		        	title: "실제퇴근시간"
		        },{
		        	field: "work_place",
		        	title: "근무지",
		        	template: function(row){
		        		if(row.work_place === 'outdoor'){
		        			return "<span>외근</span>";
		        		}else if(row.work_place === 'indoor'){
		        			return "<span>내근</span>";
		        		}else{
		        			return "";
		        		}
		        	}
		        },{
		        	field: "after_action_report",
		        	title: "초과근무보고서",
		        	template: function(row){
		        		if(row.work_place == 'outdoor'){
		        			/* if(row.approval_status == '5' || row.approval_status == '2'){
			        			return '<input type="button" class="fileDownLoad text_blue" value="초과근무보고서">'; 
			        		}else if(row.approval_status == '1'){
			        			return '<input type="button" class="text_red fileUpLoad" value="보고서등록">';
			        		}  */
			        		if(row.after_action_report_id === undefined){
			        			return '<input type="button" class="text_red fileUpLoad" value="보고서등록">';
			        		}else{
			        			return '<input type="button" class="fileDownLoad text_blue" value="초과근무보고서">'; 
			        		}
		        		}else{
		        			return '';
		        		}
		        	}
		        },{
		            field: "reward_type",
		            title: "보상선택",
		            template: function(row){
						var reward_type = row.reward_type;
						var reward_type_result = '';
						switch(reward_type){
						case '1': reward_type_result = '수당'; break;
						case '2': reward_type_result = '보상휴가'; break;
						}
						return reward_type_result;
					}
		        }],
				change: function(e){
					//codeGridClick(e);
				}
			}).data("kendoGrid");
			
			function codeGridClick(e){
 				var rows = grid.select();
				var record;
				rows.each(function(){
					record = grid.dataItem($(this));
					console.log(record);
				}); 
			}
		}
				
		mainGrid();
		
	});
</script>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="title_div">
			<h4>근무계획</h4>
		</div>
	</div>
	<div class="sub_contents_wrap">
		<form method="post" name="overWkReqListFrm"
		action="${pageContext.request.contextPath }/subHoliday/gridOverWkReqList">
			<div class="top_box">
				<dl>
					<dt class="ar" style="width: 75px">부서</dt>
					<dd>
						<input type="text" name="apply_dept_name" disabled="disabled" 
						value="${empInfo.orgnztNm }" style="width:160px;"/> 
					</dd>
					<dt class="ar" style="width: 75px">성명</dt>
					<dd>
						<input type="text" id="applyEmpName" disabled="disabled" 
						value="${empInfo.empName }" style="width:160px;"/> 
						<input type="hidden" name="apply_emp_seq" value="${empInfo.empSeq }">
						<input type="hidden" name="apply_position" value="${empInfo.positionNm }">
					</dd>
					<dt class="ar" style="width: 75px">기간</dt>
					<dd>
						<input type="text" value="" id="startDt" name="startDt" class="w113 datePickerInput"/>
						&nbsp;~&nbsp;
						<input type="text" value="" id="endDt"	name="endDt" class="w113 datePickerInput" />
					</dd>
				</dl>
			</div>
			<div class="btn_div mt10 cl">
				<div class="right_div">
					<div class="controll_btn p0">
						<button type="submit" id="gridReloadBtn">조회</button>
					</div>
				</div>
			</div>
		</form>
		<div class="com_ta2 mt20" id="gridOverWkReqList"></div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

<!-- 보고서 등록 팝업 -->
<div class="pop_wrap_dir" id="fileUploadPop" style="width:620px;">
	<div class="pop_head">
		<h1>파일 첨부</h1>
	</div>
	<form method="post" name="fileUploadFrm" enctype="multipart/form-data"
	action="${pageContext.request.contextPath }/subHoliday/fileUpload">
		<div class="pop_con">
			<div class="com_ta">
				<div id="fileDiv">
					<table>
						<colgroup>
							<col width="180"/>
							<col width=""/>	
						</colgroup>
						<tr id="fileTr">
							<th style="font-weight: bold;"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />초과근무보고서</th>
							<td id="fileTd" class="le">
								<input type="text" id="fileID1" class="file_input_textbox clear" readonly="readonly" 
								style="width:200px; text-align: center;" placeholder="파일 선택" /> 
								<input type="button" value="업로드" class="file_input_button ml4 normal_btn2" /> 
								<input type="file" id="fileID" name="file" value="" class="hidden" />
								<input type="button" value="양식다운로드" id="formDown" class="ml4 normal_btn2" />
							</td>
						</tr>
					</table>
				</div>
			</div>	
		</div>
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="submit" class="blue_btn" id="sendBtn" value="전송" />
			</div>
		</div>
	</form>
</div>

<!-- 보고서 다운로드 팝업 -->
<div class="pop_wrap_dir" id="fileDownloadPop" style="width:400px; display: none;">
	<div class="pop_con">
		<div class="btn_div mt0">
			<div class="left_div">
				<h5 id="report_name"></h5>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
				</div>
			</div>
		</div>
		<div class="com_ta" style="" id="">
			<table id="fileDownloadDiv"></table>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" value="닫기"/>
		</div>
	</div>
</div>

<script id="fileDownloadTemplate" type="text/template">
	<tr>
		<th>첨부파일</th>
		<td class="le">
			<span style="display:block;" class="mr20">
				<form name="fileDownFrm" action="<c:url value='/common/fileDown'/>">
					<img src="<c:url value='/Images/ico/ico_clip02.png'/>" alt="attach_file">&nbsp;
					<a href="#n" style="line-height: 23px; cursor: pointer; color: #0033FF"
				 	id="fileText" class="file_name">{real_file_name}.{file_extension}</a>&nbsp;
					<input type="hidden" name="attach_file_id" value="{attach_file_id}">
				</form>
			</span>
		</td>
	</tr>
</script>