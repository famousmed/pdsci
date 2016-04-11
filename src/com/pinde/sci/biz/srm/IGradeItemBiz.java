package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmGradeItem;

public interface IGradeItemBiz {
	/**
	 * 根据scheme查询
	 * @param schemeFlow
	 * @return
	 */
	public SrmGradeItem readGradeItem(String schemeFlow); 
	/**
	 * 根据参数进行增加或者更新
	 * @param item
	 * @return
	 */
	public int saveGradeItem(SrmGradeItem item);
	/**
	 * 页面加载数据
	 * @param item
	 * @return
	 */
	public List<SrmGradeItem> searchGradeItem(SrmGradeItem item);
	
}
