package com.pinde.sci.model.edc;

import java.io.Serializable;

public class RandomDrugGroupForm implements Serializable{
	
	private static final long serialVersionUID = 3319018505103453930L;
	
	private String drugGroup;

	public String getDrugGroup() {
		return drugGroup;
	}

	public void setDrugGroup(String drugGroup) {
		this.drugGroup = drugGroup;
	}
}
