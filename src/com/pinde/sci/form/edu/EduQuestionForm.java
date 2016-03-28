package com.pinde.sci.form.edu;

import com.pinde.sci.model.mo.EduQuestion;

public class EduQuestionForm {
	private EduQuestion question;
	private String courseName;
	public EduQuestion getQuestion() {
		return question;
	}
	public void setQuestion(EduQuestion question) {
		this.question = question;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	
}
