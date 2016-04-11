package com.pinde.sci.dao.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysOrg;

/**
 * 机构扩展dao接口
 * @author Administrator
 *
 */
public interface SysOrgExtMapper {

	/**
	 * 查询某个节点下的所有子节点包过自身
	 * @param parentFlow
	 * @return
	 */
	List<SysOrg> selectChildrenOrgListByOrgFlow(String orgFlow);
	/**
	 * 查询某个节点下的所有子节点但不包括自身
	 * @param parentFlow
	 * @return
	 */
	List<SysOrg> selectChildrenOrgListByOrgFlowNotIncludeSelf(String orgFlow);
	
	/**
	 * 查询没有被注册过角色的单位
	 * @return
	 */
	List<SysOrg> selectOrgNoRegByRoleFlow(String roleFlow);
	
	/**
	 * 查询主管部门
	 * @return
	 */
	List<SysOrg> selectChargeOrgList();
}
