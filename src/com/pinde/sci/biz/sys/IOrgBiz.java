package com.pinde.sci.biz.sys;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysOrgExample;
import com.pinde.sci.model.mo.SysUser;

public interface IOrgBiz {
	
	public SysOrg readSysOrg(String orgFlow);
	
	public int addOrg(SysOrg org);
	
	public int saveOrg(SysOrg org);
	
	public List<SysOrg> searchOrg(SysOrg sysOrg);
	
	/**
	 * 查询全部单位
	 */
	public List<SysOrg> queryAllSysOrg(SysOrg sysorg);
	
	/**
	 * 查询某个节点下所有子节点包过自身节点
	 * @param orgFlow
	 * @return
	 */
	public List<SysOrg> searchChildrenOrgByOrgFlow(String orgFlow);
	
	/**
	 * 查询某个节点下所有子节点但不包括自身节点
	 * @param orgFlow
	 * @return
	 */
	public List<SysOrg> searchChildrenOrgByOrgFlowNotIncludeSelf(String orgFlow);
	
	/**
	 * 查询某个角色没有被注册的单位
	 * @param roleFlow
	 * @return
	 */
	public List<SysOrg> searchOrgNoRegByRoleFlow(String roleFlow);
	
	/**
	 * 根据orgFlow和chargeOrgFlow查询主管部门和申报单位列表
	 * @param org
	 * @return
	 */
	public Map<String, List<SysOrg>> searchChargeAndApply(SysOrg org,String projListScope);
	
	/**
	 * 查询主管部门为chargeOrgFlow的单位
	 * @param chargeOrgFlow
	 * @return
	 */
	public List<SysOrg> searchOrgListByChargeOrgFlow(String chargeOrgFlow);
	
	/**
	 * 查询所有的主管部门 当有些医院是直属市医院时，该主管部门就是卫生局
	 * @return
	 */
	public List<SysOrg> searchChargeOrg();

	List<SysOrg> searchOrgWithBLOBs(SysOrg sysorg);

	int saveDeclarerOrg(SysOrg org, SysUser user);

	List<SysOrg> searchSysOrg(SysOrg sysorg);

	public List<SysOrg> searchOrgByExample(SysOrgExample example);

	List<SysOrg> searchOrderBy(SysOrg sysorg);

	List<SysOrg> searchSysOrg();

	/**
	 * 查询基地
	 * @return
	 */
	List<SysOrg> searchHbresOrgList();
 
	List<SysOrg> searchOrgNotSelf(String orgFlow);

	List<SysOrg> searchOrgFlowIn(List<String> orgFlows);

	int update(SysOrg org);

	List<SysOrg> searchByOrgNotSelf(String orgFlow, SysOrg sysorg);
	
}
