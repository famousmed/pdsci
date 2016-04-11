package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

/**
 * 项目合同业务层
 * 
 * @author shenzhen
 * 
 */
public interface IProjContractBiz {

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
	 * 合同审核
	 * @param projFlow
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 */
	public void contractAudit(String projFlow , String projListScope , String agreeFlag , String auditContent);
	
	/**
	 * 卫生局审核通过后的合同退回(非流程操作)
	 * 前提：区域版 , 当前操作用户是卫生局 , 没有填写实施报告
	 * @param recFlow
	 */
	public void controctBackForThridAudit(String recFlow);
    
	
}
