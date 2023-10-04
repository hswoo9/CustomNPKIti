package com.duzon.custom.educationManagement.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.duzon.custom.educationManagement.vo.OnlineEduVO;

public interface EducationService {

	/**
	 * @MethodName : groupEduReg
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육 등록
	 */
	void groupEduReg(Map<String, Object> map);

	/**
		 * @MethodName : groupEduList
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육등록 화면 집합교육 리스트 (첫번째 그리드)
		 */
	List<Map<String, Object>> eduList(Map<String, Object> map);

	/**
	 * @MethodName : groupEduList
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육 리스트 토탈 (첫번째 그리드)
	 */
	int eduListTotal(Map<String, Object> map);

	/**
		 * @MethodName : groupEduDetailList
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육등록 화면 집합교육대상자 리스트 (두번째 그리드)
		 */
	List<Map<String, Object>> groupEduDetailList(Map<String, Object> map);

	/**
		 * @MethodName : groupEduDetailListTotal
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육등록 화면 집합교육대상자 리스트 토탈 (두번째 그리드)
		 */
	int groupEduDetailListTotal(Map<String, Object> map);

	/**
		 * @MethodName : groupEduApproval
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 집합교육 계획 승인
		 */
	void groupEduApproval(Map<String, Object> map);

	/**
		 * @MethodName : eduFinApproval
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 집합교육 이수 승인
		 */
	void eduFinApproval(Map<String, Object> map, MultipartHttpServletRequest multi);

	/**
		 * @MethodName : privateEduReg
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 저장
		 */
	void privateEduReg(Map<String, Object> map, MultipartHttpServletRequest multi);

	/**
		 * @MethodName : privateEduList
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 리스트
		 */
	List<Map<String, Object>> privateEduList(Map<String, Object> map);

	/**
		 * @MethodName : privateEduListTotal
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 리스트 토탈
		 */
	int privateEduListTotal(Map<String, Object> map);

	void privateFinApproval(Map<String, Object> map);

	void privateFinReject(Map<String, Object> map);

	List<Map<String, Object>> privateEduStsList(Map<String, Object> map);

	int privateEduStsListTotal(Map<String, Object> map);

	List<Map<String, Object>> privateEduStsDetailList(Map<String, Object> map);

	int privateEduStsDetailListTotal(Map<String, Object> map);

	List<Map<String, String>> onlineEduExcelUpload(File destFile, Map<String, Object> map);

	void excelFile(Map<String, Object> map, MultipartHttpServletRequest multi);

	Map<String, Object> excelPath(MultipartHttpServletRequest multi, String fileNmKey, String subFilePath) throws Exception;

	List<Map<String, Object>> onlineEduExcelList(Map<String, Object> map);

	void onlineEduUpdate(Map<String, Object> map);

	void onlineEduDel(Map<String, Object> map);

	void eduReqDel(Map<String, Object> map);

	void groupEduCancle(Map<String, Object> map);

	List<Map<String, Object>> eduResultFileList(Map<String, Object> map);

	void fileDown(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response);

	void fileDownLoad(String fileNm, String path, HttpServletRequest request, HttpServletResponse response) throws Exception;

	String getOnlineMonthYn(Map<String, Object> map);

	void onlineEduSave(OnlineEduVO onlineEduVO);

	void groupEduReject(Map<String, Object> map);

	Map<String, Object> getGroupMainMap(Map<String, Object> eduMap);

	List<Map<String, Object>> getGroupEmpList(Map<String, Object> eduMap);

	void updateSchmSeq(Map<String, Object> schResult);

	void insertCalendarEmp(Map<String, Object> emp);

}
