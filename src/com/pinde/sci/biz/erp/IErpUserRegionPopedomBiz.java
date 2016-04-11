package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpUserRegionPopedom;

public interface IErpUserRegionPopedomBiz {

	/**
	 * 查询人员地区权限
	 * @param regPop
	 * @return
	 */
	public List<ErpUserRegionPopedom> searchRegionPopList(ErpUserRegionPopedom regPop);
}
