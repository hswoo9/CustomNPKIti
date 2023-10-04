package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class VcatnDTO {

	private int vcatnSn;						//휴가SN
	private String applyYr;						//적용년도
	private String deptName;					//부서명
	private String deptSeq;						//부서seq
	private String empSeq;						//사원seq
	private String empName;						//사원명
	private String yrvacFrstAlwncDaycnt;			//연가 최초부여일
	private String yrvacMdtnAlwncDaycnt;			//연가 조정부여일
	private String yrvacRemndrDaycnt;				//연가 잔여일
	private String yrvacUseDaycnt;					//연가 사용일
	private String yrvacCreatResn;				//연가 조정사유
	private String lnglbcVcatnFrstAlwncDaycnt;		//장기근속휴가 최초부여일
	private String lnglbcVcatnMdtnAlwncDaycnt;		//장기근속휴가 조정부여일
	private String lnglbcVcatnRemndrDaycnt;		//장기근속휴가 잔여일
	private String lnglbcVcatnUseDaycnt;			//장기근속휴가 사용일
	private String lnglbcVcatnCreatResn;		//장기근속휴가 조정사유
	private String speclVcatnRemndrDaycnt;			//특별휴가 잔여일
	private String speclVcatnUseDaycnt;			//특별휴가 사용일
	private int sortSn;							//정렬순번
	private String rmk;							//비고
	private String useYn;						//사용여부
	private int crtrEmplSn;						//생성자SN
	private Date creatDt;						//생성일시
	private int updusrEmplSn;					//수정자SN
	private Date updtDt;						//수정일시
	private Date lnglbcLastDt;
	
	
	@Override
    public String toString() {
		return "[vcatnSn=" + this.vcatnSn + " [applyYr=" + this.applyYr + " [deptName=" + this.deptName + " [deptSeq=" + this.deptSeq +
				" [empSeq=" + this.empSeq + " [empName=" + this.empName + " [yrvacFrstAlwncDaycnt=" + this.yrvacFrstAlwncDaycnt + " [yrvacMdtnAlwncDaycnt=" + this.yrvacMdtnAlwncDaycnt +
				" [yrvacRemndrDaycnt=" + this.yrvacRemndrDaycnt + " [yrvacUseDaycnt=" + this.yrvacUseDaycnt + " [lnglbcVcatnFrstAlwncDaycnt=" + this.lnglbcVcatnFrstAlwncDaycnt + 
				" [lnglbcVcatnMdtnAlwncDaycnt=" + this.lnglbcVcatnMdtnAlwncDaycnt + " [lnglbcVcatnRemndrDaycnt=" + this.lnglbcVcatnRemndrDaycnt + " [lnglbcVcatnUseDaycnt=" + this.lnglbcVcatnUseDaycnt +
				" [speclVcatnRemndrDaycnt=" + this.speclVcatnRemndrDaycnt + " [speclVcatnUseDaycnt=" + this.speclVcatnUseDaycnt + " [sortSn=" + this.sortSn + " [rmk=" + this.rmk +
				" [useYn=" + this.useYn + " [crtrEmplSn=" + this.crtrEmplSn + " [creatDt=" + this.creatDt + " [updusrEmplSn=" + this.updusrEmplSn + " [updtDt=" + this.updtDt + "]";
				
	}

	public int getVcatnSn() {
		return vcatnSn;
	}

	public void setVcatnSn(int vcatnSn) {
		this.vcatnSn = vcatnSn;
	}

	public String getApplyYr() {
		return applyYr;
	}

	public void setApplyYr(String applyYr) {
		this.applyYr = applyYr;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getDeptSeq() {
		return deptSeq;
	}

	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}

	public String getEmpSeq() {
		return empSeq;
	}

	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
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

	public String getYrvacCreatResn() {
		return yrvacCreatResn;
	}

	public void setYrvacCreatResn(String yrvacCreatResn) {
		this.yrvacCreatResn = yrvacCreatResn;
	}

	public String getLnglbcVcatnCreatResn() {
		return lnglbcVcatnCreatResn;
	}

	public void setLnglbcVcatnCreatResn(String lnglbcVcatnCreatResn) {
		this.lnglbcVcatnCreatResn = lnglbcVcatnCreatResn;
	}

	public String getYrvacFrstAlwncDaycnt() {
		return yrvacFrstAlwncDaycnt;
	}

	public void setYrvacFrstAlwncDaycnt(String yrvacFrstAlwncDaycnt) {
		this.yrvacFrstAlwncDaycnt = yrvacFrstAlwncDaycnt;
	}

	public String getYrvacMdtnAlwncDaycnt() {
		return yrvacMdtnAlwncDaycnt;
	}

	public void setYrvacMdtnAlwncDaycnt(String yrvacMdtnAlwncDaycnt) {
		this.yrvacMdtnAlwncDaycnt = yrvacMdtnAlwncDaycnt;
	}

	public String getYrvacRemndrDaycnt() {
		return yrvacRemndrDaycnt;
	}

	public void setYrvacRemndrDaycnt(String yrvacRemndrDaycnt) {
		this.yrvacRemndrDaycnt = yrvacRemndrDaycnt;
	}

	public String getYrvacUseDaycnt() {
		return yrvacUseDaycnt;
	}

	public void setYrvacUseDaycnt(String yrvacUseDaycnt) {
		this.yrvacUseDaycnt = yrvacUseDaycnt;
	}

	public String getLnglbcVcatnFrstAlwncDaycnt() {
		return lnglbcVcatnFrstAlwncDaycnt;
	}

	public void setLnglbcVcatnFrstAlwncDaycnt(String lnglbcVcatnFrstAlwncDaycnt) {
		this.lnglbcVcatnFrstAlwncDaycnt = lnglbcVcatnFrstAlwncDaycnt;
	}

	public String getLnglbcVcatnMdtnAlwncDaycnt() {
		return lnglbcVcatnMdtnAlwncDaycnt;
	}

	public void setLnglbcVcatnMdtnAlwncDaycnt(String lnglbcVcatnMdtnAlwncDaycnt) {
		this.lnglbcVcatnMdtnAlwncDaycnt = lnglbcVcatnMdtnAlwncDaycnt;
	}

	public String getLnglbcVcatnRemndrDaycnt() {
		return lnglbcVcatnRemndrDaycnt;
	}

	public void setLnglbcVcatnRemndrDaycnt(String lnglbcVcatnRemndrDaycnt) {
		this.lnglbcVcatnRemndrDaycnt = lnglbcVcatnRemndrDaycnt;
	}

	public String getLnglbcVcatnUseDaycnt() {
		return lnglbcVcatnUseDaycnt;
	}

	public void setLnglbcVcatnUseDaycnt(String lnglbcVcatnUseDaycnt) {
		this.lnglbcVcatnUseDaycnt = lnglbcVcatnUseDaycnt;
	}

	public String getSpeclVcatnRemndrDaycnt() {
		return speclVcatnRemndrDaycnt;
	}

	public void setSpeclVcatnRemndrDaycnt(String speclVcatnRemndrDaycnt) {
		this.speclVcatnRemndrDaycnt = speclVcatnRemndrDaycnt;
	}

	public String getSpeclVcatnUseDaycnt() {
		return speclVcatnUseDaycnt;
	}

	public void setSpeclVcatnUseDaycnt(String speclVcatnUseDaycnt) {
		this.speclVcatnUseDaycnt = speclVcatnUseDaycnt;
	}

	public Date getLnglbcLastDt() {
		return lnglbcLastDt;
	}

	public void setLnglbcLastDt(Date lnglbcLastDt) {
		this.lnglbcLastDt = lnglbcLastDt;
	}

}
