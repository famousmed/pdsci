package com.pinde.sci.form.sczyres;

import java.io.Serializable;
import java.util.List;

public class ExtInfoForm implements Serializable{
	
	private static final long serialVersionUID = 1592918930641343959L;

	/**
	 * ����
	 */
	private String nativePlace;
	
	/**
	 * ����
	 */
	private String nation;
	
	/**
	 * ����״��
	 */
	private String healthStatus;
	
	/**
	 * ������ò
	 */
	private String political;
	
	/**
	 * ����״��
	 */
	private String maritalStatus;
	
	/**
	 * ������ʷ
	 */
	private String beforeCase;
	
	/**
	 * ��Ṥ��
	 */
	private String societyWork;
	
	/**
	 * �Ƿ�Ӧ����
	 */
	private String yearGraduateFlag;
	
	/**
	 * ��Դ��ʡid
	 */
	private String birthProvId;
	
	/**
	 * ��Դ��ʡname
	 */
	private String birthProvName;
	
	/**
	 * ��Դ����id
	 */
	private String birthCityId;
	
	/**
	 * ��Դ����name
	 */
	private String birthCityName;
	
	/**
	 * ��Դ����id
	 */
	private String birthAreaId;
	
	/**
	 * ��Դ����name
	 */
	private String birthAreaName;
	
	/**
	 * ��ͥסַ
	 */
	private String homeAddress;
	
	/**
	 * ��ͥ�绰
	 */
	private String homePhome;
	
	/**
	 * �ʱ�
	 */
	private String zipCode;
	
	/**
	 * ������ʽ
	 */
	private String otherWay;
	
	/**
	 * ���֤ͼƬuri
	 */
	private String idNoUri;
	
	/**
	 * ��ҵ֤��url
	 */
	private String certificateUri;
	
	/**
	 * ѧλ֤��uri
	 */
	private String degreeUri;
	
	public String getIdNoUri() {
		return idNoUri;
	}

	public void setIdNoUri(String idNoUri) {
		this.idNoUri = idNoUri;
	}

	/**
	 * ҽʦ�ʸ�֤uri
	 */
	private String qualifiedUri;
	
	/**
	 * ҽʦִҵ֤��uri
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
	 * ��������
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
