package com.pinde.sci.biz.sys;

import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;

public interface IUserBiz {
	
	public SysUser readSysUser(String sysUserFlow);
	
	public int addUser(SysUser user);
	
	int insertUser(SysUser user);
	
	public int saveUser(SysUser user);
	
	public List<SysUser> searchUser(SysUser sysUser);
	
	public SysUser findByUserCode(String userCode);
	
	public SysUser findByIdNo(String idNo);
	
	public SysUser findByUserPhone(String userPhone);
	
	public SysUser findByUserEmail(String userEmail);
	
	public SysUser findByUserCodeNotSelf(String userFlow,String userCode);
	
	public SysUser findByIdNoNotSelf(String userFlow,String idNo);
	
	/**
	 * ����֤�����ͺ�֤���Ų�ѯ����ָ���û��������û�
	 * @param userFlow
	 * @param idNo
	 * @param cretTypeId
	 * @return
	 */
	public SysUser findByIdNoAndCretTypeNotSelf(String userFlow , String idNo , String cretTypeId);
	
	public SysUser findByUserPhoneNotSelf(String userFlow,String userPhone);
	
	public SysUser findByUserEmailNotSelf(String userFlow,String userEmail);
	
	public SysUser findByUserName(String userName);
	/**
	 * �����û�ȥ�޸�����
	 * @param sysUser
	 * @return
	 */
	public int updateUser(SysUser sysUser);

	/**
	 * �����ϼ����ŵĲ�ѯ ���磺���ܲ���
	 * @param sysUser
	 * @param orgFlows
	 * @return
	 */
	List<SysUser> searchUserByOrgFlow(SysUser sysUser,
			List<String> orgFlows);

	void modifyUserByExample(SysUser user);
	/**
	 * �����û�flow���ϲ����û�
	 * @param sysUser
	 * @return
	 */

	List<SysUser> searchSysUserByuserFlows(List<String> userFlows);

	SysUser searcherUserByOrgFlow(String orgFlow);

	List<SysUser> searchSysUserByOrgFlows(List<String> orgFlows);
	/**
	 * �û�ע�����
	 * @param user
	 */
	public void activateUser(SysUser user);

	List<SysUser> searchUserListByOrgFlow(Map<String, Object> paramMap);

	List<SysUser> searchSysUserByuserFlows(List<String> userFlows,
			String deptFlow);
	
	/**
	 * ��ȡָ��������ָ����ɫ����Ա
	 * @param orgFlow
	 * @param roleFlow
	 * @return
	 */
	List<SysUser> findUserByOrgFlowAndRoleFlow(String orgFlow , String roleFlow);
	
	List<SysUser> findUserByRoleFlow(String orgFlow , String roleFlow);


	public List<SysUser> searchUserByStatus(SysUser user);

	List<SysUser> searchUserByRoleAndOrgFlows(String roleFlow,
			List<String> orgFlows);

	int saveUser(SysUser user, String roleFlow); 
    /**
     * ��ȡӵ��ָ���˵�����Ա
     * @param paramMap
     * @return
     */
    public List<SysUser> searchUserByMenu(Map<String,Object> paramMap);

	void sendResetPassEmail(String userEmail, String userFlow);

	void authUserEmail(SysUser user);

	public void addUserDept(SysUser user,List<String> deptFlows);

	public List<SysUserDept> getUserDept(SysUser user);

	public void disUserDept(SysUser user);

	public SysUser findByUserCodeAndOrgFlow(String userCode, String orgFlow);

	public List<SysUser> searchResManageUser(SysUser user);

	/**
	 * ��Ա����
	 * @param file
	 * @return
	 */
	int importUserFromExcel(MultipartFile file);

	/**
	 * Ϊָ���û�����ͷ��
	 * @param userFlow
	 * @param file
	 * @return
	 */
	String uploadImg(String userFlow, MultipartFile file);

	/**
	 * ����ĳ�����Ż�ȡ�û����Ź�ϵ�б�
	 * @param deptFlow
	 * @return
	 */
	List<SysUserDept> searchUserDeptByDept(String deptFlow);

	/**
	 * ��ȡĳ�����ŵ�ָ����ɫ�û�(֧�ֶಿ��)
	 * @param deptFlow
	 * @param roleFlow
	 * @return
	 */
	List<SysUser> searchUserByDeptAndRole(String deptFlow, String roleFlow);

	/**
	 * ɸѡ����userFlows����û�
	 * @param orgFlow
	 * @param userFlows
	 * @return
	 */
	List<SysUser> searchUserNotInUserFlows(String orgFlow,
			List<String> userFlows);

	SysUser findByFlow(String userFlow);

	/**
	 * ��ѯ��ǰ���̻�����εĴ�������Ա
	 * @param process
	 * @param user
	 * @return
	 */
	List<SysUser> searchAfterAuditUser(ResDoctorSchProcess process, SysUser user);
	/**
	 * ����courseFlow��ѯ��Ӧ��SysUser����
	 * @param process
	 * @param user
	 * @return
	 */
	Map<String,Map<String,Object>> courseFlowSysUserMap(List<EduCourseExt> eduCourseList);

	/**
	 * �����û���ȡ�û����й�������
	 * @param userFlow
	 * @return
	 */
	List<SysUserDept> searchUserDeptByUser(String userFlow);
	/**
	 * �����û���¼����ȡuser
	 * @param userCode
	 * @return
	 */
	List<SysUser> searchUserByUserCode(String userCode);
}
