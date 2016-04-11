package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.ErpUserRegionPopedom;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.mo.SysUserRoleExample;

public interface IUserRoleBiz {
	
	public List<SysUserRole> getByUserFlow(String userFlow);
	
	public List<SysUserRole> getByOrgFlow(String orgFlow,String wsid);

	public void saveAllot(String userFlow,String orgFlow,String workStationId, String[] roleFlows);

	List<SysUserRole> searchUserRole(SysUserRole userRole);

	int saveSysUserRole(SysUserRole userRole);

	public void saveRegion(String userFlow, String[] provIds, String [] provNames);

	public List<ErpUserRegionPopedom> getErpUserRegionByUserFlow(String userFlow);

	public void delErpUserRegion(String recordFlow);

	List<SysUserRole> searchUserByRoles(List<String> roleList, String orgFlow);

	public void saveSysUserRole(String userFlow, String roleFlow);

	/**
	 * 根据用户和角色获取当前用户
	 * @param userFlow
	 * @param roleFlow
	 * @return
	 */
	SysUserRole readUserRole(String userFlow, String roleFlow);

}
