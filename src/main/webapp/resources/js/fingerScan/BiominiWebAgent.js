	////////////////////////////////////////////////// Global Variables //////////////////////////////////////////////

	var protocolVer = "http";		
	var domainName = "localhost";
	var portNo = 8084;
	
	var strBuffer;                      
	var numOfEnrolledUser = 0;
	var flag;
	var pLoopflag;
	var aLoopflag;
	var deviceInfos;
	var selectedDeviceIndex = 0;
	var userIDs = new Array();
	var userTemps = new Array();
	var convertedImageData;
	var selectedUserNo = -1;
		
	var cb_FastMode = 0;
	var cb_EncryptOpt = 0;
	var txt_EncryptKey;
	var cb_ExtractExMode = 0;
	var cb_SelectTemplateOpt;
	var tb_Sensitivity = -1;
	var tb_Brightness = -1; 
	var ddb_Securitylevel = -1;
	var ddb_Timeout = -1;
	var ddb_TemplateType = -1;
	var ddb_Fakelevel = -1;
	var cb_DetectFakeAdvancedMode = 0;
	
	var flagStatus;
	var flagFingerOn;
    var gSensorValid = "false";
    var gIsCapturing = "false";
    var gSensorOn = "false";
    var gIsFingeOn = "false";
    var gPreviewFaileCount = 0;
    var gUserSelected = -1;
    
    var gToastTimeout = 3000;
    var tagToast;

    var urlStr = protocolVer + '://' + domainName + ':' + portNo;
    //var urlStr = "";

    var pageID = 0;
////////////////////////////////////////////////// Functions //////////////////////////////////////////////
    function IsIEbrowser() {
        var browser = navigator.userAgent.toLowerCase();

        if ((browser.indexOf("chrome") != -1 || browser.indexOf("firefox") != -1) && browser.indexOf("edge") == -1)
        {
            return 0;
        }
        else
        {
            if (browser.indexOf("msie") != -1 || (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || browser.indexOf("edge") != -1) {
                return 1;
            }
        }
    }

    
	function Init() {
		debugger
		jQuery.ajax({
			type : "GET",
			url : "http://localhost:8084/api/initDevice?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				//AppendLog("Init", msg.retString);
				if(msg.retValue == 0) {
					deviceInfos = msg.ScannerInfos;
					AddScannerList(deviceInfos);
                    CheckStatusLoop();
                    
                    fingerAlert =setInterval(function() {
            			var blink = document.getElementById("imgDiv");
            			blink.style.visibility = blink.style.visibility == "" ? "hidden" : ""
            		}, 700); // 깜빡이는 속도 조절 (클수록 느리게)
                    //$('#imgDiv').css({'visibility':'visible'});
                    Enroll();
				} else {
					alert('지문인식기를 USB포트에 연결해주세요.');
				}
				
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
				alert('WebAgent 프로그램을 켜주세요.');
			}
		});
		
	}
	
	function Init2() {
		debugger
		jQuery.ajax({
			type : "GET",
			url : "http://localhost:8084/api/initDevice?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				//AppendLog("Init", msg.retString);
				if(msg.retValue == 0) {
					deviceInfos = msg.ScannerInfos;
					AddScannerList(deviceInfos);
                    CheckStatusLoop();
                    
                    fingerAlert =setInterval(function() {
            			var blink = document.getElementById("imgDiv");
            			blink.style.visibility = blink.style.visibility == "" ? "hidden" : ""
            		}, 700); // 깜빡이는 속도 조절 (클수록 느리게)
                    
                    //$('#imgDiv').css({'visibility':'visible'});
                    
                    VerifyWithTemplate();
				} else {
					alert('지문인식기를 USB포트에 연결해주세요.');
				}
				
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
				alert('WebAgent 프로그램을 켜주세요.');
			}
		});
		
	}
	
	function Init3() {
		debugger
		jQuery.ajax({
			type : "GET",
			url : "http://localhost:8084/api/initDevice?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				//AppendLog("Init", msg.retString);
				if(msg.retValue == 0) {
					deviceInfos = msg.ScannerInfos;
					AddScannerList(deviceInfos);
                    CheckStatusLoop();
                    VerifyWithTemplate2();
				} else {
					alert('지문인식기를 USB포트에 연결해주세요.');
				}
				
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
				alert('WebAgent 프로그램을 켜주세요.');
			}
		});
		
	}
	
	function UnInit() {

	    if ($('#Cb_PreviewOn').is(":checked")) {
	        $("#Cb_PreviewOn").attr("checked", 0);
	    }

		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/uninitDevice?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				AppendLog("Uninit", msg.retString);
				if(msg.retValue == 0){
					$("#slt_ScannerList").attr("innerHTML" , "");
				}else{
					$("#slt_ScannerList").attr("innerHTML" , "");
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function OnSelectScannerOptions(){
		selectedDeviceIndex = $("#slt_ScannerList option:selected").attr("value");
		
		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/getScannerStatus?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle
			},
			success : function(msg) {
				AppendLog("getScannerStatus", msg.retString);
				if(msg.retValue == 0){
					AppendLogData("====================");
					AppendLogData("SensorValid: " + msg.SensorValid);
					AppendLogData("SensorOn: " + msg.SensorOn);
					AppendLogData("IsCapturing: " + msg.IsCapturing);
					AppendLogData("IsFingerOn: " + msg.IsFingerOn);
					AppendLogData("====================");
                    QueryData();
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}

	function CheckStatusLoop() {
	    if ($("#slt_ScannerList option:selected").attr("value") == undefined)
	        selectedDeviceIndex = 0;
        else
		    selectedDeviceIndex = $("#slt_ScannerList option:selected").attr("value");
		
		jQuery.ajax({
			type : "GET",
			url: "http://localhost:8084/api/getScannerStatus?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle
			},
			success : function(msg) {
				if(msg.retValue == 0){
                    gSensorValid = msg.SensorValid;
                    gIsCapturing = msg.IsCapturing;
                    gSensorOn = msg.SensorOn;
                    gIsFingeOn = msg.IsFingerOn;
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
        
        flagStatus = setTimeout(CheckStatusLoop, 1000);
	}

	function CheckStatus(){
		selectedDeviceIndex = $("#slt_ScannerList option:selected").attr("value");
		
		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/getScannerStatus?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle
			},
			success : function(msg) {
				if(msg.retValue == 0){
                    gSensorValid = msg.SensorValid;
                    gIsCapturing = msg.IsCapturing;
                    gSensorOn = msg.SensorOn;
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}

	function AppendLog2(func, retString) {
	    var originText = document.getElementById("Tb_DisplayLog").value;
	    document.getElementById("Tb_DisplayLog").value = originText + "[" + func + "] " + retString + "\n";
	    var ta = document.getElementById('Tb_DisplayLog');
	    ta.scrollTop = ta.scrollHeight;
	}
	
	function AppendLogData2(text) {
		debugger
	    var originText = document.getElementById("Tb_DisplayLog").value;
	    document.getElementById("Tb_DisplayLog").value = originText + text + "\n";
	    var ta = document.getElementById('Tb_DisplayLog');
	    ta.scrollTop = ta.scrollHeight;
	}
	
	function AppendLog(func, retString) {
	    var originText = document.getElementById("Tb_DisplayLog").value;
	    document.getElementById("Tb_DisplayLog").value = originText + "[" + func + "] " + retString + "\n";
	    var ta = document.getElementById('Tb_DisplayLog');
	    ta.scrollTop = ta.scrollHeight;
	}
	
	function AppendLogData(text) {
		debugger
	    var originText = document.getElementById("Tb_DisplayLog").value;
	    document.getElementById("Tb_DisplayLog").value = originText + text + "\n";
	    var ta = document.getElementById('Tb_DisplayLog');
	    ta.scrollTop = ta.scrollHeight;
	}
	
	function isExistScannerHandle(){
		if(deviceInfos[selectedDeviceIndex].DeviceHandle == 0){
			return false;
		}else{
			return true;
		}
	}
	
	var sensitivity;
	
	function AddScannerList (ScannerInfos){
		var count = -1;
		$("#slt_ScannerList").attr("innerHTML" , "");
		
		$.each(ScannerInfos, function (key){
				strBuffer = "[" + ScannerInfos[key].DeviceIndex + "]" + ScannerInfos[key].DeviceType + " (" + ScannerInfos[key].ScannerName + ")";
				$("#slt_ScannerList").append("<option value='"+key+"' class='ScannerListOptions' >"+strBuffer+"</option>");	
				count = key;
			});
		count = count +1;
		AppendLogData(count +" devices detected.");
				
		$("#DDb_CompRatio").find('option[value="' + 2.5 + '"]').attr("selected", "true");
		$("#DDb-Tftype > option[value=" + 1 + "]").attr("selected", "true");
		$("#Txt_EncKey").attr("value", "");
		$("#Cb_Encrypt").attr("checked", 0);
		$("#Cb_ExtractEx").attr("checked", 0);
		
		jQuery.ajax({
			type : "GET",
			url : "http://localhost:8084/api/getParameters?dummy=" + Math.random(),
			dataType : "json",
			data : {
				sHandle :  ScannerInfos[0].DeviceHandle 
			},
			success : function(msg) {
				AppendLog("getParameters", msg.retString);
				if(msg.retValue == 0){
					if ( $('#empSensi').val() != '' ) {
						sensitivity = $('#empSensi').val();
					} else {
						sensitivity = msg.sensitivity;
					}
					
					$("#Tb_BrightnessValue").attr("value" , msg.brightness);
					$("#Tb_Sensitivity").attr("value" , sensitivity); 
					$("#Cb_FastMode").attr("checked" , msg.fastmode);
					$("#Cb_SelTemp").attr("checked", msg.selectTemplate);
					$('#DDb_TimeoutOpt > option[value="'+(msg.timeout/1000 )+'"]').attr('selected', true);
					$('#DDb_SecuLevOpt > option[value="'+msg.securitylevel+'"]').attr('selected', true);						
					$('#DDb_Tpltype > option[value="'+msg.TemplateType+'"]').attr('selected', true);
					$('#DDb_FakeLevOpt > option[value="'+msg.fakeLevel+'"]').attr('selected', true);
					$("#cb_DetectFakeAdvancedMode").attr("checked", msg.detectFakeAdvancedMode);
				}			
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}

	function DisplayScannerList() {
	
		document.getElementById("slt_ScannerList").innerHTML = "";
		document.getElementById("Tb_ScannerList").value = "";
		document.getElementById("Tb_DisplayLog").value = "";
		var StateString = document.getElementById("DDb_Scanum").value + ":" + strBuffer;
		document.getElementById("Tb_ScannerList").value = StateString;
		document.getElementById("Tb_DisplayLog").value = StateString;
		
	}
	
	function StartCapture() { 	
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		AppendLogData("[Read Cookie] " + document.cookie);

		var delayVal = 30000;

		jQuery.ajax({
		    type: "GET",
		    url : "http://localhost:8084/api/startCapturing?dummy=" + Math.random(),
		    dataType: "json",
		    data: {
		        sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
		        resetTimer: delayVal
		    },
		    success: function (msg) {
		        AppendLog("startCapturing", msg.retString);
		        if (msg.retValue == 0) {
		            CheckStatus();
		            PreviewLoop();
		        }
		    },
		    error: function (request, status, error) {
		        Toast(JSON.stringify(request), gToastTimeout);
		        Toast(JSON.stringify(status), gToastTimeout);
		        Toast(JSON.stringify(error), gToastTimeout);
		    }
		});
	}

	function AbortCapture() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}

		var delayVal = 30000;
		if (pLoopflag != undefined) {
		    clearTimeout(pLoopflag);
		}

		if (aLoopflag != undefined) {
		    clearTimeout(aLoopflag);
		}
        				
		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/abortCapture?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                resetTimer: delayVal
			}, 
			success : function(msg) {
			    AppendLog("abortCapture", msg.retString);
			},
			error : function(request, status, error) 
			{
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	
	function GetTemplateData() {
		debugger
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}

        if (cb_EncryptOpt) {
            txt_EncryptKey = document.getElementById("Txt_EncKey").value;
        }
        else {
            txt_EncryptKey = "";
        }
        
		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/getTemplateData?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
			    encrypt: cb_EncryptOpt,
			    encryptKey: txt_EncryptKey,
			    extractEx: cb_ExtractExMode,
			    qualityLevel: document.getElementById("DDb_QltyLv").value
			},
			success : function(msg) {
				
				clearInterval(fingerAlert);
            	$('#imgDiv').css({'visibility':'hidden'})
				
				AppendLog("getTemplateData", msg.retString);
				if(msg.retValue == 0) {	
					AppendLogData(msg.templateBase64);
				}
				InfoDelAll();
				if ( msg.templateBase64 == '' || msg.templateBase64 == null ) {
					alert('지문등록 시간을 초과하였습니다.');
				} else {
					
					
					
					if ( $('#typeKey').val() == 'W' ) {
						
						var data = {
								finger_login_id : $('#empID').val(),
								finger_emp_seq : $('#empSeq').val(),
								finger_key : msg.templateBase64
						}
						
						$.ajax({
							url: _g_contextPath_+'/fingerScan/fingerScanEnroll',
							data : data,
							async : false,
							type : 'POST',
							success: function(result){
								alert('지문을 등록하였습니다.');
								$('#deptName').val('');
					        	$('#empName').val('');
								gridReload();
							}
						});
						
					} else {
						
						var data = {
								finger_key : msg.templateBase64,
								finger_table_id : $('#fingerKey').val()
						}
						
						$.ajax({
							url: _g_contextPath_+'/fingerScan/fingerScanMod',
							data : data,
							async : false,
							type : 'POST',
							success: function(result){
								alert('지문을 수정하였습니다.');
								$('#deptName').val('');
					        	$('#empName').val('');
								gridReload();
							}
						});
						
					}
					
					
					
					
				}
				
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function GetTemplateData2() {
		debugger
		if( isExistScannerHandle() == false ){
			Toast2('Scanner Init First', gToastTimeout);
			return ;
		}

        if (cb_EncryptOpt) {
            txt_EncryptKey = document.getElementById("Txt_EncKey").value;
        }
        else {
            txt_EncryptKey = "";
        }

		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/getTemplateData?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
			    encrypt: cb_EncryptOpt,
			    encryptKey: txt_EncryptKey,
			    extractEx: cb_ExtractExMode,
			    qualityLevel: document.getElementById("DDb_QltyLv").value
			},
			success : function(msg) {
				AppendLog2("getTemplateData", msg.retString);
				if(msg.retValue == 0) {	
					AppendLogData2(msg.templateBase64);
				}
				if ( $('#base64').val() == msg.templateBase64 ) {
					alert('success');
				}
				InfoDelAll();
				
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function CaptureSingle() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		        
		$('#Fpimg').attr('src', 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==');
		Toast("Placed your Finger on Camera", gToastTimeout);
				
		var delayVal = 30000;

		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/captureSingle?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
			    resetTimer: delayVal
			},
			success : function(msg) 
			{
			    if ($('#Cb_PreviewOn').is(":checked")) {
			        $("#Cb_PreviewOn").attr("checked", 0);
			    }
				AppendLog("captureSingle", msg.retString);
				if(msg.retValue == 0){
					LoadImage();
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function AutoCapture() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
						
		var msg;

		jQuery.ajax({
			type : "GET",
			url : urlStr + "/api/autoCapture?dummy=" + Math.random(),
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
			    id: pageID
			},
			success : function(msg) 
			{
			    AppendLog("autoCapture", msg.retString);
			    if ($('#Cb_PreviewOn').is(":checked")) {
			        $("#Cb_PreviewOn").attr("checked", 0);
			    }
			    CheckStatus();
			    if (msg.retValue == 0) {
			        AutoCaptureLoop();
			    }
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function PreviewLoop() {

	    var sessionData = "&shandle=" + deviceInfos[selectedDeviceIndex].DeviceHandle + "&id=" + pageID;

	    var IEflag = IsIEbrowser();
    
	    if (IEflag == 1)
	    {
	        if (gIsCapturing == "true" && gSensorOn == "true" && gSensorValid == "true") {
	            $("#Fpimg").removeAttr();
	            var imgUrl = urlStr + "/img/PreviewImg.bmp?dummy=";
	            $("#Fpimg").attr("src", imgUrl + Math.random() + sessionData);

	            pLoopflag = setTimeout(PreviewLoop, 100);
	            gPreviewFaileCount = 0;
	        }
	        else if (gPreviewFaileCount < 60) {
	            pLoopflag = setTimeout(PreviewLoop, 1000);
	            gPreviewFaileCount++;
	        }
	        else {
	            gPreviewFaileCount = 0;
	            $('#Fpimg').attr('src', 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==');
	        }
	    }
	    else
	    {
	        if ($('#Cb_PreviewOn').is(":checked") == false)
	        {
	            if (gIsCapturing == "true" && gSensorOn == "true" && gSensorValid == "true") {
	                $("#Fpimg").removeAttr();
	                var imgUrl = urlStr + "/img/PreviewImg.bmp?dummy=";
	                $("#Fpimg").attr("src", imgUrl + Math.random() + sessionData);

	                pLoopflag = setTimeout(PreviewLoop, 100);
	                gPreviewFaileCount = 0;
	            }
	            else if (gPreviewFaileCount < 60) {
	                pLoopflag = setTimeout(PreviewLoop, 1000);
	                gPreviewFaileCount++;
	            }
	            else {
	                gPreviewFaileCount = 0;
	                $('#Fpimg').attr('src', 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==');
	            }
	        }
	        else
	            return;
	    }
	}

	function AutoCaptureLoop() {

	    var sessionData = "&shandle=" + deviceInfos[selectedDeviceIndex].DeviceHandle + "&id=" + pageID;
	    
	    if (gIsCapturing == "true" && gSensorOn == "true" && gSensorValid == "true") {
	        $("#Fpimg").removeAttr();
	        var imgUrl = urlStr + "/img/PreviewImg.bmp?dummy=";
	        $("#Fpimg").attr("src", imgUrl + Math.random() + sessionData);

	        if (gIsFingeOn == "true") {
	            AppendLogData("(autoCapture) fingerOn detected!");
	            gIsFingeOn = "false";
	        }

	        aLoopflag = setTimeout(AutoCaptureLoop, 100);
	        gPreviewFaileCount = 0;
	    }
	    else if (gPreviewFaileCount < 60) {
	        $('#Fpimg').attr('src', 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==');
	        aLoopflag = setTimeout(AutoCaptureLoop, 1000);
	        gPreviewFaileCount++;
	    }
	    else {
	        gPreviewFaileCount = 0;
	        $('#Fpimg').attr('src', 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==');
	    }
	}

	function InitPage() {
        
	    pageID = Math.random();
	    
	    if ($('#Cb_PreviewOn').is(":checked")) {
	        $("#Cb_PreviewOn").attr("checked", 0);
	    }

	    /*jQuery.ajax({
	        type: "GET",
	        url: "http://localhost:8084/api/createSessionID?dummy=" + Math.random(),
	        dataType: "json",
	        success: function (msg) {
	            var current = new Date();
	            var expires = new Date();
	            expires.setTime(new Date(Date.parse(current) + 1000 * 60 * 60));

	            if(msg) {
					AppendLogData("[Session ID]" + msg.sessionId);
					var cookieStr = "username=" + msg.sessionId + "; expires=" + expires.toUTCString();
					document.cookie = cookieStr;
				}
	        },
	        error: function (request, status, error) {
	        }
	    });*/
	}

    function DeletePage() {
        
        var current = new Date();
        document.cookie = "username=; expires=" + current.toUTCString();

        jQuery.ajax({
            type: "GET",
            async: false,
            url: urlStr + "/api/sessionClear?dummy=" + Math.random(),
            data: {
                id: pageID
            }
        });
	}
	
	function LoadImage() {
	    var sessionData = "&shandle=" + deviceInfos[selectedDeviceIndex].DeviceHandle + "&id=" + pageID;

	    $("#Fpimg").removeAttr();
	    $("#Fpimg").attr("src", urlStr + "/img/CaptureImg.bmp?dummy=" + Math.random() + sessionData);
	}
	
	function SaveImageBuffer() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 

	    var formatType = document.getElementById("DDb_Tftype").value;

		jQuery.ajax({
			type : "GET",
			url: urlStr + "/api/saveImageBuffer?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				fileType: formatType,
				compressionRatio: document.getElementById("DDb_CompRatio").value
			},
			success : function(msg) {
				AppendLog("saveImageBuffer", msg.retString);
				if(msg.retValue == 0)
				{
				    if (formatType == 1)
						LoadConvertedImageBuffer(urlStr + "/img/convertedCaptureImage.bmp");
				    else if (formatType == 2)
						LoadConvertedImageBuffer(urlStr + "/img/convertedCaptureImage.dat");
				    else if (formatType == 3)
						LoadConvertedImageBuffer(urlStr + "/img/convertedCaptureImage.wsq");
				}					
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}  
	
	function GetImageBuffer() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 

		jQuery.ajax({
			type : "GET",
			url: urlStr + "/api/getImageData?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
			    fileType: document.getElementById("DDb_Tftype").value,
			    compressionRatio: document.getElementById("DDb_CompRatio").value
			},
			success : function(msg) {
				AppendLog("GetImageBuffer", msg.retString);
				if(msg.retValue == 0)
				{
                    AppendLogData(msg.imageBase64);
				}
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}  

	function LoadConvertedImageBuffer(imgUrl) {
        var iframe = document.createElement("iframe"); 
        iframe.src = imgUrl; 
        iframe.style.display = "none"; 
        document.body.appendChild(iframe);
	}

	function PreviewOnChecked() {
	    var sessionData = "&shandle=" + deviceInfos[selectedDeviceIndex].DeviceHandle + "&id=" + pageID;

	    var IEflag = IsIEbrowser();

	    if (IEflag == 0)    
	    {
	        // except IE browser
	        $("#Cb_PreviewOn").attr("checked", 1);
	        var imgUrl = urlStr + "/img/PreviewStreaming.bmp?dummy=";
	        document.getElementById('Fpimg').setAttribute("src", imgUrl + Math.random() + sessionData);
	    }
	    else
	    {
	        $("#Cb_PreviewOn").attr("checked", 0);
	        AppendLogData("IE browser isn't supported Multi-Part function");
	    }
	}

	// Select Scanner Parameters Functions....
	function FastModeChecked() {
	    if ($('#Cb_FastMode').is(":checked")) {
			AppendLogData("Fast Mode Checked");
		} else {
			AppendLogData("Fast Mode UnChecked");
		}
		SendParameter();
	}
	function EncryptModeChecked() {
		if($('#Cb_Encrypt').is(":checked")) {
		    AppendLogData("Encrypt Mode Checked");
		    cb_EncryptOpt = 1;
		} else {
		    AppendLogData("Encrypt Mode Unchecked");
		    cb_EncryptOpt = 0;
		}
	}
	function ExtractExModeChecked() {
		if($('#Cb_ExtractEx').is(":checked")) {
		    AppendLogData("ExtractEx Mode Checked");
		    cb_ExtractExMode = 1;
		} else {
		    AppendLogData("ExtractEx Mode Unchecked");
		    cb_ExtractExMode = 0;
		}
	}
	function SelTemplateModeChecked() {
		if($('#Cb_SelTemp').is(":checked")) {
			AppendLogData("Select Template Mode Checked");
		} else {
			AppendLogData("Select Template Mode Unchecked");
		}
		SendParameter();
	}	
	function BrightnessValueup() {
		var TheTextBox = document.getElementById("Tb_BrightnessValue");
		if (TheTextBox.value < 100) {
			TheTextBox.value++;
			SendParameter();
		}
	}
	function BrightnessValuedw() {
		var TheTextBox = document.getElementById("Tb_BrightnessValue");
		if (TheTextBox.value > 0) {
			TheTextBox.value--;
			SendParameter();
		}
	}
	function SensitivityValueup() {
		var TheTextBox = document.getElementById("Tb_Sensitivity");
		if (TheTextBox.value < 100) {
			TheTextBox.value++;
			SendParameter();
		}
	}
	function SensitivityValuedw() {
		var TheTextBox = document.getElementById("Tb_Sensitivity");
		if (TheTextBox.value > 0) {
			TheTextBox.value--;
			SendParameter();
		}
	}
	function EnDetectFakeAdvancedChecked() {
		if($('#Cb_EnDetectFakeAdvanced').is(":checked")) {
		    AppendLogData("DetectFakeAdvanced Checked");
		    cb_DetectFakeAdvancedMode = 1;
		} else {
		    AppendLogData("DetectFakeAdvanced Unchecked");
		    cb_DetectFakeAdvancedMode = 0;
		}
		SendParameter();
	}
	function Tpltype() {
		SendParameter();
	}
	function QltyLv() {
		SendParameter();
	}
	function SecuLevOpt() {
		SendParameter();
	}
	function TimeoutOpt() {
		SendParameter();
	}
	function Tftype() {
		SendParameter();
	}
	function FakeLevOpt() {
		SendParameter();
	}
	
	function Verify(){
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		if(numOfEnrolledUser == 0) {
			AppendLogData("First, add User Data");
			return;
		}
		
		if(selectedUserNo == -1) {
			Toast("Select User-index", gToastTimeout);
			return;
		}

		jQuery.ajax({
            type : "GET",
            url : urlStr + "/db/verify?dummy=" + Math.random(),
            dataType : "json",
            data : {
                sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
                userSerialNo: selectedUserNo,
                extractEx: cb_ExtractExMode,
                qualityLevel: document.getElementById("DDb_QltyLv").value
            },
            success : function(msg) {
                AppendLog("verify", msg.retString);
                if(msg.retValue == 0) {
                    AppendLogData("Result of Verify : " + msg.retVerify);
                }
            },
            error : function(request, status, error) {
                Toast(JSON.stringify(request), gToastTimeout);
                Toast(JSON.stringify(status), gToastTimeout);
                Toast(JSON.stringify(error), gToastTimeout);
            }
        });
	}
	
	function VerifyWithTemplate(){
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		var templateData = document.getElementById("Tb_Template").value;
		var templateLength = document.getElementById("Tb_Template").value.length;
		
		if (cb_EncryptOpt) {
		    txt_EncryptKey = document.getElementById("Txt_EncKey").value;
		}
		else {
		    txt_EncryptKey = "";
		}
		
		jQuery.ajax({
            type : "GET",
            url: urlStr + "/db/verifyTemplate?dummy=" + Math.random(),
            dataType : "json",
            data : {
                sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				tempLen : templateLength,
				tempData: templateData,
				encrypt: cb_EncryptOpt,
				encryptKey: txt_EncryptKey,
				extractEx: cb_ExtractExMode,
				qualityLevel: document.getElementById("DDb_QltyLv").value
            },
            success : function(msg) {
            	
            	clearInterval(fingerAlert);
            	$('#imgDiv').css({'visibility':'hidden'})
            	
                AppendLog("verifyTemplate", msg.retString);
                if(msg.retValue == 0) {
                    AppendLogData("Result of verifyTemplate : " + msg.retVerify);
                    if ( msg.retVerify == 'Success' ) {
                    	UnInit();
                    	attendTest();
                    	
                    } else {
                    	UnInit();
                    	alert('등록한 지문이 아닙니다.');
                    }
                    
                } else {
                	UnInit();
                	alert('지문 인식을 실패하였습니다.');
                }
                	
                
                
            },
            error : function(request, status, error) {
                Toast(JSON.stringify(request), gToastTimeout);
                Toast(JSON.stringify(status), gToastTimeout);
                Toast(JSON.stringify(error), gToastTimeout);
            }
        });
	}
	
	function VerifyWithTemplate2(){
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		var templateData = document.getElementById("Tb_Template").value;
		var templateLength = document.getElementById("Tb_Template").value.length;
		
		if (cb_EncryptOpt) {
		    txt_EncryptKey = document.getElementById("Txt_EncKey").value;
		}
		else {
		    txt_EncryptKey = "";
		}

		jQuery.ajax({
            type : "GET",
            url: urlStr + "/db/verifyTemplate?dummy=" + Math.random(),
            dataType : "json",
            data : {
                sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				tempLen : templateLength,
				tempData: templateData,
				encrypt: cb_EncryptOpt,
				encryptKey: txt_EncryptKey,
				extractEx: cb_ExtractExMode,
				qualityLevel: document.getElementById("DDb_QltyLv").value
            },
            success : function(msg) {
                AppendLog("verifyTemplate", msg.retString);
                if(msg.retValue == 0) {
                    AppendLogData("Result of verifyTemplate : " + msg.retVerify);
                    if ( msg.retVerify == 'Success' ) {
                    	var data = {
                    			loginId : $('#login_id').val(),
                    			attNewSeq : $('#attNewSeq').val(),
                    			attSeq : $('#attSeq').val(),
                    	}
                    	
                    	$.ajax({
    						url: _g_contextPath_+'/fingerScan/fingerScanWorkEnd',
    						data : data,
    						async : false,
    						type : 'POST',
    						success: function(result){
    								alert('퇴근 체크하였습니다.');
        							location.reload();
    							
    						}
    					});
                    } else {
                    	alert('등록한 지문이 아닙니다.');
                    }
                    
                }
                	
                
                
            },
            error : function(request, status, error) {
                Toast(JSON.stringify(request), gToastTimeout);
                Toast(JSON.stringify(status), gToastTimeout);
                Toast(JSON.stringify(error), gToastTimeout);
            }
        });
	}
	
	function Identify(){
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
				
		if(numOfEnrolledUser == 0) {
			AppendLogData("First, add User Data");
			return;
		}
		
		jQuery.ajax({
            type : "GET",
            url: urlStr + "/db/identify?dummy=" + Math.random(),
            dataType : "json",
            data : {
                sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
                extractEx: cb_ExtractExMode,
                qualityLevel: document.getElementById("DDb_QltyLv").value
            },
            success : function(msg) {
                AppendLog("identify", msg.retString);
                if(msg.matchedIndex == -1) {
                    AppendLogData("There is no matched template data");
                }else{
                    AppendLogData("Index of Matched Template : " + msg.matchedIndex + "(" + msg.matchedID + ")");
                }
            },
            error : function(request, status, error) {
                Toast(JSON.stringify(request), gToastTimeout);
                Toast(JSON.stringify(status), gToastTimeout);
                Toast(JSON.stringify(error), gToastTimeout);
            }
		});
	}
	
	function AbortIdentify(){
		
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/abortIdentify?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				AppendLog("abortIdentify", msg.retString);
			},
			error : function(request, status, error) {
				Toast(JSON.stringify(request), gToastTimeout);
				Toast(JSON.stringify(status), gToastTimeout);
				Toast(JSON.stringify(error), gToastTimeout);
			}
		});
	}
	
	function Enroll() {
		debugger
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		var UserID = $('#empID').val();
		
		AppendLogData(UserID);
		if(UserID == null) {
			Toast("Canceled!", gToastTimeout);
			AppendLogData("User ID is NULL");
			return;
		}
        else if(userIDs.indexOf(UserID) != -1) {
			Toast("UserID should be unique ID! Try again!", gToastTimeout);
			AppendLogData("UserID should be unique ID! Try again!");
			return;
		}
		else if(String(UserID) == "") {
			Toast("You should enter the valid name!" + String(UserID), gToastTimeout);
			AppendLogData("You should enter the valid name!");
			return;
		}
		
		if ($('#Cb_SelTemp').is(":checked")){
			cb_SelectTemplateOpt = 1;
		}
		else{
			cb_SelectTemplateOpt = 0;
		}
		
		if(cb_SelectTemplateOpt == 1)
			Toast("Placed your Finger on Camera(4 times, 2 template will be selected)", gToastTimeout);
		else
			Toast("Placed your Finger on Camera", gToastTimeout);
			
		if (cb_EncryptOpt) {
		    txt_EncryptKey = document.getElementById("Txt_EncKey").value;
		}
		else {
		    txt_EncryptKey = "";
		}
		
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/enroll?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				userID : UserID,
				userSerialNo : numOfEnrolledUser,
				selectTemplate: cb_SelectTemplateOpt,
				encrypt: cb_EncryptOpt,
				encryptKey: txt_EncryptKey,
				extractEx: cb_ExtractExMode,
				qualityLevel: document.getElementById("DDb_QltyLv").value
			},
			success : function(msg) {
				
		        
				
				if(msg.retValue == 0) {
					userIDs.push(UserID);
					userTemps.push(cb_SelectTemplateOpt);
					insertUserInfo(numOfEnrolledUser, UserID, cb_SelectTemplateOpt);
					numOfEnrolledUser++;
				}
				GetTemplateData();
			},
			error : function(request, status, error) {
				HandleError(request, status, error);
			}
		});
	}
	
	function Enroll2() {
		debugger
		if( isExistScannerHandle() == false ){
			Toast2('Scanner Init First', gToastTimeout);
			return ;
		} 
		
		var UserID = $('#userSeq').val();

		AppendLogData2(UserID);
		if(UserID == null) {
			Toast2("Canceled!", gToastTimeout);
			AppendLogData2("User ID is NULL");
			return;
		}
        else if(userIDs.indexOf(UserID) != -1) {
			Toast2("UserID should be unique ID! Try again!", gToastTimeout);
			AppendLogData2("UserID should be unique ID! Try again!");
			return;
		}
		else if(String(UserID) == "") {
			Toast2("You should enter the valid name!" + String(UserID), gToastTimeout);
			AppendLogData2("You should enter the valid name!");
			return;
		}
		
		if ($('#Cb_SelTemp').is(":checked")){
			cb_SelectTemplateOpt = 1;
		}
		else{
			cb_SelectTemplateOpt = 0;
		}
		
		if(cb_SelectTemplateOpt == 1)
			Toast2("Placed your Finger on Camera(4 times, 2 template will be selected)", gToastTimeout);
		else
			Toast2("Placed your Finger on Camera", gToastTimeout);
			
		if (cb_EncryptOpt) {
		    txt_EncryptKey = document.getElementById("Txt_EncKey").value;
		}
		else {
		    txt_EncryptKey = "";
		}

		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/enroll?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				userID : UserID,
				userSerialNo : numOfEnrolledUser,
				selectTemplate: cb_SelectTemplateOpt,
				encrypt: cb_EncryptOpt,
				encryptKey: txt_EncryptKey,
				extractEx: cb_ExtractExMode,
				qualityLevel: document.getElementById("DDb_QltyLv").value
			},
			success : function(msg) {
				if(msg.retValue == 0) {
					userIDs.push(UserID);
					userTemps.push(cb_SelectTemplateOpt);
					insertUserInfo(numOfEnrolledUser, UserID, cb_SelectTemplateOpt);
					numOfEnrolledUser++;
				}
				GetTemplateData2();
			},
			error : function(request, status, error) {
				HandleError(request, status, error);
			}
		});
	}
	
	function QueryData() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}
        
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/queryData?dummy=" + Math.random(),
			dataType : "json",
			data : {
				sHandle : deviceInfos[selectedDeviceIndex].DeviceHandle,
			},
			success : function(msg) {
				AppendLog("queryData", msg.retString);
				if(msg.retValue == 0) {
               		$("#slt_UserList").attr("innerHTML" , "");
                    numOfEnrolledUser = 0;
                    var n_users = parseInt(msg.db.size);
                    for(var i=0; i<n_users; i++) {
                        var id_i = msg.db[i].id;
                        var tmp2_size = msg.db[i].template2;
                        var type_i = 0;
                        userIDs.push(id_i);
                        if(tmp2_size == 0) {
                            userTemps.push(0);
                        }
                        else {
                            userTemps.push(1);
                            type_i = 1;
                        }
                        insertUserInfo(numOfEnrolledUser, id_i, type_i);
                        numOfEnrolledUser++;
                    }
				}
				
			},
			error : function(request, status, error) {
				HandleError(request, status, error);
			}
		});
	}

	function OnSelectUser(){
		selectedUserNo = $("#slt_UserList option:selected").attr("value");
	}
	
	function insertUserInfo(serialNo, userId, templateOpt) {
		var userInfoStr;
		
		if(templateOpt == 1)
			userInfoStr = "[ No. " + serialNo + " ] " + "[ ID: " + userId + " ] " + "[ Temp1: " + "O" + " ] " + " [ Temp2: " + "O" + " ]";
		else
			userInfoStr = "[ No. " + serialNo + " ] " + "[ ID: " + userId + " ] " + "[ Temp1: " + "O" + " ] " + " [ Temp2: " + "X" + " ]";
			
		$("#slt_UserList").append("<option value='"+serialNo+"' class='UserListOptions' >"+userInfoStr+"</option>");	
	}
	
	function deleteUserInfo(delUserIndex) {
		$("#slt_UserList").attr("innerHTML" , "");
		
		for(var i=0; i<numOfEnrolledUser; i++){
			if(i < delUserIndex)
				insertUserInfo(i, userIDs[i], userTemps[i]);
			else if(i > delUserIndex)
				insertUserInfo(i-1, userIDs[i], userTemps[i]);
		}
	}
		
	function DelTpl() {
	
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}
		
		if(numOfEnrolledUser == 0) {
			AppendLogData("First, add User Data");
			return;
		}
		
		if(selectedUserNo == -1) {
			Toast("Select User-index", gToastTimeout);
			return;
		}
				
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/delete?dummy=" + Math.random(),
			dataType : "json",
			data : {
				sHandle : deviceInfos[selectedDeviceIndex].DeviceHandle,
				userSerialNo : selectedUserNo
			},
			success : function(msg) {
				AppendLog("delete", msg.retString);
				if(msg.retValue == 0) {
					deleteUserInfo(selectedUserNo);
					userIDs.splice(selectedUserNo, 1);
					userTemps.splice(selectedUserNo, 1);
					numOfEnrolledUser--;
				}
			},
			error : function(request, status, error) {
				HandleError(request, status, error);
			}
		});
	}
	
	function UpdateTemplate() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}
		
		if(numOfEnrolledUser == 0) {
			AppendLogData("First, add User Data");
			return;
		}
		
		if(selectedUserNo == -1) {
			Toast("Select User-index", gToastTimeout);
			return;
		}
		
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/update?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				userSerialNo: selectedUserNo,
				extractEx: cb_ExtractExMode,
				qualityLevel: document.getElementById("DDb_QltyLv").value
			},
			success : function(msg) {
				AppendLog("update", msg.retString);
			},
			error : function(request, status, error) {
				HandleError(request, status, error);
			}
		});
	}
	
	function InfoDelAll() {
	
		$("#slt_UserList").attr("innerHTML" , "");
		numOfEnrolledUser = 0;
		userIDs = [];
		userTemps = [];
		
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/deleteAll?dummy=" + Math.random(),
			dataType : "json",
			success : function(msg) {
				AppendLog("deleteAll", msg.retString);
			},
			error : function(request, status, error) {
					HandleError(request, status, error);
			}
		});
	}
	
	function SaveTemplate() {
		if( isExistScannerHandle() == false ){
			Toast('Scanner Init First', gToastTimeout);
			return ;
		}
		
		if(numOfEnrolledUser == 0) {
			AppendLogData("First, add User Data");
			return;
		}
		
		if(selectedUserNo == -1) {
			Toast("Select User-index", gToastTimeout);
			return;
		}

		if (cb_EncryptOpt) {
		    txt_EncryptKey = document.getElementById("Txt_EncKey").value;
		}
		else {
		    txt_EncryptKey = "";
		}
		
		jQuery.ajax({
			type : "GET",
			url: urlStr + "/db/getTemplateData?dummy=" + Math.random(),
			dataType : "json",
			data : {
			    sHandle: deviceInfos[selectedDeviceIndex].DeviceHandle,
                id: pageID,
				userSerialNo: selectedUserNo,
				encrypt: cb_EncryptOpt,
				encryptKey: txt_EncryptKey
			},
			success : function(msg) {
				AppendLog("db/getTemplateData", msg.retString);
				if(msg.retValue == 0) {	
					AppendLogData(msg.templateBase64);
				}
				
			},
			error : function(request, status, error) {
					HandleError(request, status, error);
			}
		});
	}
	
	function SendParameter() {
		if ($('#Cb_FastMode').is(":checked")){
			cb_FastMode = 1;
		} 
		else {
			cb_FastMode = 0;
		}
		
		if ($('#Cb_EnDetectFakeAdvanced').is(":checked")){
			cb_DetectFakeAdvancedMode = 1;
		} 
		else {
			cb_DetectFakeAdvancedMode = 0;
		}
				
		tb_Sensitivity = document.getElementById("Tb_Sensitivity").value;
		tb_Brightness = document.getElementById("Tb_BrightnessValue").value;
		ddb_Securitylevel = document.getElementById("DDb_SecuLevOpt").value;
		ddb_Timeout = document.getElementById("DDb_TimeoutOpt").value;
		ddb_TemplateType = document.getElementById("DDb_Tpltype").value;
		ddb_Fakelevel = document.getElementById("DDb_FakeLevOpt").value;
		
		$(document).ready(function() {
			jQuery.ajax({
				type : "GET",
				url: urlStr + "/api/setParameters?dummy=" + Math.random(),
				dataType : "json",
				data : {
					sHandle : deviceInfos[selectedDeviceIndex].DeviceHandle,
					brightness : tb_Brightness,
					fastmode : cb_FastMode,
					securitylevel : ddb_Securitylevel,
					sensitivity : tb_Sensitivity,
					timeout : ddb_Timeout,
					templateType : ddb_TemplateType,
					fakeLevel : ddb_Fakelevel,
					detectFakeAdvancedMode : cb_DetectFakeAdvancedMode
				},
				success : function(msg) {
				    AppendLog("setParameters", msg.retString);
				    AppendLogData(" unsupportedVariables : " + msg.unsupportedVariables);
				},
				error : function(request, status, error) {
					HandleError(request, status, error);
				}
			});
		});
	}
	function ClearLog()
	{
		document.getElementById("Tb_DisplayLog").value = " ";
	}
    
    function Toast(msg, timeout)
    {
        document.getElementById("TdAlert").innerHTML = msg;
        clearTimeout(tagToast);
        tagToast = setTimeout(function(){ document.getElementById("TdAlert").innerHTML = ""; }, timeout);
    }
    
    function Toast2(msg, timeout)
    {
        document.getElementById("TdAlert").innerHTML = msg;
        clearTimeout(tagToast);
        tagToast = setTimeout(function(){ document.getElementById("TdAlert").innerHTML = ""; }, timeout);
    }
	
	function HandleError(request, status, error)
	{
		Toast(JSON.stringify(request), gToastTimeout);
		Toast(JSON.stringify(status), gToastTimeout);
		Toast(JSON.stringify(error), gToastTimeout);
	}	