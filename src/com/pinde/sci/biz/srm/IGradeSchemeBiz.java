package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmGradeScheme;

public interface IGradeSchemeBiz {
	/**
	 * 根据schemeFlow去查
	 * @param schemeFlow
	 * @return
	 */
	public SrmGradeScheme readGradeScheme(String schemeFlow);
	/**
	 * 增加评审信息
	 * @param scheme
	 * @return
	 */
	public int saveGradeScheme(SrmGradeScheme scheme);
	/**
	 * 加载显示全部数据
	 */
	public List<SrmGradeScheme> searchGradeScheme(SrmGradeScheme scheme);
}
