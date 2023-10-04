package com.duzon.custom.budget.controller;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.duzon.custom.budget.service.BudgetService;
import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.common.utiles.EgovUserDetailsHelper;

import bizbox.orgchart.service.vo.LoginVO;

/**
 * 
 * @title 예실대비 콘트롤러
 * @author 이철중
 * @since 2018. 05. 25
 * @version 1.0
 * @dscription
 *
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용
 * -----------  -------  --------------------------------
 * 2018. 05. 25   이철중         최초 생성
 *
 */

@Controller
@EnableScheduling
public class BudgetController {

	@Autowired
	private CommonService commonService;
	@Autowired
	private BudgetService budgetService;

	private static final Logger logger = (Logger) LoggerFactory.getLogger(BudgetController.class);
	
	/**
	 * @MethodName : resolutionPopup
	 * @author : jy
	 * @since : 2020. 4. 20 
	 * 설명 : 지출결의 보기 팝업
	 */
	@RequestMapping(value="/budget/resolutionPopup")
	public String resolutionPopup(Locale locale, Model model, HttpServletRequest servletRequest) {
		
		logger.info("/budget/resolutionPopup");
		
		try {
			LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser();
			
			model.addAttribute( "empSeq", loginVO.getUniqId());
		} catch (Exception e) {
			logger.info("ERROR :", e);
		}
		
		return "/budget/pop/viewResolutionPop";
	}
	
	@RequestMapping(value="/budget/loginHistory")
	public String loginHistory(Locale locale, Model model, HttpServletRequest servletRequest) {
		
		logger.info("/budget/loginHistory");
		
		try {
			LoginVO loginVO = EgovUserDetailsHelper.getAuthenticatedUser();
			
			model.addAttribute( "empSeq", loginVO.getUniqId());
		} catch (Exception e) {
			logger.info("ERROR :", e);
		}
		
		return "/budget/loginHistory";
	}
	
	/**
	 * @MethodName : selectLoginHistory
	 * @author : jy
	 * @since : 2020. 6. 10
	 * 설명 : 계정별 로그인 히스토리
	 */
	@RequestMapping(value="/budget/selectLoginHistory")
	@ResponseBody
	public Map<String, Object> selectLoginHistory(@RequestParam Map<String, Object> map, ModelMap model){
		
		logger.info("/budget/selectLoginHistory");
		
		try {
			
			map.put("loginHistoryList", budgetService.selectLoginHistory(map));
			
		} catch (Exception e) {
			logger.info("ERROR : ", e);
		}
		
		return map;
	}
	
}