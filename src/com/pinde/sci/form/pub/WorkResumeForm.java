package com.pinde.sci.form.pub;

import java.io.Serializable;

public class WorkResumeForm implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2362216736053726278L;
	private String startDate;
	private String endDate;
	private String orgName;
	private String department;
	private String title;
	
	private String recordId;
	
	
	public String getRecordId() {
		return recordId;
	}
	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
}
