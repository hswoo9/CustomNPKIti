package com.duzon.custom.egov_cms.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.duzon.custom.egov_cms.dao.LongVacSetDAO;
import com.duzon.custom.egov_cms.dao.VcatnDAO;
import com.duzon.custom.egov_cms.dto.LnglbcCnwkVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnCreatHistDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;
import com.duzon.custom.egov_cms.service.LongVacSetService;

@Service
public class LongVacSetServiceImpl implements LongVacSetService {

    @Autowired
    private LongVacSetDAO longVacSetDAO;

    @Autowired
    private VcatnDAO vcatnDAO;
    
    /**
     * 장기근속휴가설정 리스트
     */
	@Override
	public List<LnglbcCnwkVcatnSetupDTO> longVacSetList(Map<String, Object> params) {
		return longVacSetDAO.getLongVacSetList(params);
	}

	/**
	 * 장기근속휴가설정 저장, 수정, 삭제
	 */
	@Override
	@Transactional
	public Map<String, Object> longVacSetSave(LnglbcCnwkVcatnSetupDTO lnglbcCnwkVcatnSetupDTO, Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int check = 0;
		String mode = params.get("mode").toString();
		String message = "";
		System.out.println(" 0 ");
		if(mode.equals("write")) {
			System.out.println(" 1 ");
			lnglbcCnwkVcatnSetupDTO.setSortSn(longVacSetDAO.getLongVacSetMax());
			check = longVacSetDAO.longVacSetSave(lnglbcCnwkVcatnSetupDTO);
			message = "등록되었습니다.";
		}
		if(mode.equals("update")) {
			System.out.println(" 2 ");
			check = longVacSetDAO.longVacSetUpdate(lnglbcCnwkVcatnSetupDTO);
			message = "수정되었습니다.";
		}
		if(mode.equals("delete")) {
			System.out.println(" 3 ");
			if(params.get("deleteList") != null) {
				System.out.println("뭐 들었지 "+params.get("deleteList").toString());
				String[] lnglbcCnwkVcatnSetupSn = params.get("deleteList").toString().split(",");
				for(int i = 0 ; i < lnglbcCnwkVcatnSetupSn.length ; i++) {
					check = longVacSetDAO.longVacSetDelete(lnglbcCnwkVcatnSetupSn[i]);
				}
				message = "삭제되었습니다.";
			}
		}
		if(check > 0) {
			System.out.println(" 4 ");
			resultMap.put("state","Y");
			resultMap.put("message", message);
		}else {
			System.out.println(" 5 ");
			resultMap.put("state","N");
			resultMap.put("message","실패");
		}
		return resultMap;
	}

	/**
	 * 장기근속휴가설정 단일객체
	 * @params lnglbcCnwkVcatnSetupSn
	 */
	@Override
	public LnglbcCnwkVcatnSetupDTO getLongVacSet(Map<String, Object> params) {
		return longVacSetDAO.getLongVacSet(params);
	}

	@Override
	@Transactional
	public Map<String, Object> makeLongVac(Map<String, Object> params){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String state = "";
		String message = "";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String applyYr = sdf.format(new Date());
		//사원별 부여일 가져오기
		List<Map<String, Object>> selectEmpAllList = longVacSetDAO.selectEmpAllList(params);
		if(selectEmpAllList.size() > 0) {
			for(int i = 0 ; i < selectEmpAllList.size(); i++) {
				selectEmpAllList.get(i).put("applyYr", applyYr);
				VcatnDTO checkVcatnDTO = longVacSetDAO.checkVcatn(selectEmpAllList.get(i));
				VcatnCreatHistDTO vcatnCreatHistDTO = new VcatnCreatHistDTO();
				if(checkVcatnDTO != null) {
					int sortSn = vcatnDAO.getVcatnCreatHistSortSn(checkVcatnDTO);
					checkVcatnDTO.setLnglbcVcatnFrstAlwncDaycnt(selectEmpAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpAllList.get(i).get("ALWNC_VCATN").toString());
					checkVcatnDTO.setLnglbcVcatnMdtnAlwncDaycnt("0");
					checkVcatnDTO.setLnglbcVcatnRemndrDaycnt(selectEmpAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpAllList.get(i).get("ALWNC_VCATN").toString());
					checkVcatnDTO.setLnglbcVcatnUseDaycnt("0");
					checkVcatnDTO.setLnglbcVcatnCreatResn("");
					checkVcatnDTO.setUpdusrEmplSn(999999);
					
					int sortSnSub = vcatnDAO.getVcatnCreatHistSortSn(checkVcatnDTO);
					
					vcatnCreatHistDTO.setCreatGbn("U");
					vcatnCreatHistDTO.setSortSn(sortSn);
					
					vcatnCreatHistDTO.setVcatnSn(checkVcatnDTO.getVcatnSn());
					vcatnCreatHistDTO.setVcatnKndSn(0);
					vcatnCreatHistDTO.setAlwncDaycnt(checkVcatnDTO.getLnglbcVcatnFrstAlwncDaycnt());
					vcatnCreatHistDTO.setCreatResn("");
					vcatnCreatHistDTO.setRmk("");
					vcatnCreatHistDTO.setUseYn("Y");
					vcatnCreatHistDTO.setCrtrEmplSn(999999);
				}else {
					checkVcatnDTO = new VcatnDTO();
					checkVcatnDTO.setApplyYr(applyYr);
					checkVcatnDTO.setDeptName(selectEmpAllList.get(i).get("dept_name") == null ? "null" : selectEmpAllList.get(i).get("dept_name").toString());
					checkVcatnDTO.setDeptSeq(selectEmpAllList.get(i).get("dept_seq") == null ? "null" : selectEmpAllList.get(i).get("dept_seq").toString());
					checkVcatnDTO.setEmpSeq(selectEmpAllList.get(i).get("emp_seq") == null ? "null" : selectEmpAllList.get(i).get("emp_seq").toString());
					checkVcatnDTO.setEmpName(selectEmpAllList.get(i).get("emp_name") == null ? "null" : selectEmpAllList.get(i).get("emp_name").toString());
					checkVcatnDTO.setLnglbcVcatnFrstAlwncDaycnt(selectEmpAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpAllList.get(i).get("ALWNC_VCATN").toString());
					checkVcatnDTO.setLnglbcVcatnMdtnAlwncDaycnt("0");
					checkVcatnDTO.setLnglbcVcatnRemndrDaycnt(selectEmpAllList.get(i).get("ALWNC_VCATN") == null ? "0" : selectEmpAllList.get(i).get("ALWNC_VCATN").toString());
					checkVcatnDTO.setLnglbcVcatnUseDaycnt("0");
					checkVcatnDTO.setLnglbcVcatnCreatResn("");
					checkVcatnDTO.setSpeclVcatnRemndrDaycnt("0");
					checkVcatnDTO.setSpeclVcatnUseDaycnt("0");
					checkVcatnDTO.setRmk("자동생성");
					checkVcatnDTO.setUseYn("Y");
					checkVcatnDTO.setCrtrEmplSn(999999);
					checkVcatnDTO.setSortSn(0);
					checkVcatnDTO.setYrvacFrstAlwncDaycnt("0");
					checkVcatnDTO.setYrvacMdtnAlwncDaycnt("0");
					checkVcatnDTO.setYrvacRemndrDaycnt("0");
					checkVcatnDTO.setYrvacUseDaycnt("0");
					checkVcatnDTO.setYrvacCreatResn("");
					vcatnDAO.vcatnSave(checkVcatnDTO);
					
					vcatnCreatHistDTO.setVcatnSn(checkVcatnDTO.getVcatnSn());
					vcatnCreatHistDTO.setVcatnKndSn(0);
					vcatnCreatHistDTO.setAlwncDaycnt(checkVcatnDTO.getLnglbcVcatnFrstAlwncDaycnt());
					vcatnCreatHistDTO.setCreatGbn("I");
					vcatnCreatHistDTO.setCreatResn("");
					vcatnCreatHistDTO.setSortSn(0);
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
    
}
