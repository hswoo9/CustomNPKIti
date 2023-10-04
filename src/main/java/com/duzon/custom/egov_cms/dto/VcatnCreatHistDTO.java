package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class VcatnCreatHistDTO {

	private int vcatnCreatHistSn;								//생성이력SN
	private int vcatnSn;										//휴가SN
	private int vcatnKndSn;										//휴가종류SN
	private String alwncDaycnt;									//부여일
	private String creatGbn;									//생성구분 I 최초부여 U 조정부여
	private String creatResn;									//생성사유
	private int sortSn;											//정렬순번
	private String rmk;											//비고
	private String useYn;										//사용여부
	private int crtrEmplSn;										//생성자SN
	
	private String creatDt;										//생성일시
	private int updusrEmplSn;								 	//수정자SN
	private Date updtDt;										//수정일시
	
	private VcatnDTO vcatnDTO;
	
	@Override
    public String toString() {
		return " [vcatnCreatHistSn=" + this.vcatnCreatHistSn + " [vcatnSn=" + this.vcatnSn + " [vcatnKndSn=" + this.vcatnKndSn +
				" [alwncDaycnt=" + this.alwncDaycnt + " [creatGbn=" + this.creatGbn + " [creatResn=" + this.creatResn +
				" [sortSn=" + this.sortSn + " [rmk=" + this.rmk + " [useYn=" + this.useYn +
				" [crtrEmplSn=" + this.crtrEmplSn + " [creatDt=" + this.creatDt + " [updusrEmplSn=" + this.updusrEmplSn +
				" [updtDt=" + this.updtDt + " ]";
				
	}

	public int getVcatnCreatHistSn() {
		return vcatnCreatHistSn;
	}

	public void setVcatnCreatHistSn(int vcatnCreatHistSn) {
		this.vcatnCreatHistSn = vcatnCreatHistSn;
	}

	public int getVcatnSn() {
		return vcatnSn;
	}

	public void setVcatnSn(int vcatnSn) {
		this.vcatnSn = vcatnSn;
	}

	public int getVcatnKndSn() {
		return vcatnKndSn;
	}

	public void setVcatnKndSn(int vcatnKndSn) {
		this.vcatnKndSn = vcatnKndSn;
	}

	public String getAlwncDaycnt() {
		return alwncDaycnt;
	}

	public void setAlwncDaycnt(String alwncDaycnt) {
		this.alwncDaycnt = alwncDaycnt;
	}

	public String getCreatGbn() {
		return creatGbn;
	}

	public void setCreatGbn(String creatGbn) {
		this.creatGbn = creatGbn;
	}

	public String getCreatResn() {
		return creatResn;
	}

	public void setCreatResn(String creatResn) {
		this.creatResn = creatResn;
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

	public String getCreatDt() {
		return creatDt;
	}

	public void setCreatDt(String creatDt) {
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
		/*
		Date date = new Date(updtDt);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String 
		*/
		this.updtDt = updtDt;
	}

	public VcatnDTO getVcatnDTO() {
		return vcatnDTO;
	}

	public void setVcatnDTO(VcatnDTO vcatnDTO) {
		this.vcatnDTO = vcatnDTO;
	}
}
