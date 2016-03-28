package com.pinde.sci.form.jsres;

import java.io.Serializable;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import com.pinde.sci.model.mo.PubUserResume;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class UserResumeExtInfoForm extends PubUserResume implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5225098729470455347L;
	
	/**
	 * ֤������
	 */
	private String certificateType;
	
	/**
	 * ֤����
	 */
	private String certificateNo;
	
	/**
	 * �̶��绰
	 */
	private String telephone;
	
	/**
	 * ��Ա����
	 */
	private String personnelType;
	
	/**
	 * ������λ
	 */
	private String WorkUnit;
	
	/**
	 * ������ϵ�˵�ַ
	 */
	private String emergencyAddress;
	
	/**
	 * ѧԺ֤����
	 */
	private String collegeCertificateNo;
	
	/**
	 * ��ҵ֤��URI
	 */
	private String certificateUri;
	
	/**
	 * ѧλ֤��URI
	 */
	private String degreeUri;
	
	/**
	 * רҵ�����ʸ�
	 */
	private String technologyQualification;
	
	/**
	 * ȡ������
	 */
	private String getTechnologyQualificationDate;
	
	/**
	 * ִҵ�ʸ����
	 */
	private String qualificationMaterial;
	
	/**
	 * �ʸ���ϱ���
	 */
	private String qualificationMaterialCode;
	
	/**
	 * ִҵ���
	 */
	private String practicingCategory;
	
	/**
	 * ִҵ��Χ
	 */
	private String practicingScope;

	public String getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(String certificateType) {
		this.certificateType = certificateType;
	}

	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getPersonnelType() {
		return personnelType;
	}

	public void setPersonnelType(String personnelType) {
		this.personnelType = personnelType;
	}

	public String getEmergencyAddress() {
		return emergencyAddress;
	}

	public void setEmergencyAddress(String emergencyAddress) {
		this.emergencyAddress = emergencyAddress;
	}

	public String getCollegeCertificateNo() {
		return collegeCertificateNo;
	}

	public void setCollegeCertificateNo(String collegeCertificateNo) {
		this.collegeCertificateNo = collegeCertificateNo;
	}

	public String getTechnologyQualification() {
		return technologyQualification;
	}

	public void setTechnologyQualification(String technologyQualification) {
		this.technologyQualification = technologyQualification;
	}

	public String getGetTechnologyQualificationDate() {
		return getTechnologyQualificationDate;
	}

	public void setGetTechnologyQualificationDate(
			String getTechnologyQualificationDate) {
		this.getTechnologyQualificationDate = getTechnologyQualificationDate;
	}

	public String getQualificationMaterial() {
		return qualificationMaterial;
	}

	public void setQualificationMaterial(String qualificationMaterial) {
		this.qualificationMaterial = qualificationMaterial;
	}

	public String getQualificationMaterialCode() {
		return qualificationMaterialCode;
	}

	public void setQualificationMaterialCode(String qualificationMaterialCode) {
		this.qualificationMaterialCode = qualificationMaterialCode;
	}

	public String getPracticingCategory() {
		return practicingCategory;
	}

	public void setPracticingCategory(String practicingCategory) {
		this.practicingCategory = practicingCategory;
	}

	public String getWorkUnit() {
		return WorkUnit;
	}

	public void setWorkUnit(String workUnit) {
		WorkUnit = workUnit;
	}

	public String getPracticingScope() {
		return practicingScope;
	}

	public void setPracticingScope(String practicingScope) {
		this.practicingScope = practicingScope;
	}

	public String getCertificateUri() {
		return certificateUri;
	}

	public void setCertificateUri(String certificateUri) {
		this.certificateUri = certificateUri;
	}

	public String getDegreeUri() {
		return degreeUri;
	}

	public void setDegreeUri(String degreeUri) {
		this.degreeUri = degreeUri;
	}

}
