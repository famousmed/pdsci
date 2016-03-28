package com.pinde.sci.model.pub;

import java.io.Serializable;

public class AidProjExt implements Serializable{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 788889091371392426L;

	private String leadOrgName;
	
	private String projIntr;
	
	private String projRemark;
	
	private String projRemark2;
	
	private String projRemark3;

	public String getProjRemark2() {
		return projRemark2;
	}

	public void setProjRemark2(String projRemark2) {
		this.projRemark2 = projRemark2;
	}

	public String getProjRemark3() {
		return projRemark3;
	}

	public void setProjRemark3(String projRemark3) {
		this.projRemark3 = projRemark3;
	}

	public String getLeadOrgName() {
		return leadOrgName;
	}

	public void setLeadOrgName(String leadOrgName) {
		this.leadOrgName = leadOrgName;
	}

	public String getProjIntr() {
		return projIntr;
	}

	public void setProjIntr(String projIntr) {
		this.projIntr = projIntr;
	}

	public String getProjRemark() {
		return projRemark;
	}

	public void setProjRemark(String projRemark) {
		this.projRemark = projRemark;
	}
	
	
}
