package com.pinde.sci.form.jsres;

import java.io.Serializable;

public class ContactorInfoForm implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 联系人的form
	 * @author Administrator
	 */
	/**
	 * 姓名
	 */
	private String contactorName;
	/**
	 * 科室
	 */
	private String dept;
	/**
	 * 固定电话
	 */
	private String phone;
	/**
	 * 手机电话
	 */
	private String mobilephone;
	/**
	 * 职务
	 */
	private String job;
	public String getContactorName() {
		return contactorName;
	}
	public void setContactorName(String contactorName) {
		this.contactorName = contactorName;
	}

	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobilephone() {
		return mobilephone;
	}
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
}
