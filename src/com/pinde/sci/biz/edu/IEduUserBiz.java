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
	 * ����
	 * @param eduUser
	 * @return
	 */
	int addEduUser(EduUser eduUser);
	
	/**
	 * ��ȡһ������
	 * @param userFlow
	 * @return
	 */
	EduUser readEduUser(String userFlow);
	
	/**
	 * �����û���Ϣ
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	int saveUserAndEduUser(SysUser sysUser, EduUser eduUser);
	/**
	 * �ϴ�ͷ��
	 * @param file
	 * @return
	 */
	String uploadImg(MultipartFile file);
	/**
	 * ��ѯ�û�
	 * @param userExt
	 * @return
	 */
	List<EduUserExt> searchList(EduUserExt userExt);
	/**
	 * ����Ȩ�޲�ѯ�û�
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForManage(Map<String,Object> paramMap);
	/**
	 * ��ѯѡ����ĳһ�ſε�ѧ������ϸ��Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForCourseDetail(Map<String,Object> paramMap);
	
	/**
	 * �����ʦ
	 * @param sysUser
	 * @param eduUser
	 * @return
	 */
	int saveUserAndRole(SysUser sysUser, EduUser eduUser,String type);
	
	/**
	 * ��ȡĳһ���˵���ϸ��Ϣ
	 * @param userFlow
	 * @return
	 */
	EduUserExt readEduUserInfo(String userFlow);
	/**
	 * ��ѯ��ʦ�������ν̿γ���Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduAndCourseList(Map<String,Object> paramMap);
	/**
	 * ������ˮ�Ų�ѯ�û�
	 * @param teacherFlowList
	 * @return
	 */
	List<EduUserExt> searchEduUserByFlows(List<String> teacherFlowList);
	
	public int saveEduUser(EduUser eduUser);
	/**
	 * ����EduUserForm(content,sysUser,eduUser)
	 * @param form
	 * @return
	 */
	int save(EduUserForm form);
	
	EduUser findByFlow(String userFlow);
	/**
	 * ��ѯ
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
	 * ͨ����ˮ�Ų�ѯ
	 * @param userFlowList
	 * @return
	 */
	List<EduUser> searchEduUserByUserFlowList(List<String> userFlowList);
	/**
	 * ��ѯEduUser,resDoctor,SysUser
	 * @param paramMap
	 * @return
	 */
	List<EduUser> searchEduUserBySysUser(Map<String,Object> paramMap);

	EduUser findBySid(String sid);

	EduUser findBySidNotSelf(String userFlow, String sid);
	
	/**
	 * ��ѯ�ͼ�¼���������ѧ����¼
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> selectEduUserStudentCourseSun(SysUser sysUser,EduUser eduUser,EduCourse course);
	/**
	 * ����ѧԱ��Ϣ��ѯ��Ӧ�Ŀγ�
	 * @param paramMap
	 * @return
	 */
	EduUserExt searchEduUserCourseExtMajorSunList(String userFlow,String majorId,String period,String courseName);
	/**
	 * ��ѯѧԱѡ�Σ�ѡ��ά����
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchStudentCourseMaintainList(Map<String, Object> paramMap);



	/**
	 * ��ѯѧԱ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserExtList(Map<String, Object> paramMap);
	List<EduUser> searchEduUser(EduUser eudUser);

	List<EduUser> searchEduByOrg(String orgFlow);
	
}
