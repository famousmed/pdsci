package com.pinde.sci.form.hbres;

import java.io.Serializable;

public class ResDoctorTrainingSpeForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5767464030553268603L;
	
	private String speId;
	private String doctorCount;
	
	public String getDoctorCount() {
		return doctorCount;
	}
	public void setDoctorCount(String doctorCount) {
		this.doctorCount = doctorCount;
	}
	public String getSpeId() {
		return speId;
	}
	public void setSpeId(String speId) {
		this.speId = speId;
	}
}
