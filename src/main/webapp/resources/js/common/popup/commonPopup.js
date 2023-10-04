var commonPupup = {};

/**
 * 참조문서 팝업 API
 * 
 * function	:	commonPupup.refDocPupup(fnCallback);
 * 
 * parmas	:	fnCallback(arg)		콜백함수		필수 (arg = 매개변수)
 * 
 * arg		:	docId	: 	문서키		ex)	"4"
 *				docNo	:	문서번호		ex)	"구축팀-1"
 *				regDate	:	등록일자		ex)	"2020-10-27"
 *				title	:	제목			ex)	"테스트"
 *				userNm	:	기안/접수자	ex)	"관리자" 
 * 
 * return	:	
 */
commonPupup.refDocPupup = function(fnCallback){
	commonPupup.refDocPupup.fnCallback = fnCallback;
	var url = '/CustomNPKlti/common/popup/refDocPopup';
	window.open(url, "viewer", "width=850, height=650, resizable=no, scrollbars = no, status=no, top=50, left=50", "newWindow");
};
