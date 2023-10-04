package com.duzon.custom.trip.service;

import java.util.Map;

public interface TripService {

	Map<String, Object> selectTripAreaList(Map<String, Object> map);

	Map<String, Object> selectTripAreaDetail(Map<String, Object> map);
	
	boolean insertTripArea(Map<String, Object> map);
	
	boolean updateTripArea(Map<String, Object> map);

	Map<String, Object> deleteTripArea(Map<String, Object> map);

	Map<String, Object> selectTripPositionGroupList(Map<String, Object> map);

	Map<String, Object> selectTripPositionGroupDetail(Map<String, Object> map);
	
	boolean insertTripPositionGroup(Map<String, Object> map);
	
	boolean updateTripPositionGroup(Map<String, Object> map);
	
	Map<String, Object> deleteTripPositionGroup(Map<String, Object> map);
	
	Map<String, Object> selectTripTransList(Map<String, Object> map);
	
	Map<String, Object> selectTripTransDetail(Map<String, Object> map);
	
	boolean insertTripTrans(Map<String, Object> map);
	
	boolean updateTripTrans(Map<String, Object> map);
	
	boolean deleteTripTrans(Map<String, Object> map);

	Map<String, Object> selectTripCostList(Map<String, Object> map);

	Object selectTripPositionGroupListPop(Map<String, Object> map);

	Object selectTripAreaListPop(Map<String, Object> map);

	Map<String, Object> insertTripCost(Map<String, Object> map);

	Map<String, Object> updateTripCost(Map<String, Object> map);

	boolean deleteTripCost(Map<String, Object> map);

	Map<String, Object> selectTripCostDetail(Map<String, Object> map);

}
