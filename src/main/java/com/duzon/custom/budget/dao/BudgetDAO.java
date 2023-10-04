package com.duzon.custom.budget.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Repository;

import com.duzon.custom.common.dao.AbstractDAO;

@Repository("BudgetDAO")
public class BudgetDAO extends AbstractDAO{

	/* 공통사용 - 커넥션 */

	public List<Map<String, Object>> selectLoginHistory(Map<String, Object> map) {
		return selectList("BudgetMaria.selectLoginHistory", map);
	}
	
}
