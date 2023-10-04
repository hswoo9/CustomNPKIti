package com.duzon.custom.trip.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.duzon.custom.trip.dao.TripDAO;
import com.duzon.custom.trip.service.TripService;

@Service
public class TripServiceImpl implements TripService {
	@Autowired private TripDAO tripDAO;

	@Override
	public Map<String, Object> selectTripAreaList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String domesticDiv = "L";
		String searchWord = (String) map.get("searchWord");	//검색어(출장지명)
		String searchOpt1 = (String) map.get("searchOpt1");	//검색조건(출장지 직접입력 여부)
		String searchOpt2 = (String) map.get("searchOpt2");	//검색조건(사용여부)
		
		if(map.get("domesticDiv") != null){
			domesticDiv = map.get("domesticDiv").toString();
		} 

		map.put("domesticDiv", domesticDiv);
		map.put("areaname", searchWord);
		map.put("directInputYn", searchOpt1);
		map.put("useYn", searchOpt2);
		
		//출장지 목록저장
		result.put("tripAreaList", tripDAO.selectTripAreaList(map));
		result.put("tripAreaListCount", tripDAO.selectTripAreaListCount(map));
		
		return result;
	}
	
	@Override
	public Map<String, Object> selectTripAreaDetail(Map<String, Object> map) {
		return tripDAO.selectTripAreaDetail(map);
	}

	@Override
	public boolean insertTripArea(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.insertTripArea(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;		
	}
	
	@Override
	public boolean updateTripArea(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.updateTripArea(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;		
	}

	@Override
	public Map<String, Object> deleteTripArea(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//출장비단가에 이미 적용된 경우 삭제되지 않도록 처리		
		Map<String, Object> isApply = tripDAO.selectApplyTripArea(map); 
		
		if(isApply != null){
			result.put("success", false);
			result.put("isApply", true);
			result.put("message", "선택한 직급그룹의 단가목록이 존재하여 삭제가 불가합니다.");
		}else{
			int cnt = tripDAO.deleteTripArea(map);
			if(cnt > 0){
				result.put("success", true);				
			}else{
				result.put("success", false);
			}
		}
		return result;
	}

	@Override
	public Map<String, Object> selectTripPositionGroupList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String domesticDiv = "L";
		String searchWord = (String) map.get("searchWord");	//검색어(출장지명)
		
		if(map.get("domesticDiv") != null){
			domesticDiv = map.get("domesticDiv").toString();
		} 

		map.put("domesticDiv", domesticDiv);
		map.put("pgroupname", searchWord);
		
		//직급그룹 목록저장
		result.put("tripPositionGroupList", tripDAO.selectTripPositionGroupList(map));
		result.put("tripPositionGroupListCount", tripDAO.selectTripPositionGroupListCount(map));
		result.put("positionGroupList", tripDAO.selectPositionGroupList(map));
		
		return result;		
	}

	@Override
	public Map<String, Object> selectTripPositionGroupDetail(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String selPosition = map.get("selPosition").toString();
		map.put("selPosition", selPosition.split(","));
		
		//직급그룹 목록저장
		result.put("tripPositionGroupList", tripDAO.selectTripPositionGroupDetail(map));
		result.put("positionGroupList", tripDAO.selectPositionGroupList(map));
		
		return result;
	}
	
	@Override
	public boolean insertTripPositionGroup(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.insertTripPositionGroup(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;		
	}
	
	@Override
	public boolean updateTripPositionGroup(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.updateTripPositionGroup(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;		
	}

	@Override
	public Map<String, Object> deleteTripPositionGroup(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//출장비단가에 이미 적용된 경우 삭제되지 않도록 처리		
		Map<String, Object> isApply = tripDAO.selectApplyPositionGroup(map); 
		
		if(isApply != null){
			result.put("success", false);
			result.put("isApply", true);
			result.put("message", "선택한 직급그룹의 단가목록이 존재하여 삭제가 불가합니다.");
		}else{
			int cnt = tripDAO.deleteTripPositionGroup(map);
			if(cnt > 0){
				result.put("success", true);				
			}else{
				result.put("success", false);
			}
		}
		return result;
	}
	
	@Override
	public Map<String, Object> selectTripTransList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String searchWord = (String) map.get("searchWord");	//검색어(교통수단명)
		String searchOpt = (String) map.get("searchOpt");	//검색조건(사용여부)
		
		map.put("transname", searchWord);
		map.put("useYn", searchOpt);
		
		//교통수단 목록저장
		result.put("tripTransList", tripDAO.selectTripTransList(map));
		result.put("tripTransListCount", tripDAO.selectTripTransListCount(map));
		
		return result;		
	}
	
	@Override
	public Map<String, Object> selectTripTransDetail(Map<String, Object> map) {
		Map<String, Object> result = tripDAO.selectTripTransDetail(map);
		return result;
	}
	
	@Override
	public boolean insertTripTrans(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.insertTripTrans(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;		
	}
	
	@Override
	public boolean updateTripTrans(Map<String, Object> map) {
		boolean result = false;
		int cnt = 0;
		
		int newOrderNum = 99999;
		if(map.get("orderNum") != null && !"".equals((String) map.get("orderNum"))){
			newOrderNum = Integer.parseInt(((String) map.get("orderNum")));			
		}
		map.put("orderNum", newOrderNum);
		
		cnt = tripDAO.updateTripTrans(map);
		
		if(cnt > 0){
			result = true;
		}
		return result;
	}
	
	@Override
	public boolean deleteTripTrans(Map<String, Object> map) {
		return tripDAO.deleteTripTrans(map) > 0 ? true : false;
	}

	@Override
	public Map<String, Object> selectTripCostList(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		String newYn = (String) map.get("newYn");				//전체내역보기
		String searchWord1 = (String) map.get("searchWord1");	//검색어(직급그룹명)
		String searchWord2 = (String) map.get("searchWord2");	//검색어(출장지명)
		String searchOpt = (String) map.get("searchOpt");		//검색조건(국내외 구분)
		String sortType = (String) map.get("sortType");			//정렬기준
		
		if(sortType == null || "".equals(sortType)){
			sortType = "1";		//디폴트 정렬설정(기준일 내림차순)
		}
		
		map.put("pgroupname", searchWord1);
		map.put("areaname", searchWord2);
		map.put("searchOpt", searchOpt);
		map.put("newYn", newYn);
		map.put("sortType", sortType);
		
		//출장지 목록저장
		result.put("tripCostList", tripDAO.selectTripCostList(map));
		result.put("tripCostListCount", tripDAO.selectTripCostListCount(map));
		
		result.put("searchWord1", searchWord1);
		result.put("searchWord2", searchWord2);
		result.put("searchOpt", searchOpt);
		
		return result;
	}

	@Override
	public Object selectTripPositionGroupListPop(Map<String, Object> map) {
		return tripDAO.selectTripPositionGroupListPop(map);
	}

	@Override
	public Object selectTripAreaListPop(Map<String, Object> map) {
		return tripDAO.selectTripAreaListPop(map);
	}

	@Override
	public Map<String, Object> insertTripCost(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//동일 직급그룹과 출장지로 동일한 기준일의 데이터가 있는지 확인하여 중복등록되지 않도록 처리		
		Map<String, Object> isApply = tripDAO.selectExistCost(map); 
		
		if(isApply != null){
			result.put("success", false);
			result.put("isApply", true);
			result.put("message", "동일 직급그룹, 출장지는 전과 동일한 기준일 등록이 불가합니다.");
		}else{
			int cnt = tripDAO.insertTripCost(map);
			if(cnt > 0){
				result.put("success", true);				
			}else{
				result.put("success", false);
			}
		}
		return result;	
	}

	@Override
	public Map<String, Object> updateTripCost(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//동일 직급그룹과 출장지로 동일한 기준일의 데이터가 있는지 확인하여 중복등록되지 않도록 처리		
		Map<String, Object> isApply = tripDAO.selectExistCost(map); 
		
		if(isApply != null){
			result.put("success", false);
			result.put("isApply", true);
			result.put("message", "동일 직급그룹, 출장지는 전과 동일한 기준일 등록이 불가합니다.");
		}else{
			int cnt = tripDAO.updateTripCost(map);
			if(cnt > 0){
				result.put("success", true);				
			}else{
				result.put("success", false);
			}
		}
		return result;	
	}

	@Override
	public boolean deleteTripCost(Map<String, Object> map) {
		return tripDAO.deleteTripCost(map) > 0 ? true : false;
	}

	@Override
	public Map<String, Object> selectTripCostDetail(Map<String, Object> map) {
		Map<String, Object> result = tripDAO.selectTripCostDetail(map);
		return result;
	}
}
