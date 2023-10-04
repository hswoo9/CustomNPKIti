package com.duzon.custom.egov_cms.controller;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.duzon.custom.common.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;

import java.util.Map;

@Controller
@RequestMapping("/other/online")
public class OnlineController {
	
	private static final Logger logger = LoggerFactory.getLogger(OnlineController.class);
	@Autowired
	private CommonService commonService;

	/**
	 * 외출 신청 전자결재 신청 팝업
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/vacationPop.do")
	public String vacationPop(HttpServletRequest request, HttpServletResponse response, Model model) throws NoPermissionException {
		LoginVO loginVo = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		//model.addAttribute("loginVO", commonService.commonGetEmpInfo(request));
		System.out.println("a =? " + loginVo);
		model.addAttribute("loginVO", loginVo);

		Map<String, Object> empInfo = commonService.commonGetEmpInfo(request);
		model.addAttribute("empInfo", empInfo);

		return "/enrollment/popup/vacationPop";
	}
	
	
}
