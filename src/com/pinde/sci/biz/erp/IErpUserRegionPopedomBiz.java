package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpUserRegionPopedom;

public interface IErpUserRegionPopedomBiz {

	/**
	 * ��ѯ��Ա����Ȩ��
	 * @param regPop
	 * @return
	 */
	public List<ErpUserRegionPopedom> searchRegionPopList(ErpUserRegionPopedom regPop);
}
