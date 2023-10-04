package com.duzon.custom.airlineMileage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@Repository
public class AirlineMileageDAO extends AbstractDAO{
	
	@SuppressWarnings("unchecked")
	public void setMileageSave(Map<String, Object> map) {
		insert("setMileageSave", map);
	}
	
	public List<Map<String, Object>> mileageListSearch(Map<String, Object> map) throws Exception{
		return selectList("mileageListSearch",map);
	}
	
	
	public int mileageListSearchTotal(Map<String, Object> map) {
		return (int) selectOne("mileageListSearchTotal", map);
	}
	
	public void fileUploadSave(Map<String, Object> map) {
		insert("airlineMileage.fileSave", map);
	}
	
	public int fileUpload(Map<String, Object> map) {
		return (Integer)update("airlineMileage.fileUpload", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> masterSearchMember(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("masterSearchMember", map);
	}
	
	public void mileageMasterInsert(Map<String, Object> map) {
		insert("mileageMasterInsert", map);
	}
	
	public void mileageDetailInsert(Map<String, Object> map) {
		insert("mileageDetailInsert", map);
	}
	
	public void mileageDetailInsert2(Map<String, Object> map) {
		insert("mileageDetailInsert2", map);
	}
	
	public void mileageMasterUpdate(Map<String, Object> map) {
		update("mileageMasterUpdate",map);
	}
	
	public void deleteMileageMasterUpdate(Map<String, Object> map) {
		update("deleteMileageMasterUpdate",map);
	}
	
	public void deleteMileageUpdate(Map<String, Object> map) {
		update("deleteMileageUpdate",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> fileList(Map<String, Object> map) {
		return selectList("airlineMileage.fileList",map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> fileDown(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("airlineMileage.fileDown", map);
	}
}
