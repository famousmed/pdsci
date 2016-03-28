package com.pinde.sci.model.gcp;

import com.pinde.sci.model.mo.GcpDrugIn;

public class GcpDrugInExt extends GcpDrugIn{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8531116172068731863L;

	private String drugName;
	
	private String spec;
	
	private String inOperatorName;

    

	public String getDrugName() {
		return drugName;
	}

	public void setDrugName(String drugName) {
		this.drugName = drugName;
	}

	public String getSpec() {
		return spec;
	}

	public void setSpec(String spec) {
		this.spec = spec;
	}

	public String getInOperatorName() {
		return inOperatorName;
	}

	public void setInOperatorName(String inOperatorName) {
		this.inOperatorName = inOperatorName;
	}
	
	
}
