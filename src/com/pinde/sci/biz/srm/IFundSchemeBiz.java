package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmProjFundInfo;

public interface IFundSchemeBiz {
	/**
	 * 根据schemeFlow查读数据
	 * @param schemeFlow
	 * @return
	 */
	public SrmFundScheme readFundScheme(String schemeFlow);
	/**
	 * 据参数进行增加或者更新
	 * @param scheme
	 * @return
	 */
	public int saveFundScheme(SrmFundScheme scheme);
	/**
	 * 查看所有方案
	 * @param scheme
	 * @return
	 */
	public List<SrmFundScheme> searchFundScheme(SrmFundScheme scheme);
	/**
	 * 查询一个项目来源下是否已经有启动的方案
	 * @param scheme
	 * @return
	 */
	public List<SrmFundScheme> searchStartScheme(String projTypeId);
	/**
	 * 删除方案信息
	 * @param scheme
	 * @return
	 */
	public int deleteFundScheme(SrmFundScheme scheme);
	/**
	 * 查询申请了预算的项目信息
	 * @param projFundInfo
	 * @return
	 */
	public List<SrmProjFundInfo> searchProjFundInfo(SrmProjFundInfo projFundInfo);
}
