package com.duzon.custom.egov_cms.dto;

import java.util.Date;

public class SpeclVcatnSetupDTO {

    private int speclVcatnSetupSn;      // 특별휴가설정SN
    private int vcatnKndSn;             // 휴가종류SN
    private String payYn;               // 유급여부
    private String applyTgt;            // 적용대상
    private String applyW;              // 적용대상
    private String applyM;              // 적용대상
    private String applyC;              // 적용대상
    private int alwncVcatn;             // 부여휴가
    private String alwncVcatnUnit;      // 부여휴가단위
    private String alwncVcatnBase;      // 부여휴가기준
    private String cnIndictYn;          // 내용표시여부
    private String cn;                  // 표시내용
    private String aftfatMntYn;         // 사후관리여부
    private String aftfatMntMth;        // 사후관리방법
    private int aftfatMntMthCmmnCd;     // 사후관리방법_공통코드SN
    private String aftfatMntFrmtName;   // 사후관리_양식명
    private String cTikeycode;          // 사후관리_양식명SEQ
    private String validPdYn;           // 유효기간적용여부
    private int validPd;                // 유효기간
    private String validPdUnit;         // 유효기간단위
    private int validPdCmmnCd;          // 유효기간단위_공통코드SN
    private int sortSn;                 // 정렬순번
    private String rmk;                 // 비고
    private String useYn;               // 사용여부
    private int crtrEmplSn;             // 생성자SN
    private Date creatDt;               // 생성일시
    private int updusrEmplSn;           // 수정자SN
    private Date updtDT;                // 수정일시


    @Override
    public String toString() {
        return "SpeclVcatnSetupDTO{" +
                "speclVcatnSetupSn=" + speclVcatnSetupSn +
                ", vcatnKndSn=" + vcatnKndSn +
                ", payYn='" + payYn + '\'' +
                ", applyTgt='" + applyTgt + '\'' +
                ", applyW='" + applyW + '\'' +
                ", applyM='" + applyM + '\'' +
                ", applyC='" + applyC + '\'' +
                ", alwncVcatn=" + alwncVcatn +
                ", alwncVcatnUnit='" + alwncVcatnUnit + '\'' +
                ", alwncVcatnBase='" + alwncVcatnBase + '\'' +
                ", cnIndictYn='" + cnIndictYn + '\'' +
                ", cn='" + cn + '\'' +
                ", aftfatMntYn='" + aftfatMntYn + '\'' +
                ", aftfatMntMth='" + aftfatMntMth + '\'' +
                ", aftfatMntMthCmmnCd=" + aftfatMntMthCmmnCd +
                ", aftfatMntFrmtName='" + aftfatMntFrmtName + '\'' +
                ", cTikeycode=" + cTikeycode +
                ", validPdYn='" + validPdYn + '\'' +
                ", validPd=" + validPd +
                ", validPdUnit='" + validPdUnit + '\'' +
                ", validPdCmmnCd=" + validPdCmmnCd +
                ", sortSn=" + sortSn +
                ", rmk='" + rmk + '\'' +
                ", useYn='" + useYn + '\'' +
                ", crtrEmplSn=" + crtrEmplSn +
                ", creatDt=" + creatDt +
                ", updusrEmplSn=" + updusrEmplSn +
                ", updtDT=" + updtDT +
                '}';
    }

    public String getPayYn() {
        return payYn;
    }

    public void setPayYn(String payYn) {
        this.payYn = payYn;
    }

    public String getApplyTgt() {
        return applyTgt;
    }

    public void setApplyTgt(String applyTgt) {
        this.applyTgt = applyTgt;
    }

    public String getApplyW() {
        return applyW;
    }

    public void setApplyW(String applyW) {
        this.applyW = applyW;
    }

    public String getApplyM() {
        return applyM;
    }

    public void setApplyM(String applyM) {
        this.applyM = applyM;
    }

    public String getApplyC() {
        return applyC;
    }

    public void setApplyC(String applyC) {
        this.applyC = applyC;
    }

    public int getAlwncVcatn() {
        return alwncVcatn;
    }

    public void setAlwncVcatn(int alwncVcatn) {
        this.alwncVcatn = alwncVcatn;
    }

    public String getAlwncVcatnUnit() {
        return alwncVcatnUnit;
    }

    public void setAlwncVcatnUnit(String alwncVcatnUnit) {
        this.alwncVcatnUnit = alwncVcatnUnit;
    }

    public String getAlwncVcatnBase() {
        return alwncVcatnBase;
    }

    public void setAlwncVcatnBase(String alwncVcatnBase) {
        this.alwncVcatnBase = alwncVcatnBase;
    }

    public String getCnIndictYn() {
        return cnIndictYn;
    }

    public void setCnIndictYn(String cnIndictYn) {
        this.cnIndictYn = cnIndictYn;
    }

    public String getCn() {
        return cn;
    }

    public void setCn(String cn) {
        this.cn = cn;
    }

    public String getAftfatMntYn() {
        return aftfatMntYn;
    }

    public void setAftfatMntYn(String aftfatMntYn) {
        this.aftfatMntYn = aftfatMntYn;
    }

    public String getAftfatMntMth() {
        return aftfatMntMth;
    }

    public void setAftfatMntMth(String aftfatMntMth) {
        this.aftfatMntMth = aftfatMntMth;
    }

    public int getAftfatMntMthCmmnCd() {
        return aftfatMntMthCmmnCd;
    }

    public void setAftfatMntMthCmmnCd(int aftfatMntMthCmmnCd) {
        this.aftfatMntMthCmmnCd = aftfatMntMthCmmnCd;
    }

    public String getAftfatMntFrmtName() {
        return aftfatMntFrmtName;
    }

    public void setAftfatMntFrmtName(String aftfatMntFrmtName) {
        this.aftfatMntFrmtName = aftfatMntFrmtName;
    }

    public String getcTikeycode() {
        return cTikeycode;
    }

    public void setcTikeycode(String cTikeycode) {
        this.cTikeycode = cTikeycode;
    }

    public String getValidPdYn() {
        return validPdYn;
    }

    public void setValidPdYn(String validPdYn) {
        this.validPdYn = validPdYn;
    }

    public int getValidPd() {
        return validPd;
    }

    public void setValidPd(int validPd) {
        this.validPd = validPd;
    }

    public String getValidPdUnit() {
        return validPdUnit;
    }

    public void setValidPdUnit(String validPdUnit) {
        this.validPdUnit = validPdUnit;
    }

    public int getValidPdCmmnCd() {
        return validPdCmmnCd;
    }

    public void setValidPdCmmnCd(int validPdCmmnCd) {
        this.validPdCmmnCd = validPdCmmnCd;
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

    public int getVcatnKndSn() {
        return vcatnKndSn;
    }

    public void setVcatnKndSn(int vcatnKndSn) {
        this.vcatnKndSn = vcatnKndSn;
    }

    public int getSpeclVcatnSetupSn() {
        return speclVcatnSetupSn;
    }

    public void setSpeclVcatnSetupSn(int speclVcatnSetupSn) {
        this.speclVcatnSetupSn = speclVcatnSetupSn;
    }
}
