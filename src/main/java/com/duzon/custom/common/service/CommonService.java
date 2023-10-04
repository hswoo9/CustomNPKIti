package com.duzon.custom.common.service;

import java.util.List;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface CommonService {

	void ctFileUpLoad(Map<String, Object> map, MultipartHttpServletRequest multi);

	/**
	 * @MethodName : commonGetEmpInfo
	 * @author : gato
	 * @since : 2018. 1. 5.
	 * 설명 : 로그인 세션 정보 가져오기
	 */
	Map<String, Object> commonGetEmpInfo(HttpServletRequest servletRequest) throws NoPermissionException;
	
	/**
	 * @MethodName : getCode
	 * @author : gato
	 * @since : 2018. 1. 5.
	 * 설명 : 공통코드 가져오기
	 */
	List<Map<String, Object>> getCode(String code, String orderby);

	Map<String, Object> getDept(String empSeq);

	void fileDownLoad(String fileNm, String path, HttpServletRequest request, HttpServletResponse response) throws Exception;

	List<Map<String, Object>> empInformation(Map<String, Object> map);

	int empInformationTotal(Map<String, Object> map);


	/**
	 * @MethodName : systemFileList
	 * @author : gato
	 * @since : 2018. 1. 8.
	 * 설명 : 첨부파일 목록 가져오기
	 */
	List<Map<String, Object>> fileList(Map<String, Object> map);

	/**
	 * @MethodName : fileDown
	 * @author : gato
	 * @since : 2018. 1. 9.
	 * 설명 : 파일 다운로드
	 */
	void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response);

	void fileDelete(Map<String, Object> map);
	
	List<Map<String, Object>> getGroupCd(Map<String, Object> map);


	Map<String, Object> getKidzDept(Map<String, Object> bizList);

	Map<String, Object> getCodeByKr(String param);

	void dailySecom(Map<String, Object> map);

	Map<String, Object> getEmpName(String empSeq);

	List<Map<String, Object>> getEmpDept(String deptSeq);

	List<Map<String, Object>> getAllDept();

	Map<String, Object> getCodeOne(String string, String string2);

	Map<String, Object> getRestFund(String empSeq);

	List<Map<String, Object>> getDutyPosition(String string);

	Map<String, Object> getKssfUserInfo(String key);

	Map<String, Object> getEmpInfoByName(Map<String, Object> empInfo);
	
	Map<String, Object> getEmpInfoByName2(Map<String, Object> empInfo);

	Map<String, Object> getCalendarEmpInfo(String string);

	List<Map<String, Object>> selectEmp(Map<String, Object> map);

	Map<String, Object> getHeader(Map<String, Object> loginMap);

	Map<String, Object> getLeader(Map<String, Object> loginMap);

	void dailyWorkAgree(Map<String, Object> map);

	void monthlyWorkPlanMake(Map<String, Object> map);

	Map<String, Object> getUpDeptName(Map<String, Object> loginMap);

	void replaceHolidayChangeCode();
	
	void setAttCode();

	void vcatnUseHistUpdate();
}
