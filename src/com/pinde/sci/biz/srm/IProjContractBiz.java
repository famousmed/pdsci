package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

/**
 * ��Ŀ��ͬҵ���
 * 
 * @author shenzhen
 * 
 */
public interface IProjContractBiz {

	/**
	 * ��ѯ�е���λ��Ŀ�б�
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchLocalProj(PubProj proj, String recTypeId);

	/**
	 * ��ѯ���ܵ�λ��Ŀ�б�
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchChargeProj(PubProj proj, String recTypeId);

	/**
	 * ��ѯ������Ŀ�б�
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchGlobalProj(PubProj proj, String recTypeId);
	
	/**
	 * ��ͬ���
	 * @param projFlow
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 */
	public void contractAudit(String projFlow , String projListScope , String agreeFlag , String auditContent);
	
	/**
	 * ���������ͨ����ĺ�ͬ�˻�(�����̲���)
	 * ǰ�᣺����� , ��ǰ�����û��������� , û����дʵʩ����
	 * @param recFlow
	 */
	public void controctBackForThridAudit(String recFlow);
    
	
}
