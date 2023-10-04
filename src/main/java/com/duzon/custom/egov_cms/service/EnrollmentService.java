package com.duzon.custom.egov_cms.service;

import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;
import com.duzon.custom.egov_cms.dto.YrvacSetupDTO;

import java.util.List;
import java.util.Map;

public interface EnrollmentService {

	Map<String, Object> enrollSave(VcatnKndDTO vcatnKndDTO);

    List<VcatnKndDTO> enrollList(Map<String, Object> params);
	
	public Map<String, Object> vacationSave(YrvacSetupDTO yrvacSetupDTO, Map<String, Object> params);
	Map<String, Object> yrvacSetupList(Map<String, Object> params);
	public YrvacSetupDTO getVacation(Map<String, Object> params);

    VcatnKndDTO enrollSelectRow(VcatnKndDTO params);

    void enrollMod(VcatnKndDTO vcatnKndDTO);

    void enrollDel(VcatnKndDTO vcatnKndDTO);

    List<VcatnKndDTO> enrollGetCode(Map<String, Object> params);

    List<Map<String, Object>> enrollDocSel(Map<String, Object> params);

    void specialVacSetIns(SpeclVcatnSetupDTO speclVcatnSetupDTO);

    List<Map<String, Object>> specialVacSetList();

    void spVacationDel(SpeclVcatnSetupDTO params);

    SpeclVcatnSetupDTO specialSelectRow(SpeclVcatnSetupDTO params);

    void specialUpd(SpeclVcatnSetupDTO params);

    Map<String, Object> insDocCert(Map<String, Object> params);

    void insOutProcess(Map<String, Object> params);

    void vacHistIns(VcatnUseHistDTO vcatnUseHistDTO);
    
    VcatnKndDTO getvacation();
    
    VcatnKndDTO getvacationTwo();

    List<Map<String, Object>> getUseVacListAll(Map<String, Object> map);

    List<Map<String, Object>> getUseDeptList();

    List<Map<String, Object>> getSpcVacList(Map<String, Object> params);
    
    Map<String, Object> vacationInfo(Map<String, Object> params);
    
    /* 외출/복귀 */
    void UpdOutReturnTimeInfo(Map<String, Object> params);
    List< Map<String, Object>> outReturnList(Map<String, Object> params);
    Map<String, Object> returnInfoInsert(Map<String, Object> params);

    void setReturnTime(Map<String, Object> params);

    Map<String, Object> getOutReturnInfoPop(Map<String, Object> params);

    List<Map<String, Object>> outReturnListAdmin(Map<String, Object> params);
}
