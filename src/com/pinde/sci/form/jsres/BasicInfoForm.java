package com.pinde.sci.form.jsres;

import java.io.Serializable;
import java.util.List;

public class BasicInfoForm implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3081738391574662552L;
	/**
	 * 职业许可证url
	 */
	private String professionLicenceUrl;
	/**
	 * 医院等级证书url
	 */
	private String hospitalLevelLicenceUrl;
	/**
	 * 获得普通专科培训合格证人数
	 */
	private String normalTraningNumber;
	/**
	 * 宿舍床位数
	 */
	private String bedNumber;
	/**
	 * 获得亚专科培训合格证
	 */
	private String inferiorTrainingNumber;
	
	/**
	 * 获得全科培训合格证
	 */
	private String allTrainingNumber;
	/**
	 * 联系人
	 */
	private List<ContactorInfoForm> contactorsList;
	
	public String getProfessionLicenceUrl() {
		return professionLicenceUrl;
	}

	public void setProfessionLicenceUrl(String professionLicenceUrl) {
		this.professionLicenceUrl = professionLicenceUrl;
	}

	public String getHospitalLevelLicenceUrl() {
		return hospitalLevelLicenceUrl;
	}

	public void setHospitalLevelLicenceUrl(String hospitalLevelLicenceUrl) {
		this.hospitalLevelLicenceUrl = hospitalLevelLicenceUrl;
	}

	public String getNormalTraningNumber() {
		return normalTraningNumber;
	}

	public void setNormalTraningNumber(String normalTraningNumber) {
		this.normalTraningNumber = normalTraningNumber;
	}

	public String getBedNumber() {
		return bedNumber;
	}

	public void setBedNumber(String bedNumber) {
		this.bedNumber = bedNumber;
	}

	public String getInferiorTrainingNumber() {
		return inferiorTrainingNumber;
	}

	public void setInferiorTrainingNumber(String inferiorTrainingNumber) {
		this.inferiorTrainingNumber = inferiorTrainingNumber;
	}

	public String getAllTrainingNumber() {
		return allTrainingNumber;
	}

	public void setAllTrainingNumber(String allTrainingNumber) {
		this.allTrainingNumber = allTrainingNumber;
	}

	public List<ContactorInfoForm> getContactorsList() {
		return contactorsList;
	}

	public void setContactorsList(List<ContactorInfoForm> contactorsList) {
		this.contactorsList = contactorsList;
	}

	

	
	

}
