package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;

/**
 * ��Ŀ����׶�ҵ���
 * 
 * @author shenzhen
 * 
 */
public interface IProjApplyBiz {
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
	 * �걨���
	 * @param proj
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 */
	public void applyAudit(String projFlow , String projListScope,String  agreeFlag , String auditContent);
	
}
