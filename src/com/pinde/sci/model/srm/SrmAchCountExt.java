package com.pinde.sci.model.srm;

import java.io.Serializable;

public class SrmAchCountExt implements Serializable{
  
	/**
	 * 
	 */
	private static final long serialVersionUID = -7509091622438355868L;

	private String orgFlow;
	
	private String orgName;

	private String achTypeId;
	
	private String achTypeName;
	
	private String srmAchCount;

	public String getOrgFlow() {
		return orgFlow;
	}

	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getAchTypeId() {
		return achTypeId;
	}

	public void setAchTypeId(String achTypeId) {
		this.achTypeId = achTypeId;
	}

	public String getAchTypeName() {
		return achTypeName;
	}

	public void setAchTypeName(String achTypeName) {
		this.achTypeName = achTypeName;
	}

	public String getSrmAchCount() {
		return srmAchCount;
	}

	public void setSrmAchCount(String srmAchCount) {
		this.srmAchCount = srmAchCount;
	}
	
	
}
