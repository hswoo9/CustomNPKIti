package com.duzon.custom.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.common.utiles.CtFileUtile;


@Controller
@RequestMapping(value="/common")
public class CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Autowired
	private CommonService commonService;
	
	
	/**
	 * YH
	 * 2017. 12. 11.
	 * 설명 : 공통 파일 다운로드
	 */
	@RequestMapping(value = "/ctFileDownLoad", method = RequestMethod.GET)
	@ResponseBody
	public void ctFileDownLoad(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) {
		
		logger.info("ctFileDownLoad");
		
		String path = (String) map.get("filePath");
		String fileNm = (String) map.get("fileNm");
		
		CtFileUtile ctFileUtile = new CtFileUtile();
		
		ctFileUtile.fileDownLoad(path, fileNm, request, response);
	
	}
	
	@RequestMapping(value = "/ctFileUpLoad", method = RequestMethod.POST)
	@ResponseBody
	public void ctFileUpLoad(@RequestParam Map<String, Object> map, MultipartHttpServletRequest multi, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("ctFileUpLoad");
		
		commonService.ctFileUpLoad(map, multi);
		

	}
	
	/**
		 * @MethodName : empInformation
		 * @author : gato
		 * @since : 2018. 1. 23.
		 * 설명 : 사원팝업
		 */
	@RequestMapping(value = "/empInformation", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> empInformation(@RequestParam Map<String, Object> map){
		logger.info("empInformation");
//		System.out.println("코드 컨트롤러");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", commonService.empInformation(map)); //리스트
		resultMap.put("totalCount", commonService.empInformationTotal(map)); //토탈
		
		return resultMap;
	}
	

	/**
	 * @MethodName : fileList
	 * @author : gato
	 * @since : 2018. 1. 8.
	 * 설명 : 첨부파일 목록 가져오기
	 */
	@RequestMapping(value = "/fileList")
	@ResponseBody
	public Map<String, Object> fileList(@RequestParam Map<String, Object> map){
		logger.info("systemFileList");		
		map.put("tableName", map.get("fileName"));
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", commonService.fileList(map));
		
		
		return resultMap;
	}
	
	/**
	 * @MethodName : fileDown
	 * @author : gato
	 * @since : 2018. 1. 9.
	 * 설명 : 정보시스템 파일 다운로드
	 */
	@RequestMapping(value = "/fileDown", method = RequestMethod.GET)
	@ResponseBody
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response){
		logger.info("fileDown");
		
		commonService.fileDown(map, request, response);
		
	}
	
	@RequestMapping(value = "/fileDelete", method = RequestMethod.POST)
	@ResponseBody
	public void fileDelete(@RequestParam Map<String, Object> map) {
		logger.info("fileDelete");
		commonService.fileDelete(map);
		
	}
	
	@RequestMapping(value = "/getSubCd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSubCd(@RequestParam String code) {
		logger.info("getSubCd");
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 
		 
		 resultMap.put("subCd", commonService.getCode(code, "ASC"));
		
		return resultMap;
	}
	
	@RequestMapping ( value = "/getDeptList", method = RequestMethod.POST )
	public ModelAndView getDeptList ( @RequestParam HashMap<String, Object> requestMap, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> allDept = commonService.getAllDept();
		mv.addObject("allDept", allDept);
		mv.setViewName( "jsonView" );
		return mv;
	}
	
	@RequestMapping(value = "/getDutyPosition", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDutyPosition(@RequestParam String subKey) {
		logger.info("getDutyPosition");
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 
		 resultMap.put("getDutyPosition", commonService.getDutyPosition(subKey));
		
		return resultMap;
	}
	
	@RequestMapping(value = "/selectEmp", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> selectEmp(@RequestParam Map<String, Object> map){
		logger.info("selectEmp");
//		System.out.println("코드 컨트롤러");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", commonService.selectEmp(map)); //리스트
		
		
		return resultMap;
	}
	
}
