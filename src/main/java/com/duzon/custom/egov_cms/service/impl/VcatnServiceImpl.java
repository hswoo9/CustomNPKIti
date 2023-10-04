package com.duzon.custom.egov_cms.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.duzon.custom.common.dao.CommonDAO;
import com.duzon.custom.common.excel.ExcelRead;
import com.duzon.custom.common.excel.ExcelReadOption;
import com.duzon.custom.egov_cms.dao.EtcVcatnDAO;
import com.duzon.custom.egov_cms.dao.VcatnDAO;
import com.duzon.custom.egov_cms.dto.SpeclDTO;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnCreatHistDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;
import com.duzon.custom.egov_cms.service.VcatnService;

@Service
public class VcatnServiceImpl implements VcatnService {

    @Autowired
    private VcatnDAO vcatnDAO;
    
    @Autowired
    private EtcVcatnDAO etcVcatnDAO;

    @Autowired
    private CommonDAO commonDAO;
    /**
	 * 연가생성리스트
	 */
	@Override
	public List<VcatnDTO> getVcatnList(Map<String, Object> params) {
		return vcatnDAO.getVcatnList(params);
	}
	
	/**
	 * 생성이력
	 */
	@Override
	public List<VcatnCreatHistDTO> getVcatnCreatHistList(Map<String, Object> params) {
		return vcatnDAO.getVcatnCreatHistList(params);
	}
	
	/**
	 * 사용이력
	 */
	@Override
	public List<VcatnUseHistDTO> getVcatnUseHistList(Map<String, Object> params) {
		return vcatnDAO.getVcatnUseHistList(params);
	}

	/**
	 * 저장
	 */
	@Override
	@Transactional
	public Map<String, Object> vcatnSave(VcatnDTO vcatnDTO, Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		//생성된 휴가가 존재하는지 조회
		VcatnDTO resultVcatnDTO = vcatnDAO.checkVcatn(params);
		if(resultVcatnDTO != null) {
			resultMap.put("message", "해당 사원의 휴가가 이미 존재합니다.");
			return resultMap;
		}else{
			//연가 최초 부여일 + 연가 조정부여일
			int yrvacDayCnt = (Integer.parseInt(vcatnDTO.getYrvacFrstAlwncDaycnt()) + Integer.parseInt(vcatnDTO.getYrvacMdtnAlwncDaycnt()));
			//장기근속휴가 최초 부여일
			//int yrvacDayCnt2 = (Integer.parseInt(vcatnDTO.getLnglbcVcatnFrstAlwncDaycnt()) + Integer.parseInt(vcatnDTO.getLnglbcVcatnMdtnAlwncDaycnt()));
			vcatnDTO.setYrvacRemndrDaycnt(Integer.toString(yrvacDayCnt));
			//vcatnDTO.setLnglbcVcatnRemndrDaycnt(Integer.toString(yrvacDayCnt2));
			int check = vcatnDAO.vcatnSave(vcatnDTO);
			if(check > 0) {
				//연가 최초 생성
				//생성이력 최초 등록
				VcatnCreatHistDTO vcatnCreatHistDTO = new VcatnCreatHistDTO();
				//휴가 기본키
				vcatnCreatHistDTO.setVcatnSn(vcatnDTO.getVcatnSn());
				//휴가종류SN 추 후 변경
				//vcatnCreatHistDTO.setVcatnKndSn(Integer.parseInt(params.get("vcatnKndSn").toString()));
				vcatnCreatHistDTO.setVcatnKndSn(params.get("vcatnKndSn") == null ? 0 : Integer.parseInt(params.get("vcatnKndSn").toString()));
				//부여일
				vcatnCreatHistDTO.setAlwncDaycnt(Integer.toString(yrvacDayCnt));
				//생성구분 최초 I 
				vcatnCreatHistDTO.setCreatGbn("I");
				//생성사유
				vcatnCreatHistDTO.setCreatResn(vcatnDTO.getYrvacCreatResn() == null ? "" : vcatnDTO.getYrvacCreatResn());
				//정렬순서 최초 저장이니 0
				vcatnCreatHistDTO.setSortSn(0);
				//비고
				vcatnCreatHistDTO.setRmk(params.get("rmk") == null ? "" : params.get("rmk").toString());
				//사용여부
				vcatnCreatHistDTO.setUseYn("Y");
				//생성자SN
				vcatnCreatHistDTO.setCrtrEmplSn(vcatnDTO.getCrtrEmplSn());
				vcatnDAO.VcatnCreatHistSave(vcatnCreatHistDTO);
				
				//장기근속휴가생성
				/*VcatnCreatHistDTO vcatnCreatHistDTO2 = new VcatnCreatHistDTO();
				//휴가기본키
				vcatnCreatHistDTO2.setVcatnSn(vcatnDTO.getVcatnSn());
				//휴가종류SN 추 후 변경
				//vcatnCreatHistDTO2.setVcatnKndSn(Integer.parseInt(params.get("vcatnKndSn").toString()));
				vcatnCreatHistDTO2.setVcatnKndSn(params.get("vcatnKndSnTwo") == null ? 0 : Integer.parseInt(params.get("vcatnKndSnTwo").toString()));
				//부여일
				vcatnCreatHistDTO2.setAlwncDaycnt(Integer.toString(yrvacDayCnt2));
				//생성구분 최초 I 
				vcatnCreatHistDTO2.setCreatGbn("U");
				//사유
				vcatnCreatHistDTO2.setCreatResn(vcatnDTO.getLnglbcVcatnCreatResn() == null ? "" : vcatnDTO.getLnglbcVcatnCreatResn());
				//정렬순서 바로 다음이니 1
				vcatnCreatHistDTO2.setSortSn(1);
				//비고
				vcatnCreatHistDTO2.setRmk(params.get("rmk") == null ? "" : params.get("rmk").toString());
				//사용여부
				vcatnCreatHistDTO2.setUseYn("Y");
				//생성자SN
				vcatnCreatHistDTO2.setCrtrEmplSn(vcatnDTO.getCrtrEmplSn());
				vcatnDAO.VcatnCreatHistSave(vcatnCreatHistDTO2);*/
				
				
				resultMap.put("message", "등록되었습니다.");
			}
		}
		//vcatnDAO.checkVcatnCreatHist(params);
		
		return resultMap;
	}

	/**
	 * 연가생성 사원 정보
	 * @param vcatnSn 연가생성키
	 */
	@Override
	public VcatnDTO getVcatnOne(Map<String, Object> params) {
		return vcatnDAO.getVcatnOne(params);
	}

	
	/**
	 * 연가생성 삭제
	 * use_yn = n
	 */
	@Override
	@Transactional
	public Map<String, Object> deleteVcatn(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		if(params.get("list") != null) {
			System.out.println("뭐 들었지 "+params.get("list").toString());
			String[] vcatnSn = params.get("list").toString().split(",");
			for(int i = 0 ; i < vcatnSn.length ; i++) {
				vcatnDAO.deleteVcatn(vcatnSn[i]);
				//중첩반복문 써서 바꿀필요가 있는지 흠
				//vcatnDAO.deleteVcatnCreatHist(yrvacSetupSn[i]);
				//vcatnDAO.deleteVcatnUseHist(yrvacSetupSn[i]);
			}
			message = "삭제되었습니다.";
		}else {
			message = "삭제할 데이터가 없습니다.";
		}
		resultMap.put("message", message);
		return resultMap;
	}

	/**
	 * 연가생성 수정
	 * @param params
	 * @param vcatnDTO
	 * @return
	 */
	@Override
	@Transactional
	public Map<String, Object> updateVcatn(Map<String, Object> params, VcatnDTO vcatnDTO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		//연가 최초 부여일 + 연가 조정부여일
		int yrvacDayCnt = (Integer.parseInt(vcatnDTO.getYrvacFrstAlwncDaycnt()) + Integer.parseInt(vcatnDTO.getYrvacMdtnAlwncDaycnt()));
		//장기근속휴가 최초 부여일
		//int yrvacDayCnt2 = (Integer.parseInt(vcatnDTO.getLnglbcVcatnFrstAlwncDaycnt()) + Integer.parseInt(vcatnDTO.getLnglbcVcatnMdtnAlwncDaycnt()));
		vcatnDTO.setYrvacRemndrDaycnt(Integer.toString(yrvacDayCnt));
		//vcatnDTO.setLnglbcVcatnRemndrDaycnt(Integer.toString(yrvacDayCnt2));
		int check = vcatnDAO.updateVcatn(vcatnDTO);
		if(check > 0) {
			//생성이력 정렬순번가져오기
			int sortSn = vcatnDAO.getVcatnCreatHistSortSn(vcatnDTO);
			//생성이력 등록
			VcatnCreatHistDTO vcatnCreatHistDTO = new VcatnCreatHistDTO();
			//휴가 기본키
			vcatnCreatHistDTO.setVcatnSn(vcatnDTO.getVcatnSn());
			//휴가종류SN 추 후 변경
			//vcatnCreatHistDTO.setVcatnKndSn(Integer.parseInt(params.get("vcatnKndSn").toString()));
			vcatnCreatHistDTO.setVcatnKndSn(0);
			//부여일
			vcatnCreatHistDTO.setAlwncDaycnt(Integer.toString(yrvacDayCnt));
			//생성구분 최초 I 
			vcatnCreatHistDTO.setCreatGbn("U");
			//생성사유
			vcatnCreatHistDTO.setCreatResn(vcatnDTO.getYrvacCreatResn() == null ? "" : vcatnDTO.getYrvacCreatResn());
			//정렬순서 최초 저장이니 0
			vcatnCreatHistDTO.setSortSn(sortSn);
			//비고
			vcatnCreatHistDTO.setRmk(params.get("rmk") == null ? "" : params.get("rmk").toString());
			//사용여부
			vcatnCreatHistDTO.setUseYn("Y");
			//생성자SN
			vcatnCreatHistDTO.setCrtrEmplSn(vcatnDTO.getCrtrEmplSn());
			vcatnDAO.VcatnCreatHistSave(vcatnCreatHistDTO);
			
			//장기근속휴가생성
			/*VcatnCreatHistDTO vcatnCreatHistDTO2 = new VcatnCreatHistDTO();
			//휴가기본키
			vcatnCreatHistDTO2.setVcatnSn(vcatnDTO.getVcatnSn());
			//휴가종류SN 추 후 변경
			//vcatnCreatHistDTO2.setVcatnKndSn(Integer.parseInt(params.get("vcatnKndSn").toString()));
			vcatnCreatHistDTO2.setVcatnKndSn(1);
			//부여일
			vcatnCreatHistDTO2.setAlwncDaycnt(Integer.toString(yrvacDayCnt2));
			//생성구분 최초 I 
			vcatnCreatHistDTO.setCreatGbn("U");
			//사유
			vcatnCreatHistDTO.setCreatResn(vcatnDTO.getLnglbcVcatnCreatResn() == null ? "" : vcatnDTO.getLnglbcVcatnCreatResn());
			//정렬순서 바로 다음이니 1
			vcatnCreatHistDTO.setSortSn(sortSn+1);
			//비고
			vcatnCreatHistDTO.setRmk(params.get("rmk") == null ? "" : params.get("rmk").toString());
			//사용여부
			vcatnCreatHistDTO.setUseYn("Y");
			//생성자SN
			vcatnCreatHistDTO.setCrtrEmplSn(vcatnDTO.getCrtrEmplSn());
			vcatnDAO.VcatnCreatHistSave(vcatnCreatHistDTO);*/
			message = "수정되었습니다.";
		}else {
			message = "수정중 오류가 발생했습니다.";
		}
		resultMap.put("message", message);
		return resultMap;
	}

	
	/**
	 * 특별휴가 생성
	 */
	@SuppressWarnings("unchecked")
	@Override
	@Transactional
	public Map<String, Object> specialSave(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		String message2 = "";
		//다중
		if(params.get("saveEmpList") != null) {
			try {
				String[] saveEmpList = params.get("saveEmpList").toString().split(",");
				for(int i = 0 ; i < saveEmpList.length ; i++) {
					Map<String, Object> empInfo = vcatnDAO.empInfo(saveEmpList[i]);
					Map<String, Object> checkMap = new HashMap<String, Object>();
					checkMap.put("empSeq", empInfo.get("emp_seq").toString());
					checkMap.put("speclVcatnSetupSn", params.get("speclVcatnSetupSn").toString());
					Map<String, Object> reduplicationCheck = vcatnDAO.reduplicationCheck(checkMap);
					if(reduplicationCheck == null) {
						SpeclDTO speclDTO = new SpeclDTO();
						speclDTO.setDeptName(empInfo.get("dept_name").toString());
						speclDTO.setDeptSeq(empInfo.get("dept_seq").toString());
						speclDTO.setEmpSeq(empInfo.get("emp_seq").toString());
						speclDTO.setEmpName(empInfo.get("emp_name").toString());
						speclDTO.setAlwncDaycnt(Integer.parseInt(params.get("speclVcatnRemndrDaycnt").toString()));
						speclDTO.setRmk(params.get("rmk").toString());
						//정렬순번
						int sortSn = vcatnDAO.getSpeclSortSn(saveEmpList[i]);
						speclDTO.setSortSn(sortSn);
						speclDTO.setCrtrEmplSn(Integer.parseInt(params.get("crtrEmplSn").toString()));
						speclDTO.setSpeclVcatnSetupSn( Integer.parseInt(params.get("speclVcatnSetupSn").toString()));
						vcatnDAO.specialSave(speclDTO);
					}else {
						message2 += empInfo.get("dept_name").toString() + " : " + empInfo.get("emp_name").toString() + "\n";
					}
				}
				message = "등록되었습니다.";
				
			}catch (Exception e) {
				e.printStackTrace();
				message = "등록중 오류발생";
				resultMap.put("message", message + "\n" + e.getMessage());
				return resultMap;
			}
		}
		//단일
		if(params.get("saveEmpList") == null && params.get("empSeq") != null) {
			Map<String, Object> empInfo = vcatnDAO.empInfo(params.get("empSeq").toString());
			Map<String, Object> checkMap = new HashMap<String, Object>();
			checkMap.put("empSeq", empInfo.get("emp_seq").toString());
			checkMap.put("speclVcatnSetupSn", params.get("speclVcatnSetupSn").toString());
			Map<String, Object> reduplicationCheck = vcatnDAO.reduplicationCheck(checkMap);
			if(reduplicationCheck == null) {
				SpeclDTO speclDTO = new SpeclDTO();
				speclDTO.setDeptName(empInfo.get("dept_name").toString());
				speclDTO.setDeptSeq(empInfo.get("dept_seq").toString());
				speclDTO.setEmpSeq(empInfo.get("emp_seq").toString());
				speclDTO.setEmpName(empInfo.get("emp_name").toString());
				speclDTO.setAlwncDaycnt(Integer.parseInt(params.get("speclVcatnRemndrDaycnt").toString()));
				speclDTO.setRmk(params.get("rmk").toString());
				//정렬순번
				int sortSn = vcatnDAO.getSpeclSortSn(params.get("empSeq").toString());
				speclDTO.setSortSn(sortSn);
				speclDTO.setCrtrEmplSn(Integer.parseInt(params.get("crtrEmplSn").toString()));
				speclDTO.setSpeclVcatnSetupSn( Integer.parseInt(params.get("speclVcatnSetupSn").toString()));
				vcatnDAO.specialSave(speclDTO);
				message = "등록되었습니다.";
			}else {
				message = "해당 사원에 휴가가 존재합니다.";
			}
			
		}
		if(params.get("saveEmpList") == null && params.get("empSeq") == null){
			message = "등록할 사원이 없습니다.";
		}
		
		resultMap.put("message", message);
		if(message2 != ""){
			message2 += "미등록 대상입니다.\n사유 : 중복된 휴가";
			resultMap.put("message2", message2);
		}
		return resultMap;
	}

	/**
	 * 특별휴가 정보조회
	 * 생성이력에서 특별휴가 관련 조인 
	 */
	@Override
	public Map<String, Object> getSpecialOne(Map<String, Object> params) {
		return vcatnDAO.getSpecialOne(params);
	}

	/**
	 * 특별휴가 생성이력 삭제
	 */
	/*
	@Override
	@Transactional
	public Map<String, Object> deleteSpecialVcatn(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		if(params.get("list") != null) {
			String[] deleteVcatnCreatHistSn = params.get("list").toString().split(",");
			Map<String, Object> vcatnCreatHistSn = new HashMap<String, Object>();
			for(int i = 0 ; i < deleteVcatnCreatHistSn.length ; i++) {
				//생성이력키 조회
				vcatnCreatHistSn = vcatnDAO.getSpecialVcatnKey(deleteVcatnCreatHistSn[i]);
				if(vcatnCreatHistSn != null) {
					//생성이력 N 처리
					vcatnDAO.deleteSpecialHist(vcatnCreatHistSn.get("vcatnCreatHistSn").toString());
					//휴가 특별휴가 0 처리
					vcatnDAO.specialDelete(vcatnCreatHistSn.get("vcatnSn").toString());
				}
				message = "삭제되었습니다.";
			}
		}else {
			message = "삭제중 오류가 발생했습니다.";
		}
		resultMap.put("message", message);
		return resultMap;
	}
	*/
	/**
	 * 특별휴가 생성이력 삭제2
	 */
	@Override
	@Transactional
	public Map<String, Object> deleteSpecialVcatn(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		if(params.get("list") != null) {
			try {
				String[] deleteList = params.get("list").toString().split(",");
				for(int i = 0 ; i < deleteList.length ; i++) {
					vcatnDAO.deleteSpecl(deleteList[i]);
				}
				message = "삭제되었습니다.";
			}catch (Exception e) {
				e.printStackTrace();
				message = "삭제중 오류가 발생했습니다.\n" + e.getMessage();
				resultMap.put("message", message);
				return resultMap;
			}
		}
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	@Transactional
	public Map<String, Object> specialUpdate(Map<String, Object> params, SpeclDTO speclDTO) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		try {
			vcatnDAO.updateSpecl(speclDTO);
			message = "수정되었습니다.";
		}catch (Exception e) {
			e.printStackTrace();
			message = "수정중 오류가 발생했습니다.\n" + e.getMessage();
		}
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public SpeclVcatnSetupDTO getSpecialVacCode(Map<String, Object> params) {
		return vcatnDAO.getSpecialVacCode(params);
	}

	@Override
	public VcatnDTO checkVcatn(Map<String, Object> params) {
		return vcatnDAO.checkVcatn(params);
	}

	@Override
	public List<VcatnCreatHistDTO> getVcatnCreatHist(Map<String, Object> params) {
		return vcatnDAO.getVcatnCreatHist(params);
	}

	@Override
	public VcatnUseHistDTO vcatnUseHistSave(VcatnUseHistDTO vcatnUseHistDTO) {
		return null;
	}

	@Override
	public List<Map<String, Object>> getSpecialList(Map<String, Object> params) {
		return vcatnDAO.getSpecialList(params);
	}

	/**
	 * 부서리스트 가져오기
	 */
	@Override
	public List<Map<String, Object>> getAllDept(Map<String, Object> params) {
		return vcatnDAO.getAllDept(params);
	}

	/**
	 * 개인휴가현황 리스트
	 */
	@Override
	public List<Map<String, Object>> getList(Map<String, Object> params) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		resultList.addAll(vcatnDAO.getList(params));
		//resultList.addAll(vcatnDAO.getLnglbcList(params));
		resultList.addAll(vcatnDAO.getSpecialList(params));
		//resultList.addAll(vcatnDAO.getSpecialMyList(params));
		return resultList;
	}
	
	/**
	 * 개인휴가현황 사용리스트
	 */
	@Override
	public List<Map<String, Object>> getUseList(Map<String, Object> params) {
		return vcatnDAO.getUseList(params);
	}

	@Override
	public List<Map<String, Object>> getMyVcation(Map<String, Object> params) {
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		if(params.get("type") != null) {
			int type = Integer.parseInt(params.get("type").toString());
			//연가
			if(type == 1) {
				resultList = vcatnDAO.getMyVcation(params);
			}
			//장기근속
			if(type == 2) {
				resultList = vcatnDAO.getMyVcation(params);
			}
			//특별휴가
			if(type == 3) {
				return vcatnDAO.getSpecialMyList(params);
			}
			if(type == 4) {
				return etcVcatnDAO.getEtcVcatnMyList(params);
			}
		}else {
			
		}
		return resultList;
	}

	
	/**
	 * 개인휴가현황 특별휴가 사용리스트
	 */
	@Override
	public List<Map<String, Object>> getSpecialUseHist(Map<String, Object> params) {
		return vcatnDAO.getSpecialUseHist(params);
	}

	@Override
	@Transactional
	public Map<String, Object> evidenceFileSave(List<Map<String, Object>> fileList) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String message = "";
		if(fileList.size() > 0) {
			try {
				for(Map<String, Object> map : fileList) {
					vcatnDAO.evidenceFileSave(map);
				}
				message = "등록되었습니다.";
			}catch (Exception e) {
				e.printStackTrace();
				message = "등록중 오류발생\n"+e.getMessage();
			}
		}
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> getMyHistList(Map<String, Object> params) {
		return vcatnDAO.getMyHistList(params);
	}

	@Override
	@Transactional
	public Map<String, Object> specialExcelUpload(File file, Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String speclVcatnSetupSn = params.get("vcatnGbnNameExcel").toString();
		String state = "";
		String message = "";
		String message2 = "";
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(file.getAbsolutePath());
		excelReadOption.setOutputColumns("A","B","C");
		excelReadOption.setStartRow(2);
		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		if(excelContent.size() > 0) {
			for(Map<String, String> article : excelContent) {
				String empName = article.get("A") == null ? "" : article.get("A").toString();
				String empSeq = article.get("B") == null ? "" : article.get("B").replace(".00", "");
				if(empName != "" && empSeq != "") {
					Map<String, Object> empMap = new HashMap<String, Object>();
					empMap.put("emp_name", empName);
					empMap.put("notIn", "ok");
					empMap.put("skip", "0");
					empMap.put("pageSize", "10");
					List<Map<String, Object>> empList = commonDAO.empInformation(empMap);
					System.out.println("empList size : "+empList.size());
					if(empList.size() > 0 && empSeq.equals(article.get("B").replace(".00", ""))) {
						//특별휴가 체크
						Map<String, Object> checkMap = new HashMap<String, Object>();
						checkMap.put("empSeq", empList.get(0).get("emp_seq").toString());
						checkMap.put("speclVcatnSetupSn", speclVcatnSetupSn);
						Map<String, Object> reduplicationCheck = vcatnDAO.reduplicationCheck(checkMap);
						if(reduplicationCheck == null) {
							SpeclDTO speclDTO = new SpeclDTO();
							speclDTO.setEmpSeq(empList.get(0).get("emp_seq").toString());
							speclDTO.setEmpName(empList.get(0).get("emp_name").toString());
							speclDTO.setDeptName(empList.get(0).get("dept_name").toString());
							speclDTO.setDeptSeq(empList.get(0).get("dept_seq").toString());
							speclDTO.setAlwncDaycnt(Integer.parseInt(article.get("C").toString().replace(".00", "")));
							speclDTO.setSpeclVcatnSetupSn(Integer.parseInt(speclVcatnSetupSn));
							speclDTO.setSortSn(0);
							speclDTO.setRmk(params.get("remark").toString());
							speclDTO.setCrtrEmplSn(Integer.parseInt(params.get("crtrEmplSn").toString()));
							vcatnDAO.specialSave(speclDTO);
						}else{
							message2 += reduplicationCheck.get("DEPT_NAME") + " : " + reduplicationCheck.get("EMP_NAME") + "\n";
						}
					}
				}else{
					Map<String, Object> empMap = new HashMap<String, Object>();
					empMap.put("notIn", "ok");
					empMap.put("skip", "0");
					empMap.put("pageSize", "100");
					List<Map<String, Object>> empList = commonDAO.empInformation(empMap);
					for(int j = 0 ; j < empList.size() ; j++) {
						if(empList.size() > 0 && empSeq.equals(article.get("B").replace(".00", ""))) {
							//특별휴가 체크
							Map<String, Object> checkMap = new HashMap<String, Object>();
							checkMap.put("empSeq", empList.get(j).get("emp_seq").toString());
							checkMap.put("speclVcatnSetupSn", speclVcatnSetupSn);
							Map<String, Object> reduplicationCheck = vcatnDAO.reduplicationCheck(checkMap);
							if(reduplicationCheck == null) {
								SpeclDTO speclDTO = new SpeclDTO();
								speclDTO.setEmpSeq(empList.get(j).get("emp_seq").toString());
								speclDTO.setEmpName(empList.get(j).get("emp_name").toString());
								speclDTO.setDeptName(empList.get(j).get("dept_name").toString());
								speclDTO.setDeptSeq(empList.get(j).get("dept_seq").toString());
								speclDTO.setAlwncDaycnt(Integer.parseInt(article.get("C").toString().replace(".00", "")));
								speclDTO.setSpeclVcatnSetupSn(Integer.parseInt(speclVcatnSetupSn));
								speclDTO.setSortSn(0);
								speclDTO.setRmk(params.get("remark").toString());
								speclDTO.setCrtrEmplSn(Integer.parseInt(params.get("crtrEmplSn").toString()));
								vcatnDAO.specialSave(speclDTO);
							}else{
								message2 += reduplicationCheck.get("DEPT_NAME") + " : " + reduplicationCheck.get("EMP_NAME") + "\n";
							}
						}
					}
				}
			}
			state = "success";
			message = "등록되었습니다.";
		}else {
			state = "fail";
			message = "등록할 데이터가 없습니다.";
		}
		if(message2 != "") {
			message2 += "미등록 대상입니다.\n사유 : 중복된 휴가";
			resultMap.put("message2", message2);
		}
		resultMap.put("state", state);
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectFileUploadList(Map<String, Object> params) {
		return vcatnDAO.selectFileUploadList(params);
	}
	
	@Override
	public Map<String, Object> fileDelete(Map<String, Object> params){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String state = "";
		String message = "";
		int check = vcatnDAO.fileDelete(params);
		if(check > 0) {
			state = "success";
			message = "삭제되었습니다.";
		}else {
			state = "fail";
			message = "데이터 삭제에 실패했습니다.";
		}
		resultMap.put("state", state);
		resultMap.put("message", message);
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> getEmpSeqFileList(Map<String, Object> params) {
		return vcatnDAO.getEmpSeqFileList(params);
	}

	@Override
	public void outProcessCancel(Map<String, Object> params) {
		vcatnDAO.outProcessCancel(params);
	}

	@Override
	public Map<String, Object> makeVacation(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String state = "";
		String message = "";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String applyYr = sdf.format(new Date());
		
		List<Map<String, Object>> selectEmpYrvacAllList = vcatnDAO.selectEmpYrvacAllList(params);
		if(selectEmpYrvacAllList.size() > 0) {
			for(int i = 0 ; i < selectEmpYrvacAllList.size(); i++) {
				Map<String, Object> searchMap = new HashMap<String, Object>();
				searchMap.put("empSeq", selectEmpYrvacAllList.get(i).get("emp_seq"));
				searchMap.put("applyYr", applyYr);
				VcatnDTO vcatnDTO = vcatnDAO.checkVcatn(searchMap);
				VcatnCreatHistDTO vcatnCreatHistDTO = new VcatnCreatHistDTO();
				if(vcatnDTO != null) {
					vcatnDTO.setApplyYr(applyYr);
					vcatnDTO.setDeptName(selectEmpYrvacAllList.get(i).get("dept_name").toString());
					vcatnDTO.setDeptSeq(selectEmpYrvacAllList.get(i).get("dept_seq").toString());
					vcatnDTO.setEmpSeq(selectEmpYrvacAllList.get(i).get("emp_seq").toString());
					vcatnDTO.setEmpName(selectEmpYrvacAllList.get(i).get("emp_name").toString());
					vcatnDTO.setYrvacFrstAlwncDaycnt(selectEmpYrvacAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpYrvacAllList.get(i).get("ALWNC_VCATN").toString());
					vcatnDTO.setYrvacMdtnAlwncDaycnt("0");
					vcatnDTO.setYrvacRemndrDaycnt(selectEmpYrvacAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpYrvacAllList.get(i).get("ALWNC_VCATN").toString());
					vcatnDTO.setYrvacUseDaycnt("0");
					vcatnDTO.setRmk("자동생성");
					vcatnDTO.setUpdusrEmplSn(999999);
					
					vcatnDAO.updateVcatn(vcatnDTO);
					
					int sortSn = vcatnDAO.getVcatnCreatHistSortSn(vcatnDTO);
					vcatnCreatHistDTO.setCreatGbn("U");
					vcatnCreatHistDTO.setSortSn(sortSn);
					vcatnCreatHistDTO.setVcatnSn(vcatnDTO.getVcatnSn());
					vcatnCreatHistDTO.setVcatnKndSn(params.get("vcatnKndSn") == null ? 0 : Integer.parseInt(params.get("vcatnKndSn").toString()));
					vcatnCreatHistDTO.setAlwncDaycnt(vcatnDTO.getYrvacFrstAlwncDaycnt());
					vcatnCreatHistDTO.setCreatResn("");
					vcatnCreatHistDTO.setRmk("");
					vcatnCreatHistDTO.setUseYn("Y");
					vcatnCreatHistDTO.setCrtrEmplSn(999999);
				}else {
					vcatnDTO = new VcatnDTO();
					
					vcatnDTO.setApplyYr(applyYr);
					vcatnDTO.setDeptName(selectEmpYrvacAllList.get(i).get("dept_name").toString());
					vcatnDTO.setDeptSeq(selectEmpYrvacAllList.get(i).get("dept_seq").toString());
					vcatnDTO.setEmpSeq(selectEmpYrvacAllList.get(i).get("emp_seq").toString());
					vcatnDTO.setEmpName(selectEmpYrvacAllList.get(i).get("emp_name").toString());
					vcatnDTO.setYrvacFrstAlwncDaycnt(selectEmpYrvacAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpYrvacAllList.get(i).get("ALWNC_VCATN").toString());
					vcatnDTO.setYrvacMdtnAlwncDaycnt("0");
					vcatnDTO.setYrvacRemndrDaycnt(selectEmpYrvacAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpYrvacAllList.get(i).get("ALWNC_VCATN").toString());
					vcatnDTO.setYrvacUseDaycnt("0");
					vcatnDTO.setYrvacCreatResn("");
					vcatnDTO.setLnglbcVcatnFrstAlwncDaycnt("0");
					vcatnDTO.setLnglbcVcatnMdtnAlwncDaycnt("0");
					vcatnDTO.setLnglbcVcatnRemndrDaycnt("0");
					vcatnDTO.setLnglbcVcatnUseDaycnt("0");
					vcatnDTO.setLnglbcVcatnCreatResn("");
					vcatnDTO.setSpeclVcatnRemndrDaycnt("0");
					vcatnDTO.setSpeclVcatnUseDaycnt("0");
					vcatnDTO.setUseYn("Y");
					
					vcatnDTO.setSortSn(0);
					
					vcatnDTO.setRmk("자동생성");
					vcatnDTO.setCrtrEmplSn(999999);
					
					vcatnDAO.vcatnSave(vcatnDTO);
					
					int sortSn = vcatnDAO.getVcatnCreatHistSortSn(vcatnDTO);
					vcatnCreatHistDTO.setVcatnSn(vcatnDTO.getVcatnSn());
					vcatnCreatHistDTO.setVcatnKndSn(params.get("vcatnKndSn") == null ? 0 : Integer.parseInt(params.get("vcatnKndSn").toString()));
					vcatnCreatHistDTO.setAlwncDaycnt(vcatnDTO.getYrvacFrstAlwncDaycnt());
					vcatnCreatHistDTO.setCreatGbn("I");
					vcatnCreatHistDTO.setCreatResn("");
					vcatnCreatHistDTO.setSortSn(sortSn);
					vcatnCreatHistDTO.setRmk("");
					vcatnCreatHistDTO.setUseYn("Y");
					vcatnCreatHistDTO.setCrtrEmplSn(999999);
				}
				vcatnDAO.VcatnCreatHistSave(vcatnCreatHistDTO);
			}
		}
		resultMap.put("state", state);
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public Map<String, Object> vacationUseCheck(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String state = "";
		String message = "";
		int check = vcatnDAO.vacationUseCheck(params);
		if(check > 0) {
			state = "500";
			message = "해당 일자에 휴가가 이미 존재합니다.";
		}else {
			state = "200";
		}
		resultMap.put("state", state);
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public void outProcessReturn(Map<String, Object> params) {
		vcatnDAO.outProcessReturn(params);
	}

	@Override
	public List<Map<String, Object>> selectVacationList(Map<String, Object> params) {
		return vcatnDAO.selectVacationList(params);
	}
	
	@Override
	public void outProcessApplication(Map<String, Object> params) {
		vcatnDAO.outProcessApplication(params);
	}

	@Override
	public void makeMonthlyLeave(Map<String, Object> params) {
		vcatnDAO.makeMonthlyLeave(params);
	}

	@Override
	public Map<String, Object> vcatnUseHistSnEtc(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		vcatnDAO.vcatnUseHistSnEtc(params);
		return resultMap;
	}
}
