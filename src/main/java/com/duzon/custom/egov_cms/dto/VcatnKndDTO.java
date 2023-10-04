package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class VcatnKndDTO {

    private int vcatnKndSn;             // 휴가종류SN
    private String vcatnGbnName;        // 휴가구분명
    private int vcatnGbnCmmnCd;         // 휴가구분_공통코드SN
    private String vcatnKndName;        // 휴가종류명
    private String useUnit;             // 사용단위
    private String bsicVal;             // 기본값
    private int sortSn;                 // 정렬순번
    private String rmk;                 // 비고
    private String useYn;               // 사용여부
    private int crtrEmplSn;             // 생성자SN
    private Date creatDt;               // 생성일시
    private int updusrEmplSn;           // 수정자SN
    private Date updtDT;                // 수정일시
    private String vcatnType;			// 휴가코드비고값

    @Override
    public String toString() {
        return "VcatnKndDTO{" +
                "vcatnKndSn=" + vcatnKndSn +
                ", vcatnGbnName='" + vcatnGbnName + '\'' +
                ", vcatnGbnCmmnCd=" + vcatnGbnCmmnCd +
                ", vcatnKndName='" + vcatnKndName + '\'' +
                ", useUnit='" + useUnit + '\'' +
                ", bsicVal='" + bsicVal + '\'' +
                ", sortSn=" + sortSn +
                ", rmk='" + rmk + '\'' +
                ", useYn='" + useYn + '\'' +
                ", crtrEmplSn=" + crtrEmplSn +
                ", creatDt=" + creatDt +
                ", updusrEmplSn=" + updusrEmplSn +
                ", updtDT=" + updtDT +
                ", vcatnType=" + vcatnType +
                '}';
    }

    public int getVcatnKndSn() {
        return vcatnKndSn;
    }

    public void setVcatnKndSn(int vcatnKndSn) {
        this.vcatnKndSn = vcatnKndSn;
    }

	public String getVcatnGbnName() {
		return vcatnGbnName;
	}

	public void setVcatnGbnName(String vcatnGbnName) {
		this.vcatnGbnName = vcatnGbnName;
	}

	public int getVcatnGbnCmmnCd() {
		return vcatnGbnCmmnCd;
	}

	public void setVcatnGbnCmmnCd(int vcatnGbnCmmnCd) {
		this.vcatnGbnCmmnCd = vcatnGbnCmmnCd;
	}

	public String getVcatnKndName() {
		return vcatnKndName;
	}

	public void setVcatnKndName(String vcatnKndName) {
		this.vcatnKndName = vcatnKndName;
	}

	public String getUseUnit() {
		return useUnit;
	}

	public void setUseUnit(String useUnit) {
		this.useUnit = useUnit;
	}

	public String getBsicVal() {
		return bsicVal;
	}

	public void setBsicVal(String bsicVal) {
		this.bsicVal = bsicVal;
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

	public String getVcatnType() {
		if(vcatnType == null) {
			this.vcatnType = "";
		}
		return vcatnType;
	}

	public void setVcatnType(String vcatnType) {
		this.vcatnType = vcatnType;
	}
}
