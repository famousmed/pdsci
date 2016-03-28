package com.pinde.sci.form.edc;

import java.io.Serializable;
import java.util.List;

public class EdcPatientIeForm implements Serializable{
	
	private static final long serialVersionUID = -6167050502759087663L;
	
	/**
	 * ������ˮ��
	 */
	private String patientFlow;
	/**
	 * ���˳�������
	 */
	private String patientBirthday;
	/**
	 * ����ƴ����д
	 */
	private String patientName;
	/**
	 * �����Ա�
	 */
	private String sexId;
	/**
	 * Ԥ������
	 */
	private String layerFactors;
	
	/**
	 * ����/�ų���ˮ��
	 */
	private String ieFlow;
	/**
	 * ����/�ų�ֵ
	 */
	private String ieValue;
	/**
	 * ����/�ų�������
	 */
	private String varName;
	private List<EdcPatientIeForm> ieValueList;
	public String getPatientFlow() {
		return patientFlow;
	}
	public void setPatientFlow(String patientFlow) {
		this.patientFlow = patientFlow;
	}
	public String getPatientBirthday() {
		return patientBirthday;
	}
	public void setPatientBirthday(String patientBirthday) {
		this.patientBirthday = patientBirthday;
	}
	
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getSexId() {
		return sexId;
	}
	public void setSexId(String sexId) {
		this.sexId = sexId;
	}
	
	public String getLayerFactors() {
		return layerFactors;
	}
	public void setLayerFactors(String layerFactors) {
		this.layerFactors = layerFactors;
	}
	public String getIeFlow() {
		return ieFlow;
	}
	public void setIeFlow(String ieFlow) {
		this.ieFlow = ieFlow;
	}
	public String getIeValue() {
		return ieValue;
	}
	public void setIeValue(String ieValue) {
		this.ieValue = ieValue;
	}
	public String getVarName() {
		return varName;
	}
	public void setVarName(String varName) {
		this.varName = varName;
	}
	public List<EdcPatientIeForm> getIeValueList() {
		return ieValueList;
	}
	public void setIeValueList(List<EdcPatientIeForm> ieValueList) {
		this.ieValueList = ieValueList;
	}
	
}
