package com.pinde.sci.model.exam;

import java.util.List;

import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamBookImpDetail;

public class ExamBookImpExt extends ExamBookImp{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private List<ExamBookImpDetail> examBookImpDetails;

	private ExamBook examBook;

	public List<ExamBookImpDetail> getExamBookImpDetails() {
		return examBookImpDetails;
	}

	public void setExamBookImpDetails(List<ExamBookImpDetail> examBookImpDetails) {
		this.examBookImpDetails = examBookImpDetails;
	}

	public ExamBook getExamBook() {
		return examBook;
	}

	public void setExamBook(ExamBook examBook) {
		this.examBook = examBook;
	}
	
	
	
	
	

}
