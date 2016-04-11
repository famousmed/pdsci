package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

public interface EduUserExtMapper {
	
	List<EduUserExt> selectList(EduUserExt userExt);
	/**
	 * ����Ա����--��ѯ��Ա��Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserForManage(Map<String,Object> paramMap);
    /**
     * �γ�ѧϰ���ͳ��--��ѯѧϰ���ſε���Ա��Ϣ
     * @param paramMap
     * @return
     */
	List<EduUserExt> searchEduUserForCourseDetail(Map<String,Object> paramMap);
	
	/**
	 * ��ȡ�û���Ϣ
	 * @param userFlow
	 * @return
	 */
	EduUserExt readEduUserInfo(String userFlow);
	/**
	 * ��ȡ��ʦ�������ν̵Ŀγ���Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduAndCourseList(Map<String,Object> paramMap);
	/**
	 * ������ˮ�Ų�ѯ�û�
	 * @param paramMap
	 * @return
	 */
	List<EduUserExt> searchEduUserList(Map<String,Object> paramMap);
	
	
	/**
	 * ��ѯEduUser,resDoctor,SysUser
	 * @param paramMap
	 * @return
	 */
	List<EduUser> searchEduUserBySysUser(Map<String,Object> paramMap);
	
	
	
	/**
	 * ��ѯ�ͼ�¼���������ѧ����¼
	 * @param paramMap
	 * @return
	 */
	public List<EduUserExt> selectEduUserStudentCourseSun(Map<String, Object> paramMap);
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
	/**
	 * ����ѧԱ��Ϣ��ѯ��Ӧ�Ŀγ�
	 * @param paramMap
	 * @return
	 */
	EduUserExt searchEduUserCourseExtMajorSunList(Map<String, Object> paramMap);
}
