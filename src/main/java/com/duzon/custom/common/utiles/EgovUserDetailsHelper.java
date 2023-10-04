package com.duzon.custom.common.utiles;

import java.net.InetAddress;
import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import bizbox.orgchart.service.vo.LoginVO;

public class EgovUserDetailsHelper {
	
	public static LoginVO getAuthenticatedUser(){
		
		ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = attr.getRequest();
		LoginVO loginVo = (LoginVO) request.getSession(true).getAttribute("loginVO");
		if(loginVo != null){
			return loginVo;
		}
		String serverName = request.getServerName();
        System.out.println ( "serverName =>"  + serverName ) ;
        if(serverName.indexOf("localhost") > -1 || serverName.indexOf("127.0.0.1") > -1 || serverName.indexOf("1.233.95.140") > -1) {
        	loginVo = new LoginVO();
        	loginVo = new bizbox.orgchart.service.vo.LoginVO();
			loginVo.setGroupSeq("klti");
			loginVo.setCompSeq("1000");
			//loginVo.setCompSeq("10163");
			loginVo.setOrganId("1000");
			loginVo.setBizSeq("1000");
			loginVo.setOrgnztId("1010");
			loginVo.setOrgnztNm("시스템관리"); //시스템관리
/*			loginVo.setDept_seq("100000001"); //100000001 //10163197 //10163197 국제교류팀
			//loginVo.setDept_seq("10163192");
			loginVo.setUniqId("000000");//000000 //200912 //100000177 //200913(채혜진)
			//loginVo.setUniqId("100000167"); //채혜진
			//loginVo.setUniqId("201113");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("관리자");	//관리자
			//loginVo.setName("한경아");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A03"); // 직급
			loginVo.setPositionNm("2급");
			loginVo.setClassCode("A02"); // 직책
			loginVo.setClassNm("본부장");*/
			loginVo.setAuthorCode("ERP_PAYDATA#ERP_SPEND");

			loginVo.setDept_seq("100000001");
			loginVo.setUniqId("000000");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("관리자");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A11"); // 직급
			loginVo.setPositionNm("팀공유");
			loginVo.setClassCode("A07"); // 직책
			loginVo.setClassNm("과장");

			/*loginVo.setDept_seq("100000001");
			loginVo.setUniqId("200879");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("백지수");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A05"); // 직급
			loginVo.setPositionNm("4급");
			loginVo.setClassCode("A04"); // 직책
			loginVo.setClassNm("팀장");*/

			/*loginVo.setDept_seq("100000001");
			loginVo.setUniqId("200896");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("이민아");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A04"); // 직급
			loginVo.setPositionNm("3급");
			loginVo.setClassCode("A04"); // 직책
			loginVo.setClassNm("팀장");*/


			/*loginVo.setDept_seq("100000001");
			loginVo.setUniqId("100000115");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("전정인");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A06"); // 직급
			loginVo.setPositionNm("5급");
			loginVo.setClassCode("A09"); // 직책
			loginVo.setClassNm("사원");*/

/*			loginVo.setDept_seq("100000024");
			loginVo.setUniqId("100000082");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("곽효환");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A01"); // 직급
			loginVo.setPositionNm("원장");
			loginVo.setClassCode("A01"); // 직책
			loginVo.setClassNm("원장");*/

/*			loginVo.setDept_seq("10163187");
			loginVo.setUniqId("201106");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("이경섭");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A06"); // 직급
			loginVo.setPositionNm("5급");
			loginVo.setClassCode("A12"); // 직책
			loginVo.setClassNm("주임");*/

			/*loginVo.setDept_seq("100000101");
			loginVo.setUniqId("100000157");
			loginVo.setLangCode("kr");
			loginVo.setUserSe("ADMIN");
			loginVo.setErpEmpCd("2017051501");
			loginVo.setErpCoCd("2018");
			loginVo.setEaType("ea");
			loginVo.setEmail("devjitsu");
			loginVo.setEmailDomain("st-tech.org");
			loginVo.setId("admin");//admin
			loginVo.setName("한경아");
			loginVo.setOrganNm("한국문학번역원");
			loginVo.setPositionCode("A13"); // 직급
			loginVo.setPositionNm("5급");
			loginVo.setClassCode("A14"); // 직책
			loginVo.setClassNm("전임의교원");*/


		}
        if(loginVo.getIp() == null || "".equals(loginVo.getIp())) {
        	loginVo.setIp(request.getHeader("X-FORWARDED-FOR"));
        }
        if(loginVo.getIp() == null || "".equals(loginVo.getIp())) {
        	loginVo.setIp(request.getRemoteAddr());
        }
        if(loginVo.getIp() == null || "".equals(loginVo.getIp())) {
        	try {
				loginVo.setIp(InetAddress.getLocalHost().getHostAddress());
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
		return loginVo;
	}
}
