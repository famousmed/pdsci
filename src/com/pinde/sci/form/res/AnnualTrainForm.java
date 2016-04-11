package com.pinde.sci.form.res;

import java.io.Serializable;

public class AnnualTrainForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2420819931570058734L;

	private String schDeptName;
	private String studyType;
	private String trainContent;
	private String trainDate;
	private String academicScore;
	private String classHourScore;
	private String remarks;
	
	public String getSchDeptName() {
		return schDeptName;
	}
	public void setSchDeptName(String schDeptName) {
		this.schDeptName = schDeptName;
	}
	public String getStudyType() {
		return studyType;
	}
	public void setStudyType(String studyType) {
		this.studyType = studyType;
	}
	public String getTrainContent() {
		return trainContent;
	}
	public void setTrainContent(String trainContent) {
		this.trainContent = trainContent;
	}
	public String getTrainDate() {
		return trainDate;
	}
	public void setTrainDate(String trainDate) {
		this.trainDate = trainDate;
	}
	public String getAcademicScore() {
		return academicScore;
	}
	public void setAcademicScore(String academicScore) {
		this.academicScore = academicScore;
	}
	public String getClassHourScore() {
		return classHourScore;
	}
	public void setClassHourScore(String classHourScore) {
		this.classHourScore = classHourScore;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
