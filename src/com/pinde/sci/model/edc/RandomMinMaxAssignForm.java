package com.pinde.sci.model.edc;

import java.io.Serializable;



public class RandomMinMaxAssignForm implements Serializable{
	
	private static final long serialVersionUID = -3831034722377386042L;
	
	private String orgFlow;
	public String getOrgFlow() {
		return orgFlow;
	}
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}
	private String assignCount;
	private String minAssignDate;
	private String maxAssignDate;
	
	public String getAssignCount() {
		return assignCount;
	}
	public void setAssignCount(String assignCount) {
		this.assignCount = assignCount;
	}
	public String getMinAssignDate() {
		return minAssignDate;
	}
	public void setMinAssignDate(String minAssignDate) {
		this.minAssignDate = minAssignDate;
	}
	public String getMaxAssignDate() {
		return maxAssignDate;
	}
	public void setMaxAssignDate(String maxAssignDate) {
		this.maxAssignDate = maxAssignDate;
	}
	
}
