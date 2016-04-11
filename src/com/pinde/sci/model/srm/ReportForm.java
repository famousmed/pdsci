package com.pinde.sci.model.srm;

import java.io.Serializable;

public class ReportForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String orgFlow;
	
	private String orgName;
	
	private Integer projCount;
	
	private Integer applyCount;
	
	private Integer evalCount;
	
	private Integer approveCount;
	
	private Integer notApproveCount;
	
	private Float approveScale;
	
	
	

	public Float getApproveScale() {
		return approveScale;
	}

	public void setApproveScale(Float approveScale) {
		this.approveScale = approveScale;
	}

	public Integer getApplyCount() {
		return applyCount;
	}

	public void setApplyCount(Integer applyCount) {
		this.applyCount = applyCount;
	}

	public Integer getEvalCount() {
		return evalCount;
	}

	public void setEvalCount(Integer evalCount) {
		this.evalCount = evalCount;
	}

	public Integer getApproveCount() {
		return approveCount;
	}

	public void setApproveCount(Integer approveCount) {
		this.approveCount = approveCount;
	}

	public Integer getNotApproveCount() {
		return notApproveCount;
	}

	public void setNotApproveCount(Integer notApproveCount) {
		this.notApproveCount = notApproveCount;
	}

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

	public Integer getProjCount() {
		return projCount;
	}

	public void setProjCount(Integer projCount) {
		this.projCount = projCount;
	}
	
	

}
