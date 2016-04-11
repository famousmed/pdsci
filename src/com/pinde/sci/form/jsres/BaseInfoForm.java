package com.pinde.sci.form.jsres;

import java.io.Serializable;
import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.SysOrg;

public class BaseInfoForm implements Serializable {
	/**
	 * @author Administrator
	 */
	private static final long serialVersionUID = 3265544507795331566L;
	private SysOrg sysOrg;
	private ResBase resBase;
    private BasicInfoForm basicInfo;
    private EducationInfo educationInfo;
    private OrganizationManage organizationManage;
    private SupportCondition supportCondition;
    
	public EducationInfo getEducationInfo() {
		return educationInfo;
	}
	public void setEducationInfo(EducationInfo educationInfo) {
		this.educationInfo = educationInfo;
	}
	public SysOrg getSysOrg() {
		return sysOrg;
	}
	public void setSysOrg(SysOrg sysOrg) {
		this.sysOrg = sysOrg;
	}
	public ResBase getResBase() {
		return resBase;
	}
	public BasicInfoForm getBasicInfo() {
		return basicInfo;
	}
	public void setBasicInfo(BasicInfoForm basicInfo) {
		this.basicInfo = basicInfo;
	}
	public void setResBase(ResBase resBase) {
		this.resBase = resBase;
	}
	public OrganizationManage getOrganizationManage() {
		return organizationManage;
	}
	public void setOrganizationManage(OrganizationManage organizationManage) {
		this.organizationManage = organizationManage;
	}
	public SupportCondition getSupportCondition() {
		return supportCondition;
	}
	public void setSupportCondition(SupportCondition supportCondition) {
		this.supportCondition = supportCondition;
	}
	



}
