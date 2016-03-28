package com.pinde.sci.form.irb;

import java.io.Serializable;
import java.util.List;

public class IrbDecisionDetailForm implements Serializable{
	
	private static final long serialVersionUID = -1618171570714371083L;
	
	private String irbFlow;
	private String opinion;
	private String approveValidity;
	private String contact;
	private String chairman;
	private String irbInfo;
	private String trackFrequency;
	private String trackDate;
	private String irbDecisionDate;
	private String irbRecTypeId;
	private String recFlow;
	private List<IrbApplyFileForm> applyFileForms;
	
	
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}

	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getChairman() {
		return chairman;
	}
	public void setChairman(String chairman) {
		this.chairman = chairman;
	}
	public String getIrbInfo() {
		return irbInfo;
	}
	public void setIrbInfo(String irbInfo) {
		this.irbInfo = irbInfo;
	}
	
	public String getApproveValidity() {
		return approveValidity;
	}
	public void setApproveValidity(String approveValidity) {
		this.approveValidity = approveValidity;
	}
	
	public String getIrbDecisionDate() {
		return irbDecisionDate;
	}
	public void setIrbDecisionDate(String irbDecisionDate) {
		this.irbDecisionDate = irbDecisionDate;
	}
	public String getIrbRecTypeId() {
		return irbRecTypeId;
	}
	public void setIrbRecTypeId(String irbRecTypeId) {
		this.irbRecTypeId = irbRecTypeId;
	}
	public String getRecFlow() {
		return recFlow;
	}
	public void setRecFlow(String recFlow) {
		this.recFlow = recFlow;
	}
	public String getTrackFrequency() {
		return trackFrequency;
	}
	public void setTrackFrequency(String trackFrequency) {
		this.trackFrequency = trackFrequency;
	}
	public String getTrackDate() {
		return trackDate;
	}
	public void setTrackDate(String trackDate) {
		this.trackDate = trackDate;
	}
	public List<IrbApplyFileForm> getApplyFileForms() {
		return applyFileForms;
	}
	public void setApplyFileForms(List<IrbApplyFileForm> applyFileForms) {
		this.applyFileForms = applyFileForms;
	}
	
}
