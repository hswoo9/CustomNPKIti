package com.duzon.custom.main.controller;

import java.util.Locale;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.duzon.custom.common.service.CommonService;

/**
 * 기본 레이아웃 입니다.
 * 
 * -----------------------
 *   GNB(defaultTop)
 * -----------------------
 *     |
 *     |
 * LNG |   Iframe(defaultIframe)
 *     |
 *     |
 *     
 * @author iguns
 *
 */
@Controller
public class LayoutController {
	
	private static final Logger logger = LoggerFactory.getLogger(LayoutController.class);
	@Autowired private CommonService commonService;
	
	@RequestMapping(value = "/layout/defaultIframe")
	public String defaultIframe(Locale locale, Model model) {
		logger.info("Welcome defaultIframe! The client locale is {}.", locale);
		
		
		return "/layout/defaultIframe";
	}
	
	@RequestMapping(value = "/layout/defaultIframeMailSso")
	public String defaultIframeMailSso(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome defaultIframeMailSso! The client locale is {}.", locale);
		model.addAttribute("empInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/layout/defaultIframeMailSso";
	}
	
	@RequestMapping(value = "/layout/defaultIframeReqList")
	public String defaultIframeReqList(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome defaultIframeMailSso! The client locale is {}.", locale);
		model.addAttribute("empInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/layout/defaultIframeReqList";
	}
	
	@RequestMapping(value = "/layout/defaultTop")
	public String defaultTop(Locale locale, Model model) {
		logger.info("Welcome defaultTop! The client locale is {}.", locale);
		
		
		return "/layout/defaultTop";
	}
	
	@RequestMapping(value = "/layout/defaultLeft")
	public String defaultLeft(Locale locale, Model model) {
		logger.info("Welcome defaultLeft! The client locale is {}.", locale);
		
		
		return "/layout/defaultLeft";
	}
	
}
