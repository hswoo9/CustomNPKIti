package com.duzon.custom.common.vo;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

/**

  * @FileName : scheduleVO.java

  * @Date : 2019. 4. 12. 

  * @작성자 : 김찬혁

  * @변경이력 :

  * @프로그램 설명 : 일정 api

  */
public class ScheduleVO {
	
	private String empSeq = "1";
	private String groupSeq = "";
	private String bizSeq = "";
	private String deptSeq = "";
	private String compSeq = "";
	private String emailAddr = "";
	private String emailDomain = "";
	private String pId = "";
	private	String tId = "";
	private	String schmSeq = "0";
	private	String schSeq = "";
	private	String schTitle = "";
	private	String alldayYn = "";
	private	String startDate = "";
	private	String endDate = "";	
	private	String gbnCode = "E";
	private	String gbnSeq = "1";
	private	String schGbnCode = "10";
	private	String repeatType = "10";
	private	String contents = "";
	private	String rangeCode = "N";
	private	String schPlace = "";
	private	String mcalSeq = "28";
	private	String langeCode = "kr";
	
	public String getEmpSeq() {
		return empSeq;
	}
	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}
	public String getGroupSeq() {
		return groupSeq;
	}
	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}
	public String getBizSeq() {
		return bizSeq;
	}
	public void setBizSeq(String bizSeq) {
		this.bizSeq = bizSeq;
	}
	public String getDeptSeq() {
		return deptSeq;
	}
	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}
	public String getCompSeq() {
		return compSeq;
	}
	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getEmailDomain() {
		return emailDomain;
	}
	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String gettId() {
		return tId;
	}
	public void settId(String tId) {
		this.tId = tId;
	}
	public String getSchSeq() {
		return schSeq;
	}
	public void setSchSeq(String schSeq) {
		this.schSeq = schSeq;
	}
	public String getSchmSeq() {
		return schmSeq;
	}
	public void setSchmSeq(String schmSeq) {
		this.schmSeq = schmSeq;
	}
	public String getSchTitle() {
		return schTitle;
	}
	public void setSchTitle(String schTitle) {
		this.schTitle = schTitle;
	}
	public String getAlldayYn() {
		return alldayYn;
	}
	public void setAlldayYn(String alldayYn) {
		this.alldayYn = alldayYn;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getGbnCode() {
		return gbnCode;
	}
	public void setGbnCode(String gbnCode) {
		this.gbnCode = gbnCode;
	}
	public String getGbnSeq() {
		return gbnSeq;
	}
	public void setGbnSeq(String gbnSeq) {
		this.gbnSeq = gbnSeq;
	}
	public String getSchGbnCode() {
		return schGbnCode;
	}
	public void setSchGbnCode(String schGbnCode) {
		this.schGbnCode = schGbnCode;
	}
	public String getRepeatType() {
		return repeatType;
	}
	public void setRepeatType(String repeatType) {
		this.repeatType = repeatType;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getRangeCode() {
		return rangeCode;
	}
	public void setRangeCode(String rangeCode) {
		this.rangeCode = rangeCode;
	}
	public String getSchPlace() {
		return schPlace;
	}
	public void setSchPlace(String schPlace) {
		this.schPlace = schPlace;
	}
	public String getMcalSeq() {
		return mcalSeq;
	}
	public void setMcalSeq(String mcalSeq) {
		this.mcalSeq = mcalSeq;
	}
	public String getLangeCode() {
		return langeCode;
	}
	public void setLangeCode(String langeCode) {
		this.langeCode = langeCode;
	}
	public Map<String, Object> getHeader() {
		return header;
	}
	public void setHeader(Map<String, Object> header) {
		this.header = header;
	}
	public Map<String, Object> getBody() {
		return body;
	}
	public void setBody(Map<String, Object> body) {
		this.body = body;
	}
	public Map<String, Object> getCompanyInfo() {
		return companyInfo;
	}
	public void setCompanyInfo(Map<String, Object> companyInfo) {
		this.companyInfo = companyInfo;
	}
	
	private Map<String, Object> header = new HashMap<String, Object>();
	private Map<String, Object> body = new HashMap<String, Object>();
	private Map<String, Object> companyInfo = new HashMap<String, Object>();
	private Map<String, Object> schedule = new HashMap<String, Object>();

	public String getSchedule() {
				
		header.put("empSeq", empSeq);
		header.put("groupSeq", groupSeq);
		header.put("tId", tId);
		header.put("pId", pId);
		
		body.put("schmSeq", schmSeq);
		body.put("schTitle", schTitle);
		body.put("alldayYn", alldayYn);
		body.put("startDate", startDate);
		body.put("endDate", endDate);
		body.put("gbnCode", gbnCode);		
		body.put("gbnSeq", gbnSeq);
		body.put("schGbnCode", schGbnCode);
		body.put("repeatType", repeatType);
		body.put("contents", contents);
		body.put("rangeCode", rangeCode);
		body.put("schPlace", schPlace);
		body.put("mcalSeq", mcalSeq);
		body.put("langeCode", langeCode);
		
		companyInfo.put("bizSeq", bizSeq);
		companyInfo.put("compSeq", compSeq);
		companyInfo.put("deptSeq", deptSeq);
		companyInfo.put("emailAddr", emailAddr);
		companyInfo.put("emailDomain", emailDomain);
		
		body.put("companyInfo", companyInfo);
		
		schedule.put("header", header);
		schedule.put("body", body);
		
		return new Gson().toJson(schedule);
	}

}
