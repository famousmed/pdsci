package com.pinde.sci.form.gcp;

import java.util.List;

public class GcpMeetingForm {
	private String projFlow;
	private String projStageId;
	private String saveType;
	/*会议信息*/
	private String date;
	private String address;
	private String compere;
	private String user;
	private String intro;
	/*启动通知*/
	private String period;
	private String scope;
	private String goSign;
	private String noticeDate;
	private String researchCount;
	/*会议文件*/
	List<GcpMeetingFileForm> files;
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCompere() {
		return compere;
	}
	public void setCompere(String compere) {
		this.compere = compere;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public String getProjFlow() {
		return projFlow;
	}
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}
	public String getProjStageId() {
		return projStageId;
	}
	public void setProjStageId(String projStageId) {
		this.projStageId = projStageId;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getScope() {
		return scope;
	}
	public void setScope(String scope) {
		this.scope = scope;
	}
	public String getGoSign() {
		return goSign;
	}
	public void setGoSign(String goSign) {
		this.goSign = goSign;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	public String getResearchCount() {
		return researchCount;
	}
	public void setResearchCount(String researchCount) {
		this.researchCount = researchCount;
	}
	public String getSaveType() {
		return saveType;
	}
	public void setSaveType(String saveType) {
		this.saveType = saveType;
	}
	public List<GcpMeetingFileForm> getFiles() {
		return files;
	}
	public void setFiles(List<GcpMeetingFileForm> files) {
		this.files = files;
	}
	
}
