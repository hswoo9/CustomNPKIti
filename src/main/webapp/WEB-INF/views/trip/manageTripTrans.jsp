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
	
	// 신규버튼 클릭
	$("#newButton").click(function() {
		$("#mode").val("I");
		
		$("form").each(function() {  
			if(this.id == "regForm") this.reset();  
		});
	});
	
	// 저장버튼 클릭
	$("#saveButton").click(function() {		
		f_save();
	});
	
	// 저장버튼 클릭
	$("#deleteButton").click(function() {		
		f_delete();
	});
	
	$("#searchButton").click(function() {		
		f_reload();
	});
	
	$("input[name=searchWord]").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	f_reload();
        }
    });
	
	f_reload();
});

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

// 출장지 저장
function f_save(){
	
	var saveUrl = "";
		
	if($.trim($("#transname_kr").val()) == ""){
		alert("<%=DJMessage.getMessage("TX000020695","교통수단명을 입력해주세요.", langCode)%>");
		$("#transname_kr").focus();
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000004920","입력한 내용으로 저장하시겠습니까?", langCode)%>")){
		if($("#mode").val() == "I"){
			saveUrl = '${pageContext.request.contextPath}/trip/insertTripTrans';
		}else if($("#mode").val() == "U"){
			saveUrl = '${pageContext.request.contextPath}/trip/updateTripTrans';
		}
		
		$.ajax({
			type: 'POST',
			url:saveUrl,
			data:{
					 "transCd":$("#trans_cd").val()
					,"transnameKr":$("#transname_kr").val()
					,"transnameEn":$("#transname_en").val()
					,"transnameJp":$("#transname_jp").val()
					,"transnameCn":$("#transname_cn").val()
					,"useYn":$(":input:radio[name=use_yn]:checked").val()
// 					,"airYn":$(":input:radio[name=air_yn]:checked").val()
					,"orderNum":$("#order_num").val()
					,"note":$("#note").val()
					,"transSeq":$("#trans_seq").val()
				},
			success: function(e){
				if(e){
					alert("<%=DJMessage.getMessage("TX000002544","저장 되었습니다.", langCode)%>");
					f_reload();
					$("#mode").val("I");
					
					$("form").each(function() {  
						if(this.id == "regForm") this.reset();  
					});
				}else{
					alert("<%=DJMessage.getMessage("TX000012787","저장을 실패하였습니다.", langCode)%>");
				}
			}
		});
	}
}

//직급그룹 삭제
function f_delete(){
	//alert($("#pgroup_seq").val());
	
	if($("#trans_seq").val() == ""){
		alert("<%=DJMessage.getMessage("TX000006888","삭제할 데이터를 선택해주세요.", langCode)%>");
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000012275","삭제하시겠습니까?", langCode)%>")){
		$.ajax({
			type: 'POST',
			url:'${pageContext.request.contextPath}/trip/deleteTripTrans',
			data:{
					"transSeq":$("#trans_seq").val()
				},
			success: function(e){
				if(e){
					alert("<%=DJMessage.getMessage("TX000012947","데이터가 삭제 되었습니다.", langCode)%>");
					f_reload();					
					$("#mode").val("I");
					
					$("form").each(function() {  
						if(this.id == "regForm") this.reset();  
					});
				}else{
					alert("<%=DJMessage.getMessage("TX000002106","삭제에 실패하였습니다.", langCode)%>");						
				}				
			}
		});
	}	
}

function f_reload(){
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripTransList',
		data:{
			"searchWord":$("#searchWord").val()
			,"searchOpt":$("#searchOpt").val()
		},
		success: function(e){
			f_setGrid(e.tripTransList);
		}
	});
}

function f_select(trans_seq){
	$("#trans_seq").val(trans_seq);	// 현재 선택한 교통수단 시퀀스 저장
	$("#mode").val("U");;			// 업데이트 모드로 변경
	
	// 선택한 출장단가 상세정보 로드
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripTransDetail',
		data:{
				"transSeq":$("#trans_seq").val()
			},
		success: function(e){
			// 로딩한 상세정보 출력
			f_select_callback(e);			
		}
	});	
}

function f_select_callback(result){
	$("#transname_kr").val(result.transnameKr);
	$("#transname_en").val(result.transnameEn);
	$("#transname_jp").val(result.transnameJp);
	$("#transname_cn").val(result.transnameCn);
	
	if(result.useYn == "Y"){
		$('input:radio[id="use_yn_y"]').prop("checked", true);
	}else{
		$('input:radio[id="use_yn_n"]').prop("checked", true);
	}
	
	if(result.airYn == "Y"){
		$('input:radio[id="air_yn_y"]').prop("checked", true);
	}else{
		$('input:radio[id="air_yn_n"]').prop("checked", true);
	}
	
	$("#order_num").val(result.orderNum);
	$("#trans_cd").val(result.transCd);
	$("#note").val(result.note);
}

function f_setGrid(dataList){
	
	// 그리드 초기화(기존 데이터 삭제)	
	$("#divTestArea").html("");
	$(".gt_paging").remove();
	
	$("#divTestArea").GridTable({
		
        'tTablename': 'tableName'      // 자동 생성될 테이블 네임
        , 'nHeight':'470'
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
                return "교통수단코드";
            },
            colgroup: '34'
        }, {
            no: '2',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000020696","교통수단명", langCode)%>";
            },
            colgroup: '80'
        }, {
            no: '3',
            renderValue: function () {
                return '<%=DJMessage.getMessage("TX000016716","사용여부", langCode)%>';
            },
            colgroup: '34'
        }],

        "aoDataRender": [{
            no: '0',           	
            render: function (idx, item) {
                // can use idx, item 
                return idx+1;
            },
            height: '25'
        }, {
            no: '1',
            render: function (idx, item) {
           		return item.transCd;            		
            },
            height: '25'
        }, {
            no: '2',
            render: function (idx, item) {
           		return "<a href=javascript:f_select('"+item.transSeq+"')>"+item.transnameKr+"</a>";            		
            },
            height: '25'
        }, {
            no: '3',
            render: function (idx, item) {
            	return "<a href=javascript:f_select('"+item.transSeq+"')>"+item.useYn+"</a>";            	
            },
            height: '25'
        }]
        , "fnRowCallBack": function (row, aData) {
        	$(row).click(function (){
                f_select(aData.transSeq);
            });    	
        }
    	, "tableOption": "testTable"
    });
}
</script> 
</head>
<!-- iframe wrap -->
<div class="iframe_wrap">
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="location_info">
			 <ul>
				<li><a href="#n"><img src="${pageContext.request.contextPath}/Images/ico/ico_home01.png" alt=""></a></li>
				<li><a href="#n"><%=DJMessage.getMessage("TX000020583","인사/근태", langCode)%></a></li>
				<li><a href="#n"><%=DJMessage.getMessage("TX000011135","근태관리", langCode)%></a></li>
				<li><a href="#n"><%=DJMessage.getMessage("TX000020665","출장여비관리", langCode)%></a></li>
				<li class="on"><a href="#n"><%=DJMessage.getMessage("TX000020697","교통수단관리", langCode)%></a></li>
			 </ul>
		</div>
		<div class="title_div">
			<h4><%=DJMessage.getMessage("TX000020697","교통수단관리", langCode)%></h4>
		</div>	
	</div>
	
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt class="ar" style="width:71px;"><%=DJMessage.getMessage("TX000020696","교통수단명", langCode)%></dt>
			<dd><input type="text" name="searchWord" id="searchWord" style="width:200px;" /></dd>
			<dt>사용유무</dt>
			<dd>
				<select class="selectmenu" style="width:100px;" id="searchOpt">
					<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
					<option value="Y"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></option>
					<option value="N"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></option>
				</select>
			</dd>
			<dd><input type="button" id="searchButton" value="<%=DJMessage.getMessage("TX000001289","검색", langCode)%>" /></dd>
		</dl>
	</div>
	
	
	<div class="sub_contents_wrap">						
		<div class="btn_div">
			<div class="right_div">
				<div class="controll_btn p0">
					<button id="newButton"><%=DJMessage.getMessage("TX000018896","추가", langCode)%></button>
					<button id="saveButton"><%=DJMessage.getMessage("TX000001256","저장", langCode)%></button>
					<button id="deleteButton"><%=DJMessage.getMessage("TX000005668","삭제", langCode)%></button>
				</div>
			</div>
		</div>
		
		<div class="twinbox">
			<table>
				<colgroup>
					<col style="width:45%;" />
					<col />
				</colgroup>
				<tr>									
					<td class="twinbox_td">

						<!-- 교통수단목록 -->
						<div class="btn_div mt0">
							<div class="left_div">							
								<h5><%=DJMessage.getMessage("TX000004667","교통수단", langCode)%> <%=DJMessage.getMessage("TX000003107","목록", langCode)%></h5>
							</div>													
						</div>
					
						<div id="divTestArea"></div>
					</td>
					
					<td class="twinbox_td">
						<!-- 상세내역 -->
						<div class="btn_div mt0">
							<div class="left_div">							
								<h5><%=DJMessage.getMessage("TX000000512","상세내역", langCode)%></h5>
							</div>													
						</div>
						<div class="com_ta">
						<form id="regForm" method="post">
							<input type="hidden" id="mode" name="mode" />
							<input type="hidden" id="trans_seq" name="trans_seq" />
							<table>
								<colgroup>
									<col width="100"/>
									<col width="100"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th colspan="2">교통수단코드</th>
									<td><input type="text" style="width:98%" name="trans_cd" id="trans_cd" /></td>
								</tr>
								<tr>
									<th rowspan="4"><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000020696","교통수단명", langCode)%></th>
									<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000002787","한국어", langCode)%></th>
									<td><input type="text" style="width:98%" name="transname_kr" id="transname_kr" /></td>
								</tr>
								<tr>
									<th><%=DJMessage.getMessage("TX000002790","영어", langCode)%></th>
									<td><input type="text" style="width:98%" name="transname_en" id="transname_en" /></td>
								</tr>
								<tr>
									<th><%=DJMessage.getMessage("TX000002788","일본어", langCode)%></th>
									<td><input type="text" style="width:98%" name="transname_jp" id="transname_jp" /></td>
								</tr>
								<tr>
									<th><%=DJMessage.getMessage("TX000002789","중국어", langCode)%></th>
									<td><input type="text" style="width:98%" name="transname_cn" id="transname_cn" /></td>
								</tr>
								<tr>
									<th colspan="2"><%=DJMessage.getMessage("TX000000274","사용유무", langCode)%></th>
									<td>
										<input type="radio" name="use_yn" id="use_yn_y" value="Y" checked />
										<label for="use_yn_y"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></label>
										<input type="radio" name="use_yn" id="use_yn_n" value="N" class="ml10"/>
										<label for="use_yn_n"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></label>
									</td>
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<th colspan="2">항공기여부</th> -->
<!-- 									<td> -->
<!-- 										<input type="radio" name="air_yn" id="air_yn_y" value="Y" checked /> -->
<!-- 										<label for="air_yn_y">예</label> -->
<!-- 										<input type="radio" name="air_yn" id="air_yn_n" value="N" class="ml10"/> -->
<!-- 										<label for="air_yn_n">아니오</label> -->
<!-- 									</td> -->
<!-- 								</tr> -->
								<tr>
									<th colspan="2"><%=DJMessage.getMessage("TX000018112","정렬순서", langCode)%></th>
									<td>
										<input type="text" style="width:60%" name="order_num" id="order_num" onkeydown="onlyNumber(this)" />
									</td>
								</tr>
								<tr>
									<th colspan="2"><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
									<td>
										<input type="text" style="width:98%" name="note" id="note" />
									</td>
								</tr>
							</table>
						</form>
						</div>
					</td>
				</tr>
			</table>		
		</div>
	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->