package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class SpeclDTO {

	private int speclSn;						//특별휴가SN		SPECL_SN
	private int speclVcatnSetupSn;				//특별휴가설정SN	SPECL_VCATN_SETUP_SN
	private String deptName;					//부서명			DEPT_NAME
	private String deptSeq;						//부서seq			DEPT_SEQ
	private String empSeq;						//사원seq			EMP_SEQ
	private String empName;						//사원명			EMP_NAME
	private int alwncDaycnt;					//부여일			ALWNC_DAYCNT
	private String rmk;							//비고			RMK
	private int sortSn;							//정렬순번			SORT_SN
	private String useYn;						//사용여부			USE_YN
	private int crtrEmplSn;						//생성자SN		CRTR_EMPL_SN
	private Date creatDt;						//생성일시			CREAT_DT
	private int updusrEmplSn;					//수정자SN		UPDUSR_EMPL_SN
	private Date updtDt;						//수정일시			UPDT_DT
	
	@Override
	public String toString() {
		
		return " [ speclSn " + this.speclSn + " [ speclVcatnSetupSn " + this.speclVcatnSetupSn + " [ deptName " + this.deptName +
				" [ deptSeq " + this.deptSeq + " [ empSeq " + this.empSeq + " [ empName " + this.empName +
				" [ alwncDaycnt " + this.alwncDaycnt + " [ rmk " + this.rmk + " [ sortSn " + this.sortSn +
				" [ useYn " + this.useYn + " [ rmk " + this.rmk + " [ crtrEmplSn " + this.crtrEmplSn +
				" [ creatDt " + this.creatDt + " [ updusrEmplSn " + this.updusrEmplSn + " [ updtDt " + this.updtDt + "";
	}
	public int getSpeclSn() {
		return speclSn;
	}
	public void setSpeclSn(int speclSn) {
		this.speclSn = speclSn;
	}
	public int getSpeclVcatnSetupSn() {
		return speclVcatnSetupSn;
	}
	public void setSpeclVcatnSetupSn(int speclVcatnSetupSn) {
		this.speclVcatnSetupSn = speclVcatnSetupSn;
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
	public int getAlwncDaycnt() {
		return alwncDaycnt;
	}
	public void setAlwncDaycnt(int alwncDaycnt) {
		this.alwncDaycnt = alwncDaycnt;
	}
	public String getRmk() {
		return rmk;
	}
	public void setRmk(String rmk) {
		this.rmk = rmk;
	}
	public int getSortSn() {
		return sortSn;
	}
	public void setSortSn(int sortSn) {
		this.sortSn = sortSn;
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
