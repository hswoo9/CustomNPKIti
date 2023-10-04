package com.duzon.custom.budget.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.duzon.custom.budget.dao.BudgetDAO;

@Service ("BudgetService")
public class BudgetServiceImpl implements BudgetService {
	
	@Resource ( name = "BudgetDAO" )
	private BudgetDAO budgetDAO;

	@Override
	public List<Map<String, Object>> selectLoginHistory(Map<String, Object> map) {
		return budgetDAO.selectLoginHistory(map);
	}
}
