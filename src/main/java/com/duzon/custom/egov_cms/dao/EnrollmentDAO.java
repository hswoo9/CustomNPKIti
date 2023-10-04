package com.duzon.custom.egov_cms.dao;

import com.duzon.custom.common.dao.AbstractDAO;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;
import com.duzon.custom.egov_cms.dto.YrvacSetupDTO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
@Repository
public class EnrollmentDAO extends AbstractDAO {

	/**
	 * 휴가종류 리스트
	 */
	public List<VcatnKndDTO> getVcatnKndList(Map<String, Object> params){
		return selectList("enrollment.getVcatnKndList", params);
	}
	
	/**
	 * 휴가종류 리스트 카운트
	 */
	public Object getVcatnKndListCount(Map<String, Object> params){
		return selectOne("enrollment.getVcatnKndListCount", params);
	}

	/**
	 * 연가설정
	 */
	public int vacationSave(YrvacSetupDTO yrvacSetupDTO) {
		return (int) insert("enrollment.vacationSave", yrvacSetupDTO);
	}
	public int vacationUpdate(YrvacSetupDTO yrvacSetupDTO) {
		return (int) update("enrollment.vacationUpdate", yrvacSetupDTO);
	}
	public int vacationDelete(String yrvacSetupSn) {
		return (int) update("enrollment.vacationDelete", yrvacSetupSn);
	}
	public int getYrvacSetupMax() {
		return (int)selectOne("enrollment.getYrvacSetupMax");
	}
	public List<YrvacSetupDTO> getYrvacSetupList(Map<String, Object> params){
		return selectList("enrollment.getYrvacSetupList", params);
	}
	public Object getYrvacSetupListCount(Map<String, Object> params){
		return selectOne("enrollment.getYrvacSetupListCount", params);
	}
    public int enrollSave(VcatnKndDTO vcatnKndDTO) {
		return (int) insert("enrollment.enrollSave", vcatnKndDTO);
    }

	public List<VcatnKndDTO> enrollList(Map<String, Object> params) {
		return selectList("enrollment.enrollList", params);
	}
	
	public YrvacSetupDTO getVacation(Map<String, Object> params) {
		return (YrvacSetupDTO)selectOne("enrollment.getVacation",params);
	}

	public VcatnKndDTO enrollSelectRow(VcatnKndDTO params) {
		return (VcatnKndDTO) selectOne("enrollment.enrollSelectRow", params);
	}

	public void enrollMod(VcatnKndDTO vcatnKndDTO) {
		update("enrollment.enrollMod", vcatnKndDTO);
	}

	public void enrollDel(VcatnKndDTO vcatnKndDTO) {
		update("enrollment.enrollDel", vcatnKndDTO);
	}

	public List<VcatnKndDTO> enrollGetCode(Map<String, Object> params) {
		return selectList("enrollment.enrollGetCode", params);
	}

	public List<Map<String, Object>> enrollDocSel(Map<String, Object> params) {

		return selectList("enrollment.enrollDocSel", params);
	}

	public void specialVacSetIns(SpeclVcatnSetupDTO speclVcatnSetupDTO) {
		insert("enrollment.specialVacSetIns", speclVcatnSetupDTO);
	}

	public List<Map<String, Object>> specialVacSetList() {
		return selectList("enrollment.specialVacSetList");
	}

	public void spVacationDel(SpeclVcatnSetupDTO params) {
		update("enrollment.spVacationDel", params);
	}

	public SpeclVcatnSetupDTO specialSelectRow(SpeclVcatnSetupDTO params) {
		return (SpeclVcatnSetupDTO) selectOne("enrollment.specialSelectRow", params);
	}

	public void specialUpd(SpeclVcatnSetupDTO params) {
		update("enrollment.specialUpd", params);
	}

    public Map<String, Object> insDocCert(Map<String, Object> params) {
		insert("enrollment.insDocCert", params);
		return (Map<String, Object>) selectOne("enrollment.getDocInfo");
	}


	public void insOutProcess(Map<String, Object> map) {
		insert("enrollment.insOutProcess", map);
	}

	public void vacHistIns(VcatnUseHistDTO vcatnUseHistDTO) {
		insert("enrollment.vacHistIns", vcatnUseHistDTO);
	}

	public void vacHistUpd(Map<String, Object> map) {
		log.info("===============" + map);
		update("enrollment.vacHistUpd", map);
	}
	
	public VcatnKndDTO getvacation() {
		return (VcatnKndDTO) selectOne("enrollment.getvacation");
	}
	
	public VcatnKndDTO getvacationTwo() {
		return (VcatnKndDTO) selectOne("enrollment.getvacationTwo");
	}

    public List<Map<String, Object>> getUseVacListAll(Map<String, Object> params) {
		return selectList("enrollment.getUseVacListAll", params);
    }

	public List<Map<String, Object>> getUseDeptList() {
		return selectList("enrollment.getUseDeptList");
	}

	public List<Map<String, Object>> getUseSpcVacListAll(Map<String, Object> params) {
		return selectList("enrollment.getUseSpcVacListAll", params);
	}

	public List<Map<String, Object>> getSpcVacList(Map<String, Object> params) {
		return selectList("enrollment.getSpcVacList", params);
	}
	
	public Map<String, Object> vacationInfo(Map<String, Object> params){
//		return (Map<String, Object>) selectOne("enrollment.vacationInfo", params);
		return (Map<String, Object>) selectOne("enrollment.vacationPopInfo", params);
	}
	
	
	/* 외출/복귀 */
	public void UpdOutReturnTimeInfo(Map<String, Object> params) {
		update("enrollment.UpdOutReturnTimeInfo", params);
	}
	
	public int returnInfoInsert(Map<String, Object> params) {
		return (int) update("enrollment.returnInfoInsert", params);
	}
	
	public List<Map<String, Object>> outReturnList(Map<String, Object> params) {
		return selectList("enrollment.outReturnList", params);
	}

    public void setReturnTime(Map<String, Object> params) {
        update("enrollment.setReturnTime", params);
    }
    
    public int returnTimeCheck(Map<String, Object> params) {
		return (int) selectOne("enrollment.returnTimeCheck", params);
	}

	public Map<String, Object> getSearchAnnvYearCustom(VcatnUseHistDTO vcatnUseHistDTO) {
		return (Map<String, Object>) selectOne("enrollment.getSearchAnnvYearCustom", vcatnUseHistDTO);
	}

	public Map<String, Object> getAnnvUseSqnoCustom(VcatnUseHistDTO params){
		return (Map<String, Object>) selectOne("enrollment.getAnnvUseSqnoCustom", params);
	}

	public void insertAnnvUseCustom(VcatnUseHistDTO vcatnUseHistDTO) {
		insert("enrollment.insertAnnvUseCustom", vcatnUseHistDTO);
	}

	public Map<String, Object> getUseOutReturnInfo(Map<String, Object> params) {
		return (Map<String, Object>) selectOne("enrollment.getUseOutReturnInfo", params);
	}

	public List<Map<String, Object>> getUseOutReturnInfoList(Map<String, Object> params) {
		return selectList("enrollment.getUseOutReturnInfoList", params);
	}

	public void insOutAndReturn(Map<String, Object> data) {
		insert("enrollment.insOutAndReturn", data);
	}

	public Map<String, Object> getReqSqno() {
		return (Map<String, Object>) selectOne("enrollment.getReqSqno");
	}

	public void setOutAndReturnTAA(Map<String, Object> map) {
		insert("enrollment.setOutAndReturnTAA", map);
	}

	public void setOutAndReturnTAAR(Map<String, Object> map) {
		insert("enrollment.setOutAndReturnTAAR", map);
	}

	public void setOutAndReturnTAARD(Map<String, Object> map) {
		insert("enrollment.setOutAndReturnTAARD", map);
	}

	public Map<String, Object> getOutReturnInfoPop(Map<String, Object> params) {
		return (Map<String, Object>) selectOne("enrollment.getOutReturnInfoPop", params);
	}

	public List<Map<String, Object>> outReturnListAdmin(Map<String, Object> params) {
		return selectList("enrollment.outReturnListAdmin", params);
	}

}
