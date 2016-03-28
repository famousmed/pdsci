package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysUser;

public interface IProjRecBiz {

//	/**
//	 * 保存
//	 * @param projProcessRec
//	 */
//	public void addProjRec(PubProjRec projRec);
	
//	/**
//	 * 保存的重载方法
//	 * @param projProcessRec
//	 * @param user
//	 */
//	public void saveProjRec(PubProjRec projRec , SysUser user);
	
//	/**
//	 * 修改(根据流水号主键修改)
//	 * @param projProcessRec
//	 */
//	public void updateProjRec(PubProjRec projRec);
	
//	/**
//	 * 修改的重载
//	 * @param projProcessRec
//	 */
//	public void updateProjRec(PubProjRec projRec , SysUser user);
	
	/**
	 * 根据主键查找 包过大字段
	 * @param flow
	 * @return
	 */
	public PubProjRec readProjRec(String flow);
	
//	/**
//	 * 根据主键查找 不包过大字段
//	 * @param flow
//	 * @return
//	 */
//	public PubProjRec selectProjRecNoContentByFlow(String flow);
	
	/**
	 * 保存
	 * @param projProcessRec
	 */
	public void addProjRec(PubProjRec projRec);
	
//	/**
//	 * 保存的重载方法
//	 * @param projProcessRec 
//	 * @param user
//	 */
//	public void addProjRec(PubProjRec projRec , SysUser user);

	public List<PubProjRec> searchProjRec(PubProjRecExample example);
	
	public List<PubProjRec> searchProjRecNotInApply(PubProjRec projRec);
	
	public List<PubProjRec> searchProjRec(PubProjRec projRec);
	
	public void modProjRec(PubProjRec applyRec);

//	public void addPubProjRec(String recTypeId,PubProj pubProj);

	public void delProjRec(PubProjRec rec);

//	public void submitRecAudit(String recTypeId,PubProjRec rec);

	public void changeRecStatusForAudit(String recTypeId, PubProj proj,
			PubProjRec rec, String projListScope,
			String isNotAgree,String auditContent);
	
	/**
	 * 根据projFlow和recType 查询 返回唯一一条记录的数据 不包过大字段  不能用于季报 等多条rec的情况
	 */
	public PubProjRec selectProjRecByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * 根据projFlow和recType 查询 rec的数量
	 */
	public Integer selectRecCountByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * 根据projFlow和recType 查询 返回唯一一条记录 包过大字段 不能用于进展报告 ， 变更报告等多条rec情况
	 * @param projFlow
	 * @param recTypeId
	 * @return
	 */
	public PubProjRec selectProjRecWithContentByProjFlowAndRecType(String projFlow , String recTypeId);
	
	/**
	 * 更新recContent
	 * @param applyRec
	 */
	public void modProjRecWithXml(PubProjRec applyRec);
    
	/**
	 * 查找是否存在中止报告和验收申请书是否存在
	 * @param projFlow
	 * @param recTypeId
	 * @return
	 */
	public List<PubProjRec> searchCompleteAndTerminate(String projFlow,String recTypeId);
	
	public List<PubProjRec> selectProjRecByProjFlowAndRecList(String projFlow , List<String> recTypeList);

	PubProjRec selectProjRecNoContentByFlow(String flow);	
}
