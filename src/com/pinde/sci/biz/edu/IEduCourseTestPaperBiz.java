package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduCourseTestPaperExt;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.mo.TestResult;

public interface IEduCourseTestPaperBiz {
	
	/**
	 * ��ѯ�γ̿��Թ�����ϵ(recordStatusΪY)
	 * @param eduCourseTestPaper
	 * @return
	 */
    public List<EduCourseTestPaper> searchCourseTestPaperList(EduCourseTestPaper eduCourseTestPaper);
    /**
     * ����γ̳��ǹ�����ϵԭ�ӷ���
     * @param eduCourseTestPaper
     * @return
     */
    public int save(EduCourseTestPaper eduCourseTestPaper);
    /**
     * ���ӻ�ɾ���γ̿��Թ�����¼
     * @param recordFlow
     * @param courseFlow
     * @param testPaper
     * @return
     */
    public int addAndDeleteCourseTestPaper(String courseFlow,String chapterFlow,String paperFlow,String type);
    /**
     * ��ѯһ���γ̿��Թ�����¼����ϸ��Ϣ
     * @param recordFlow
     * @return
     */
    public EduCourseTestPaper readEduCourseTestPaper(String recordFlow);
    
    /**
     *  ��ѯ�γ̿��Թ�����ϵ
     * @param eduCourseTestPaper
     * @return
     */
	public List<EduCourseTestPaper> searchCourseTestPaperListNotRecordStatus(
			EduCourseTestPaper eduCourseTestPaper);
	/**
	 * ��ѯĳ�γ̵��Ծ�
	 * @param courseFlow
	 * @return
	 */
	public List<EduCourseTestPaperExt> searchCourseTestPaperExt(String courseFlow);
	
	/**
	 * ��֤�Ծ��Ƿ��
	 * @param courseFlow
	 * @return
	 */
	int testProvingMany(String courseFlow,String chapterFlow);
	
	
}
