package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;

public interface IExpertProjBiz {

	/**
	 * 保存专家评审的项目
	 * @param expertProj
	 */
	void save(SrmExpertProj expertProj);

	/**
	 * 根据项目流水号和 用户流水号查询专家评审的项目
	 * @param projFlow
	 * @param userFlow
	 * @return
	 */
	SrmExpertProj read(String projFlow, String userFlow);

	/**
	 * 根据主键修改 包过大字段
	 * @param expertProj
	 */
	void modifyByFlow(SrmExpertProj expertProj);

	/**
	 * 评审项目过期 隐藏
	 * @param expertProj
	 */
	void saveForHide(SrmExpertProj expertProj);
 
	List<SrmExpertProj> searchExample(SrmExpertProjExample expertProj);

	/**
	 * 根据主键查询
	 * @param recordFlow
	 * @return
	 */
	SrmExpertProj read(String recordFlow);

	/**
	 * 根据评审设置流水号 查询该次评审设置中的专家评审的项目
	 * @param evaluationFlow
	 * @return
	 */
	List<SrmExpertProj> searchExperProjByEvaluationFlow(String evaluationFlow);

	/**
	 * 在评审设置的时候给某个项目分配评审专家
	 * @param groupProj
	 * @param userFlow
	 */
	void saveExpertProj(SrmExpertProjEval groupProj, List<String> userFlowList);

	/**
	 * 根据主键修改 不包过大字段
	 * @param expertProj
	 */
	void modifyWithOutBlobsByFlow(SrmExpertProj expertProj);   
	
	/**
	 * 根据自身条件修改 包过大字段
	 * @param expertProj
	 */
	void modifyWithBlob(SrmExpertProj expertProj);
	
	/**
	 * 根据自身条件修改 不包过大字段
	 * @param expertProj
	 */
	void modify(SrmExpertProj expertProj);
	
	/**
	 * 查询某个专家的评审项目
	 * @param srmExpertProjExt
	 * @return
	 */
	List<SrmExpertProjExt> searchExpertProj(SrmExpertProjExt srmExpertProjExt);
	
	/**
	 * 查询参加某个项目评审的所有专家
	 * @param expertProj
	 * @return
	 */
	List<SysUserExt>  searchJoinEvalSetExpertList(SrmExpertProj expertProj);
	
	/**
	 * 关联用户表 查询专家评审的信息 包过用户信息
	 * @param expertProj
	 * @return
	 */
	List<SrmExpertProjExt> searchExpertProjExtAndUserExt(SrmExpertProj expertProj);
	
	/**
	 * 判断某个项目是否有专家打过分
	 * @param projFlow
	 * @return true 有专家给该项目打过分 并且保存或提交过  false 还没有专家给该项目打过分
	 */
	public boolean searchExpertIsSetScoreByProjFlow(String projFlow);
	
	/**
	 * 给专家发送短信通知
	 */
	public void sendPhoneNotice(String evalSetFlow , String userFlow);
	
	/**
	 * 给专家发送邮件通知
	 */
	public void sendEmailNotice(String evalSetFlow , String userFlow);
 
} 
 