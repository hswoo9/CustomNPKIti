package egovframework.com.cmm.util;

import java.net.InetAddress;

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
            //loginVo.setCompSeq("1000");
            loginVo.setCompSeq("10163");
            loginVo.setOrganId("1000");
            loginVo.setBizSeq("1000");
            loginVo.setOrgnztId("1010");
            loginVo.setOrgnztNm("시스템관리");
            loginVo.setDept_seq("100000001");
            loginVo.setUniqId("000000");//000000
            //loginVo.setUniqId("201113");
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
            loginVo.setPositionNm("6급");
            loginVo.setClassCode("A07"); // 직책
            loginVo.setClassNm("과장");
            loginVo.setAuthorCode("ERP_PAYDATA#ERP_SPEND");
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
