package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduUserBiz {
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
	 * 保存用户并赋权
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
}
