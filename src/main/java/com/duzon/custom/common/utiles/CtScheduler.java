package com.duzon.custom.common.utiles;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.duzon.custom.common.service.CommonService;

public class CtScheduler {
	
	private static final Logger logger = LoggerFactory.getLogger(CtScheduler.class);
	
	@Autowired
	private CommonService commonService;
	
	public void dailyWorkAgree() {
		Map<String, Object> map = new HashMap<String, Object>();
		commonService.dailyWorkAgree(map);
	}
	
	public void setAttCode() {
		commonService.setAttCode();
	}
	
	public void monthlyWorkPlanMake() {
		Map<String, Object> map = new HashMap<String, Object>();
		commonService.monthlyWorkPlanMake(map);
	}

	public void replaceHolidayChangeCode() {
		commonService.replaceHolidayChangeCode();
	}

	public void vcatnUseHistUpdate(){
		commonService.vcatnUseHistUpdate();
	}

}
