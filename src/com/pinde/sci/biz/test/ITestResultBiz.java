package com.pinde.sci.biz.test;

import java.util.List;

import com.pinde.sci.form.test.TestResultForm;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.test.TestResultExt;

public interface ITestResultBiz {

	/**
	 * 查询考试结果
	 * @param testResult
	 * @return
	 */
	public List<TestResult> searchTestResultList(TestResult testResult);

	/**
	 * 根据考试记录查询试卷信息
	 * @param testResult
	 * @return
	 */
	List<TestResultExt> reasonTestreRultChaTestPaper(String courseFlow,String userFlow,TestResultForm testResult);
	/**
	 * 根据userFlow查询考试成绩信息
	 * @param userFlow
	 * @return
	 */
	List<TestResult> searchResultByUserFlow(String userFlow);
	/**
	 * 编辑考试成绩
	 * @param result
	 * @return
	 */
	int edit(TestResult result);

	/**
	 * 保存
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
	 * 查询学生考试通过的记录
	 * @param userFlow
	 * @param chapterFlow
	 * @return
	 */
	List<TestResult> searchPassResult(String userFlow,String chapterFlow);
	
}
