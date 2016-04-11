package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduStudentCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

/**
 * @author tiger
 *
 */
public interface IEduStudentCourseBiz {
    
	/**
	 * 修改学生选课情况
	 * @param eduStudentCourse
	 * @return
	 */
	public int save(EduStudentCourse eduStudentCourse);
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
	 * 把该科室该学生的必修课插入该学生的课程中
	 * @param course
	 * @return
	 */
	public String saveStudentRequiredCourse(SysUser sysUser,String schDeptFlow);

	/**
	 * 查询学生选择的课程
	 * @param eduCourse
	 * @param sysUser
	 * @param studyStatusIdList
	 * @param courseTypeIdList
	 * @return
	 */
	List<EduStudentCourseExt> searchStuCourses(EduCourse eduCourse,
			SysUser sysUser, List<String> studyStatusIdList,
			List<String> courseTypeIdList);
	
	/**
	 * 查询学生学分情况
	 * @param user
	 * @return
	 */
	Map<String,Object> searchUserCreditMap(SysUser user,String deptFlow);
	/**
	 * 查询学生最近学习的课程
	 * @param sysUser
	 * @return
	 */
	public List<EduStudentCourse> searchUserNearStudyCourse(SysUser sysUser);
	
	/**
	 * 查询学生可以发现的课程
	 * @param sysUser
	 * @param schDeptFlow
	 * @param order
	 * @param eduCourse
	 * @return
	 */
	public List<EduCourseExt> searchFindCoursePersonal(SysUser sysUser,ResDoctor resDoctor,String schDeptFlow,String order,EduCourse eduCourse);
	
	/**
	 * 查询学生选课记录
	 * @param studentCourse
	 * @return
	 */
	public List<EduStudentCourse> searchStudentCourseList(EduStudentCourse studentCourse);
	/**
	 * 加载发现课程列表
	 * @param sysUser
	 * @param resDoctor
	 * @param schDeptFlow
	 * @param checkSchDeptFlow
	 * @param isCredit
	 * @param isPeriod
	 * @param eduCourse
	 * @return
	 */
	List<EduCourseExt> searchFindCourseNoDoctor(SysUser sysUser,
			ResDoctor resDoctor, String schDeptFlow, String checkSchDeptFlow,
			String isCredit, String isPeriod, EduCourse eduCourse);
	
	List<EduStudentCourse> searchStudentCourseList(List<String> courseFlowList); 
	
	
	Map<String,Map<String,Object>> courseFlowStudentCourseMap(List<EduCourseExt> eduCourseList);
	/**
	 * 将课程信息插入年度培训记录
	 * @param studentCourse
	 * @param user
	 * @param schDept
	 * @return
	 */
	int saveCourseAnnualTrain(EduStudentCourse studentCourse,EduCourse course,SysUser user);

	List<StudentCourseNumForm> studentCourseNumList(Map<String, Object> map);
	
	Map<String,Map<String,Object>> studentCourseListMap(List<String> list);
	
	/**
	 * 保存网上选课
	 * @param courseFlowList
	 * @return
	 */
	int saveStudentCourseByCourseFlowList(String studentPeriod, String majorId, String userFlow, List<String> courseFlowList, String replenishFlag);
	
	/**
	 * 查询该届学生该专业所有课程已选人数（已选）
	 * @param paramMap
	 * @return
	 */
	List<StudentCourseNumForm> searchStudentCourseChooseCount(Map<String, Object> paramMap);
	
	/**
	 * 保存课程维护
	 * @param userFlow
	 * @param courseFlow
	 * @return
	 */
	int saveCourseMaintain(EduStudentCourse studentCourse, String courseMajorRecordFlow);
	
	/**
	 * 根据课程类别组织该用户所选课程对应的课程Map
	 * @param userFlow
	 * @return
	 */
	Map<String, Object> extractStudentCourseMapByUserFlow(String studentPeriod, String userFlow);
	
	
	/**
	 * 获取该年度该学员的所有选择课程
	 * @param studentPeriod
	 * @param userFlow
	 * @return
	 */
	List<EduStudentCourseExt> searchStudentCourseExtList(String studentPeriod, String userFlow);
	
}
