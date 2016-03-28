package com.pinde.sci.biz.test;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.TestPaper;

public interface ITestPaperBiz {
	
	/**
	 * ��ѯ�Ծ��б�
	 * @param testPaper
	 * @return
	 */
	public List<TestPaper> searchTestPaperList(TestPaper testPaper);
    /**
     * ��ȡһ���Ծ����ϸ��Ϣ
     * @param paperFlow
     * @return
     */
	public TestPaper readTestPaper(String paperFlow);
	/**
	 * ��ѯ�Ծ��б�
	 * @param paramMap
	 * @return
	 */
	List<TestPaper> searchTestPaperList(String courseFlow,String chapterFlow,String userFlow);
	


}
