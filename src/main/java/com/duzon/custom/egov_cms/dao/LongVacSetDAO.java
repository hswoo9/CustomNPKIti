package com.duzon.custom.egov_cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;
import com.duzon.custom.egov_cms.dto.LnglbcCnwkVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;

@SuppressWarnings("unchecked")
@Repository
public class LongVacSetDAO extends AbstractDAO {

	/**
	 * 장기근속휴가설정 리스트
	 * @param params
	 * @return
	 */
	public List<LnglbcCnwkVcatnSetupDTO> getLongVacSetList(Map<String, Object> params){
		return selectList("longVacSet.getLongVacSetList", params);
	}
	
	/**
	 * 장기근속휴가설정 리스트 카운트
	 */
	public int getLongVacSetCount(Map<String, Object> params) {
		return (int)selectOne("longVacSet.getLongVacSetCount", params);
	}
	/**
	 * 장기근속휴가설정 정렬순번
	 * @return 큰 정렬순번 +1 값
	 * 		   없으면 0
	 */
	public int getLongVacSetMax() {
		return (int)selectOne("longVacSet.getLongVacSetMax");
	}
	
	/**
	 * 장기근속휴가설정 저장
	 */
	public int longVacSetSave(LnglbcCnwkVcatnSetupDTO lnglbcCnwkVcatnSetupDTO) {
		return (int)insert("longVacSet.longVacSetSave", lnglbcCnwkVcatnSetupDTO);
	}
	
	/**
	 * 장기근속휴가설정 업데이트
	 */
	public int longVacSetUpdate(LnglbcCnwkVcatnSetupDTO lnglbcCnwkVcatnSetupDTO) {
		return (int)update("longVacSet.longVacSetUpdate", lnglbcCnwkVcatnSetupDTO);
	}
	
	/**
	 * 장기근속휴가설정 삭제 (use_yn N 처리)
	 * @param lnglbcCnwkVcatnSetupSn 장기근속휴가설정 pk
	 */
	public int longVacSetDelete(String lnglbcCnwkVcatnSetupSn) {
		return (int)update("longVacSet.longVacSetDelete", lnglbcCnwkVcatnSetupSn);
	}
	
	/**
	 * 
	 */
	public LnglbcCnwkVcatnSetupDTO getLongVacSet(Map<String, Object> params) {
		return (LnglbcCnwkVcatnSetupDTO)selectOne("longVacSet.getLongVacSet", params);
	}
	
	public List<Map<String, Object>> selectEmpAllList(Map<String, Object> params){
		return selectList("longVacSet.selectEmpAllList", params);		
	}
	
	public VcatnDTO checkVcatn(Map<String, Object> params){
		return (VcatnDTO) selectOne("longVacSet.checkVcatn", params);
	}
	
}
