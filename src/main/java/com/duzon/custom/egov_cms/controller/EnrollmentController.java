package com.duzon.custom.egov_cms.controller;


import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;
import com.duzon.custom.egov_cms.dto.YrvacSetupDTO;
import com.duzon.custom.egov_cms.service.EnrollmentService;
import com.duzon.custom.outprocess.service.OutProcessService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EnrollmentController {

    private static final Logger logger = LoggerFactory.getLogger(EnrollmentController.class);

    @Autowired
    private EnrollmentService enrollmentService;

    @Autowired
	private CommonService commonService;

    @Resource(name = "OutProcessService")
	OutProcessService outProcessService;

    /**
     * 외출/복귀 페이지
     * @param request
     * @param model
     * @return
	 * @throws NoPermissionException
     */
    @RequestMapping("/enrollment/outReturnInfo")
    public String outReturnInfo(HttpServletRequest request, Model model) throws NoPermissionException {
    	model.addAttribute("loginVO", commonService.commonGetEmpInfo(request));
        return "/enrollment/outReturnInfo";
    }

	/**
	 * 외출/복귀 관리자 페이지
	 * @param request
	 * @param model
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/enrollment/outReturnInfoAdminView")
	public String outReturnInfoAdminView(HttpServletRequest request, Model model) throws NoPermissionException {
		model.addAttribute("loginVO", commonService.commonGetEmpInfo(request));
		return "/enrollment/outReturnInfoAdminView";
	}

    /**
     * 외출시간 등록
     * @param params
     * @param model
	 * @param request
     * @return
     */
    @RequestMapping("/enrollment/UpdOutReturnTimeInfo")
	public String UpdOutReturnTimeInfo(@RequestParam Map<String, Object> params, Model model, HttpServletRequest request) {

		enrollmentService.UpdOutReturnTimeInfo(params);

		model.addAttribute("ms", "수정되었습니다");

		return "jsonData";
	}

    /**
     * 복귀시간 등록
     * @param params
     * @param model
	 * @param request
     * @return
     */
    @RequestMapping("/enrollment/returnInfoInsert")
	public String returnInfoInsert(@RequestParam Map<String, Object> params, Model model, HttpServletRequest request) {
    	
		try{
			model.addAttribute("check", enrollmentService.returnInfoInsert(params));
		} catch(Exception e){
			e.printStackTrace();
		}
		return "jsonData";
	}

    /**
     * 외출/복귀 리스트 불러오기
     * @param params
	 * @param model
     * @return
     */
    @RequestMapping("/enrollment/outReturnList")
	public String outReturnList(@RequestParam Map<String, Object> params, Model model) {

		List<Map<String, Object>> list = new ArrayList<>();
		list = enrollmentService.outReturnList(params);

		model.addAttribute("list", list);
		return "jsonData";
	}

    /**
     * 휴가 종류 등록
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/enrollment/enrollment")
    public String enrollment(HttpServletRequest request, Model model) {
        return "/enrollment/enrollment";
    }

    /**
     * 휴가종류 등록 > 휴가등록 값 불러오기
     * @param params
	 * @param model
     * @return
     */
    @RequestMapping("/enrollment/enrollList")
	public String vcatnKndList(@RequestParam Map<String, Object> params, Model model) {

		List<VcatnKndDTO> list = new ArrayList<>();
		list = enrollmentService.enrollList(params);

		model.addAttribute("list", list);
		return "jsonData";
	}

    /**
	 * 휴가 종류 Row 조회
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/enrollSelectRow")
	public String enrollSelectRow(VcatnKndDTO params, Model model){

		VcatnKndDTO vcatnKndDTO = new VcatnKndDTO();
		vcatnKndDTO = enrollmentService.enrollSelectRow(params);

		model.addAttribute("rs", vcatnKndDTO);

		return "jsonData";
	}

	/**
	 * 휴가종류 등록
	 * @param vcatnKndDTO
	 * @param model
	 * @param request
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/enrollment/enrollSave")
	public String enrollSave(VcatnKndDTO vcatnKndDTO, Model model, HttpServletRequest request) throws NoPermissionException{
		//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
		Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
		vcatnKndDTO.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));
		try{
			model.addAttribute("check", enrollmentService.enrollSave(vcatnKndDTO));
		} catch(Exception e){
			e.printStackTrace();
		}
		return "jsonData";
	}

	/**
	 * 휴가종류 수정
	 * @param vcatnKndDTO
	 * @param request
	 * @throws NoPermissionException
	 * @return
	 */
	@RequestMapping("/enrollment/enrollMod")
	public String enrollMod(VcatnKndDTO vcatnKndDTO, HttpServletRequest request) throws NoPermissionException{
		//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
		//vcatnKndDTO.setUpdusrEmplSn(Integer.parseInt(loginVO.getUniqId()));
		Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
		vcatnKndDTO.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));
		enrollmentService.enrollMod(vcatnKndDTO);

		return "jsonData";
	}

	/**
	 * 휴가 종류 삭제
	 * @param vcatnKndDTO
	 * @return
	 */
	@RequestMapping("/enrollment/enrollDel")
	public String enrollDel(VcatnKndDTO vcatnKndDTO){
		enrollmentService.enrollDel(vcatnKndDTO);

		return "jsonData";
	}

    /**
	 * 연가 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/vacationSet.do")
	public String vacationSet(HttpServletRequest request, Model model) {
		model.addAttribute("vcation", enrollmentService.getvacation());
		return "/enrollment/vacationSet";
	}

	/**
	 * 연가 설정 리스트 불러오기
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/yrvacSetupList.do")
	@ResponseBody
	public Map<String, Object> yrvacSetupList(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		return enrollmentService.yrvacSetupList(params);
	}

	/**
	 * 연가 내용 저장
	 * @param params
	 * @param yrvacSetupDTO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/vacationSave")
	@ResponseBody
	public Map<String, Object> vacationSave(@RequestParam Map<String, Object> params, YrvacSetupDTO yrvacSetupDTO, HttpServletRequest request, Model model) {
		logger.info(" [] "+yrvacSetupDTO.toString());
		logger.info(" [] "+params.toString());
		return enrollmentService.vacationSave(yrvacSetupDTO, params);
	}

	/**
	 * 연가 내용 불러오기
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/getVacation")
	@ResponseBody
	public YrvacSetupDTO getVacation(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		logger.info(" [] "+params.toString());
		return enrollmentService.getVacation(params);
	}

    /**
     * 특별휴가 설정
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/enrollment/specialVacSet.do")
    public String specialVacSet(HttpServletRequest request, Model model) {
        return "/enrollment/specialVacSet";
    }

    /**
	 * 특별 휴가 구분 값 (RMK) 가져오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/getRmk")
	public String getRmk(VcatnKndDTO params, Model model){

		VcatnKndDTO vcatnKndDTO = new VcatnKndDTO();
		vcatnKndDTO = enrollmentService.enrollSelectRow(params);

		model.addAttribute("rs", vcatnKndDTO);

		return "jsonData";
	}

	/**
	 * 특별 휴가 설정 데이터 조회
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/specialVacSetList")
	public String specialVacSetList(Model model){
		model.addAttribute("rs", enrollmentService.specialVacSetList());
		return "jsonData";
	}

    /**
     * 특별휴가 코드 조회
     * @param params
     * @param model
     * @return
     */
    @RequestMapping("/enrollment/specialVacCode")
    public String specialVacCode(@RequestParam Map<String, Object> params, Model model){

        List<VcatnKndDTO> vcatnKndDTOs = new ArrayList<>();
        vcatnKndDTOs = enrollmentService.enrollGetCode(params);

        model.addAttribute("rs", vcatnKndDTOs);

        return "jsonData";
    }

    /**
     * 사후관리 Check > 신청서 조회
     * @param params
     * @param model
     * @return
     */
    @RequestMapping("/enrollment/enrollDocSel")
    public String enrollDocSel(@RequestParam Map<String, Object> params, Model model){
        List<Map<String, Object>> map = enrollmentService.enrollDocSel(params);

        model.addAttribute("rs", map);
        return "jsonData";
    }

    /**
	 * 특별휴가설정 추가
	 * @param speclVcatnSetupDTO
	 * @param model
	 * @param request
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/enrollment/specialVacSetIns")
	public String specialVacSetIns(SpeclVcatnSetupDTO speclVcatnSetupDTO, Model model, HttpServletRequest request) throws NoPermissionException{

		//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
		//speclVcatnSetupDTO.setCrtrEmplSn(Integer.parseInt(loginVO.getUniqId()));
		Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
		speclVcatnSetupDTO.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));
		enrollmentService.specialVacSetIns(speclVcatnSetupDTO);

		return "jsonData";
	}

	/**
	 * 특별휴가 설정 데이터 삭제
	 * @param params
	 * @param model
	 * @param request
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/enrollment/spVacationDel")
	public String spVacationDel(SpeclVcatnSetupDTO params, Model model, HttpServletRequest request) throws NoPermissionException{
		//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
		//params.setUpdusrEmplSn(Integer.parseInt(loginVO.getUniqId()));
		Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
		params.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));
		enrollmentService.spVacationDel(params);

		return "jsonData";
	}

	/**
	 * 특별휴가 선택한 값(1행) 조회
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/specialSelectRow")
	public String specialSelectRow(SpeclVcatnSetupDTO params, Model model){

		SpeclVcatnSetupDTO speclVcatnSetupDTO = new SpeclVcatnSetupDTO();
		speclVcatnSetupDTO = enrollmentService.specialSelectRow(params);

		model.addAttribute("rs", speclVcatnSetupDTO);
		return "jsonData";
	}

	/**
	 * 특별휴가 수정
	 * @param params
	 * @param model
	 * @param request
	 * @return
	 * @throws NoPermissionException
	 */
	@RequestMapping("/enrollment/specialUpd")
	public String specialUpd(SpeclVcatnSetupDTO params, Model model, HttpServletRequest request) throws NoPermissionException{
		//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
		//params.setUpdusrEmplSn(Integer.parseInt(loginVO.getUniqId()));
		Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
		params.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));

		enrollmentService.specialUpd(params);

		return "jsonData";
	}

	/**
	 * 연가 생성
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/vacationCr.do")
	public String vacationCr(HttpServletRequest request, Model model) {
		model.addAttribute("vcation", enrollmentService.getvacation());
		return "/enrollment/vacationCr";
	}

	/**
	 * 장기근속휴가 설정
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/specialVacCr.do")
	public String specialVacCr(HttpServletRequest request, Model model) {
		return "/enrollment/specialVacCr";
	}

    /**
	 * 휴가 신청
	 * @return
	 */
	@RequestMapping("/enrollment/vacationApp.do")
	public String vacationApp() {
		return "/enrollment/vacationApp";
	}

	/**
	 * Method	:	GET
	 * params	:	processId	프로세스 id
	 * 				approKey	외부시스템 연동키
	 * 				docId		전자결재 id
	 * 				docSts		전자결재 상태(임시보관:10, 상신결재:20, 반려:100, 종결:90, 삭제:999)
	 * 				userId		로그인 사용자 키
	 * @param map
	 * @param request
	 * @return
	 */
	@RequestMapping("/vacation/outProcessSel")
	public ModelAndView outProcessSel(@RequestParam Map<String, Object> map, HttpServletRequest request) {
		logger.info("vacation/outProcessSel");
		ModelAndView mv = new ModelAndView();
		System.out.println(map);
		String resultCode = "SUCCESS";
		String resultMessage = "성공하였습니다.";
		try{
			Map<String, Object> resultMap = outProcessService.outProcessSel(map);
			mv.addObject("title", resultMap.get("title"));
			mv.addObject("content", resultMap.get("content"));
		}catch(Exception e){
			logger.info(e.getMessage());
			resultCode = "FAIL";
			resultMessage = "연계 정보 갱신 오류 발생("+e.getMessage()+")";
		}
		mv.addObject("resultCode", resultCode);
		mv.addObject("resultMessage", resultMessage);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 결재문서 정보 저장
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/insDocCert")
	public String insDocCert(@RequestParam Map<String, Object> params, Model model){
		Map<String, Object> map = new HashMap<>();

		map = enrollmentService.insDocCert(params);

		model.addAttribute("rs", map);
		return "jsonData";
	}

	/**
	 * Method	:	POST
	 * params	:	processId	프로세스 id
	 * 				approKey	외부시스템 연동키
	 * 				docId		전자결재 id
	 * 				docSts		전자결재 상태(임시보관:10, 상신결재:20, 반려:100, 종결:90, 삭제:999)
	 * 				userId		로그인 사용자 키
	 * @param map
	 * @param mv
	 * @return
	 */
	@RequestMapping("/vacation/outProcessUpd")
	public ModelAndView outProcessUpd(@RequestBody Map<String, Object> map, ModelAndView mv){
		logger.info("vacation/outProcessUpd");
		System.out.println("@@@@@@@@@@@@@"+map);

		String resultCode = "SUCCESS";
		String resultMessage = "성공하였습니다.";


		try{
			enrollmentService.insOutProcess(map);
		}catch(Exception e){
			logger.info(e.getMessage());
			resultCode = "FAIL";
			resultMessage = "연계 정보 갱신 오류 발생("+e.getMessage()+")";
		}

		mv.addObject("resultCode", resultCode);
		mv.addObject("resultMessage", resultMessage);
		mv.setViewName("jsonView");
		return mv;
	}

	/**
	 * 휴가신청 결재 상신
	 * @param vcatnUseHistDTO
	 * @param request
	 */
	@RequestMapping("/vacation/newVacSet")
	public void newVacSet(VcatnUseHistDTO vcatnUseHistDTO, HttpServletRequest request){

		try{
			//LoginVO loginVO = (LoginVO) request.getSession(true).getAttribute("loginVO");
			//vcatnUseHistDTO.setCrtrEmplSn(Integer.parseInt(loginVO.getUniqId()));
			Map<String, Object> loginVO = commonService.commonGetEmpInfo(request);
			vcatnUseHistDTO.setCrtrEmplSn(Integer.parseInt(loginVO.get("empSeq").toString()));
			enrollmentService.vacHistIns(vcatnUseHistDTO);
		} catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 연차 사용내역, 잔여일수 등 불러오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/vacationInfo")
	public String vacationInfo(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("obj", enrollmentService.vacationInfo(params));
		return "jsonData";
	}

	/**
	 * 관리자 휴가 페이지
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/enrollment/adminVacList.do")
	public String adminVacList(Model model, HttpServletRequest request){
		//model.addAttribute("loginVO", (LoginVO) request.getSession(true).getAttribute("loginVO"));
		return "/enrollment/adminVacList";
	}

	/**
	 * 휴가사용현황 리스트 불러오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getUseVacList")
	public String getUseVacList(@RequestParam Map<String,Object> params, Model model){

		System.out.println("@@@@@" + params);
		List<Map<String, Object>> listMap = new ArrayList<>();
		listMap = enrollmentService.getUseVacListAll(params);

		model.addAttribute("list", listMap);

		return "jsonData";
	}

	/**
	 * 사용 부서 리스트 가져오기
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getUseDeptList")
	public String getUseDeptList(Model model){
		List<Map<String, Object>> listMap = new ArrayList<>();
		listMap = enrollmentService.getUseDeptList();

		int tot_cnt = 0;
		for(Map<String, Object> map : listMap){
			tot_cnt += Integer.parseInt(map.get("grp_cnt").toString());
		}

		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		map.put("dept_name", "합계");
		map.put("grp_cnt", tot_cnt);
		list.add(map);

		for(Map<String, Object> mapTo : listMap){
			list.add(mapTo);
		}

		model.addAttribute("list", list);

		return "jsonData";
	}

	/**
	 * @param yrvacSetupDTO
	 * @param mode
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/check.do")
	@ResponseBody
	public Map<String, Object> check(YrvacSetupDTO yrvacSetupDTO, @RequestParam("mode") String mode, HttpServletRequest request, Model model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		logger.info(""+yrvacSetupDTO.toString());
		logger.info("[ "+mode);
		return resultMap;
	}

	/**
	 * 특별휴가 리스트 가져오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getSpcVacList")
	public String getSpcVacList(@RequestParam Map<String, Object> params, Model model){

		List<Map<String, Object>> list = enrollmentService.getSpcVacList(params);

		model.addAttribute("list", list);

		return "jsonData";
	}

	/**
	 * 복귀시간 등록
	 * @param params
	 * @param model
	 * @return
	 */
    @RequestMapping("/enrollment/setReturnTime")
    public String setReturnTime(@RequestParam Map<String, Object> params, Model model){
        enrollmentService.setReturnTime(params);

        model.addAttribute("ms", "복귀가 완료되었습니다.");
        return "jsonView";
    }

	/**
	 * 외출시간 등록
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/enrollment/setOutTime")
	public String setOutTime(@RequestParam Map<String, Object> params, Model model){
		enrollmentService.setOutTime(params);

		model.addAttribute("ms", "외출이 완료되었습니다.");
		return "jsonView";
	}

	@RequestMapping("/enrollment/outReturnModPop")
	public String outReturnModPop(@RequestParam Map<String, Object> params, Model model){
		model.addAttribute("obj", enrollmentService.getOutReturnInfoPop(params));
		return "jsonView";
	}

	@RequestMapping("/enrollment/outReturnListAdmin")
	public String outReturnListAdmin(@RequestParam Map<String, Object> params, Model model) {

		List<Map<String, Object>> list = new ArrayList<>();
		list = enrollmentService.outReturnListAdmin(params);

		model.addAttribute("list", list);
		return "jsonData";
	}
}
