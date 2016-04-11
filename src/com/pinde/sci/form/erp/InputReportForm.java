package com.pinde.sci.form.erp;

import java.io.Serializable;

public class InputReportForm implements Serializable{
	
	private static final long serialVersionUID = 1464420004899904247L;
	
	private String userFlow;
	private String userName;
	private String deptFlow;
	private String deptName;
	private String newCustomerNum;
	private String newCustomerUserNum;
	
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
	public String getDeptFlow() {
		return deptFlow;
	}
	public void setDeptFlow(String deptFlow) {
		this.deptFlow = deptFlow;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getNewCustomerNum() {
		return newCustomerNum;
	}
	public void setNewCustomerNum(String newCustomerNum) {
		this.newCustomerNum = newCustomerNum;
	}
	public String getNewCustomerUserNum() {
		return newCustomerUserNum;
	}
	public void setNewCustomerUserNum(String newCustomerUserNum) {
		this.newCustomerUserNum = newCustomerUserNum;
	}
	
	
}
