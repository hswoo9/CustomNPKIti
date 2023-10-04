package com.duzon.custom.egov_cms.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.duzon.custom.egov_cms.dto.LnglbcCnwkVcatnSetupDTO;
import com.duzon.custom.egov_cms.service.LongVacSetService;


@Controller
@RequestMapping("/longVacSet")
public class LongVacSetController {
	
	private static final Logger logger = LoggerFactory.getLogger(LongVacSetController.class);
	
	@Autowired
	private LongVacSetService longVacSetService;

	/**
	 * 장기근속휴가 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/longVacSet.do")
	public String specialVacCr(HttpServletRequest request, Model model) {
		return "/enrollment/longVacSet";
	}

	/**
	 * 장기근속휴가설정 리스트
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/longVacSetList")
	public String longVacSetList(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		model.addAttribute("list", longVacSetService.longVacSetList(params));
		return "jsonData";
	}

	/**
	 * 장기근속휴가설정 저장
	 * @param lnglbcCnwkVcatnSetupDTO
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/longVacSetSave")
	public String longVacSetSave(LnglbcCnwkVcatnSetupDTO lnglbcCnwkVcatnSetupDTO, @RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		model.addAttribute("result", longVacSetService.longVacSetSave(lnglbcCnwkVcatnSetupDTO, params));
		return "jsonData";
	}

	/**
	 * 장기근속휴가 등록 리스트 가져오기
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/getLongVacSet")
	public String getLongVacSet(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		model.addAttribute("object", longVacSetService.getLongVacSet(params));
		return "jsonData";
	}

	/**
	 * 장기근속휴가 일괄 저장
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/makeLongVac")
	public String makeLongVac(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			model.addAttribute("object", longVacSetService.makeLongVac(params));
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}
		return "jsonData";
	}
}
