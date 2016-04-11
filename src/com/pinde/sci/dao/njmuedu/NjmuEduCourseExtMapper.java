package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduAnswer;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduCourseExt;

public interface NjmuEduCourseExtMapper {
	/**
	 * ��ѯ�γ�
	 * @param courseFlow �γ���ˮ��
	 * @return
	 */
	EduCourseExt selectOneWithChapters(String courseFlow);
	/**
	 * ��ѯĳһѧ����ѡ��Ŀγ�
	 * @param paramMap
	 * @return
	 */
	public List<EduCourse> searchStuCourseList(Map<String,Object> paramMap);
	/**
	 * ��ѯĳһ��ʦ�ν̵Ŀγ���Ϣ
	 * @param eduCourse
	 * @return
	 */
	public List<EduCourse> searchTchCourseList(Map<String,Object> paramMap);
	/**
	 * ͳ��ĳһ��ʦ�ν̿γ�����
	 * @param paramMap
	 * @return
	 */
	public int countTchCourse(Map<String,Object> paramMap);
	/**
	 * �鿴ѡ��ĳһ��ʦ�γ̵�����ѧ��
	 * @param eduCourse
	 * @return
	 */
	public List<SysUser> searchUserByTch(SysUser sysUser);
	/**
	 * ����������ѯ����
	 * @param sysUser
	 * @return
	 */
	public List<EduQuestion> searchTchEduQuestionsList(Map<String,Object> paramMap);
	/**
	 * ��ѯ�ý�ʦ�ν̵����пγ̵�����Ĵ�
	 * @param sysUser
	 * @return
	 */
	public List<EduAnswer> searchEduAnswerList(String questionFlow);
	/**
	 * ��ѯѡ����ĳһ�ſε�����ѧ����Ϣ
	 * @param eduCourse
	 * @return
	 */
	public List<SysUser> searchUserByCourse(String courseFlow);
	/**
	 * �����û���ˮ�źͿγ����Ͳ�ѯ�γ���Ϣ
	 * @param paramMap
	 * @return
	 */
	public List<EduCourse> searchUserCourseByType(Map<String,Object> paramMap);
	/**
	 *  �����û���ˮ�źͿγ����Ͳ�ѯ�γ�����
	 * @param paramMap
	 * @return
	 */
	public int countUserCourseByType(Map<String,Object> paramMap);
	/**
	 * �����û���ˮ�Ų�ѯ���û���õ���ѧ��
	 * @param userFlow
	 * @return
	 */
	public int countUserAllCredit(String userFlow);
	/**
	 * ��ѯĳһ�ſ��д���ĳ��ѧϰ״̬������
	 * @param paramMap
	 * @return
	 */
	public int countUserByStudyStatus(Map<String,Object> paramMap);
	/**
	 * ��ѯĳѧ���ı�רҵ�Ƽ��γ�(ѡ���������)
	 * @param 
	 * @return
	 */
	public List<EduCourseExt> countRecommendCourseByChooseMost(Map<String,Object> paramMap);
	/**
	 * ��ѯĳѧ���ı�רҵ�Ƽ��γ�(�γ��������)
	 * @param 
	 * @return
	 */
	public List<EduCourseExt> countRecommendCourseByScoreMost(Map<String,Object> paramMap);
	
	/**
	 * ��ʦ�γ���������
	 * @param paramMap
	 * @return
	 */
	List<EduCourseExt> searchCourseListByScoreOrder(Map<String, Object> paramMap);
	
	/**
	 * ��ʦ�γ���������
	 * @param paramMap
	 * @return
	 */
	List<EduCourseExt> searchCourseListByQuestionOrder(Map<String, Object> paramMap);
	
	/**
	 * ���ݲ�ѯ������ѯ�γ�--����Ա
	 * @param paramMap
	 * @return
	 */
	List<EduCourse> searchCourseByCondition(Map<String,Object> paramMap);
	
	/**
	 * ��ʦ�ڿ���Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduCourseExt> searchTeacherChapterInfo(Map<String, Object> paramMap);
	/**
	 * ��ȡѧ�������ѻ��ѧ�ֵĿγ�
	 * @param userFlow
	 * @return
	 */
	List<EduCourse> selectStudentCreditCourses(String userFlow);
	/**
	 * ��ȡѧ����Ҫ����ı��޿�
	 * @param paramMap
	 * @return
	 */
	public List<EduCourse> searchNeedAddCourses(Map<String,Object> paramMap); 
}
