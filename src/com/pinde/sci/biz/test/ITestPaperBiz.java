package com.pinde.sci.biz.test;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.TestPaper;

public interface ITestPaperBiz {
	
	/**
	 * 查询试卷列表
	 * @param testPaper
	 * @return
	 */
	public List<TestPaper> searchTestPaperList(TestPaper testPaper);
    /**
     * 获取一份试卷的详细信息
     * @param paperFlow
     * @return
     */
	public TestPaper readTestPaper(String paperFlow);
	/**
	 * 查询试卷列表
	 * @param paramMap
	 * @return
	 */
	List<TestPaper> searchTestPaperList(String courseFlow,String chapterFlow,String userFlow);
	


}
