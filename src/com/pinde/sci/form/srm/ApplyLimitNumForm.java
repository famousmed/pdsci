package com.pinde.sci.form.srm;

import java.io.Serializable;

public class ApplyLimitNumForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6824569415089569440L;
	
	private Short limitNum;
	private Integer auditCount;
	private String resultFlag;
	
	public Short getLimitNum() {
		return limitNum;
	}
	public void setLimitNum(Short limitNum) {
		this.limitNum = limitNum;
	}
	public Integer getAuditCount() {
		return auditCount;
	}
	public void setAuditCount(Integer auditCount) {
		this.auditCount = auditCount;
	}
	public String getResultFlag() {
		return resultFlag;
	}
	public void setResultFlag(String resultFlag) {
		this.resultFlag = resultFlag;
	}

}
