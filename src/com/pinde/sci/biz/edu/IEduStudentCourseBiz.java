package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduStudentCourseExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

/**
 * @author tiger
 *
 */
public interface IEduStudentCourseBiz {
    
	/**
	 * �޸�ѧ��ѡ�����
	 * @param eduStudentCourse
	 * @return
	 */
	public int save(EduStudentCourse eduStudentCourse);
	/**
	 * ��ѯѧ��ѡ��Ŀγ̵���ϸ��Ϣ
	 * @param eduUserExtList
	 * @return
	 */
	public Map<String,Map<String,Object>> searchStudentChooseCourses(List<EduUserExt> eduUserExtList);
    /**
     * ��ѯѡ����ĳ�ڿε�ѧ����ѧ��
     * @param paramMap
     * @return
     */
	public Map<String,Object> searchCourseCreditForm(String courseFlow);
	
	/**
	 * �Ѹÿ��Ҹ�ѧ���ı��޿β����ѧ���Ŀγ���
	 * @param course
	 * @return
	 */
	public String saveStudentRequiredCourse(SysUser sysUser,String schDeptFlow);

	/**
	 * ��ѯѧ��ѡ��Ŀγ�
	 * @param eduCourse
	 * @param sysUser
	 * @param studyStatusIdList
	 * @param courseTypeIdList
	 * @return
	 */
	List<EduStudentCourseExt> searchStuCourses(EduCourse eduCourse,
			SysUser sysUser, List<String> studyStatusIdList,
			List<String> courseTypeIdList);
	
	/**
	 * ��ѯѧ��ѧ�����
	 * @param user
	 * @return
	 */
	Map<String,Object> searchUserCreditMap(SysUser user,String deptFlow);
	/**
	 * ��ѯѧ�����ѧϰ�Ŀγ�
	 * @param sysUser
	 * @return
	 */
	public List<EduStudentCourse> searchUserNearStudyCourse(SysUser sysUser);
	
	/**
	 * ��ѯѧ�����Է��ֵĿγ�
	 * @param sysUser
	 * @param schDeptFlow
	 * @param order
	 * @param eduCourse
	 * @return
	 */
	public List<EduCourseExt> searchFindCoursePersonal(SysUser sysUser,ResDoctor resDoctor,String schDeptFlow,String order,EduCourse eduCourse);
	
	/**
	 * ��ѯѧ��ѡ�μ�¼
	 * @param studentCourse
	 * @return
	 */
	public List<EduStudentCourse> searchStudentCourseList(EduStudentCourse studentCourse);
	/**
	 * ���ط��ֿγ��б�
	 * @param sysUser
	 * @param resDoctor
	 * @param schDeptFlow
	 * @param checkSchDeptFlow
	 * @param isCredit
	 * @param isPeriod
	 * @param eduCourse
	 * @return
	 */
	List<EduCourseExt> searchFindCourseNoDoctor(SysUser sysUser,
			ResDoctor resDoctor, String schDeptFlow, String checkSchDeptFlow,
			String isCredit, String isPeriod, EduCourse eduCourse);
	
	List<EduStudentCourse> searchStudentCourseList(List<String> courseFlowList); 
	
	
	Map<String,Map<String,Object>> courseFlowStudentCourseMap(List<EduCourseExt> eduCourseList);
	/**
	 * ���γ���Ϣ���������ѵ��¼
	 * @param studentCourse
	 * @param user
	 * @param schDept
	 * @return
	 */
	int saveCourseAnnualTrain(EduStudentCourse studentCourse,EduCourse course,SysUser user);

	List<StudentCourseNumForm> studentCourseNumList(Map<String, Object> map);
	
	Map<String,Map<String,Object>> studentCourseListMap(List<String> list);
	
	/**
	 * ��������ѡ��
	 * @param courseFlowList
	 * @return
	 */
	int saveStudentCourseByCourseFlowList(String studentPeriod, String majorId, String userFlow, List<String> courseFlowList, String replenishFlag);
	
	/**
	 * ��ѯ�ý�ѧ����רҵ���пγ���ѡ��������ѡ��
	 * @param paramMap
	 * @return
	 */
	List<StudentCourseNumForm> searchStudentCourseChooseCount(Map<String, Object> paramMap);
	
	/**
	 * ����γ�ά��
	 * @param userFlow
	 * @param courseFlow
	 * @return
	 */
	int saveCourseMaintain(EduStudentCourse studentCourse, String courseMajorRecordFlow);
	
	/**
	 * ���ݿγ������֯���û���ѡ�γ̶�Ӧ�Ŀγ�Map
	 * @param userFlow
	 * @return
	 */
	Map<String, Object> extractStudentCourseMapByUserFlow(String studentPeriod, String userFlow);
	
	
	/**
	 * ��ȡ����ȸ�ѧԱ������ѡ��γ�
	 * @param studentPeriod
	 * @param userFlow
	 * @return
	 */
	List<EduStudentCourseExt> searchStudentCourseExtList(String studentPeriod, String userFlow);
	
}
