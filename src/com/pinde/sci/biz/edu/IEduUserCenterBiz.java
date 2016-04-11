package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

public interface IEduUserCenterBiz {
    
	/**
	 * ��ѯĳѧ��ѡ���ÿ�����͵Ŀγ�����
	 * @param userFlow
	 * @return
	 */
	Map<String,Object> countUserCourseByType(String userFlow);
	/**
	 * ���ݿγ����ͺͿγ�ѧϰ״̬
	 * ��ѯĳѧ��ѡ���ÿ�����͵Ŀγ�����
	 * @param userFlow
	 * @return
	 */
	Map<String,Integer> countUserCourse(String userFlow,String studyStatusId,String deptFlow);
	/**
	 * ��ѯĳ��ʦ�ν̵�ÿ�����͵Ŀγ�����
	 * @param userFlow
	 * @return
	 */
	Map<String,Object> countTchCourse(String userFlow);
	/**
	 * ��ѯѧ���Ƽ��γ�(ѡ�������)
	 * @param user
	 * @return
	 */
	List<EduCourseExt> countRecommendCourseByChooseMost(EduUser user);
	/**
	 * ��ѯѧ���Ƽ��γ�(�������)
	 * @param user
	 * @return
	 */
	List<EduCourseExt> countRecommendCourseByScoreMost(EduUser user);
	
	/**
	 * �����������
	 * @param eduUser
	 * @return
	 */
	List<EduCourseExt> searchCourseListByQuestionOrder(EduUser eduUser);
	
	/**
	 * �����������
	 * @param eduUser
	 * @return
	 */
	List<EduCourseExt> searchCourseListByScoreOrder(EduUser eduUser);
	
	
}
