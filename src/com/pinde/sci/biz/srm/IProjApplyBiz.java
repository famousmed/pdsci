package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;

/**
 * 项目申请阶段业务层
 * 
 * @author shenzhen
 * 
 */
public interface IProjApplyBiz {
	/**
	 * 查询承担单位项目列表
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchLocalProj(PubProj proj, String recTypeId);

	/**
	 * 查询主管单位项目列表
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchChargeProj(PubProj proj, String recTypeId);

	/**
	 * 查询所有项目列表
	 * 
	 * @param proj
	 * @param currUser
	 */
	public List<PubProj> searchGlobalProj(PubProj proj, String recTypeId);


	/**
	 * 申报审核
	 * @param proj
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 */
	public void applyAudit(String projFlow , String projListScope,String  agreeFlag , String auditContent);
	
}
