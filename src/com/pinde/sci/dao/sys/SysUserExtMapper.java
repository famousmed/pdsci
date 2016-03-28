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
	 * ��ѯָ��������ĳһ��ɫ��Ա(�Ѽ�����û�)
	 * @param orgFlow
	 * @param roleFlow
	 * @return
	 */
	List<SysUser> selectUserByOrgFlowAndRoleFlow(Map<String, Object> paramMap);
	
	List<SysUser> selectUserByRoleFlow(Map<String, Object> paramMap);
	
	List<SysUser> searchUserByRoleAndOrgFlows(@Param(value="roleFlow")String roleFlow,@Param(value="orgFlows")List<String> orgFlows);
	/**
	 * ��ѯӵ��ĳ���˵����ܵ��û�
	 * @param paramMap
	 * @return
	 */
	List<SysUser> selectUserByMenuId(Map<String, Object> paramMap);
	public List<SysUser> searchResManageUser(Map<String, Object> map);
	
	/**
	 * ���ݿ��Ҳ���������ڸÿ��ҵ���Ա(�����ಿ��)
	 * @param deptFlow
	 * @return
	 */
	List<SysUser> searchUserByDeptAndRole(@Param(value="deptFlow")String deptFlow,@Param(value="roleFlow")String roleFlow);
	
	/**
	 * ��ѯ��ǰ���̻�����εĴ�������Ա
	 * @param process
	 * @param user
	 * @return
	 */
	List<SysUser> searchAfterAuditUser(@Param(value="process")ResDoctorSchProcess process,@Param(value="user")SysUser user);
}
