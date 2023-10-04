package com.duzon.custom.egov_cms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;
import com.duzon.custom.egov_cms.dto.SpeclDTO;
import com.duzon.custom.egov_cms.dto.SpeclVcatnSetupDTO;
import com.duzon.custom.egov_cms.dto.VcatnCreatHistDTO;
import com.duzon.custom.egov_cms.dto.VcatnDTO;
import com.duzon.custom.egov_cms.dto.VcatnUseHistDTO;

@SuppressWarnings("unchecked")
@Repository
public class VcatnDAO extends AbstractDAO {

	/**
	 * 연가생성리스트
	 */
	public List<VcatnDTO> getVcatnList(Map<String, Object> params) {
		return selectList("vcatn.getVcatnList", params);
	}
	
	/**
	 * 사용이력
	 */
	public List<VcatnCreatHistDTO> getVcatnCreatHistList(Map<String, Object> params){
		return selectList("vcatn.getVcatnCreatHistList", params);
	}
	/**
	 * 생성이력
	 */
	public List<VcatnUseHistDTO> getVcatnUseHistList(Map<String, Object> params){
		return selectList("vcatn.getVcatnUseHistList", params);
	}
	
	/**
	 * 휴가 유무 조회
	 */
	public VcatnDTO checkVcatn(Map<String, Object> params) {
//		return (VcatnDTO)selectOne("vcatn.checkVcatn", params);
		return (VcatnDTO)selectOne("vcatn.checkAnnv", params);
	}
	
	/**
	 * 생성이력 유무 조회
	 */
	public int checkVcatnCreatHist(Map<String, Object> params) {
		return (int)selectOne("vcatn.checkVcatnCreatHist", params);
	}
	
	/**
	 * 휴가 저장
	 */
	public int vcatnSave(VcatnDTO vcatnDTO) {
		return (int)insert("vcatn.vcatnSave", vcatnDTO);
	}
	
	/**
	 * 생성이력 저장
	 */
	public int VcatnCreatHistSave(VcatnCreatHistDTO vcatnCreatHistDTO) {
		return (int)insert("vcatn.VcatnCreatHistSave", vcatnCreatHistDTO);
	}
	
	/**
	 * 연가생성 사원 정보
	 */
	public VcatnDTO getVcatnOne(Map<String, Object> params) {
		return (VcatnDTO)selectOne("vcatn.getVcatnOne", params);
	}
	
	/**
	 * 연가생성 삭제
	 */
	public int deleteVcatn(String vcatnSn) {
		return (int)update("vcatn.deleteVcatn", vcatnSn);
	}
	
	/**
	 * 연가생성 수정
	 */
	public int updateVcatn(VcatnDTO vcatnDTO) {
		return (int)update("vcatn.updateVcatn", vcatnDTO); 
	}
	
	/**
	 * 생성이력 정렬 수 가져오기
	 */
	public int getVcatnCreatHistSortSn(VcatnDTO vcatnDTO) {
		return (int) selectOne("vcatn.getVcatnCreatHistSortSn", vcatnDTO);
	}
	
	/**
	 * 사용이력 정렬 수 가져오기
	 */
	public int getVcatnUseHistSortSn(VcatnDTO vcatnDTO) {
		return (int) selectOne("vcatn.getVcatnUseHistSortSn", vcatnDTO);
	}
	
	/**
	 * 특별휴가 생성 저장
	 */
	public int specialSave(SpeclDTO speclDTO) {
		return (int) insert("vcatn.specialSave", speclDTO);
	}
	
	/**
	 * 특별휴가 정보 조회
	 */
	public Map<String, Object> getSpecialOne(Map<String, Object> params) {
		return (Map<String, Object>) selectOne("vcatn.getSpecialOne", params);
	}
	
	/**
	 * 특별휴가 생성이력 삭제
	 */
	public int deleteSpecialHist(String vcatnCreatHistSn){
		return (int) update("vcatn.deleteSpecialHist", vcatnCreatHistSn);
	}
	
	/**
	 * 휴가 잔여일 0 처리
	 */
	public int specialDelete(Map<String, Object> params){
		return (int) update("vcatn.specialDelete", params);
	}
	
	/**
	 * 특별휴가 생성이력 키 조회 
	 */
	public Map<String, Object> getSpecialVcatnKey(String vcatnSn) {
		return (Map<String, Object>)selectOne("vcatn.getSpecialVcatnKey", vcatnSn);
	}
	/**
	 * 특별휴가 구분 가져오기
	 */
	public SpeclVcatnSetupDTO getSpecialVacCode(Map<String, Object> params){
		return (SpeclVcatnSetupDTO) selectOne("vcatn.getSpecialVacCode", params);
	}
	
	/**
	 * 생성이력조회
	 */
	public List<VcatnCreatHistDTO> getVcatnCreatHist(Map<String, Object> params){
		return selectList("vcatn.getVcatnCreatHist", params);
	}
	
	/**
	 * 특별휴가 생성 리스트 
	 */
	public List<Map<String, Object>> getSpecialList(Map<String, Object> params) {
		return selectList("vcatn.getSpecialList", params);
	}
	
	/**
	 * 특별휴가 생성 리스트 
	 */
	public VcatnCreatHistDTO getSpecialHist(Map<String, Object> params) {
		return (VcatnCreatHistDTO)selectOne("vcatn.getSpecialHist", params);
	}
	
	/**
	 * 특별휴가 정렬 순번 가져오기
	 */
	public int getSpeclSortSn(String empSeq) {
		return (int) selectOne("vcatn.getSpeclSortSn", empSeq);
	}
	
	/**
	 * 사원 정보
	 */
	public Map<String, Object> empInfo(String empSeq){
		return (Map<String, Object>) selectOne("vcatn.empInfo", empSeq);
	}
	
	/**
	 * 특별휴가 수정
	 */
	public int updateSpecl(SpeclDTO speclDTO) {
		return (int) update("vcatn.updateSpecl", speclDTO);
	}
	
	/**
	 * 특별휴가 삭제
	 */
	public int deleteSpecl(String speclSn) {
		return (int) update("vcatn.deleteSpecl", speclSn);
	}
	
	/**
	 * 부서리스트 변경
	 */
	public List<Map<String, Object>> getAllDept(Map<String, Object> params){
		return selectList("vcatn.getAllDept", params);
	}
	
	/**
	 * 개인휴가현황 리스트
	 */
	public List<Map<String, Object>> getList(Map<String, Object> params){
		return selectList("vcatn.getList", params);
	}
	
	/**
	 * 개인휴가현황 사용리스트
	 */
	public List<Map<String, Object>> getUseList(Map<String, Object> params){
		return selectList("vcatn.getUseList", params);
	}
	/**
	 * 휴가신청 잔여 조회	
	 */
	public List<Map<String, Object>> getMyVcation(Map<String, Object> params){
//		return selectList("vcatn.getMyVcation", params);
		return selectList("vcatn.getMyAnnv", params);
	}
	/**
	 * 특별휴가 리스트조회(개인)	
	 */
	public List<Map<String, Object>> getSpecialMyList(Map<String, Object> params){
		return selectList("vcatn.getSpecialMyList", params);
	}
	/**
	 * 특별휴가 리스트조회(개인)	
	 */
	public List<Map<String, Object>> getSpecialUseHist(Map<String, Object> params){
		return selectList("vcatn.getSpecialUseHist", params);
	}
	
	public void evidenceFileSave(Map<String, Object> params) {
		insert("vcatn.evidenceFileSave", params);
	}
	
	public List<Map<String, Object>> getMyHistList(Map<String, Object> params) {
		return selectList("vcatn.getMyHistList", params);
	}
	
	public Map<String, Object> reduplicationCheck(Map<String, Object> params){
		return (Map<String, Object>) selectOne("vcatn.reduplicationCheck", params);
	}
	
	public List<Map<String, Object>> selectFileUploadList(Map<String, Object> params){
		return selectList("vcatn.selectFileUploadList", params);
	}
	
	public int fileDelete(Map<String, Object> params) {
		return (int) delete("vcatn.fileDelete", params);
	}
	
	public List<Map<String, Object>> getEmpSeqFileList(Map<String, Object> params) {
		return selectList("vcatn.getEmpSeqFileList", params);
	}
	
	public void outProcessCancel(Map<String, Object> params) {
		update("vcatn.outProcessCancel", params);
	}
	
	public List<Map<String, Object>> selectEmpYrvacAllList(Map<String, Object> params){
		return selectList("vcatn.selectEmpYrvacAllList", params);
	}
	
	public int vacationUseCheck(Map<String, Object> params){
		return (int) selectOne("vcatn.vacationUseCheck", params);
	}
	
	public void outProcessReturn(Map<String, Object> params) {
		update("vcatn.outProcessReturn", params);
	}
	
	public List<Map<String, Object>> selectVacationList(Map<String, Object> params){
		return selectList("vcatn.selectVacationList", params);
	}
	
	public List<Map<String, Object>> getLnglbcList(Map<String, Object> params){
		return selectList("vcatn.getLnglbcList", params);
	}
	
	public void outProcessApplication(Map<String, Object> params) {
		update("vcatn.outProcessApplication", params);
	}
	
	public void makeMonthlyLeave(Map<String, Object> params) {
		update("vcatn.makeMonthlyLeave", params);
	}
	
	public void vcatnUseHistSnEtc(Map<String, Object> params) {
		update("vcatn.vcatnUseHistSnEtc", params);
	}
	
}
