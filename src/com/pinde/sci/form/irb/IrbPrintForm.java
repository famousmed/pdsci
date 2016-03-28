package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbPrintForm implements Serializable{
	
	private static final long serialVersionUID = -3422840127657356149L;
	
	private String irbFlow;
	private String recTypeId;
	private String watermarkFlag;
	private String userFlow;
	private String meetingFlow;
	private String recordFlow;
	private String year;
	private String irbInfoFlow;
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public String getRecTypeId() {
		return recTypeId;
	}
	public void setRecTypeId(String recTypeId) {
		this.recTypeId = recTypeId;
	}
	public String getWatermarkFlag() {
		return watermarkFlag;
	}
	public void setWatermarkFlag(String watermarkFlag) {
		this.watermarkFlag = watermarkFlag;
	}
	public String getUserFlow() {
		return userFlow;
	}
	public void setUserFlow(String userFlow) {
		this.userFlow = userFlow;
	}
	public String getMeetingFlow() {
		return meetingFlow;
	}
	public void setMeetingFlow(String meetingFlow) {
		this.meetingFlow = meetingFlow;
	}
	public String getRecordFlow() {
		return recordFlow;
	}
	public void setRecordFlow(String recordFlow) {
		this.recordFlow = recordFlow;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getIrbInfoFlow() {
		return irbInfoFlow;
	}
	public void setIrbInfoFlow(String irbInfoFlow) {
		this.irbInfoFlow = irbInfoFlow;
	}
}
	
