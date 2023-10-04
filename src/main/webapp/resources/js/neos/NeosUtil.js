/**
 *
 * @title Neos Javascript Util
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 28.
 * @version
 * @dscription Javascript를 쓰면서 유용하다고 생각되는 유틸을 작성
 * 			   jQuery가 기본적으로 선행 포함 되어야 한다.
 *
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용
 * -----------  -------  --------------------------------
 * 2012. 4. 25.  박기환        최초 생성
 *
 */

/**
 * 원하는 id의 tag 안의 input tag와 select의 값을 가져온다.
 * 파라미터의 갯수에 따라 값을 다르게 가져옴
 * 2개 --> select, textarea 의 값들을 가져올때 쓰인다
 * 3개 --> input 의 값들을 가져올때 쓰인다
 * 최초 값을 가져올때 쓰인다.
 *
 * @param id 			원하는 tag의 id
 * @param tag_type 		원하는 tag 종류
 * @param input_type	input tag의 type 종류
 * @return data			map형의 객체로 받아서 return
 *
 */

var _g_contextPath_ ;
var _g_aproval_width_ = 1000;
var _g_aproval_heigth_ = 700;
var NeosUtil = {};
function get_input_data(id, tag_type, input_type){

	var data = {};
	var input_data;

	if(arguments.length==2){

		input_data = $("#"+id+" "+tag_type);

	}else if(arguments.length==3){

		input_data = $("#"+id+" "+tag_type+"[type="+input_type+"]");

	}

	input_data.each(function(){
		data[$(this).attr("id")] = $(this).val();
	});

	return data;
}

/**
 * 원하는 id의 tag 안의 input tag와 select의 값을 가져온다.
 * 기존의 가져온 값이 있고 그 값을 합치고 싶을때 쓰인다.
 * select, textarea 의 값들을 가져올때 쓰인다
 *
 * @param id 			원하는 tag의 id
 * @param tag_type 		원하는 tag 종류
 * @param data			기존과 합치고 싶은 객체
 * @return data			map형의 객체로 받아서 return
 *
 */
function update_input_data(id, tag_type, data){
	var input_data;

	input_data = $("#"+id+" "+tag_type);

	input_data.each(function(){
		data[$(this).attr("id")] = $(this).val();
	});

	return data;
}

/**
 * 원하는 id의 tag 안의 input tag와 select의 값을 가져온다.
 * 기존의 가져온 값이 있고 그 값을 합치고 싶을때 쓰인다.
 * input 의 값들을 가져올때 쓰인다
 *
 * @param id 			원하는 tag의 id
 * @param tag_type 		원하는 tag 종류
 * @param data			기존과 합치고 싶은 객체
 * @return data			map형의 객체로 받아서 return
 *
 */
function update_input_data2(id, tag_type, input_type, data){


	var input_data;
	// input 태그에 type이 radio인 값 가져오는거 추가
	if(tag_type=="input" && input_type=="radio"){

		input_data = $("#"+id+" :radio");
		input_data.each(function(){
			data[$(this).attr("name")] = $(":radio[name="+$(this).attr("name")+"][checked=checked]").val();
		});

	}else{
		input_data = $("#"+id+" "+tag_type+"[type="+input_type+"]");

		input_data.each(function(){
			data[$(this).attr("id")] = $(this).val();
		});
	}

	return data;
}

function getLeftMenuWidth(){
	return 215;
}

//*----- 문자열 관련 함수 -----*//
/**
 *이름 : ncCom_Date()
 *설명 : 날짜를 린턴한다
 *인자 : 날짜형태 '/','-', '.'
 *리턴 : 날짜형태
*/
function ncCom_Date(argDate, argFlag){
	if(typeof(argDate) == "undefined") return "" ;
	if( ncCom_Empty(argDate) || ( argDate.length != 8 && argDate.length != 10 ) ) return "" ;
	
	if(typeof(argFlag) == "undefined") argFlag = ".";

	if( argDate.length == 10 ) {
		argDate = ncCom_Replace(argDate, '.', '');
		argDate = ncCom_Replace(argDate, '-', '');
		argDate = ncCom_Replace(argDate, '/', '');
	}
	argFlag = argFlag.toUpperCase() ;


	var day ="";

	var y =  (argDate.length>=4)? argDate.substr(0,4):"    ";
	var sy = (argDate.length>=4) ? argDate.substr(2,2): "  ";
	var m =(argDate.length>=6)? argDate.substr(4,2):"  ";
	var d = (argDate.length>=8)? argDate.substr(6,2):"  ";

	switch (argFlag) {
		case "Y" : day = y;  break;
		case "M" : day = m;  break;
		case "D" : day = d;  break;
		case "YM" : day=y + "." + m ; break;
		case "SYMD": day = sy + "." + m + "." + d; break ;
		default  : day = y + argFlag + m + argFlag + d;
	}
	return day;
}
/**
  *이름 : ncCom_Today()
  *설명 : 현재날짜를 린턴한다
  *인자 : 날짜형태 '/','-'
  *리턴 : 날짜형태
 */
function ncCom_Today(argFlag){
	if(typeof(argFlag) == "undefined") argFlag = "/";

	argFlag = argFlag.toUpperCase();

	//---- 호스트 날짜로 변경

	var day ="";
	var today= gv.sdate; // 스크립트로 생성

	var y = (today.length>=4)? today.substr(0,4):"    ";
	var m =(today.length>=6)? today.substr(4,2):"  ";
	var d = (today.length>=8)? today.substr(6,2):"  ";

	switch (argFlag) {
		case "Y" : day = y;  break;
		case "M" : day = m;  break;
		case "D" : day = d;  break;
		case "YM" : day=y + "." + m ; break;
		default  : day = y + argFlag + m + argFlag + d;
	}
	return day;
}

/**
  *이름 : ncCom_Empty()
  *설명 : 공백여부체크한다
  *인자 : 체크할 문자
  *리턴 : true ,false
 */
function ncCom_Empty(argStr){
	if (!argStr) return true;
	if (argStr.length == 0) return true;
	if(typeof(argStr) == "undefined")  return true ;
	if(argStr == "undefined")  return true ;	
	if(argStr == "null") return true ;
	
	for (var i = 0; i<argStr.length; i++) {
 		if ( (" " == argStr.charAt(i)) || ("　" == argStr.charAt(i)) )  {	}
		else return false;
	}
	return true;
}
/**
 *이름 : ncCom_EmptyToString()
 *설명 : 공백을 특정문자로 변경한다.
 *인자 : argStr : 체크할 문자,  conString: 변경할 문자
 *리턴 : 변경 문자
*/
function ncCom_EmptyToString(argStr,conString){
	if ( conString == undefined )  conString = "" ;
	if(ncCom_Empty(argStr+"") || argStr == "null" || argStr == null ) {

	}else{
		conString = argStr ;
	}
	return conString ;
}
/**
  *이름 : ncCom_DelBlank()
  *설명 : 공백을 제거한다
  *인자 : 제거할문자
  *리턴 : 문자열
 */
function ncCom_DelBlank(argStr){
	var len = argStr.length;
	var retStr = "";
	argStr += "";
	for(var i=0; i<len; i++) {
		if((argStr.charAt(i)!=" ") && (argStr.charAt(i)!="　"))
			retStr += argStr.charAt(i);
	}
	return retStr;
}

function ncCom_EmptyReplace(argStr, argConvert) {
	if(ncCom_Empty(argStr)) return argConvert ;
	else return argStr ;
}

/**
  *이름 : ncCom_SubstrHan()
  *설명 : 한글문자열길이만큼 가져옴
  *인자 : argStr : 문자열
  *		  argPos : 시작위치
  *          argLen : 종료위치
  *리턴 : 문자열
  *ex) ncCom_SubstrHan('가나다라마바사',2,3) = '다라마'
 */
function ncCom_SubstrHan(argStr, argPos, argLen){
	var p1 = sub_HanLen(argStr, argPos);
	var p2 = sub_HanLen(argStr, (argPos + argLen));
	return (argStr.substr(p1, p2-p1));
}

/**
  *이름 : ncCom_Replace()
  *설명 : 한글문자열길이만큼 가져옴
  *인자 : originalString : 문자열
  *		  findText : 찾을 문자열
  *          replaceText : 바꿔야할 문자열
  *리턴 : 문자열
  *ex) ncCom_Replace('테스트다','스','타') = ' 테타트다'
 */
function ncCom_Replace(originalString, findText, replaceText){

	originalString = ncCom_Trim(originalString);

	var pos = 0 ;

	pos = originalString.indexOf(findText);
	while (pos != -1) {
		preString = originalString.substr(0,pos);
		postString = originalString.substring(pos+findText.length);
		originalString = preString + replaceText + postString;
		pos = originalString.indexOf(findText);
	}

	return originalString;
}

/**
  *이름 : ncCom_Trim()
  *설명 : 문자열 공백제거
  *인자 : 문자열
  *리턴 : 문자열
  *ex) ncCom_Trim(' 테스트다 ') = '테스트다'
 */
function ncCom_Trim(argStr) {
	if(argStr == null)
		return "";

	argStr = argStr.toString();

	var pos1, pos2 ;
	for(pos1=0; (argStr.charAt(pos1) == ' ' || argStr.charAt(pos1) == '　') && pos1 < argStr.length ; pos1++) ;
		for(pos2=argStr.length-1; (argStr.charAt(pos2) == ' ' || argStr.charAt(pos2) == '　') && pos2 >= 0 ; pos2--) ;
			if(pos1 > pos2) return "" ;
	return argStr.substr(0,pos2+1).substring(pos1) ;
}

function fncConvertRegDate(dtRegDate){
 	var nd = new Date();

 	var regYear	= dtRegDate.substring(0,4);
 	var regMonth= dtRegDate.substring(5,7);
 	var regDate	= dtRegDate.substring(8,10);
 	var regTime	= dtRegDate.substring(11,16);

 	var nowYear	= nd.getFullYear();
 	var nowMonth= nd.getMonth()+1;
 	if(nowMonth<10){
 		nowMonth = "0" + nowMonth;
 	}
 	var nowDate	= nd.getDate();
 	if(nowDate<10){
 		nowDate = "0" + nowDate;
 	}

 	if(regYear == nowYear ){
    	if(regMonth+"/"+regDate == nowMonth+"/"+nowDate){
 			strRegDate = regTime;
 		}else{
 			strRegDate = regMonth+"/"+regDate;
 		}
     }else{
     	if(regMonth+"/"+regDate == nowMonth+"/"+nowDate){
 			strRegDate = regTime;
 		}else{
 			strRegDate = regMonth+"/"+regDate;
 		}
     }


 	return strRegDate;
 }

	//*----- 입력 필드 관련 함수 -----*//
/**
  *이름 : ncCom_ErrField()
  *설명 :  입력필드 입력여부확인
  *인자 :
			argObj : 입력필드명
			argTitle : 공백일경우 메세지
  *리턴 : true, false
  *ex) ncCom_ErrField(입력필드명)
 */

function ncCom_ErrField(argObj, argTitle){
	if (argTitle==null) argTitle = argObj.title;
	alert(argTitle);
	ncCom_ColorField(argObj);
	return false;
}

/**
  *이름 : ncCom_CheckDate()
  *설명 :  From ~ To 체크  , 시작날짜가 종료날짜보다 크면 false 를 리턴
  *인자 :
			argFrom : 시작날짜
			argTitle : 종료날짜
			argSign : 날짜 형태 ('-','.'...)
  *리턴 : true, false
  *ex) ncCom_CheckDate('2002-02-01','2003-03-01','-')
 */
function ncCom_CheckDate(argFrom,argTo,argSign){
	var intFrom = parseInt(ncCom_Replace(argFrom,argSign,""));
	var intTo = parseInt(ncCom_Replace(argTo,argSign,""));
	if((intFrom-intTo)>0) {
		return(false);
	}
	return(true);
}

/**
  *이름 : ncCom_DiffDate()
  *설명 : 날짜 차이를 일로계산 한다
  *인자 :
			fromDate : 시작날짜
			toDate : 종료날짜

  *리턴 : 날짜차이일
  *ex) ncCom_DiffDate('2002-02-01','2003-03-01')
 */
function ncCom_DiffDate(fromDate, toDate) {
	var MinMilli = 1000 * 60;
	var HrMilli = MinMilli * 60;
	var DyMilli = HrMilli * 24;

	var d1 = new Date(ncCom_Replace(fromDate, ".", "/"));
	var d2 = new Date(ncCom_Replace(toDate, ".", "/"));

	var d3 = d2-d1;
	var str = d3 /DyMilli ;

	return str;
}
/**
  *이름 : ncCom_DiffMonthDate()
  *설명 : 월 차이를  계산 한다
  *인자 :
			fromDate : 시작날짜
			toDate : 종료날짜

  *리턴 : 날짜개월수
  *ex) ncCom_DiffMonthDate('2002-02-01','2003-03-01')
 */
function ncCom_DiffMonthDate(fromDate, toDate) {
	var fromYear =  "";
	var toYear = "";
	var fromMonth = "";
	var toMonth = "";

	fromYear = parseInt( fromDate.substring(0,4) ) ;
	toYear = parseInt(toDate.substring(0,4) ) ;
	fromMonth =  fromDate.substring(5,7);
	toMonth  = toDate.substring(5,7);


	if (fromMonth.length == 2) {
		if(fromMonth.substring(0,1) == '0')  fromMonth = parseInt(fromMonth.substring(1,2));
		else fromMonth = parseInt(fromMonth);
	}else {
		fromMonth = parseInt(fromMonth);
	}
	if (toMonth.length == 2) {
		if(toMonth.substring(0,1) == '0')  toMonth = parseInt(toMonth.substring(1,2));
		else toMonth = parseInt(toMonth);
	}else {
		toMonth = parseInt(toMonth);
	}

	return ( (toYear - fromYear) * 12 ) + (  toMonth - fromMonth) ;
}
function ncCom_ColorField(argField) {

//	if (argField.tagName == "SELECT" ) {
//		argField.style.backgroundColor = '#DEFDD2'
//		argField.focus()
//		return;
//	}
//	argField.style.backgroundColor = '#DEFDD2'

	argField.select();
	argField.focus();
}

//*----- 날짜 계산 관련 함수 -----*//


/**
  *이름 : ncCom_CalcDate2()
  *설명 :  기준일자에서 특정 기간을 ±(하루,한달,일년
  *인자 :
			argDate : 기준날짜
			toDate : 특정기간

  *리턴 : 날짜차이일
  *ex) ncCom_CalcDate2('20030203','-d')  = 20030202
 */

function ncCom_CalcDate2(argDate, argFlag){
	var year	= argDate.substr(0,4);
	var month	= argDate.substr(4,2);
	var day		= argDate.substr(6,2);

	switch(argFlag) {
	case "-d" :
		day = parseInt(day,10)-1;
		if ( day == 0 ){
			month --;
			if ( month == 0 ){
				year --;
				month = 12;
			}
			day = ncCom_MaxDay(year, month);
		}
		break;
	case "+d" :
		day = parseInt(day,10)+1;
		if ( day > ncCom_MaxDay(year, month) ) {
			month ++;
			if ( month == 13 ){
				year ++;
				month=1;
			}
			day = 1;
		}
		break;
	case "-m" :
		month = parseInt(month,10)-1;
		if ( month == 0 ){
			year --;
			month = 12;
		}
		break;
	case "+m" :
		month = parseInt(month,10)+1;
		if ( month == 13 ){
			year ++;
			month=1;
		}
		break;
	case "-y" :
		year = parseInt(year)-1;
		month = parseInt(month,10);
		break;
	case "+y" :
		year = parseInt(year)+1;
		month = parseInt(month,10);
		break;
	}

	if ( (argFlag.substr(1,1) == 'm' ) || (argFlag.substr(1,1) == 'y' )) {
		tempmaxday = ncCom_MaxDay(year, month);
		if ( day > tempmaxday ) day = tempmaxday;
	}

	month = parseInt(month,10);
	if ( month < 10 ) month="0"+month;

	day = parseInt(day,10);
	if ( day < 10) day = "0" + day;

	return( year+""+month+""+day+"" );
}

function ncCom_MaxDay(argYear, argMonth){
	var cDate = new Array(29, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var lastday = cDate[ argMonth-0 ];
	if( argMonth == 2 && ((argYear%4==0 && argYear%100!=0) || (argYear%400==0)) )
	lastday = cDate[0];

	return lastday;
}
 /**------------------------------------------------------------------------------------------
   년, 월, 일 유효성 체크 (윤년 체크 포함)
   입력항목 :
           - optionFlg : YMD가 필수 항목이면 1 ,
                                   선택항목: 0 이며, 모두 입력 또는 모두 공백
            -  year :  년을 표시하는 input 객체  (ex. MainForm.year)
            -  month: 월을 표시하는 input 객체
            -  day :    일을 표시하는 input 객체
    관련 함수
            - isNumber () :  숫자만 입력 받도록하는 함수
            - tabOrder()  :    정해진 숫자만큼 입력하면 자동으로 포커스 이동
--------------------------------------------------------------------------------------------*/
function checkYMD(optionFlg, year, month, day) {

     //----------------------------------------------------------
     // year, month, day 를 모두 입력했는지 조사
     // 년월일 이 필수 입력이 아니면 체크 불필요
     //----------------------------------------------------------
     if(optionFlg) {
        if(!year.value|| !month.value || !day.value) {
            alert("년월일은 필수 입력항목입니다");
            year.focus();
            return false;
       }
     }else {

        //옵션사항인데 YMD가 하나도 입력되지 않으면 체크 하지않음
	    if( ncCom_Empty(year.value)  && ncCom_Empty(month.value) && ncCom_Empty(day.value) ) {
            return true;
        }else {
            if( ncCom_Empty(year.value) || ncCom_Empty(month.value) || ncCom_Empty(day.value) ) {
                alert("년월일이 모두 입력되거나 모두 생략되어야  합니다.");
                year.focus();
                return false;
            }
         }
     }

     //---------------------------------------------------------
     // year, month, day는 input 객체이다.
     //--------------------------------------------------------
     var total_days;            // 각 월별 총 일수  (30 | 31| 28| 29)
     var ckFlg=0;
    //--------------------------------------------------------------------
    // 숫자만 입력받도록 한다.  isNumber()를 사용하면
    //  생략해도 된다.
    //-------------------------------------------------------------------
     var  data1 = year.value;
     var data2 = month.value;
     var data3 = day.value;
     for ( var j=1; j< 4; j++ ) {
         var data = eval( "data"+j );
        for ( var i=0; i < data.length; i++)  {
            var ch = data.substring(i,i+1);
            if (ch<"0" | ch>"9") {
	    alert ( "\n일자를 바르게 입력하세요." );
	     year.focus();
	     year.select();
	     return false;
	 }
        }// end inner for
    } //end outter for


    //------------------------------------------------------------
    // 월 체크 ( 1 ~ 12)
    //-----------------------------------------------------------
     if( (1 > month.value) ||  (12 < month.value) ) {
	       ckFlg=1;
     }
     if(ckFlg) {
        alert ( "\n월을 바르게 입력하세요."  );
         month.focus();
         month.select();
         return false;
      }

      //------------------------------------------------------------
      // 1. 각 달의 총 날수를 구한다.
      //----------------------------------------------------------
       if(month.value == 4||month.value == 6||month.value == 9||month.value == 11)  {
           total_days = 30;
        } else {
            total_days=31;
        }
       //--------------------------------------------------------
       // 1-1.윤년에 따른 2월 총 날수 구한다.
       //--------------------------------------------------------
       if(month.value ==2) {
            // 윤년조사
            if((year.value % 4 == 0) && (year.value % 100 != 0) || (year.value % 400 == 0)) {
                total_days = 29;
             } else{
    	    total_days = 28;
             }
         }

         //-------------------------------------------------------------------
         // 일자 체크 : 각년월별로 총 날수가 맞는지 조사
         //-------------------------------------------------------------------
         if( ( 1 > day.value ) || ( day.value > total_days ) ) {
            ckFlg=1;
          }
          if(ckFlg) {
            alert ( "\n일자를 바르게 입력하세요."  );
            day.focus();
            day.select();
             return false;
            }

            //-----------------------------------------------------------
            // MM/DD 형식으로 입력해야 하지만,
            //  M 또는 D 형식으로 입력한 경우 앞에 0 추가
            //-------------------------------------------------------------
            if ( data2.length < 2 ) {
                 data2 = "0"+data2 ;
            }
            if ( data3.length < 2 ) {
                data3 = "0"+data3 ;
             }
            return true;

}

//-----------------------------------------------//
//*----- 관리자 사용 함수 (prefix : sub_ ) -----*//
//-----------------------------------------------//


//*--  한글의 길이 구하기 --*//
function sub_HanLen(argPos1, argPos2) {
	if(argPos2==0) return 0;
	var len=0;
	for(var i=0; i<argPos1.length; i++) {
		var str = "";
		str = escape(argPos1.charAt(i));
		if(str.length>3) len+=2;
		else len++;
	//	if(len==argPos2) break;
	}

	return (len);
}

/**
	파일 확장자 체크
	반드시 서버에서 다시확인해야함.
*/
function checkFileExt(obj,ext){
	var fileExt = obj.value.substr(obj.value.length-3,3);
	if(fileExt.toUpperCase() == ext.toUpperCase()) return true;
	else return false;
}

/**---------------------------------------------------------------------------
  주민번호 체크
  입력항목:
                 - preNoRes : 주민번호앞 6자리 필드
                 -postNoRes :주민번호뒤7자리필드
  ---------------------------------------------------------------------------*/
  function checkNoRes(arg){
    if (arg.length != 13){

        return false;
    } else {
        var str_serial1 = arg.substring(0,6);
        var str_serial2 = arg.substring(6,13);

        var digit=0;
        for (var i=0;i<str_serial1.length;i++){
            var str_dig=str_serial1.substring(i,i+1);
            if (str_dig<'0' || str_dig>'9'){
                digit=digit+1;
            }
        }

       if ((str_serial1 == '') || ( digit != 0 )){
            return false;
        }

        var digit1=0;
        for (var i=0;i<str_serial2.length;i++){
            var str_dig1=str_serial2.substring(i,i+1);
            if (str_dig1<'0' || str_dig1>'9'){
                digit1=digit1+1;
            }
        }

         if ((str_serial2 == '') || ( digit1 != 0 )){
            return false;
         }

         if (str_serial1.substring(2,3) > 1){
            return false;
         }

         if (str_serial1.substring(4,5) > 3){
            return false;
         }

         if (str_serial2.substring(0,1) > 4 || str_serial2.substring(0,1) == 0){
            return false;
         }

         var a1=str_serial1.substring(0,1);
         var a2=str_serial1.substring(1,2);
         var a3=str_serial1.substring(2,3);
          var a4=str_serial1.substring(3,4);
         var a5=str_serial1.substring(4,5);
          var a6=str_serial1.substring(5,6);

          var check_digit=a1*2+a2*3+a3*4+a4*5+a5*6+a6*7;

         var b1=str_serial2.substring(0,1);
         var b2=str_serial2.substring(1,2);
         var b3=str_serial2.substring(2,3);
         var b4=str_serial2.substring(3,4);
         var b5=str_serial2.substring(4,5);
         var b6=str_serial2.substring(5,6);
         var b7=str_serial2.substring(6,7);

         var check_digit=check_digit+b1*8+b2*9+b3*2+b4*3+b5*4+b6*5;

         check_digit = check_digit%11;
         check_digit = 11 - check_digit;
         check_digit = check_digit%10;

         if (check_digit != b7){
            return false;
         } else{
            // alert('올바른 주민등록 번호입니다.');
            return true;
        }
    }
}
	//----------------------------------------------------------------------
	// 메일체크
	// 성공 true, 실패 false
	//----------------------------------------------------------------------
	function chkEmail(str) {
		var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
		var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

		if ( r1.test(str) || !r2.test(str) ) {
			return false;
		}

		return true;
	}

	/**
	 * 체크박스 선택
	 * @param arg1 객체명
	 * @param arg2 선택여부
	 */
	function allCheckBox(arg1, arg2 ) {

		if (arg1 == undefined ) {
			return ;
		}
		var cnt = arg1.length ;
		if (cnt ==  undefined ) {
			arg1.checked =  arg2 ;
		} else {
			for ( var i = 0 ; i < cnt ; i++ ) {
				arg1[i].checked = arg2 ;
			}
		}
	}

	/**
	 * 체크박스 선택여부
	 * @param arg
	 * @returns {Boolean}
	 */
	function checkBoxSelected(arg) {
		if (arg == undefined ) {
			return false ;
		}
		var cnt = arg.length ;
		var result   = false ;
		if (cnt ==  undefined ) {
			if( arg.checked == true )  return  true;

		} else {
			for ( var i = 0 ; i < cnt ; i++ ) {
				if ( arg[i].checked == true ) return true ;
			}
		}

		return  false ;
	}

	/**
	 * 체크박스에 선택된 값
	 * @param arg
	 * @returns
	 */
	function optionBoxSelectedValue(arg) {
		if (arg == undefined ) {
			return "";
		}
		var cnt = arg.length ;
		var result  =  "" ;

		if (cnt ==  undefined ) {
			if( arg.checked == true )  return arg.value ;

		} else {
			for ( var i = 0 ; i < cnt ; i++ ) {

				if ( arg[i].checked == true )  return arg[i].value ;
			}
		}
		return "" ;
	}
	/**
	 * 체크박스에 선택된 갯수
	 * @param arg
	 * @returns {Number}
	 */
	function checkBoxSelectedCount(arg) {
		if (arg == undefined ) {
			return  0 ;
		}
		var len = arg.length ;

		var cnt = 0 ;
		if (len ==  undefined ) {
			if( arg.checked == true )   cnt  = cnt + 1 ;

		} else {
			for ( var i = 0 ; i < len ; i++ ) {
				if ( arg[i].checked == true ) {
					cnt = cnt + 1 ;
				}
			}
		}
		return cnt ;
	}

	/**
	 * 체크박스에 선택된 인덱스를 배열로 반환
	 * @param arg
	 * @returns
	 */
	function checkBoxSelectedIndex( arg ) {
		if (arg == undefined ) {
			return null  ;
		}
		cnt = checkBoxSelectedCount(arg) ;
		var arrIndex = new Array(cnt);
		var len = arg.length ;
		var index  = 0 ;
		if (len ==  undefined ) {
			if( arg.checked == true )  arrIndex[0] =  0 ;
		} else {
			for ( var i = 0 ; i < len ; i++ ) {
				if ( arg[i].checked == true )  {
					arrIndex[index] = i ;
					index = index + 1 ;
				}
			}
		}
		return arrIndex ;
	}

	/**
	 * 체크 박스에서 선택된 값을 배열로 반환
	 * @param arg
	 * @returns
	 */
	function checkBoxSelectedValue( arg ) {
		if (arg == undefined ) {
			return null  ;
		}
		cnt = checkBoxSelectedCount(arg) ;
		var arrValue = new Array(cnt);
		var len = arg.length ;
		var index  = 0 ;
		if (len ==  undefined ) {
			if( arg.checked == true )  arrValue[0] =  arg.value ;
		} else {
			for ( var i = 0 ; i < len ; i++ ) {
				if ( arg[i].checked == true )  {
					arrValue[index] = arg[i].value ;
					index = index + 1 ;
				}
			}
		}
		return arrValue ;
	}
	/**
	 *
	 * @param arg1
	 * @param arg2
	 * @returns
	 */
	function checkBoxSelectedValue2( arg1, arg2 ) {
		if (arg1 == undefined ) {
			return null  ;
		}
		cnt = checkBoxSelectedCount(arg1) ;
		var arrValue = new Array(cnt);
		var len = arg1.length ;
		var index  = 0 ;
		if (len ==  undefined ) {
			if( arg1.checked == true )  arrValue[0] =  arg2.value ;
		} else {
			for ( var i = 0 ; i < len ; i++ ) {
				if ( arg1[i].checked == true )  {
					arrValue[index] = arg2[i].value ;
					index = index + 1 ;
				}
			}
		}
		return arrValue ;
	}

	/**
	 * 배열여부
	 * @param arg
	 * @returns {Boolean}
	 */
	function isObjArray(arg) {
		var result = false ;
		try {
			if( arg.length  == undefined ) {
				result = false ;

			}else {
				result = true ;

			}
		}catch (E) {

			result = false;
		}

		return result ;
	}
//--- 현 시스템의 O/S(Windows) Version을 리턴한다.
function getAgent(){
	var KindAgent = navigator.userAgent;
	if(KindAgent.indexOf("Windows 95"))
		return("95");
	else if(KindAgent.indexOf("Windows 98"))
		return("98");
	else if(KindAgent.indexOf("Windows 2000"))
		return("2000");
}

//--- 웹 브라우저의 이름을 리턴한다.
function getNavigatorName(){
	return(navigator.appName);
}

//--- 웹 브라우저의 Version을 리턴한다.
function getNavigatorVer(){
	var ver  = parseInt(navigator.appVersion,10);
	return(ver);
}


	ie = document.all?1:0;

	function hL(E){
		if (ie){
			while (E.tagName!="TR"){E=E.parentElement;}
		}
		else{
			while (E.tagName!="TR"){E=E.parentNode;}
		}
		E.className = "H";
	}

	function dL(E){
		if (ie){
			while (E.tagName!="TR")	{E=E.parentElement;}
		}
		else{
			while (E.tagName!="TR")	{E=E.parentNode;}
		}
		E.className = "";
	}

/**
 * 체크박스 선택
 * @param checks
 * @param isCheck
 */
function checkAll(checks, isCheck){
	var fobj = document.getElementsByName(checks);
	var style = "";
	if(fobj == null) return;

  	if(fobj.length){
  		for(var i=0; i < fobj.length; i++){
  			if(fobj[i].disabled==false){
  				fobj[i].checked = isCheck;
  			}
  		}
  	}else{
  		if(fobj.disabled==false){
  			fobj.checked = isCheck;
  		}
  	}

}
	function openWindow(url,  width, height, strScroll ){
		var pop = "" ;
		windowX = Math.ceil( (window.screen.width  - width) / 2 );
		windowY = Math.ceil( (window.screen.height - height) / 2 );
		pop = window.open(url, "NeosMain", "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll);
		try {pop.focus(); } catch(e){}
		
	}
	function openWindow2(url,  windowName, width, height, strScroll, strResize ){

		var pop = "" ;
		windowX = Math.ceil( (window.screen.width  - width) / 2 );
		windowY = Math.ceil( (window.screen.height - height) / 2 );
		if(strResize == undefined || strResize == '') {
			strResize = 0 ;
		}
		pop = window.open(url, windowName, "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize);
		try {pop.focus(); } catch(e){}
		return pop;
	}
	function checkLength(maxlen, obj) {
		    var temp;
		    var msglen = maxlen*2;
		    var value  = obj.value;

		    var len =  obj.value.length;
		    var txt = "" ;

		    if (len == 0) {
		        value = maxlen*2;
		    } else  {
		        for(var k=0; k<len; k++) {
		            temp = value.charAt(k);
		            if (escape(temp).length > 4){
		                msglen -= 2;
		            } else {
		                msglen--;
		            }
		            if(msglen < 0) {
		               alert("영문은 "+(maxlen*2)+"자, 한글은 " + maxlen + "자 까지 입력할 수 있습니다.");
		                obj.value = txt;
		                break;
		            } else {
		                txt += temp;
		            };
		        };
		    };
		}
		function updateChar(length_limit, objname,tobj) {

			var length = calculate_msglen(tobj.value);
			if( objname != "" )
				document.getElementById(objname).innerText = length;
			if (length > length_limit) {
				alert("메세지는 최대  " + length_limit + "byte까지 입력 가능합니다.");
				tobj.value = tobj.value.replace(/\r\n$/, "");
				tobj.value = assert_msglen(tobj.value, length_limit,objname);
				length = calculate_msglen(tobj.value);
				if( objname != "" )
					document.getElementById(objname).innerText = length;
			}
		}
		function calculate_msglen(message) {
			var nbytes = 0;

        	for (var i=0; i<message.length; i++) {
            	var ch = message.charAt(i);
            	if (escape(ch).length > 4) {
                	nbytes += 2;
            	} else if (ch != '\r') {
                	nbytes++;
            	}
        	}
			return nbytes;
		}
		function assert_msglen(message, maximum,objname) {
			var inc = 0;
			var nbytes = 0;
			var msg = "";
			var msglen = message.length;

			for (var i=0; i<msglen; i++) {
				var ch = message.charAt(i);
				inc = 0 ;
				if (escape(ch).length > 4) {
					inc = 2;
				}else if(ch == '\n' ) {
					if (message.charAt(i-1) != '\r') {
						inc = 1;
					}

				}else {
					inc =  1;
				}
				if ((nbytes + inc) > maximum) {
					break;
				}
				nbytes += inc;
				msg += ch;
			}
			if(objname != "")
				document.getElementById(objname).innerText = nbytes;
			return msg;
		}
	function formSerialize(chkfrm){
		if(chkfrm==null) return "";
	 	var values="";
	 	chkFormElment = new Array();
		for(var i=0;i<chkfrm.length;i++){
			chkFormElment[chkFormElment.length]=chkfrm[i].name+"="+chkfrm[i].value;
		}
		values=chkFormElment.join('&');
		return values;
	}

	/**
	 *숫자여부
	 * @param arg
	 * @returns {Boolean}
	 */
	function isNumber(arg) {

		for(var i=0; i<arg.length; i++) {
			var chr = arg.substr(i, 1);
			if(chr < '0' || chr > '9') {
				return false;
			}
		}

		return true;
	}

	/**
	 * 포커스 자동이동
	 * @param nowID
	 * @param nextID
	 * @param autoLength
	 */
	function fncAutoFocus(nowID, nextID, autoLength) {
		var nowObjID = $("#" + nowID).val();
		var nextObjID = $("#" + nextID).val();

		if (nowObjID.length == autoLength) {
			$("#" + nextID).focus();
		}
	}

	/**
	 * 돈으로 변환
	 * @param data
	 * @param cipher
	 * @returns
	 */
    function getToPrice(data, cipher) {
    	if(data == null){
    		data = "0";
    	}
        var TempValue = data.toString();
        TempValue = TempValue.replace(/,/g, "");
        TempValue = parseInt(TempValue, 10);
        var sign = "";
        if(TempValue < 0){
        	sign = "-";
        	TempValue = Math.abs(TempValue);
        }

        if (isNaN(TempValue))
            return data;

        TempValue = TempValue.toString();
        var iLength = TempValue.length;

        if (iLength < 4)
            return data;

        if (cipher == undefined)
            cipher = 3;

        cipher = Number(cipher);
        count = iLength / cipher;

        var slice = new Array();

        for (var i = 0; i < count; i++)
        {
            if (i * cipher >= iLength) break;
            slice[i] = TempValue.slice((i + 1) * -cipher, iLength - (i * cipher));
        }

        var revslice = slice.reverse();

        return sign + revslice.join(',');
    }
	/**
	 * 엔터키 포함 여부
	 * @param str
	 * @returns {Boolean}
	 */
    function fc_isIncludeEnterKey(str) {
    	var strSplit = str.split("\r\n");
    	if(strSplit.length > 1) {
    		return true;
    	}
    	return false;
    }

    /**
     * 문서제목 제한 정규표현식
     */
    function getDocTitleExp() {
    	return ":";
    }

    /**
     * 기록물철 제목 제한 정규표현식
     */
    function getArchiveTitleExp() {
    	return "\"|'|<|>|~|!|@|#|%|&|{|}|/|-";
    }

    /**
     * 단위업무 제목 제한 정규표현식
     */
    function getWorkTitleExp() {
    	return "\"|'|<|>|~|!|@|#|%|&|{|}";
    }

    /**
     * 첨부제목 제한 정규표현식
     */
    function getAttachTitleExp() {
    	return "\"|'|<|>|~|!|@|#|%|&|{|}";
    }

    /**
     * 제한된 기호를 보여주기윈한 함수
     */
    function getExpKeyword(exp) {
    	var reg = /\|/g;
    	return exp.replace(reg,",");
    }

    /**
     * 문자열 html 제거
     * @param text
     * @returns
     */
    function removeHTML(text) {
        var objReg = new RegExp();  //  정규 표현식 객체를 생성한다
        objReg = /[<][^>]*[>]/gi;
         // <...> 태그를 대소문자 구분 없이[/gi 옵션](g=global / i=insensitive) 모두 찾는다.
         text= text.replace(objReg, "");
         return text;
    }

    function neosPopup(popType, param, popName) {
    	switch (popType) {
    		case 'POP_APPLINE' : //결재라인 보기
    			var uri = getContextPath()+"/edoc/eapproval/workflow/listApprovalLine.do?" +param ;
				openWindow2(uri,  "popDocApprovalLine", 730, 366, 0) ;
				break;
    		case 'POP_DOCWRITE' : //상신문서작성
				var uri = getContextPath()+"/edoc/eapproval/docCommonDrafWrite.do?" + param;
    			openWindow2(uri,  "popDocTemplate", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
				break;
    		case 'POP_DOCVIEW' : //상신문서보기
    		case 'POP_ONE_DOCVIEW' : //상신문서보기
    		case 'POP_DOCEDIT' : //상신문서수정
    			if(ncCom_Empty(popName)) {
    				popName = "popDocApprovalEdit";
    			}
    			if(popType == "POP_ONE_DOCVIEW") {
    				param= "multiViewYN=N&"+param;
    			}else {
    				param= "multiViewYN=Y&"+param;
    			}
				var uri = getContextPath()+"/edoc/eapproval/docCommonDraftView.do?"+ param;
				return openWindow2(uri,  popName,  _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
				break;
    		case 'POP_DOCREF' : //조문서보기
    			var firstDiKeyCode = $("#firstDiKeyCode").val();
    			param= "firstDiKeyCode="+firstDiKeyCode+"&"+param;
    			var uri = getContextPath()+"/edoc/eapproval/docCommonDraftView.do?"+ param;
    			return openWindow2(uri,  popName,  _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_DOCUSER' : //문서보기
    			if(ncCom_Empty(popName)) {
    				popName = "popDocApprovalEdit";
    			}
    			if(popType == "POP_ONE_DOCVIEW") {
    				param= "multiViewYN=N&"+param;
    			}else {
    				param= "multiViewYN=Y&"+param;
    			}
    			var uri = getContextPath()+"/edoc/eapproval/docCommonDraftUserView.do?"+ param;
    			openWindow2(uri,  popName,  _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_DOCCHARGE' : //문서보기
    			if(ncCom_Empty(popName)) {
    				popName = "popDocApprovalEdit";
    			}
    			if(popType == "POP_ONE_DOCVIEW") {
    				param= "multiViewYN=N&"+param;
    			}else {
    				param= "multiViewYN=Y&"+param;
    			}
    			var uri = getContextPath()+"/edoc/eapproval/docCommonDraftChargeView.do?"+ param;
    			openWindow2(uri,  popName,  _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_DOCCOPY' : //문서복사
				//var uri = "/edoc/eapproval/workflow/docApprovalCopyPopup.do?"+ param;
    			var uri = getContextPath()+"/edoc/eapproval/workflow/docReDraftViewPopup.do?"+ param;
				openWindow2(uri,  "popDocApprovalCopy",  200, 130, 0,0) ;
				break;
    		case 'POP_DOCEDITLIST' : //문서수정내역
				//var uri = "/edoc/eapproval/workflow/docApprovalCopyPopup.do?"+ param;
    			var uri = getContextPath()+"/edoc/eapproval/workflow/listMyOrderKuljaeLine.do?"+ param;
				openWindow2(uri,  "popDocEditList",  966, 430, 1,0) ;
				break;
    		case 'POP_HWPVIEW' : //hwp 파일 보기
				//var uri = "/edoc/eapproval/workflow/docApprovalCopyPopup.do?"+ param;
    			var uri = getContextPath()+"/edoc/eapproval/workflow/docApprovalView.do?"+ param;
				openWindow2(uri,  "popHwpView", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
				break;
    		case 'POP_ERP_EXPENSES' : //기안문서 호출
    			var uri =  getContextPath()+"/edoc/eapproval/workflow/docG20DraftWrite.do?"+ param;
    			openWindow2(uri,  "popHwpErpExpenses", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_COMMON_DRAFT' : //근태 , 휴가
    			var uri =  getContextPath()+"/edoc/eapproval/workflow/docCommonDrafWrite.do?"+ param;
    			openWindow2(uri,  "popHwpCommon",  _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_EDIT_VACATION' : //근태정보 수정
    			var uri =  getContextPath()+"/erp/g20/abdocu.do?"+ param;
    			openWindow2(uri,  "popEditErpExpenses",  968, 700, 0,0) ;
    			break;
    		case 'POP_EDIT_ERP_IU' : //KOFIA 예산회계정보 수정
    			var uri =  getContextPath()+"/kofia/ac/draftLoad.do?"+ param;
    			openWindow2(uri,  "popEditErpExpenses",  964, 670, 0,0) ;
    			break;
    		case 'POP_DOCLIST_DOWN': //
    			var uri =  getContextPath()+"/neos/edoc/document/record/board/common/DocListDown.do?"+ param;
				openWindow2(uri,  "popDocListDown",  335, 250, 0,0) ;
    			break;
    		case 'POP_OLD_DOCVIEW': //구문서함 조회시 기안 파일뷰어 
    			var uri = getContextPath()+"/neos/edoc/document/olddoc/board/common/OldDocFileViewPopup.do?"+ param;
				openWindow2(uri,  "popHwpView", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
				break;
    		case 'POP_OLD_DOCKAITVIEW': //구문서함 조회시 기안 파일뷰어 
    			var uri = getContextPath()+"/neos/edoc/document/olddoc/board/common/OldDocFileViewKAITPopup.do?"+ param;
    			openWindow2(uri,  "popHwpView", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
    			break;
    		case 'POP_OLD_HANDYDOCVIEW': //구핸디문서함 조회시 기안 파일뷰어 
    			var uri = getContextPath()+"/neos/edoc/document/olddoc/board/common/OldHandyDocFileViewPopup.do?"+ param;
				openWindow2(uri,  "popHwpView", _g_aproval_width_, _g_aproval_heigth_, 0,1) ;
				break;
    		case 'POP_OLD_APPLINE' : //결재라인 보기
    			var uri = getContextPath()+"/neos/edoc/document/olddoc/board/common/OldDocApprovalLineEx.do?" +param ;
				openWindow2(uri,  "popOldDocApprovalLine", 887, 346, 0) ;
				break;
    		case 'POP_MEMOSUBJECT_OPINION' : //메모의견정보
    			var uri = getContextPath()+"/memoreport/memoReportSubjectOpinionList.do?" +param ;
    			openWindow2(uri,  "popMemoSubjectOpinion", 960, 546, 0) ;
    			break;
    		case 'POP_MEMOREFER' : //메모참조대상자조회
    			var uri = getContextPath()+"/memoreport/memoReportReferForMemoReportList.do?" +param ;
    			openWindow2(uri,  "popMemoReportRefer",620, 546, 0) ;
    			break;
    		case 'POP_DEPT' : //부서정보   
    			var uri = getContextPath()+"/cmm/system/selectOrganDeptView.do?" +param ;
    			openWindow2(uri,  "popOrganDept", 290, 520, 0) ;
    			break;
    		case 'POP_MEMBERFORDEPT' : //사용자조회   
    			var uri = getContextPath()+"/cmm/system/selectMemberViewPopup.do?" +param+"&searchDept=Y" ;
    			openWindow2(uri,  "popOrganDept", 569, 550, 0) ;
    			break;
    		case 'POP_MEMBER' : //사용자조회   
    			var uri = getContextPath()+"/cmm/system/selectMemberViewPopup.do?" +param ;
    			openWindow2(uri,  "popMember", 290, 650, 0) ;
    			break;
    		case 'POP_WORKUNIT' : //단위업무조회   
    			var uri = getContextPath()+"/cmm/system/selectWorkcodeView.do?" +param ;
    			openWindow2(uri,  "popWorkUnit", 290, 520, 0) ;
    			break;
    		case 'POP_TAKEOVERRESULT' : //인계결과   
    			var uri = getContextPath()+"/archive/archiveTakeOverResultList.do" ;
    			openWindow2("",  "popTakeOverResult", 920, 520, 0) ;
    			frmPop.action = uri ;
    			frmPop.method = "post" ;
    			frmPop.target = "popTakeOverResult";
    			frmPop.submit();
    			frmPop.target = "";
    			$("idTakeOverResult").html("");
    			break;
    		case 'POP_RECORD_TAKEOVERRESULT' : //기록물인계결과   
    			var uri = getContextPath()+"/record/recordTakeOverResultList.do" ;
    			openWindow2("",  "popTakeOverResult", 920, 520, 0) ;
    			frmPop.action = uri ;
    			frmPop.method = "post" ;
    			frmPop.target = "popTakeOverResult";
    			frmPop.submit();
    			frmPop.target = "";
    			$("idTakeOverResult").html("");
    			break;
    		case 'POP_EDIT_ERP_EXPENSES' : //회계정보 수정
    			var uri =  param;
    			openWindow2(uri,  "popEditErpExpenses",  968, 700, 0,0) ;
    			break;
    		case 'POP_EMAILWRITE' : //이메일WRITE POPUP 
    			var uri = getContextPath()+"/getMailWriteLink.do?" +param ;
    			openWindow2(uri,  "popEmailWrite",  968, 700, 0,0) ;
    			break;
    		case 'POP_RESEARCH_BUDGET' : //연구관리 예산내역 보기
    			var uri = getContextPath()+"/koddi/cm/research/researchBudgetList.do?" +param ;
				openWindow2(uri,  "popResearchBudget", 887, 346, 0) ;
				break;
    		case 'POP_RESEARCHER_JOIN' : //연구관리 공동연구원 보기
    			var uri = getContextPath()+"/koddi/cm/research/researcherJoinList.do?" +param ;
				openWindow2(uri,  "popResearcherJoin", 887, 346, 0) ;
				break;
    	}
    }
NeosUtil.getLeftMenuWidth = function(){
	// edward ui 수정
	// 기존
	//left : 215 + 오른쪽 margin 여백 : 30
	//return 215  + 30;
	//  수정    /*+ 37 */
	//if($("#lnb_left").css("display")=="none"){

	var lnbLeft =$("#lnb_left").css("display");
	//alert('33  getLeftMenuWidth  lnbLeft : '+lnbLeft);
	if(lnbLeft ==undefined){//  frameset 사용시   ( frame page를 위해 )
		lnbLeft = $(top.document).find("#lnb_left").css("display");
	}
	//alert('$(top.document).find("#lnb_left").css("display") : '+$(top.document).find("#lnb_left").css("display"));
	//alert('$("#lnb_left").css("display") : '+$("#lnb_left").css("display"));

	if(lnbLeft=="none"){  //  frameset 사용시
		return 71;
	}
	else{
		return 281;
	}


};

NeosUtil.close = function(){
	window.open('', '_self', '');
	window.close();
};
//object -> a=a&c=c url 문자열 변경
NeosUtil.makeParam = function(obj){
	var arr = [];
	for(var item in obj){
		if(obj[item]){
			arr[arr.length] = encodeURIComponent(item.toString()) + "=" + encodeURIComponent(obj[item].toString());
		}
	}
	return arr.join("&");
};
NeosUtil.makeButonType01 = function(msg, fn, div_btn, id){
	/*if(!div_btn){
		div_btn = "div_btn";
	}
	if(!msg || !msg.length) return false;
	var html = "<ul style='display:inline'>";
	var btnArray = [];
	for(var i = 0;i< msg.length;i++){
		var tempHtml = "<li style='display:inline;padding-left:4px'>";
		if(fn && fn[i]){
			tempHtml+= "<a href='javascript:;' title='"+msg[i]+"' onclick='"+fn[i]+"' >"+msg[i]+"</a>";
		}
		else{
			tempHtml += "<a href='javascript:;' title='"+msg[i]+"' >"+msg[i]+"</a>";
		}
		tempHtml +="</li>";
		btnArray[btnArray.length] = tempHtml;
	}
	html +=btnArray.join(NeosUtil.makeButonType01_space());
	html += "</ul>";
	$("#" + div_btn).html(html);*/
	NeosUtil.makeButonType02(msg, fn, div_btn, id);
};
NeosUtil.makeButonType01_space = function(){
	var html = "";
	//html += "<span style='width:4px; display:block'></span>";
	return html;
};
NeosUtil.makeButonType02 = function(msg, fn, div_btn, id){
	if(!$.isArray(id)){
		id = [];
	}

	if(!div_btn){
		div_btn = "div_btn";
	}
	if(!msg /*|| !msg.length*/) return false;
	var html = "<div class='controll_btn ri_btn'>";
	var btnArray = [];
	for(var i = 0;i< msg.length;i++){
		var tempID = id[i] || "";
		var tempHtml = "";

		if(fn && fn[i]){
			tempHtml+= "<button type='button' id='"+tempID+"' class='btnArrow' href='javascript:;' onclick='"+fn[i]+"' title='"+msg[i]+"' style='margin-left:4px'><span>"+msg[i]+"</span></button>";
		}
		else{
			tempHtml += "<button type='button' id='"+tempID+"' class='btnArrow' href='javascript:;' title='"+msg[i]+"' ><span>"+msg[i]+"</span></button>";
		}
		btnArray[btnArray.length] = tempHtml;
	}
	html +=btnArray.join(NeosUtil.makeButonType02_space());
	html += "</div>";
	$("#" + div_btn).html(html);
};
NeosUtil.makeButonType02_space = function(){
	var html = "";
	//html += "<span style='margin-right:4px; '></span>";
	return html;
};
NeosUtil.openPopArchive = function(obj)
{
	var openUrl = getContextPath()+"/neos/edoc/eapproval/popup/SelectArchiveWithMyFavorite.do";
	var options = "width=630,height=607";
	var param = NeosUtil.makeParam(obj);//"method=RegistArchiveDocDispatch.SelectArchiveValueSet";
	var fullUrl = openUrl +"?" + param;
	var name = "SelectArchive";
	var SelectArchive = window.open(fullUrl, name, options);
	if(!SelectArchive){
		alert("<spring:message code='eaproval.pop.unlockPopup' />"/*팝업을 해제해 주세요.*/);
	}
};

NeosUtil.openPopArchive2 = function(obj)
{
	var openUrl = getContextPath()+"/neos/edoc/eapproval/popup/SelectArchiveReMove.do";
	var options = "width=630,height=607";
	var param = NeosUtil.makeParam(obj);//"method=RegistArchiveDocDispatch.SelectArchiveValueSet";
	var fullUrl = openUrl +"?" + param;
	var name = "SelectArchive";
	var SelectArchive = window.open(fullUrl, name, options);
	if(!SelectArchive){
		alert("<spring:message code='eaproval.pop.unlockPopup' />"/*팝업을 해제해 주세요.*/);
	}
};


NeosUtil.makeButonType03 = function(msg, fn, div_btn, id){
	if(!$.isArray(id)){
		id = [];
	}

	if(!div_btn){
		div_btn = "div_btn";
	}
	if(!msg /*|| !msg.length*/) return false;
	var html = "<div class='clearfx mT5'><p class='fR' >";
	var btnArray = [];
	for(var i = 0;i< msg.length;i++){
		var tempID = id[i] || "";
		var tempHtml = "";

		if(fn && fn[i]){
			tempHtml+= "<a id='"+tempID+"' class='btnArrow' href='javascript:;' onclick='"+fn[i]+"' title='"+msg[i]+"' style='margin-left:4px'><span>"+msg[i]+"</span></a>";
		}
		else{
			tempHtml += "<a id='"+tempID+"' class='btnArrow' href='javascript:;' title='"+msg[i]+"' ><span>"+msg[i]+"</span></a>";
		}
		btnArray[btnArray.length] = tempHtml;
	}
	html +=btnArray.join(NeosUtil.makeButonType02_space());
	html += "</p></div>";
	$("#" + div_btn).html(html);
};
/**
 *
 * @param strType : 공백: 대,소문자, 숫자, a: 소문자, A:대문자, a1:소문자+숫자, A1:대문자+숫자
 * @param strLength : 랜덤문자열 자리수
 * @returns
 */
function rndStr(strType, strLength) {
	var rndstr = new RndStr();
	rndstr.setType(strType);
	rndstr.setStr(strLength);
	return rndstr.getStr()  ;
}
function RndStr() {
	this.str = '';
	this.pattern = /^[a-zA-Z0-9]+$/;
	this.setStr =	function(n) {
						if(!/^[0-9]+$/.test(n)) n = 0x10;
						this.str = '';
						for(var i=0; i<n-1; i++) {
							this.rndchar();
						}

					};
	this.setType =  function(s) {
						switch(s) {
							case '1' : this.pattern = /^[0-9]+$/; break;
							case 'A' : this.pattern = /^[A-Z]+$/; break;
							case 'a' : this.pattern = /^[a-z]+$/; break;
							case 'A1' : this.pattern = /^[A-Z0-9]+$/; break;
							case 'a1' : this.pattern = /^[a-z0-9]+$/; break;
							default : this.pattern = /^[a-zA-Z0-9]+$/;

						}

					};
	this.getStr = function() {
		return this.str;
	};

	this.rndchar =  function() {
						var rnd = Math.round(Math.random() * 1000);
						if(!this.pattern.test(String.fromCharCode(rnd))) {
							this.rndchar();
						} else {
							this.str += String.fromCharCode(rnd);

						}

					};
};
function telePhoneParse(telNo) {
	var telNo1 = "" ;
	var arrTelNo = ["", "", ""];

	if(ncCom_Empty(telNo)) return "";

	telNo = ncCom_Replace(telNo, "-", "");

	if(ncCom_Empty(telNo)) return "";
	var count = telNo.length ;

	if(count < 9  ) {
		if( count == 2)  {
			arrTelNo[0] = telNo.substring(0, 2) ;
		}else if ( count  == 3 ) {
			arrTelNo[0] = telNo.substring(0, 3) ;
		}
	}else if (count == 9 ) {
		arrTelNo[0] = telNo.substring(0, 2) ;
		arrTelNo[1] = telNo.substring(2, 5) ;
		arrTelNo[2] = telNo.substring(5, 9) ;
	}else if (count == 10 ) {
		telNo1 = telNo.substring(0, 2) ;
		if(telNo1 == "02") {
			arrTelNo[0] = telNo.substring(0, 2) ;
			arrTelNo[1] = telNo.substring(2, 6) ;
			arrTelNo[2] = telNo.substring(6, 10) ;
		}else {
			arrTelNo[0] = telNo.substring(0, 3) ;
			arrTelNo[1] = telNo.substring(3, 6) ;
			arrTelNo[2] = telNo.substring(6, 10) ;
		}

	}else if (count == 11 ) {
		arrTelNo[0] = telNo.substring(0, 3) ;
		arrTelNo[1] = telNo.substring(3, 7) ;
		arrTelNo[2] = telNo.substring(7, 11) ;
	}else if (count == 12 ) {
		arrTelNo[0] = telNo.substring(0, 4) ;
		arrTelNo[1] = telNo.substring(4, 8) ;
		arrTelNo[2] = telNo.substring(8, 12) ;
	}
	return arrTelNo ;
}
function isMobile(telNo) {
	if( telNo == "011" || telNo == "017" || telNo == "016" || telNo == "019"  || telNo == "010" ) return  true ;
	return false ;


}
function getContextPath(){

    return _g_contextPath_;
}
//multiFile init
function initMultiFile(tabNumber) {

    $("#neosFile_"+tabNumber).MultiFile({
    	list : '#file-list_' + tabNumber,
        namePattern:'neosFile_'+tabNumber,
        STRING: {
            remove: "<img src= '"+_g_contextPath_ + "/images/portal/erp/ico_del.gif' alt = '삭제'/>"   //삭제 이미지아이콘으로도 바꿀수 있다(이미지 태그 넣으면 됨).
        }
     });
}

function shoutCutTitleChange(title){
	if($("#conHead").length)
	{
		$("#conHead").html("<h2>" + title + "</h2>");
	//	parent.conHeight();
	}
/*
	var articleArea =  $("#articleArea", parent.document);
	$("#conHead", articleArea).remove();

	if(!title){
		try {
			parent.resizeWindow();
		} catch (e) {
			try {
				parent.parent.resizeWindow();
			} catch (e) {
				var message = e.message.toString();
				try {
					console.log(message);
				} catch (e) {
					// TODO: handle exception
				}
			}
		}
		return false;
	}

	$.conHead = 0;
	var conHead = $("<div>").attr("id", "conHead").addClass("conHead");
	var shoutCutTitle = $("<h2>").attr("id", "shoutCutTitle");
	conHead.append(shoutCutTitle);
	conHead.insertBefore($("#contents", parent.document));

	$("#shoutCutTitle", parent.document).html(title);
	try {
		parent.resizeWindow();
	} catch (e) {
		try {
			parent.parent.resizeWindow();
		} catch (e) {
			var message = e.message.toString();
			try {
				console.log(message);
			} catch (e) {
				// TODO: handle exception
			}
		}
	}
*/
    /* title -  문서제목 설정 */
/*
    $(function(){
    	try {
			$("title", parent.document).html("NEOS- " + title);
		} catch (e) {
			try {
				console.log(e.message);
			} catch (e) {
				// TODO: handle exception
			}
		}
    });
*/
}

editorConfig = function( config, bodyID, height ) {
	config.docType = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
	//config.font_defaultLabel = 'Gulim';
	//config.font_names = 'Gulim/Gulim;Dotum/Dotum;Batang/Batang;Gungsuh/Gungsuh;Arial/Arial;Tahoma/Tahoma;Verdana/Verdana';
	config.fontSize_defaultLabel = '12px';
	config.fontSize_sizes = '8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';
	config.language = "ko";
	config.resize_enabled = false;
	config.enterMode = CKEDITOR.ENTER_P;
	config.shiftEnterMode = CKEDITOR.ENTER_P;
	config.startupFocus = true;
	//config.uiColor = '#EEEEEE';
	config.toolbarCanCollapse = false;
	config.menu_subMenuDelay = 0;
	//config.toolbar = [['Bold','Italic','Underline','Strike','-','Subscript','Superscript','-','TextColor','BGColor','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Link','Unlink','-','Find','Replace','SelectAll','RemoveFormat','-','Image','Flash','Table','SpecialChar'],'/',['Source','-','ShowBlocks','-','Font','FontSize','Undo','Redo','-','About']];
	config.bodyId =  bodyID;
	config.height = height;
    config.filebrowserUploadUrl = getContextPath()+'/edoc/eapproval/workflow/ckEditorImageUpload.do';
    config.filebrowserImageUploadUrl = getContextPath()+'/edoc/eapproval/workflow/ckEditorImageUpload.do';
};

/*월(2자리), 일(2자리), 시간(2자리), 초(2자리), 밀리초(3자리) 자리수 맞추기*/

NeosUtil.setNumTwo = function(num, isMilli)
{	var set = 2;
	if(isMilli)set = 3;
	var numStr = "" + num;
	if(numStr.length < set){
		if(!isMilli){
			return "0" + 	numStr;
		}
		else{
			if(("0" + 	numStr).length< set){
				return "00" + 	numStr;
			}else{
				return "0" + 	numStr;
			}
		}
	}
	else return numStr;
};
NeosUtil.getCalcImg = function(){
	return _g_contextPath_ + "/images/common/btn_callender.gif";
};


/**
 * @see 다중 사용자 선택을 지정해주는 팝업을 위한 함수
 * @param obj{root : root}
 * @author 김석환
 * @description
 * 

 1. 초기값 셋팅 함수 구현 예시
var getMultiSelectUser = function(obj){
	return {
			name : $("#joinUserNameList").val(), 
			id : $("#joinUserIDList").val(),
			dept : $("#joinUserDeptList").val()
		};
};

2. 팝업에서 사용자 리스트 받는 함수 구현 예시
var setMultiSelectUser = function(name, id, dept){
	$("#joinUserNameList").val(name);
	$("#joinUserIDList").val(id);
	$("#joinUserDeptList").val(dept);
};
3. 사용화면 : scheduleRegistry.jsp
 * 
 * */
NeosUtil.openMultiSelectUser = function(obj){
	var param = "";
	if(obj && typeof obj == "object" && obj.root && $.trim(obj.root)){
		param = NeosUtil.makeParam(obj);
	}
	var url =  _g_contextPath_ + "/cmm/popup/popMultiSelectUser.do?" + param; 
	var popup = window.open(url, "userSelect", 'toolbar=no, scrollbar=no, width=530, height=510, resizable=no, status=no');
	popup.focus();
};

/**
 * @see 다중 부서 선택을 지정해주는 팝업을 위한 함수
 * @param obj{root : root}
 * @author 김석환
 * @description
 * 

 1. 초기값 셋팅 함수 구현 예시
var getMultiSelectDept = function(obj){
	return {
			name : $("#joindeptListName").val(), 
			id : $("#joindeptListId").val()
		};
};

2. 팝업에서 부서 리스트 받는 함수 구현 예시
var setMultiSelectDept = function(name, id){
	$("#joindeptListName").val(name);
	$("#joindeptListId").val(id);
	
};
 * 
 * */
NeosUtil.openMultiSelectDept = function(obj){
	var param = "";
	if(obj && typeof obj == "object" && obj.root && $.trim(obj.root)){
		param = NeosUtil.makeParam(obj);
	}
	var url =  _g_contextPath_ + "/cmm/popup/popMultiSelectDept.do?" + param; 
	var popup = window.open(url, "userSelect", 'toolbar=no, scrollbar=no, width=530, height=510, resizable=no, status=no');
	popup.focus();
};

/**
 * @see 다중 사용자 선택을 지정해주는 팝업을 위한 함수(팀원, 부서원, 일반계약직, 일용계약직 제외)
 * 사용화면 : PimsAttendance.jsp
 * 2013.01.27 haxu sohn
*/
NeosUtil.openMultiSelectUser2 = function(obj){
	var param = "";
	if(obj && typeof obj == "object" && obj.root && $.trim(obj.root)){
		param = NeosUtil.makeParam(obj);
	}
	var url =  _g_contextPath_ + "/cmm/popup/popMultiSelectUser2.do?" + param; 
	var popup = window.open(url, "userSelect", 'toolbar=no, scrollbar=no, width=530, height=510, resizable=no, status=no');
	popup.focus();
};

/**
 * @param title  : 글자열
 * @param max_byte  : 최대글자열
 * @param last_word  : 자른뒤에 붙는 문자열
 * @return title  : 결과문자
 * @author 김성호
 * @description 
 * 
 * 
 * */
NeosUtil.disp_title  = function(title, max_byte, last_word){

    var title_len = title.length;  
    var title_byte = 0;
    var max_len = 0; 

    for(var i=0;i<title_len;i++){
        var one_char = title.charAt(i);   
        if(escape(one_char).length > 4){  //한글 
        	title_byte +=2;
        }else{  // 한글외
        	title_byte++; 
        }
        if(title_byte <= max_byte){
        	max_len = i + 1;
        }
    }

    // max_byte(제한길이)초과글 삭제, 연결문자열 추가
    if (parseInt(title_byte) > parseInt(max_byte)) {                     
    	title= title.substr(0, max_len)+last_word;          
    } 
    return title;
};

function textToHtmlConvert(strValue) {
	if(ncCom_Empty(strValue)) return "";
	strValue = ncCom_Replace(strValue, "&lt;", "<") ;
	strValue = ncCom_Replace(strValue, "&gt;", ">") ;
	strValue = ncCom_Replace(strValue, "&#40;", "(") ;
	strValue = ncCom_Replace(strValue, "&#41;", ")") ;
	strValue = ncCom_Replace(strValue, "&#39;", "'") ;
	strValue = ncCom_Replace(strValue, "&quot;", '"') ;
	strValue = ncCom_Replace(strValue, "&apos;", "'") ;
	strValue = ncCom_Replace(strValue, "<br>", "\r") ;
	strValue = ncCom_Replace(strValue, "<br/>", "\r") ;	
	strValue = ncCom_Replace(strValue, "&nbsp;", " ") ;
	return strValue ;
}
/**
 * os 체크 
 * @returns {String}
 */
function getOSInfoStr() {
    var ua = navigator.userAgent;

    if (ua.indexOf("NT 6.1") != -1) return "Windows 7";
    else if(ua.indexOf("NT 6.0") != -1) return "Windows Vista";
    else if(ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
    else if(ua.indexOf("NT 5.1") != -1) return "Windows XP";
    else if(ua.indexOf("NT 5.0") != -1) return "Windows 2000";
    else if(ua.indexOf("NT") != -1) return "Windows NT";
    else if(ua.indexOf("9x 4.90") != -1) return "Windows Me";
    else if(ua.indexOf("98") != -1) return "Windows 98";
    else if(ua.indexOf("95") != -1) return "Windows 95";
    else if(ua.indexOf("Win16") != -1) return "Windows 3.x";
    else if(ua.indexOf("Windows") != -1) return "Windows";
    else if(ua.indexOf("Linux") != -1) return "Linux";
    else if(ua.indexOf("Macintosh") != -1) return "Macintosh";
    else return "";
}

function localSaveFilePath() {
	var filePath = "";
	var osType = getOSInfoStr();
	if(osType == "Windows 7" || osType == "Windows Vista") {
		filePath = "C:\\Users\\Public\\Documents\\" ;
	}else if (osType == "Windows XP") {
		filePath = "C:\\Documents and Settings\\All Users\\Documents\\";
	}
	return filePath ;
}
/**
 * div dialog 가 필요할때 사용함
 * 작성자 : 김석환
 * 사용 : 
	$(window).resize(function(){
		NeosUtil.dialogStyleSet("id");
	});	
 * 참조페이지 : scheduleViewMonth.jsp
 * 
 */
NeosUtil.dialogStyleSet = function(id){
	$("#" + id)
	//.css("width", $("#contents").width()+15).css("height", $("#contents")
	.css("width", $("body").width()+15).css("height", $("body")
			.height()+15).addClass("erp-dialog-form-background")
	.css("position", "absolute")
	.css("left", "1px").css("top", "1px").css("zIndex", "700000").css("filter", "Alpha(Opacity=50)");	
}; 
  
/** IU 연동양식 TemplateKey 가져오기  **/
NeosUtil.getTemplateKey = function(childCode, detailCode, serviceName){

    var data = {childCode : childCode , detailCode :  detailCode , serviceName :  serviceName};
    var key = "";
    var opt = {
            type:"post",
            url:_g_contextPath_ + "/erp/iu/cmm/getTemplateKey.do",
            datatype:"json",
            data: data,
            async : false,
            success:function(data){
/*                if(data && data.result && data.result.C_TIKEYCODE){
                    key = data.result.C_TIKEYCODE;  
                }*/
            	
                if(data && data.result){
                    key = data.result; 
                }
            },
            error : function(e){
            }
        };
    $.ajax(opt); 
    
    return key;
};

function getFileSize(fileid) {
	try {
	    var fileSize = 0;
	    
	    if (navigator.userAgent.match(/msie/i)) {
	        //before making an object of ActiveXObject, 
	        //please make sure ActiveX is enabled in your IE browser
	    	
	    		    	
	        var objFSO = new ActiveXObject("Scripting.FileSystemObject"); 
	        var filePath = $("#" + fileid)[0].value;
	        var objFile = objFSO.getFile(filePath);
	        var fileSize = objFile.size; //size in kb
	        fileSize = fileSize / 1048576; //size in mb 
        
/*        
	    	var filePath = $("#" + fileid)[0].value;
	        var img = new Image();
	        img.dynsrc = filePath;
	        fileSize = img.fileSize ;        
	        fileSize = fileSize / 1048576; //size in m
*/	        
	        
	    }
	        //for FF, Safari, Opeara and Others
	    else {
	        fileSize = $("#" + fileid)[0].files[0].size //size in kb
	        fileSize = fileSize / 1048576; //size in mb 
	    }
	    fileSize =roundPrecision(fileSize,2);

	    return fileSize ;
	}
	catch (e) {
	    alert("Error is :" + e);
	}
}
function roundPrecision (val, precision) {
	 var p = Math.pow(10, precision);
	 return Math.round(val * p) / p;
}

