package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduStudentCourseBiz {
    
	/**
	 * 修改学生选课情况
	 * @param eduStudentCourse
	 * @return
	 */
	public int edit(EduStudentCourse eduStudentCourse);
	/**
	 * 查询学生选择的课程的详细信息
	 * @param eduUserExtList
	 * @return
	 */
	public Map<String,Map<String,Object>> searchStudentChooseCourses(List<EduUserExt> eduUserExtList);
    /**
     * 查询选修了某节课的学生的学分
     * @param paramMap
     * @return
     */
	public Map<String,Object> searchCourseCreditForm(String courseFlow);
	/**
	 * 插入必修课
	 * @return
	 */
	public int insertRequireCourse(String userFlow);
}
