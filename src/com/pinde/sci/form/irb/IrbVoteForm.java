package com.pinde.sci.form.irb;

import java.io.Serializable;
import java.util.List;

public class IrbVoteForm implements Serializable{
	
	private static final long serialVersionUID = -4620099810549596766L;
	
	/**
	 * 投票用户流水号
	 */
	private String userFlow;
	/**
	 * 签名
	 */
	private String userName;
	/**
	 * 审查决定id
	 */
	private String decisionId;
	/**
	 * 审查决定名称
	 */
	private String decisionName;
	/**
	 * 利益冲突 Y：是
	 */
	private String conflict;
	/**
	 * 投票日期
	 */
	private String date;
	/**
	 * 具体意见
	 */
	private String opinion;
	/**
	 * 会议最终决定
	 */
	private String mDecisionId;
	private String irbFlow;
	private List<IrbVoteForm> voteList;
	/**
	 * 会议流水号
	 */
	private String meetingFlow;
	/**
	 * 操作类型
	 */
	private String operType;
	public String getUserFlow() {
		return userFlow;
	}
	public void setUserFlow(String userFlow) {
		this.userFlow = userFlow;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDecisionId() {
		return decisionId;
	}
	public void setDecisionId(String decisionId) {
		this.decisionId = decisionId;
	}
	public String getConflict() {
		return conflict;
	}
	public void setConflict(String conflict) {
		this.conflict = conflict;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
	}
	public String getmDecisionId() {
		return mDecisionId;
	}
	public void setmDecisionId(String mDecisionId) {
		this.mDecisionId = mDecisionId;
	}
	public String getDecisionName() {
		return decisionName;
	}
	public void setDecisionName(String decisionName) {
		this.decisionName = decisionName;
	}
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public List<IrbVoteForm> getVoteList() {
		return voteList;
	}
	public void setVoteList(List<IrbVoteForm> voteList) {
		this.voteList = voteList;
	}
	public String getMeetingFlow() {
		return meetingFlow;
	}
	public void setMeetingFlow(String meetingFlow) {
		this.meetingFlow = meetingFlow;
	}
	public String getOperType() {
		return operType;
	}
	public void setOperType(String operType) {
		this.operType = operType;
	}
	
}
