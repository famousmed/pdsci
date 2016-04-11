package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.srm.FundItemInfo;

public interface IFundSchemeDetailBiz {
	/**
	 * 添加经费项
	 * @param schemeFlow
	 * @param itemFlows
	 */
	public void saveFundSchemeDetail(SrmFundSchemeDetail schemeDtl);
	/**
	 * 更新或者增加
	 * @param fundSchemeDetail
	 * @return
	 */
	public void updateFundSchemeDetail(List<SrmFundSchemeDetail> schemeDtlList);
	/**
	 * 查询对应的经费项目信息
	 */
	public List<FundItemInfo> searchFundSchemeDetailInfo(SrmFundSchemeDetail fundSchemeDetail);
	
	/**
	 * 查询未加入的经费项目
	 */
	public List<FundItemInfo> searchSrmFundItemNotInBySchemeFlow(String schemeFlow);
	
	/**
	 * 查询经费方案包含的项目--方案维护适用
	 */
	public List<SrmFundSchemeDetail> searchFundSchemeDetail(SrmFundSchemeDetail fundSchemeDtl);
	
	/**
	 * 根据主键查询
	 * @param fundItemFlow
	 * @return
	 */
	public SrmFundSchemeDetail read(String fundItemFlow);
	/**
	 * 查询经费方案包含的项目--申请预算适用
	 */
	public List<SrmFundSchemeDetail> searchFundSchemeDetailSee(SrmFundSchemeDetail fundSchemeDtl);

}
