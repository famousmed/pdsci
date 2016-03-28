package com.pinde.sci.form.sczyres;

import java.io.Serializable;
import java.util.List;

public class ExtInfoForm implements Serializable{
	
	private static final long serialVersionUID = 1592918930641343959L;

	/**
	 * 籍贯
	 */
	private String nativePlace;
	
	/**
	 * 民族
	 */
	private String nation;
	
	/**
	 * 健康状况
	 */
	private String healthStatus;
	
	/**
	 * 政治面貌
	 */
	private String political;
	
	/**
	 * 婚姻状况
	 */
	private String maritalStatus;
	
	/**
	 * 既往病史
	 */
	private String beforeCase;
	
	/**
	 * 社会工作
	 */
	private String societyWork;
	
	/**
	 * 是否应届生
	 */
	private String yearGraduateFlag;
	
	/**
	 * 生源地省id
	 */
	private String birthProvId;
	
	/**
	 * 生源地省name
	 */
	private String birthProvName;
	
	/**
	 * 生源地市id
	 */
	private String birthCityId;
	
	/**
	 * 生源地市name
	 */
	private String birthCityName;
	
	/**
	 * 生源地区id
	 */
	private String birthAreaId;
	
	/**
	 * 生源地区name
	 */
	private String birthAreaName;
	
	/**
	 * 家庭住址
	 */
	private String homeAddress;
	
	/**
	 * 家庭电话
	 */
	private String homePhome;
	
	/**
	 * 邮编
	 */
	private String zipCode;
	
	/**
	 * 其他方式
	 */
	private String otherWay;
	
	/**
	 * 身份证图片uri
	 */
	private String idNoUri;
	
	/**
	 * 毕业证书url
	 */
	private String certificateUri;
	
	/**
	 * 学位证书uri
	 */
	private String degreeUri;
	
	public String getIdNoUri() {
		return idNoUri;
	}

	public void setIdNoUri(String idNoUri) {
		this.idNoUri = idNoUri;
	}

	/**
	 * 医师资格证uri
	 */
	private String qualifiedUri;
	
	/**
	 * 医师执业证书uri
	 */
	private String regUri;

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

	public String getQualifiedUri() {
		return qualifiedUri;
	}

	public void setQualifiedUri(String qualifiedUri) {
		this.qualifiedUri = qualifiedUri;
	}

	public String getRegUri() {
		return regUri;
	}

	public void setRegUri(String regUri) {
		this.regUri = regUri;
	}

	/**
	 * 工作经历
	 */
	private List<WorkResumeForm> workResumeList;

	public String getNativePlace() {
		return nativePlace;
	}

	public void setNativePlace(String nativePlace) {
		this.nativePlace = nativePlace;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getHealthStatus() {
		return healthStatus;
	}

	public void setHealthStatus(String healthStatus) {
		this.healthStatus = healthStatus;
	}

	public String getPolitical() {
		return political;
	}

	public void setPolitical(String political) {
		this.political = political;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getBeforeCase() {
		return beforeCase;
	}

	public void setBeforeCase(String beforeCase) {
		this.beforeCase = beforeCase;
	}

	public String getSocietyWork() {
		return societyWork;
	}

	public void setSocietyWork(String societyWork) {
		this.societyWork = societyWork;
	}

	public String getYearGraduateFlag() {
		return yearGraduateFlag;
	}

	public void setYearGraduateFlag(String yearGraduateFlag) {
		this.yearGraduateFlag = yearGraduateFlag;
	}

	public String getBirthProvId() {
		return birthProvId;
	}

	public void setBirthProvId(String birthProvId) {
		this.birthProvId = birthProvId;
	}

	public String getBirthProvName() {
		return birthProvName;
	}

	public void setBirthProvName(String birthProvName) {
		this.birthProvName = birthProvName;
	}

	public String getBirthCityId() {
		return birthCityId;
	}

	public void setBirthCityId(String birthCityId) {
		this.birthCityId = birthCityId;
	}

	public String getBirthCityName() {
		return birthCityName;
	}

	public void setBirthCityName(String birthCityName) {
		this.birthCityName = birthCityName;
	}

	public String getBirthAreaId() {
		return birthAreaId;
	}

	public void setBirthAreaId(String birthAreaId) {
		this.birthAreaId = birthAreaId;
	}

	public String getBirthAreaName() {
		return birthAreaName;
	}

	public void setBirthAreaName(String birthAreaName) {
		this.birthAreaName = birthAreaName;
	}

	public String getHomeAddress() {
		return homeAddress;
	}

	public void setHomeAddress(String homeAddress) {
		this.homeAddress = homeAddress;
	}

	public String getHomePhome() {
		return homePhome;
	}

	public void setHomePhome(String homePhome) {
		this.homePhome = homePhome;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getOtherWay() {
		return otherWay;
	}

	public void setOtherWay(String otherWay) {
		this.otherWay = otherWay;
	}

	public List<WorkResumeForm> getWorkResumeList() {
		return workResumeList;
	}

	public void setWorkResumeList(List<WorkResumeForm> workResumeList) {
		this.workResumeList = workResumeList;
	}
}
