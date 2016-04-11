package com.pinde.sci.biz.test;

import java.util.List;

import com.pinde.sci.form.test.TestResultForm;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.test.TestResultExt;

public interface ITestResultBiz {

	/**
	 * ��ѯ���Խ��
	 * @param testResult
	 * @return
	 */
	public List<TestResult> searchTestResultList(TestResult testResult);

	/**
	 * ���ݿ��Լ�¼��ѯ�Ծ���Ϣ
	 * @param testResult
	 * @return
	 */
	List<TestResultExt> reasonTestreRultChaTestPaper(String courseFlow,String userFlow,TestResultForm testResult);
	/**
	 * ����userFlow��ѯ���Գɼ���Ϣ
	 * @param userFlow
	 * @return
	 */
	List<TestResult> searchResultByUserFlow(String userFlow);
	/**
	 * �༭���Գɼ�
	 * @param result
	 * @return
	 */
	int edit(TestResult result);

	/**
	 * ����
	 * @param testResult
	 * @return
	 */
	int saveTestResultList(List<TestResult> testResult);
	
	/**
	 * 
	 * @param userFlow
	 * @param result
	 * @return
	 */
	List<TestResult> searchResult(String userFlow,TestResult result);
	/**
	 * ��ѯѧ������ͨ���ļ�¼
	 * @param userFlow
	 * @param chapterFlow
	 * @return
	 */
	List<TestResult> searchPassResult(String userFlow,String chapterFlow);
	
}
