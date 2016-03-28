package com.pinde.sci.model.srm;

import java.io.Serializable;

public class PubStatementExt implements Serializable{
     
	/**
	 * 
	 */
	private static final long serialVersionUID = -2554106887305747816L;

	private String orgFlow;
	
	private String orgName;
	
	private String projTypeId;
	
	private String projTypeName;
	
	private int allProjCount;
	
	private int noSubmitProjCount;
	
	private int submitProjCount;
	
	private int approvingProjCount;
	
	private int approveProjCount;

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


	public String getProjTypeId() {
		return projTypeId;
	}

	public void setProjTypeId(String projTypeId) {
		this.projTypeId = projTypeId;
	}

	public String getProjTypeName() {
		return projTypeName;
	}

	public void setProjTypeName(String projTypeName) {
		this.projTypeName = projTypeName;
	}

	public int getAllProjCount() {
		return allProjCount;
	}

	public void setAllProjCount(int allProjCount) {
		this.allProjCount = allProjCount;
	}

	public int getNoSubmitProjCount() {
		return noSubmitProjCount;
	}

	public void setNoSubmitProjCount(int noSubmitProjCount) {
		this.noSubmitProjCount = noSubmitProjCount;
	}

	public int getSubmitProjCount() {
		return submitProjCount;
	}

	public void setSubmitProjCount(int submitProjCount) {
		this.submitProjCount = submitProjCount;
	}

	public int getApprovingProjCount() {
		return approvingProjCount;
	}

	public void setApprovingProjCount(int approvingProjCount) {
		this.approvingProjCount = approvingProjCount;
	}

	public int getApproveProjCount() {
		return approveProjCount;
	}

	public void setApproveProjCount(int approveProjCount) {
		this.approveProjCount = approveProjCount;
	}

	
	
}
