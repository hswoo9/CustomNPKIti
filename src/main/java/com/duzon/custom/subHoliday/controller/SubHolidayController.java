package com.duzon.custom.subHoliday.controller;

import java.net.UnknownHostException;
import java.time.LocalDate;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.subHoliday.service.SubHolidayService;
import com.duzon.custom.workPlan.service.WorkPlanService;

@Controller
public class SubHolidayController {
	private static final Logger logger = LoggerFactory.getLogger(SubHolidayController.class);
	
	@Autowired private SubHolidayService subHolidayService;
	@Autowired private CommonService commonService;
	@Autowired private WorkPlanService workPlanService;
	/**
	 * @MethodName : overWkAdmin
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 23.
	 * @Detail     : 시간외/휴일근무 설정 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/overWkAdmin", method = RequestMethod.GET)
	public String overWkAdmin(Locale locale, Model model,HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		model.addAttribute("empInfo", commonService.commonGetEmpInfo(servletRequest));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_code", "WORK_TYPE");
		model.addAttribute("workType", subHolidayService.getCommCodeList(map));
		return "/subHoliday/overWkAdmin";
	}
	
	/**
	 * @MethodName : overHoliWorkSelect
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 시간외근무 마스터 데이터 불러오기
	 */
	@RequestMapping("/subHoliday/overHoliWorkSelect")
	@ResponseBody
	public Map<String, Object> overHoliWorkSelect(){
		logger.info("overHoliWorkSelect");
		Map<String, Object> resultMap = subHolidayService.overHoliWorkSelect();
		return resultMap;
	}
	
	/**
	 * @MethodName : overHoliWorkUpdate
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 시간외근무 마스터 데이터 업데이트
	 */
	@RequestMapping(value = "/subHoliday/overHoliWorkUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> overHoliWorkUpdate(@RequestParam Map<String, Object> map){
		logger.info("overHoliWorkUpdate");
		int n = subHolidayService.overHoliWorkUpdate(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : empInformationAdmit
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 사원리스트 팝업
	 */
	@RequestMapping("/subHoliday/empInformationAdmitList")
	@ResponseBody
	public Map<String, Object> empInformationAdmit(@RequestParam Map<String, Object> map){
		logger.info("empInformationAdmitList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.empInformationAdmitList(map));
		resultMap.put("totalCount", subHolidayService.empInformationAdmitTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : empSetAdmitInsert
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 월 개인 시간외근무 인정시간 등록/수정하기
	 */
	@RequestMapping(value = "/subHoliday/empSetAdmitInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> empSetAdmitInsert(@RequestBody List<Map<String, Object>> list){
		logger.info("empSetAdmitInsert");
		int n = subHolidayService.empSetAdmitInsert(list);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : empSetAdminDeactivate
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 월 개인 시간외근무 인정시간 삭제(비활성화) 
	 */
	@RequestMapping(value = "/subHoliday/empSetAdminDeactivate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> empSetAdminDeactivate(@RequestBody List<Map<String, Object>> list){
		logger.info("empSetAdminDeactivate");
		int n = subHolidayService.empSetAdminDeactivate(list);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : gridOverWkEmpSetList
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 월 개인 시간외근무 인정시간 등록 목록보기
	 */
	@RequestMapping("/subHoliday/gridOverWkEmpSetList")
	@ResponseBody
	public Map<String, Object> gridOverWkEmpSetList(@RequestParam Map<String, Object> map){
		logger.info("gridOverWkEmpSetList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridOverWkEmpSetList(map));
		resultMap.put("totalCount", subHolidayService.gridOverWkEmpSetListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : holidaySet
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 30.
	 * @Detail     : 휴일근무설정 등록
	 */
	@RequestMapping(value="/subHoliday/holidaySet", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> holidaySet(@RequestParam Map<String, Object> map){
		logger.info("holidaySet");
		int n = subHolidayService.holidaySet(map);
		Map<String, Object> resultMap= new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : holidaySetDeactivate
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 30.
	 * @Detail     : 휴일근무설정 삭제(비활성화)
	 */
	@RequestMapping(value = "/subHoliday/holidaySetDeactivate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> holidaySetDeactivate(@RequestBody List<Map<String, Object>> list){
		logger.info("holidaySetDeactivate");
		int n = subHolidayService.holidaySetDeactivate(list);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : gridHoliTypeList
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 휴일근무설정 목록 불러오기
	 */
	@RequestMapping("/subHoliday/gridHoliTypeList")
	@ResponseBody
	public Map<String, Object> gridHoliTypeList(@RequestParam Map<String, Object> map) {
		logger.info("gridHoliTypeList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridHoliTypeList(map));
		resultMap.put("totalCount", subHolidayService.gridHoliTypeListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : overWkReq
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 시간외/휴일근무 신청 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/overWkReq", method = RequestMethod.GET)
	public String overWkReq(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> master = subHolidayService.overHoliWorkSelect();
		Map<String, Object> getHeader = commonService.getHeader(empInfo);
		model.addAttribute("getHeader", getHeader);
		model.addAttribute("empInfo", empInfo);
		model.addAttribute("master", master);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_code", "OVERWK_TYPE");
		map.put("code", "01");
		model.addAttribute("typeCode", subHolidayService.getTypeCode(map));
		return "/subHoliday/overWkReq";
	}
	
	/**
	 * @MethodName : getWorkTime
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 8.
	 * @Detail     : 시간외근무 신청을 위한 근무시간 조회
	 */
	@RequestMapping("/subHoliday/getWorkTime")
	@ResponseBody
	public Map<String, Object> getWorkTime(@RequestParam Map<String, Object> map){
		logger.info("getWorkTime");
		return subHolidayService.getWorkTime(map);
	}
	
	/**
	 * @methodName : getWeekAgreeMin
	 * @author     : 이동광
	 * @since      : 2019. 4. 19.
	 * @detail     : 주52시간 알림메세지를 위한 주간 시간외근무 인정시간 불러오기
	 */
	@RequestMapping("/subHoliday/getWeekAgreeMin")
	@ResponseBody
	public Map<String, Object> getWeekAgreeMin(@RequestParam Map<String, Object> map){
		logger.info("getWeekAgreeMin");
		return subHolidayService.getWeekAgreeMin(map);
	}
	
	/**
	 * @MethodName : overWkReqInsert
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 8.
	 * @Detail     : 시간외근무 신청(&휴일근무 신청) + 중복체크 + 파일업로드(근무계획서첨부)
	 */
	@RequestMapping(value = "/subHoliday/overWkReqInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> overWkReqInsert(@RequestParam Map<String, Object> map,
						MultipartHttpServletRequest multi){
		logger.info("overWkReqInsert");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String checkResult = subHolidayService.fn_chkOverHoliApply(map);
		int n = 0;
		if(checkResult.equals("Y")) {
			n = subHolidayService.overWkReqInsert(map, multi);
		}else {
			n = -2;
		}
		if(n>0) {
			resultMap.put("code", "success");
		}else if(n == -2){
			resultMap.put("code", checkResult);
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : getApplyMinMonthSum
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 11.
	 * @Detail     : 현재 월 시간외근무 신청 시간 계(분) 
	 */
	@RequestMapping("/subHoliday/getApplyMinMonthSum")
	@ResponseBody
	public Map<String, Object> getApplyMinMonthSum(@RequestParam Map<String, Object> map){
		logger.info("getApplyMinMonthSum");
		return subHolidayService.getApplyMinMonthSum(map);
	}
	
	/**
	 * @MethodName : gridOverWkMonthList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 11.
	 * @Detail     : 현재 시간외근무 신청 내역
	 */
	@RequestMapping("/subHoliday/gridOverWkMonthList")
	@ResponseBody
	public Map<String, Object> gridOverWkMonthList(@RequestParam Map<String, Object> map){
		logger.info("gridOverWkMonthList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridOverWkMonthList(map));
		resultMap.put("totalCount", subHolidayService.gridOverWkMonthListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : holidayWkReq
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 휴일근무 신청 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/holidayWkReq", method = RequestMethod.GET)
	public String holidayWkReq(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> getHeader = commonService.getHeader(empInfo);
		Map<String, Object> master = subHolidayService.overHoliWorkSelect();
		model.addAttribute("master", master);
		model.addAttribute("getHeader", getHeader);
		model.addAttribute("empInfo", empInfo);
		model.addAttribute("holiTypeList", subHolidayService.gridHoliTypeList());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_code", "OVERWK_TYPE");
		map.put("code", "02");
		model.addAttribute("typeCode", subHolidayService.getTypeCode(map));
		return "/subHoliday/holidayWkReq";
	}
		
	/**
	 * @MethodName : getWeekHoliday
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 11.
	 * @Detail     : 휴일 체크 week(0: 월요일, 6: 일요일), holiday(1이상: 휴일)
	 */
	@RequestMapping("/subHoliday/getWeekHoliday")
	@ResponseBody
	public Map<String, Object> getWeekHoliday(@RequestParam Map<String, Object> map){
		logger.info("getWeekHoliday");
		return subHolidayService.getWeekHoliday(map);
	}
	
	/**
	 * @MethodName : overHoliAdminApp
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 12.
	 * @Detail     : 시간외근무 승인 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/overWkAdminApp", method = RequestMethod.GET)
	public String overHoliAdminApp(Locale locale, Model model,HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		int isAdmin = subHolidayService.getAllAdmin(empInfo);
		String admin_yn = "N";
		if(isAdmin > 0) {
			admin_yn = "Y";
		}
		model.addAttribute("admin_yn", admin_yn);
		return "/subHoliday/overWkAdminApp";
	}
	
	/**
	 * @MethodName : getCommCodeList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 12.
	 * @Detail     : 공통코드 가져오기
	 */
	@RequestMapping("/subHoliday/getCommCodeList")
	@ResponseBody
	public Map<String, Object> getCommCodeList(@RequestParam Map<String, Object> map){
		logger.info("getCommCodeList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.getCommCodeList(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : gridOverWkReqList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 12.
	 * @Detail     : 시간외근무 신청 목록 불러오기
	 */
	@RequestMapping("/subHoliday/gridOverWkReqList")
	@ResponseBody
	public Map<String, Object> gridOverWkReqList(@RequestParam Map<String, Object> map){
		logger.info("gridOverWkReqList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridOverWkReqList(map));
		resultMap.put("totalCount", subHolidayService.gridOverWkReqListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : overWkApprovalUpdate
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 13.
	 * @Detail     : 시간외근무 승인 /승인취소/반려, 휴일근무 승인/승인취소/반려
	 */
	@RequestMapping(value = "/subHoliday/overWkApprovalUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> overWkApprovalUpdate(@RequestBody List<Map<String, Object>> list){
		logger.info("overWkApprovalUpdate");
		int n = subHolidayService.overWkApprovalUpdate(list);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : holidayWkPrivateView
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 13.
	 * @Detail     : 휴일근무 조회(개인) 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/holidayWkPrivateView", method = RequestMethod.GET)
	public String holidayWkPrivateView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		return "/subHoliday/holidayWkPrivateView";
	}
	
	/**
	 * @MethodName : holiWkApprovalUpdate
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 14.
	 * @Detail     : 휴일근무 조회(개인), 파일업로드(결과보고서첨부)시 approval_status 5 업데이트 
	 */
	@RequestMapping(value = "/subHoliday/holiWkApprovalUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> holiWkApprovalUpdate(@RequestParam Map<String, Object> map, 
						MultipartHttpServletRequest multi) {
		logger.info("holiWkApprovalUpdate");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int n = subHolidayService.holiWkApprovalUpdate(map, multi);
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : getFileInfo
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 14.
	 * @Detail     : 파일 다운로드창에 표시하기 위한 정보 조회
	 */
	@RequestMapping("/subHoliday/getFileInfo")
	@ResponseBody
	public Map<String, Object> getFileInfo(@RequestParam Map<String, Object> map){
		logger.info("getFileInfo");
		return subHolidayService.getFileInfo(map);
	}
	
	/**
	 * @MethodName : holidayWkAdminView
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 13.
	 * @Detail     : 휴일근무 조회(인사) 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/holidayWkAdminView", method = RequestMethod.GET)
	public String holidayWkAdminView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		return "/subHoliday/holidayWkAdminView";
	}
	
	/**
	 * @MethodName : holidayWkAdminApp
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 18.
	 * @Detail     : 휴일근무 승인 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/holidayWkAdminApp", method = RequestMethod.GET)
	public String holidayWkAdminApp(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		int isAdmin = subHolidayService.getAllAdmin(empInfo);
		String admin_yn = "N";
		if(isAdmin > 0) {
			admin_yn = "Y";
		}
		model.addAttribute("admin_yn", admin_yn);
		return "/subHoliday/holidayWkAdminApp";
	}
	
	/**
	 * @MethodName : subHolidayReq
	 * @Author     : 이동광
	 * @Since      : 2019. 1. 29.
	 * @Detail     : 대체휴무 현황&신청 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/subHolidayReq", method = RequestMethod.GET)
	public String subHolidayReq(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		empInfo.put("year", year);
		Map<String, Object> getAgreeUseRestMinSum = subHolidayService.getAgreeUseRestMinSum(empInfo);
		Map<String, Object> getHeader = commonService.getHeader(empInfo);
		Map<String, Object> workType = subHolidayService.getWorkTypeCode(empInfo);
		model.addAttribute("getHeader", getHeader);
		model.addAttribute("empInfo", empInfo);
		model.addAttribute("sum", getAgreeUseRestMinSum);
		model.addAttribute("workType", workType);
		return "/subHoliday/subHolidayReq";
	}
	
	/**
	 * @MethodName : subHolidayReqInsert
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 19.
	 * @Detail     : 대체휴무 신청
	 */
	@RequestMapping(value = "/subHoliday/subHolidayReqInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subHolidayReqInsert(@RequestParam Map<String, Object> map){
		logger.info("subHolidayReqInsert");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int n = subHolidayService.subHolidayReqInsert(map);
		if(n>0) {
			resultMap.put("code", "success");
			resultMap.put("replace_day_off_use_id", map.get("replace_day_off_use_id"));
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	@RequestMapping(value = "/subHoliday/subHolidayCompare", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subHolidayCompare(@RequestParam Map<String, Object> map){
		logger.info("subHolidayCompare");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int n = subHolidayService.subHolidayCompare(map);
		if(n>0) {
			resultMap.put("code", "success");
			resultMap.put("replace_day_off_use_id", map.get("appro_key"));
		}else {
			resultMap.put("code", "fail");
			resultMap.put("replace_day_off_use_id", map.get("appro_key"));
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : gridSubHolidayReqList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 19.
	 * @Detail     : 대체휴무 신청현황 조회
	 */
	@RequestMapping("/subHoliday/gridSubHolidayReqList")
	@ResponseBody
	public Map<String, Object> gridSubHolidayReqList(@RequestParam Map<String, Object> map){
		logger.info("gridSubHolidayReqList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridSubHolidayReqList(map));
		resultMap.put("totalCount", subHolidayService.gridSubHolidayReqListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : gridSubHolidayReqListToday
	 * @Author     : 이용욱
	 * @Since      : 2020. 5. 19.
	 * @Detail     : 오늘의 대체휴무 신청현황 조회
	 */
	@RequestMapping("/subHoliday/gridSubHolidayReqListToday")
	@ResponseBody
	public Map<String, Object> gridSubHolidayReqListToday(@RequestParam Map<String, Object> map){
		logger.info("gridSubHolidayReqListToday");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridSubHolidayReqListToday(map));
		resultMap.put("totalCount", subHolidayService.gridSubHolidayReqListTotalToday(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : subHolidayReqDeactivate
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 20.
	 * @Detail     : 대체휴무 신청 취소 
	 */
	@RequestMapping(value = "/subHoliday/subHolidayReqDeactivate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subHolidayReqDeactivate(@RequestParam Map<String, Object> map){
		logger.info("subHolidayReqDeactivate");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int n = subHolidayService.subHolidayReqDeactivate(map);
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : getWeekendHolidayCnt
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 20.
	 * @Detail     : 신청 기간 내 주말, 공휴일 날짜 합산하여 리턴
	 */
	@RequestMapping("/subHoliday/getWeekendHolidayCnt")
	@ResponseBody
	public Map<String, Object> getWeekendHolidayCnt(@RequestParam Map<String, Object> map){
		logger.info("getWeekendHolidayCnt");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("cnt", subHolidayService.getWeekendHolidayCnt(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : getOverHoliRestMin
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 21.
	 * @Detail     : 대체휴무 잔여시간 리턴 
	 */
	@RequestMapping("/subHoliday/getOverHoliRestMin")
	@ResponseBody
	public Map<String, Object> getOverHoliRestMin(@RequestParam Map<String, Object> map){
		logger.info("getOverHoliRestMin");
		return subHolidayService.getOverHoliRestMin(map);
	}
	
	/**
	 * @MethodName : gridSubHolidayOccurList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 20.
	 * @Detail     : 대체휴무 발생현황 조회 
	 */
	@RequestMapping("/subHoliday/gridSubHolidayOccurList")
	@ResponseBody
	public Map<String, Object> gridSubHolidayOccurList(@RequestParam Map<String, Object> map){
		logger.info("gridSubHolidayOccurList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridSubHolidayOccurList(map));
		resultMap.put("totalCount", subHolidayService.gridSubHolidayOccurListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : subHoliAdminApp
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 21.
	 * @Detail     : 대체휴무 승인페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/subHoliAdminApp", method = RequestMethod.GET)
	public String subHoliAdminApp(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		int isAdmin = subHolidayService.getAllAdmin(empInfo);
		String admin_yn = "N";
		if(isAdmin > 0) {
			admin_yn = "Y";
		}
		model.addAttribute("admin_yn", admin_yn);
		return "/subHoliday/subHoliAdminApp";
	}
	
	/**
	 * @MethodName : subHoliApprovalUpdate
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 21.
	 * @Detail     : 대체휴무 승인, 반려
	 */
	@RequestMapping(value = "/subHoliday/subHoliApprovalUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> subHoliApprovalUpdate(@RequestBody List<Map<String, Object>> list){
		logger.info("subHoliApprovalUpdate");
		int n = subHolidayService.subHoliApprovalUpdate(list);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
			return resultMap;
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : subHoliAdminView
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 21.
	 * @Detail     : 대체휴무 조회(인사) 페이지 이동
	 */
	@RequestMapping(value = "/subHoliday/subHoliAdminView", method = RequestMethod.GET)
	public String subHoliAdminView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		return "/subHoliday/subHoliAdminView";
	}
	
	/**
	 * @MethodName : gridSubHolidayUseRestList
	 * @Author     : 이동광
	 * @Since      : 2019. 2. 21.
	 * @Detail     : 사원별 대체휴무 사용, 잔여시간 조회
	 */
	@RequestMapping("/subHoliday/gridSubHolidayUseRestList")
	@ResponseBody
	public Map<String, Object> gridSubHolidayUseRestList(@RequestParam Map<String, Object> map){
		logger.info("gridSubHolidayUseRestList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.gridSubHolidayUseRestList(map));
		resultMap.put("totalCount", subHolidayService.gridSubHolidayUseRestListTotal(map));
		return resultMap;
	}
	
	/**
	 * @methodName : overWkExcelList
	 * @author     : 이동광
	 * @since      : 2019. 3. 13.
	 * @detail     : 시간외근무 엑셀다운로드
	 */
	@RequestMapping("/subHoliday/overWkExcelList")
	public String overWkExcelList(@RequestParam Map<String, Object> map, Map<String, Object> modelMap) {
		logger.info("overWkExcelList");
		List<Map<String, Object>> excelList = subHolidayService.overWkExcelList(map);
		modelMap.put("excelList", excelList);
		modelMap.put("excelType", map.get("startDt") + "_" + map.get("endDt") + "_시간외근무목록");
		return "excelView";
	}
	@RequestMapping("/subHoliday/upExcelDown")
	public String upExcelDown(@RequestParam Map<String, Object> map, Map<String, Object> modelMap) {
		logger.info("upExcelDown");
		List<Map<String, Object>> excelList = subHolidayService.upExcelDown(map);
		modelMap.put("excelList", excelList);
		if(map.get("startDt")!=null && map.get("endDt")!=null && map.get("startDt")!="" && map.get("endDt")!="") {
			modelMap.put("excelType", map.get("startDt") + "_" + map.get("endDt") + "보상휴가현황");
		}else{
			modelMap.put("excelType", "보상휴가현황");
		}
		return "subHoliExcelView";
	}
	@RequestMapping("/subHoliday/downExcelDown")
	public String downExcelDown(@RequestParam Map<String, Object> map, Map<String, Object> modelMap) {
		logger.info("downExcelDown");
		List<Map<String, Object>> excelList = subHolidayService.downExcelDown(map);
		modelMap.put("excelList", excelList);
		if(map.get("startDt")!=null && map.get("endDt")!=null && map.get("startDt")!="" && map.get("endDt")!="") {
			modelMap.put("excelType", map.get("startDt") + "_" + map.get("endDt") + "보상휴가 발생현황");
		}else{
			modelMap.put("excelType", "보상휴가 발생현황");
		}
		return "subHoliOccurExcelView";
	}
	@RequestMapping("/subHoliday/allExcelDown")
	public String allExcelDown(@RequestParam Map<String, Object> map, Map<String, Object> modelMap) {
		logger.info("allExcelDown");
		List<Map<String, Object>> excelList = subHolidayService.allExcelDown(map);
		modelMap.put("excelList", excelList);
		if(map.get("startDt")!=null && map.get("endDt")!=null && map.get("startDt")!="" && map.get("endDt")!="") {
			modelMap.put("excelType", map.get("startDt") + "_" + map.get("endDt") + "전체 보상휴가 발생현황");
		}else{
			modelMap.put("excelType", "전체 보상휴가 발생현황");
		}
		return "subHoliOccurExcelView";
	}
	
	/**
	 * @methodName : getTypeCode
	 * @author     : 이동광
	 * @since      : 2019. 6. 5.
	 * @detail     : 공통코드 가져오기
	 */
	@RequestMapping("/subHoliday/getTypeCode")
	@ResponseBody
	public Map<String, Object> getTypeCode(@RequestParam Map<String, Object> map){
		logger.info("getTypeCode");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("code", subHolidayService.getTypeCode(map));
		return resultMap;
	}
	
	/**
	 * @methodName : inputAgreeMin
	 * @author	   : 이동광
	 * @since 	   : 2019. 6. 13.
	 * @detail	   : 근무지외 휴일근무 인정시간 직접 입력하기
	 */
	@RequestMapping(value="/subHoliday/inputAgreeMin", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> inputAgreeMin(@RequestParam Map<String, Object> map){
		logger.info("inputAgreeMin");
		int n = subHolidayService.inputAgreeMin(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @methodName : getAgreeMin
	 * @author	   : 이동광
	 * @since 	   : 2019. 6. 13.
	 * @detail	   : 휴일근무 인정시간 불러오기
	 */
	@RequestMapping("/subHoliday/getAgreeMin")
	@ResponseBody
	public Map<String, Object> getAgreeMin(@RequestParam Map<String, Object> map){
		logger.info("getAgreeMin");
		return subHolidayService.getAgreeMin(map);
	}
	
	/**
	 * @methodName : updateAgreeMin
	 * @author	   : 이동광
	 * @since 	   : 2019. 6. 13.
	 * @detail	   : 휴일근무 인정시간/사용시간/잔여시간 업데이트
	 */
	@RequestMapping("/subHoliday/updateAgreeMin")
	@ResponseBody
	public Map<String, Object> updateAgreeMin(@RequestParam Map<String, Object> map){
		logger.info("updateAgreeMin");
		int n = subHolidayService.updateAgreeMin(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(n>0) {
			resultMap.put("code", "success");
		}else {
			resultMap.put("code", "fail");
		}
		return resultMap;
	}
	
	/**
	 * @MethodName : iframe
	 * @Author     : 이동광
	 * @Since      : 2019. 7. 15.
	 * @Detail     : 메인페이지에 표시할 일일 근태현황 Iframe
	 */
	@RequestMapping(value = "/subHoliday/iframe", method = RequestMethod.GET)
	public String iframe(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overtimeView! The client locale is {}.", locale);
		Map<String, Object> empInfo = commonService.commonGetEmpInfo(servletRequest);
		model.addAttribute("empInfo", empInfo);
		return "/subHoliday/iframe";
	}

	@RequestMapping(value = "/subHoliday/overWkTimeList")
	@ResponseBody
	public Map<String, Object> overWkTimeList(@RequestParam Map<String, Object> map){
		logger.info("overWkTimeList");		
	
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", subHolidayService.overWkTimeList(map)); //리스트
		
		
		return resultMap;
	}
	
	@RequestMapping(value = "/subHoliday/overWkPrivateView", method = RequestMethod.GET)
	public String overWkPrivateView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overWkPrivateView! The client locale is {}.", locale);
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String deptSeq = (String) loginMap.get("deptSeq");
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("userSeq", (String) loginMap.get("empSeq"));
		return "/subHoliday/overWkPrivateView";
	}
	
	@RequestMapping(value = "/subHoliday/overWkList")
	@ResponseBody
	public Map<String, Object> overWkList(@RequestParam Map<String, Object> map){
		logger.info("overWkList");		
		
		return subHolidayService.overWkList(map);
	}
	
	@RequestMapping(value = "/subHoliday/overWkAdminView", method = RequestMethod.GET)
	public String overWkAdminView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome overWkAdminView! The client locale is {}.", locale);
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String deptSeq = (String) loginMap.get("deptSeq");
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("userSeq", (String) loginMap.get("empSeq"));
		return "/subHoliday/overWkAdminView";
	}
	
	@RequestMapping(value = "/subHoliday/otApplyCancel", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> otApplyCancel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException {
		logger.info("otApplyCancel");	
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		map.put("userId", loginMap.get("empSeq"));
		
		subHolidayService.otApplyCancel(map);
		
		return map;

	}
	
	@RequestMapping(value = "/subHoliday/checkHoliTime", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkHoliTime(@RequestParam Map<String, Object> map){
		logger.info("checkHoliTime");		
	
		//리턴용 map
		Map<String, Object> resultMap = subHolidayService.checkHoliTime(map);
		resultMap.put("workMin", workPlanService.getWorkMin(map));
		return resultMap;
	}
	
	@RequestMapping(value = "/subHoliday/replaceHoliCheck", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replaceHoliCheck(@RequestParam Map<String, Object> map){
		logger.info("replaceHoliCheck");		
	
		//리턴용 map
		Map<String, Object> resultMap = subHolidayService.replaceHoliCheck(map);
		
		return resultMap;
	}
	
	/**
	 * @methodName : defaultIframeReqList
	 * @author	   : 이동광
	 * @since 	   : 2019. 12. 17.
	 * @detail	   : 신청 현황 표시 프레임
	 */
	@RequestMapping("/subHoliday/defaultIframeReqList")
	@ResponseBody
	public Map<String, Object> defaultIframeReqList(@RequestParam Map<String, Object> map) {
		logger.info("defaultIframeReqList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.defaultIframeReqList(map));
		return resultMap;
	}

	/**
	 * @methodName : reqList
	 * @author	   : leev0
	 * @since 	   : 2019. 12. 17.
	 * @detail	   : 신청 현황 관리자 페이지
	 */
	@RequestMapping(value = "/subHoliday/reqList")
	public String reqList(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome reqList! The client locale is {}.", locale);
		model.addAttribute("empInfo", commonService.commonGetEmpInfo(servletRequest));
		return "/subHoliday/reqList";
	}
	
	@RequestMapping("/subHoliday/subHolidayReqDaySelect")
	@ResponseBody
	public Map<String, Object> subHolidayReqDaySelect(@RequestParam Map<String, Object> map) {
		logger.info("subHolidayReqDaySelect");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("daySelect", subHolidayService.subHolidayReqDaySelect(map));
		return resultMap;
	}
	
	@RequestMapping("/subHoliday/SearchAttReqMainMgrList")
	@ResponseBody
	public Map<String, Object> SearchAttReqMainMgrList(@RequestParam Map<String, Object> map){
		logger.info("SearchAttReqMainMgrList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.SearchAttReqMainMgrList(map));
		resultMap.put("totalCount", subHolidayService.SearchAttReqMainMgrListTotal(map));
		return resultMap;
	}
	
	/**
	 * @MethodName : subHolidayReqList
	 * @author : gato
	 * @since : 2018. 2. 1.
	 * 설명 : 연장/휴일보상 근무 개인조회 리스트
	 */
	@RequestMapping(value = "/subHoliday/subHolidayReqList")
	@ResponseBody
	public Map<String, Object> subHolidayReqList(@RequestParam Map<String, Object> map){
		logger.info("subHolidayReqList");		
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", subHolidayService.subHolidayReqList(map)); //리스트
		resultMap.put("totalCount", subHolidayService.subHolidayReqListTotal(map)); //토탈
		
		return resultMap;
}
}
