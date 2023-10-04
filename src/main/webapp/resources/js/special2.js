// 전역변수 설정
var vacation = {
    global : {
		fileList : new Array()
    }
}

var uri = "/CustomNPKlti";
//uri = "";

function checkFileType(filePath){
	var fileFormat = filePath.split(".");
	if(fileFormat.indexOf("xls") > -1 || fileFormat.indexOf("xlsx") > -1){
		return true;
	}else{
		return false;
	}
}

function fileCheck(e){
	var file = $("#excelFile").val();
	if(file == "" || file == null){
		alert("파일이 없습니다.");
		return false;
	}else if(!checkFileType(file)){
		alert("엑셀 파일이 아닙니다.");
		return false;
	}
	if(confirm("업로드 하시겠습니까?")){
		var formData = new FormData(document.getElementById("excelUploadForm"));
		var uploadFileList = Object.keys(vacation.global.fileList);
		if(uploadFileList.length == 0){
			alert("파일이 없습니다.");
			return;
		}
		for(var i = 0; i < uploadFileList.length; i++){
			formData.append('excelFile', vacation.global.fileList[uploadFileList[i]]);
		}
		$.ajax({
			url: uri + "/vcatn/excelUpload",
			data: formData,
			type:'POST',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			dataType: 'json',
			cache: false,
			async: false,
			success:function(result){
				console.log(result);
				if(result.state == "success"){
					if(result.message2 != null){
						alert(result.message2);
					}
					alert(result.message);
					return "true";
				}else{
					if(result.message2 != null){
						alert(result.message2);
					}
					alert(result.message);
					return "false";
				}
			}
		});
	}
}

function excelFormDown(){
	
  var rows = [{
    	 
        cells: [
          { bold: true,
        	 value: "성명",
        	 vAlign: "center",
             hAlign: "center",
             borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
           },
          { bold: true,
        	 value: "사번",
        	 vAlign: "center",
	         hAlign: "center",
	         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
          },
          { bold: true,
        	 value: "부여일(일)",
        	 vAlign: "center",
	         hAlign: "center",
	         borderTop: { color: "#000000" },borderBottom: { color: "#000000" },borderLeft: { color: "#000000" },borderRight: { color: "#000000" }
          },
        ]
    }];

    var workbook = new kendo.ooxml.Workbook({
      sheets: [
        {
          columns: [
            { width: 100 },
            { width: 100 },
            { width: 100 },
          ],
          // Title of the sheet
          title: "특별휴가등록",
          // Rows of the sheet
          rows: rows
        },
      ]
    });
    //save the file as Excel file with extension xlsx
    kendo.saveAs({dataURI: workbook.toDataURL(), fileName: "특별휴가등록.xlsx"});

}
