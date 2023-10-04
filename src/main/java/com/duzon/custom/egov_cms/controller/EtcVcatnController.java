package com.duzon.custom.egov_cms.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.service.EtcVcatnService;

@Controller
@RequestMapping("/etc")
public class EtcVcatnController {
	
	private static final Logger logger = LoggerFactory.getLogger(EtcVcatnController.class);
	
	@Autowired
	private EtcVcatnService etcVcatnService;

	/**
     * 기타 휴가 설정
     * @param params
     * @param model
     * @return
     */
	@RequestMapping("/specialVacSetEtc")
	public String specialVacSetEtc(@RequestParam Map<String, Object> params, Model model) {
		return "/enrollment/specialVacSetEtc";
	}

	/**
	 * 특별 휴가 등록된 리스트 불러오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/etcVacSetList")
	public String etcVacSetList(@RequestParam Map<String, Object> params, Model model){
		model.addAttribute("rs", etcVcatnService.etcVacSetList());
		return "jsonData";
	}

	/**
	 * 기타휴가 코드 불러오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/etcVacCode")
	public String etcVacCode(@RequestParam Map<String, Object> params, Model model){

		List<VcatnKndDTO> vcatnKndDTOs = new ArrayList<>();
		vcatnKndDTOs = etcVcatnService.etcVacCode(params);

		model.addAttribute("rs", vcatnKndDTOs);

		return "jsonData";
	}

	/**
     * 기타휴가생성
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/specialVacCrEtc")
	public String specialVacCrEtc(@RequestParam Map<String, Object> params, Model model) {
		return "/enrollment/specialVacCrEtc";
	}

	/** 특별휴가 리스트 조회
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/getEtcVcatnList")
	public String getEtcVcatnList(@RequestParam Map<String, Object> params, Model model){
		model.addAttribute("list", etcVcatnService.getEtcVcatnList(params));
		return "jsonData";
	}

	/**
     * 장기근속휴가(유효기간)
     * @param params
     * @param model
     * @return
     */
	@RequestMapping("/etcJsp")
	public String etcJsp(@RequestParam Map<String, Object> params, Model model) {
		return "/enrollment/etcJsp";
	}

	/**
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/etc1")
	public String etc1(@RequestParam Map<String, Object> params, Model model){
		etcVcatnService.etc1(params);
		return "jsonData";
	}

	/**
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/etc2")
	public String etc2(@RequestParam Map<String, Object> params, Model model){
		etcVcatnService.etc2(params);
		return "jsonData";
	}
}
