package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmGradeScheme;

public interface IGradeSchemeBiz {
	/**
	 * ����schemeFlowȥ��
	 * @param schemeFlow
	 * @return
	 */
	public SrmGradeScheme readGradeScheme(String schemeFlow);
	/**
	 * ����������Ϣ
	 * @param scheme
	 * @return
	 */
	public int saveGradeScheme(SrmGradeScheme scheme);
	/**
	 * ������ʾȫ������
	 */
	public List<SrmGradeScheme> searchGradeScheme(SrmGradeScheme scheme);
}
