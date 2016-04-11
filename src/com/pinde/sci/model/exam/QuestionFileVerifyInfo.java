package com.pinde.sci.model.exam;

import java.io.Serializable;

public class QuestionFileVerifyInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private boolean passFlag;
	
	private Integer questionNo;
	
	private Integer lineNum;
	
	private String questionTypeId;
	
	private String msg = "格式不正确";//默认显示信息

	public boolean isPassFlag() {
		return passFlag;
	}

	public void setPassFlag(boolean passFlag) {
		this.passFlag = passFlag;
	}

	public Integer getQuestionNo() {
		return questionNo;
	}

	public void setQuestionNo(Integer questionNo) {
		this.questionNo = questionNo;
	}

	public Integer getLineNum() {
		return lineNum;
	}

	public void setLineNum(Integer lineNum) {
		this.lineNum = lineNum;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getQuestionTypeId() {
		return questionTypeId;
	}

	public void setQuestionTypeId(String questionTypeId) {
		this.questionTypeId = questionTypeId;
	}
	
	
	
}
