package com.pinde.sci.biz.edu;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.CourseInfoForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduCourseScheduleExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.SysOrg;

public interface IEduCourseScheduleBiz {
	/**
	 * �������޸�
	 * @param schedule
	 * @return
	 */
	int edit(EduCourseSchedule schedule);
	/**
	 * �����½�ƽ������
	 * @param schedule
	 * @return
	 */
	BigDecimal searchAvgScore(EduCourseSchedule schedule);
	/**
	 * ��������
	 * @param schedule
	 */
	int saveChapterScore(EduCourseSchedule schedule);
	/**
	 * ��ѯ
	 * @param schedule
	 * @return
	 */
	EduCourseSchedule searchOne(EduCourseSchedule schedule);
	/**
	 * ������
	 * @param schedule
	 */
	void savePraise(EduCourseSchedule schedule);
	
	/**
	 * ��ѯ��������
	 * @param eduCourseSchedule
	 * @return
	 */
	List<EduCourseSchedule> searchEvaluateList(EduCourseSchedule eduCourseSchedule);
	/**
	 * ��������ѯ
	 * @param recordFlow
	 * @return
	 */
	EduCourseSchedule seachOne(String recordFlow);
	/**
	 * ��ѯĳ�ڿ�(����ȫ��)������ѧ����ѧϰ����
	 * @param eduUserExtList
	 * @param courseFlow
	 * @return
	 */
	Map<String,Map<String,Object>> searchUserScheduleMap(List<EduUserExt> eduUserExtList,String courseFlow);
	/**
	 * ����������ѯ�ڿ���ϸ��Ϣ
	 * @param eduUserExtList
	 * @return
	 */
	Map<String,Map<String,Object>> countInfoOfTeacher(List<EduUserExt> eduUserExtList);
	
	
	List<EduCourseScheduleExt> searchChapterScheduleMap(Map<String, Object> paramMap);
	Map<String, Map<String, Object>> searchChapterScheduleMap(String courseFlow, String condition);
	
	/**
	 * ��ѯ�ý�ʦ���ڿγ̵�����ѧУ
	 * @param oparamMap
	 * @return
	 */
	List<SysOrgExt> selectOrgOfSchedule(Map<String, Object> oparamMap);
	/**
	 * ��ѯѧУ������
	 * @param paramMap
	 * @return
	 */
	CourseInfoForm countInfoOfTeacher(Map<String, Object> paramMap);
	
	List<EduCourseScheduleExt> searchCourseSchedule(Map<String, Object> paramMap);
	/**
	 * ��ѯѧ����ѧϰ��¼
	 * @param eduUserExtList
	 * @return
	 */
	Map<String,Map<String,Map<String,Object>>> searchStuSchedule(List<EduUserExt> eduUserExtList);
	/**
	 * ��ѯÿ��ѧУ�Ŀγ�������
	 * @param orgList
	 * @return
	 */
    Map<String,Map<String,Object>> searchCourseFinishInfoByOrg(List<SysOrg> orgList,List<EduCourse> courseList);
	
	List<EduCourseSchedule> searchEduCourseScheduleList(EduCourseSchedule schedule);
	
	/**
	 * ��ѯ
	 * @param paramMap
	 * @return
	 */
	List<EduCourseSchedule> searchEduCourseScheduleList(Map<String, Object> paramMap);
	/**
	 * ��ѯ��һ�½���ˮ��
	 * @param chapterFlow
	 * @param courseFlow
	 * @return
	 */
	String nextChapter(String chapterFlow, String courseFlow);
	/**
	 * ����Ƶ������ɺ��޸�ѧϰ��¼�����жϿ����Ƿ񼰸�
	 * @param userFlow
	 * @param chapterFlow
	 * @return
	 */
	int modifyScheduleForFinishVideo(String userFlow,String chapterFlow);
}
