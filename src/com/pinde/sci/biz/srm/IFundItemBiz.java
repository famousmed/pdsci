package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundItem;

public interface IFundItemBiz {
	/**
	 * ����itemFlow�������
	 * @param itemFlow
	 * @return
	 */
	public SrmFundItem readFundItem(String itemFlow);
	/**
	 * ���ݲ����������ӻ��߸���
	 * @param item
	 * @return
	 */
	public int saveFundItem(SrmFundItem item);
	/**
	 * ҳ���������
	 * @param item
	 * @return
	 */
	public List<SrmFundItem> searchFundItem(SrmFundItem item);
}
