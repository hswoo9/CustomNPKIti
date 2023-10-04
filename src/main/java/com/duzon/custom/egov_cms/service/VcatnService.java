package com.duzon.custom.egov_cms.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.duzon.custom.egov_cms.dto.SpeclDTO;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnCreatHistDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;

public interface VcatnService {

	
	/**
	 * 연가생성리스트
	 */
	List<VcatnDTO> getVcatnList(Map<String, Object> params);
	
	/**
	 * 생성이력
	 */
	List<VcatnCreatHistDTO> getVcatnCreatHistList(Map<String, Object> params);
	
	/**
	 * 사용이력
	 */
	List<VcatnUseHistDTO> getVcatnUseHistList(Map<String, Object> params);
	
	/**
	 * 저장
	 * @param params
	 * @return
	 */
	Map<String, Object> vcatnSave(VcatnDTO vcatnDTO, Map<String, Object> params);
	
	/**
	 * 연가생성 사원 정보
	 * @param vcatnSn 연가생성키
	 */
	VcatnDTO getVcatnOne(Map<String, Object> params);
	
	/**
	 * 연가생성 삭제
	 */
	Map<String, Object> deleteVcatn(Map<String, Object> params);
	
	/**
	 * 연가생성 수정
	 */
	Map<String, Object> updateVcatn(Map<String, Object> params, VcatnDTO vcatnDTO);
	
	/**
	 * 특별휴가 생성
	 */
	Map<String, Object> specialSave(Map<String, Object> params);
	
	/**
	 * 특별휴가생성 정보조회
	 */
	Map<String, Object> getSpecialOne(Map<String, Object> params);
	
	/**
	 * 특별휴가생성 삭제
	 */
	Map<String, Object> deleteSpecialVcatn(Map<String, Object> params);
	
	/**
	 * 특별휴가생성 수정
	 */
	Map<String, Object> specialUpdate(Map<String, Object> params, SpeclDTO speclDTO);
	
	/**
	 * 특별휴가 구분가져오기
	 */
	SpeclVcatnSetupDTO getSpecialVacCode(Map<String, Object> params);
	
	/**
	 * 연가생성 사원 정보2
	 * empSeq 
	 */
	VcatnDTO checkVcatn(Map<String, Object> params);
	
	/**
	 * 휴가생성이력 조회
	 */
	List<VcatnCreatHistDTO> getVcatnCreatHist(Map<String, Object> params);
	
	/**
	 * 사용이력 저장
	 */
	VcatnUseHistDTO vcatnUseHistSave(VcatnUseHistDTO vcatnUseHistDTO);
	
	/**
	 * 특별휴가 생성 리스트 
	 */
	List<Map<String, Object>> getSpecialList(Map<String, Object> params);
	
	/**
	 * 부서리스트 가져오기
	 */
	List<Map<String, Object>> getAllDept(Map<String, Object> params);
	
	/**
	 * 개인휴가현황 리스트
	 */
	List<Map<String, Object>> getList(Map<String, Object> params);
	
	/**
	 * 개인휴가현황 사용리스트
	 */
	List<Map<String, Object>> getUseList(Map<String, Object> params);
	/**
	 * 개인휴가현황 사용리스트
	 */
	List<Map<String, Object>> getMyVcation(Map<String, Object> params);
	
	/**
	 * 개인휴가현황 -> 생성이력
	 */
	//List<Map<String, Object>> getMyHistList(Map<String, Object> params);
	
	List<Map<String, Object>> getSpecialUseHist(Map<String, Object> params);
	
	Map<String, Object> evidenceFileSave(List<Map<String, Object>> fileList);
	
	List<Map<String, Object>> getMyHistList(Map<String, Object> params);
	
	Map<String, Object> specialExcelUpload(File file, Map<String, Object> params);
	
	List<Map<String, Object>> selectFileUploadList(Map<String, Object> params);
	
	Map<String, Object> fileDelete(Map<String, Object> params);
	
	List<Map<String, Object>> getEmpSeqFileList(Map<String, Object> params);
	
	void outProcessCancel(Map<String, Object> params);
	
	Map<String, Object> makeVacation(Map<String, Object> params);
	
	Map<String, Object> vacationUseCheck(Map<String, Object> params);
	
	void outProcessReturn(Map<String, Object> params);
	
	List<Map<String, Object>> selectVacationList(Map<String, Object> params);
	
	void outProcessApplication(Map<String, Object> params);
	
	void makeMonthlyLeave(Map<String, Object> params);
	
	Map<String, Object> vcatnUseHistSnEtc(Map<String, Object> params);
	
}
