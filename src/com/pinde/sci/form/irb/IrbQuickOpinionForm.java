package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbQuickOpinionForm implements Serializable{
	
	private static final long serialVersionUID = -7761857608439239197L;
	
	String irbFlow;
	String reviewWayId;
	String irbDecisionId;
	String irbDecisionName;
	String reviewOpinion;
	String operTime;
	String operUserFlow;
	String operUserName;
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public String getReviewWayId() {
		return reviewWayId;
	}
	public void setReviewWayId(String reviewWayId) {
		this.reviewWayId = reviewWayId;
	}
	public String getIrbDecisionId() {
		return irbDecisionId;
	}
	public void setIrbDecisionId(String irbDecisionId) {
		this.irbDecisionId = irbDecisionId;
	}
	public String getReviewOpinion() {
		return reviewOpinion;
	}
	public void setReviewOpinion(String reviewOpinion) {
		this.reviewOpinion = reviewOpinion;
	}
	public String getOperTime() {
		return operTime;
	}
	public void setOperTime(String operTime) {
		this.operTime = operTime;
	}
	public String getOperUserFlow() {
		return operUserFlow;
	}
	public void setOperUserFlow(String operUserFlow) {
		this.operUserFlow = operUserFlow;
	}
	public String getOperUserName() {
		return operUserName;
	}
	public void setOperUserName(String operUserName) {
		this.operUserName = operUserName;
	}
	public String getIrbDecisionName() {
		return irbDecisionName;
	}
	public void setIrbDecisionName(String irbDecisionName) {
		this.irbDecisionName = irbDecisionName;
	}
	
}
