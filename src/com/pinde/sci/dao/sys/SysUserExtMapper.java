package com.pinde.sci.dao.sys;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SysUser;

public interface SysUserExtMapper {
	public List<SysUser> selectIrbUserByForm(SysUserForm form); 
	public List<SysUser> selectResUserByForm(SysUserForm form); 
	
	List<SysUser> searchUserListByOrgFlow(Map<String, Object> paramMap);
	
	/**
	 * 查询指定机构的某一角色人员(已激活的用户)
	 * @param orgFlow
	 * @param roleFlow
	 * @return
	 */
	List<SysUser> selectUserByOrgFlowAndRoleFlow(Map<String, Object> paramMap);
	
	List<SysUser> selectUserByRoleFlow(Map<String, Object> paramMap);
	
	List<SysUser> searchUserByRoleAndOrgFlows(@Param(value="roleFlow")String roleFlow,@Param(value="orgFlows")List<String> orgFlows);
	/**
	 * 查询拥有某个菜单功能的用户
	 * @param paramMap
	 * @return
	 */
	List<SysUser> selectUserByMenuId(Map<String, Object> paramMap);
	public List<SysUser> searchResManageUser(Map<String, Object> map);
	
	/**
	 * 根据科室查出所有属于该科室的人员(包括多部门)
	 * @param deptFlow
	 * @return
	 */
	List<SysUser> searchUserByDeptAndRole(@Param(value="deptFlow")String deptFlow,@Param(value="roleFlow")String roleFlow);
	
	/**
	 * 查询当前带教或科主任的待出科人员
	 * @param process
	 * @param user
	 * @return
	 */
	List<SysUser> searchAfterAuditUser(@Param(value="process")ResDoctorSchProcess process,@Param(value="user")SysUser user);
}
