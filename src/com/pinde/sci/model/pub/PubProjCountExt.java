package com.pinde.sci.model.pub;

import java.io.Serializable;

public class PubProjCountExt implements Serializable{
   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1677428827063895911L;

	private String orgFlow;
	
	private String orgName;
	
	private String projCount;

	public String getOrgFlow() {
		return orgFlow;
	}

	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getProjCount() {
		return projCount;
	}

	public void setProjCount(String projCount) {
		this.projCount = projCount;
	}

	


	
	
}
