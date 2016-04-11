package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduCourseExt;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduCourseBiz {
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
	List<EduCourse> searchStuCourseList(EduCourse eduCourse,SysUser sysUser,List<String> studyStatusList);
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
	 * 保存视频图片文件
	 * @param file
	 * @param type
	 * @return
	 * @throws Exception
	 */
	EduFileForm saveFile(MultipartFile file, String type) throws Exception;
	
	
}
