package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

public interface IEduUserCenterBiz {
    
	/**
	 * 查询某学生选择的每种类型的课程数量
	 * @param userFlow
	 * @return
	 */
	Map<String,Object> countUserCourseByType(String userFlow);
	/**
	 * 根据课程类型和课程学习状态
	 * 查询某学生选择的每种类型的课程数量
	 * @param userFlow
	 * @return
	 */
	Map<String,Integer> countUserCourse(String userFlow,String studyStatusId,String deptFlow);
	/**
	 * 查询某教师任教的每种类型的课程数量
	 * @param userFlow
	 * @return
	 */
	Map<String,Object> countTchCourse(String userFlow);
	/**
	 * 查询学生推荐课程(选的人最多)
	 * @param user
	 * @return
	 */
	List<EduCourseExt> countRecommendCourseByChooseMost(EduUser user);
	/**
	 * 查询学生推荐课程(评分最高)
	 * @param user
	 * @return
	 */
	List<EduCourseExt> countRecommendCourseByScoreMost(EduUser user);
	
	/**
	 * 问题最多排上
	 * @param eduUser
	 * @return
	 */
	List<EduCourseExt> searchCourseListByQuestionOrder(EduUser eduUser);
	
	/**
	 * 评分最高排行
	 * @param eduUser
	 * @return
	 */
	List<EduCourseExt> searchCourseListByScoreOrder(EduUser eduUser);
	
	
}
