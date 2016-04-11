package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.ProjFundDetailExt;


public interface IPaymentBiz {
	/**
	 * 查询报销列表
	 * @return
	 */
	List<FundInfoExt> queryPaymentList(PubProj proj);
	
	/**
	 * 根据经费流水号查找报销明细
	 * @param fundFlow
	 * @return
	 */
	List<SrmProjFundDetail> getDetailByFundFlow(String fundFlow);

	
	/**
	 * 保存报销明细（多个）
	 * @param fundInfo
	 * @param dList
	 */
	void saveDetailList(String fundFlow,List<SrmProjFundDetail> detailList,SrmFundProcess fundProcess);
	
	/**
	 * 保存报销明细
	 * @param fundDetail
	 */
	void reimburse(SrmProjFundDetail fundDetail);
	
	/**
	 * 根据schemeFlow查找FundSchemeDetail
	 * @param schemeFlow
	 * @return
	 */
	List<SrmFundSchemeDetail> getSchemeDetailBySchemeFlow(String schemeFlow);


	/**
	 * 查询审核列表
	 * @return
	 */
	List<ProjFundDetailExt> queryFundDetailAuditList(ProjFundDetailExt fundDetailExt);
	
	/**
	 * 
	 * @param fundFlow
	 * @return
	 */
	SrmProjFundInfo getFundInfoByFundFlow(String fundFlow);
	
	/**
	 * 查找报销明细
	 * @param fundDetailFlow
	 * @return
	 */
	SrmProjFundDetail getDetailByDetailFlow(String fundDetailFlow);
	
	/**
	 * 
	 * @param fundDetail
	 * @param fundProcess
	 */
	void updateDetailStatus(SrmProjFundDetail fundDetail,SrmFundProcess fundProcess);
	
	/**
	 * 在显示报销列表的的时候查询预算金额
	 * @param fundFlow
	 * @param itemFlow
	 * @return
	 */
	SrmProjFundDetail searchBudgetDetail(String fundFlow , String itemFlow);
	
	/**
	 * 查询没有被通过的经费项个数
	 * @param fundDetail
	 * @return
	 */
	int searchFundDetailNoApproveCount(SrmProjFundDetail fundDetail);

	

}
