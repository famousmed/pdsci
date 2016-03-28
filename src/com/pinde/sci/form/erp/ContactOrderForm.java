package com.pinde.sci.form.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpOaContactOrder;

public class ContactOrderForm {

	private ErpOaContactOrder contactOrder;
	
	private String contractStatusId;
	
	private String contactStatusName;
	
	private String contractStatusName;
	
	private String customerAddress;
	
	private String consumerAddress;
	
	private String postName;
	
	private String deptName;
	
	private String telPhone;
	
	private String celPhone;
	
	private String userFlow;
	
	private String userName;
	
	private List<ContactOrderAuditForm> auditList;
	
	private List<ContactVisitForm> contactVisitList;
	
	private ContactOrderDisposeForm disposeForm;

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getPostName() {
		return postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getTelPhone() {
		return telPhone;
	}

	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}

	public String getCelPhone() {
		return celPhone;
	}

	public void setCelPhone(String celPhone) {
		this.celPhone = celPhone;
	}

	public String getUserFlow() {
		return userFlow;
	}

	public void setUserFlow(String userFlow) {
		this.userFlow = userFlow;
	}

	public ErpOaContactOrder getContactOrder() {
		return contactOrder;
	}

	public void setContactOrder(ErpOaContactOrder contactOrder) {
		this.contactOrder = contactOrder;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getContractStatusId() {
		return contractStatusId;
	}

	public void setContractStatusId(String contractStatusId) {
		this.contractStatusId = contractStatusId;
	}

	public String getContractStatusName() {
		return contractStatusName;
	}

	public void setContractStatusName(String contractStatusName) {
		this.contractStatusName = contractStatusName;
	}

	public List<ContactOrderAuditForm> getAuditList() {
		return auditList;
	}

	public void setAuditList(List<ContactOrderAuditForm> auditList) {
		this.auditList = auditList;
	}

	public ContactOrderDisposeForm getDisposeForm() {
		return disposeForm;
	}

	public void setDisposeForm(ContactOrderDisposeForm disposeForm) {
		this.disposeForm = disposeForm;
	}

	public String getContactStatusName() {
		return contactStatusName;
	}

	public void setContactStatusName(String contactStatusName) {
		this.contactStatusName = contactStatusName;
	}

	public List<ContactVisitForm> getContactVisitList() {
		return contactVisitList;
	}

	public void setContactVisitList(List<ContactVisitForm> contactVisitList) {
		this.contactVisitList = contactVisitList;
	}

	public String getConsumerAddress() {
		return consumerAddress;
	}

	public void setConsumerAddress(String consumerAddress) {
		this.consumerAddress = consumerAddress;
	}
	
	
}
