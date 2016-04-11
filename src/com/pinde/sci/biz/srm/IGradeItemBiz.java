package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmGradeItem;

public interface IGradeItemBiz {
	/**
	 * ����scheme��ѯ
	 * @param schemeFlow
	 * @return
	 */
	public SrmGradeItem readGradeItem(String schemeFlow); 
	/**
	 * ���ݲ����������ӻ��߸���
	 * @param item
	 * @return
	 */
	public int saveGradeItem(SrmGradeItem item);
	/**
	 * ҳ���������
	 * @param item
	 * @return
	 */
	public List<SrmGradeItem> searchGradeItem(SrmGradeItem item);
	
}
