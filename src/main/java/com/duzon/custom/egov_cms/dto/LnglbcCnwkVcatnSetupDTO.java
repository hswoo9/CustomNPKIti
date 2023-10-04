package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class LnglbcCnwkVcatnSetupDTO {

    private int lnglbcCnwkVcatnSetupSn; // 장기근속휴가설정SN
    private int vcatnKndSn;             // 휴가종류SN
    private int cnwkYycnt;              // 근속년수
    private int alwncVcatn;             // 부여휴가
    private String atmcCreatYn;         // 자동생성여부
    private int sortSn;                 // 정렬순번
    private String rmk;                 // 비고
    private String useYn;               // 사용여부
    private int crtrEmplSn;             // 생성자SN
    private Date creatDt;               // 생성일시
    private int updusrEmplSn;           // 수정자SN
    private Date updtDT;                // 수정일시

    @Override
    public String toString() {
        return "LnglbcCnwkVcatnSetupDTO{" +
                "lnglbcCnwkVcatnSetupSn=" + lnglbcCnwkVcatnSetupSn +
                ", vcatnKndSn=" + vcatnKndSn +
                ", cnwkYycnt=" + cnwkYycnt +
                ", alwncVcatn=" + alwncVcatn +
                ", atmcCreatYn='" + atmcCreatYn + '\'' +
                ", sortSn=" + sortSn +
                ", rmk='" + rmk + '\'' +
                ", useYn='" + useYn + '\'' +
                ", crtrEmplSn=" + crtrEmplSn +
                ", creatDt=" + creatDt +
                ", updusrEmplSn=" + updusrEmplSn +
                ", updtDT=" + updtDT +
                '}';
    }

    public int getLnglbcCnwkVcatnSetupSn() {
        return lnglbcCnwkVcatnSetupSn;
    }

    public void setLnglbcCnwkVcatnSetupSn(int lnglbcCnwkVcatnSetupSn) {
        this.lnglbcCnwkVcatnSetupSn = lnglbcCnwkVcatnSetupSn;
    }

	public int getVcatnKndSn() {
		return vcatnKndSn;
	}

	public void setVcatnKndSn(int vcatnKndSn) {
		this.vcatnKndSn = vcatnKndSn;
	}

	public int getCnwkYycnt() {
		return cnwkYycnt;
	}

	public void setCnwkYycnt(int cnwkYycnt) {
		this.cnwkYycnt = cnwkYycnt;
	}

	public int getAlwncVcatn() {
		return alwncVcatn;
	}

	public void setAlwncVcatn(int alwncVcatn) {
		this.alwncVcatn = alwncVcatn;
	}

	public String getAtmcCreatYn() {
		return atmcCreatYn;
	}

	public void setAtmcCreatYn(String atmcCreatYn) {
		this.atmcCreatYn = atmcCreatYn;
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

	public Date getUpdtDT() {
		return updtDT;
	}

	public void setUpdtDT(Date updtDT) {
		this.updtDT = updtDT;
	}
}
