package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class SpeclUseHistDTO {

	private int speclUseHistSn;					//SPECL_USE_HIST_SN
	private int speclSn;							//SPECL_SN
	private Date startDt;							//START_DT
	private Date endDt;								//END_DT
	private int speclUseDaycnt;					//SPECL_USE_DAYCNT
	private int sortSn;							//SORT_SN
	private String rmk;								//RMK
	private String useYn;							//USE_YN					
	private int crtrEmplSn;							//CRTR_EMPL_SN
	private Date creatDt;							//CREAT_DT
	private int updusrEmplSn;						//UPDUSR_EMPL_SN
	private Date updtDt;							//UPDT_DT
	public int getSpeclUseHistSn() {
		return speclUseHistSn;
	}
	public void setSpeclUseHistSn(int speclUseHistSn) {
		this.speclUseHistSn = speclUseHistSn;
	}
	public int getSpeclSn() {
		return speclSn;
	}
	public void setSpeclSn(int speclSn) {
		this.speclSn = speclSn;
	}
	public Date getStartDt() {
		return startDt;
	}
	public void setStartDt(Date startDt) {
		this.startDt = startDt;
	}
	public Date getEndDt() {
		return endDt;
	}
	public void setEndDt(Date endDt) {
		this.endDt = endDt;
	}
	public int getSpeclUseDaycnt() {
		return speclUseDaycnt;
	}
	public void setSpeclUseDaycnt(int speclUseDaycnt) {
		this.speclUseDaycnt = speclUseDaycnt;
	}
	public int getSortSn() {
		return sortSn;
	}
	public void setSortSn(int sortSn) {
		this.sortSn = sortSn;
	}
	public String getRmk() {
		return rmk;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public int getCrtrEmplSn() {
		return crtrEmplSn;
	}
	public void setCrtrEmplSn(int crtrEmplSn) {
		this.crtrEmplSn = crtrEmplSn;
	}
	public Date getCreatDt() {
		return creatDt;
	}
	public void setCreatDt(Date creatDt) {
		this.creatDt = creatDt;
	}
	public int getUpdusrEmplSn() {
		return updusrEmplSn;
	}
	public void setUpdusrEmplSn(int updusrEmplSn) {
		this.updusrEmplSn = updusrEmplSn;
	}
	public Date getUpdtDt() {
		return updtDt;
	}
	public void setUpdtDt(Date updtDt) {
		this.updtDt = updtDt;
	}
	

}
