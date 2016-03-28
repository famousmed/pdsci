package com.pinde.sci.form.erp;

public class ContactOrderAuditForm {
   
	private String userFlow;
	
	private String userName;
	
	private String auditDate;
	
	private String auditStatusId;
	
	private String auditStatusName;
	
	private String auditContent;

	public String getUserFlow() {
		return userFlow;
	}

	public void setUserFlow(String userFlow) {
		this.userFlow = userFlow;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAuditContent() {
		return auditContent;
	}

	public void setAuditContent(String auditContent) {
		this.auditContent = auditContent;
	}

	public String getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(String auditDate) {
		this.auditDate = auditDate;
	}

	public String getAuditStatusId() {
		return auditStatusId;
	}

	public void setAuditStatusId(String auditStatusId) {
		this.auditStatusId = auditStatusId;
	}

	public String getAuditStatusName() {
		return auditStatusName;
	}

	public void setAuditStatusName(String auditStatusName) {
		this.auditStatusName = auditStatusName;
	}
	
	
}
