package com.pinde.sci.dao.exam;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamSubject;

public interface ExamBookExtMapper {
	
	public List<ExamBook> searchBookBySubject(String subjectFlow);
	
	public List<ExamBook> searchBookByQuestion(String questionFlow);

	public List<Map<String, Integer>> countQuestNumByQuestionTypeOfBook(String bookFlow);

	public List<ExamBook> searchBookByBook(String bookFlow);

	public List<Map<String, Integer>> countQuestNumByBookOfBook(String bookFlow);

	public List<Map<String, Integer>> countQuestNumBySubjectOfBook(String bookFlow);

	public List<ExamSubject> searchSubjectByBook(String bookFlow);

}
