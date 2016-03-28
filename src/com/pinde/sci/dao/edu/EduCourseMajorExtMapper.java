package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.MajorCourseForm;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;

public interface EduCourseMajorExtMapper {
	
	public List<MajorCourseForm> searchIncludeCourseMajor(Map<String,Object> paramMap);

	public List<EduCourse> selectCourseNotIncludeMajor(Map<String,Object> paramMap);

	public List<EduCourseMajorExt> selectCourseByMajor(Map<String,Object> paramMap);

	/**
	 * 查询可以引用数据的年份
	 * @param paramMap
	 * @return
	 */
	List<String> searchRecommendYear(Map<String, String> paramMap);

	/**
	 * 查询该年度该专业所设全部课程
	 * @param period
	 * @param planYear
	 * @return
	 */
	List<EduCourseMajorExt> searchCourseMajorExtList(EduCourseMajorExt courseMajorExt);
	
	
	/**
	 * 查询该年度该专业  补选课程
	 * @param period
	 * @param planYear
	 * @return
	 */
	List<EduCourseMajorExt> searchReplenishCourseMajorExtList(Map<String, Object> paramMap);

}
