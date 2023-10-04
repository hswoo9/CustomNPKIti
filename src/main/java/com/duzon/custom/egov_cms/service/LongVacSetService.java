package com.duzon.custom.egov_cms.service;

import com.duzon.custom.egov_cms.dto.LnglbcCnwkVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;

import java.util.List;
import java.util.Map;

import com.duzon.custom.egov_cms.dto.YrvacSetupDTO;

public interface LongVacSetService {

	//장기근속휴가설정 리스트
	public List<LnglbcCnwkVcatnSetupDTO> longVacSetList(Map<String, Object> params);
	
	//장기근속휴가설정 저장, 수정, 삭제
	public Map<String, Object> longVacSetSave(LnglbcCnwkVcatnSetupDTO lnglbcCnwkVcatnSetupDTO, Map<String, Object> params);
	
	//장기근속휴가설정 단일 객체 가져오기
	public LnglbcCnwkVcatnSetupDTO getLongVacSet(Map<String, Object> params);
	
	public Map<String, Object> makeLongVac(Map<String, Object> params);
}
