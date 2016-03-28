package com.pinde.sci.form.sch;

import java.io.Serializable;

public class DoctorSearchForm implements Serializable{
	
	private static final long serialVersionUID = -7689352547548165240L;
	
	private String doctorName;
	private String trainingSpeId;
	private String sessionNumber;
	private String graduatedId;
	private String sexId;
	private String rotationFlow;
	private String doctorCategoryId;
	
	public String getDoctorCategoryId() {
		return doctorCategoryId;
	}
	public void setDoctorCategoryId(String doctorCategoryId) {
		this.doctorCategoryId = doctorCategoryId;
	}
	public String getRotationFlow() {
		return rotationFlow;
	}
	public void setRotationFlow(String rotationFlow) {
		this.rotationFlow = rotationFlow;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getTrainingSpeId() {
		return trainingSpeId;
	}
	public void setTrainingSpeId(String trainingSpeId) {
		this.trainingSpeId = trainingSpeId;
	}
	public String getSessionNumber() {
		return sessionNumber;
	}
	public void setSessionNumber(String sessionNumber) {
		this.sessionNumber = sessionNumber;
	}
	public String getGraduatedId() {
		return graduatedId;
	}
	public void setGraduatedId(String graduatedId) {
		this.graduatedId = graduatedId;
	}
	public String getSexId() {
		return sexId;
	}
	public void setSexId(String sexId) {
		this.sexId = sexId;
	}
}
