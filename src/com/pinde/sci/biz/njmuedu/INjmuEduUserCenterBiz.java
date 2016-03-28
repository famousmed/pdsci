package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.njmuedu.EduCourseExt;

public interface INjmuEduUserCenterBiz {
    
	/**
	 * ��ѯĳѧ��ѡ���ÿ�����͵Ŀγ�����
	 * @param userFlow
	 * @return
	 */
	Map<String,Object> countUserCourseByType(String userFlow);
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
