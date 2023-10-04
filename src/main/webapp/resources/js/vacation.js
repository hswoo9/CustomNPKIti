// 전역변수 설정
var vacation = {
    global : {

    }
}
var uri = "/CustomNPKlti";
//uri = "";
function callSpcVacList(e, d, k, sDt, eDt){
    bottomGrid(e, d, k, sDt, eDt);
}
function callEmpKindsGrid(empSeq, day){
	empKindsGrid(empSeq, day);
}
function callSelectFileUploadList(useYn, empSeq, id){
	selectFileUploadList(useYn, empSeq, id);
}

function bottomGrid(e, d, k, sDt, eDt){

    var bottomDataSource = new kendo.data.DataSource({
        serverPaging : true,
        pageSize : 10,
        transport : {
            read : {
                //url : uri + "/vacation/getSpcVacList",
				url : uri + "/vcatn/getSpecialUseHist",
                dataType : "json",
                type : 'post'
            },
            parameterMap : function(data, operation) {
                data.empSeq = e;
				data.authority = "admin";
				data.speclSn = k;
				data.startDate = sDt;
				data.endDate = eDt;
				
                return data;
            }
        },
        schema : {
            data : function(response) {
                return response.list;
            },
            total : function(response) {
                return response.list.length;
            }
        }
    });

    var grid = $("#bottomGrid").kendoGrid(
        {
            dataSource : bottomDataSource,
            height : 250,
            dataBound : function(e) {
                this.fitColumns();
                gridDataBound(e);
            },
            sortable : false,
            pageable : {
                refresh : true,
                pageSizes : [ 10, 20, 30, 50, 100 ],
                buttonCount : 5
            },
            persistSelection : true,
            selectable : "multiple",
            columns : [
                {
                    field : "",
                    title : "부서",
                    template : function(e){
                    	if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + d + "</span>";
                    	}else{
                    		return d;
                    	}
                        
                    }
                }, {
                    field : "EMP_NAME",
                    title : "이름",
                    template : function(e){
                    	if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + e.EMP_NAME + "</span>"; 
                    	}else{
                    		return e.EMP_NAME;
                    	}
                    }
                }, {
                    field : "VCATN_KND_NAME",
                    title : "휴가명",
                    template : function(e){
                    	if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + e.VCATN_KND_NAME + "</span>"; 
                    	}else{
                    		return e.VCATN_KND_NAME;
                    	}
                    }
                }, {
                    field : "ALWNC_DAYCNT",
                    title : "부여일",
                    template : function(e){
                    	if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + e.ALWNC_DAYCNT + "</span>"; 
                    	}else{
                    		return e.ALWNC_DAYCNT;
                    	}
                    }
                }, {
                    field : "USE_DAY",
                    title : "사용일",
                     template : function(e){
                    	if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + e.USE_DAY + "</span>"; 
                    	}else{
                    		return e.USE_DAY;
                    	}
                    }
                }, {
                    field : "",
                    title : "잔여일",
					template : function(e){
						var result = e.ALWNC_DAYCNT;
						if(e.USE_DAY != null){
							if(e.state == "C"){
	                    		return "<span style='text-decoration: line-through; color: red;'>" + (Number(e.ALWNC_DAYCNT) - Number(e.USE_DAY)) + "</span>"; 
	                    	}else{
	                    		return Number(e.ALWNC_DAYCNT) - Number(e.USE_DAY);
	                    	}
						}
						if(e.state == "C"){
                    		return "<span style='text-decoration: line-through; color: red;'>" + result + "</span>"; 
                    	}else{
                    		return result;
                    	}
					}
                }, {
                    field : "c_ridocfullnum",
                    title : "문서번호",
                    template : function(e){
                    	var str = "";
                    	var dikeycode = e.c_dikeycode;
						if(e.state == "C"){
							if(dikeycode != null && dikeycode != ''){
                    			return "<span style='text-decoration: line-through; color: red;'>" + e.c_ridocfullnum + "</span>"; 
							}else{
								str = "";
							}
                    	}else{
                    		if(dikeycode != null && dikeycode != ''){
								str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ e.c_ridocfullnum +"</a>";
							}else{
								str = "";
							}
                    	}
						return str;

                    }
                }, {
                    field : "",
                    title : "결재문서",
                    template : function(e){
                    	var str = "";
                    	var dikeycode = e.c_dikeycode;
                        if(dikeycode != null && dikeycode != ''){
							str += "<a href=\"javascript: fnViewAppDoc('"+ dikeycode +"','');\" class='appDocClass'>"+ e.doc_title +"</a>";
						}else{
							str = "";
						}
						return str;

                    }
                }, {
                    field : "",
                    title : "관리",
                    template : function(e){
						if(e.state == "C"){
	                    	return "";
	                	}else{
		                    if(e.AFTFAT_MNT_YN == 'Y'){
		                    	if(e.AFTFAT_MNT_MTH == '1'){
			                        if(e.EVIDENCE_FILE_SN != null){
			                        	var str = "";
			                        	str += "<div class='fileBtnDown'><input type='button' onclick=\"fn_fileDownload('"+ e.FILE_MASK +"','"+ e.FILE_NAME +"')\" value='다운로드'>";
			                        	str += "<input type='button' style='margin-left: 10px; background: #eb1818;' onclick=\"fn_fileDelete('" + e.EVIDENCE_FILE_SN + "', '"+ e.FILE_MASK +"');\" value='삭제'/></div>";
			                            return str;
			                        } else {
			                            return "<span style='color: red;'>증빙파일 미제출</span>";
			                        }
		                    	}else{
		                    		return "전자결재";
		                    	}
		                    }else{
		                    	return "사후관리 미사용";
		                    }
	                	}
                    }
                }],
            change : function(e) {
                codeGridClick(e)
            }
        }).data("kendoGrid");

}

function fn_fileDownload(mask, name){
    var comSubmit = new ComSubmit();
    comSubmit.setUrl(uri + "/vacationDownloadFile.do");
    //comSubmit.setUrl("/vacationDownloadFile.do");
    comSubmit.addParam("fileName", name);
    comSubmit.addParam("fileMask", mask);
    comSubmit.addParam("pathNum", "8");
    comSubmit.submit();
}

function fnViewAppDoc(c_dikeycode, formId) {
	var eaType = "ea";
	if (!window.location.origin) {
		window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
	}
	
	var origin = document.location.origin;
	
	var thisX = parseInt(document.body.scrollWidth);
	var thisY = parseInt(document.body.scrollHeight);
	var maxThisX = screen.width - 50;
	var maxThisY = screen.height - 50;
	
	if (maxThisX > 1000) {
		maxThisX = 1000;
	}
	
	var marginY = 0;
	// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45; // IE 6.x
	else if (navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75; // IE 7.x
	
	if (thisX > maxThisX) {
		window.document.body.scroll = "yes";
		thisX = maxThisX;
	}
	
	if (thisY > maxThisY - marginY) {
		window.document.body.scroll = "yes";
		thisX += 19;
		thisY = maxThisY - marginY;
	}
	
	// 센터 정렬
	var windowX = (screen.width - maxThisX + 10) / 2;
	var windowY = (screen.height - maxThisY) / 2 - 20;
	var strScroll = 0;
	var strResize = 0;
	var location = 0;
	
	//origin = "http://gw.jif.re.kr/";
	
	if (eaType == "ea") {
		var url = origin + "/ea/edoc/eapproval/docCommonDraftView.do?diKeyCode=" + c_dikeycode;
	} else if (formId || formId === 0) {
		var url = origin + "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + c_dikeycode + "&form_id=" + formId;
	} else {
		return;
	}
	
	pop = window.open(
		url, "EaViewPop",
		"width=" + maxThisX + ", height=" + maxThisY + ", top=" + windowY + ", left=" + windowX + ", scrollbars=yes, resizable=" + strResize + ", location=" + location
	);
	
	try {
		pop.focus();
	} catch(e) {}
}

function fn_fileDelete(key, fileMask){
	if(confirm("정말 삭제하시겠습니까?")){
		var formData = new FormData();
		formData.append("fileKey", key);
		formData.append("fileMask", fileMask);
		
		$.ajax({
			url: uri + "/vcatn/fileDelete",
			data: formData,
			type:'POST',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				
				if(result.state == "success"){
					alert(result.message);
					location.reload();
				}else{
					alert(result.message);
					location.reload();
				}
			}
		});
	}
}

function zipFileDownload(empSeq, zipName){
	var formData = new FormData();
	formData.append("empSeq", empSeq);
	formData.append("zipName", zipName);
	$.ajax({
		url: uri + "/vcatn/zipFileCheck",
		data: formData,
		type:'POST',
		enctype: 'multipart/form-data',
		processData: false,
		contentType: false,
		dataType: 'json',
		cache: false,
		async: false,
		success:function(result){
			if(result.state == "200"){
				var comSubmit = new ComSubmit();
			    comSubmit.setUrl(uri + "/vcatn/zipFileDownload.do");
				comSubmit.addParam("empSeq", empSeq);
			    comSubmit.addParam("zipName", zipName);
			    comSubmit.submit();
			}else{
				alert("등록된 파일이 없습니다.");
			}
		}
	});
}

function empKindsGrid(empSeq, day){
	var empKindsDataSource = new kendo.data.DataSource({
        serverPaging : true,
        pageSize : 10,
        transport : {
            read : {
				url : uri + "/vcatn/getSpecialList",
                dataType : "json",
                type : 'post'
            },
            parameterMap : function(data, operation) {
                data.empSeq = empSeq;
				data.year = day;
                return data;
            }
        },
        schema : {
            data : function(response) {
                return response.list;
            },
            total : function(response) {
                return response.list.length;
            }
        }
    });

    var grid = $("#empKindsGrid").kendoGrid(
        {
            dataSource : empKindsDataSource,
            height : 250,
            dataBound : function(e) {
                this.fitColumns();
                gridDataBound(e);
            },
            sortable : false,
            pageable : {
                refresh : true,
                pageSizes : [ 10, 20, 30, 50, 100 ],
                buttonCount : 5
            },
            persistSelection : true,
            selectable : "single",
            columns : [
				{
                    field : "SPECL_SN",
                    hidden: true
                }, {
                    field : "DEPT_NAME",
                    title : "부서"
                }, {
                    field : "EMP_NAME",
                    title : "이름",
                }, {
                    field : "VCATN_KND_NAME",
                    title : "휴가명"
                }, {
                    field : "ALWNC_DAYCNT",
                    title : "부여일",
                }, {
                    field : "useDate",
                    title : "사용일",
                }, {
                    field : "",
                    title : "잔여일",
					template : function(e){
						if(e.useDate != null){
							return (Number(e.ALWNC_DAYCNT) - Number(e.useDate));	
						}else{
							return e.ALWNC_DAYCNT;
						}
                		
					}
                }],
				change : function(e) {
					codeGridClick(e)
				}
        }).data("kendoGrid");

		function codeGridClick(e) {
			var rows = grid.select();
			var record;
			var speclSn = "";
			rows.each(function() {
				record = grid.dataItem($(this));
				speclSn = record.SPECL_SN;
				
			});
			$("#speclSn").val(speclSn);
			var sDt = $("#sDt").val();
			var eDt = $("#eDt").val();
			callSpcVacList(empSeq, day, speclSn, sDt, eDt);
			
		}
}


function selectFileUploadList(useYn, empSeq, id){
	var fileDataSource = new kendo.data.DataSource({
		serverPaging : true,
		pageSize : 10,
		transport : {
			read : {
				url : uri + "/vcatn/selectFileUploadList",
				dataType : "json",
				type : 'post'
			},
			parameterMap : function(data) {
				data.empSeq = empSeq;
				data.evidenceFileSn = useYn;
				return data;
			}
		},
		schema : {
			data : function(response) {
				return response.list;
			},
			total : function(response) {
				var str = "[ " + response.list.length + " 건 ]";
				$("#fileCount").text(str);
				return response.list.length;
			}
		}
	});
	var grid = $("#" + id).kendoGrid({
		dataSource : fileDataSource,
		height : 253,
		sortable : false,
		pageable : {
			refresh : true,
			pageSizes : true,
			buttonCount : 5
		},
		persistSelection : true,
		columns : [
			{
				field : "VCATN_KND_NAME",
				title : "근태구분"
			}, {
				field : "",
				title : "사용기간",
				columns : [ {
					field : "stDt",
					title : "시작일자",
				},{
					field : "stDtTime",
					title : "시작시간",
				},{
					field : "enDt",
					title : "종료일자",
				},{
					field : "enDtTime",
					title : "종료시간",
				}]
			}, {
				field : "USE_DAY",
				title : "사용일수"
			}, {
				field : "",
				title : "비고",
				template : function(row){
					var str = "";
					var aftfatYn = row.AFTFAT_MNT_YN;
					if(aftfatYn == 'Y'){
						str += "<span style='color: red;'>미등록</span>";
					}
					return str;
				}
			}]
	}).data("kendoGrid");
}	
