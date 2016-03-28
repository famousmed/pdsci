package com.pinde.sci.form.jsres;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class BaseExtInfoForm {
	/**
	 * �����صĻ�����Ϣ
	 */
	private BasicInfoForm basicInfo ;
	/**
	 * ��ѧ��Ϣ
	 */
	private EducationInfo educationInfo;
	/**
	 * ��֯�������Ϣ
	 * @return
	 */
	private OrganizationManage organizationManage;
	/**
	 * ֧������
	 * @return
	 */
	private SupportCondition supportCondition;
	
	
	
	public EducationInfo getEducationInfo() {
		return educationInfo;
	}
	public void setEducationInfo(EducationInfo educationInfo) {
		this.educationInfo = educationInfo;
	}
	public void setBasicInfo(BasicInfoForm basicInfo) {
		this.basicInfo = basicInfo;
	}
	public BasicInfoForm getBasicInfo() {
		return basicInfo;
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
