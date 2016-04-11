package com.pinde.sci.biz.exam;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamQuestion;
import com.pinde.sci.model.mo.ExamSubject;

public interface ISubjectManageBiz {
	
	public List<ExamSubject> search(ExamSubject subject);
	
	public int countQuestNumOfSubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumByQuestionTypeOfSubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumBySubjectOfSubject(String subjectFlow);
	
	public List<Map<String,Integer>> countQuestNumByBookOfSubject(String subjectFlow);
	
	public void saveOrder(String [] subjectFlows);
	
	public List<ExamBook> searchBookBySubject(String subjectFlow);
	
	public List<ExamBook> searchBookByQuestion(String questionFlow);

	public List<ExamSubject> searchSubjectByQuestion(String questionFlow);
	
	public List<ExamSubject> searchSubjectBySubject(String subjectFlow);

	public void delQuestionSubject(String subjectFlow, String questionFlow);

	public void unRel(String subjectFlow);

	public ExamSubject read(String subjectFlow);
	
	public void add(ExamSubject subject,ExamSubject subjectParent);

	public void mod(ExamSubject subject);

	public void del(String subjectFlow);

	public void merge(String[] subjectFlows);

	public int countForTree(String subjectFlow);

	public void copy(String examBankType,String targetSubjectFlow, String sourceSubjectFlow);

	public void extract(String examBankType, String targetSubjectFlow,String sourceSubjectFlow);
	
	/**
	 * 科目编号在题库类型中的数量 (是否唯一)
	 * @param subjectCode
	 * @param bankTypeId
	 * @return
	 */
	public int countSubjectCodeInBankType(String subjectFlow , String subjectCode , String bankTypeId);

}
