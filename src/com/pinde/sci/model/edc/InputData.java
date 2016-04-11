package com.pinde.sci.model.edc;

import java.io.Serializable;


public class InputData implements Serializable{
	private String attrCode;
	private String value;
	public String getAttrCode() {
		return attrCode;
	}
	public void setAttrCode(String attrCode) {
		this.attrCode = attrCode;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
}
