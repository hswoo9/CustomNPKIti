package com.duzon.custom.workPlan.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.subHoliday.dao.SubHolidayDAO;
import com.duzon.custom.workPlan.dao.WorkPlanDAO;
import com.duzon.custom.workPlan.service.WorkPlanService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import static jdk.nashorn.internal.runtime.GlobalFunctions.parseInt;

@Service
public class WorkPlanServiceImpl implements WorkPlanService {

	private static final Logger logger = LoggerFactory.getLogger(WorkPlanServiceImpl.class);
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private WorkPlanDAO workPlanDAO;
	@Autowired private SubHolidayDAO subHolidayDAO;

	@Override
	public Map<String, Object> workTypeList(Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.workTypeList(map)); //리스트
		result.put("totalCount", workPlanDAO.workTypeListTotal(map)); //토탈
		
		return result;
	}

	@Override
	public Map<String, Object> workTypeSave(Map<String, Object> map) {
		
		if ( StringUtils.equals( (String) map.get("work_type_id"), "0") ) {
			workPlanDAO.workTypeSave(map);
		} else {
			workPlanDAO.workTypeMod(map);
		}
		
		return map;
	}

	@Override
	public Map<String, Object> workTypeDel(Map<String, Object> map) {
		workPlanDAO.workTypeDel(map);
		return map;
	}

	@Override
	public Map<String, Object> setDataSearch(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> status = workPlanDAO.getWorkPlanSts(map);
		result.put("status", status);
		
		if ( status.get("STATUS").equals("0") ) {
			result.put("list", workPlanDAO.setNewSearch(map));
		} else {
			map.put("flex_code_id", status.get("flex_code_id"));
			result.put("list", workPlanDAO.setDataSearch(map));
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> getWorkPlanType() {
		return workPlanDAO.getWorkPlanType();
	}

	@Override
	public void workPlanUserSave(Map<String, Object> map) {
		
		Gson gson = new Gson(); 
		List<Map<String, Object>> workPlanList = gson.fromJson((String) map.get("data"),new TypeToken<List<Map<String, Object>>>(){}.getType());
		System.out.println(map);
		String empSeq = (String)map.get("empSeq");
		String worker_dept_name = (String)map.get("orgnztNm");
		String worker_position = (String)map.get("positionNm");
		String worker_duty = (String)map.get("classNm");
		String flex_code_id = (String)map.get("flex_code_id");

		if (parseInt(map.get("end_month"), 10) > parseInt(map.get("apply_month"), 10)) {
	 		// apply_month = "202504", end_month="202507" 일 경우 202504, 202505, 202506, 202507 유연근무가 생성되어야함



		}else{
			if ( map.get("pk").equals("0") ) {
				workPlanDAO.workPlanMasterSave(map);
				Long work_plan_id = (Long)map.get("work_plan_id");

				for (Map<String, Object> vo : workPlanList) {

					vo.put("empSeq", empSeq);
					vo.put("work_plan_id", work_plan_id);
					vo.put("status", "1");
					vo.put("worker_dept_name", worker_dept_name);
					vo.put("worker_position", worker_position);
					vo.put("worker_duty", worker_duty);
					vo.put("flex_code_id", flex_code_id);

					workPlanDAO.workPlanDetailSave(vo);
					workPlanDAO.workPlanDetailHistorySave(vo);

				}

			} else {

			}
		}

		
	}

	@Override
	public Map<String, Object> workPlanAppList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.workPlanAppList(map)); //리스트
		result.put("totalCount", workPlanDAO.workPlanAppListTotal(map)); //토탈
		
		return result;
		
		
	}

	@Override
	public void workPlanApproval(Map<String, Object> map) {
		Gson gson = new Gson(); 
		Map<String, Object> total = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		
		for ( String key : total.keySet() ) {
			Map<String, Object> subData = (Map<String, Object>)  total.get(key);
			subData.put("userId", (String)map.get("userId"));
			workPlanDAO.workPlanMasterApproval(subData);
			workPlanDAO.workPlanDetailApproval(subData);
			workPlanDAO.workPlanHistoryUpdate(subData);
		}
		
	}

	@Override
	public void workPlanAppCancel(Map<String, Object> map) {
		String[] work_plan_id = ((String) map.get("data")).split(",");
		for (int i = 0; i < work_plan_id.length; i++) {
			map.put("work_plan_id", work_plan_id[i]);
			workPlanDAO.workPlanAppMasterCancel(map);
			workPlanDAO.workPlanAppDetailCancel(map);
			
		}
		
	}

	@Override
	public Map<String, Object> workTypeCodeList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", workPlanDAO.workTypeCodeList(map)); //리스트
		return result;
	}

	@Override
	public void workPlanChange(Map<String, Object> map) {
		Gson gson = new Gson(); 
		Map<String, Object> total = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		
		for ( String key : total.keySet() ) {
			Map<String, Object> subData = (Map<String, Object>)  total.get(key);
			subData.put("userId", (String)map.get("userId"));
			workPlanDAO.workPlanDetailChange(subData);
			workPlanDAO.workPlanHistoryChange(subData);
			workPlanDAO.workPlanDetailHistoryKeyUpdate(subData);
		}
		
	}

	@Override
	public Map<String, Object> workPlanChangeAppList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.workPlanChangeAppList(map)); //리스트
		result.put("totalCount", workPlanDAO.workPlanChangeAppListTotal(map)); //토탈
		
		return result;
	}
	
	@Override
	public Map<String, Object> workPlanChangeAppList2(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.workPlanChangeAppList2(map)); //리스트
		//result.put("totalCount", workPlanDAO.workPlanChangeAppListTotal(map)); //토탈
		
		return result;
	}

	@Override
	public void workPlanChangeCancel(Map<String, Object> map) {
		Gson gson = new Gson(); 
		Map<String, Object> total = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		
		for ( String key : total.keySet() ) {
			Map<String, Object> subData = (Map<String, Object>)  total.get(key);
			subData.put("userId", (String)map.get("userId"));
			workPlanDAO.workPlanDetailChangeCancel(subData);
			workPlanDAO.workPlanHistoryChangeCancel(subData);
		}
		
	}

	@Override
	public void workPlanChangeApproval(Map<String, Object> map) {
		Gson gson = new Gson(); 
		Map<String, Object> total = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		
		for ( String key : total.keySet() ) {
			Map<String, Object> subData = (Map<String, Object>)  total.get(key);
			subData.put("userId", (String)map.get("userId"));
			workPlanDAO.workPlanDetailChangeApproval(subData);
			workPlanDAO.workPlanHistoryChangeApproval(subData);
			
		}
		
	}

	@Override
	public Map<String, Object> adminWorkPlanDetail(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.adminWorkPlanDetail(map)); //리스트
		
		return result;
	}
	
	@Override
	public Map<String, Object> adminWorkPlanDetail2(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.adminWorkPlanDetail2(map)); //리스트
		
		return result;
	}

	@Override
	public Map<String, Object> workPlanMasterList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", workPlanDAO.workPlanMasterList(map)); //리스트
		result.put("totalCount", workPlanDAO.workPlanMasterListTotal(map)); //토탈
		
		return result;
	}
	
	@Override
	public Map<String, Object> dayOfFamilyList(Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.dayOfFamilyList(map)); //리스트
		
		return result;
	}

	@Override
	public Map<String, Object> dayOfFamilyApply(Map<String, Object> map) {
		
		Gson gson = new Gson(); 
		Map<String, Object> total = gson.fromJson((String) map.get("data"),new TypeToken<Map<String, Object>>(){}.getType() );
		
		for ( String key : total.keySet() ) {
			Map<String, Object> subData = (Map<String, Object>)  total.get(key);
			subData.put("userId", (String)map.get("userId"));
			
			if ( subData.get("type").equals("N") ) {
				
				String makeYn = workPlanDAO.makeWorkPlanYn(subData);
				
				if ( makeYn.equals("N") ) {
					
					workPlanDAO.autoMakeWorkPlan(subData);
					
				}
				
				Map<String, Object> weekCntMap = workPlanDAO.getWeekCnt(subData);
				
				int cnt = Integer.parseInt(String.valueOf(weekCntMap.get("CNT")));
				String month = String.valueOf(weekCntMap.get("AFTER_MONTH"));
				String workTypeId = String.valueOf(weekCntMap.get("WORK_TYPE_ID"));
				
				if ( StringUtils.equals(workTypeId, "6") ) {
					
				} else {
					
					Map<String, Object> afterMonthMap = new HashMap<String, Object>();
					
					afterMonthMap.put("dateVal", month);
					afterMonthMap.put("apply_emp_seq", subData.get("apply_emp_seq"));
					
					if ( cnt < 7 ) {
						workPlanDAO.autoMakeWorkPlan(afterMonthMap);
					}
					
					int getAddMin = workPlanDAO.getAddMin(subData);
					
					subData.put("addMin", getAddMin);
					
					workPlanDAO.dayOfFamilyApply(subData);
					workPlanDAO.workPlanWeekUpdate(subData);
					workPlanDAO.workPlanDateUpdate(subData);
					
				}
				
				
			} else {
				
				int getAddMin = workPlanDAO.getAddMin(subData);
				subData.put("addMin", getAddMin);
				
				workPlanDAO.dayOfFamilyApplyCancel(subData);
				workPlanDAO.workPlanDateUpdate(subData);
				workPlanDAO.workPlanWeekUpdate(subData);
			}
			
		}
		
		
		return map;
	}

	@Override
	public void workPlanCancel(Map<String, Object> map) {
		workPlanDAO.workPlanHistoryCancel(map);
		workPlanDAO.workPlanDetailCancel(map);
		workPlanDAO.workPlanCancel(map);
	}

	@Override
	public Map<String, Object> familyDayReqLeftList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.familyDayReqLeftList(map)); //리스트
		
		return result;
	}

	@Override
	public Map<String, Object> familyDayReqRightList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", workPlanDAO.familyDayReqRightList(map)); //리스트
		
		return result;
	}

	@Override
	public Map<String, Object> getMonthLimit(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("monthLimit", workPlanDAO.monthLimit(map));
		result.put("weekLimit", workPlanDAO.weekLimit(map));
		
		return result;
	}

	@Override
	public Map<String, Object> getWorkMin(Map<String, Object> map) {
		
		return workPlanDAO.getWorkMin(map);
	}

	@Override
	public void defaultMod(Map<String, Object> map) {
		workPlanDAO.defaultMod(map);		
	}
	
	@Override
	public Map<String, Object> getWeekNo(Map<String, Object> map) {
		return workPlanDAO.getWeekNo(map);
	}

	@Override
	public Map<String, Object> checkFlexPlan(Map<String, Object> map) {
		return workPlanDAO.checkFlexPlan(map);
	}
	
	@Override
	public List<Map<String, Object>> workPlanExcelList(Map<String, Object> map) {
		return workPlanDAO.workPlanExcelList(map);
	}
	
	@Override
	public Map<String, Object> getAdminSeq() {
		return workPlanDAO.getAdminSeq();
	}
	
	@Override
	public Map<String, Object> scheduleList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> temp_map = new HashMap<String, Object>();
		temp_map = subHolidayDAO.overHoliWorkSelect();
		map.put("night_work_reward", temp_map.get("night_work_reward"));
		result.put("list", workPlanDAO.scheduleList(map)); //리스트
		
		return result;
	}
	
	@Override
	public Map<String, Object> getWorkPlanMin(Map<String, Object> map) {
		return workPlanDAO.getWorkPlanMin(map);
	}
}
