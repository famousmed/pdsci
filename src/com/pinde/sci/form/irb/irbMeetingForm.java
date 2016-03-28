package com.pinde.sci.form.irb;

import java.io.Serializable;

import com.pinde.sci.model.mo.IrbMeeting;

public class irbMeetingForm implements Serializable{
	
	private static final long serialVersionUID = -8872395468550539806L;
	
	private IrbMeeting meeting;
	/**
	 * 会议报告项目数
	 */
	private int fastCount;
	/**
	 * 会议审查项目数
	 */
	private int meetingCount;
	private String meetingEndDate;
	private String userFlow;
	public IrbMeeting getMeeting() {
		return meeting;
	}
	public void setMeeting(IrbMeeting meeting) {
		this.meeting = meeting;
	}
	public int getFastCount() {
		return fastCount;
	}
	public void setFastCount(int fastCount) {
		this.fastCount = fastCount;
	}
	public int getMeetingCount() {
		return meetingCount;
	}
	public void setMeetingCount(int meetingCount) {
		this.meetingCount = meetingCount;
	}
	public String getMeetingEndDate() {
		return meetingEndDate;
	}
	public void setMeetingEndDate(String meetingEndDate) {
		this.meetingEndDate = meetingEndDate;
	}
	public String getUserFlow() {
		return userFlow;
	}
	public void setUserFlow(String userFlow) {
		this.userFlow = userFlow;
	}
	
}
