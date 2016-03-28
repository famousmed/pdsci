package com.pinde.sci.biz.exam;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamQuestion;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;

public interface IQuestionManageBiz {
	
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectQuestionType(String subjectFlow,String questionTypeId);
	
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectSubject(String subjectFlow,String subjectFlow2);
	
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectBook(String subjectFlow,String bookFlow);
	
	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookQuestionType(String bookFlow,String questionTypeId);
	
	/**
	 * 根据书号和题目类型 查询该书目下该题型的所有题目和对应的子题
	 * @param bookFlow
	 * @param questionTypeId
	 * @return
	 */
	public List<ExamQuestionExt> searchExamQuestionAndSubQuestionByBookQuestionType(String bookFlow,String questionTypeId);
	
	/**
	 * 根据科目流水号和题目类型 查询该书目下该题型的所有题目和对应的子题
	 * @param bookFlow
	 * @param questionTypeId
	 * @return
	 */
	public List<ExamQuestionExt> searchExamQuestionAndSubQuestionBySubjectQuestionType(String subjectFlow,String questionTypeId);

	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookSubject(String bookFlow, String subjectFlow);

	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookBook(String bookFlow, String bookFlow2);

	public void del(String questionFlow);
	
	public ExamQuestionExt createQuestion(String typeId , ExamBookImp bookImp , Map<Integer , String> questionData);

	/**
	 * 替换掉题目选项的ABCE...更改为@@
	 * @param data
	 * @return
	 */
	String replaceQuestionStr(String data);

}
