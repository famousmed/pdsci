package com.pinde.sci.form.edc;

import java.io.Serializable;
import java.util.List;

public class EdcPatientIeForm implements Serializable{
	
	private static final long serialVersionUID = -6167050502759087663L;
	
	/**
	 * 病人流水号
	 */
	private String patientFlow;
	/**
	 * 病人出生日期
	 */
	private String patientBirthday;
	/**
	 * 病人拼音缩写
	 */
	private String patientName;
	/**
	 * 病人性别
	 */
	private String sexId;
	/**
	 * 预后因素
	 */
	private String layerFactors;
	
	/**
	 * 纳入/排除流水号
	 */
	private String ieFlow;
	/**
	 * 纳入/排除值
	 */
	private String ieValue;
	/**
	 * 纳入/排除变量名
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
