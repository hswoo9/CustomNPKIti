// 숫자체크
function checkNumber(Num) {
	var temp = "";
	for (var i = 0; i < Num.value.length; i++) {
		achar = Num.value.substring(i, i + 1);
		if ((achar < "0") || (achar > "9")) {
			alert("숫자만 입력해 주세요.");
			Num.value = temp;
			if(Num.value.length == 0){Num.value = "";}
		} else {
			temp += achar;
		}

	}		
}

// 문자열 치환
function replaceAll(str, searchStr, replaceStr) {
    return str.split(searchStr).join(replaceStr);
}

// 문자열에 포함된 모든 공백 제거
function compactTrim(str) {
	return str.replace(/(\s*)/g, "");
}

// 천단위 콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 콤마제거
function removeComma(n) {  
    if ( typeof n == "undefined" || n == null || n == "" ) {
        return "";
    }
    var txtNumber = '' + n;
    return txtNumber.replace(/(,)/g, "");
}

// 타임스탬프 yyymmdd 형태로 변환 
function timestampToYYYYMMDD(timestamp, gubun){
	var stampDate = new Date(timestamp);
	var year = stampDate.getFullYear();
	var month = ('0' + (stampDate.getMonth() + 1)).slice(-2);
	var day = ('0' + stampDate.getDate()).slice(-2);
	
	return year+gubun+month+gubun+day; 
}

// 날짜(일수) 더하기 빼기 
function date_add(sDate, nDays){
	// 년도
	var yy = parseInt(sDate.substr(0, 4), 10);
	// 월
	var mm = parseInt(sDate.substr(5, 2), 10);
	// 일 
	var dd = parseInt(sDate.substr(8), 10);
	// 계산되어진 날짜
	var d = new Date(yy, mm -1, dd + nDays);
	
	yy = d.getFullYear();
	mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
	dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
	
	return '' + yy + '-' + mm + '-' + dd;
}

// Null 체크
function gfn_isNull(str) {
    if (str == null) return true;
    if (str == "NaN") return true;
    if (new String(str).valueOf() == "undefined") return true;    
    var chkStr = new String(str);
    if( chkStr.valueOf() == "undefined" ) return true;
    if (chkStr == null) return true;    
    if (chkStr.toString().length == 0 ) return true;   
    return false; 
}
 
function ComSubmit(opt_formId) {
    this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId;
    this.url = "";
     
    if(this.formId == "commonForm"){
        $("#commonForm")[0].reset();
        $("#commonForm").children().remove();
    }
     
    this.setUrl = function setUrl(url){
        this.url = url;
    };
     
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
    };
     
    this.submit = function submit(){
        var frm = $("#"+this.formId)[0];
        frm.action = this.url;
        frm.method = "post";
        frm.submit();   
    };
}

// 체크박스 설정
function comCheckProp(nameArr, flag){
	for(var idx in nameArr){
		$("input[name="+nameArr[idx]+"]").prop("checked",flag);	
	}
}

// 구분 변수에 따라 입력가능한 문자 설정
function checkRegexpValue(gubun, obj) {
	
	var regx;
		
	switch(gubun){
		case "k" : // 한글
			regx = /[^ㄱ-ㅎ|가-힣]/g;
			break;
		case "e" : // 영어
			regx = /[^a-zA-Z]/g;
			break;
		case "n" : // 숫자
			regx = /[^0-9]/g;
			break;
		case "en": // 영어, 숫자
			regx = /[^a-zA-Z-_0-9]/g
			break;	
		case "s": // 특수문자
			regx = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g;
			break;
	}
	
	obj.value = obj.value.replace(regx, '');
}

// 입력값 검사
function fn_inputValidation(fields){
	// fields => { f : "필드ID OR 필드NAME 다중검사일경우 '&' 을 사이에 붙임", m : "메시지내용" , t : "타입 : t -> 텍스트 , c -> 라디오 체크, n -> name으로 검사 ")	
	for(idx in fields){
		
		switch(fields[idx].t){
		// 텍스트
		case "t":
			
			if(!$("#"+fields[idx].f).val()){
				alert( fields[idx].m + " 는 (은) 필수 입력항목입니다." );
				$("#"+fields[idx].f).focus();
				return false;
			}
			
			break;
		// 라디오, 체크	
		case "c":
			
			var arr = fields[idx].f.split("&");
			var mArr = fields[idx].m.split("&");
			
			var flag = false;
			var mIdx = 0;
			for(i in arr){
				if($("#"+arr[i]).prop("checked")){
					flag = true;
					mIdx = i;
					break;
				}
			}
			
			if(!flag){
				
				if(mArr.length == 1){
					mIdx = 0;
				}
				
				alert( mArr[mIdx] + " 는 (은) 필수 입력항목입니다." );
				return false;
			}
			
			break;
		
		// 네임으로 검사
		case "n":
			if(!$("input[name="+fields[idx].f+"]").val()){
				alert( fields[idx].m + " 는 (은) 필수 입력항목입니다." );
				return false;
			}
			
			break;
		}
	}
	return true;
}

// 사용브라우저 체크
function isBrowserCheck(){ 
	const agt = navigator.userAgent.toLowerCase(); 
	if (agt.indexOf("chrome") != -1) return 'Chrome'; 
	if (agt.indexOf("opera") != -1) return 'Opera'; 
	if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
	if (agt.indexOf("webtv") != -1) return 'WebTV'; 
	if (agt.indexOf("beonex") != -1) return 'Beonex'; 
	if (agt.indexOf("chimera") != -1) return 'Chimera'; 
	if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
	if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
	if (agt.indexOf("firefox") != -1) return 'Firefox'; 
	if (agt.indexOf("safari") != -1) return 'Safari'; 
	if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
	if (agt.indexOf("netscape") != -1) return 'Netscape'; 
	if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla'; 
	if (agt.indexOf("msie") != -1) { 
    	let rv = -1; 
		if (navigator.appName == 'Microsoft Internet Explorer') { 
			let ua = navigator.userAgent; var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})"); 
		if (re.exec(ua) != null) 
			rv = parseFloat(RegExp.$1); 
		} 
		return 'Internet Explorer '+rv; 
	} 
}

// 객체 크기 체크
function fn_chkObjLength(obj){
	if( obj === null || obj === undefined){
		return 0; 
	}
	return Object.keys(obj).length;
}