package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class YrvacSetupDTO {

    private int yrvacSetupSn;           // 연결설정SN
    private int vcatnKndSn;             // 휴가종류SN
    private int hffcPdStrYr;            // 재직기간_시작적용년도
    private int hffcPdEndYr;            // 재직기간_종료적용년도
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
        return "YrvacSetupDTO{" +
                "yrvacSetupSn=" + yrvacSetupSn +
                ", vcatnKndSn=" + vcatnKndSn +
                ", hffcPdStrYr=" + hffcPdStrYr +
                ", hffcPdEndYr=" + hffcPdEndYr +
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

    public int getYrvacSetupSn() {
        return yrvacSetupSn;
    }

    public void setYrvacSetupSn(int yrvacSetupSn) {
        this.yrvacSetupSn = yrvacSetupSn;
    }

	public int getVcatnKndSn() {
		return vcatnKndSn;
	}

	public void setVcatnKndSn(int vcatnKndSn) {
		this.vcatnKndSn = vcatnKndSn;
	}

	public int getHffcPdStrYr() {
		return hffcPdStrYr;
	}

	public void setHffcPdStrYr(int hffcPdStrYr) {
		this.hffcPdStrYr = hffcPdStrYr;
	}

	public int getHffcPdEndYr() {
		return hffcPdEndYr;
	}

	public void setHffcPdEndYr(int hffcPdEndYr) {
		this.hffcPdEndYr = hffcPdEndYr;
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
