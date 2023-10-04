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

<%String langCode = (session.getAttribute("langCode") == null ? "kr" : (String)session.getAttribute("langCode")).toLowerCase();%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script>
   	var langCode = "kr";
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
	});
	
	// 저장버튼 클릭
	$("#saveButton").click(function() {		
		f_save();
	});
	
	// 저장버튼 클릭
	$("#deleteButton").click(function() {		
		f_delete();
	});
	
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
	
	//f_reload();
});

function onlyNumber(obj) {
    $(obj).keyup(function(){
         $(this).val($(this).val().replace(/[^0-9]/g,""));
    }); 
}

// 출장지 저장
function f_save(){
	
	var saveUrl = "";
	
	if($("#domestic_div").val() == "L"){
		$("#areaname_kr").val($("#areaname_kr_L").val());
		$("#areaname_en").val($("#areaname_en_L").val());
		$("#areaname_jp").val($("#areaname_jp_L").val());
		$("#areaname_cn").val($("#areaname_cn_L").val());
		$("#direct_input_yn").val($(":input:radio[name=direct_input_yn_L]:checked").val());
		$("#use_yn").val($(":input:radio[name=use_yn_L]:checked").val());
		$("#local_yn").val($(":input:radio[name=local_yn]:checked").val());
		$("#order_num").val($("#order_num_L").val());
		$("#note").val($("#note_L").val());		
	}else if($("#domestic_div").val() == "F"){
		$("#areaname_kr").val($("#areaname_kr_F").val());
		$("#areaname_en").val($("#areaname_en_F").val());
		$("#areaname_jp").val($("#areaname_jp_F").val());
		$("#areaname_cn").val($("#areaname_cn_F").val());
		$("#direct_input_yn").val($(":input:radio[name=direct_input_yn_F]:checked").val());
		$("#use_yn").val($(":input:radio[name=use_yn_F]:checked").val());
		$("#order_num").val($("#order_num_F").val());
		$("#note").val($("#note_F").val());
	}
	
	if($.trim($("#areaname_kr").val()) == ""){
		alert("<%=DJMessage.getMessage("TX000020670","출장지명을 입력해주세요.", langCode)%>");
		$("#areaname_kr_" + $("#domestic_div").val()).focus();
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000004920","입력한 내용으로 저장하시겠습니까?", langCode)%>")){
		if($("#mode").val() == "I"){
			saveUrl = '${pageContext.request.contextPath}/trip/insertTripArea';
		}else if($("#mode").val() == "U"){
			saveUrl = '${pageContext.request.contextPath}/trip/updateTripArea';
		}
		
		$.ajax({
			type: 'POST',
			url:saveUrl,
			data:{
					"domesticDiv":$("#domestic_div").val()
					,"areanameKr":$("#areaname_kr").val()
					,"areanameEn":$("#areaname_en").val()
					,"areanameJp":$("#areaname_jp").val()
					,"areanameCn":$("#areaname_cn").val()
					,"directInputYn":$("#direct_input_yn").val()
					,"useYn":$("#use_yn").val()
					,"localYn":$("#local_yn").val()
					,"orderNum":$("#order_num").val()
					,"note":$("#note").val()
					,"areaSeq":$("#area_seq").val()
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

//출장지 삭제
function f_delete(){
	if($("#area_seq").val() == ""){
		alert("<%=DJMessage.getMessage("TX000006888","삭제할 데이터를 선택해주세요.", langCode)%>");
		return;
	}
	
	if(confirm("<%=DJMessage.getMessage("TX000012275","삭제하시겠습니까?", langCode)%>")){
		$.ajax({
			type: 'POST',
			url:'${pageContext.request.contextPath}/trip/deleteTripArea',
			data:{
					"domesticDiv":$("#domestic_div").val()
					,"areaSeq":$("#area_seq").val()
				},
			success: function(e){
				if(e.success){
					alert("<%=DJMessage.getMessage("TX000012947","데이터가 삭제 되었습니다.", langCode)%>");
					// 출장지 목록 reload
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
						alert("<%=DJMessage.getMessage("TX000020671","선택한 직급그룹의 단가목록이 존재하여 삭제가 불가합니다.", langCode)%>");					
					}else{
						alert("<%=DJMessage.getMessage("TX000002106","삭제에 실패하였습니다.", langCode)%>");						
					}					
				}
			}
		});
	}	
}

// 그리드 리로드
function f_reload(){
	
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripAreaList',
		data:{
				"domesticDiv":$("#domestic_div").val()
		},
		success: function(e){
			f_setGrid(e.tripAreaList);
		}
	});
}

// 그리드 Row 선택
function f_select(areaSeq){

	$("#area_seq").val(areaSeq);	// 현재 선택한 출장지 시퀀스 저장
	$("#mode").val("U");;			// 업데이트 모드로 변경
	
	// 선택한 출장지 상세정보 로드
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripAreaDetail',
		data:{
				"domesticDiv":$("#domestic_div").val()
				,"areaSeq":$("#area_seq").val()
			},
		success: function(e){
			// 로딩한 상세정보 출력
			f_select_callback(e);			
		}
	});	
}

function f_select_callback(result){
	if($("#domestic_div").val() == "L"){
		$("#areaname_kr_L").val(result.areanameKr);
		$("#areaname_en_L").val(result.areanameEn);
		$("#areaname_jp_L").val(result.areanameJp);
		$("#areaname_cn_L").val(result.areanameCn);
		
		if(result.directInputYn == "Y"){
			$('input:radio[id="direct_input_yn_y_L"]').prop("checked", true);
		}else{
			$('input:radio[id="direct_input_yn_n_L"]').prop("checked", true);
		}
		
		if(result.useYn == "Y"){
			$('input:radio[id="use_yn_y_L"]').prop("checked", true);
		}else{
			$('input:radio[id="use_yn_n_L"]').prop("checked", true);
		}
		
		if(result.localYn == "Y"){
			$('input:radio[id="local_yn_y"]').prop("checked", true);
		}else{
			$('input:radio[id="local_yn_n"]').prop("checked", true);
		}
		
		$("#use_yn_L").val(result.useYn);
		$("#order_num_L").val(result.orderNum);
		$("#local_yn").val(result.localYn);
		$("#note_L").val(result.note);
	}else{
		$("#areaname_kr_F").val(result.areanameKr);
		$("#areaname_en_F").val(result.areanameEn);
		$("#areaname_jp_F").val(result.areanameJp);
		$("#areaname_cn_F").val(result.areanameCn);
		
		if(result.directInputYn == "Y"){
			$('input:radio[id="direct_input_yn_y_F"]').prop("checked", true);
		}else{
			$('input:radio[id="direct_input_yn_n_F"]').prop("checked", true);
		}
		
		if(result.useYn == "Y"){
			$('input:radio[id="use_yn_y_F"]').prop("checked", true);
		}else{
			$('input:radio[id="use_yn_n_F"]').prop("checked", true);
		}
		
		$("#use_yn_F").val(result.useYn);
		$("#order_num_F").val(result.orderNum);
		$("#note_F").val(result.note);
	}
}

function f_search(){
	$.ajax({
		type: 'POST',
		url:'${pageContext.request.contextPath}/trip/selectTripAreaList',
		data:{
				"domesticDiv":$("#domestic_div").val()
				,"searchWord":$("#searchWord_" + $("#domestic_div").val()).val()
				,"searchOpt1":$("#searchOpt1_" + $("#domestic_div").val()).val()
				,"searchOpt2":$("#searchOpt2_" + $("#domestic_div").val()).val()
			},
		success: function(e){
			f_setGrid(e.tripAreaList);
		}
	});
}

function f_setGrid(dataList){
	
	// 그리드 초기화(기존 데이터 삭제)	
	$("#divTestArea_" + $("#domestic_div").val() + "").html("");
	$(".gt_paging").remove();
	
	$("#divTestArea_" + $("#domestic_div").val() + "").GridTable({
        'tTablename': 'tableName_' + $("#domestic_div").val()      // 자동 생성될 테이블 네임
        , 'nHeight':'408'
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
                return "<%=DJMessage.getMessage("","출장지명", langCode)%>";
            },
            colgroup: ''
        }, {
            no: '2',
            renderValue: function () {
                return '<%=DJMessage.getMessage("TX000020672","출장지 직접입력", langCode)%>';
            },
            colgroup: '170'
        }, {
            no: '3',
            renderValue: function () {
                return "<%=DJMessage.getMessage("TX000016716","사용여부", langCode)%>";
            },
            colgroup: '120'
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
            	return "<a href=javascript:f_select('"+item.areaSeq+"')>"+item.areanameKr+"</a>";
            },        
            width: '',
            height: '25',
            align: ''
        }, {
            no: '2',
            render: 'directInputYn',
            width: '',
            height: '25',
            align: ''
        }, {
            no: '3',
            render: 'useYn',
            width: '',
            height: '25',
            align: ''
        }]
        , "fnRowCallBack": function (row, aData) {
        	$(row).click(function (){
                f_select(aData.areaSeq);
            });        	
        }
    	, "tableOption": "testTable"
    });
}

//탭
function tab_nor_Fn(num){
	if(num == 1){
		if($("#domestic_div").val() == "F"){
			$("#area_seq").val("");			// 탭 이동시 선택했던 출장지 시퀀스 초기화			
		}		
		$("#domestic_div").val("L");		
	}else if(num == 2){
		if($("#domestic_div").val() == "L"){
			$("#area_seq").val("");			// 탭 이동시 선택했던 출장지 시퀀스 초기화
		}
		$("#domestic_div").val("F");		
	}
	
	// 탭 이동시 검색조건 초기화
	$("#searchWord_" + $("#domestic_div").val()).val("");
	$("#searchOpt1_" + $("#domestic_div").val()).val("").prop("selected", true);
	$("#searchOpt2_" + $("#domestic_div").val()).val("").prop("selected", true);
	$("#searchOpt1_" + $("#domestic_div").val()).selectmenu("refresh");
	$("#searchOpt2_" + $("#domestic_div").val()).selectmenu("refresh");
	
	$("#mode").val("I");
	
	// 입력폼 초기화
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
	<div class="location_info">
		 <ul>
		 </ul>
	</div>
	<div class="title_div">
		<h4><%=DJMessage.getMessage("TX000020673","출장지관리", langCode)%></h4>
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
					<div class="twinbox mt20">
						<table style="">
							<colgroup>
								<col width="50%"/>
								<col />
							</colgroup>
							<tr>
								<td class="twinbox_td" style="min-width:570px;">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000020674","출장지목록", langCode)%></p>
									<div class="top_box" style="    padding: 3px 0 9px 0;">
									
										<dl>
											<dt><%=DJMessage.getMessage("","출장지명", langCode)%></dt>
											<dd><input type="text" style="width:100px;" name="searchWord_L" id="searchWord_L" /></dd>
											<dt class="lh15 ar"><%=DJMessage.getMessage("TX000004662","출장지", langCode)%><br /> <%=DJMessage.getMessage("TX000001021","직접입력", langCode)%></dt>
											<dd>
												<select class="selectmenu" style="width:80px;" id="searchOpt1_L">
													<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
													<option value="Y"><%=DJMessage.getMessage("TX000001551","허용", langCode)%></option>
													<option value="N"><%=DJMessage.getMessage("TX000020675","불가", langCode)%></option>
												</select>
											</dd>
											<dt><%=DJMessage.getMessage("TX000000274","사용유무", langCode)%></dt>
											<dd>
												<select class="selectmenu" style="width:60px;" id="searchOpt2_L">
													<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
													<option value="Y"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></option>
													<option value="N"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></option>
												</select>
											</dd>
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
													<th rowspan="4"><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("","출장지명", langCode)%></th>
													<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000002787","한국어", langCode)%></th>
													<td><input type="text" style="width:98%" name="areaname_kr_L" id="areaname_kr_L" /></td>
												</tr>
												<tr>
													<th><%=DJMessage.getMessage("TX000002790","영어", langCode)%></th>
													<td><input type="text" style="width:98%" name="areaname_en_L" id="areaname_en_L" /></td>
												</tr>
												<tr>
													<th><%=DJMessage.getMessage("TX000002788","일본어", langCode)%></th>
													<td><input type="text" style="width:98%" name="areaname_jp_L" id="areaname_jp_L" /></td>
												</tr>
												<tr>
													<th><%=DJMessage.getMessage("TX000002789","중국어", langCode)%></th>
													<td><input type="text" style="width:98%" name="areaname_cn_L" id="areaname_cn_L" /></td>
												</tr>
												<tr>
													<th colspan="2"><%=DJMessage.getMessage("TX000020672","출장지 직접입력", langCode)%></th>
													<td>
														<input type="radio" name="direct_input_yn_L" id="direct_input_yn_y_L" value="Y" checked />
														<label for="direct_input_yn_y_L"><%=DJMessage.getMessage("TX000001551","허용", langCode)%></label>
														<input type="radio" name="direct_input_yn_L" id="direct_input_yn_n_L" value="N" class="ml10"/>
														<label for="direct_input_yn_n_L"><%=DJMessage.getMessage("TX000020675","불가", langCode)%></label>
													</td>
												</tr>
												<tr>
													<th colspan="2">관내여부</th>
													<td>
														<input type="radio" name="local_yn" id="local_yn_y" value="Y" checked />
														<label for="local_yn_y">예</label>
														<input type="radio" name="local_yn" id="local_yn_n" value="N" class="ml10"/>
														<label for="local_yn_n">아니오</label>
													</td>
												</tr>
												<tr>
													<th colspan="2"><%=DJMessage.getMessage("TX000000274","사용유무", langCode)%></th>
													<td>
														<input type="radio" name="use_yn_L" id="use_yn_y_L" value="Y" checked />
														<label for="use_yn_y_L"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></label>
														<input type="radio" name="use_yn_L" id="use_yn_n_L" value="N" class="ml10"/>
														<label for="use_yn_n_L"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></label>
													</td>
												</tr>
												<tr>
													<th colspan="2"><%=DJMessage.getMessage("TX000018112","정렬순서", langCode)%></th>
													<td>
														<input type="text" style="width:60%" name="order_num_L" id="order_num_L" onkeydown="onlyNumber(this)" />
													</td>
												</tr>
												<tr>
													<th colspan="2"><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
													<td>
														<input type="text" style="width:98%" name="note_L" id="note_L" />
													</td>
												</tr>
											</table>
										</form>
									</div>
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
								<col width="50%"/>
								<col />
							</colgroup>
							<tr>
								<td class="twinbox_td" style="min-width:570px;">
									<p class="tit_p fl"><%=DJMessage.getMessage("TX000020674","출장지목록", langCode)%></p>
									<div class="top_box" style="    padding: 3px 0 9px 0;">
									
										<dl>
											<dt><%=DJMessage.getMessage("","출장지명", langCode)%></dt>
											<dd><input type="text" style="width:100px;" name="searchWord_F" id="searchWord_F" /></dd>
											<dt class="lh15 ar"><%=DJMessage.getMessage("TX000004662","출장지", langCode)%><br /> <%=DJMessage.getMessage("TX000001021","직접입력", langCode)%></dt>
											<dd>
												<select class="selectmenu" style="width:80px;" id="searchOpt1_F">
													<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
													<option value="Y"><%=DJMessage.getMessage("TX000001551","허용", langCode)%></option>
													<option value="N"><%=DJMessage.getMessage("TX000020675","불가", langCode)%></option>
												</select>
											</dd>
											<dt><%=DJMessage.getMessage("TX000000274","사용유무", langCode)%></dt>
											<dd>
												<select class="selectmenu" style="width:60px;" id="searchOpt2_F">
													<option value="" selected="selected"><%=DJMessage.getMessage("TX000000862","전체", langCode)%></option>
													<option value="Y"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></option>
													<option value="N"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></option>
												</select>
											</dd>
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
												<th rowspan="4"><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("","출장지명", langCode)%></th>
												<th><img src="${pageContext.request.contextPath}/Images/ico/ico_check01.png" alt=""> <%=DJMessage.getMessage("TX000002787","한국어", langCode)%></th>
												<td><input type="text" style="width:98%" name="areaname_kr_F" id="areaname_kr_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002790","영어", langCode)%></th>
												<td><input type="text" style="width:98%" name="areaname_en_F" id="areaname_en_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002788","일본어", langCode)%></th>
												<td><input type="text" style="width:98%" name="areaname_jp_F" id="areaname_jp_F" /></td>
											</tr>
											<tr>
												<th><%=DJMessage.getMessage("TX000002789","중국어", langCode)%></th>
												<td><input type="text" style="width:98%" name="areaname_cn_F" id="areaname_cn_F" /></td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000020672","출장지 직접입력", langCode)%></th>
												<td>
													<input type="radio" name="direct_input_yn_F" id="direct_input_yn_y_F" value="Y" checked />
													<label for="direct_input_yn_y_F"><%=DJMessage.getMessage("TX000001551","허용", langCode)%></label>
													<input type="radio" name="direct_input_yn_F" id="direct_input_yn_n_F" value="N" class="ml10"/>
													<label for="direct_input_yn_n_F"><%=DJMessage.getMessage("TX000020675","불가", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000000274","사용유무", langCode)%></th>
												<td>
													<input type="radio" name="use_yn_F" id="use_yn_y_F" value="Y" checked />
													<label for="use_yn_y_F"><%=DJMessage.getMessage("TX000018619","사용", langCode)%></label>
													<input type="radio" name="use_yn_F" id="use_yn_n_F" value="N" class="ml10"/>
													<label for="use_yn_n_F"><%=DJMessage.getMessage("TX000001243","미사용", langCode)%></label>
												</td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018112","정렬순서", langCode)%></th>
												<td>
													<input type="text" style="width:60%" name="order_num_F" id="order_num_F" onkeydown="onlyNumber(this)" />
												</td>
											</tr>
											<tr>
												<th colspan="2"><%=DJMessage.getMessage("TX000018384","비고", langCode)%></th>
												<td>
													<input type="text" style="width:98%" name="note_F" id="note_F" />
												</td>
											</tr>
										</table>
									</form>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div><!-- //탭2 -->
		</div><!--// tab_area -->	

	</div><!--// sub_contents_wrap -->
</div><!--// iframe wrap -->
<form id="regForm" method="post">
	<input type="hidden" id="areaname_kr" name="areaname_kr" />
	<input type="hidden" id="areaname_en" name="areaname_en" />
	<input type="hidden" id="areaname_jp" name="areaname_jp" />
	<input type="hidden" id="areaname_cn" name="areaname_cn" />
	<input type="hidden" id="direct_input_yn" name="directInputYn" />	
	<input type="hidden" id="use_yn" name="use_yn" />	
	<input type="hidden" id="local_yn" name="local_yn" />
	<input type="hidden" id="order_num" name="order_num" />
	<input type="hidden" id="note" name="note" />	
	<input type="hidden" id="mode" name="mode" value="I" />
	<input type="hidden" id="domestic_div" name="domestic_div" value="L" />
	<input type="hidden" id="area_seq" name="area_seq" />
</form>