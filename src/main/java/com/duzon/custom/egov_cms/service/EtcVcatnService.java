package com.duzon.custom.egov_cms.service;

import java.util.List;
import java.util.Map;

import com.duzon.custom.egov_cms.dto.VcatnKndDTO;

public interface EtcVcatnService {

    List<Map<String, Object>> etcVacSetList();
    
    List<VcatnKndDTO> etcVacCode(Map<String, Object> params);
    
    List<Map<String, Object>> getEtcVcatnList(Map<String, Object> params);
    
    void etc1(Map<String, Object> params);
    
    void etc2(Map<String, Object> params);
    
    void etc3(Map<String, Object> params);
    
    List<Map<String, Object>> toDayAnnvList(Map<String, Object> params);
}
