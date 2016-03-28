package com.pinde.sci.model.gcp;

import com.pinde.sci.model.mo.GcpDrug;

public class GcpDrugExt extends GcpDrug{
	
	private static final long serialVersionUID = 1619563966833429702L;
	private String projName;


	public String getProjName() {
		return projName;
	}

	public void setProjName(String projName) {
		this.projName = projName;
	}
	
}
