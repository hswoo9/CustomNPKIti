package com.duzon.custom.egov_cms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.duzon.custom.egov_cms.dao.EtcVcatnDAO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.service.EtcVcatnService;

@Service
public class EtcVcatnServiceImpl implements EtcVcatnService {

    @Autowired
    private EtcVcatnDAO etcVcatnDAO;

    @Override
	public List<Map<String, Object>> etcVacSetList() {
		return etcVcatnDAO.etcVacSetList();
	}
    
	@Override
	public List<VcatnKndDTO> etcVacCode(Map<String, Object> params) {
		return etcVcatnDAO.etcVacCode(params);
	}
	
	@Override
	public List<Map<String, Object>> getEtcVcatnList(Map<String, Object> params) {
		return etcVcatnDAO.getEtcVcatnList(params);
	}

	@Override
	public void etc1(Map<String, Object> params) {
		etcVcatnDAO.etc1(params);
	}

	@Override
	public void etc2(Map<String, Object> params) {
		etcVcatnDAO.etc2(params);
	}

	@Override
	public void etc3(Map<String, Object> params) {
		etcVcatnDAO.etc3(params);
	}

	@Override
	public List<Map<String, Object>> toDayAnnvList(Map<String, Object> params) {
		return etcVcatnDAO.toDayAnnvList(params);
	}
}

