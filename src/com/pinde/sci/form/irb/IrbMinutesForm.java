package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbMinutesForm implements Serializable{
	
	private static final long serialVersionUID = 1426645053919708814L;
	
	/**
	 * ���鱨��Ļ����¼
	 */
	private String reportMinutes;
	/**
	 * ίԱ���ʺʹ���
	 */
	private String question;
	/**
	 * ����
	 */
	private String discussion;
	/**
	 * �������
	 */
	private String title;
	

	public String getReportMinutes() {
		return reportMinutes;
	}

	public void setReportMinutes(String reportMinutes) {
		this.reportMinutes = reportMinutes;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getDiscussion() {
		return discussion;
	}

	public void setDiscussion(String discussion) {
		this.discussion = discussion;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
