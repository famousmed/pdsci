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
	 * �޸���Ŀ��ʱ��ͬʱ���ӽڵ�Ҳ�޸�,����ֻ�޸����
	 * @param book
	 */
	public void modBookAndSubBook(ExamBook book);

	public void del(String subjectFlow);

	public void merge(String[] bookFlows);

	public int countForTree(String bookFlow);

	/**
	 * ������Ŀ��ˮ�ŵݹ��ѯ������
	 * @param bookFlow
	 * @return
	 */
	ExamBook findBookByBookFlow(String bookFlow);
	
	/**
	 * ɾ����Ŀ�Ϳ�Ŀ�Ĺ��� �� ͬʱɾ������Ŀ�������Ŀ����Ŀ
	 * @param bookFlow
	 * @param subjectFlow
	 */
	void delBookAndSubjectRelation(String bookFlow , String subjectFlow);
	
	/**
	 * ��Ŀ�󶨿�Ŀ
	 * @param bookFlow
	 * @param subjectFlow
	 */
	void addBindSubject(String bookFlow , String subjectFlow);
	
	/**
	 * ���°󶨿�Ŀ
	 * @param bookFlow
	 * @param subjectFlow
	 * @param oldSubjectFlow
	 */
	void rebindSubject(String bookFlow , String subjectFlow , String oldSubjectFlow);

	/**
	 * ��ѯһ���ڵ��µ������ӽڵ�
	 * @param bookFlow
	 * @return
	 */
	List<ExamBook> findSubBookByBookFlow(String bookFlow);

	/**
	 * һ������
	 * ���մ���ʱ������
	 * @param bookParentFlow
	 */
	void smartOrder(String bookParentFlow);

	List<ExamSubject> findSubjectByBookFlow(String bookFlow);


}
