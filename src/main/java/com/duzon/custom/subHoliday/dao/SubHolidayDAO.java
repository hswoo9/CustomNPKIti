package com.duzon.custom.subHoliday.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@Repository
public class SubHolidayDAO extends AbstractDAO {
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> overHoliWorkSelect(){
		return (Map<String, Object>)selectOne("subHoliday.overHoliWorkSelect");
	}
	public int overHoliWorkUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.overHoliWorkUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> empInformationAdmitList(Map<String, Object> map){
		return selectList("subHoliday.empInformationAdmitList", map);
	}
	public int empInformationAdmitTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.empInformationAdmitTotal", map);
	}
	public int empSetAdmitInsert(List<Map<String, Object>> list) {
		return (Integer)insert("subHoliday.empSetAdmitInsert", list);
	}
	public int empSetAdminDeactivate(List<Map<String, Object>> list) {
		return (Integer)update("subHoliday.empSetAdminDeactivate", list);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridOverWkEmpSetList(Map<String, Object> map) {
		return selectList("subHoliday.gridOverWkEmpSetList", map);
	}
	public int gridOverWkEmpSetListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridOverWkEmpSetListTotal", map);
	}
	public int holidaySet(Map<String, Object> map) {
		return (Integer)insert("subHoliday.holidaySet", map);
	}
	public int holidaySetDeactivate(List<Map<String, Object>> list) {
		return (Integer)update("subHoliday.holidaySetDeactivate", list);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridHoliTypeList(Map<String, Object> map) {
		return selectList("subHoliday.gridHoliTypeList", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridHoliTypeList() {
		return selectList("subHoliday.gridHoliTypeList");
	}
	public int gridHoliTypeListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridHoliTypeListTotal", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWeekAgreeMin(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("subHoliday.getWeekAgreeMin", map);
	}
	public int getTypeCode(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.getTypeCode", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWeekHoliday(Map<String, Object> map){
		return (Map<String, Object>)selectOne("subHoliday.getWeekHoliday", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkTime(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("subHoliday.getWorkTime", map);
	}
	public int getBasicTimeId() {
		return (Integer)selectOne("subHoliday.getBasicTimeId");
	}
	public int getBasicTimeIdHalf() {
		return (Integer)selectOne("subHoliday.getBasicTimeIdHalf");
	}
	public String getFullHalf(Map<String, Object> map) {
		return (String)selectOne("subHoliday.getFullHalf", map);
	}
	public String fn_chkOverHoliApply(Map<String, Object> map) {
		return (String)selectOne("subHoliday.fn_chkOverHoliApply", map);
	}
	public int overWkReqInsert(Map<String, Object> map) {
		return (Integer)insert("subHoliday.overWkReqInsert", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getApplyMinMonthSum(Map<String, Object> map){
		return (Map<String, Object>)selectOne("subHoliday.getApplyMinMonthSum", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridOverWkMonthList(Map<String, Object> map){
		return selectList("subHoliday.gridOverWkMonthList", map);
	}
	public int gridOverWkMonthListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridOverWkMonthListTotal", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getCommCodeList(Map<String, Object> map){
		return selectList("subHoliday.getCommCodeList", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridOverWkReqList(Map<String, Object> map){
		return selectList("subHoliday.gridOverWkReqList", map);
	}
	public int gridOverWkReqListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridOverWkReqListTotal", map);
	}
	public int overWkApprovalUpdate(List<Map<String, Object>> list) {
		return (Integer)update("subHoliday.overWkApprovalUpdate", list);
	}
	public int holiWkCancle(Map<String, Object> map) {
		return (Integer)update("subHoliday.holiWkCancle", map);
	}
	public int holidayWkApproval(Map<String, Object> map) {
		return (Integer)insert("subHoliday.holidayWkApproval", map);
	}
	public void sp_holiday_work_approval(Map<String, Object> map) {
		selectOne("subHoliday.sp_holiday_work_approval", map);
	}
	public void sp_holiday_work_cancle(Map<String, Object> map) {
		selectOne("subHoliday.sp_holiday_work_cancle", map);
	}
	public int holiWkReqDeactivate(Map<String, Object> map) {
		return (Integer)update("subHoliday.holiWkReqDeactivate", map);
	}
	public int holiWkReqActiveY(Map<String, Object> map) {
		return (Integer)update("subHoliday.holiWkReqActiveY", map);
	}
	public int holiWkApprovalUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.holiWkApprovalUpdate", map);
	}
	public int fileUploadSave(Map<String, Object> map) {
		return (Integer)insert("subHoliday.fileUploadSave", map);
	}
	public int fileUpload(Map<String, Object> map) {
		return (Integer)update("subHoliday.fileUpload", map);
	}
	public int reportUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.reportUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getFileInfo(Map<String, Object> map){
		return (Map<String, Object>)selectOne("subHoliday.getFileInfo", map);
	}
	public int subHolidayReqInsert(Map<String, Object> map) {
		return (Integer)insert("subHoliday.subHolidayReqInsert", map);
	}
	public void subHolidayReqGroupKeyUpdate(Map<String, Object> map) {
		update("subHoliday.subHolidayReqGroupKeyUpdate", map);
	}
	public void sp_subHoliday_req(Map<String, Object> map) {
		selectOne("subHoliday.sp_subHoliday_req", map);
	}
	public void sp_subHoliday_req_select(Map<String, Object> map) {
		selectOne("subHoliday.sp_subHoliday_req_select", map);
	}
	public void sp_subHoliday_cancle(Map<String, Object> map) {
		selectOne("subHoliday.sp_subHoliday_cancle", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSubHolidayReqList(Map<String, Object> map){
		return selectList("subHoliday.gridSubHolidayReqList", map);
	}
	public int gridSubHolidayReqListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridSubHolidayReqListTotal", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSubHolidayReqListToday(Map<String, Object> map){
		return selectList("subHoliday.gridSubHolidayReqListToday", map);
	}
	public int gridSubHolidayReqListTotalToday(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridSubHolidayReqListTotalToday", map);
	}
	public int subHolidayReqDeactivate(Map<String, Object> map) {
		return (Integer)update("subHoliday.subHolidayReqDeactivate", map);
	}
	public int subHolidayReqDeactivateReject(Map<String, Object> map) {
		return (Integer)update("subHoliday.subHolidayReqDeactivateReject", map);
	}
	public int getWeekendHolidayCnt(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.getWeekendHolidayCnt", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getAgreeUseRestMinSum(Map<String, Object> map){
		return (Map<String, Object>)selectOne("subHoliday.getAgreeUseRestMinSum", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSubHolidayOccurList(Map<String, Object> map){
		return selectList("subHoliday.gridSubHolidayOccurList", map);
	}
	public int gridSubHolidayOccurListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridSubHolidayOccurListTotal", map);
	}
	public int subHoliApprovalUpdate(List<Map<String, Object>> list) {
		return (Integer)update("subHoliday.subHoliApprovalUpdate", list);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getOverHoliRestMin(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("subHoliday.getOverHoliRestMin", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> gridSubHolidayUseRestList(Map<String, Object> map){
		return selectList("subHoliday.gridSubHolidayUseRestList", map);
	}
	public Map<String, Object> subHolidayTimeTotal(Map<String, Object> map){
		return (Map<String, Object>)selectOne("subHoliday.subHolidayTimeTotal", map);
	}
	public int gridSubHolidayUseRestListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.gridSubHolidayUseRestListTotal", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> overWkExcelList(Map<String, Object> map){
		return selectList("subHoliday.overWkExcelList", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> upExcelDown(Map<String, Object> map){
		return selectList("subHoliday.upExcelDown", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> downExcelDown(Map<String, Object> map){
		return selectList("subHoliday.downExcelDown", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> allExcelDown(Map<String, Object> map){
		return selectList("subHoliday.allExcelDown", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> overWkTimeList(Map<String, Object> map) {
		return selectList("subHoliday.overWkTimeList", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> overWkList(Map<String, Object> map) {
		return selectList("subHoliday.overWkList", map);
	}
	public int overWkListTotal(Map<String, Object> map) {
		return (int) selectOne("subHoliday.overWkListTotal", map);
	}
	public void schmSeqUpdate(Map<String, Object> map) {
		update("subHoliday.schmSeqUpdate", map);
		
	}
	public void schmSeqUpdate2(Map<String, Object> map) {
		update("subHoliday.schmSeqUpdate2", map);
		
	}
	public void otApplyCancel(Map<String, Object> map) {
		update("subHoliday.otApplyCancel", map);
		
	}
	public String checkHoliTime(Map<String, Object> map) {
		return (String)selectOne("subHoliday.fn_chkOverHoliApply", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> replaceHoliCheck(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("subHoliday.replaceHoliCheck", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkTypeCode(Map<String, Object> map){
		return (Map<String, Object>) selectOne("subHoliday.getWorkTypeCode", map);
	}
	public int inputAgreeMin(Map<String, Object> map) {
		return (Integer)insert("subHoliday.inputAgreeMin", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getAgreeMin(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("subHoliday.getAgreeMin", map);
	}
	public int updateAgreeMin(Map<String, Object> map) {
		return (Integer)update("subHoliday.updateAgreeMin", map);
	}
	public int updateWorkStartEndTime(Map<String, Object> map) {
		return (Integer)update("subHoliday.updateWorkStartEndTime", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getWorkStartEndTime(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("subHoliday.getWorkStartEndTime", map);
	}
	public int getAllAdmin(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.getAllAdmin", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> defaultIframeReqList(Map<String, Object> map) {
		return selectList("subHoliday.defaultIframeReqList", map);
	}
	//////////////////////////////////////////////////////////////////////////
	public int otApplyDocStsUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.otApplyDocStsUpdate", map);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> getSubHoliReqData(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("subHoliday.getSubHoliReqData", map);
	}
	public int rehApplyDocStsUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.rehApplyDocStsUpdate", map);
	}
	//////////////////////////////////////////////////////////////////////////
	public int selectCodeUpdate(Map<String, Object> map) {
		return (Integer)update("subHoliday.selectCodeUpdate", map);
	}
	public int selectCodeUpdateN() {
		return (Integer)updateN("subHoliday.selectCodeUpdateN");
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> subHolidayReqDaySelect(Map<String, Object> map) {
		return selectList("subHoliday.subHolidayReqDaySelect", map);
	}
	public int replace_holiday_update(Map<String, Object> map) {
		return (Integer)update("subHoliday.replace_holiday_update", map);
	}
	public int replace_holiday_cancle(Map<String, Object> map) {
		return (Integer)update("subHoliday.replace_holiday_cancle", map);
	}
	public int subHolidayCompare(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.subHolidayCompare", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> SearchAttReqMainMgrList(Map<String, Object> map){
		return selectList("subHoliday.SearchAttReqMainMgrList", map);
	}
	public int SearchAttReqMainMgrListTotal(Map<String, Object> map) {
		return (Integer)selectOne("subHoliday.SearchAttReqMainMgrListTotal", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> subHolidayReqList(Map<String, Object> map) {
		return selectList("subHoliday.subHolidayReqList",map);
	}

	public int subHolidayReqListTotal(Map<String, Object> map) {
		return (int) selectOne("subHoliday.subHolidayReqListTotal",map);
	}

	public void sp_subHoliday_reject(Map<String, Object> map) {
		selectList("subHoliday.sp_subHoliday_reject", map);
	}

}
