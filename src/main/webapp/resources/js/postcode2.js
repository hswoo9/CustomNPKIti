/**  
 * 다음 지도
 * onclick="fnZipPop(this);"
 * return input tag id = POST_CD, ADDR_M, ADDR_D / 우편번호, 주소, 상세주소
 **/

if(window.location.protocol.indexOf("https:") > -1)
	document.write("<script src='https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js'><"+"/script>");		
else
	document.write("<script src='http://dmaps.daum.net/map_js_init/postcode.v2.js'><"+"/script>");

function fnZipPop2(target) {
    new daum.Postcode({
        oncomplete: function(data) {
        	
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            if(target.id == "btnCompZip"){
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('deptZipCode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('deptAddr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('deptDetailAddr').focus();
            }
            else{
            	// 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('POST_CD2').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('ADDR_M2').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('ADDR_D2').focus();
            }
        }
    }).open();

}