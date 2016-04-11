package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.njmuedu.OneCourseCreditForm;
import com.pinde.sci.model.njmuedu.EduStudentCourseExt;

public interface NjmuEduStudentCourseExtMapper {

	/**
	 * 查询某学生选择的所有课程及其学习情况
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentCourseExt> searchEduStudentCourseExtByUserFlow(Map<String,Object> paramMap);
	/**
	 * 根据条件统计课程相关信息
	 * @param paramMap
	 * @return
	 */
	public int countCourseInfoByCondition(Map<String,Object> paramMap);
	
	/**
     * 查询选修了某节课的学生的学分
     * @param paramMap
     * @return
     */
	public List<OneCourseCreditForm> searchCourseCreditForm(Map<String,Object> paramMap);
}
