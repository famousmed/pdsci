package com.pinde.sci.dao.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysOrg;

/**
 * ������չdao�ӿ�
 * @author Administrator
 *
 */
public interface SysOrgExtMapper {

	/**
	 * ��ѯĳ���ڵ��µ������ӽڵ��������
	 * @param parentFlow
	 * @return
	 */
	List<SysOrg> selectChildrenOrgListByOrgFlow(String orgFlow);
	/**
	 * ��ѯĳ���ڵ��µ������ӽڵ㵫����������
	 * @param parentFlow
	 * @return
	 */
	List<SysOrg> selectChildrenOrgListByOrgFlowNotIncludeSelf(String orgFlow);
	
	/**
	 * ��ѯû�б�ע�����ɫ�ĵ�λ
	 * @return
	 */
	List<SysOrg> selectOrgNoRegByRoleFlow(String roleFlow);
	
	/**
	 * ��ѯ���ܲ���
	 * @return
	 */
	List<SysOrg> selectChargeOrgList();
}
