package com.duzon.custom.egov_cms.dao;

import java.util.List;
import java.util.Map;

import com.duzon.custom.egov_cms.dto.*;
import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@SuppressWarnings("unchecked")
@Repository
public class EtcVcatnDAO extends AbstractDAO {

	public List<Map<String, Object>> etcVacSetList() {
		return selectList("etcVcatn.etcVacSetList");
	}
	
	public List<VcatnKndDTO> etcVacCode(Map<String, Object> params) {
		return selectList("etcVcatn.etcVacCode", params);
	}
	
	public List<Map<String, Object>> getEtcVcatnList(Map<String, Object> params) {
		return selectList("etcVcatn.getEtcVcatnList", params);
	}
	
	public List<Map<String, Object>> getEtcVcatnMyList(Map<String, Object> params) {
		return selectList("etcVcatn.getEtcVcatnMyList", params);
	}
	
	public void etc1(Map<String, Object> params) {
		insert("etcVcatn.etc1", params);
	}
	
	public void etc2(Map<String, Object> params) {
		insert("etcVcatn.etc2", params);
	}
	
	public void etc3(Map<String, Object> params) {
		insert("etcVcatn.etc3", params);
	}
	
	public List<Map<String, Object>> toDayAnnvList(Map<String, Object> params){
		return selectList("etcVcatn.toDayAnnvList", params);
	}
}
