package com.duzon.custom.egov_cms.controller;

import java.io.File;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.egov_cms.dto.SpeclDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;
import com.duzon.custom.egov_cms.service.VcatnService;
import com.duzon.custom.util.FilePath;
import com.duzon.custom.util.FileUtil2;
import com.duzon.custom.util.FileUtil3;

import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;


@Controller
public class VcatnController {
	
	private static final Logger logger = LoggerFactory.getLogger(VcatnController.class);

	@Autowired
	private VcatnService vcatnService;
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * 연가생성 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getVcatnList")
	public String getVcatnList(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("list", vcatnService.getVcatnList(params));
		return "jsonData";
	}
	
	/**
	 * 생성이력 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getVcatnCreatHistList")
	public String getVcatnCreatHistList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getVcatnCreatHistList(params));
		return "jsonData";
	}
	
	/**
	 * 사용이력 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getVcatnUseHistList")
	public String getVcatnUseHistList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getVcatnUseHistList(params));
		return "jsonData";
	}
	
	/**
	 * 연가생성 저장
	 * @param params
	 * @param vcatnDTO
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/vcatnSave")
	public String vcatnSave(@RequestParam Map<String, Object> params, VcatnDTO vcatnDTO, Model model) {
		logger.info("	c1	"+vcatnDTO.toString());
		logger.info("	c2	"+params.toString());
		model.addAttribute("object", vcatnService.vcatnSave(vcatnDTO, params));
		return "jsonData";
	}
	
	/**
	 * 연가생성 사원 정보
	 * @param vcatnSn 연가생성키
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getVcatnOne")
	public String getVcatnOne(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.getVcatnOne(params));
		return "jsonData";
	}
	
	/**
	 * 연가생성 사원 정보2
	 * @param empSeq 사원키
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/checkVcatn")
	public String checkVcatn(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.checkVcatn(params));
		return "jsonData";
	}
	
	/**
	 * 연가생성 삭제
	 * @param list 연가생성키 리스트
	 * @param vcatnSn 연가생성키
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/deleteVcatn")
	public String deleteVcatn(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.deleteVcatn(params));
		return "jsonData";
	}
	
	/**
	 * 연가생성 사원 정보
	 * @param vcatnSn 연가생성키
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/updateVcatn")
	public String updateVcatn(@RequestParam Map<String, Object> params, VcatnDTO vcatnDTO, Model model) {
		logger.info(" params "+params.toString());
		logger.info(" params "+vcatnDTO.toString());
		model.addAttribute("object", vcatnService.updateVcatn(params, vcatnDTO));
		return "jsonData";
	}
	/**
	 * 특별휴가 생성 저장
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/specialSave")
	public String specialSave(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.specialSave(params));
		return "jsonData";
	}
	
	/**
	 * 특별휴가생성 정보 조회
	 * @param vcatnSn 연가생성키
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getSpecialOne")
	public String getSpecialOne(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.getSpecialOne(params));
		return "jsonData";
	}
	
	/**
	 * 특별휴가 생성이력 및 잔여일 삭제
	 * 휴가생성 자체를 지워야하는지?? 이력 및 잔여일만 지우는지??
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/deleteSpecialVcatn")
	public String deleteSpecialVcatn(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.deleteSpecialVcatn(params));
		return "jsonData";
	}
	
	/**
	 * 특별휴가 수정
	 * @param params
	 * @param speclDTO
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/specialUpdate")
	public String specialUpdate(@RequestParam Map<String, Object> params, SpeclDTO speclDTO, Model model) {
		logger.info(" params "+params.toString());
		logger.info(" params "+speclDTO.toString());
		model.addAttribute("object", vcatnService.specialUpdate(params, speclDTO));
		return "jsonData";
	}
	
	/**
	 * 특별휴가 구분 가져오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getSpecialVacCode")
	public String getSpecialVacCode(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("object", vcatnService.getSpecialVacCode(params));
		return "jsonData";
	}
	
	/**
	 * 휴가 생성 이력 조회
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getVcatnCreatHist")
	public String getVcatnCreatHist(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
//		model.addAttribute("list", vcatnService.getVcatnCreatHist(params));
		model.addAttribute("obj", vcatnService.checkVcatn(params));
		return "jsonData";
	}
	
	
	/**
	 * 특별휴가생성 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getSpecialList")
	public String getSpecialList(@RequestParam Map<String, Object> params, Model model) {
		logger.info(" params "+params.toString());
		model.addAttribute("list", vcatnService.getSpecialList(params));
		return "jsonData";
	}

	/**
	 * 부서 리스트 가져오기
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getAllDept")
	public String getAllDept(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getAllDept(params));
		return "jsonData";
	}
	/**
	 * 개인휴가현황페이지 
	 * @param model
	 * @param request
	 * @throws NoPermissionException
	 * @return
	 */
	@RequestMapping("/vcatn/myVacation.do")
	public String myVacation(Model model, HttpServletRequest request) throws NoPermissionException {
		model.addAttribute("loginVO", commonService.commonGetEmpInfo(request));
		return "/enrollment/myVacation";
	}
	/**
	 * 개인휴가현황페이지(관리자) 
	 * @param model
	 * @param request
	 * @throws NoPermissionException
	 * @return
	 */
	@RequestMapping("/vcatn/adminVacation.do")
	public String adminVacation(Model model, HttpServletRequest request) throws NoPermissionException {
		model.addAttribute("loginVO", commonService.commonGetEmpInfo(request));
		return "/enrollment/adminVacation";
	}
	/**
	 * 개인휴가현황 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getList")
	public String getList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getList(params));
		return "jsonData";
	}
	/**
	 * 개인휴가현황 년도별 사용리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getUseList")
	public String getUseList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getUseList(params));
		return "jsonData";
	}
	/**
	 * 휴가신청 잔여 조회
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vacation/getMyVcation")
	public String getMyVcation(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getMyVcation(params));
		return "jsonData";
	}
	
    /**
	 * 개인휴가현황 -> 생성이력
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getMyHistList")
	public String getMyHistList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getMyHistList(params));
		return "jsonData";
	}
	
	/**
	 * 개인휴가현황 -> 특별휴가 사용이력
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/getSpecialUseHist")
	public String getSpecialUseHist(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.getSpecialUseHist(params));
		return "jsonData";
	}


	/**
	 * 파일 업로드
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/vcatn/fileUpload")
	private String fileUpload(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) throws Exception {
		try {
			FileUtil3 fileUtil = new FileUtil3();
			List<Map<String, Object>> fileList = fileUtil.upload2(request, "files", 8, null, params.get("vcatnUseHistSn").toString());
			model.addAttribute("obj", vcatnService.evidenceFileSave(fileList));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonData";
	}

	/**
	 * 엑셀 양식 업로드
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/vcatn/excelUpload")
	@ResponseBody
	private Map<String, Object> excelUpload(@RequestParam Map<String, Object> params, MultipartHttpServletRequest request, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String slash = "/";
		String defaultPath2 = request.getSession().getServletContext().getRealPath("/upload/") + "/";
		String originFilePath = FilePath.setFilePath(defaultPath2, slash, 8) + "original" + slash;
		MultipartFile excelFileOriginal = request.getFile("excelFile");
		try {
			File excelFile = new File(originFilePath + excelFileOriginal.getOriginalFilename());
			excelFileOriginal.transferTo(excelFile);
			logger.info("][     " + params.toString());
			resultMap = vcatnService.specialExcelUpload(excelFile, params);
			excelFile.delete();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * (개인)증빙파일 업로드 리스트
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/selectFileUploadList")
	private String selectFileUploadList(@RequestParam Map<String, Object> params, Model model) {
		model.addAttribute("list", vcatnService.selectFileUploadList(params));
		return "jsonData";
	}
	
	/**
	 * (관리자)증빙파일 삭제
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/fileDelete")
	@ResponseBody
	private Map<String, Object> fileDelete(@RequestParam Map<String, Object> params, MultipartHttpServletRequest request, Model model) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String slash = "/";
		String defaultPath2 = request.getSession().getServletContext().getRealPath("/upload/") + "/";
		String originFilePath = FilePath.setFilePath(defaultPath2, slash, 8) + "original" + slash;
		File excelFile = new File(originFilePath + params.get("fileMask"));
		if(excelFile.delete()) {
			return vcatnService.fileDelete(params);
		}else{
			resultMap.put("state", "fail");
			resultMap.put("message", "파일 삭제에 실패했습니다.");
			return resultMap;
		}
	}

	/**
	 * ZIP 파일 다운로드
	 * @param params
	 * @param response
	 */
	@RequestMapping("/vcatn/zipFileDownload.do")
	private void zipFileDownload(@RequestParam Map<String, Object> params, HttpServletResponse response) {
		logger.info("	/vcatn/zipFileDownload.do	" + params.toString());
		try {
			List<Map<String, Object>> fileList = vcatnService.getEmpSeqFileList(params);
			logger.info("	fileList	" + fileList.toString());
			FileUtil2 fileUtil = new FileUtil2();
			boolean check = fileUtil.CompressZIP(response, params, fileList);
			if(check) {
				String deleteZipName[] = new String[1];
				deleteZipName[0] = params.get("zipName").toString()+".zip";
				logger.info("deleteZipName.length - > "+deleteZipName.length);
				FileUtil3 fileUtil2 = new FileUtil3();
				fileUtil2.deleteFileZIP(deleteZipName, 8);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param map
	 * @param mv
	 * @return
	 */
	@RequestMapping("/vacation/outProcessCancel")
	public ModelAndView outProcessCancel(@RequestBody Map<String, Object> map, ModelAndView mv){
		String resultCode = "SUCCESS";
		String resultMessage = "성공하였습니다.";
		try{
			vcatnService.outProcessCancel(map);
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
	 * 연가 생성
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/makeVacation")
	public String makeVacation(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			model.addAttribute("object", vcatnService.makeVacation(params));
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}
		return "jsonData";
	}

	/**
	 * 휴가 사용 일자 조회
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/vacationUseCheck")
	public String vacationUseCheck(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			logger.info("여기야 여기" + params.toString());
			model.addAttribute("object", vcatnService.vacationUseCheck(params));
		}catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", e.getMessage());
		}
		return "jsonData";
	}
	
	/**
	 * 상신 취소
	 * @param map
	 * @param mv
	 * @return
	 */
	@RequestMapping("/vacation/outProcessReturn")
	public ModelAndView outProcessReturn(@RequestBody Map<String, Object> map, ModelAndView mv){
		String resultCode = "SUCCESS";
		String resultMessage = "성공하였습니다.";
		try{
			vcatnService.outProcessReturn(map);
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
	
	@RequestMapping("/vcatn/zipFileCheck")
	public String zipFileCheck(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			List<Map<String, Object>> fileList = vcatnService.getEmpSeqFileList(params);
			if(fileList.size() > 0) {
				model.addAttribute("state", "200");
			}else {
				model.addAttribute("state", "500");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonData";
	}

	/**
	 * 생성된 휴가 목록 가져오기
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/vacationKnds")
	public String selectVacationList(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			model.addAttribute("list", vcatnService.selectVacationList(params));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonData";
	}

	/**
	 * 전자결재 상신
	 * @param map
	 * @param mv
	 * @return
	 */
	@RequestMapping("/vacation/outProcessApplication")
	public ModelAndView outProcessApplication(@RequestBody Map<String, Object> map, ModelAndView mv){
		String resultCode = "SUCCESS";
		String resultMessage = "성공하였습니다.";
		try{
			vcatnService.outProcessApplication(map);
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
	 * 기타휴가 사용 내역 불러오기
	 * @param params
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/vcatn/vcatnUseHistSnEtc")
	public String vcatnUseHistSnEtc(@RequestParam Map<String, Object> params, HttpServletRequest request, Model model) {
		try {
			model.addAttribute("data", vcatnService.vcatnUseHistSnEtc(params));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "jsonData";
	}
	
}
