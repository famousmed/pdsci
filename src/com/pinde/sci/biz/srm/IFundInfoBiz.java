package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.srm.PubProjExt;

public interface IFundInfoBiz {

	public List<SrmProjFundInfo> searchFundInfo(SrmProjFundInfo fundInfo);
	
	public void saveFundInfo(SrmProjFundInfo fundInfo,List<SrmProjFundDetail> fundDtlList,SrmFundProcess process);

	/**
	 * ≤È—Ø‘§À„…Û∫À¡–±Ì
	 * @param projExt
	 * @return
	 */
	public List<PubProjExt> searchBudgetAuditList(PubProjExt projExt);
	
	public void updateFundInfoStatus(SrmProjFundInfo fundInfo,SrmFundProcess process);
	
	public SrmProjFundInfo getFundInfoByFlow(String fundFlow);
	
	/**
	 * ‘§À„…Û∫À
	 */
	public void budgetAudit(SrmProjFundInfo fundInfo,SrmFundProcess process);
	
}
