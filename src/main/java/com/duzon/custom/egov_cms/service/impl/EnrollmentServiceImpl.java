package com.duzon.custom.egov_cms.service.impl;

import com.duzon.custom.egov_cms.dao.EnrollmentDAO;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnKndDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;
import com.duzon.custom.egov_cms.dto.YrvacSetupDTO;
import com.duzon.custom.egov_cms.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    @Autowired
    private EnrollmentDAO enrollmentDAO;

	@Override
	public Map<String, Object> enrollSave(VcatnKndDTO vcatnKndDTO) {
		Map<String, Object> resultMap = new HashMap<>();
		String message = "";
		if(vcatnKndDTO.getVcatnType().toString().equals("V001")) {
			VcatnKndDTO checkDTO = enrollmentDAO.getvacation();
			if(checkDTO != null) {
				message = "연가가 이미 존재합니다.";
			}else {
				int check = enrollmentDAO.enrollSave(vcatnKndDTO);
				if(check > 0) {
					message = "등록되었습니다.";
				}
			}
		}/*else if(vcatnKndDTO.getVcatnGbnCmmnCd() == 683){
			VcatnKndDTO checkDTO = enrollmentDAO.getvacationTwo();
			if(checkDTO != null) {
				message = "장기근속휴가가 이미 존재합니다.";
			}else {
				int check = enrollmentDAO.enrollSave(vcatnKndDTO);
				if(check > 0) {
					message = "등록되었습니다.";
				}
			}
		}*/else {
			int check = enrollmentDAO.enrollSave(vcatnKndDTO);
			if(check > 0) {
				message = "등록되었습니다.";
			}
		}
		resultMap.put("message", message);
		return resultMap;
	}

	@Override
	public List<VcatnKndDTO> enrollList(Map<String, Object> params) {
		return enrollmentDAO.enrollList(params);
	}

	@Override
	public Map<String, Object> vacationSave(YrvacSetupDTO yrvacSetupDTO, Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int check = 0;
		String mode = params.get("mode").toString();
		String message = "";
		System.out.println(" 0 ");
		if(mode.equals("write")) {
			System.out.println(" 1 ");
			yrvacSetupDTO.setSortSn(enrollmentDAO.getYrvacSetupMax());
			check = enrollmentDAO.vacationSave(yrvacSetupDTO);
			message = "등록되었습니다.";
		}
		if(mode.equals("update")) {
			System.out.println(" 2 ");
			check = enrollmentDAO.vacationUpdate(yrvacSetupDTO);
			message = "수정되었습니다.";
		}
		if(mode.equals("delete")) {
			System.out.println(" 3 ");
			if(params.get("deleteList") != null) {
				System.out.println("뭐 들었지 "+params.get("deleteList").toString());
				String[] yrvacSetupSn = params.get("deleteList").toString().split(",");
				for(int i = 0 ; i < yrvacSetupSn.length ; i++) {
					check = enrollmentDAO.vacationDelete(yrvacSetupSn[i]);
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

	@Override
	public Map<String, Object> yrvacSetupList(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", enrollmentDAO.getYrvacSetupList(params));
		resultMap.put("totalCount", enrollmentDAO.getYrvacSetupListCount(params));
		return resultMap;
	}

	@Override
	public YrvacSetupDTO getVacation(Map<String, Object> params) {
		return enrollmentDAO.getVacation(params);
	}

	@Override
	public VcatnKndDTO enrollSelectRow(VcatnKndDTO params) {
		return enrollmentDAO.enrollSelectRow(params);
	}

	@Override
	public void enrollMod(VcatnKndDTO vcatnKndDTO) {
		enrollmentDAO.enrollMod(vcatnKndDTO);
	}

	@Override
	public void enrollDel(VcatnKndDTO vcatnKndDTO) {
		enrollmentDAO.enrollDel(vcatnKndDTO);
	}

	@Override
	public List<VcatnKndDTO> enrollGetCode(Map<String, Object> params) {
		return enrollmentDAO.enrollGetCode(params);
	}

	@Override
	public List<Map<String, Object>> enrollDocSel(Map<String, Object> params) {
		return enrollmentDAO.enrollDocSel(params);
	}

	@Override
	public void specialVacSetIns(SpeclVcatnSetupDTO speclVcatnSetupDTO) {
		enrollmentDAO.specialVacSetIns(speclVcatnSetupDTO);
	}

	@Override
	public List<Map<String, Object>> specialVacSetList() {
		return enrollmentDAO.specialVacSetList();
	}

	@Override
	public void spVacationDel(SpeclVcatnSetupDTO params) {
		enrollmentDAO.spVacationDel(params);
	}

	@Override
	public SpeclVcatnSetupDTO specialSelectRow(SpeclVcatnSetupDTO params) {
		return enrollmentDAO.specialSelectRow(params);
	}

	@Override
	public void specialUpd(SpeclVcatnSetupDTO params) {
		enrollmentDAO.specialUpd(params);
	}

	@Override
	public Map<String, Object> insDocCert(Map<String, Object> params) {

		return enrollmentDAO.insDocCert(params);
	}

	@Override
	public void insOutProcess(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<>();

		//Map<String, Object> data = enrollmentDAO.getUseOutReturnInfo(params);
		List<Map<String, Object>> data = enrollmentDAO.getUseOutReturnInfoList(params);

		if(data.size() > 0){
			for(int i = 0; i < data.size(); i++){

				Map<String, Object> sqnoMap = enrollmentDAO.getReqSqno();
				params.put("reqSqno", sqnoMap.get("req_sqno"));
				params.put("reqDate", sqnoMap.get("req_date"));


				data.get(i).put("crtrEmplSn", params.get("empSeq"));
				data.get(i).put("reqSqno", sqnoMap.get("req_sqno"));
				data.get(i).put("reqDate", sqnoMap.get("req_date"));

				params.put("startDt", data.get(i).get("VCATN_USE_STDT"));
				params.put("endDt", data.get(i).get("VCATN_USE_ENDT"));
				params.put("annvUseDayCnt", data.get(i).get("USE_DAY"));
				params.put("attTime", data.get(i).get("ATT_TIME"));

				params.put("VCATN_DEPT_SEQ", data.get(i).get("dept_seq"));
				params.put("VCATN_EMP_SEQ", data.get(i).get("emp_seq"));
				params.put("VCATN_USER_ID", data.get(i).get("login_id"));

				System.out.println("*** 1 " + data);
				System.out.println("*** 2 " + params);

				enrollmentDAO.insOutAndReturn(data.get(i));
				enrollmentDAO.insOutProcess(map);
				enrollmentDAO.vacHistUpd(params);
				enrollmentDAO.setOutAndReturnTAA(params);	/* t_at_att insert */
				enrollmentDAO.setOutAndReturnTAAR(params);	/* t_at_att_req insert */
				enrollmentDAO.setOutAndReturnTAARD(params);	/* t_at_att_req_detail insert */

			}
		}
	}

	@Override
	public void vacHistIns(VcatnUseHistDTO vcatnUseHistDTO) {
		enrollmentDAO.vacHistIns(vcatnUseHistDTO);
	}

	@Override
	public VcatnKndDTO getvacation() {
		return enrollmentDAO.getvacation();
	}
	
	@Override
	public VcatnKndDTO getvacationTwo() {
		return enrollmentDAO.getvacationTwo();
	}

	@Override
	public List<Map<String, Object>> getUseVacListAll(Map<String, Object> params) {

		if(Integer.parseInt(params.get("vacKind").toString()) == 0){
			return enrollmentDAO.getUseVacListAll(params);
		} else {
			return enrollmentDAO.getUseSpcVacListAll(params);
		}
	}

	@Override
	public List<Map<String, Object>> getSpcVacList(Map<String, Object> params) {
		return enrollmentDAO.getSpcVacList(params);
	}

	@Override
	public List<Map<String, Object>> getUseDeptList() {
		return enrollmentDAO.getUseDeptList();
	}

	@Override
	public Map<String, Object> vacationInfo(Map<String, Object> params) {
		return enrollmentDAO.vacationInfo(params);
	}
	
	
	/* 외출/복귀 페이지 */
	@Override
	public void UpdOutReturnTimeInfo(Map<String, Object> params) {
		enrollmentDAO.UpdOutReturnTimeInfo(params);
	}

	@Override
	public Map<String, Object> returnInfoInsert(Map<String, Object> params) {
		Map<String, Object> resultMap = new HashMap<>();
		String message = "";
		
		int check = enrollmentDAO.returnInfoInsert(params);
		if(check > 0) {
			message = "등록되었습니다.";
		}
		
		resultMap.put("message", message);
		return resultMap;
	}
	
	@Override
	public List<Map<String, Object>> outReturnList(Map<String, Object> params) {
		return enrollmentDAO.outReturnList(params);
	}

    @Override
    public void setReturnTime(Map<String, Object> params) {
        enrollmentDAO.setReturnTime(params);
    }

	@Override
	public Map<String, Object> getOutReturnInfoPop(Map<String, Object> params) {
		return enrollmentDAO.getOutReturnInfoPop(params);
	}

	@Override
	public List<Map<String, Object>> outReturnListAdmin(Map<String, Object> params) {
		return enrollmentDAO.outReturnListAdmin(params);
	}
}

