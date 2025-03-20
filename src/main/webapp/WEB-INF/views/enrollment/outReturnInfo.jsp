<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>


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

.k-dropdown-wrap.k-state-default {
	overflow: hidden;
}

select {
	height:24px;
	border:1px solid #c3c3c3;
	padding-left:7px;
	padding-right:20px;
	color:#515967;
	-webkit-appearance: none;  /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
	background:#fff url("../Images/ico/sele_arw01.png") no-repeat right center;
}

</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width: 1100px">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">

		<div class="title_div">
			<h4>외출/복귀</h4>
		</div>
	</div>

	<div class="sub_contents_wrap">
		<p class="tit_p mt5 mt20">외출/복귀 등록</p>
		<div class="top_box">
			<dl style="height: 40px;">
				<dt class="ar" style="width: 65px">날짜</dt>
				<dd>
					<input type="text" value="" id="startDt" class="w113"/>
						&nbsp;~&nbsp;
					<input type="text" value="" id="endDt"	class="w113" />
                </dd>
			</dl>
		</div>
		
		<div class="btn_div" style="margin-top: 20px;">
			<div class="left_div">
				<p class="tit_p mt5 mb0">외출/복귀 리스트</p>
			</div>

			<div class="right_div">
				<div class="controll_btn p0">
					<button type="button" id="" onclick="gridReload()">조회</button>
					<button type="button" id="btnOut" onclick="window.open('${pageContext.request.contextPath }/other/online/vacationPop.do','window_name', 'location=no, status=no');">외출 신청</button>
					<!-- <button type="button" id="btnReturn">복귀</button> -->
				</div>
			</div>
		</div>

		<div style="text-align: right">
			<p style="font-weight: bold">※ 복귀 시간은 한 번만 등록할 수 있습니다. (등록 후 버튼 사라짐)</p>
		</div>

		<div class="com_ta2 mt15" style="margin-top: 5px !important;">
			<div id="grid"></div>
		</div>
	</div>
	<!-- //sub_contents_wrap -->
</div>
<!-- iframe wrap -->

<div class="pop_wrap_dir" id="outInfoPop"
	style="width: 430px; height: 200px;" hidden>
	<div class="pop_head">
		<h1>외출시간 등록</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="3">외출날짜입력</th>
					<td class="le">
						<input type="text" value="" id="targetDt" class="w113" />
					</td>
				</tr>
				<tr>
					<th colspan="3">외출시간입력</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="outTimePicker" name="out_time" />
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="popRegister"
				onclick="outInfoInsert();" value="등록" /> <input type="button"
				class="gray_btn" id="outInfoPopCancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<%-- <div class="pop_wrap_dir" id="returnInfoPop"
	style="width: 430px; height: 200px;" hidden>
	<div class="pop_head">
		<h1>복귀시간 등록</h1>
	</div>
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120" />
					<col width="" />
				</colgroup>
				<tr>
					<th colspan="3">복귀날짜입력</th>
					<td class="le">
						<input type="text" value="" id="targetDt2" class="w113" />
					</td>
				</tr>
				<tr>
					<th colspan="3">복귀시간입력</th>
					<td class="le">
						<span style="display:block;" class="mr20">
							<input id="returnTimePicker" name="return_time" />
						</span>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="blue_btn" id="popRegister2"
				onclick="returnInfoInsert();" value="등록" /> <input type="button"
				class="gray_btn" id="returnInfoPopCancle" value="닫기" />
		</div>
	</div>
	<!-- //pop_foot -->
</div> --%>
<!-- //pop_wrap -->

<script type="text/javascript">

	console.log('${loginVO}');

	$(function() {
		var date = new Date(), y = date.getFullYear(), m = date.getMonth();
		var firstDay = new Date(y, m, 1);
		var lastDay = new Date(y, m + 1, 0);
		$("#startDt").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value: firstDay
		});
		$("#endDt").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value : lastDay
		});
		$("#targetDt").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value : date
		});
		/*$("#targetDt2").kendoDatePicker({
			start : "month",
			depth : "month",
			format : "yyyy-MM-dd",
			parseFormats : [ "yyyy-MM-dd" ],
			culture : "ko-KR",
			value : date
		});*/
		
		$("#startDt").attr("readonly", true);
		$("#endDt").attr("readonly", true);
		$("#targetDt").attr("readonly", true);
		//$("#targetDt2").attr("readonly", true);
		
		//팝업창 시간 선택
		/*$("#outTimePicker").kendoTimePicker({
			culture: "kr-KR",
			value: new Date(),
			format: "HH:mm",
			interval: 1
		});
		
		$("#returnTimePicker").kendoTimePicker({
			culture: "kr-KR",
			value: new Date(),
			format: "HH:mm",
			interval: 1
		});*/
		
		mainGrid();
		
		//outInfoPop();
		//returnInfoPop();
	});
	

	var dataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : "<c:url value='/enrollment/outReturnList'/>",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data, operation) {
				data.empSeq = "<c:out value='${loginVO.empSeq}'/>";
                data.to = $("#startDt").val();
                data.from = $("#endDt").val();
				//data.code_kr = $('#searchCode').val();

				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				record = response.list.length;

				return record;
			}
		}
	});
	
	/* 데이터 없을 시 첫번째 그리드 처리 함수 */
	function gridDataBound(e) {
		var grid = e.sender;
		if (grid.dataSource.data.length == 0) {
			var colCount = grid.columns.length;
			$(e.sender.wrapper)
					.find('tbody')
					.append(
							'<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">데이터가 없습니다.</td></tr>');
		}
	};

	function mainGrid() {
		//캔도 그리드 기본
		var grid = $("#grid").kendoGrid(
			{
				dataSource : dataSource,
				height : 550,
				dataBound : function(e) {
					gridDataBound(e);
				},
				sortable : true,
				pageable : {
					refresh : true,
					pageSizes : [ 10, 20, 30, 50, 100 ],
					buttonCount : 5
				},
				persistSelection : true,
				selectable : "multiple",
				columns : [
						{
							title: "번호",
							template: "#= record-- #",
							width : 20
						}, {
                            field: "EMP_NAME",
                            title: "사용자명",
                            width: 50
                        }, {
							field : "ORI_TARGET_DATE",
							title : "일자",
							width : 50
						}, {
							field : "ORI_OUT_TIME",
							title : "시작시간",
							width : 50
						}, {
							field : "ORI_RETURN_TIME",
							title : "종료시간",
							width : 50
						}, {
                            field : "OUT_TIME",
                            title : "총 신청시간",
                            width : 50
                        }, /*{
                            field : "ORI_UPDT_DGRE",
                            title : "수정차수",
                            width : 100
                        }, */
						{
							field : "VCATN_OUT_TIME",
							title : "실제 외출시간",
							width : 50
						},
						{
							field : "",
							title : "외출 등록",
							width : 50,
							template : function (dataItem) {
								console.log(dataItem);
								if (dataItem.VCATN_OUT_TIME != "" && dataItem.VCATN_OUT_TIME != null){
									return "";
								} else {
									return "<div class=\"controll_btn p0\" style=\"text-align: center;\"><button type=\"button\" id=\"btnReturn\" onclick=\"fnSetOut(" + dataItem.ORI_ID + ",'" + dataItem.ORI_OUT_TIME + "','" + dataItem.ORI_RETURN_TIME + "', '" + dataItem.ORI_TARGET_DATE + "')\">외출</button></div>";
								}
							}
						},
						{
							field : "VCATN_RET_TIME",
							title : "실제 복귀시간",
							width : 50
						},{
                            field : "",
                            title : "복귀 등록",
                            width : 50,
                            template : function (dataItem) {
                                console.log(dataItem);
								if (dataItem.VCATN_RET_TIME != "" && dataItem.VCATN_RET_TIME != null){
									return "";
								} else {
									return "<div class=\"controll_btn p0\" style=\"text-align: center;\"><button type=\"button\" id=\"btnReturn\" onclick=\"fnSetReturn(" + dataItem.ORI_ID + ",'" + dataItem.ORI_OUT_TIME + "','" + dataItem.ORI_RETURN_TIME + "', '" + dataItem.ORI_TARGET_DATE + "')\">복귀</button></div>";
								}
                            }
                        },{
							field : "STATUS",
							title : "기타",
							width : 50,
							template: function(dataItem){
								if(dataItem.STATUS == "초과"){
									return "<div style=\"color: red;\">" + dataItem.STATUS + "</div>";
								} else if (dataItem.STATUS == "정상"){
									return "<div style=\"color: blue;\">" + dataItem.STATUS + "</div>";
								} else {
									return "";
								}
							}
						},/*{
						field : "",
						title : "테스트",
						width : 200,
						template : function (dataItem) {
							return '<div class="controll_btn p9" style="display: flex; justify-content: center;">' +
								   '<button type="button" id="" onclick="testBtn1(\''+dataItem.ORI_TARGET_DATE+'\');">오전외출</button>' +
								   '<button type="button" id="" style="margin: 0 5px;" onclick="testBtn2();">업무중외출</button>' +
								   '<button type="button" id="" onclick="testBtn3();">오후외출</button></div>';
						}
					}*/],
				change : function(e) {
					codeGridClick(e)
				}
			}).data("kendoGrid");

		grid.table.on("click", ".checkbox", selectRow);

		var checkedIds = {};

		// on click of the checkbox:
		function selectRow() {

			var checked = this.checked, row = $(this).closest("tr"), grid = $(
					'#grid').data("kendoGrid"), dataItem = grid.dataItem(row);

			checkedIds[dataItem.CODE_CD] = checked;
			if (checked) {
				//-select the row
				row.addClass("k-state-selected");
			} else {
				//-remove selection
				row.removeClass("k-state-selected");
			}

		}
		function codeGridClick() {
			var rows = grid.select();
			var record;
			rows.each(function() {
				record = grid.dataItem($(this));
				console.log(record);
			});

		}
	}
	
	function gridReload() {
		$('#grid').data('kendoGrid').dataSource.read();
	}

	// 외출
	/*function outInfoPop() {

		var myWindow2 = $("#outInfoPop");
		undo2 = $("#btnOut");

		undo2.click(function() {

			myWindow2.data("kendoWindow").open();	
			
			//팝업창 시간 선택
			$("#outTimePicker").kendoTimePicker({
				culture: "kr-KR",
				value: new Date(),
				format: "HH:mm",
				interval: 1
			});
			
			/!*$("#returnTimePicker").kendoTimePicker({
				culture: "kr-KR",
				value: new Date(),
				format: "HH:mm",
				interval: 1
			});*!/
			
		});

		$("#outInfoPopCancle").click(function() {
			myWindow2.data("kendoWindow").close();
		});
		
		myWindow2.kendoWindow({
			width : "430px",
			height : "200px",
			visible : false,
			modal : true,
			actions : [ "Close" ]
		}).data("kendoWindow").center();
	}*/

	function outInfoInsert() {
		
		var data = {
			targetDate: $("#targetDt").val(),
			outTime: $("#targetDt").val() + " " + $("#outTimePicker").val() + ":00",
			empSeq: "<c:out value='${loginVO.empSeq}'/>"
			
		}
		$.ajax({
			url : _g_contextPath_ + "/enrollment/outInfoInsert",
			data : data,
			dataType : "json",
			type : "post",
			async : false,
			success : function(rs) {
				alert(rs.check.message);
				console.log(rs.check.message);
				//$("#outTime").val('');
				//mainGrid();
				
				location.reload();
			}
		});
	}
	
	// 복귀
	/*function returnInfoPop() {

		var myWindow3 = $("#returnInfoPop");
		undo3 = $("#btnReturn");

		undo3.click(function() {

			myWindow3.data("kendoWindow").open();
			
		});

		$("#returnInfoPopCancle").click(function() {
			myWindow3.data("kendoWindow").close();
		});
		myWindow3.kendoWindow({
			width : "430px",
			height : "200px",
			visible : false,
			modal : true,
			actions : [ "Close" ]
		}).data("kendoWindow").center();
	}

	function returnInfoInsert() {
		
		var data = {
			targetDate: $("#targetDt").val(),	// 기준일
			
			returnTime: $("#targetDt2").val() + " " + $("#returnTimePicker").val() + ":00",
			empSeq: "<c:out value='${loginVO.empSeq}'/>"
			
		}
		$.ajax({
			url : _g_contextPath_ + "/enrollment/returnInfoInsert",
			data : data,
			dataType : "json",
			type : "post",
			async : false,
			success : function(rs) {
				alert(rs.check.message);
				console.log(rs.check.message);
				//$("#outTime").val('');
				//mainGrid();
				
				location.reload();
			}
		});
	}*/

	function fnSetOut(k, a, b, day){
		var nowDate = new Date();

		var nowHour = nowDate.getHours();
		var nowMinute = nowDate.getMinutes();

		var flag = false;

		if(b == '12:00'){
			if(nowHour == 13) {
				if (nowMinute < 5) {
					flag = true;
				}
			}else if(nowHour < 13){
				flag = true;
			}
		}

		if(confirm("외출시간을 등록하시겠습니까?")){
			if(flag != true){if(flag == true){
				alert("외출 시간이 등록되었습니다.");
				var data = {
					key : k,
					status : "정상"
				}
				// 실 외출시간 update
				$.ajax({
					url : _g_contextPath_ + "/enrollment/setOutTime",
					data : data,
					dateType :"json",
					type : "post",
					success : function (rs){

						gridReload();
					}
				});
			} else {
				alert("외출 시간이 등록되었습니다.");
				var data = {
					key : k,
					status : "정상"
				}
				// 실 외출시간 update
				$.ajax({
					url : _g_contextPath_ + "/enrollment/setOutTime",
					data : data,
					dateType :"json",
					type : "post",
					success : function (rs){

						gridReload();
					}
				});
			}
			}
		}
	}



    // 외출복귀 function (k: key, a: 외출신청시간, b: 복귀신청시간, day: 날짜)
    function fnSetReturn(k, a, b, day){

        var outDate = new Date(day + " " + a);
        var returnDate = new Date(day + " " + b);
		var nowDate = new Date();

		var nowHour = nowDate.getHours();
		var nowMinute = nowDate.getMinutes();

		returnDate.setMinutes(returnDate.getMinutes() + 10);

		var flag = false;

		if(b == '12:00'){
			if(nowHour == 13) {
				if (nowMinute < 5) {
					flag = true;
				}
			}else if(nowHour < 13){
				flag = true;
			}
		}

		if(confirm("복귀시간을 등록하시겠습니까?")){
			if(outDate < nowDate){  //외출신청시간 < 현재시간일때 복귀시간 등록이 가능
				if(returnDate < nowDate && flag != true){ //복귀신청시간 < 현재시간일때 복귀시간이 초과
					alert("복귀 시간이 초과되었습니다.");
					var data = {
						key : k,
						status : "초과"
					}
					// 실 복귀시간 update
					$.ajax({
						url : _g_contextPath_ + "/enrollment/setReturnTime",
						data : data,
						dateType :"json",
						type : "post",
						success : function (rs){

							gridReload();
						}
					});
				} else if(flag == true){
					alert("복귀 시간이 등록되었습니다.");
					var data = {
						key : k,
						status : "정상"
					}
					// 실 복귀시간 update
					$.ajax({
						url : _g_contextPath_ + "/enrollment/setReturnTime",
						data : data,
						dateType :"json",
						type : "post",
						success : function (rs){

							gridReload();
						}
					});
				} else {
					alert("복귀 시간이 등록되었습니다.");
					var data = {
						key : k,
						status : "정상"
					}
					// 실 복귀시간 update
					$.ajax({
						url : _g_contextPath_ + "/enrollment/setReturnTime",
						data : data,
						dateType :"json",
						type : "post",
						success : function (rs){

							gridReload();
						}
					});
				}
			} else {
				alert("외출 일정 이후에 복귀 시간을 등록할 수 있습니다.");
				return;
			}
		}





        var rtCheck = false;
        var returnFlag = false;

        /*if(b > 0){
            rtCheck = confirm("이미 복귀하셨습니다. 현재 시간으로 복귀시간을 변경하시겠습니까?");

            if(!rtCheck){
                return;
            }
        }

        if(b == 0){
            returnFlag = confirm("복귀하시겠습니까?");

            if(!returnFlag){
                return;
            }
        }*/

        // 복귀 데이터 업로드
        /*if(rtCheck || returnFlag){
            var data = {
                key : k,
            }
            $.ajax({
                url : _g_contextPath_ + "/enrollment/setReturnTime",
                data : data,
                type : "post",
                dataType : "json",
                success : function(rs){
                    alert(rs.ms);

                    gridReload();
                }
            });
        }*/

    }

	/* 신청취소 */
	function formOpen(approKey){

		var subData = {};
		subData.approKey = approKey;

		$.ajax({
			url:"<c:url value='/vcatn/getOutingAnnvDocInfo'/>",
			data: subData,
			type: 'POST',
			dataType: 'json',
			async: false,
			success:function(result){

				var data = {};
				data.mod = 'W';
				data.outProcessCode = "VAC02";
				data.contentsStr = makeContentStr(docNo);
				data.compSeq = "${loginVO.compSeq}";
				//data.empSeq = "${loginVO.uniqId}";
				data.empSeq = "${loginVO.empSeq}";
				data.approKey = approKey;


				//window.open("",  "viewer", "width=1000px, height=900px, resizable=no, scrollbars = yes, status=no, top=50, left=50", "newWindow");


				outProcessLogOn(data);
				window.close();
			}
		});

	}


	//사용자 근태 정보 조회
	// day: 외출날짜
	function testBtn1(day){

		var attData = {
			empSeq: "${loginVO.empSeq}",
			attDate: day,
		}

		$.ajax({
			url: _g_contextPath_ + "/vcatn/getAttInfo",
			data: attData,
			type: 'POST',
			dataType: 'json',
			success:function(rs){

				console.log(rs.att);	//근태내역
				console.log(rs.req);	//연차신청내역

				var comeDt = rs.att.come_dt.substring(0,4) + "-" + rs.att.come_dt.substring(4,6) + "-" + rs.att.come_dt.substring(6,8);	//출근날짜
				var comeTm = rs.att.come_dt.substring(8,10) + ":" + rs.att.come_dt.substring(10,12);	//출근시간
				var reqEdDt = rs.req.end_dt.substring(0,4) + "-" + rs.req.end_dt.substring(4,6) + "-" + rs.req.end_dt.substring(6);	//외출복귀날짜
				var reqEdTm = rs.req.end_time.substring(0,2) + ":" + rs.req.end_time.substring(2);	//외출복귀시간


				console.log("출근날짜 " + comeDt);
				console.log("출근시간 " + comeTm);
				console.log("외출날짜 " + reqEdDt);
				console.log("외출종료시간 " + reqEdTm);

				var come = new Date(comeDt + " " + comeTm);
				var req = new Date(reqEdDt + " " + reqEdTm);

				console.log(come);
				console.log(req);

				req.setMinutes(req.getMinutes() + 5);
				console.log(req);

				if(come > req){
					alert("지각!")

				} else {
					alert("복귀!")
				}




			}
		});
	}

	
</script>