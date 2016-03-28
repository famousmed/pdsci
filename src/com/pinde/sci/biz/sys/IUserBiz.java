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
	 * 根据证件类型和证件号查询不是指定用户的其他用户
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
	 * 根据用户去修改密码
	 * @param sysUser
	 * @return
	 */
	public int updateUser(SysUser sysUser);

	/**
	 * 用于上级部门的查询 例如：主管部门
	 * @param sysUser
	 * @param orgFlows
	 * @return
	 */
	List<SysUser> searchUserByOrgFlow(SysUser sysUser,
			List<String> orgFlows);

	void modifyUserByExample(SysUser user);
	/**
	 * 根据用户flow集合查找用户
	 * @param sysUser
	 * @return
	 */

	List<SysUser> searchSysUserByuserFlows(List<String> userFlows);

	SysUser searcherUserByOrgFlow(String orgFlow);

	List<SysUser> searchSysUserByOrgFlows(List<String> orgFlows);
	/**
	 * 用户注册审核
	 * @param user
	 */
	public void activateUser(SysUser user);

	List<SysUser> searchUserListByOrgFlow(Map<String, Object> paramMap);

	List<SysUser> searchSysUserByuserFlows(List<String> userFlows,
			String deptFlow);
	
	/**
	 * 获取指定机构，指定角色的人员
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
     * 获取拥有指定菜单的人员
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
	 * 人员导入
	 * @param file
	 * @return
	 */
	int importUserFromExcel(MultipartFile file);

	/**
	 * 为指定用户保存头像
	 * @param userFlow
	 * @param file
	 * @return
	 */
	String uploadImg(String userFlow, MultipartFile file);

	/**
	 * 根据某个部门获取用户部门关系列表
	 * @param deptFlow
	 * @return
	 */
	List<SysUserDept> searchUserDeptByDept(String deptFlow);

	/**
	 * 获取某个部门的指定角色用户(支持多部门)
	 * @param deptFlow
	 * @param roleFlow
	 * @return
	 */
	List<SysUser> searchUserByDeptAndRole(String deptFlow, String roleFlow);

	/**
	 * 筛选不在userFlows里的用户
	 * @param orgFlow
	 * @param userFlows
	 * @return
	 */
	List<SysUser> searchUserNotInUserFlows(String orgFlow,
			List<String> userFlows);

	SysUser findByFlow(String userFlow);

	/**
	 * 查询当前带教或科主任的待出科人员
	 * @param process
	 * @param user
	 * @return
	 */
	List<SysUser> searchAfterAuditUser(ResDoctorSchProcess process, SysUser user);
	/**
	 * 根据courseFlow查询对应的SysUser对象
	 * @param process
	 * @param user
	 * @return
	 */
	Map<String,Map<String,Object>> courseFlowSysUserMap(List<EduCourseExt> eduCourseList);

	/**
	 * 根据用户获取用户所有关联部门
	 * @param userFlow
	 * @return
	 */
	List<SysUserDept> searchUserDeptByUser(String userFlow);
	/**
	 * 根据用户登录名获取user
	 * @param userCode
	 * @return
	 */
	List<SysUser> searchUserByUserCode(String userCode);
}
