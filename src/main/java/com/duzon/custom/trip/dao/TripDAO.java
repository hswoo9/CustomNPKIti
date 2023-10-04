package com.duzon.custom.trip.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@Repository
public class TripDAO extends AbstractDAO {

	public Object selectTripAreaList(Map<String, Object> map) {
		return selectList("trip.selectTripAreaList", map);
	}
	
	public Object selectTripAreaListCount(Map<String, Object> map) {
		return selectOne("trip.selectTripAreaListCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTripAreaDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectTripAreaDetail", map);
	}
	
	public int insertTripArea(Map<String, Object> map) {
		return (Integer)insert("trip.insertTripArea", map);
	}
	
	public int updateTripArea(Map<String, Object> map) {
		return (Integer)update("trip.updateTripArea", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectApplyTripArea(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectApplyTripArea", map);
	}

	public int deleteTripArea(Map<String, Object> map) {
		return (Integer)delete("trip.deleteTripArea", map);
	}

	public Object selectTripPositionGroupList(Map<String, Object> map) {
		return selectList("trip.selectTripPositionGroupList", map);
	}

	public Object selectTripPositionGroupListCount(Map<String, Object> map) {
		return selectOne("trip.selectTripPositionGroupListCount", map);
	}

	public Object selectPositionGroupList(Map<String, Object> map) {
		return selectList("trip.selectPositionGroupList", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTripPositionGroupDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectTripPositionGroupDetail", map);
	}

	public int insertTripPositionGroup(Map<String, Object> map) {
		return (Integer)insert("trip.insertTripPositionGroup", map);
	}
	
	public int updateTripPositionGroup(Map<String, Object> map) {
		return (Integer)update("trip.updateTripPositionGroup", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectApplyPositionGroup(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectApplyPositionGroup", map);
	}
	
	public int deleteTripPositionGroup(Map<String, Object> map) {
		return (Integer)delete("trip.deleteTripPositionGroup", map);
	}

	public Object selectTripTransList(Map<String, Object> map) {
		return selectList("trip.selectTripTransList", map);
	}

	public Object selectTripTransListCount(Map<String, Object> map) {
		return selectOne("trip.selectTripTransListCount", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTripTransDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectTripTransDetail", map);
	}

	public int insertTripTrans(Map<String, Object> map) {
		return (Integer)insert("trip.insertTripTrans", map);
	}

	public int updateTripTrans(Map<String, Object> map) {
		return (Integer)update("trip.updateTripTrans", map);
	}

	public int deleteTripTrans(Map<String, Object> map) {
		return (Integer)delete("trip.deleteTripTrans", map);
	}

	public Object selectTripCostList(Map<String, Object> map) {
		return selectList("trip.selectTripCostList", map);
	}

	public Object selectTripCostListCount(Map<String, Object> map) {
		return selectOne("trip.selectTripCostListCount", map);
	}

	public Object selectTripPositionGroupListPop(Map<String, Object> map) {
		return selectList("trip.selectTripPositionGroupListPop", map);
	}

	public Object selectTripAreaListPop(Map<String, Object> map) {
		return selectList("trip.selectTripAreaListPop", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectExistCost(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectExistCost", map);
	}

	public int insertTripCost(Map<String, Object> map) {
		return (Integer)insert("trip.insertTripCost", map);
	}

	public int updateTripCost(Map<String, Object> map) {
		return (Integer)update("trip.updateTripCost", map);
	}

	public int deleteTripCost(Map<String, Object> map) {
		return (Integer)update("trip.deleteTripCost", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectTripCostDetail(Map<String, Object> map) {
		return (Map<String, Object>)selectOne("trip.selectTripCostDetail", map);
	}
}
