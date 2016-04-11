package com.pinde.sci.model.edc;

import java.io.Serializable;

public class PatientMinMaxIndateForm implements Serializable{
	
	private static final long serialVersionUID = -147176250662665309L;
	
	//机构流水号
	private String orgFlow;
	//入组例数
	private String inCount;
	//第一例入组日期
	private String minInDate;
	//最后一例入组日期
	private String maxInDate;
	
	public String getOrgFlow() {
		return orgFlow;
	}
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}
	public String getInCount() {
		return inCount;
	}
	public void setInCount(String inCount) {
		this.inCount = inCount;
	}
	public String getMinInDate() {
		return minInDate;
	}
	public void setMinInDate(String minInDate) {
		this.minInDate = minInDate;
	}
	public String getMaxInDate() {
		return maxInDate;
	}
	public void setMaxInDate(String maxInDate) {
		this.maxInDate = maxInDate;
	}
	
}
