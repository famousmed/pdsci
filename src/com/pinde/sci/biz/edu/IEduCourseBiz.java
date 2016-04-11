package com.pinde.sci.biz.edu;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.edu.EduCourseForm;
import com.pinde.sci.form.edu.EduCourseSearchConditionForm;
import com.pinde.sci.form.edu.EduFileForm;
import com.pinde.sci.form.edu.EduStudentCourseForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.TestPaper;

public interface IEduCourseBiz {
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
	List<EduCourse> searchStuCourseList(EduCourse eduCourse,SysUser sysUser,String studyStatus);
	
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
	 * ��ѯ�γ�
	 * @param course
	 * @return
	 */
	List<EduCourse> searchCourseList(EduCourse course,EduCourseSearchConditionForm form);
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
	 * ��ѯѡ�����ſ�ѧ�����������Լ���
	 * @param courseFlow
	 * @return
	 */
	List<SysUser> userSelectOneCourseListNotIncludeSelf(List<String> userFlowList,String courseFlow);
	
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
	 * ����courseListͬcourseName��ѯ
	 * @param resourseFlowList
	 * @return
	 */
	List<EduCourse> searchCourseNameByCourseFlowList(List<String> courseFlowList,EduCourse course);
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
	 * �����ļ�
	 * @param file
	 * @param dir
	 * @return
	 * @throws Exception 
	 */
	EduFileForm saveFile(MultipartFile file,String type) throws Exception;
	/**
	 * ����resEdu�γ���Ϣ
	 * @param course
	 * @param chapter
	 * @param form
	 * @return
	 */
	String saveResEduCourse(EduCourse course,EduCourseChapter chapter, EduCourseForm form);
	/**
	 * ����γ���Ϣ��������ˮ��
	 * @param course
	 * @return
	 */
	void saveLog(EduCourse course,SysUser user,String reqType,String operName);
	/**
	 * ����γ�
	 * @param course
	 * @return
	 */
	String saveCourseReturnFlow(EduCourse course);
	/**
	 * �жϽ�ɫ
	 * @return
	 */
	String checkRole();
	/**
	 * ��ѯ�γ̱��ޣ��Ʒ֣���ѧʱ��Ա��Χ
	 * @param courseFlow
	 * @return
	 */
	Map<String, Object> searchEduCourseRefMap(String courseFlow,String type);
	/**
	 * ���ݵ�ǰ�û���ˮ�Ų�ѯ�γ�
	 * @param course
	 * @param user
	 * @return 
	 */
	List<EduCourseExt> selectCourseList(String userFlow,List<String> deptFlow,EduCourse eduCourse,ResDoctor resDoctor,SysUser sysUser);
	
	
	/**
	 * �޸Ŀγ�״̬
	 * @param course
	 * @param user
	 * @return 
	 */
	void changeCourseStatus(EduCourse course,SysUser user,String type);
	
	List<EduStudentCourseForm> searchCourse(Map<String, Object> paramMap);
	/**
	 * ��ѯ��ǰ�û��Ŀγ�
	 * @param course
	 * @param user
	 * @return 
	 */
	List<EduCourse> selectCourse(String userFlow, EduCourse course,List<String> deptFlow);
	/**
	 * �γ̵���
	 * @param file
	 * @return
	 */
	int importCourseFromExcel(MultipartFile file);
	
}
