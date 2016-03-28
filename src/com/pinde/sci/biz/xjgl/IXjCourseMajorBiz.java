package com.pinde.sci.biz.xjgl;

import java.util.List;

import com.pinde.sci.form.edu.MajorCourseForm;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;

public interface IXjCourseMajorBiz {
    
	/**
	 * ��ѯרҵ��������Ŀγ�
	 * @param courseMajor
	 * @return
	 */
	public List<MajorCourseForm> searchIncludeCourseMajor(EduCourseMajor courseMajor,EduCourse course);
	/**
	 * ����רҵ�γ̹�ϵ
	 * @param courseMajor
	 * @return
	 */
	public int save(EduCourseMajor courseMajor);
	/**
	 * ��ѯĳרҵ�²������Ŀγ�
	 * @param majorId
	 * @param year
	 * @return
	 */
	public List<EduCourse> searchCourseNotIncludeMajor(String majorId,String year);
	/**
	 * ����רҵ��ѯ�γ�
	 * @param majorId
	 * @param year
	 * @return
	 */
	public List<EduCourseMajorExt> searchCourseByMajor(String majorId,String year);
	/**
	 * ��ѯ�γ�רҵ��ϵ
	 * @param courseMajor
	 * @return
	 */
	public List<EduCourseMajor> searchCourseMajorListNoStatus(EduCourseMajor courseMajor);
	/**
	 * ɾ��
	 * @param courseMajor
	 * @return
	 */
	public int delete(EduCourseMajor courseMajor);
	/**
	 * ��ѯ�������õ�����
	 * @param currYear
	 * @return
	 */
	public List<String> searchRecommendYear(String year,String recommendFlag);
	/**
	 * ��ѯ��������������
	 * @param courseMajor
	 * @return
	 */
	public int saveRecommendData(EduCourseMajor courseMajor,String targetYear);
	/**
	 * ɾ����������
	 * @param courseMajor
	 * @return
	 */
	public int delRecommendData(EduCourseMajor courseMajor);
	
}
