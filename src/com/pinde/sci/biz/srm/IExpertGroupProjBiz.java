package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;

public interface IExpertGroupProjBiz {
	/**
	 * 根据项目号，评审id(1：立项评审   2：验收评审)
	 * @param groupFlow
	 * @return
	 */
	public SrmExpertProjEval searchSrmExpertGroupProjByProjFlowAndEvaluationId(String projFlow , String evaluationId);
	
	/**
	 * 根据评审设置流水号(主键)查询 评审设置对象
	 * @param recordFlow
	 * @return
	 */
	public SrmExpertProjEval searchSrmExpertGroupProjByFlow(String recordFlow);

	public void save(SrmExpertProjEval egp);

	public Map<String, SrmExpertProjEval> orgExperGroupProjMap();
	
	/**
	 * 根据条件查询评审设置(关联项目和评审方案)
	 * @param srmExpertGroupProjExt
	 * @return
	 */
	public List<SrmExpertGroupProjExt> searchSrmExpertGroupProjList(SrmExpertGroupProjExt srmExpertGroupProjExt);
	
	/**
	 * 根据自身条件查询评审设置
	 * @param srmExpertGroupProj
	 * @return
	 */
	public  List<SrmExpertProjEval>  searchSrmExpertGroupProj(SrmExpertProjEval  srmExpertGroupProj);
	
	/**
	 * 根据流水号更新评审设置
	 * @param evalSetFlow
	 */
	public void modExpertGroupProjByFlow(SrmExpertProjEval expertGroupProj);
	
	/**
	 * 根据流水号查询评审设置
	 * @param evalSetFlow
	 * @return
	 */
	public SrmExpertProjEval read(String evalSetFlow);
	
	/**
	 * 取消评审设置
	 * 1：将该评审设置状态标记设置为N
	 * 2:将该评审设置下分配的专家委员记录设置为N
	 * @param expertGroupProj
	 */
	public void cancelEvalSet(SrmExpertProjEval expertGroupProj);
	
	
}
