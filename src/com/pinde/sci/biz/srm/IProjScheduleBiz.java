package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysUser;

public interface IProjScheduleBiz {
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
	 * ��չ�׶α������
	 * @param projFlow
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 */
	public void scheduleAudit(String recFlow , String projListScope,
			String agreeFlag, String auditContent);
	
//	public PubProj readProject(String projectFlow);
//
//	
//	/**
//	 * ��ѯ
//	 * @param proj
//	 * @return
//	 */
//	public List<PubProj> searchProj(PubProj proj);
//	
//	/**
//	 * ���ܲ��Ų�ѯ
//	 * @param proj
//	 * @param orgFlow
//	 * @return
//	 */
//	public List<PubProj> searchChargeProjList(PubProj proj , String orgFlow);
	
	


	/**
//	 * ��ѯ��ǰ��¼�û�Ȩ�޷�Χ��Ŀ 
//	 * @param proj
//	 * @param currUser
//	 * @return
//	 */
//	public List<PubProj> searchPersonalProj(PubProj proj); 
	 
	

	
//	/**
//	 * ������Ŀ��Ϣ������
//	 * @param proj
//	 * @param currUser
//	 */
//	public void modProject(PubProj proj);
	
	

//	public void changeProjStatusForAudit(PubProj proj, String projListScope,String isNotAgree);



	

} 
 