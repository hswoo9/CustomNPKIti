package com.duzon.custom.airlineMileage.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.airlineMileage.service.AirlineMileageService;
import com.duzon.custom.common.service.CommonService;

@Controller
public class AirlineMileageController {
	private static final Logger logger = LoggerFactory.getLogger(AirlineMileageController.class);
	
	@Autowired private CommonService commonService;
	@Autowired private AirlineMileageService airlineMileageService; 
	
	/**
	 * @MethodName : mileageAdminView
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 15.
	 * @Detail     : 마일리지 관리자 페이지
	 */
	@RequestMapping(value = "/airlineMileage/mileageAdminView", method = RequestMethod.GET)
	public String mileageAdminView(Locale locale, Model model,HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome mileageAdminView! The client locale is {}.", locale);
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String deptSeq = (String) loginMap.get("deptSeq");
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("userSeq", (String) loginMap.get("empSeq"));
		
		
		return "/airlineMileage/mileageAdminView";
	}
	/**
	 * @MethodName : mileageExcelUpload
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 15.
	 * @Detail     : 마일리지 엑셀 업로드
	 */
	@ResponseBody
    @RequestMapping(value = "/airlineMileage/excelUpload", method = RequestMethod.POST)
    public Map<String, Object> mileageExcelUpload(@RequestParam Map<String, Object> map,Locale locale, Model model, MultipartHttpServletRequest multi)  throws Exception{
		logger.info("mileageExcelUpload");
		
		return airlineMileageService.excelUpload(map,multi,model);
    }
	/**
	 * @MethodName : mileageSearchAdmin
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 15.
	 * @Detail     : 마일리지 조회(관리자)
	 */
	@RequestMapping(value = "/airlineMileage/mileageListSearchAdmin", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mileageListSearchAdmin(@RequestParam Map<String, Object> map) throws Exception{
		logger.info("mileageSearchAdmin");		
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", airlineMileageService.mileageListSearch(map)); //리스트
		resultMap.put("totalCount", airlineMileageService.mileageListSearchTotal(map)); //토탈
		
		return resultMap;
	}
	/**
	 * @MethodName : mileageReq
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 23.
	 * @Detail     : 마일리지 등록 페이지
	 */
	@RequestMapping(value = "/airlineMileage/mileageReq", method = RequestMethod.GET)
	public String mileageReq(Locale locale, Model model,HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome mileageReq! The client locale is {}.", locale);
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String deptSeq = (String) loginMap.get("deptSeq");
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("userSeq", (String) loginMap.get("empSeq"));
		
		
		return "/airlineMileage/mileageReq";
	}
	/**
	 * @MethodName : fileUpload
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 24.
	 * @Detail     : 파일업로드
	 */
	@RequestMapping("/airlineMileage/fileUpload")
    public Map<String, Object> fileUpload(@RequestParam Map<String, Object> map,Locale locale, Model model, MultipartHttpServletRequest multi) throws Exception{
    	
		logger.info("fileUpload");

		return airlineMileageService.fileUpload(map,multi,model);
    }
	
	/**
	 * @MethodName : mileageRequest
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 24.
	 * @Detail     : 마일리지 등록
	 */
	@RequestMapping(value="/airlineMileage/mileageRequest", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> mileageRequest(@RequestParam Map<String, Object> map) throws Exception{

		logger.debug("mileageRequest");
	
		airlineMileageService.updateMileageMaster(map);

		return map;
	}
	
	/**
	 * @MethodName : deleteMileage
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 30.
	 * @Detail     : 마일리지 등록한 데이터 삭제
	 */
	@RequestMapping(value="/airlineMileage/deleteMileage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteMileage(@RequestParam Map<String, Object> map) throws Exception{

		logger.debug("deleteMileage");
		
		airlineMileageService.deleteMileage(map);

		return map;
	}
	
	/**
	 * @MethodName : fileList
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 24.
	 * @Detail     : 파일가지고오기
	 */
	@RequestMapping(value = "/airlineMileage/fileList")
	@ResponseBody
	public Map<String, Object> fileList(@RequestParam Map<String, Object> map){
		logger.info("fileList");		
		map.put("tableName", map.get("fileName"));
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", airlineMileageService.fileList(map));
		
		
		return resultMap;
	}
	
	/**
	 * @MethodName : fileDown
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 24.
	 * @Detail     : 첨부파일 다운로드
	 */
	@RequestMapping(value = "/airlineMileage/fileDown", method = RequestMethod.GET)
	@ResponseBody
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response){
		logger.info("fileDown");
		
		airlineMileageService.fileDown(map, request, response);
		
	}
	
	/**
	 * @MethodName : mileageUserView
	 * @Author     : 김진호
	 * @Since      : 2021. 9. 15.
	 * @Detail     : 마일리지 사용자 페이지
	 */
	@RequestMapping(value = "/airlineMileage/mileageUserView", method = RequestMethod.GET)
	public String mileageUserView(Locale locale, Model model,HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("Welcome mileageAdminView! The client locale is {}.", locale);
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> getUpDeptName = commonService.getUpDeptName(loginMap);
		String deptSeq = (String) loginMap.get("deptSeq");
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("userInfo", loginMap);
		model.addAttribute("getUpDeptName", getUpDeptName);
		model.addAttribute("userSeq", (String) loginMap.get("empSeq"));
		
		
		return "/airlineMileage/mileageUserView";
	}
	
}
