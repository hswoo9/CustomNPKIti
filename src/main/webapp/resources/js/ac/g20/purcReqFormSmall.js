/**
 *
 * 소액구매용 js 파일
 *
 */

/**
 * 구매의뢰 데이터 입력
 */
purcReq.setPurcReq = function(purcReqInfo){
	$('#purcReqId').val(purcReqInfo.purcReqId);
	$('#purcReqTitle').val(purcReqInfo.purcReqTitle);
	$("#purcReqDate").data("kendoDatePicker").value(ncCom_Date(purcReqInfo.purcReqDate, '-'));
	$('#term').val(purcReqInfo.term);
	$('#purcPurpose').val(purcReqInfo.purcPurpose);
	$('#txt_TR_NM').val(purcReqInfo.trNm).attr('code', purcReqInfo.trCd);
	
	/*소액구매 파라미터 추가*/
	if(purcReqInfo.payConCodeId){
		if($("#payCon").data("kendoComboBox")){
			$("#payCon").data("kendoComboBox").value(purcReqInfo.payConCodeId);
		}else{
			$("#payCon").val(purcReqInfo.payCon).attr('code', purcReqInfo.payConCodeId);
		}
	}
	if(purcReqInfo.payTypeCodeId){
		if($("#payType").data("kendoComboBox")){
			$("#payType").data("kendoComboBox").value(purcReqInfo.payTypeCodeId);
		}else{
			$("#payType").val(purcReqInfo.payType).attr('code', purcReqInfo.payTypeCodeId);
		}
	}
	$('#payCnt').val(purcReqInfo.payCnt);
	if(purcReqInfo.contAm){
		$('#contAm').val(purcReqInfo.contAm.toString().toMoney());
	}
	if(purcReqInfo.contTypeCodeId){
		if($("#contType").data("kendoComboBox")){
			$("#contType").data("kendoComboBox").value(purcReqInfo.contTypeCodeId);
		}else{
			$("#contType").val(purcReqInfo.contType).attr('code', purcReqInfo.contTypeCodeId);
		}
	}
	$("#contDate").val(ncCom_Date(purcReqInfo.contDate, '-'));
	$('#txt_REG_NB').val(purcReqInfo.regNb);
	$('#txt_CEO_NM').val(purcReqInfo.ceoNm);
	/*소액구매 파라미터 추가*/
};

/**
 * 구매의뢰 데이터 저장
 */
purcReq.purcReqInfoSave = function(){
	var saveObj = {};
	/*구매의뢰서 파라미터 추가*/
	saveObj.regDate = $('#txtGisuDate').val();
    saveObj.purcReqType = $('#purcReqType').val();
    saveObj.purcReqTypeCodeId = $('#purcReqType').attr('CODE');
    saveObj.purcReqNo = $('#purcReqNo').val();
    saveObj.purcReqId = $('#purcReqId').val();
    saveObj.purcReqTitle = $('#purcReqTitle').val();
    saveObj.purcReqDate = $('#purcReqDate').val();
    saveObj.term = $('#term').val();
    saveObj.purcPurpose = $('#purcPurpose').val();
    saveObj.trNm = $('#txt_TR_NM').val();
    saveObj.trCd = $('#txt_TR_NM').attr('CODE');
    saveObj.formId = template_key;
    /*구매의뢰서 파라미터 추가*/
    
    /*소액구매 파라미터 추가*/
	saveObj.payCon = $('#payCon').data('kendoComboBox').text();
	saveObj.payConCodeId = $('#payCon').val();
	saveObj.payType = $('#payType').data('kendoComboBox').text();
	saveObj.payTypeCodeId = $('#payType').val();
	saveObj.payCnt = $('#payCnt').val();
	saveObj.contType = $('#contType').data('kendoComboBox').text();
	saveObj.contTypeCodeId = $('#contType').val();
	saveObj.contAm = $('#contAm').val().toString().toMoney2();
	saveObj.contDate = $('#contDate').val();
	saveObj.regNb = $('#txt_REG_NB').val();
	saveObj.ceoNm = $('#txt_CEO_NM').val();
	/*소액구매 파라미터 추가*/
    
	var resultData = {};
	/*ajax 호출할 파라미터*/
    var opt = {
    		url : _g_contextPath_ + "/Ac/G20/Ex/setPurcReqH.do",
    		stateFn : abdocu.state,
            async: false,
            data : saveObj,
            successFn : function(data){
            	if(data){
                	var purcReqId = data.purcReqId?data.purcReqId : "0";
                	var purcReqHId = data.purcReqHId?data.purcReqHId : "0";
                	$('#purcReqId').val(purcReqId);
            	}else{
					alert(NeosUtil.getMessage("TX000009901","오류가 발생하였습니다. 관리자에게 문의하세요"));
            	}
            }
            ,
            failFn : function (request,status,error) {
    	    	alert(NeosUtil.getMessage("TX000009901","오류가 발생하였습니다. 관리자에게 문의하세요")+".\n errorCode :"+request.responseText+"\n");
        	}
    };

    acUtil.ajax.call(opt, resultData);
};
/*구매의뢰서 끝*/

abdocu.ProjectInfo.RowSave_Process = function(tr){

	var erp_year = acUtil.util.getUniqueTime().substring(0, 4);

	var erp_gisu_dt = $("#txtGisuDate").val().replace(/-/gi,"");
	
	var erp_acisu_dt = null;
	if($("#txtAcisuDate").length > 0){
		erp_acisu_dt = $("#txtAcisuDate").val().replace(/-/gi,"");
	}
	
	$("#txt_GisuDt").val(erp_gisu_dt.replace(/-/gi,""));

	if(erp_gisu_dt.length!=8){
		erp_gisu_dt = acUtil.util.getUniqueTime().substring(0,8);
	}
	var saveObj = {};
	
	/*구매의뢰서 파라미터 추가*/
	saveObj.regDate = $('#txtGisuDate').val();
    saveObj.purcReqType = $('#purcReqType').val();
    saveObj.purcReqTypeCodeId = $('#purcReqType').attr('CODE');
    saveObj.purcReqNo = $('#purcReqNo').val();
    saveObj.purcReqId = $('#purcReqId').val();
    saveObj.purcReqTitle = $('#purcReqTitle').val();
    saveObj.purcReqDate = $('#purcReqDate').val();
    saveObj.term = $('#term').val();
    saveObj.purcPurpose = $('#purcPurpose').val();
    saveObj.trNm = $('#txt_TR_NM').val();
    saveObj.trCd = $('#txt_TR_NM').attr('CODE');
    saveObj.formId = template_key;
    /*구매의뢰서 파라미터 추가*/
	
//	saveObj.abdocu_no       = abdocuInfo.abdocu_no;
	saveObj.abdocu_no       = tr.attr('id') || '0';
	saveObj.docu_mode       = abdocuInfo.docu_mode;
	saveObj.docu_fg         = abdocuInfo.docu_fg;
	saveObj.docu_fg_text    = abdocuInfo.docu_fg_text;
    saveObj.erp_co_cd       = abdocuInfo.erp_co_cd;
    saveObj.erp_co_nm       = abdocuInfo.erp_co_nm;
    saveObj.erp_dept_cd     = $("#txtDEPT_NM").attr("CODE");
    saveObj.erp_dept_nm     = $("#txtDEPT_NM").val();
    saveObj.erp_emp_cd      = $("#txtKOR_NM").attr("CODE");
    saveObj.erp_emp_nm      = $("#txtKOR_NM").val();
    saveObj.erp_div_cd      = $(".txtDIV_NM", tr).attr("CODE");
    saveObj.erp_div_nm      = $(".txtDIV_NM", tr).val();
    saveObj.mgt_cd          = $(".txt_ProjectName", tr).attr("CODE");
	saveObj.mgt_nm_encoding = $(".txt_ProjectName", tr).val();
	saveObj.bottom_nm       = $(".txtBottom_cd", tr).val() || "";
	saveObj.bottom_cd       = $(".txtBottom_cd", tr).attr("CODE") || "";
	saveObj.rmk_dc          = $(".txt_Memo", tr).val();
	
    saveObj.erp_gisu_dt     = erp_gisu_dt;
    if(erp_acisu_dt){
    	saveObj.erp_acisu_dt     = erp_acisu_dt;
    }
    saveObj.erp_gisu_from_dt= "";
    saveObj.erp_gisu_to_dt  = "";
    saveObj.erp_gisu        = "0";
    saveObj.erp_year        = erp_year;
    saveObj.it_businessLink = $(".txt_IT_BUSINESSLINK", tr).val();
    
    /*소액구매 파라미터 추가*/
	saveObj.payCon = $('#payCon').data('kendoComboBox').text();
	saveObj.payConCodeId = $('#payCon').val();
	saveObj.payType = $('#payType').data('kendoComboBox').text();
	saveObj.payTypeCodeId = $('#payType').val();
	saveObj.payCnt = $('#payCnt').val();
	saveObj.contType = $('#contType').data('kendoComboBox').text();
	saveObj.contTypeCodeId = $('#contType').val();
	saveObj.contAm = $('#contAm').val().toString().toMoney2();
	saveObj.contDate = $('#contDate').val();
	saveObj.regNb = $('#txt_REG_NB').val();
	saveObj.ceoNm = $('#txt_CEO_NM').val();
	/*소액구매 파라미터 추가*/
    
	var resultData = {};
	/*ajax 호출할 파라미터*/
    var opt = {
    		url : _g_contextPath_ + "/Ac/G20/Ex/setPurcReqH.do",						// 구매의뢰서 저장
    		stateFn : abdocu.state,
            async: true,
            data : saveObj,
            successFn : function(data){
            	
            	if(data){
                	var abdocu_no = data.result?data.result : "0";
                	var purcReqId = data.purcReqId?data.purcReqId : "0";
                	var purcReqHId = data.purcReqHId?data.purcReqHId : "0";
            		var obj = acUtil.util.getParamObj();
            		obj["abdocu_no"] = abdocu_no;
            		obj["purcReqId"] = purcReqId;
            		obj["purcReqHId"] = purcReqHId;
            		obj["focus"] = "txt_BUDGET_LIST";
            		obj["template_key"] = template_key;
            		fnReLoad(obj);
            	}else{
					alert(NeosUtil.getMessage("TX000009901","오류가 발생하였습니다. 관리자에게 문의하세요"));
            	}

            }
            ,
            failFn : function (request,status,error) {
    	    	alert(NeosUtil.getMessage("TX000009901","오류가 발생하였습니다. 관리자에게 문의하세요")+".\n errorCode :"+request.responseText+"\n");
        	}
    };

    acUtil.ajax.call(opt, resultData);
};

abdocu.approvalOpen = function(){
	var contAm = parseInt($("#contAm").val().toString().toMoney2());
	var capAm = parseInt(fnTpfGetCommCodeList("PURC_SMALL_PAYMENT").filter(function(obj){return obj.code == "CAP";})[0].code_val.toString().toMoney2());
	if(capAm <= contAm){
		alert('소액구매는 ' + capAm.toString().toMoney() + "원을 초과 할 수 없습니다.");
		return false;
	}
	if(!$('#purcReqTitle').val()){
		alert('계약명을 입력하세요.');
		return false;
	}
	if(!$('#purcReqDate').val() && (!$('#term').val() || $('#term').val() == '0')){
//	if(!$('#purcReqDate').val()){
		alert('사업기간을 입력하세요.');
		return false;
	}
	if(!$('#txt_TR_NM').val()){
		alert('거래처를 선택하세요.');
		return false;
	}
	/*if(!$('#txt_REG_NB').val()){
		alert('거래처를 선택하세요.');
		return false;
	}
	if(!$('#txt_CEO_NM').val()){
		alert('거래처를 선택하세요.');
		return false;
	}*/
	if(!$('#txt_TR_NM').attr("code")){
		alert('거래처를 선택하세요.');
		return false;
	}
	if($('#fileArea1 span').length < 1){
		alert('기본계획서를 등록하세요.')
		return false;
	}
	var obj = abdocu.approvalValidation();
	if(!obj.isSuccess){
		alert(obj.msg);  
		return false; 
	}
	
	var table = $("#erpBudgetInfo-table");
	var tr = $("tr", table);
	var ids = []; /*예산 목록*/
	$.map(tr, function(val, i){
		var id = $(val).attr("id");
		if(id && id != "0"){
			ids[ids.length] = id;
		}
	});

	var overBudget = [];
	var validationResult =  '';
	for ( var i = 0, max = ids.length; i < max; i++) {
		var tempTr = $("#" + ids[i], table);
		var txt_BUDGET_LIST = $(".txt_BUDGET_LIST", tempTr).attr("CODE");
		var reffer_b_no = $("#"+ids[i]).attr("reffer_b_no");
		var data = {
			  abdocu_no : abdocuInfo.abdocu_no
			, abdocu_b_no : ids[i]
			, abdocu_no_reffer : abdocuInfo.abdocu_no_reffer
			, docu_mode :abdocuInfo.docu_mode 
			, abgt_cd : txt_BUDGET_LIST
			, abdocu_b_no_reffer : reffer_b_no
			, erp_co_cd :  abdocuInfo.erp_co_cd
		};

		/*ajax 호출할 파라미터*/
		var opt = {
	            url : _g_contextPath_ + "/Ac/G20/Ex/approvalValidation.do",
	            stateFn:abdocu.state,
	            async:false,
	            data : data,
	            successFn : function(data){
	            	var result = parseInt(data.result, 10);
	            	
	            	/* 상배 예산 통제 세부 옵션 확인 */
	            	if(data.ctlFg < 5){
	            		return;
	            	}
	            	if(isNaN(result)){
	            		result = -1;
	            	}
	            	
	            	/* 참조 품의액 검증 */
	            	if(isNaN(result)){
	            		validationResult = 'NaN';
	            	}else if( (result < 0 ) && ( data.ctlFg == 10  )){
	            		validationResult = 'CONFER';
	            	}else if((result < 0 ) && ( data.ctlFg != 10  ) /*&& 예산옵션트루*/ ){
            			validationResult = 'BGT';
	            	}
	            	
	            	/* 수입품의서 제외 */
	            	if(abdocuInfo.docu_mode =="0" && overBudget.length || abdocuInfo.docu_fg == "8"){
	            		// TODO : 예산 확인 필요. 
	            		// validationResult == 'BGT';
	            		validationResult = '';
	            	}
	            	// 여입결의서, 수입결의서 제외
	            	if(abdocuInfo.docu_mode =="1"){
		            	if(abdocuInfo.docu_fg == "5" || abdocuInfo.docu_fg == "6" || abdocuInfo.docu_fg == "7"){
		            		// TODO : 예산 확인 필요. 
		            		validationResult = '';
		            	}
	            	}
	            }
	    };	
	    /*결과 데이터 담을 객체*/
		acUtil.resultData = {};
		/*한글기안으로 안넘어가게 주석처리*/
	    acUtil.ajax.call(opt, acUtil.resultData );
	}

	if(validationResult == 'NaN'){
		alert('금액 검증도중 오류가 발생하였습니다.');
		return;
	}if(validationResult == 'CONFER'){
		alert('품의액을 초과 하였습니다. 확인해주세요.');
		return;
	}else if(validationResult == 'BGT'){
		alert(NeosUtil.getMessage("TX000011163","예산을 초과 하였습니다. 확인해주세요."));
		return;
	}
	
	$("." + abdocu.overBudget).removeClass(abdocu.overBudget);
	for ( var i = 0, max = overBudget.length; i < max; i++) {
		$("#" + overBudget[i] + " .totalAM", table).parents("td").addClass(abdocu.overBudget);
	}
	
	// 구매의뢰번호 생성
	var data = {purcReqId : $('#purcReqId').val()};
	var opt = {
    		url : _g_contextPath_ + "/Ac/G20/Ex/makePurcReqNo.do",
    		stateFn:abdocu.state,
    		async:false,
    		data : data,
    		successFn : function(result){
    			approvalOpen(result);
    		}
	};
	acUtil.ajax.call(opt, null);
};

/**
 * 문서본문 생성
 */
function makeContentsStr(result){
	var purcContInfo = result.purcReqInfo;
	var contentsStr = "";
	contentsStr += "<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'>";
	contentsStr += "<TABLE border='1' cellspacing='0' cellpadding='0' style='border-collapse:collapse;border:none;font-family:'굴림체';'>";
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='width:76px;height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 1.1pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>관련근거</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD colspan='3' valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 1.1pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%'>&nbsp;</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>계약명</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD colspan='3' valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt;text-align:center;'>";
	contentsStr += "	<P CLASS=HStyle0 style='font-size:11.0pt;font-family:'굴림체';'>&nbsp;"+purcContInfo.purcReqTitle+"</P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>목적</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD colspan='3' valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 style='font-size:11.0pt;font-family:'굴림체';'>&nbsp;"+purcContInfo.purcPurpose+"</P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	
	contentsStr += "<TR>";
	contentsStr += "	<TD rowspan='1' valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>계약금액</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD colspan='3' valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';font-weight:bold;text-align:center;'>"+purcContInfo.contAm.toString().toMoney()+" 원 (부가가치세포함)</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.9pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>사업기간</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='width:390px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.9pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	var contEndDate = purcContInfo.purcReqDate;
	if(!contEndDate){
		contEndDate = purcContInfo.term;
	}
	contentsStr += "	<P CLASS=HStyle0> <SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>계약일로부터 "+contEndDate+"일까지</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='width:91px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>계약예정일</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='width:148px;border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	var contDate = purcContInfo.contDate;
	if(!contDate){
		contDate = "";
	}else{
		contDate = contDate.replace(/-/gi,".") + ".";
	}
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+contDate+"</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:53px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.9pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>계약방법</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.9pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0> <SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+purcContInfo.contType+"</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>거래처</SPAN></P>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>(사업자번호)</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+purcContInfo.trNm+"</SPAN></P>";
	var regNb = purcContInfo.regNb.substring(0,3) + "-" + purcContInfo.regNb.substring(3,5) + "-" + purcContInfo.regNb.substring(5,10);
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+regNb+"</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>지급조건</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0> <SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+purcContInfo.payCon+"</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>지급방법</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';text-align:center;'>"+purcContInfo.payType+"</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	
	contentsStr = makeContentsStrHB(contentsStr, result);
	
	contentsStr += "<TR>";
	contentsStr += "	<TD valign='middle' style='height:30px;border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';text-align:center;'>비고</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "	<TD colspan='3' valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>";
	contentsStr += "	<P CLASS=HStyle0><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';'>&nbsp;</SPAN></P>";
	contentsStr += "	</TD>";
	contentsStr += "</TR>";
	
	contentsStr += "</TABLE></P>";
	contentsStr += "<P CLASS=HStyle0 STYLE='height:30px;text-align:center;line-height:100%;'>&nbsp;</P>";
	contentsStr += "<P CLASS=HStyle0 STYLE='height:30px;text-align:center;line-height:100%;'>&nbsp;</P>";
	
	contentsStr = makeContentsStrT(contentsStr, result)
	
	contentsStr += "";
	contentsStr += "</TABLE>";
	makeContentsStrSave(contentsStr);
	return contentsStr;
}

function makeContentsStrHB(contentsStr, result){
	var purcReqHBList = result.purcReqHBList;
	var rowspan = purcReqHBList.length;
	$.each(purcReqHBList, function(inx){
		var apply_am = this.apply_am.toString().toMoney();
		var abgtNm = "";
		if(this.erp_bgt_nm4){
			abgtNm = this.erp_bgt_nm3+"▶"+this.erp_bgt_nm4;
		}else if(this.erp_bgt_nm3){
			abgtNm = this.erp_bgt_nm2+"▶"+this.erp_bgt_nm3;
		}else{
			abgtNm = this.erp_bgt_nm1+"▶"+this.erp_bgt_nm2;
		}
		contentsStr += "<TR>";
		if(inx == 0){
			contentsStr += "	<TD rowspan='"+rowspan+"' valign='middle' style='border-left:solid #000000 1.1pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt;'>";
			contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>예산과목</SPAN></P>";
			contentsStr += "	</TD>";
		}
		contentsStr += "	<TD valign='middle' style='height:77px;border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt;'>";
		contentsStr += "	<P CLASS=HStyle0 STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';'>"+this.mgt_nm+"</P>";
		contentsStr += "	<P CLASS=HStyle0 STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';'>▶"+this.bottom_nm+"</P>";
		contentsStr += "	<P CLASS=HStyle0> <SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';'>▶"+abgtNm+"</SPAN></P>";
		contentsStr += "	</TD>";
		contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt;'>";
		contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;font-weight:bold;line-height:160%;font-family:'굴림체';'>집행금액</SPAN></P>";
		contentsStr += "	</TD>";
		contentsStr += "	<TD valign='middle' style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.7pt 1.4pt 5.7pt'>";
		contentsStr += "	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:11.0pt;line-height:160%;font-family:'굴림체';'>"+apply_am+"원</SPAN></P>";
		contentsStr += "	</TD>";
		contentsStr += "</TR>";
	});
	return contentsStr;
}

/**
 * 공통코드리스트 조회
 */
function fnTpfGetCommCodeList(groupCode){
	var result = {};
	var params = {};
	params.group_code = groupCode;
    var opt = {
    		url     : _g_contextPath_ + "/commcode/getCommCodeList",
            async   : false,
            data    : params,
            successFn : function(data){
            	result = data;
            	commCode[groupCode] = data;
            }
    };
    acUtil.ajax.call(opt);
	return result;
}

function fnTradeInfoSave(){
	purcReq.purcReqInfoSave();
}