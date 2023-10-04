package com.duzon.custom.workPlan.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@Repository
public class WorkPlanDAO extends AbstractDAO {

	/**
		 * @MethodName : workTypeList
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 리스트
		 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workTypeList(Map<String, Object> map) {
		return selectList("workPlan.workTypeList", map);
	}

	/**
		 * @MethodName : workTypeListTotal
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 리스트 토탈
		 */
	public int workTypeListTotal(Map<String, Object> map) {
		return (int) selectOne("workPlan.workTypeListTotal", map);
	}

	/**
		 * @MethodName : workTypeSave
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 저장
		 */
	public void workTypeSave(Map<String, Object> map) {
		insert("workPlan.workTypeSave", map);
		
	}

	/**
		 * @MethodName : workTypeMod
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 수정
		 */
	public void workTypeMod(Map<String, Object> map) {
		update("workPlan.workTypeMod", map);
		
	}

	/**
		 * @MethodName : workTypeDel
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 삭제
		 */
	public void workTypeDel(Map<String, Object> map) {
		update("workPlan.workTypeDel", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkPlanSts(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("workPlan.getWorkPlanSts", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> setDataSearch(Map<String, Object> map) {
		return selectList("workPlan.setDataSearch", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWorkPlanType() {
		return selectList("workPlan.getWorkPlanType");
	}

	public void workPlanMasterSave(Map<String, Object> map) {
		insert("workPlan.workPlanMasterSave", map);
		
	}

	public void workPlanDetailSave(Map<String, Object> vo) {
		insert("workPlan.workPlanDetailSave", vo);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> setNewSearch(Map<String, Object> map) {
		return selectList("workPlan.setNewSearch", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workPlanAppList(Map<String, Object> map) {
		return selectList("workPlan.workPlanAppList", map);
	}

	public int workPlanAppListTotal(Map<String, Object> map) {
		return (int) selectOne("workPlan.workPlanAppListTotal", map);
	}

	public void workPlanMasterApproval(Map<String, Object> map) {
		update("workPlan.workPlanMasterApproval", map);
		
	}

	public void workPlanDetailApproval(Map<String, Object> map) {
		update("workPlan.workPlanDetailApproval", map);
		
	}

	public void workPlanAppMasterCancel(Map<String, Object> map) {
		update("workPlan.workPlanAppMasterCancel", map);
		
	}

	public void workPlanAppDetailCancel(Map<String, Object> map) {
		update("workPlan.workPlanAppDetailCancel", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workTypeCodeList(Map<String, Object> map) {
		return selectList("workPlan.workTypeCodeList", map);
	}

	public void workPlanDetailHistorySave(Map<String, Object> vo) {
		insert("workPlan.workPlanDetailHistorySave", vo);
		
	}

	public void workPlanHistoryUpdate(Map<String, Object> map) {
		update("workPlan.workPlanHistoryUpdate", map);
		
	}

	public void workPlanHistoryChange(Map<String, Object> map) {
		insert("workPlan.workPlanHistoryChange", map);
		
	}

	public void workPlanDetailChange(Map<String, Object> map) {
		update("workPlan.workPlanDetailChange", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workPlanChangeAppList(Map<String, Object> map) {
		return selectList("workPlan.workPlanChangeAppList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workPlanChangeAppList2(Map<String, Object> map) {
		return selectList("workPlan.workPlanChangeAppList2", map);
	}

	public int workPlanChangeAppListTotal(Map<String, Object> map) {
		return (int) selectOne("workPlan.workPlanChangeAppListTotal", map);
	}

	public void workPlanDetailChangeCancel(Map<String, Object> map) {
		update("workPlan.workPlanDetailChangeCancel", map);
		
	}

	public void workPlanHistoryChangeCancel(Map<String, Object> map) {
		update("workPlan.workPlanHistoryChangeCancel", map);
		
	}

	public void workPlanDetailHistoryKeyUpdate(Map<String, Object> map) {
		update("workPlan.workPlanDetailHistoryKeyUpdate", map);
		
	}

	public void workPlanDetailChangeApproval(Map<String, Object> map) {
		update("workPlan.workPlanDetailChangeApproval", map);
		
	}

	public void workPlanHistoryChangeApproval(Map<String, Object> map) {
		update("workPlan.workPlanHistoryChangeApproval", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> adminWorkPlanDetail(Map<String, Object> map) {
		return selectList("workPlan.adminWorkPlanDetail", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> adminWorkPlanDetail2(Map<String, Object> map) {
		return selectList("workPlan.adminWorkPlanDetail2", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workPlanMasterList(Map<String, Object> map) {
		return selectList("workPlan.workPlanMasterList", map);
	}

	public int workPlanMasterListTotal(Map<String, Object> map) {
		return (int) selectOne("workPlan.workPlanMasterListTotal", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> dayOfFamilyList(Map<String, Object> map) {
		return selectList("workPlan.dayOfFamilyList", map);
	}

	public void dayOfFamilyApply(Map<String, Object> map) {
		insert("workPlan.dayOfFamilyApply", map);
		
	}

	public void workPlanWeekUpdate(Map<String, Object> map) {
		update("workPlan.workPlanWeekUpdate", map);
		
	}

	public void workPlanDateUpdate(Map<String, Object> map) {
		update("workPlan.workPlanDateUpdate", map);
		
	}

	public void dayOfFamilyApplyCancel(Map<String, Object> map) {
		update("workPlan.dayOfFamilyApplyCancel", map);
		
	}

	public void workPlanHistoryCancel(Map<String, Object> map) {
		update("workPlan.workPlanHistoryCancel", map);
		
	}

	public void workPlanDetailCancel(Map<String, Object> map) {
		update("workPlan.workPlanDetailCancel", map);
		
	}

	public void workPlanCancel(Map<String, Object> map) {
		update("workPlan.workPlanCancel", map);
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> familyDayReqLeftList(Map<String, Object> map) {
		return selectList("workPlan.familyDayReqLeftList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> familyDayReqRightList(Map<String, Object> map) {
		return selectList("workPlan.familyDayReqRightList", map);
	}

	public String makeWorkPlanYn(Map<String, Object> map) {
		return (String) selectOne("workPlan.makeWorkPlanYn", map);
		
	}

	public void autoMakeWorkPlan(Map<String, Object> map) {
		update("workPlan.autoMakeWorkPlan", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> monthLimit(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("workPlan.monthLimit", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> weekLimit(Map<String, Object> map) {
		return selectList("workPlan.weekLimit", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkMin(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("workPlan.getWorkMin", map);
	}

	public void defaultMod(Map<String, Object> map) {
		update("workPlan.defaultMod", map);
		
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getWeekCnt(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("workPlan.getWeekCnt", map);
	}

	public int getAddMin(Map<String, Object> map) {
		return (int) selectOne("workPlan.getAddMin", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWeekNo(Map<String, Object> map){
		return (Map<String, Object>)selectOne("workPlan.getWeekNo", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> checkFlexPlan(Map<String, Object> map){
		return (Map<String, Object>)selectOne("workPlan.checkFlexPlan", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> workPlanExcelList(Map<String, Object> map){
		return selectList("workPlan.workPlanExcelList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getAdminSeq(){
		return (Map<String, Object>)selectOne("workPlan.getAdminSeq");
	}
	
	public Object scheduleList(Map<String, Object> map) {
		return selectList("workPlan.scheduleList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkPlanMin(Map<String, Object> map){
		return (Map<String, Object>)selectOne("workPlan.getWorkPlanMin", map);
	}
	///////////////////////////////////////////////////////////////
	public int workPlanMasterReject(List<Map<String, Object>> list) {
		return (Integer)update("workPlan.workPlanMasterReject", list);
	}
	public int workPlanDetailReject(List<Map<String, Object>> list) {
		return (Integer)update("workPlan.workPlanDetailReject", list);
	}
	public int workPlanDocStsUpdate(Map<String, Object> map) {
		return (Integer)update("workPlan.workPlanDocStsUpdate", map);
	}
	public int workPlanChangeRejectDetailUpdate(Map<String, Object> map) {
		return (Integer)update("workPlan.workPlanChangeRejectDetailUpdate", map);
	}
	public int workPlanChangeRejectHistoryUpdate(Map<String, Object> map) {
		return (Integer)update("workPlan.workPlanChangeRejectHistoryUpdate", map);
	}
	public int workPlanChangeDocStsUpdate(Map<String, Object> map) {
		return (Integer)update("workPlan.workPlanChangeDocStsUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getWorkPlanChangeList(Map<String, Object> map) {
		return selectList("workPlan.getWorkPlanChangeList", map);
	}
}
