package com.pinde.sci.form.irb;

import java.io.Serializable;
import java.util.List;

public class IrbVoteForm implements Serializable{
	
	private static final long serialVersionUID = -4620099810549596766L;
	
	/**
	 * ͶƱ�û���ˮ��
	 */
	private String userFlow;
	/**
	 * ǩ��
	 */
	private String userName;
	/**
	 * ������id
	 */
	private String decisionId;
	/**
	 * ����������
	 */
	private String decisionName;
	/**
	 * �����ͻ Y����
	 */
	private String conflict;
	/**
	 * ͶƱ����
	 */
	private String date;
	/**
	 * �������
	 */
	private String opinion;
	/**
	 * �������վ���
	 */
	private String mDecisionId;
	private String irbFlow;
	private List<IrbVoteForm> voteList;
	/**
	 * ������ˮ��
	 */
	private String meetingFlow;
	/**
	 * ��������
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
