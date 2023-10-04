package com.duzon.custom.educationManagement.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;
import com.duzon.custom.educationManagement.vo.OnlineEduVO;

@Repository
public class EducationDAO extends AbstractDAO {

	/**
	 * @MethodName : groupEduReg
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 
	 */
	public void groupEduReg(Map<String, Object> map) {
		
		insert("educationManagement.groupEduReg", map);
		
	}
	
	/**
		 * @MethodName : groupEduPersonReg
		 * @author : gato
		 * @since : 2018. 3. 8.
		 * 설명 : 집합교육대상자등록
		 */
	public void groupEduPersonReg(Map<String, Object> map) {
		
		insert("educationManagement.groupEduPersonReg", map);
		
	}
	
	/**
	 * @MethodName : groupEduList
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육 리스트 (첫번째 그리드)
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> eduList(Map<String, Object> map) {
		return selectList("educationManagement.eduList", map);
	}
	
	/**
	 * @MethodName : groupEduList
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육 리스트 토탈 (첫번째 그리드)
	 */
	public int eduListTotal(Map<String, Object> map) {
		return (int) selectOne("educationManagement.eduListTotal",map);
	}
	/**
	 * @MethodName : groupEduDetailList
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육대상자 리스트 (두번째 그리드)
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> groupEduDetailList(Map<String, Object> map) {
		return selectList("educationManagement.groupEduDetailList", map);
	}
	/**
	 * @MethodName : groupEduDetailListTotal
	 * @author : gato
	 * @since : 2018. 3. 8.
	 * 설명 : 집합교육등록 화면 집합교육대상자 리스트 토탈 (두번째 그리드)
	 */
	public int groupEduDetailListTotal(Map<String, Object> map) {
		return (int) selectOne("educationManagement.groupEduDetailListTotal",map);
	}
	
	/**
		 * @MethodName : groupEduApproval
		 * @author : gato
		 * @since : 2018. 3. 9.
		 * 설명 : 집합교육계획 승인
		 */
	public int groupEduApproval(Map<String, Object> map) {
		return (int) update("educationManagement.groupEduApproval", map);
		
	}
	
	/**
		 * @MethodName : eduFinFileSave
		 * @author : gato
		 * @since : 2018. 3. 9.
		 * 설명 : 집합교육이수 관련 첨부파일 최초저장
		 */
	public void eduFinFileSave(Map<String, Object> map) {
		insert("educationManagement.eduFinFileSave", map);
		
	}
	
	/**
		 * @MethodName : eduFinFileUpload
		 * @author : gato
		 * @since : 2018. 3. 9.
		 * 설명 : 집합교육이수 관련 첨부파일 명, 확장자 , 크기, 경로 저장
		 */
	public void eduFinFileUpload(Map<String, Object> map) {
		update("educationManagement.eduFinFileUpload", map);
		
	}
	
	/**
		 * @MethodName : eduFinApproval
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 집합교육 이수 승인
		 */
	public void eduFinApproval(Map<String, Object> map) {
		update("educationManagement.eduFinApproval", map);
		
	}
	
	/**
		 * @MethodName : eduPersonFinApproval
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 집합교육 개별 이수승인
		 */
	public void eduPersonFinApproval(Map<String, Object> map) {
		update("educationManagement.eduPersonFinApproval", map);
		
	}
	
	/**
		 * @MethodName : eduPersonFinReset
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 집합교육  개별 이수 승인 수정
		 */
	public void eduPersonFinReset(Map<String, Object> map) {
		update("educationManagement.eduPersonFinReset", map);
		
	}
	
	/**
		 * @MethodName : privateEduList
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 리스트
		 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> privateEduList(Map<String, Object> map) {
		return selectList("educationManagement.privateEduList", map);
	}
	
	/**
		 * @MethodName : privateEduListTotal
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 리스트 토탈
		 */
	public int privateEduListTotal(Map<String, Object> map) {
		return (int) selectOne("educationManagement.privateEduListTotal",map);
	}
	
	/**
		 * @MethodName : privateFinReject
		 * @author : gato
		 * @since : 2018. 3. 12.
		 * 설명 : 개별교육 이수요청 반려
		 */
	public void privateFinReject(Map<String, Object> map) {
		update("educationManagement.privateFinReject", map);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> privateEduStsList(Map<String, Object> map) {
		return selectList("educationManagement.privateEduStsList", map);
		
	}
	
	public int privateEduStsListTotal(Map<String, Object> map) {
		return (int) selectOne("educationManagement.privateEduStsListTotal",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> privateEduStsDetailList(Map<String, Object> map) {
		return selectList("educationManagement.privateEduStsDetailList", map);
	}
	
	public int privateEduStsDetailListTotal(Map<String, Object> map) {
		return (int) selectOne("educationManagement.privateEduStsDetailListTotal",map);
	}
	
	public void onlineEduReset(OnlineEduVO onlineEduVO) {
		delete("educationManagement.onlineEduReset", onlineEduVO);
		
	}
	
	public void onlineEduPersonReset(OnlineEduVO onlineEduVO) {
		delete("educationManagement.onlineEduPersonReset", onlineEduVO);		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> onlineEduExcelList(Map<String, Object> map) {
		return selectList("educationManagement.onlineEduExcelList", map);
	}
	
	public void onlineEduUpdate(Map<String, Object> map) {
		update("educationManagement.onlineEduUpdate", map);
		
	}
	
	public void onlineEduPersonUpdate(Map<String, Object> map) {
		update("educationManagement.onlineEduPersonUpdate", map);
		
	}
	
	public void onlineEduPersonDel(Map<String, Object> map) {
		delete("educationManagement.onlineEduPersonDel", map);
		
	}
	
	public void onlineEduDel(Map<String, Object> map) {
		delete("educationManagement.onlineEduDel", map);
		
	}
	
	public void eduReqDel(Map<String, Object> map) {
		update("educationManagement.eduReqDel", map);		
	}
	
	public void groupEduCancle(Map<String, Object> map) {
		update("educationManagement.groupEduCancle", map);				
	}
	
	public void eduReqPersonDel(Map<String, Object> map) {
		update("educationManagement.eduReqPersonDel", map);				
	}
	
	public int getResultFileSeq(Map<String, Object> map) {
		return (int) selectOne("educationManagement.getResultFileSeq", map);
	}
	
	public void eduResultFileSave(Map<String, Object> map) {
		insert("educationManagement.eduResultFileSave", map);		
	}
	
	public void eduResultFileUpload(Map<String, Object> map) {
		update("educationManagement.eduResultFileUpload", map);		
	}
	
	public void privateEduUpdate(Map<String, Object> map) {
		update("educationManagement.privateEduUpdate", map);		
		
	}
	
	public void privateEduPersonUpdate(Map<String, Object> map) {
		update("educationManagement.privateEduPersonUpdate", map);		
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> eduResultFileList(Map<String, Object> map) {
		return selectList("educationManagement.eduResultFileList",map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> fileDown(Map<String, Object> map) {
		return (Map<String, Object>) selectOne("educationManagement.fileDown", map);
	}
	
	public String getOnlineMonthYn(Map<String, Object> map) {
		return (String) selectOne("educationManagement.getOnlineMonthYn", map);
	}
	
	public void onlineEduSave(OnlineEduVO onlineEduVO) {
		insert("educationManagement.onlineEduSave", onlineEduVO);
	}	
	
	public void onlineEduPersonSave(OnlineEduVO onlineEduVO) {
		insert("educationManagement.onlineEduPersonSave", onlineEduVO);
		
	}
	
	public void groupEduReject(Map<String, Object> map) {
		update("educationManagement.groupEduReject", map);
		
	}
	
	public void groupEduPersonReject(Map<String, Object> map) {
		update("educationManagement.groupEduPersonReject", map);
		
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> getGroupMainMap(Map<String, Object> eduMap) {
		return (Map<String, Object>) selectOne("educationManagement.getGroupMainMap", eduMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getGroupEmpList(Map<String, Object> eduMap) {
		return selectList("educationManagement.getGroupEmpList", eduMap);
	}
	
	public void updateSchmSeq(Map<String, Object> schResult) {
		update("educationManagement.updateSchmSeq", schResult);
		
	}
	
	public void insertCalendarEmp(Map<String, Object> emp) {
		insert("educationManagement.insertCalendarEmp", emp);
		
	}
}
