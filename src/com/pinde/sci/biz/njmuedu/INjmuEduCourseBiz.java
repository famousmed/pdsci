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
     * ��ѯϵͳ�����пγ�
     * @return
     */
	List<EduCourse> searchAllCourseList(EduCourse eduCourse,String sort);
	/**
	 * ��ѯĳѧ����ѡ��Ŀγ�
	 * @param eduStudentCourse
	 * @return
	 */
	List<EduCourse> searchStuCourseList(EduCourse eduCourse,SysUser sysUser,List<String> studyStatusList);
	/**
	 * ��ѯ�γ̰��������½�
	 * @param courseFlow �γ���ˮ��
	 * @return
	 */
	EduCourseExt searchOneWithChapters(String courseFlow);
	

	int editCourse(EduCourse course, MultipartFile file) throws Exception;
	
	/**
	 * ����γ�
	 * @param course
	 * @return
	 */
	int saveCourse(EduCourse course);
	
	/**
	 * ��ѯ�γ�
	 * @param course
	 * @return
	 */
	List<EduCourse> searchCourseList(EduCourse course);
	/**
	 * ��ȡһ���γ̼�¼
	 * @param courseFlow
	 * @return
	 */
	EduCourse readCourse(String courseFlow);
	
	/**
	 * ɾ���γ�ͼƬ
	 * @param courseFlow
	 * @return
	 */
	int deleteCourseImg(String courseFlow);
	
	/**
	 *ɾ���γ�
	 * @param courseFlow
	 * @return
	 */
	int delCourse(String courseFlow);
	/**
	 * ��ѯĳ��ʦ�ν̵Ŀγ�
	 * @param eduStudentCourse
	 * @return
	 */
	List<EduCourse> searchTchCourseList(EduCourse eduCourse,SysUser sysUser);
	/**
	 * ����ѡ��ĳ��ʦ�ν̿γ̵�ѧ��
	 * @param sysUser
	 * @return
	 */
	List<SysUser> searchUserByTch(SysUser sysUser);
	/**
	 * ͳ��ѡ��ĳһ�ſε�ѧ��
	 * @param eduCourse
	 * @return
	 */
	int countUserSelectOneCourse(EduCourse eduCourse);
	/**
	 * ��ѯѡ�����ſ�ѧ������ϸ��Ϣ
	 * @param courseFlow
	 * @return
	 */
	List<SysUser> userSelectOneCourseList(String courseFlow);
	/**
	 * ��ѯѧ��ĳһ�ſε�ѧϰ���
	 * @param schedule
	 * @return
	 */
	List<EduCourseSchedule> searchScheduleList(EduCourseSchedule schedule);
     /**
      * ��ѯĳ�û���ȫ��ѧ���ܺ�
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
	 * ��ѯ
	 * @param resourseFlowList
	 * @return
	 */
	List<EduCourse> searchCourseListByCourseFlowList(List<String> courseFlowList);
	/**
	 * ѡ��γ�
	 * @param userFlow
	 * @param courseFlow
	 * @return
	 */
	int chooseCourse(String userFlow,String courseFlow);
	/**
	 * ����������ѯ�γ�
	 * @param condition
	 * @return
	 */
	List<EduCourse> searchCourseByCondition(String condition);
	/**
	 * ���ݽ�ʦ��ˮ�Ų�ѯÿ����ʦ���ν̵Ŀγ���Ϣ������
	 * @param eduUserExtList
	 * @return
	 */
	Map<String,Map<String,Object>> searchCourseInfoAndCountByEduUserExt(List<EduUserExt> eduUserExtList);
	/**
	 * ��ʦ�ڿ���Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduCourseExt> searchTeacherChapterInfo(Map<String, Object> paramMap);
	/**
	 * ��ѯѧ�������ѻ��ѧ�ֵĿγ�
	 * @param userFlow
	 * @return
	 */
	List<EduCourse> searchStudentCreditCourses(String userFlow);
	/**
	 * ������ƵͼƬ�ļ�
	 * @param file
	 * @param type
	 * @return
	 * @throws Exception
	 */
	EduFileForm saveFile(MultipartFile file, String type) throws Exception;
	
	
}
