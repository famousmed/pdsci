package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.srm.ProjFundDetailExt;

public interface IFundInfoDetailBiz {

	
	public List<SrmProjFundDetail> searchFundDetail(SrmProjFundDetail fundDtl);
	
	public void saveFundDetail(SrmProjFundDetail fundDtl);
	
	public void updateFundDetail(SrmProjFundDetail fundDtl);
	
	public int deleteFundDetail(String fundDetailFlow);
	public int updateRecordStatusByFundFlow(String fundFlow,String recordStatus);
	/**
	 * 获取经费明细扩展
	 * @param fundDetailFlow
	 * @return
	 */
	public ProjFundDetailExt selectProjFundDetailExt(String fundDetailFlow);
}
