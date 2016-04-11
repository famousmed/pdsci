package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

public interface EduUserExtMapper {
	
	List<EduUserExt> selectList(EduUserExt userExt);
	/**
	 * 管理员报表--查询人员信息
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForManage(Map<String,Object> paramMap);
    /**
     * 课程学习情况统计--查询学习该门课的人员信息
     * @param paramMap
     * @return
     */
	List<EduUserExt> searchEduUserForCourseDetail(Map<String,Object> paramMap);
	
	/**
	 * 获取用户信息
	 * @param userFlow
	 * @return
	 */
	EduUserExt readEduUserInfo(String userFlow);
	/**
	 * 获取老师及其所任教的课程信息
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduAndCourseList(Map<String,Object> paramMap);
	/**
	 * 根据流水号查询用户
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserList(Map<String,Object> paramMap);
	
	
	/**
	 * 查询EduUser,resDoctor,SysUser
	 * @param paramMap
	 * @return
	 */
	List<EduUser> searchEduUserBySysUser(Map<String,Object> paramMap);
	
	
	
	/**
	 * 查询和记录表相关联的学生记录
	 * @param paramMap
	 * @return
	 */
	public List<EduUserExt> selectEduUserStudentCourseSun(Map<String, Object> paramMap);
	/**
	 * 查询学员选课（选课维护）
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchStudentCourseMaintainList(Map<String, Object> paramMap);
	/**
	 * 查询学员
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserExtList(Map<String, Object> paramMap);
	/**
	 * 根据学员信息查询对应的课程
	 * @param paramMap
	 * @return
	 */
	EduUserExt searchEduUserCourseExtMajorSunList(Map<String, Object> paramMap);
}
