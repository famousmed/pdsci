package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.PubProjExt;

/**
 * 项目评审务层
 * 
 * @author shenzhen
 * 
 */
public interface IProjEvaluationBiz {

	/**
	 * 查询可评审项目列表
	 * 
	 * @param projListScope
	 * @param proj
	 * @param orgFlow
	 * @return
	 */
	public List<PubProjExt> searchProjList(PubProjExt projExt);
	
	/**
	 * 保存评审设置(网评)
	 * 1：新增或更新评审设置
	 * 2：新增或更新评审设置中选的专家
	 * @param groupProj
	 * @param userFlows
	 */
	public void saveEvaluationSettingForNetWork(SrmExpertProjEval groupProj);
	
	/**
	 * 保存评审设置(会评)
	 * 1:如果原先是网评 就将原先评审设置中的专家和项目的关联记录状态置为N
	 * 2：新增或保存评审设置
	 * @param groupProj
	 * @param userFlows
	 */
	public void saveEvaluationSettingForMeeting(SrmExpertProjEval groupProj);
	
//	/**
//	 * 在评审设置 或 会议上 添加一个会审的项目时 ， 关联该会议上的专家和该项目
//	 * @param expertProjEval
//	 */
//	public void saveExpertProjWhenAddProjForMeeting(SrmExpertProjEval expertProjEval);


}
