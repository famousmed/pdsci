package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.njmuedu.EduUserExt;

public interface NjmuEduUserExtMapper {
	
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
	
}
