package com.pinde.sci.biz.edu;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.edu.EduCourseForm;
import com.pinde.sci.form.edu.EduCourseSearchConditionForm;
import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.form.edu.EduStudentCourseForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestPaper;

public interface IEduCourseBiz {
    /**
     * 查询系统中所有课程
     * @return
     */
	List<EduCourse> searchAllCourseList(EduCourse eduCourse,String sort);
	/**
	 * 查询某学生所选择的课程
	 * @param eduStudentCourse
	 * @return
	 */
	List<EduCourse> searchStuCourseList(EduCourse eduCourse,SysUser sysUser,String studyStatus);
	
	/**
	 * 查询课程包含所有章节
	 * @param courseFlow 课程流水号
	 * @return
	 */
	EduCourseExt searchOneWithChapters(String courseFlow);
	

	int editCourse(EduCourse course, MultipartFile file) throws Exception;
	
	/**
	 * 保存课程
	 * @param course
	 * @return
	 */
	int saveCourse(EduCourse course);
	
	/**
	 * 查询课程
	 * @param course
	 * @return
	 */
	List<EduCourse> searchCourseList(EduCourse course);
	/**
	 * 查询课程
	 * @param course
	 * @return
	 */
	List<EduCourse> searchCourseList(EduCourse course,EduCourseSearchConditionForm form);
	/**
	 * 获取一条课程记录
	 * @param courseFlow
	 * @return
	 */
	EduCourse readCourse(String courseFlow);
	
	/**
	 * 删除课程图片
	 * @param courseFlow
	 * @return
	 */
	int deleteCourseImg(String courseFlow);
	
	/**
	 *删除课程
	 * @param courseFlow
	 * @return
	 */
	int delCourse(String courseFlow);
	/**
	 * 查询某教师任教的课程
	 * @param eduStudentCourse
	 * @return
	 */
	List<EduCourse> searchTchCourseList(EduCourse eduCourse,SysUser sysUser);
	/**
	 * 查找选择某教师任教课程的学生
	 * @param sysUser
	 * @return
	 */
	List<SysUser> searchUserByTch(SysUser sysUser);
	/**
	 * 统计选择某一门课的学生
	 * @param eduCourse
	 * @return
	 */
	int countUserSelectOneCourse(EduCourse eduCourse);
	/**
	 * 查询选修这门课学生的详细信息
	 * @param courseFlow
	 * @return
	 */
	List<SysUser> userSelectOneCourseList(String courseFlow);
	/**
	 * 查询选修这门课学生（不包括自己）
	 * @param courseFlow
	 * @return
	 */
	List<SysUser> userSelectOneCourseListNotIncludeSelf(List<String> userFlowList,String courseFlow);
	
	/**
	 * 查询学生某一门课的学习情况
	 * @param schedule
	 * @return
	 */
	List<EduCourseSchedule> searchScheduleList(EduCourseSchedule schedule);
     /**
      * 查询某用户的全部学分总和
      * @param userFlow
      * @return
      */
    int countUserAllCredit(String userFlow);
	
    Map<String,Object> countUserByStudyStatus(String courseFlow);
    /**
     * 
     * @return
     */
	List<EduStudentCourse> searchStudentCourse(EduStudentCourse eduStudentCourse);
	
	/**
	 * 查询
	 * @param resourseFlowList
	 * @return
	 */
	List<EduCourse> searchCourseListByCourseFlowList(List<String> courseFlowList);
	/**
	 * 根据courseList同courseName查询
	 * @param resourseFlowList
	 * @return
	 */
	List<EduCourse> searchCourseNameByCourseFlowList(List<String> courseFlowList,EduCourse course);
	/**
	 * 选择课程
	 * @param userFlow
	 * @param courseFlow
	 * @return
	 */
	int chooseCourse(String userFlow,String courseFlow);
	/**
	 * 根据条件查询课程
	 * @param condition
	 * @return
	 */
	List<EduCourse> searchCourseByCondition(String condition);
	/**
	 * 根据教师流水号查询每个教师所任教的课程信息和数量
	 * @param eduUserExtList
	 * @return
	 */
	Map<String,Map<String,Object>> searchCourseInfoAndCountByEduUserExt(List<EduUserExt> eduUserExtList);
	/**
	 * 教师授课信息
	 * @param paramMap
	 * @return
	 */
	List<EduCourseExt> searchTeacherChapterInfo(Map<String, Object> paramMap);
	/**
	 * 查询学生所有已获得学分的课程
	 * @param userFlow
	 * @return
	 */
	List<EduCourse> searchStudentCreditCourses(String userFlow);
	/**
	 * 保存文件
	 * @param file
	 * @param dir
	 * @return
	 * @throws Exception 
	 */
	EduFileForm saveFile(MultipartFile file,String type) throws Exception;
	/**
	 * 保存resEdu课程信息
	 * @param course
	 * @param chapter
	 * @param form
	 * @return
	 */
	String saveResEduCourse(EduCourse course,EduCourseChapter chapter, EduCourseForm form);
	/**
	 * 保存课程信息并返回流水号
	 * @param course
	 * @return
	 */
	void saveLog(EduCourse course,SysUser user,String reqType,String operName);
	/**
	 * 保存课程
	 * @param course
	 * @return
	 */
	String saveCourseReturnFlow(EduCourse course);
	/**
	 * 判断角色
	 * @return
	 */
	String checkRole();
	/**
	 * 查询课程必修，计分，计学时人员范围
	 * @param courseFlow
	 * @return
	 */
	Map<String, Object> searchEduCourseRefMap(String courseFlow,String type);
	/**
	 * 根据当前用户流水号查询课程
	 * @param course
	 * @param user
	 * @return 
	 */
	List<EduCourseExt> selectCourseList(String userFlow,List<String> deptFlow,EduCourse eduCourse,ResDoctor resDoctor,SysUser sysUser);
	
	
	/**
	 * 修改课程状态
	 * @param course
	 * @param user
	 * @return 
	 */
	void changeCourseStatus(EduCourse course,SysUser user,String type);
	
	List<EduStudentCourseForm> searchCourse(Map<String, Object> paramMap);
	/**
	 * 查询当前用户的课程
	 * @param course
	 * @param user
	 * @return 
	 */
	List<EduCourse> selectCourse(String userFlow, EduCourse course,List<String> deptFlow);
	/**
	 * 课程导入
	 * @param file
	 * @return
	 */
	int importCourseFromExcel(MultipartFile file);
	
}
