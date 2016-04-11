package com.pinde.sci.dao.exam;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ExamSubject;

public interface ExamSubjectExtMapper {
	
	public List<ExamSubject> searchSubjectByQuestion(String questionFlow);
	
	public List<ExamSubject> searchSubjectBySubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumByQuestionTypeOfSubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumBySubjectOfSubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumByBookOfSubject(String subjectFlow);

}
