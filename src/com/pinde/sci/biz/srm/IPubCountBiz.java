package com.pinde.sci.biz.srm;


import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubProjCountExt;
import com.pinde.sci.model.srm.SrmAchCountExt;

public interface IPubCountBiz {
    
	/**
	 * 卫生局待办事项统计
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjGlobal(SysOrg org);
	/**
	 * 主管部门待办事项统计
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjCharge(SysOrg org);
	/**
	 * 医院待办事项统计
	 * @param org
	 * @return
	 */
	public List<Map<String, Integer>> selectCountProjLocal(SysOrg org);
	/**
	 * 医院待审核成果统计
	 * @param org
	 * @return
	 */
	public Map<String,Integer> selectCountSrmAchLocal(SysOrg org);
	
	/**
	 * 根据该单位的流水号查询该单位下参加立项评审的项目的总数
	 * @return
	 */
	public int selectProjInExpertAll();
	/**
	 * 根据该单位的流水号查询该单位下立项通过的项目的总数
	 * @return
	 */
	public int selectProjApproveAll();
	/**
	 * 根据该单位的流水号查询该单位下立项不通过的项目的总数
	 * @return
	 */
	public int selectProjNotApproveAll();
	/**
	 * 根据该单位的流水号查询该单位下通过申报审核的项目的总数
	 * @return
	 */
	public int selectProjApply();
	/**
	 * 根据该单位的流水号查询该单位下通过验收报告审核的项目总数
	 * @return
	 */
	public int selectProjComplete();
	/**
	 * 根据该单位的流水号查询该单位下一级所有单位分别承担的项目数
	 * @return
	 */
	public List<PubProjCountExt> selectProjGroupByOrg();
	/**
	 * 根据该单位的流水号查询该单位下一级所有单位分别承担的成果种类及数量
	 * @return
	 */
	public List<SrmAchCountExt> selectSrmAchByOrg();
	/**
	 * 根据该单位的流水号查询该单位下一集所有单位承担某一种成果的数量
	 * @param table
	 * @param tableName
	 * @return
	 */
	public List<SrmAchCountExt> selectSrmAchByTypeId(String table,String tableName,Boolean sumFlag);
    /**
     * 查询当前登录者所属机构下属所有重点人才的记录
     * @param aidTalents
     * @return
     */
    public List<AidTalents> selectAidTalentsByOrg(AidTalents aidTalents);
    /**
     * 查询当前登录者所属机构下待审核的人员
     * @param sysUser
     * @return
     */
    public List<SysUser> selectRegedUser(SysUser sysUser);
    
    /**
     * 院版查询待预算审核的项目数量
     * @return
     */
    public Integer findDealBudgetAuditProjCount();
    
    /**
     * 院版查询待报销审核的数量
     * @return
     */
    public Integer findDealPaymentAuditCount();
}
