package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduCourseTestPaperExt;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.mo.TestResult;

public interface IEduCourseTestPaperBiz {
	
	/**
	 * 查询课程考试关联关系(recordStatus为Y)
	 * @param eduCourseTestPaper
	 * @return
	 */
    public List<EduCourseTestPaper> searchCourseTestPaperList(EduCourseTestPaper eduCourseTestPaper);
    /**
     * 保存课程程是关联关系原子方法
     * @param eduCourseTestPaper
     * @return
     */
    public int save(EduCourseTestPaper eduCourseTestPaper);
    /**
     * 增加或删除课程考试关联记录
     * @param recordFlow
     * @param courseFlow
     * @param testPaper
     * @return
     */
    public int addAndDeleteCourseTestPaper(String courseFlow,String chapterFlow,String paperFlow,String type);
    /**
     * 查询一条课程考试关联记录的详细信息
     * @param recordFlow
     * @return
     */
    public EduCourseTestPaper readEduCourseTestPaper(String recordFlow);
    
    /**
     *  查询课程考试关联关系
     * @param eduCourseTestPaper
     * @return
     */
	public List<EduCourseTestPaper> searchCourseTestPaperListNotRecordStatus(
			EduCourseTestPaper eduCourseTestPaper);
	/**
	 * 查询某课程的试卷
	 * @param courseFlow
	 * @return
	 */
	public List<EduCourseTestPaperExt> searchCourseTestPaperExt(String courseFlow);
	
	/**
	 * 验证试卷是否绑定
	 * @param courseFlow
	 * @return
	 */
	int testProvingMany(String courseFlow,String chapterFlow);
	
	
}
