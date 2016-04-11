package com.pinde.sci.form.pub;

import java.io.Serializable;

public class AcademicResumeForm implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1466581256488474029L;
	private String startDate;
	private String academicName;
	private String title;
	
	private String recordId;

	
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getAcademicName() {
		return academicName;
	}

	public void setAcademicName(String academicName) {
		this.academicName = academicName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRecordId() {
		return recordId;
	}

	public void setRecordId(String recordId) {
		this.recordId = recordId;
	}

	

	
	
}
