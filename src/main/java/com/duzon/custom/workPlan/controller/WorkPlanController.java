package com.duzon.custom.workPlan.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.subHoliday.service.SubHolidayService;
import com.duzon.custom.workPlan.service.WorkPlanService;


@Controller
public class WorkPlanController {
	
	private static final Logger logger = LoggerFactory.getLogger(WorkPlanController.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private WorkPlanService workPlanService;
	
	@Autowired
	private SubHolidayService subHolidayService;
	
	/**
		 * @MethodName : workTypeAdmin
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 관리자 화면
		 */
	@RequestMapping(value= "/workPlan/workTypeAdmin")
	public String workTypeAdmin(Locale locale, Model model, HttpServletRequest servletRequest) {
		logger.info("workTypeAdmin");
		
		return "/workPlan/workTypeAdmin";
		
	}
	
	/**
		 * @MethodName : workTypeList
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 리스트
		 */
	@RequestMapping(value = "/workPlan/workTypeList")
	@ResponseBody
	public Map<String, Object> workTypeList(@RequestParam Map<String, Object> map){
		logger.info("workTypeList");		
		
		return workPlanService.workTypeList(map);
	}
	
	/**
		 * @MethodName : workTypeSave
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 저장
		 */
	@RequestMapping(value = "/workPlan/workTypeSave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workTypeSave(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workTypeSave");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		Map<String, Object> result = workPlanService.workTypeSave(map);
		return result;

	}	
	
	/**
		 * @MethodName : workTypeDel
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 삭제
		 */
	@RequestMapping(value = "/workPlan/workTypeDel", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> workTypeDel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workTypeDel");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		Map<String, Object> result = workPlanService.workTypeDel(map);
		return result;

	}
	
	/**
		 * @MethodName : workPlanUser
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 사용자 화면
		 */
	@RequestMapping(value = "/workPlan/workPlanUser", method = RequestMethod.GET)
	public String workPlanUser(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanUser");	
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> getHeader = commonService.getHeader(loginMap);
		Map<String, Object> master = subHolidayService.overHoliWorkSelect();
		Map<String, Object> workType = subHolidayService.getWorkTypeCode(loginMap);
		
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("workPlanType", workPlanService.getWorkPlanType());
		model.addAttribute("getHeader", getHeader);
		model.addAttribute("master", master);
		model.addAttribute("workType", workType);
		
		return "/workPlan/workPlanUser";
	}
	
	/**
		 * @MethodName : setDataSearch
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 데이터 조회
		 */
	@RequestMapping(value = "/workPlan/setDataSearch", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> setDataSearch(@RequestParam Map<String, Object> map) {
		logger.info("setDataSearch");	
		
		
		return workPlanService.setDataSearch(map);
		
	}
	
	/**
		 * @MethodName : workPlanUserSave
		 * @author : gato
		 * @since : 2019. 2. 7.
		 * 설명 : 유연근무 신청
		 */
	@RequestMapping(value = "/workPlan/workPlanUserSave", method = RequestMethod.POST)
	@ResponseBody
	public void workPlanUserSave(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanUserSave");	
		
		map.putAll(commonService.commonGetEmpInfo(servletRequest));
		
		workPlanService.workPlanUserSave(map);
		
	}
	
	/**
		 * @MethodName : workPlanReqAdmin
		 * @author : gato
		 * @since : 2019. 2. 7.
		 * 설명 : 유연근무 신청 승인 화면
		 */
	@RequestMapping(value = "/workPlan/workPlanReqAdmin", method = RequestMethod.GET)
	public String workPlanReqAdmin(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanReqAdmin");	
		
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		model.addAttribute("workPlanType", workPlanService.getWorkPlanType());
		int isAdmin = subHolidayService.getAllAdmin(commonService.commonGetEmpInfo(servletRequest));
		String admin_yn = "N";
		if(isAdmin > 0) {
			admin_yn = "Y";
		}
		model.addAttribute("admin_yn", admin_yn);
		return "/workPlan/workPlanReqAdmin";
	}
	
	/**
		 * @MethodName : workPlanAppList
		 * @author : gato
		 * @since : 2019. 2. 7.
		 * 설명 : 유연근무 승인 대기 리스트
		 */
	@RequestMapping(value = "/workPlan/workPlanAppList")
	@ResponseBody
	public Map<String, Object> workPlanAppList(@RequestParam Map<String, Object> map){
		logger.info("workPlanAppList");		
		
		return workPlanService.workPlanAppList(map);
	}
	
	@RequestMapping(value = "/workPlan/workPlanApproval", method = RequestMethod.POST)
	@ResponseBody
	public String workPlanApproval(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workPlanApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		workPlanService.workPlanApproval(map);
		
		
		return "/workPlan/workPlanReqAdmin";
	}
	
	@RequestMapping(value = "/workPlan/workPlanAppCancel", method = RequestMethod.POST)
	@ResponseBody
	public String workPlanAppCancel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("workPlanAppCancel");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		workPlanService.workPlanAppCancel(map);
		
		return "ok";
	}
	
	@RequestMapping(value = "/workPlan/workTypeCodeList")
	@ResponseBody
	public Map<String, Object> workTypeCodeList(@RequestParam Map<String, Object> map){
		logger.info("workTypeCodeList");		
		
		return workPlanService.workTypeCodeList(map);
	}
	
	@RequestMapping(value = "/workPlan/workPlanChange", method = RequestMethod.POST)
	@ResponseBody
	public String workPlanChange(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workPlanChange");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		workPlanService.workPlanChange(map);
		
		
		return "/workPlan/workPlanUser";
	}
	
	@RequestMapping(value = "/workPlan/workPlanChangeAdmin", method = RequestMethod.GET)
	public String workPlanChangeAdmin(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanChangeAdmin");	
		
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		model.addAttribute("workPlanType", workPlanService.getWorkPlanType());
		model.addAttribute("getAdminSeq", workPlanService.getAdminSeq());
		int isAdmin = subHolidayService.getAllAdmin(commonService.commonGetEmpInfo(servletRequest));
		String admin_yn = "N";
		if(isAdmin > 0) {
			admin_yn = "Y";
		}
		model.addAttribute("admin_yn", admin_yn);
		
		return "/workPlan/workPlanChangeAdmin";
	}
	
	@RequestMapping(value = "/workPlan/workPlanChangeAppList")
	@ResponseBody
	public Map<String, Object> workPlanChangeAppList(@RequestParam Map<String, Object> map){
		logger.info("workPlanChangeAppList");		
		
		return workPlanService.workPlanChangeAppList(map);
	}
	
	@RequestMapping(value = "/workPlan/workPlanChangeAppList2")
	@ResponseBody
	public Map<String, Object> workPlanChangeAppList2(@RequestParam Map<String, Object> map){
		logger.info("workPlanChangeAppList2");		
		
		return workPlanService.workPlanChangeAppList2(map);
	}
	
	@RequestMapping(value = "/workPlan/workPlanChangeCancel", method = RequestMethod.POST)
	@ResponseBody
	public String workPlanChangeCancel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workPlanChangeCancel");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		workPlanService.workPlanChangeCancel(map);
		
		
		return "/workPlan/workPlanUser";
	}
	
	@RequestMapping(value = "/workPlan/workPlanChangeApproval", method = RequestMethod.POST)
	@ResponseBody
	public String workPlanChangeApproval(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workPlanChangeApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		workPlanService.workPlanChangeApproval(map);
		
		
		return "/workPlan/workPlanChangeAdmin";
	}
	
	@RequestMapping(value = "/workPlan/adminWorkPlanDetail")
	@ResponseBody
	public Map<String, Object> adminWorkPlanDetail(@RequestParam Map<String, Object> map){
		logger.info("adminWorkPlanDetail");		
		
		return workPlanService.adminWorkPlanDetail(map);
	}
	
	@RequestMapping(value = "/workPlan/adminWorkPlanDetail2")
	@ResponseBody
	public Map<String, Object> adminWorkPlanDetail2(@RequestParam Map<String, Object> map){
		logger.info("adminWorkPlanDetail2");		
		
		return workPlanService.adminWorkPlanDetail2(map);
	}
	
	@RequestMapping(value = "/workPlan/workPlanListView", method = RequestMethod.GET)
	public String workPlanListView(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanListView");	
		
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		model.addAttribute("workPlanType", workPlanService.getWorkPlanType());
		
		return "/workPlan/workPlanListView";
	}
	
	@RequestMapping(value = "/workPlan/workPlanListPrivateView", method = RequestMethod.GET)
	public String workPlanListPrivateView(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("workPlanListPrivateView");	
		
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		model.addAttribute("workPlanType", workPlanService.getWorkPlanType());
		
		return "/workPlan/workPlanListPrivateView";
	}
	
	@RequestMapping(value = "/workPlan/workPlanMasterList")
	@ResponseBody
	public Map<String, Object> workPlanMasterList(@RequestParam Map<String, Object> map){
		logger.info("workPlanMasterList");		
		
		return workPlanService.workPlanMasterList(map);
	}
	
	@RequestMapping(value= "/workPlan/dayOfFamilyAdmin")
	public String dayOfFamilyAdmin(Locale locale, Model model, HttpServletRequest servletRequest) {
		logger.info("dayOfFamilyAdmin");
		
		return "/workPlan/dayOfFamilyAdmin";
		
	}
	
	@RequestMapping(value = "/workPlan/dayOfFamilyList")
	@ResponseBody
	public Map<String, Object> dayOfFamilyList(@RequestParam Map<String, Object> map){
		logger.info("dayOfFamilyList");		
		
		return workPlanService.dayOfFamilyList(map);
	}
	
	@RequestMapping(value = "/workPlan/dayOfFamilyApply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> dayOfFamilyApply(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("dayOfFamilyApply");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		Map<String, Object> result = workPlanService.dayOfFamilyApply(map);
		return result;

	}
	
	@RequestMapping(value = "/workPlan/workPlanCancel", method = RequestMethod.POST)
	@ResponseBody
	public void workPlanCancel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("workPlanCancel");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		workPlanService.workPlanCancel(map);

	}
	
	@RequestMapping(value = "/workPlan/familyDayReqLeftList")
	@ResponseBody
	public Map<String, Object> familyDayReqLeftList(@RequestParam Map<String, Object> map){
		logger.info("familyDayReqLeftList");		
		
		return workPlanService.familyDayReqLeftList(map);
	}
	
	@RequestMapping(value = "/workPlan/familyDayReqRightList")
	@ResponseBody
	public Map<String, Object> familyDayReqRightList(@RequestParam Map<String, Object> map){
		logger.info("familyDayReqRightList");		
		
		return workPlanService.familyDayReqRightList(map);
	}
	
	@RequestMapping(value = "/workPlan/getMonthLimit")
	@ResponseBody
	public Map<String, Object> getMonthLimit(@RequestParam Map<String, Object> map){
		logger.info("getMonthLimit");		
		
		return workPlanService.getMonthLimit(map);
	}
	
	@RequestMapping(value = "/workPlan/getWorkMin")
	@ResponseBody
	public Map<String, Object> getWorkMin(@RequestParam Map<String, Object> map){
		logger.info("getWorkMin");		
		
		return workPlanService.getWorkMin(map);
	}
	
	@RequestMapping(value = "/workPlan/getWorkPlanMin")
	@ResponseBody
	public Map<String, Object> getWorkPlanMin(@RequestParam Map<String, Object> map){
		logger.info("getWorkPlanMin");		
		
		return workPlanService.getWorkPlanMin(map);
	}
	
	@RequestMapping(value = "/workPlan/defaultMod", method = RequestMethod.POST)
	@ResponseBody
	public void defaultMod(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("defaultMod");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		workPlanService.defaultMod(map);

	}
	
	@RequestMapping("/workPlan/getWeekNo")
	@ResponseBody
	public Map<String, Object> getWeekNo(@RequestParam Map<String, Object> map){
		logger.info("getWeekNo");
		return workPlanService.getWeekNo(map);
	}
	
	@RequestMapping("/workPlan/checkFlexPlan")
	@ResponseBody
	public Map<String, Object> checkFlexPlan(@RequestParam Map<String, Object> map){
		logger.info("checkFlexPlan");
		return workPlanService.checkFlexPlan(map);
	}

	@RequestMapping("/workPlan/workPlanExcelList")
	public String workPlanExcelList(@RequestParam Map<String, Object> map, Map<String, Object> modelMap) {
		logger.info("workPlanExcelList");
		List<Map<String, Object>> excelList = workPlanService.workPlanExcelList(map);
		modelMap.put("excelList", excelList);
		modelMap.put("excelType", map.get("startDt") + "_" + map.get("endDt") + "_유연근무신청목록");
		return "workPlanExcelList";
	}
	
	@RequestMapping(value = "/workPlan/scheduleList")
	@ResponseBody
	public Map<String, Object> scheduleList(@RequestParam Map<String, Object> map){
		logger.info("scheduleList");
		return workPlanService.scheduleList(map);
	}
	
	@RequestMapping(value = "/workPlan/scheduleAdmin", method = RequestMethod.GET)
	public String scheduleAdmin(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("scheduleAdmin");	
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/workPlan/scheduleAdmin";
	}
	
	@RequestMapping(value = "/workPlan/scheduleDept", method = RequestMethod.GET)
	public String scheduleDept(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("scheduleDept");	
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/workPlan/scheduleDept";
	}
	
	@RequestMapping(value = "/workPlan/scheduleUser", method = RequestMethod.GET)
	public String scheduleUser(Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("scheduleUser");	
		model.addAttribute("userInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/workPlan/scheduleUser";
	}
}
