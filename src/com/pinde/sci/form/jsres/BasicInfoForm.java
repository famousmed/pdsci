package com.pinde.sci.form.jsres;

import java.io.Serializable;
import java.util.List;

public class BasicInfoForm implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3081738391574662552L;
	/**
	 * ְҵ���֤url
	 */
	private String professionLicenceUrl;
	/**
	 * ҽԺ�ȼ�֤��url
	 */
	private String hospitalLevelLicenceUrl;
	/**
	 * �����ͨר����ѵ�ϸ�֤����
	 */
	private String normalTraningNumber;
	/**
	 * ���ᴲλ��
	 */
	private String bedNumber;
	/**
	 * �����ר����ѵ�ϸ�֤
	 */
	private String inferiorTrainingNumber;
	
	/**
	 * ���ȫ����ѵ�ϸ�֤
	 */
	private String allTrainingNumber;
	/**
	 * ��ϵ��
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
