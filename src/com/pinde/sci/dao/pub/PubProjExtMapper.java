package com.pinde.sci.dao.pub;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.PubProjExt;
import com.pinde.sci.model.srm.ReportForm;

/**
 * proj扩展mapper
 * @author Administrator
 *
 */
public interface PubProjExtMapper {

	/**
	 * 根据proj自身条件查询主管部门下的所有项目
	 * @param proj
	 * @return
	 */
	public List<PubProj> selectChargeProjList(PubProj proj , String chargeOrgFlow);
	
	public List<PubProj> selectChargeProj(Map<String, Object> paramMap);

	public List<PubProj> searchProjByProjFlows(String projFlows);
  
	public List<PubProj> searchProjByProjFlows(List<String> projFlows);

	public List<PubProj> selectLocalProj(Map<String, Object> paramMap); 
	
	public List<PubProj> selectGlobalProj(Map<String, Object> paramMap); 
	
	/**
	 * 查询申报审核的项目列表
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectApplyAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * 查询合同审核的项目列表
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectContractAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * 查询进展阶段审核的项目表
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectSchduleAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * 查询完成阶段审核的项目表
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectCompleteAduitProjList(Map<String , Object> paramMap);
	
	/**
	 * 查询项目列表通用方法(当前机构管理下所有的项目  ， 关联rec要求指定rectype)
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectProjList(Map<String , Object> paramMap);
	
	/**
	 * 立项审核查询
	 * @param projExt
	 * @return
	 */
	public List<PubProjExt> selectEvaluationProjList(PubProjExt projExt);
	
	/**
	 * 项目查询通用方法(当前机构管理下所有的项目)
	 * @param proj
	 * @return
	 */
	public List<PubProj> selectCommonProjList(PubProj proj);
	
	/**
	 * 查询可以下拨的项目列表
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> selectProjListForFundPlan(Map<Object , Object> paramMap);
	/**
	 * 统计除预算审核以外的其他待办事项
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountProj(Map<String,Object> paramMap);
	/**
	 * 统计待审核的预算
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountProjFund(Map<String,Object> paramMap);
	/**
	 * 统计待审核的成果
	 * @param paramMap
	 * @return
	 */
	public Integer selectCountSrmAch(Map<String,Object> paramMap);
	
	/**
	 * 按单位流水号查询该单位下参加立项评审的项目数量
	 * @return
	 */
	public List<PubProjCountExt> selectProjCountInExpert(@Param(value="orgFlow") String orgFlow);
	
	/**
	 * 按单位流水号查询该单位下与阶段状态相关的项目数量
	 * @param orgFlow
	 * @return
	 */
	public List<PubProjCountExt> selectRoundStageStatus(HashMap<String,String> map);
	
	public List<PubProjCountExt> selectProjDirect(HashMap<String,String> map);
	
	public Integer selectCountProjFundDown(Map<String,Object> paramMap);
	
	public List<PubProj> selectList(PubProjExt projExt);
	
	public List<PubProj> selectTerminateProj(Map<String,String> terminateId);
	
	/**
	 * 报表查询
	 * @param proj
	 * @return
	 */
	public List<ReportForm> selectReportFormData(Map<String,Object> paramMap);
	
	/**
	 * 根据申请机构分组 查询指定条件下的 所有机构拥有的项目数量
	 * @param paramMap
	 * @return
	 */
	public List<Map<String , String>> selectOrgHavingProjCount(Map<String , Object> paramMap);

	/**
	 * 查询已申报单位审核通过项目
	 * @param paramMap
	 * @return
	 */
	public int searchAuditCount(Map<String, Object> paramMap);
	
} 
