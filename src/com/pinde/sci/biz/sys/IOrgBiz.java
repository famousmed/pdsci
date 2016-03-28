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
	 * ��ѯȫ����λ
	 */
	public List<SysOrg> queryAllSysOrg(SysOrg sysorg);
	
	/**
	 * ��ѯĳ���ڵ��������ӽڵ��������ڵ�
	 * @param orgFlow
	 * @return
	 */
	public List<SysOrg> searchChildrenOrgByOrgFlow(String orgFlow);
	
	/**
	 * ��ѯĳ���ڵ��������ӽڵ㵫����������ڵ�
	 * @param orgFlow
	 * @return
	 */
	public List<SysOrg> searchChildrenOrgByOrgFlowNotIncludeSelf(String orgFlow);
	
	/**
	 * ��ѯĳ����ɫû�б�ע��ĵ�λ
	 * @param roleFlow
	 * @return
	 */
	public List<SysOrg> searchOrgNoRegByRoleFlow(String roleFlow);
	
	/**
	 * ����orgFlow��chargeOrgFlow��ѯ���ܲ��ź��걨��λ�б�
	 * @param org
	 * @return
	 */
	public Map<String, List<SysOrg>> searchChargeAndApply(SysOrg org,String projListScope);
	
	/**
	 * ��ѯ���ܲ���ΪchargeOrgFlow�ĵ�λ
	 * @param chargeOrgFlow
	 * @return
	 */
	public List<SysOrg> searchOrgListByChargeOrgFlow(String chargeOrgFlow);
	
	/**
	 * ��ѯ���е����ܲ��� ����ЩҽԺ��ֱ����ҽԺʱ�������ܲ��ž���������
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
	 * ��ѯ����
	 * @return
	 */
	List<SysOrg> searchHbresOrgList();
 
	List<SysOrg> searchOrgNotSelf(String orgFlow);

	List<SysOrg> searchOrgFlowIn(List<String> orgFlows);

	int update(SysOrg org);

	List<SysOrg> searchByOrgNotSelf(String orgFlow, SysOrg sysorg);
	
}
