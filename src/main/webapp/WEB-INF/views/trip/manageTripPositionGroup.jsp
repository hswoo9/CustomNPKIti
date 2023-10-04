<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="com.duzon.custom.common.utiles.DJMessage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%String langCode = (session.getAttribute("langCode") == null ? "kr" : (String)session.getAttribute("langCode")).toLowerCase();%>

<script>
   	var langCode = "<%=langCode%>";
</script>

<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css2/common.css"/>
	    
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ucgridtable.1.0.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#mode").val("I");			// 입력구분
	$("#domestic_div").val("L");	// 국내외구분
	
	// 신규버튼 클릭
	$("#newButton").click(function() {
		$("#mode").val("I");
		
		if($("#domestic_div").val() == "L"){
			$("form").each(function() {  
				if(this.id == "regForm1") this.reset();  
			});			
		}else if($("#domestic_div").val() == "F"){
			$("form").each(function() {  
				if(this.id == "regForm2") this.reset();  
			});
		}
		f_reload();
	});
	
	// 저장버튼 클릭
	$("#saveButton").click(function() {		
		f_save();
	});
	
	// 삭제버튼 클릭
	$("#deleteButton").click(function() {		
		f_delete();
	});
	
	// 검색버튼 클릭
	$("#searchButton_L").click(function() {		
		f_search();
	});
	
	$("#searchButton_F").click(function() {		
		f_search();
	});
	
	$("input[name=searchWord_L]").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	f_search();
        }
    });
	
	$("input[name=searchWord_F]").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	f_search();
        }
    });
	
// 	f_reload();
});

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

// 직책그룹 저장
function f_save(){
	
	var saveUrl = "";
	var selPosition = "";
	var isChecked = false;
	
	if($("#domestic_div").val() == "L"){
		$("#pgroupname_kr").val($("#pgroupname_kr_L").val());
		$("#pgroupname_en").val($("#pgroupname_en_L").val());
		$("#pgroupname_jp").val($("#pgroupname_jp_L").val());
		$("#pgroupname_cn").val($("#pgroupname_cn_L").val());
		$("#order_num").val($("#order_num_L").val());
		$("#note").val($("#note_L").val());
		
		if($('input:checkbox[name="sel_position_L"]').is(":checked")){
			isChecked = true;
			$("input[name=sel_position_L]:checked").each(function() {
				if(selPosition != ""){
					selPosition = selPosition + "," + $(this).val();
				}else{
					selPosition = $(this).val();
				}
			});
			$("#sel_position").val(selPosition);
		}else{
			isChecked = false;
		}
	}else if($("#domestic_div").val() == "F"){
		$("#pgroupname_kr").val($("#pgroupname_kr_F").val());
		$("#pgroupname_en").val($("#pgroupname_en_F").val());
		$("#pgroupname_jp").val($("#pgroupname_jp_F").val());
		$("#pgroupname_cn").val($("#pgroupname_cn_F").val());
		$("#order_num").val($("#order_num_F").val());
		$("#note").val($("#note_F").val());
		
		if($('input:checkbox[name="sel_position_F"]').is(":checked")){
			isChecked = true;
			$("input[name=sel_position_F]:checked").each(function() {
				if(selPosition != ""){
					selPosition = selPosition + "," + $(this).val();
				}else{
					selPosition = $(this).val();
				}
			});
			$("#sel_position").val(selPosition);
		}else{
			isChecked = false;
		}
	}
	
	if($.trim($("#pgroupname_kr").val()) == ""){
		alert("<%=DJMessage.getMessage("TX000005902","그룹명을 입력해주세요.", langCode)%>");
		$("#pgroupname_kr").focus();
		return;
	}else if(!isChecked){
		alert("<%=DJMessage.getMessage("TX000010705","직책을 선택해주세요.", langCode)%>");
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000004920","입력한 내용으로 저장하시겠습니까?", langCode)%>")){
		if($("#mode").val() == "I"){
			saveUrl = '${pageContext.request.contextPath}/trip/insertTripPositionGroup';
		}else if($("#mode").val() == "U"){
			saveUrl = '${pageContext.request.contextPath}/trip/updateTripPositionGroup';
		}
		
		$.ajax({
			type: 'POST',
			url:saveUrl,
			data:{
					"domesticDiv":$("#domestic_div").val()
					,"pgroupnameKr":$("#pgroupname_kr").val()
					,"pgroupnameEn":$("#pgroupname_en").val()
					,"pgroupnameJp":$("#pgroupname_jp").val()
					,"pgroupnameCn":$("#pgroupname_cn").val()
					,"orderNum":$("#order_num").val()
					,"note":$("#note").val()
					,"selPosition":$("#sel_position").val()
					,"pgroupSeq":$("#pgroup_seq").val()
				},
			success: function(e){
				if(e){
					alert("<%=DJMessage.getMessage("TX000002544","저장 되었습니다.", langCode)%>");
					f_reload();
					$("#mode").val("I");
					
					if($("#domestic_div").val() == "L"){
						$("form").each(function() {  
							if(this.id == "regForm1") this.reset();  
						});			
					}else if($("#domestic_div").val() == "F"){
						$("form").each(function() {  
							if(this.id == "regForm2") this.reset();  
						});
					}
				}else{
					alert("<%=DJMessage.getMessage("TX000012787","저장을 실패하였습니다.", langCode)%>");
				}
			}
		});
	}
}

// 직책그룹 삭제
function f_delete(){
	//alert($("#pgroup_seq").val());
	
	if($("#pgroup_seq").val() == ""){
		alert("<%=DJMessage.getMessage("TX000006888","삭제할 데이터를 선택해주세요.", langCode)%>");
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000012275","삭제하시겠습니까?", langCode)%>")){
		$.ajax({
			type: 'POST',
			url:'${pageContext.request.contextPath}/trip/deleteTripPositionGroup',
			data:{
					"domesticDiv":$("#domestic_div").val()
					,"pgroupSeq":$("#pgroup_seq").val()
				},
			success: function(e){
				if(e.success){
					alert("<%=DJMessage.getMessage("TX000012947","데이터가 삭제 되었습니다.", langCode)%>");
					// 직책그룹 목록 reload
					f_reload();
					$("#mode").val("I");
					
					if($("#domestic_div").val() == "L"){
						$("form").each(function() {  
							if(this.id == "regForm1") this.reset();  
						});			
					}else if($("#domestic_div").val() == "F"){
						$("form").each(function() {  
							if(this.id == "regForm2") this.reset();  
						});
					}
				}else{
					if(e.isApply){
						alert("<%=DJMessage.getMessage("TX000020770","선택한 직책그룹의 단가목록이 존재하여 삭제가 불가합니다.", langCode)%>");						
					}else{
						alert("<%=DJMessage.getMessage("TX000002106","삭제에 실패하였습니다.", langCode)%>");						
					}		
				}
			}
		});
	}	
}

//그리드 리로드
function f_reload(){
	
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripPositionGroupList',
		data:{
				"domesticDiv":$("#domestic_div").val()
		},
		success: function(e){
			f_setGrid(e.tripPositionGroupList);
			f_setGrid2(e.positionGroupList);
		}
	});
}

//그리드 Row 선택
function f_select(pgroupSeq, selPosition){
	
	$("#pgroup_seq").val(pgroupSeq);	// 현재 선택한 직책그룹 시퀀스 저장
	$("#mode").val("U");;				// 업데이트 모드로 변경
	
	// 선택한 출장지 상세정보 로드
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripPositionGroupDetail',
		data:{
				"domesticDiv":$("#domestic_div").val()
				,"pgroupSeq":$("#pgroup_seq").val()
				,"selPosition":selPosition
			},
		success: function(e){
			// 로딩한 상세정보 출력
			f_select_callback(e);			
		}
	});	
}

function f_select_callback(result){
	if($("#domestic_div").val() == "L"){
		$("#pgroupname_kr_L").val(result.tripPositionGroupList.pgroupnameKr);
		$("#pgroupname_en_L").val(result.tripPositionGroupList.pgroupnameEn);
		$("#pgroupname_jp_L").val(result.tripPositionGroupList.pgroupnameJp);
		$("#pgroupname_cn_L").val(result.tripPositionGroupList.pgroupnameCn);
		$("#order_num_L").val(result.tripPositionGroupList.orderNum);
		$("#note_L").val(result.tripPositionGroupList.note);
	}else{
		$("#pgroupname_kr_F").val(result.tripPositionGroupList.pgroupnameKr);
		$("#pgroupname_en_F").val(result.tripPositionGroupList.pgroupnameEn);
		$("#pgroupname_jp_F").val(result.tripPositionGroupList.pgroupnameJp);
		$("#pgroupname_cn_F").val(result.tripPositionGroupList.pgroupnameCn);
		$("#order_num_F").val(result.tripPositionGroupList.orderNum);
		$("#note_F").val(result.tripPositionGroupList.note);
	}
	f_setGrid2(result.positionGroupList, 'select');
}

// 검색
function f_search(){
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripPositionGroupList',
		data:{
				"domesticDiv":$("#domestic_div").val()
				,"searchWord":$("#searchWord_" + $("#domestic_div").val()).val()
			},
		success: function(e){
			f_setGrid(e.tripPositionGroupList);
		}
	});
}

function f_checkAll(){
	if($('input:checkbox[name="checkAll_' + $("#domestic_div").val() + '"]').is(":checked")){			
		$('input[name="sel_position_' + $("#domestic_div").val() + '"]').prop("checked", true);
	}else{
		$('input[name="sel_position_' + $("#domestic_div").val() + '"]').prop("checked", false);
	}
}

function f_setGrid(dataList){
	
	// 그리드 초기화(기존 데이터 삭제)	
	$("#divTestArea_" + $("#domestic_div").val() + "").html("");
	$(".gt_paging").remove();
	
	$("#divTestArea_" + $("#domestic_div").val() + "").GridTable({
        'tTablename': 'tableName_' + $("#domestic_div").val()      // 자동 생성될 테이블 네임
        , 'nHeight':'444'
        , 'nTableType': '1'            // 테이블 타입
        , 'oPage': {                   // 사용자 페이징 정보
            'bPageOff': false          // 페이징 기능 사용여부
            , 'nItemSize': 10          // 페이지별 아이템 갯수
        }                
        , 'oDetail': {                 // type 2 상세 페이지 정보
            'bDetailOff': true         // 상세 페이지 사용여부
        }
        , 'oNoData': {                          //  데이터가 존재하지 않는 경우 
            'tText': '<%=DJMessage.getMessage("TX000017974","데이터가 존재하지 않습니다.", langCode)%>'      //  출력 텍스트 설정
             //, 'tStyle': 'background:red;'      //  적용 스타일 설정
		}
        , "data": dataList,
        "aoHeaderInfo": [{
            no: '0',
            renderValue: function () {
                return "no";
            },
            colgroup: '34'
        }, {
            no: '1',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000018431","그룹명", langCode)%>";
            },
            colgroup: ''
        }],

        "aoDataRender": [{
            no: '0',           	
            render: function (idx, item) {
                // can use idx, item 
                return idx+1;
            },
            width: '',
            height: '25',
            align: ''
        }, {
            no: '1',
            render: function (idx, item) {
            	return "<a href=javascript:f_select('"+item.pgroupSeq+"','"+item.selPosition+"')>"+item.pgroupnameKr+"</a>";
            },        
            width: '',
            height: '25',
            align: ''
        }]
        , "fnRowCallBack": function (row, aData) {
        	$(row).click(function (){
                f_select(aData.pgroupSeq, aData.selPosition);
            });     	
        }
    	, "tableOption": "testTable"
    });
}

// 직책선택 그리드
function f_setGrid2(dataList, type){
	
	// 그리드 초기화(기존 데이터 삭제)	
	$("#divPositionArea_" + $("#domestic_div").val() + "").html("");
	
	$("#divPositionArea_" + $("#domestic_div").val() + "").GridTable({
        'tTablename': 'positionTable_' + $("#domestic_div").val()      // 자동 생성될 테이블 네임
        , 'nHeight':'284'
        , 'nTableType': '1'            // 테이블 타입
        , 'oPage': {                   // 사용자 페이징 정보
            'bPageOff': true          // 페이징 기능 사용여부
            , 'nItemSize': 10          // 페이지별 아이템 갯수
        }                
        , 'oDetail': {                 // type 2 상세 페이지 정보
            'bDetailOff': true         // 상세 페이지 사용여부
        }
        , "data": dataList,
        "aoHeaderInfo": [{
            no: '0',
            renderValue: function (idx) {
            	return "<input type='checkbox' onclick='f_checkAll();' name='checkAll_" + $("#domestic_div").val() + "' id='checkAll_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;'></input><label for='checkAll_" + $("#domestic_div").val() + "'></label>";
            },
            colgroup: '34'
        }, {
            no: '1',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000000152","명칭", langCode)%>";
            },
            colgroup: '25%'
        }, {
            no: '2',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000016216","사용회사", langCode)%>";
            },
            colgroup: '25%'
        }, {
            no: '3',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000020765","소속 직책그룹", langCode)%>";
            },
            colgroup: ''            
        }],

        "aoDataRender": [{
            no: '0',           	
            render: function (idx, item) {
            	if(type == "select"){
            		if(item.checkYn == "checked"){
                		return "<input type='checkbox' checked='checked' id='sel_position_" + $("#domestic_div").val() + idx + "' name='sel_position_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;' value='" + item.dpSeq + "'></input><label for='sel_position_" + $("#domestic_div").val() + idx + "'></label>";
                	}else{
                		if($.trim(item.pgroupnameKr) != ""){
                			return "<input type='checkbox' disabled='disabled' id='sel_position_" + $("#domestic_div").val() + idx + "' name='sel_position_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;'></input><label for='sel_position_" + $("#domestic_div").val() + idx + "'></label>";            			
                		}else{
                			return "<input type='checkbox' id='sel_position_" + $("#domestic_div").val() + idx + "' name='sel_position_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;' value='" + item.dpSeq + "'></input><label for='sel_position_" + $("#domestic_div").val() + idx + "'></label>";
                		}            			
                	}          
            	}else{
            		if($.trim(item.pgroupnameKr) != ""){
            			return "<input type='checkbox' disabled='disabled' id='sel_position_" + $("#domestic_div").val() + idx + "' name='sel_position_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;'></input><label for='sel_position_" + $("#domestic_div").val() + idx + "'></label>";            			
            		}else{
            			return "<input type='checkbox' id='sel_position_" + $("#domestic_div").val() + idx + "' name='sel_position_" + $("#domestic_div").val() + "' class='' style='visibility:hidden;' value='" + item.dpSeq + "'></input><label for='sel_position_" + $("#domestic_div").val() + idx + "'></label>";
            		}            			
            	}            	  	
            },
            width: '',
            height: '25',
            align: ''
        }, {
            no: '1',
            render: 'dpName',
            width: '',
            height: '25',
            align: ''
        }, {
            no: '2',
            render: 'compName',     
            width: '',
            height: '25',
            align: ''
        }, {
            no: '3',
            render: 'pgroupnameKr',   
            width: '',
            height: '25',
            align: ''
        }]
        , "fnRowCallBack": function (row, aData) {
            // console.log(row);
            // console.log(aData);        	
        }
    	, "tableOption": "testTable"
    });
}

// 탭 이동
function tab_nor_Fn(num){
	if(num == 1){
		if($("#domestic_div").val() == "F"){
			$("#pgroup_seq").val("");			// 탭 이동시 선택했던 직책그룹 시퀀스 초기화			
		}		
		$("#domestic_div").val("L");		
	}else if(num == 2){
		if($("#domestic_div").val() == "L"){
			$("#pgroup_seq").val("");			// 탭 이동시 선택했던 직책그룹 시퀀스 초기화
		}
		$("#domestic_div").val("F");		
	}
	
	// 탭 이동시 검색조건 초기화
	$("#searchWord_" + $("#domestic_div").val()).val("");
	
	$("#mode").val("I");
	
	//입력폼 초기화
	if($("#domestic_div").val() == "L"){
		$("form").each(function() {  
			if(this.id == "regForm1") this.reset();  
		});			
	}else if($("#domestic_div").val() == "F"){
		$("form").each(function() {  
			if(this.id == "regForm2") this.reset();  
		});
	}
	
	$(".tab"+num).show();
	$(".tab"+num).siblings().hide();
	
	var inx = num -1

	$(".tab_nor li").eq(inx).addClass("on");
	$(".tab_nor li").eq(inx).siblings().removeClass("on");
	
	f_reload();
}
</script>
</head>
<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1000px;">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="location_info">
			 <ul>
			 </ul>
		</div>
		<div class="title_div">
			<h4><%=DJMessage.getMessage("TX000020766","직책그룹관리", langCode)%></h4>
		</div>	
	</div>
	<div class="sub_contents_wrap">
		<div class="posi_re">
			<div class="tab_nor">
				<ul>
					<li class="mW100 ac on"><a href="javascript:tab_nor_Fn(1);"><%=DJMessage.getMessage("TX000015728","국내", langCode)%></a></li>
					<li class="mW100 ac"><a href="javascript:tab_nor_Fn(2)"><%=DJMessage.getMessage("TX000020684","국외", langCode)%></a></li>
				</ul>
			</div>
			
			<div class="posi_ab" style="top:0;right:0;">
				<div id="" class="controll_btn p0">
					<button id="newButton"><%=DJMessage.getMessage("TX000018896","추가", langCode)%></button>
					<button id="saveButton"><%=DJMessage.getMessage("TX000001256","저장", langCode)%></button>
					<button id="deleteButton"><%=DJMessage.getMessage("TX000005668","삭제", langCode)%></button>
				</div>
			</div>
		</div>
			
			<div class="tab_area">
				<!-- 탭 -->
				<div class="tab1">
					<div class="twinbox mt20" >
						<table style="">
							<colgroup>
								<col width="40%"/>
								<col />
							</colgroup>
							<tr>
								<td class="twinbox_td" style="min-width:370px;">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000020767","직책그룹목록", langCode)%></p>
									<div class="top_box">
										<dl>
											<dt><%=DJMessage.getMessage("TX000018431","그룹명", langCode)%></dt>
											<dd><input type="text" name="searchWord_L" id="searchWord_L" style="width:200px;" /></dd>
											<dd><input type="button" id="searchButton_L" value="<%=DJMessage.getMessage("TX000001289","검색", langCode)%>" /></dd>																
										</dl>
									</div>
									<p class="mt14"></p>
									<div id="divTestArea_L">
                           			</div>														
								</td>


								<td class="twinbox_td">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm1" method="post">
										<table>
											<colgroup>
													<col width="100"/>
													<col width="100"/>
													<col width=""/>
												</colgroup>
											<tr>
												<th rowspan="4"><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000018431","그룹명", langCode)%></th>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000002787","한국어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_kr_L" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002790","영어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_en_L" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002788","일본어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_jp_L" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002789","중국어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_cn_L" /></td>
											</tr>											
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018112","정렬순서", langCode)%></th>
												<td>
													<input type="text" style="width:60%;" id="order_num_L" onkeydown="onlyNumber(this)" />
												</td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td>
													<input type="text" style="width:98%" id="note_L" />
												</td>
											</tr>
										</table>
									</form>
									</div>

									<p class="tit_p mt15"><%=DJMessage.getMessage("TX000015460","직책선택", langCode)%> <span class="text_red">(<%=DJMessage.getMessage("TX000004080","필수", langCode)%>)</span></p>
									<p class="text_blue f11 mt-5 mb10"><span class="f12">※</span> <%=DJMessage.getMessage("TX000007033","시스템설정", langCode)%> > <%=DJMessage.getMessage("TX000020768","직급직책관리에서 직책명 관리가 가능합니다.", langCode)%></p>									
									<div id="divPositionArea_L"></div>
								</td>
							</tr>
						</table>
					</div>
				</div><!-- //탭1 -->
				
				
				<!-- 탭2 -->
				<div class="tab2" style="display:none;">
					<div class="twinbox mt20">
						<table style="">
							<colgroup>
								<col width="40%"/>
								<col />
							</colgroup>
							<tr>
								<td class="twinbox_td">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000020767","직책그룹목록", langCode)%></p>
									<div class="top_box">
										<dl>
											<dt><%=DJMessage.getMessage("TX000018431","그룹명", langCode)%></dt>
											<dd><input type="text" name="searchWord_F" id="searchWord_F" style="width:200px;" /></dd>
											<dd><input type="button" id="searchButton_F" value="<%=DJMessage.getMessage("TX000001289","검색", langCode)%>" /></dd>																
										</dl>
									</div>
									<p class="mt14"></p>
									<div id="divTestArea_F">
                           			</div>										
								</td>


								<td class="twinbox_td">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></p>
									<div class="com_ta">
									<form id="regForm2" method="post">
										<table>
											<colgroup>
													<col width="100"/>
													<col width="100"/>
													<col width=""/>
												</colgroup>
											<tr>
												<th rowspan="4"><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000018431","그룹명", langCode)%></th>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000002787","한국어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_kr_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002790","영어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_en_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002788","일본어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_jp_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002789","중국어", langCode)%></th>
												<td><input type="text" style="width:60%" id="pgroupname_cn_F" /></td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018112","정렬순서", langCode)%></th>
												<td>
													<input type="text" style="width:60%;" id="order_num_F" onkeydown="onlyNumber(this)" />
												</td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td>
													<input type="text" style="width:98%" id="note_F" />
												</td>
											</tr>
										</table>
									</form>
									</div>

									<p class="tit_p mt15"><%=DJMessage.getMessage("TX000015460","직책선택", langCode)%> <span class="text_red">(<%=DJMessage.getMessage("TX000004080","필수", langCode)%>)</span></p>
									<p class="text_blue f11 mt-5 mb10"><span class="f12">※</span> <%=DJMessage.getMessage("TX000007033","시스템설정", langCode)%> > <%=DJMessage.getMessage("TX000020768","직급직책관리에서 직책명 관리가 가능합니다.", langCode)%></p>									
									<div id="divPositionArea_F"></div>
								</td>
							</tr>
						</table>
					</div>
				</div><!-- //탭2 -->
		</div><!--// tab_area -->	

	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->		
<form id="regForm" method="post">
	<input type="hidden" id="pgroupname_kr" name="pgroupname_kr" />
	<input type="hidden" id="pgroupname_en" name="pgroupname_en" />
	<input type="hidden" id="pgroupname_jp" name="pgroupname_jp" />
	<input type="hidden" id="pgroupname_cn" name="pgroupname_cn" />	
	<input type="hidden" id="order_num" name="order_num" />
	<input type="hidden" id="note" name="note" />	
	<input type="hidden" id="sel_position" name="sel_position" />
	<input type="hidden" id="mode" name="mode" value="I" />
	<input type="hidden" id="domestic_div" name="domestic_div" value="L" />
	<input type="hidden" id="pgroup_seq" name="pgroup_seq" />
</form>