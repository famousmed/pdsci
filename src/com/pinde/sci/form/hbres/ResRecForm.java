package com.pinde.sci.form.hbres;

import java.io.Serializable;

import com.pinde.sci.model.mo.ResRec;

public class ResRecForm extends ResRec implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2697698680458997809L;
	
	private String teachTypeId;
	private String teachAddress;
	private String teachDate;
	private String teachExplain;
	
	public String getTeachTypeId() {
		return teachTypeId;
	}
	public void setTeachTypeId(String teachTypeId) {
		this.teachTypeId = teachTypeId;
	}
	public String getTeachAddress() {
		return teachAddress;
	}
	public void setTeachAddress(String teachAddress) {
		this.teachAddress = teachAddress;
	}
	public String getTeachDate() {
		return teachDate;
	}
	public void setTeachDate(String teachDate) {
		this.teachDate = teachDate;
	}
	public String getTeachExplain() {
		return teachExplain;
	}
	public void setTeachExplain(String teachExplain) {
		this.teachExplain = teachExplain;
	}
}
