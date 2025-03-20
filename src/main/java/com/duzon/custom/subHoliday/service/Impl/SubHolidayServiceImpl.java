package com.duzon.custom.subHoliday.service.Impl;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.common.service.CommonService;
import com.duzon.custom.common.utiles.CtApi;
import com.duzon.custom.common.vo.MessageVO;
import com.duzon.custom.common.vo.ScheduleVO;
import com.duzon.custom.subHoliday.dao.SubHolidayDAO;
import com.duzon.custom.subHoliday.service.SubHolidayService;
import com.google.gson.Gson;

@Service
public class SubHolidayServiceImpl implements SubHolidayService{
	private static final Logger logger = LoggerFactory.getLogger(SubHolidayServiceImpl.class);
	
	@Value("#{bizboxa['BizboxA.fileRootPath']}")
	private String fileRootPath;
	
	@Value("#{bizboxa['BizboxA.holiWkReq_report']}")
	private String holiWkReq_report;
	
	@Autowired private SubHolidayDAO subHolidayDAO;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	public Map<String, Object> overHoliWorkSelect() {
		return subHolidayDAO.overHoliWorkSelect();
	}
	@Override
	public int overHoliWorkUpdate(Map<String, Object> map) {
		return subHolidayDAO.overHoliWorkUpdate(map);
	}
	@Override
	public List<Map<String, Object>> empInformationAdmitList(Map<String, Object> map) {
		return subHolidayDAO.empInformationAdmitList(map);
	}
	@Override
	public int empInformationAdmitTotal(Map<String, Object> map) {
		return subHolidayDAO.empInformationAdmitTotal(map);
	}
	@Override
	public int empSetAdmitInsert(List<Map<String, Object>> list) {
		return subHolidayDAO.empSetAdmitInsert(list);
	}
	@Override
	public int empSetAdminDeactivate(List<Map<String, Object>> list) {
		return subHolidayDAO.empSetAdminDeactivate(list);
	}
	@Override
	public List<Map<String, Object>> gridOverWkEmpSetList(Map<String, Object> map) {
		return subHolidayDAO.gridOverWkEmpSetList(map);
	}
	@Override
	public int gridOverWkEmpSetListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridOverWkEmpSetListTotal(map);
	}
	@Override
	public int holidaySet(Map<String, Object> map) {
		return subHolidayDAO.holidaySet(map);
	}
	@Override
	public int holidaySetDeactivate(List<Map<String, Object>> list) {
		return subHolidayDAO.holidaySetDeactivate(list);
	}
	@Override
	public List<Map<String, Object>> gridHoliTypeList(Map<String, Object> map) {
		return subHolidayDAO.gridHoliTypeList(map);
	}
	@Override
	public List<Map<String, Object>> gridHoliTypeList() {
		return subHolidayDAO.gridHoliTypeList();
	}
	@Override
	
	public int gridHoliTypeListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridHoliTypeListTotal(map);
	}
	@Override
	public Map<String, Object> getWorkTime(Map<String, Object> map) {
		Map<String, Object> weekHoliday = subHolidayDAO.getWeekHoliday(map);
		String week = String.valueOf(weekHoliday.get("week"));
		String holiday = String.valueOf(weekHoliday.get("holiday"));
		String workType = String.valueOf(weekHoliday.get("workType"));
		boolean isHoly = false;
		if(StringUtils.equals(workType, "0") && ( StringUtils.equals(week, "5") 
											   || StringUtils.equals(week, "6") 
											   || !StringUtils.equals(holiday, "0") )) {
			isHoly = true;
		}else if(StringUtils.equals(workType, "6")) {
			isHoly = true;
		}
		/*if( StringUtils.equals(week, "5") || StringUtils.equals(week, "6") || !StringUtils.equals(holiday, "0") || StringUtils.equals(workType, "6")) {
			weekHoliday.put("holiday", true);
			return weekHoliday;
		}*/
		if(isHoly) {
			weekHoliday.put("holiday", true);
			return weekHoliday;
		}
		
		Map<String, Object> resultMap = subHolidayDAO.getWorkTime(map);
		if(resultMap == null) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("basic", true);
			String fullHalf = subHolidayDAO.getFullHalf(map);
			if(fullHalf.equals("FULL")) {
				resultMap.put("work_type_id", subHolidayDAO.getBasicTimeId());
				resultMap.put("attend_time", "09:00");
				resultMap.put("leave_time", "18:00");
			}else if(fullHalf.equals("HALF")) {
				resultMap.put("work_type_id", subHolidayDAO.getBasicTimeIdHalf());
				resultMap.put("attend_time", "09:00");
				resultMap.put("leave_time", "14:00");
			}
		}
		return resultMap;
	}
	@Override
	public String fn_chkOverHoliApply(Map<String, Object> map) {
		return subHolidayDAO.fn_chkOverHoliApply(map);
	}
	@Override
	public int overWkReqInsert(Map<String, Object> map, MultipartHttpServletRequest multi) {
		int result = subHolidayDAO.overWkReqInsert(map);
		return result;
	}
	@Override
	public Map<String, Object> getApplyMinMonthSum(Map<String, Object> map) {
		return subHolidayDAO.getApplyMinMonthSum(map);
	}
	@Override
	public List<Map<String, Object>> gridOverWkMonthList(Map<String, Object> map) {
		return subHolidayDAO.gridOverWkMonthList(map);
	}
	@Override
	public int gridOverWkMonthListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridOverWkMonthListTotal(map);
	}
	@Override
	public Map<String, Object> getWeekAgreeMin(Map<String, Object> map) {
		return subHolidayDAO.getWeekAgreeMin(map);
	}
	@Override
	public int getTypeCode(Map<String, Object> map) {
		return subHolidayDAO.getTypeCode(map);
	}
	@Override
	public Map<String, Object> getWeekHoliday(Map<String, Object> map) {
		return subHolidayDAO.getWeekHoliday(map);
	}
	@Override
	public List<Map<String, Object>> getCommCodeList(Map<String, Object> map) {
		return subHolidayDAO.getCommCodeList(map);
	}
	@Override
	public List<Map<String, Object>> gridOverWkReqList(Map<String, Object> map){
		return subHolidayDAO.gridOverWkReqList(map);
	}
	@Override
	public int gridOverWkReqListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridOverWkReqListTotal(map);
	}
	@Override
	public int overWkApprovalUpdate(List<Map<String, Object>> list) {
		int n = subHolidayDAO.overWkApprovalUpdate(list);
		/*for(Map<String, Object> map : list) {
			String otTypeCodeKr = (String)map.get("ot_type_code_kr");
			if(otTypeCodeKr.equals("휴일")) {
				String approvalStatus = (String)map.get("approval_status");
				if(approvalStatus.equals("2")) {
					//subHolidayDAO.holidayWkApproval(map);
					//subHolidayDAO.sp_holiday_work_approval(map);
				}else if(approvalStatus.equals("1")) {
					//subHolidayDAO.sp_holiday_work_cancle(map);
					subHolidayDAO.holiWkReqDeactivate(map);
					subHolidayDAO.holiWkCancle(map);
				}
			} else {
				String approvalStatus = (String)map.get("approval_status");
				if ( approvalStatus.equals("1") ) {
					subHolidayDAO.holiWkReqDeactivate(map);
				}
			}
		}*/
		for(Map<String, Object> map : list) {
			String approvalStatus = (String)map.get("approval_status");
			Object after_action_report_id = map.get("after_action_report_id");
			if(approvalStatus.equals("1")) {
				subHolidayDAO.holiWkReqDeactivate(map);//승인취소시 인정시간 쌓인 결과테이블 비활성화시키기
				if(after_action_report_id != null && after_action_report_id != "") {
					subHolidayDAO.holiWkCancle(map);//파업업로드한 테이블 컬럼 비활성화시키기
				}
			}
		}
		return n;
	}
	@Override
	public int holiWkApprovalUpdate(Map<String, Object> map, MultipartHttpServletRequest multi) {
		List<MultipartFile> fileList = multi.getFiles("file");
		int fileSeq = 0;
		int result = 0;
		for(MultipartFile mFile : fileList) {
			String fileName = mFile.getOriginalFilename();
			if(fileName.equals("")) {
				continue;
			}else {
				int n = subHolidayDAO.holiWkApprovalUpdate(map);
				if(n>0) {
					result = fileUploadService(fileSeq++, mFile, map);
					map.put("report_id_column", "after_action_report_id");
					map.put("report_id", map.get("attach_file_id"));
					subHolidayDAO.reportUpdate(map);
				}else {
					result = -1;
				}
			}
		}
		return result;
	}
	@Override
	public int fileUploadService(int fileSeq, MultipartFile mFile, Map<String, Object> map) {
		String fileName = mFile.getOriginalFilename();
		Long fileSize = mFile.getSize();
		String orgFileName = fileName.substring(0, fileName.lastIndexOf("."));
		String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
		String subPath = String.valueOf(Calendar.getInstance().get(Calendar.YEAR))
				 + "/" + String.valueOf(Calendar.getInstance().get(Calendar.MONTH) + 1);
		String filePath = fileRootPath + holiWkReq_report + subPath + File.separator;
		File dir = new File(filePath);
		try {
			if(!dir.isDirectory()) {
				dir.mkdirs();
			}
			map.put("file_seq", fileSeq++);
			subHolidayDAO.fileUploadSave(map);
			mFile.transferTo(new File(filePath + map.get("attach_file_id") + "." +fileExtension));
			map.put("real_file_name", orgFileName);
			map.put("file_extension", fileExtension);
			map.put("file_path", filePath);
			map.put("file_size", fileSize);
			return subHolidayDAO.fileUpload(map);
		}catch(Exception e) {
			logger.error(e.getMessage());
			return -2;
		}
	}
	@Override
	public Map<String, Object> getFileInfo(Map<String, Object> map) {
		return subHolidayDAO.getFileInfo(map);
	}
	@Override
	public int subHolidayReqInsert(Map<String, Object> map) {
		int n = subHolidayDAO.subHolidayReqInsert(map);
		ArrayList<String> select_array = new ArrayList<String>();
		for(int i=0; i<((String) map.get("select_result_id")).split("/").length; i++) {
			select_array.add(((String) map.get("select_result_id")).split("/")[i]);
		}
		for(int i=0; i<select_array.size(); i++) {
			System.out.println(select_array.get(i));
			map.put("select_result_id", select_array.get(i));
			subHolidayDAO.selectCodeUpdate(map);
		}
		subHolidayDAO.sp_subHoliday_req_select(map);
		subHolidayDAO.selectCodeUpdateN();
		return n;
	}
	@Override
	public int subHolidayCompare(Map<String, Object> map) {
		int n = subHolidayDAO.subHolidayCompare(map);
		return n;
	}
	@Override
	public List<Map<String, Object>> gridSubHolidayReqList(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayReqList(map);
	}
	@Override
	public int gridSubHolidayReqListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayReqListTotal(map);
	}
	@Override
	public List<Map<String, Object>> gridSubHolidayReqListToday(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayReqListToday(map);
	}
	@Override
	public int gridSubHolidayReqListTotalToday(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayReqListTotalToday(map);
	}
	@Override
	public List<Map<String, Object>> overWkExcelList(Map<String, Object> map) {
		return subHolidayDAO.overWkExcelList(map);
	}
	@Override
	public List<Map<String, Object>> upExcelDown(Map<String, Object> map) {
		return subHolidayDAO.upExcelDown(map);
	}
	@Override
	public List<Map<String, Object>> downExcelDown(Map<String, Object> map) {
		return subHolidayDAO.downExcelDown(map);
	}
	@Override
	public List<Map<String, Object>> allExcelDown(Map<String, Object> map) {
		return subHolidayDAO.allExcelDown(map);
	}
	@Override
	public int subHolidayReqDeactivate(Map<String, Object> map) {
		int n = subHolidayDAO.subHolidayReqDeactivate(map);
		subHolidayDAO.sp_subHoliday_cancle(map);
		return n;
	}
	@Override
	public int getWeekendHolidayCnt(Map<String, Object> map) {
		return subHolidayDAO.getWeekendHolidayCnt(map);
	}
	@Override
	public Map<String, Object> getAgreeUseRestMinSum(Map<String, Object> map) {
		return subHolidayDAO.getAgreeUseRestMinSum(map);
	}
	@Override
	public List<Map<String, Object>> gridSubHolidayOccurList(Map<String, Object> map) {

		List<Map<String, Object>> listMap = subHolidayDAO.gridSubHolidayOccurList(map);

		for(int i=0; i<listMap.size(); i++){
			if(listMap.get(i).get("approval_status").equals("4")){
				listMap.get(i).remove("holi_start");
			}
		}

		return listMap;
	}
	@Override
	public int gridSubHolidayOccurListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayOccurListTotal(map);
	}
	@Override
	public int subHoliApprovalUpdate(List<Map<String, Object>> list) {

		int n = subHolidayDAO.subHoliApprovalUpdate(list);

		for(int i=0; i<list.size(); i++) {

			if(list.get(i).get("approval_status").equals("4")) {

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("replace_day_off_use_id", list.get(i).get("replace_day_off_use_id"));
				map.put("use_emp_seq", list.get(i).get("use_emp_seq"));

				subHolidayDAO.sp_subHoliday_reject(map);
			}
		}

		return n;
	}
	@Override
	public Map<String, Object> getOverHoliRestMin(Map<String, Object> map) {
		return subHolidayDAO.getOverHoliRestMin(map);
	}
	@Override
	public List<Map<String, Object>> gridSubHolidayUseRestList(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayUseRestList(map);
	}
	@Override
	public Map<String, Object> subHolidayTimeTotal(Map<String, Object> map) {
		return subHolidayDAO.subHolidayTimeTotal(map);
	}
	@Override
	public int gridSubHolidayUseRestListTotal(Map<String, Object> map) {
		return subHolidayDAO.gridSubHolidayUseRestListTotal(map);
	}
	@Override
	public List<Map<String, Object>> overWkTimeList(Map<String, Object> map) {
		return subHolidayDAO.overWkTimeList(map);
	}
	@Override
	public Map<String, Object> overWkList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", subHolidayDAO.overWkList(map)); //리스트
		result.put("totalCount", subHolidayDAO.overWkListTotal(map)); //토탈
		
		return result;
	}
	@Override
	public void otApplyCancel(Map<String, Object> map) {
		subHolidayDAO.otApplyCancel(map);
		
	}
	
	@Override
	public Map<String, Object> checkHoliTime(Map<String, Object> map) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("resultMsg", subHolidayDAO.checkHoliTime(map));
		map.put("work_date", map.get("apply_start_date"));
		map.put("emp_seq", map.get("apply_emp_seq"));
		Map<String, Object> weekHoliday = subHolidayDAO.getWeekHoliday(map);
		String week = String.valueOf(weekHoliday.get("week"));
		String holiday = String.valueOf(weekHoliday.get("holiday"));
		String workType = String.valueOf(weekHoliday.get("workType"));
		
		boolean isHoly = false;
		if(StringUtils.equals(workType, "0") && ( StringUtils.equals(week, "5") 
											   || StringUtils.equals(week, "6") 
											   || !StringUtils.equals(holiday, "0") )) {
			isHoly = true;
		}else if(StringUtils.equals(workType, "6")) {
			isHoly = true;
		}
		/*if( StringUtils.equals(week, "5") || StringUtils.equals(week, "6") || !StringUtils.equals(holiday, "0") || StringUtils.equals(workType, "6")) {
			weekHoliday.put("holiday", true);
			return weekHoliday;
		}*/
		if(isHoly) {
			result.put("holiYn", "Y");
		}else {
			result.put("holiYn", "N");
			result.put("resultMsg", "휴일근무는 휴일에만 신청가능합니다.");
		}
		
		/*if( StringUtils.equals(week, "5") || StringUtils.equals(week, "6") || !StringUtils.equals(holiday, "0") || StringUtils.equals(workType, "6")) {
			result.put("holiYn", "Y");
		} else {
			result.put("holiYn", "N");
			result.put("resultMsg", "휴일근무는 휴일에만 신청가능합니다.");
		}*/
		
		
		return result;
	}
	@Override
	public Map<String, Object> replaceHoliCheck(Map<String, Object> map) {
		return subHolidayDAO.replaceHoliCheck(map);
	}
	
	@Override
	public Map<String, Object> getWorkTypeCode(Map<String, Object> map) {
		return subHolidayDAO.getWorkTypeCode(map);
	}
	
	@Override
	public int inputAgreeMin(Map<String, Object> map) {
		subHolidayDAO.updateWorkStartEndTime(map);
		return subHolidayDAO.inputAgreeMin(map);
	}
	
	@Override
	public Map<String, Object> getAgreeMin(Map<String, Object> map) {
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("min", subHolidayDAO.getAgreeMin(map));
		resultMap.put("time", subHolidayDAO.getWorkStartEndTime(map));
		return resultMap;
	}
	
	@Override
	public int updateAgreeMin(Map<String, Object> map) {
		subHolidayDAO.updateWorkStartEndTime(map);
		return subHolidayDAO.updateAgreeMin(map);
	}
	
	@Override
	public int getAllAdmin(Map<String, Object> map) {
		return subHolidayDAO.getAllAdmin(map);
	}
	
	@Override
	public List<Map<String, Object>> defaultIframeReqList(Map<String, Object> map) {
		return subHolidayDAO.defaultIframeReqList(map);
	}
	@Override
	public List<Map<String, Object>> subHolidayReqDaySelect(Map<String, Object> map) {
		return subHolidayDAO.subHolidayReqDaySelect(map);
	}
	@Override
	public List<Map<String, Object>> SearchAttReqMainMgrList(Map<String, Object> map) {
		return subHolidayDAO.SearchAttReqMainMgrList(map);
	}
	@Override
	public int SearchAttReqMainMgrListTotal(Map<String, Object> map) {
		return subHolidayDAO.SearchAttReqMainMgrListTotal(map);
	}
	
	@Override
	public List<Map<String, Object>> subHolidayReqList(Map<String, Object> map) {
		return subHolidayDAO.subHolidayReqList(map);
	}
	
	@Override
	public int subHolidayReqListTotal(Map<String, Object> map) {
		return subHolidayDAO.subHolidayReqListTotal(map);
	}
}
