package com.duzon.custom.workPlan.service;

import java.util.List;
import java.util.Map;

public interface WorkPlanService {

	/**
		 * @MethodName : workTypeList
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 리스트
		 */
	Map<String, Object> workTypeList(Map<String, Object> map);

	/**
		 * @MethodName : workTypeSave
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 저장
		 */
	Map<String, Object> workTypeSave(Map<String, Object> map);

	/**
		 * @MethodName : workTypeDel
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 근무유형 삭제
		 */
	Map<String, Object> workTypeDel(Map<String, Object> map);

	/**
		 * @MethodName : setDataSearch
		 * @author : gato
		 * @since : 2019. 1. 30.
		 * 설명 : 유연근무 데이터 조회
		 */
	Map<String, Object> setDataSearch(Map<String, Object> map);

	List<Map<String, Object>> getWorkPlanType();

	void workPlanUserSave(Map<String, Object> map);

	Map<String, Object> workPlanAppList(Map<String, Object> map);

	void workPlanApproval(Map<String, Object> map);

	void workPlanAppCancel(Map<String, Object> map);

	Map<String, Object> workTypeCodeList(Map<String, Object> map);

	void workPlanChange(Map<String, Object> map);

	Map<String, Object> workPlanChangeAppList(Map<String, Object> map);

	Map<String, Object> workPlanChangeAppList2(Map<String, Object> map);

	void workPlanChangeCancel(Map<String, Object> map);

	void workPlanChangeApproval(Map<String, Object> map);

	Map<String, Object> adminWorkPlanDetail(Map<String, Object> map);
	
	Map<String, Object> adminWorkPlanDetail2(Map<String, Object> map);

	Map<String, Object> workPlanMasterList(Map<String, Object> map);

	Map<String, Object> dayOfFamilyList(Map<String, Object> map);

	Map<String, Object> dayOfFamilyApply(Map<String, Object> map);

	void workPlanCancel(Map<String, Object> map);

	Map<String, Object> familyDayReqLeftList(Map<String, Object> map);

	Map<String, Object> familyDayReqRightList(Map<String, Object> map);

	Map<String, Object> getMonthLimit(Map<String, Object> map);

	Map<String, Object> getWorkMin(Map<String, Object> map);

	void defaultMod(Map<String, Object> map);
	
	Map<String, Object> getWeekNo(Map<String, Object> map);

	Map<String, Object> checkFlexPlan(Map<String, Object> map);
	
	List<Map<String, Object>> workPlanExcelList(Map<String, Object> map);
	
	Map<String, Object> getAdminSeq();
	
	Map<String, Object> scheduleList(Map<String, Object> map);

	Map<String, Object> getWorkPlanMin(Map<String, Object> map);
}
