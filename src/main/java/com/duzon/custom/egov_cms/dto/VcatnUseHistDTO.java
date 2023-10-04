package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class VcatnUseHistDTO {

	

	private int vcatnUseHistSn;							//사용이력SN
	private int vcatnSn;								//휴가SN
	private int speclSn;								//특별휴가SN
	private int vcatnKndSn;								//휴가종류SN
	private Date vcatnUseStdt;							//사용시작일
	private Date vcatnUseEndt;							//사용종료일
	private Double useDay;								//사용일
	private String approKey;							//문서번호
	private int sortSn;									//정렬순번
	private String rmk;									//비고
	private String useYn;								//사용여부
	private int crtrEmplSn;								//생성자SN
	private Date creatDt;								//생성일시
	private int updusrEmplSn;							//수정자SN
	private Date updtDt;								//수정일시
	private String targetEmpSeq;

	private String attTime;								//사용시간 예)1시간이면 0100, 2시간이면 0200 ...

	private String annvYear;
	private int useSqno;
	
	@Override
	public String toString() {
		return "VcatnUseHistDTO [vcatnUseHistSn=" + vcatnUseHistSn + ", vcatnSn=" + vcatnSn + ", speclSn=" + speclSn
				+ ", vcatnKndSn=" + vcatnKndSn + ", vcatnUseStdt=" + vcatnUseStdt + ", vcatnUseEndt=" + vcatnUseEndt
				+ ", useDay=" + useDay + ", approKey=" + approKey + ", sortSn=" + sortSn + ", rmk=" + rmk + ", useYn="
				+ useYn + ", crtrEmplSn=" + crtrEmplSn + ", creatDt=" + creatDt + ", updusrEmplSn=" + updusrEmplSn
				+ ", updtDt=" + updtDt + ", targetEmpSeq=" + targetEmpSeq + ", attTime=" + attTime + "]";
	}

	public int getSpeclSn() {
		return speclSn;
	}

	public void setSpeclSn(int speclSn) {
		this.speclSn = speclSn;
	}

	public String getApproKey() {
		return approKey;
	}

	public void setApproKey(String approKey) {
		this.approKey = approKey;
	}

	public Double getUseDay() {
		return useDay;
	}

	public void setUseDay(Double useDay) {
		this.useDay = useDay;
	}

	public int getVcatnUseHistSn() {
		return vcatnUseHistSn;
	}


	public void setVcatnUseHistSn(int vcatnUseHistSn) {
		this.vcatnUseHistSn = vcatnUseHistSn;
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


	public Date getVcatnUseStdt() {
		return vcatnUseStdt;
	}


	public void setVcatnUseStdt(Date vcatnUseStdt) {
		this.vcatnUseStdt = vcatnUseStdt;
	}


	public Date getVcatnUseEndt() {
		return vcatnUseEndt;
	}


	public void setVcatnUseEndt(Date vcatnUseEndt) {
		this.vcatnUseEndt = vcatnUseEndt;
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

	public String getTargetEmpSeq() {
		return targetEmpSeq;
	}

	public void setTargetEmpSeq(String targetEmpSeq) {
		this.targetEmpSeq = targetEmpSeq;
	}

	public String getAttTime() {
		return attTime;
	}

	public void setAttTime(String attTime) {
		this.attTime = attTime;
	}

	public String getAnnvYear() {return annvYear;}

	public void setAnnvYear(String annvYear) {this.annvYear = annvYear;}

	public int getUseSqno() {return useSqno;}

	public void setUseSqno(int useSqno) {this.useSqno = useSqno;}

}
