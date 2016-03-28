package com.pinde.sci.biz.exam;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ExamBook;
import com.pinde.sci.model.mo.ExamSubject;

public interface IBookManageBiz {
	
	public List<ExamBook> search(ExamBook book);
	
	public int countQuestNumOfBook(String bookFlow);
	
	public void saveOrder(String [] bookFlows);
	
	public List<Map<String,Integer>> countQuestNumByQuestionTypeOfBook(String bookFlow);
	
	public List<ExamBook> searchBookByBook(String bookFlow);

	public List<Map<String, Integer>> countQuestNumByBookOfBook(String bookFlow);

	public List<Map<String, Integer>> countQuestNumBySubjectOfBook(String bookFlow);

	public List<ExamSubject> searchSubjectByBook(String bookFlow);

	public void unRel(String bookFlow);

	public ExamBook read(String bookFlow);

	public void add(ExamBook book, ExamBook bookParent);

	public void mod(ExamBook book);
	
	/**
	 * 修改书目的时候同时将子节点也修改,现在只修改书号
	 * @param book
	 */
	public void modBookAndSubBook(ExamBook book);

	public void del(String subjectFlow);

	public void merge(String[] bookFlows);

	public int countForTree(String bookFlow);

	/**
	 * 根据书目流水号递归查询顶层书
	 * @param bookFlow
	 * @return
	 */
	ExamBook findBookByBookFlow(String bookFlow);
	
	/**
	 * 删除书目和科目的关联 ， 同时删除该书目在这个科目的题目
	 * @param bookFlow
	 * @param subjectFlow
	 */
	void delBookAndSubjectRelation(String bookFlow , String subjectFlow);
	
	/**
	 * 书目绑定科目
	 * @param bookFlow
	 * @param subjectFlow
	 */
	void addBindSubject(String bookFlow , String subjectFlow);
	
	/**
	 * 重新绑定科目
	 * @param bookFlow
	 * @param subjectFlow
	 * @param oldSubjectFlow
	 */
	void rebindSubject(String bookFlow , String subjectFlow , String oldSubjectFlow);

	/**
	 * 查询一个节点下的所有子节点
	 * @param bookFlow
	 * @return
	 */
	List<ExamBook> findSubBookByBookFlow(String bookFlow);

	/**
	 * 一键排序
	 * 按照创建时间排序
	 * @param bookParentFlow
	 */
	void smartOrder(String bookParentFlow);

	List<ExamSubject> findSubjectByBookFlow(String bookFlow);


}
