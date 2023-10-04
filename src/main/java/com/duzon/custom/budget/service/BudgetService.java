package com.duzon.custom.budget.service;

import java.util.List;
import java.util.Map;

public interface BudgetService {
	List<Map<String, Object>> selectLoginHistory(Map<String, Object> map);
}
