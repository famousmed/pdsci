package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundItem;

public interface IFundItemBiz {
	/**
	 * 根据itemFlow查读数据
	 * @param itemFlow
	 * @return
	 */
	public SrmFundItem readFundItem(String itemFlow);
	/**
	 * 根据参数进行增加或者更新
	 * @param item
	 * @return
	 */
	public int saveFundItem(SrmFundItem item);
	/**
	 * 页面加载数据
	 * @param item
	 * @return
	 */
	public List<SrmFundItem> searchFundItem(SrmFundItem item);
}
