package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduUserBiz {
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
	 * �����û�����Ȩ
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
}
