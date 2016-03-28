package com.pinde.sci.biz.xjgl;

import java.util.List;

import com.pinde.sci.form.edu.MajorCourseForm;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;

public interface IXjCourseMajorBiz {
    
	/**
	 * 查询专业及其包含的课程
	 * @param courseMajor
	 * @return
	 */
	public List<MajorCourseForm> searchIncludeCourseMajor(EduCourseMajor courseMajor,EduCourse course);
	/**
	 * 保存专业课程关系
	 * @param courseMajor
	 * @return
	 */
	public int save(EduCourseMajor courseMajor);
	/**
	 * 查询某专业下不包含的课程
	 * @param majorId
	 * @param year
	 * @return
	 */
	public List<EduCourse> searchCourseNotIncludeMajor(String majorId,String year);
	/**
	 * 根据专业查询课程
	 * @param majorId
	 * @param year
	 * @return
	 */
	public List<EduCourseMajorExt> searchCourseByMajor(String majorId,String year);
	/**
	 * 查询课程专业关系
	 * @param courseMajor
	 * @return
	 */
	public List<EduCourseMajor> searchCourseMajorListNoStatus(EduCourseMajor courseMajor);
	/**
	 * 删除
	 * @param courseMajor
	 * @return
	 */
	public int delete(EduCourseMajor courseMajor);
	/**
	 * 查询可以引用的年限
	 * @param currYear
	 * @return
	 */
	public List<String> searchRecommendYear(String year,String recommendFlag);
	/**
	 * 查询并保存引用数据
	 * @param courseMajor
	 * @return
	 */
	public int saveRecommendData(EduCourseMajor courseMajor,String targetYear);
	/**
	 * 删除引用数据
	 * @param courseMajor
	 * @return
	 */
	public int delRecommendData(EduCourseMajor courseMajor);
	
}
