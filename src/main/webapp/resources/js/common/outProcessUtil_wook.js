/**
 * 전자결재 문서 작성(SSO 호출) API
 * tag		:	<form id="outProcessFormData" action="/gw/outProcessLogOn.do" target="outProcessLogOn"></form>
 * 
 * function	:	outProcessLogOn(params);
 * 
 * 		 ---- mod = W
 * parmas :	compSeq			 	그룹웨어 회사코드			조건 필수
 * 			approKey 	     	외부시스템 연동키			필수
 *          outProcessCode      외부시스템 연동코드			1.둘 중 하나 필수
 *          formId           	그룹웨어 양식코드			1.(양식정보값)
 *          loginId          	그룹웨어 로그인 id			2.셋 중 하나 필수
 *          empSeq 				그룹웨어 사번				2.( compSeq 필수 )
 *          erpSeq              ERP 사번					2.(사용자정보값)
 *          fileKey             파일인터페이스 키			첨부 있을 시
 *          contentsEnc         본문Html 인코더
 *          contentsStr         본문Html
 *          mod                 작성/보기/삭제 구분			필수 W : 작성 / V : 보기 / D : 삭제
 *          
 *          ---- mod = V
 * parmas :	compSeq			 	그룹웨어 회사코드			조건 필수
 * 			outProcessCode      외부시스템 연동코드			1.둘 중 하나 필수
 *          formId           	그룹웨어 양식코드			1.둘 중 하나 필수(양식정보값)
 * 			loginId          	그룹웨어 로그인 id			2.셋 중 하나 필수
 *          empSeq 				그룹웨어 사번				2.셋 중 하나 필수( compSeq 필수 )
 *          erpSeq              ERP 사번					2.셋 중 하나 필수(사용자정보값)
 *          approKey 	     	외부시스템 연동키			3.둘 중 하나 필수
 * 			docId				그룹웨어 전자결재 id			3.둘 중 하나 필수
 * return :		
 */
function outProcessLogOn(params){
	if($("#outProcessFormData").length < 1){
		outProcessLogOnInit();
	}
	var form = $('#outProcessFormData');

	if(location.host.indexOf("127.0.0.1") > -1 || location.host.indexOf("localhost") > -1 || location.host.indexOf("1.233.95.140") > -1){
    	form.prop("action", "https://gw.ltikorea.or.kr/gw/outProcessLogOn.do");
    }else{
    	form.prop("action", "/gw/outProcessLogOn.do");
    }
	
	var urlParams = makeParames(params, form);
	urlParams = urlParams.replace("&", "?");
	var win;
	
	if(params.mod == "W"){
		var data = {}
		data.processId = params.outProcessCode;
		data.approKey = params.approKey;
		data.title = params.title;
		data.content = params.contentsStr;
		$.ajax({
			type : 'POST',
			async: false,
			url : _g_contextPath_  + '/outProcess/outProcessTempInsert',
			data:data,
			dataType : 'json',
			success : function(data) {
				if(data.resultCode == "SUCCESS"){
					var url = $('#outProcessFormData').attr("action") + urlParams;
					win = window.open(url, "outProcessLogOn", "scrollbars=yes, width=1000px, height=900px, resizable=no, status=no, top=50, left=50", "newWindow");
					form.submit();
				}
			}
		});
	}else{
		var url = form.prop("action") + "?compSeq=" + params.compSeq + "&empSeq=" + params.empSeq + "&docId=" + params.docId + "&outProcessCode=" + params.outProcessCode +"&mod=" + params.mod;
		win = window.open(url, "outProcessLogOn", "scrollbars=yes, width=1000px, height=900px, resizable=no, status=no, top=50, left=50", "newWindow");
		form.submit();
	}
	
	return win;
	
}

function outProcessLogOnInit(){
	var html = '<form id="outProcessFormData" action="/gw/outProcessLogOn.do" target="outProcessLogOn">';
	$("body").append(html);
}

function outProcessLogOn2(params){
	var form = $('#outProcessFormData');
	if(location.host.indexOf("127.0.0.1") > -1 || location.host.indexOf("localhost") > -1){
    	form.prop("action", "https://gw.ltikorea.or.kr/gw/outProcessLogOn.do");
    }else{
    	form.prop("action", "/gw/outProcessLogOn.do");
    }
	
	makeParames(params, form);
	
	form.submit();
}

function makeParames(params, form){
	var url = "";
	if(params.compSeq){
		var compSeq = $('<input type="hidden" name="compSeq"/>');
		compSeq.val(params.compSeq);
		form.append(compSeq);
		url += "&compSeq="+params.compSeq;
	}
	if(params.approKey){
		var approKey = $('<input type="hidden" name="approKey"/>');
		approKey.val(params.approKey);
		form.append(approKey);
		url += "&approKey="+params.approKey;
	}
	if(params.outProcessCode){
		var outProcessCode = $('<input type="hidden" name="outProcessCode"/>');
		outProcessCode.val(params.outProcessCode);
		form.append(outProcessCode);
		url += "&outProcessCode="+params.outProcessCode;
	}
	if(params.formId){
		var formId = $('<input type="hidden" name="formId"/>');
		formId.val(params.formId);
		form.append(formId);
		url += "&formId="+params.formId;
	}
	if(params.loginId){
		var loginId = $('<input type="hidden" name="loginId"/>');
		loginId.val(params.loginId);
		form.append(loginId);
		url += "&loginId="+params.loginId;
	}
	if(params.empSeq){
		var empSeq = $('<input type="hidden" name="empSeq"/>');
		empSeq.val(params.empSeq);
		form.append(empSeq);
		url += "&empSeq="+params.empSeq;
	}
	if(params.erpSeq){
		var erpSeq = $('<input type="hidden" name="erpSeq"/>');
		erpSeq.val(params.erpSeq);
		form.append(erpSeq);
		url += "&erpSeq="+params.erpSeq;
	}
	if(params.fileKey){
		var fileKey = $('<input type="hidden" name="fileKey"/>');
		fileKey.val(params.fileKey);
		form.append(fileKey);
		url += "&fileKey="+params.fileKey;
	}
	// api방식 변경으로 주석
//	if(params.contentsEnc){
//		var contentsEnc = $('<input type="hidden" name="contentsEnc"/>');
//		contentsEnc.val(params.contentsEnc);
//		form.append(contentsEnc);
//	}
//	if(params.contentsStr){
//		var contentsStr = $('<input type="hidden" name="contentsStr"/>');
//		contentsStr.val(params.contentsStr);
//		form.append(contentsStr);
//	}
	if(params.mod){
		var mod = $('<input type="hidden" name="mod"/>');
		mod.val(params.mod);
		form.append(mod);
		url += "&mod="+params.mod;
	}
	if(params.docId){
		var docId = $('<input type="hidden" name="docId"/>');
		docId.val(params.docId);
		form.append(docId);
		url += "&docId="+params.docId;
	}
	return url;
}

/**
 * 파일키 생성 수정중
 * 
 * function	:	makeFileKey(params);
 * 
 * parmas :		targetId					 	그룹웨어 회사코드			조건 필수
 * 				targetTableName 	      		외부시스템 연동키			필수
 *          
 * return :		fileKey							
 */

function makeFileKey(params){
	var fileKey = "";
	var data = {};
	data.targetId = params.targetId;
	data.targetTableName = params.targetTableName;
	$.ajax({
		type : 'POST',
		async: false,
		url : _g_contextPath_  + '/outProcess/makeFileKey',
		data:data,
		dataType : 'json',
		success : function(data) {
			if(data){
        		fileKey = data.fileKey;
        	}else{
				alert(NeosUtil.getMessage("TX000009901","오류가 발생하였습니다. 관리자에게 문의하세요"));
        	}
		}
	});
	return fileKey;
}

/**
 * 
 * function	:	outProcessDocSts(params);
 * 
 * parmas :			approKey	외부시스템 연동키			필수
 *          		processId	외부시스템 연동코드			1.둘 중 하나 필수
 * 
 * return :			docId		전자결재 문서키
 * 					docSts		전자결재 문서상태
 */
function outProcessDocSts(params){
	var result;
	var data = {}
	data.processId = params.processId;
	data.approKey = params.approKey
	$.ajax({
		type : 'POST',
		async: false,
		url : _g_contextPath_  + '/outProcess/outProcessDocSts',
		data:data,
		dataType : 'json',
		success : function(data) {
			if(data.result){
				result = data.result;
			}
		}
	});
	return result;
}

/**
 * 
 * function	:	outProcessAppTest(data);
 * 
 * parmas :			approKey	외부시스템 연동키			필수
 *          		processId	외부시스템 연동코드			1.둘 중 하나 필수
 * 					docId		문서키
 * 					docSts		문서상태
 * 					userId		사용자ID
 */
function outProcessAppTest(obj){
	var data = {};
	if(obj){
		data = obj;
	}else{
		data.approKey = "WorkPlan_18";
		data.processId = "WorkPlan";
		data.docId = "1000";
		data.docSts = "10";
		data.userId = "admin";
	}
    $.ajax({
//		url: _g_contextPath_+"/outProcess/outProcessApp",
		url: _g_contextPath_+"/workPlan/outProcessApp",
		type : 'POST',
		data: JSON.stringify(data),
		dataType: 'json',
		contentType:'application/json; charset=utf-8',
		async   : false,
		success: function(result){
			console.log(result);
		}
	});
}