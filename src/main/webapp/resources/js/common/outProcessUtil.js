/**
 * 전자결재 문서 작성(SSO 호출) API
 * tag		:	<form id="outProcessFormData" action="/gw/outProcessLogOn.do" target="outProcessLogOn"></form>
 * 
 * function	:	outProcessLogOn(params);
 * 
 * 		 ---- mod = W
 * parmas :	compSeq					 	그룹웨어 회사코드			조건 필수
 * 				approKey 	             		외부시스템 연동키			필수
 *          		outProcessCode           외부시스템 연동코드			1.둘 중 하나 필수
 *          		formId                   		그룹웨어 양식코드			1.(양식정보값)
 *          		loginId                  			그룹웨어 로그인 id			2.셋 중 하나 필수
 *          		empSeq 					    그룹웨어 사번				2.( compSeq 필수 )
 *          		erpSeq                   		ERP 사번						2.(사용자정보값)
 *          		fileKey                  			파일인터페이스 키			첨부 있을 시
 *          		contentsEnc              	본문Html 인코더
 *          		contentsStr              		본문Html
 *          		mod                      		작성/보기/삭제 구분		필수 W : 작성 / V : 보기 / D : 삭제
 *          
 *          ---- mod = V
 * parmas :	loginId                  			그룹웨어 로그인 id			필수
 * 				approKey             			외부시스템 연동키			필수
 * 				outProcessCode			외부시스테 연동코드		필수
 * 
 * return :		
 */
function outProcessLogOn(params){
	var form = $('#outProcessFormData');
	var url = "http://gwa.tpf.kro.kr/gw/outProcessLogOn.do";
	if(location.host.indexOf("127.0.0.1") > -1 || location.host.indexOf("localhost") > -1){
    	form.prop("action", "http://gwa.tpf.kro.kr/gw/outProcessLogOn.do");
//    	form.prop("action", "http://127.0.0.1:8090/gw/outProcessLogOn.do");
    }else{
    	form.prop("action", "/gw/outProcessLogOn.do");
    	url  = "/gw/outProcessLogOn.do";
    }
	
	url = makeParames(params, form, url);
	url = url.replace("&", "?");
	window.open(url, "viewer", "width=965, height=650, resizable=no, scrollbars = yes, status=no, top=50, left=50", "newWindow");
}

function outProcessLogOn2(params){
	var form = $('#outProcessFormData');
	if(location.host.indexOf("127.0.0.1") > -1 || location.host.indexOf("localhost") > -1){
		form.prop("action", "http://gwa.tpf.kro.kr/gw/outProcessLogOn.do");
//    	form.prop("action", "http://127.0.0.1:8090/gw/outProcessLogOn.do");
    }else{
    	form.prop("action", "/gw/outProcessLogOn.do");
    }
	
	makeParames(params, form);
	
	form.submit();
}

function makeParames(params, form, url){
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
	if(params.contentsEnc){
		var contentsEnc = $('<input type="hidden" name="contentsEnc"/>');
		contentsEnc.val(params.contentsEnc);
		form.append(contentsEnc);
		url += "&contentsEnc="+params.contentsEnc;
	}
	if(params.contentsStr){
		var contentsStr = $('<input type="hidden" name="contentsStr"/>');
		contentsStr.val(params.contentsStr);
		form.append(contentsStr);
		url += "&contentsStr="+params.contentsStr;
	}
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