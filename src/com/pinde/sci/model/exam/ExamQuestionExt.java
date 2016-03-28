package com.pinde.sci.model.exam;

import java.util.List;

import com.pinde.sci.model.mo.ExamQuestionDetailWithBLOBs;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;

public class ExamQuestionExt extends ExamQuestionWithBLOBs{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<ExamQuestionDetailWithBLOBs> questionDetails;
	public List<ExamQuestionDetailWithBLOBs> getQuestionDetails() {
		return questionDetails;
	}
	public void setQuestionDetails(List<ExamQuestionDetailWithBLOBs> questionDetails) {
		this.questionDetails = questionDetails;
	}

}
