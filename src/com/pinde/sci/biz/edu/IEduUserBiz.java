package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.edu.EduUserForm;
import com.pinde.sci.model.edu.EduStudentCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

public interface IEduUserBiz {
	/**
	 * 保存
	 * @param eduUser
	 * @return
	 */
	int addEduUser(EduUser eduUser);
	
	/**
	 * 获取一条数据
	 * @param userFlow
	 * @return
	 */
	EduUser readEduUser(String userFlow);
	
	/**
	 * 保存用户信息
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	int saveUserAndEduUser(SysUser sysUser, EduUser eduUser);
	/**
	 * 上传头像
	 * @param file
	 * @return
	 */
	String uploadImg(MultipartFile file);
	/**
	 * 查询用户
	 * @param userExt
	 * @return
	 */
	List<EduUserExt> searchList(EduUserExt userExt);
	/**
	 * 根据权限查询用户
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForManage(Map<String,Object> paramMap);
	/**
	 * 查询选择了某一门课的学生的详细信息
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForCourseDetail(Map<String,Object> paramMap);
	
	/**
	 * 保存教师
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	int saveUserAndRole(SysUser sysUser, EduUser eduUser,String type);
	
	/**
	 * 获取某一个人的详细信息
	 * @param userFlow
	 * @return
	 */
	EduUserExt readEduUserInfo(String userFlow);
	/**
	 * 查询老师及其所任教课程信息
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduAndCourseList(Map<String,Object> paramMap);
	/**
	 * 根据流水号查询用户
	 * @param teacherFlowList
	 * @return
	 */
	List<EduUserExt> searchEduUserByFlows(List<String> teacherFlowList);
	
	public int saveEduUser(EduUser eduUser);
	/**
	 * 保存EduUserForm(content,sysUser,eduUser)
	 * @param form
	 * @return
	 */
	int save(EduUserForm form);
	
	EduUser findByFlow(String userFlow);
	/**
	 * 查询
	 * @param eduUser
	 * @return
	 */
	List<EduUser> search(EduUser eduUser);

//	List<EduUser> searchEduUserBySysUser(EduUser eduUser, SysUser sysUser);

	int importCourseFromExcel(MultipartFile file);



//	List<EduUser> searchEduUserBySysUser(EduUser eduUser, SysUser sysUser,
//			String startDate, String endDate, String startSid, String endSid,
//			String startBirthday, String endBirthday);

	/**
	 * 通过流水号查询
	 * @param userFlowList
	 * @return
	 */
	List<EduUser> searchEduUserByUserFlowList(List<String> userFlowList);
	/**
	 * 查询EduUser,resDoctor,SysUser
	 * @param paramMap
	 * @return
	 */
	List<EduUser> searchEduUserBySysUser(Map<String,Object> paramMap);

	EduUser findBySid(String sid);

	EduUser findBySidNotSelf(String userFlow, String sid);
	
	/**
	 * 查询和记录表相关联的学生记录
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> selectEduUserStudentCourseSun(SysUser sysUser,EduUser eduUser,EduCourse course);
	/**
	 * 根据学员信息查询对应的课程
	 * @param paramMap
	 * @return
	 */
	EduUserExt searchEduUserCourseExtMajorSunList(String userFlow,String majorId,String period,String courseName);
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
	List<EduUser> searchEduUser(EduUser eudUser);

	List<EduUser> searchEduByOrg(String orgFlow);
	
}
