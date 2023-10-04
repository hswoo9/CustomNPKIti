package com.duzon.custom.educationManagement.controller;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.educationManagement.service.EducationService;
import com.duzon.custom.educationManagement.vo.OnlineEduVO;
import com.google.gson.Gson;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

/**

  * @FileName : EducationController.java

  * @Project : CustomNPKssf

  * @Date : 2019. 2. 18. 

  * @작성자 : 김찬혁

  * @변경이력 :

  * @프로그램 설명 : 교육 관리

  */
@Controller
public class EducationController {
	
	private static final Logger logger = LoggerFactory.getLogger(EducationController.class);
	
	@Value("#{bizboxa['BizboxA.domain']}")
	private String domain;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private EducationService educationService;
	
	/**
		 * @MethodName : adminEduRegView
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육 등록 메인 View
		 */
	@RequestMapping(value="/educationManagement/groupEduRegView", method = RequestMethod.GET)
	public String adminEduRegView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		List<Map<String, Object>> requiredDn = commonService.getCode("REQUIRED_EDUCATION", "asc");
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", new Gson().toJson(empDept));
		model.addAttribute("requiredDn", new Gson().toJson(requiredDn));
		return "/educationManagement/groupEduRegView";		
	}
	
	/**
	 * @MethodName : groupEduAppView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육 승인 메인 View
	 */
	@RequestMapping(value="/educationManagement/groupEduAppView", method = RequestMethod.GET)
	public String adminGroupEduAppView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/groupEduAppView";		
	}

	/**
	 * @MethodName : groupEduFinView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육 이수 메인 View
	 */
	@RequestMapping(value="/educationManagement/groupEduFinView", method = RequestMethod.GET)
	public String adminGroupEduFinView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptSeq", deptSeq);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/groupEduFinView";		
	}
	
	/**
	 * @MethodName : privateEduRegView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 개별교육 등록 메인 View
	 */
	@RequestMapping(value="/educationManagement/privateEduRegView", method = RequestMethod.GET)
	public String privateEduRegView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		Map<String, Object> getEduNm = commonService.getCodeOne("EDUCATION_DN", "ED02");
		Map<String, Object> getFinNm = commonService.getCodeOne("EDU_COMPLETION_STS", "EC01");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> restFund = commonService.getRestFund(empSeq); 
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		model.addAttribute("restFund", restFund.get("restFund"));
		model.addAttribute("finDn", getFinNm.get("code_kr"));
		model.addAttribute("eduDn", getEduNm.get("code_kr"));
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/privateEduRegView";		
	}
	
	/**
	 * @MethodName : privateEduRegView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 개별교육 관리자 이수처리 메인 View
	 */
	@RequestMapping(value="/educationManagement/privateEduAdminView", method = RequestMethod.GET)
	public String privateEduAdminView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		Map<String, Object> getEduNm = commonService.getCodeOne("EDUCATION_DN", "ED02");
		Map<String, Object> getFinNm = commonService.getCodeOne("EDU_COMPLETION_STS", "EC01");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> restFund = commonService.getRestFund(empSeq); 
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		model.addAttribute("restFund", restFund.get("restFund"));
		model.addAttribute("finDn", getFinNm.get("code_kr"));
		model.addAttribute("eduDn", getEduNm.get("code_kr"));
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/privateEduAdminView";		
	}
	
	/**
	 * @MethodName : privateEduRegView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 교육현황 개인용 페이지
	 */
	@RequestMapping(value="/educationManagement/privateEduStsView", method = RequestMethod.GET)
	public String privateEduStsView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		Map<String, Object> getEduNm = commonService.getCodeOne("EDUCATION_DN", "ED02");
		Map<String, Object> getFinNm = commonService.getCodeOne("EDU_COMPLETION_STS", "EC01");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> restFund = commonService.getRestFund(empSeq); 
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		model.addAttribute("restFund", restFund.get("restFund"));
		model.addAttribute("finDn", getFinNm.get("code_kr"));
		model.addAttribute("eduDn", getEduNm.get("code_kr"));
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/privateEduStsView";		
	}
	
	/**
	 * @MethodName : privateEduRegView
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 교육현황 담당자 페이지
	 */
	@RequestMapping(value="/educationManagement/adminEduStsView", method = RequestMethod.GET)
	public String adminEduStsView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		Map<String, Object> getEduNm = commonService.getCodeOne("EDUCATION_DN", "ED02");
		Map<String, Object> getFinNm = commonService.getCodeOne("EDU_COMPLETION_STS", "EC01");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String empSeq = (String) loginMap.get("erpEmpSeq");
		String deptSeq = (String) loginMap.get("deptSeq");
		Map<String, Object> restFund = commonService.getRestFund(empSeq); 
		Map<String, Object> empName = commonService.getEmpName(empSeq);		
		Map<String, Object> deptList = commonService.getDept(empSeq);
		List<Map<String, Object>> empDept = commonService.getEmpDept(deptSeq);
		List<Map<String, Object>> allDept = commonService.getAllDept();
		List<Map<String, Object>> getPosition = commonService.getDutyPosition("POSITION");
		model.addAttribute("getPosition", getPosition);
		model.addAttribute("restFund", restFund.get("restFund"));
		model.addAttribute("finDn", getFinNm.get("code_kr"));
		model.addAttribute("eduDn", getEduNm.get("code_kr"));
		model.addAttribute("allDept", allDept);
		model.addAttribute("deptList", deptList);
		model.addAttribute("deptName", (String) loginMap.get("orgnztNm"));
		model.addAttribute("userSeq", (String) loginMap.get("erpEmpSeq"));
		model.addAttribute("userName", empName.get("emp_name"));
		model.addAttribute("empDept", empDept);
		return "/educationManagement/adminEduStsView";		
	}
	
	/**
		 * @MethodName : onlineEduUploadView
		 * @author : gato
		 * @since : 2018. 3. 21.
		 * 설명 : 온라인교육 업로드 이수처리
		 */
	@RequestMapping(value="/educationManagement/onlineEduUploadView", method = RequestMethod.GET)
	public String onlineEduUploadView(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		
		return "/educationManagement/onlineEduUploadView";		
	}
	
	/**
		 * @MethodName : groupEduReg
		 * @author : gato
		 * @throws UnknownHostException 
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육 등록
		 */
	@RequestMapping(value="/educationManagement/groupEduReg", method = RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	public void groupEduReg(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("groupEduReg");
		
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> getCodeNm = commonService.getCodeOne("EDUCATION_STEP", "ES01");
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("education_step_code_id", "ES01");
		map.put("education_step", getCodeNm.get("code_kr"));
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		
		educationService.groupEduReg(map);		
		
		
	}
	
	/**
		 * @MethodName : groupEduList
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육등록 화면 집합교육 리스트 (첫번째 그리드)
		 */
	@RequestMapping(value = "/educationManagement/eduList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> eduList(@RequestParam Map<String, Object> map){
		logger.info("groupEduList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", educationService.eduList(map)); //리스트
		resultMap.put("totalCount", educationService.eduListTotal(map)); //토탈
		
		return resultMap;
	}
	
	/**
	 * @MethodName : groupEduList
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육대상자 리스트 (두번째 그리드)
	 */
	@RequestMapping(value = "/educationManagement/groupEduDetailList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupEduDetailList(@RequestParam Map<String, Object> map){
		logger.info("groupEduDetailList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", educationService.groupEduDetailList(map)); //리스트
		resultMap.put("totalCount", educationService.groupEduDetailListTotal(map)); //토탈
		
		return resultMap;
	}
	
	/**
		 * @MethodName : groupEduApproval
		 * @author : gato
	 * @throws URISyntaxException 
		 * @since : 2018. 3. 9.
		 * 설명 : 집합교육 계획 승인
		 */
	@RequestMapping(value = "/educationManagement/groupEduApproval", method = RequestMethod.POST)
	@ResponseBody
	public String groupEduApproval(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException, URISyntaxException{
		logger.info("groupEduApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		Map<String, Object> getCodeNm = commonService.getCodeOne("EDUCATION_STEP", "ES02");
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("education_step_code_id", "ES02");
		map.put("education_step", getCodeNm.get("code_kr"));
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.groupEduApproval(map);
//		Map<String, Object> schResult = eduInsertSchedule(map);
//		schResult.put("eduKey", map.get("data"));
//		educationService.updateSchmSeq(schResult);
//		List<Map<String, Object>> empList = educationService.getGroupEmpList(map);
//		for (Map<String, Object> emp : empList) {
//			
//			emp.put("schm_seq", schResult.get("schmSeq"));
//			emp.put("sch_seq", schResult.get("schSeq"));
//			emp.put("user_type", "10");
//			emp.put("comp_seq", "1000");
//			emp.put("group_seq", "tpf");
//			emp.put("org_type", "E");
//			emp.put("sub_org_seq", "ALL");
//			emp.put("use_yn", "Y");
//			emp.put("create_seq", schResult.get("create_seq"));
//			
//			educationService.insertCalendarEmp(emp);
//			
//		}
		
		
		return "ok";
	}
	
	/**
		 * @MethodName : eduFinApproval
		 * @author : gato
		 * @since : 2018. 3. 9.
		 * 설명 : 집합교육 이수 승인
		 */
	@RequestMapping(value="/educationManagement/eduFinApproval")
	public String eduFinApproval(@RequestParam Map<String, Object> map, MultipartHttpServletRequest multi, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("eduFinApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.eduFinApproval(map, multi);
		return "/educationManagement/groupEduFinView";
	}
	
	/**
	 * @MethodName : privateEduReg
	 * @author : gato
	 * @since : 2018. 3. 9.
	 * 설명 : 개별교육 이수요청
	 */
	@RequestMapping(value="/educationManagement/privateEduReg", method = RequestMethod.POST)
	public String privateEduReg(@RequestParam Map<String, Object> map, MultipartHttpServletRequest multi, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("eduFinApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.privateEduReg(map, multi);
		return "/educationManagement/privateEduRegView";
	}
	
	/**
		 * @MethodName : privateEduList
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 리스트
		 */
	@RequestMapping(value = "/educationManagement/privateEduList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> privateEduList(@RequestParam Map<String, Object> map){
		logger.info("privateEduList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", educationService.privateEduList(map)); //리스트
		resultMap.put("totalCount", educationService.privateEduListTotal(map)); //토탈
		
		return resultMap;
	}
	
	/**
	 * @MethodName : privateFinApproval
	 * @author : gato
	 * @since : 2018. 3. 9.
	 * 설명 : 개별교육 이수 승인
	 */
	@RequestMapping(value="/educationManagement/privateFinApproval")
	public String privateFinApproval(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("privateFinApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.privateFinApproval(map);
		return "/educationManagement/privateEduAdminView";
	}

	/**
	 * @MethodName : privateFinApproval
	 * @author : gato
	 * @since : 2018. 3. 9.
	 * 설명 : 개별교육 이수 반려
	 */
	@RequestMapping(value="/educationManagement/privateFinReject")
	public String privateFinReject(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("privateFinApproval");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.privateFinReject(map);
		return "/educationManagement/privateEduAdminView";
	}
	
	/**
	 * @MethodName : privateEduStsList
	 * @author : gato
	 * @since : 2018. 3. 12.
	 * 설명 : 개인별 교육현황 리스트
	 */
	@RequestMapping(value = "/educationManagement/privateEduStsList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> privateEduStsList(@RequestParam Map<String, Object> map){
		logger.info("privateEduStsList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty((String) map.get("education_duty"))) {
			String[] education_duty = ((String) map.get("education_duty")).split(",");
			map.put("education_duty", education_duty);
		}
		resultMap.put("list", educationService.privateEduStsList(map)); //리스트
		resultMap.put("totalCount", educationService.privateEduStsListTotal(map)); //토탈
		return resultMap;
	}
	
	/**
		 * @MethodName : privateEduStsDetailList
		 * @author : gato
		 * @since : 2018. 3. 13.
		 * 설명 : 개인별 교육현황 상세
		 */
	@RequestMapping(value = "/educationManagement/privateEduStsDetailList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> privateEduStsDetailList(@RequestParam Map<String, Object> map){
		logger.info("privateEduList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if (StringUtils.isNotEmpty((String) map.get("education_duty"))) {
			String[] education_duty = ((String) map.get("education_duty")).split(",");
			map.put("education_duty", education_duty);
		}
		resultMap.put("list", educationService.privateEduStsDetailList(map)); //리스트
		resultMap.put("totalCount", educationService.privateEduStsDetailListTotal(map)); //토탈
		
		return resultMap;
	}
	
	/**
		 * @MethodName : onlineEduExcelUploadAjax
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인 교육 엑셀 업로드
		 */
	@RequestMapping(value = "/educationManagement/onlineEduExcelUploadAjax", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> onlineEduExcelUploadAjax(@RequestParam Map<String, Object> map,Locale locale, Model model, MultipartHttpServletRequest multi) throws Exception{
		String localIp = InetAddress.getLocalHost().getHostAddress();
		MultipartFile fileNm = multi.getFile("fileNm");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(multi);
		map.put("userId", loginMap.get("erpEmpSeq"));
		map.put("localIp", localIp);
		
		if (fileNm == null || fileNm.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택 해 주세요.");
		}
		String filePath = "/home/neos/tpf_file/excel/";
		File destFile = new File(filePath+fileNm.getOriginalFilename());
		File dir = new File(filePath);
		 if(!dir.isDirectory()){
             dir.mkdirs();
         }
		 
		try {
			fileNm.transferTo(destFile);
		} catch (IllegalStateException | IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		List<Map<String, String>> result = educationService.onlineEduExcelUpload(destFile, map);
		destFile.delete();
		
	    return result;
	}
	
	/**
		 * @MethodName : onlineEduExcelList
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인교육 리스트
		 */
	@RequestMapping(value = "/educationManagement/onlineEduExcelList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> onlineEduExcelList(@RequestParam Map<String, Object> map){
		logger.info("onlineEduExcelList");
		
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", educationService.onlineEduExcelList(map)); //리스트
		
		return resultMap;
	}
	
	/**
		 * @MethodName : onlineEduUpdate
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인교육 수정 
		 */
	@RequestMapping(value="/educationManagement/onlineEduUpdate", method = RequestMethod.POST)
	@ResponseBody
	public String onlineEduUpdate(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("eduFinApproval");
		int flag = 0;
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.onlineEduUpdate(map);
		return flag+"";
	}
	
	/**
		 * @MethodName : onlineEduDel
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인교육 삭제
		 */
	@RequestMapping(value = "/educationManagement/onlineEduDel", method = RequestMethod.POST)
	@ResponseBody
	public String onlineEduDel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("onlineEduDel");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.onlineEduDel(map);
		
		return "ok";
	}
	
	/**
		 * @MethodName : onlineEduExcelDown
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인교육 업로드용 엑셀양식 다운로드
		 */
	@RequestMapping(value = "/educationManagement/onlineEduExcelDown", method = RequestMethod.GET)
	@ResponseBody
	public void onlineEduExcelDown(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response){
		logger.info("onlineEduExcelDown");
		try {
			String fileName = "onlineEduUpload.xlsx";
			String realFileName = "온라인교육엑셀업로드양식.xlsx";
			
			String path = request.getSession().getServletContext().getRealPath("/resources/exceltemplate/"+fileName);
			commonService.fileDownLoad(realFileName, path, request, response);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	}
	
	/**
		 * @MethodName : eduReqDel
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 교육 삭제
		 */
	@RequestMapping(value = "/educationManagement/eduReqDel", method = RequestMethod.POST)
	@ResponseBody
	public String eduReqDel(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("eduReqDel");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.eduReqDel(map);
		return "ok";
	}
	
	/**
		 * @MethodName : groupEduCancle
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 집합교육 승인 취소
		 */
	@RequestMapping(value = "/educationManagement/groupEduCancle", method = RequestMethod.POST)
	@ResponseBody
	public String groupEduCancle(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException, URISyntaxException{
		logger.info("groupEduCancle");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		Map<String, Object> getCodeNm = commonService.getCodeOne("EDUCATION_STEP", "ES01");
		map.put("education_step_code_id", "ES01");
		map.put("education_step", getCodeNm.get("code_kr"));
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.groupEduCancle(map);
//		deleteCalendar(map);
		
		return "ok";
	}
	
	/**
		 * @MethodName : eduResultFileList
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 결과보고서 파일 리스트
		 */
	@RequestMapping(value = "/educationManagement/eduResultFileList")
	@ResponseBody
	public Map<String, Object> eduResultFileList(@RequestParam Map<String, Object> map){
		logger.info("eduResultFileList");		
		map.put("education_id", map.get("fileName"));
		//리턴용 map
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("list", educationService.eduResultFileList(map));
		
		
		return resultMap;
	}
	
	/**
		 * @MethodName : fileDown
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 파일 다운
		 */
	@RequestMapping(value = "/educationManagement/fileDown", method = RequestMethod.GET)
	@ResponseBody
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpServletResponse response){
		logger.info("fileDown");
		
		educationService.fileDown(map, request, response);
		
	}
	
	/**
		 * @MethodName : onlineEduSave
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 온라인교육 저장
		 */
	@RequestMapping(value="/educationManagement/onlineEduSave", method = RequestMethod.POST)
	@ResponseBody
	public String onlineEduSave(@ModelAttribute("onlineEduVO") OnlineEduVO onlineEduVO, HttpServletRequest servletRequest) throws Exception{
		logger.info("onlineEduSave");
		
		int flag = 0;
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		Map<String, Object> eduDn = commonService.getCodeOne("EDUCATION_DN", "ED03");
		onlineEduVO.setLocalIp(localIp);
		onlineEduVO.setUserId((String) loginMap.get("erpEmpSeq"));
		onlineEduVO.setEducation_type_code_id((String) eduDn.get("code"));
		onlineEduVO.setEducation_type((String) eduDn.get("code_kr"));
		
		educationService.onlineEduSave(onlineEduVO);

		return flag+"";
	}
	
	/**
		 * @MethodName : onlineEduMonthYn
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 선택월 온라인교육 등록 여부 확인
		 */
	@RequestMapping(value = "/educationManagement/onlineEduMonthYn", method = RequestMethod.POST)
	@ResponseBody
	public String onlineEduMonthYn(@RequestParam Map<String, Object> map){
		logger.info("onlineEduMonthYn");
		
		//리턴용 map
		String result = educationService.getOnlineMonthYn(map);
		
		
		return result;
	}
	
	/**
		 * @MethodName : groupEduReject
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 집합교육 반려
		 */
	@RequestMapping(value="/educationManagement/groupEduReject")
	public String groupEduReject(@RequestParam Map<String, Object> map, HttpServletRequest servletRequest) throws NoPermissionException, UnknownHostException{
		logger.info("groupEduReject");
		Map<String, Object> loginMap = commonService.commonGetEmpInfo(servletRequest);
		String localIp = InetAddress.getLocalHost().getHostAddress();
		map.put("localIp", localIp);
		map.put("userId", loginMap.get("erpEmpSeq"));
		educationService.groupEduReject(map);
		return "/educationManagement/groupEduAppView";
	}
	
	/**
		 * @MethodName : eduInsertSchedule
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 집합교육 일정등록 api
		 */
	public Map<String, Object> eduInsertSchedule(Map<String, Object> eduMap) throws URISyntaxException {
		
		Map<String, Object> userInfo = new HashMap<String, Object>();
		
		Map<String, Object> mainMap = educationService.getGroupMainMap(eduMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, Object> header = new HashMap<String, Object>();
		
		Map<String, Object> body = new HashMap<String, Object>();
		
		Map<String, Object> companyInfo = new HashMap<String, Object>();
		
		userInfo = commonService.getCalendarEmpInfo((String) mainMap.get("manager_emp_seq"));
		
		String title = (String) mainMap.get("education_name");
		String empSeq = (String) mainMap.get("manager_emp_seq");
		String contents = (String) mainMap.get("education_name");
		String startDate = (String) mainMap.get("education_start_date")+ (String) mainMap.get("education_start_time");
		String endDate = (String) mainMap.get("education_end_date")+ (String) mainMap.get("education_end_time");
		String schPlace = (String) mainMap.get("education_place");
		String mcalSeq = (String) userInfo.get("mcalSeq");
		String groupSeq = (String) userInfo.get("group_seq");
		String bizSeq = (String) userInfo.get("biz_seq");
		String deptSeq = (String) userInfo.get("dept_seq");
		String compSeq = (String) userInfo.get("comp_seq");
		String emailAddr = (String) userInfo.get("email_addr");
		String emailDomain = (String) userInfo.get("homepg_addr");
		
		header.put("pId", "");
		header.put("groupSeq", groupSeq);
		header.put("tId", "");
		header.put("empSeq", empSeq);
		
		body.put("schmSeq", "0");
		body.put("schTitle", title);
		body.put("startDate", startDate);
		body.put("endDate", endDate);
		body.put("alldayYn", "N");
		body.put("gbnCode", "M");
		body.put("gbnSeq", "");
		body.put("schGbnCode", "10");
		body.put("repeatType", "10");
		body.put("contents", contents);
		body.put("rangeCode", "N");
		body.put("schPlace", schPlace);
		body.put("mcalSeq", mcalSeq);
		body.put("langeCode", "kr");
//		body.put("schUserList", schUserList);
//		body.put("schUserList", jArray);//배열을 넣음
		companyInfo.put("bizSeq", bizSeq);
		companyInfo.put("compSeq", compSeq);
		companyInfo.put("deptSeq", deptSeq);
		companyInfo.put("emailAddr", "");
		companyInfo.put("emailDomain", "");
		
		body.put("companyInfo", companyInfo);

		resultMap.put("header", header);
		resultMap.put("body", body);
		
		String data = new Gson().toJson(resultMap);
		
		
		Map<String, Object> apiResult = new HashMap<String, Object>();
		try {
			RequestConfig.Builder requestBuilder = RequestConfig.custom();
    	    HttpClientBuilder builder = HttpClientBuilder.create();
    	    builder.setDefaultRequestConfig(requestBuilder.build());
    	    HttpClient client = builder.build();
    	    ObjectMapper mapper = new ObjectMapper();

    	    StringEntity stringEntity = new StringEntity(data, HTTP.UTF_8);
    	    String result = "";
    	    HttpPost httpost = new HttpPost(new URI("http://"+domain+"/schedule/MobileSchedule/InsertMtSchedule"));
    	    httpost.addHeader("Content-Type", "application/json");
    	    HttpResponse response;
    	    httpost.setEntity(stringEntity);
    	    

    	    response = client.execute(httpost);
    	    result = EntityUtils.toString(response.getEntity());
    	    apiResult = mapper.readValue(result, new TypeReference<Map<String, Object>>() {});

    	   
    	   
    	} catch (IOException e) {
    	    e.printStackTrace();
    	}
    	
		
		Map<String, Object> schmSeq = (Map<String, Object>) apiResult.get("result");
		schmSeq.put("create_seq", (String) mainMap.get("manager_emp_seq"));
		
		return schmSeq;
		
	}
	
	public static void main(String[] args) throws URISyntaxException {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		Map<String, Object> header = new HashMap<String, Object>();
		Map<String, Object> body = new HashMap<String, Object>();
		Map<String, Object> companyInfo = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		params.put("mcalSeq","100");
		
		String mcalSeq = (String) params.get("mcalSeq");
		String[] mcalArr; 
		mcalArr = mcalSeq.split(";");
		
		
		header.put("pId", "");
		header.put("groupSeq", "tpf");
		header.put("tId", "");
		header.put("empSeq", "1402");
	
		
		ArrayList<String> placeList = new ArrayList<>();
		placeList.add("1403");
		placeList.add("1402");
		placeList.add("1399");
		placeList.add("1350");
		placeList.add("1351");
		placeList.add("1352");
		
		JSONObject obj = new JSONObject();
		try {
		JSONArray jArray = new JSONArray();//배열이 필요할때
		for (int i = 0; i < placeList.size(); i++)//배열
			{
				JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
				sObject.put("orgSeq", placeList.get(i));
				sObject.put("userType", "10");
				sObject.put("orgType", "E");
				sObject.put("compSeq", "1000");
				sObject.put("deptSeq", "");
				
				jArray.add(sObject);
			}
			body.put("schUserList", jArray);//배열을 넣음
	

		} catch (JSONException e) {
		e.printStackTrace();
		}

		
		body.put("schmSeq", "10");
		body.put("schTitle", "마스터일정 api 테스트");
		body.put("startDate", "201807310900");
		body.put("endDate", "201807311200");
		body.put("alldayYn", "N");
		body.put("gbnCode", "M");
		body.put("gbnSeq", "");
		body.put("schGbnCode", "10");
		body.put("repeatType", "10");
		body.put("contents", "마스터일정 api 내용");
		body.put("rangeCode", "N");
		body.put("schPlace", "운영센터");
		body.put("mcalSeq", "100");
		body.put("langeCode", "kr");
//		body.put("schUserList", schUserList);
		
		companyInfo.put("bizSeq", "1000");
		companyInfo.put("compSeq", "1000");
		companyInfo.put("deptSeq", "1327");
		companyInfo.put("emailAddr", "");
		companyInfo.put("emailDomain", "");
		
		body.put("companyInfo", companyInfo);

		resultMap.put("header", header);
		resultMap.put("body", body);
		
		String data = new Gson().toJson(resultMap);
		
		
		Map<String, Object> apiResult = new HashMap<String, Object>();
		try {
    	    RequestConfig.Builder requestBuilder = RequestConfig.custom();
    	    HttpClientBuilder builder = HttpClientBuilder.create();
    	    builder.setDefaultRequestConfig(requestBuilder.build());
    	    HttpClient client = builder.build();
    	    ObjectMapper mapper = new ObjectMapper();

    	    StringEntity stringEntity = new StringEntity(data, HTTP.UTF_8);
    	    String result = "";
    	    HttpPost httpost = new HttpPost(new URI("http://gwa.tpf.kro.kr/schedule/MobileSchedule/InsertMtSchedule"));
    	    httpost.addHeader("Content-Type", "application/json");
    	    HttpResponse response;
    	    httpost.setEntity(stringEntity);
    	    

    	    response = client.execute(httpost);
    	    result = EntityUtils.toString(response.getEntity());
    	    apiResult = mapper.readValue(result, new TypeReference<Map<String, Object>>() {});

    	   
    	   
    	} catch (IOException e) {
    	    e.printStackTrace();
    	}
    	
	}
	
	/**
		 * @MethodName : deleteCalendar
		 * @author : 김찬혁
		 * @since : 2018. 8. 21.
		 * 설명 : 집합교육 일정삭제 api
		 */
	public void deleteCalendar(Map<String, Object> eduMap) throws URISyntaxException {
		
		Map<String, Object> mainMap = educationService.getGroupMainMap(eduMap);
		Map<String, Object> userInfo = new HashMap<String, Object>();
		Map<String, Object> header = new HashMap<String, Object>();
		Map<String, Object> body = new HashMap<String, Object>();
		Map<String, Object> companyInfo = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		userInfo = commonService.getCalendarEmpInfo((String) mainMap.get("manager_emp_seq"));
		
		header.put("empSeq", userInfo.get("emp_seq"));

		body.put("empSeq", userInfo.get("emp_seq"));
		body.put("schmSeq", mainMap.get("sch_seq"));
		body.put("schSeq", mainMap.get("sch_seq"));
		body.put("rangeCode", "DM");
		
		companyInfo.put("bizSeq", userInfo.get("biz_seq"));
		companyInfo.put("compSeq", userInfo.get("comp_seq"));
		companyInfo.put("deptSeq", userInfo.get("dept_seq"));
		companyInfo.put("emailAddr", userInfo.get("email_addr"));
		companyInfo.put("emailDomain", userInfo.get("homepg_addr"));
		
		body.put("companyInfo", companyInfo);

		resultMap.put("header", header);
		resultMap.put("body", body);
		
		String data = new Gson().toJson(resultMap);
		
		
		Map<String, Object> apiResult = new HashMap<String, Object>();
		try {
    	    RequestConfig.Builder requestBuilder = RequestConfig.custom();
    	    HttpClientBuilder builder = HttpClientBuilder.create();
    	    builder.setDefaultRequestConfig(requestBuilder.build());
    	    HttpClient client = builder.build();
    	    ObjectMapper mapper = new ObjectMapper();

    	    StringEntity stringEntity = new StringEntity(data, HTTP.UTF_8);
    	    String result = "";
    	    HttpPost httpost = new HttpPost(new URI("http://"+domain+"/schedule/MobileSchedule/DeleteMtSchedule"));
    	    httpost.addHeader("Content-Type", "application/json");
    	    HttpResponse response;
    	    httpost.setEntity(stringEntity);
    	    

    	    response = client.execute(httpost);
    	    result = EntityUtils.toString(response.getEntity());
    	    apiResult = mapper.readValue(result, new TypeReference<Map<String, Object>>() {});

    	   
    	   
    	} catch (IOException e) {
    	    e.printStackTrace();
    	}
    	
		
	}

}
