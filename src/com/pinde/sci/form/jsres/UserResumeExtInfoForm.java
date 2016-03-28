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
	 * 证件类型
	 */
	private String certificateType;
	
	/**
	 * 证件号
	 */
	private String certificateNo;
	
	/**
	 * 固定电话
	 */
	private String telephone;
	
	/**
	 * 人员类型
	 */
	private String personnelType;
	
	/**
	 * 工作单位
	 */
	private String WorkUnit;
	
	/**
	 * 紧急联系人地址
	 */
	private String emergencyAddress;
	
	/**
	 * 学院证书编号
	 */
	private String collegeCertificateNo;
	
	/**
	 * 毕业证书URI
	 */
	private String certificateUri;
	
	/**
	 * 学位证书URI
	 */
	private String degreeUri;
	
	/**
	 * 专业技术资格
	 */
	private String technologyQualification;
	
	/**
	 * 取得日期
	 */
	private String getTechnologyQualificationDate;
	
	/**
	 * 执业资格材料
	 */
	private String qualificationMaterial;
	
	/**
	 * 资格材料编码
	 */
	private String qualificationMaterialCode;
	
	/**
	 * 执业类别
	 */
	private String practicingCategory;
	
	/**
	 * 执业范围
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
