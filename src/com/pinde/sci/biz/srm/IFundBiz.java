package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.FundSum;

/**
 *项目经费
 */
public interface IFundBiz {
	/**
	 * 经费列表
	 * @param proj
	 * @return
	 */
	public List<FundInfoExt> getList(PubProj proj);
	/**
	 * 经费明细
	 * @param fundFlow
	 * @return
	 */
	public List<SrmProjFundDetail> getDetails(String fundFlow);
	/**
	 * 保存经费明细
	 * @param detail
	 * @return
	 */
	public void saveDetail(SrmProjFundDetail detail );
	/**
	 * 获取经费
	 * @param fundFlow 经费流水号
	 * @return
	 */
	public SrmProjFundInfo getFund(String fundFlow);
	/**
	 * 计算经费总计
	 * @param list 经费列表
	 * @return
	 */
	public FundSum getFundSum(List<FundInfoExt> list);
	/**
	 * 获取经费扩展
	 * @param fundFlow 经费流水号
	 * @return
	 */
	public FundInfoExt getFundExt(String fundFlow);
	
	/**
	 * 根据经费明细流水号删除该经费明细，
	 * 同时更新实际到账金额， 到账余额 ，根据到账类型决定更新下拨实际到账总额或配套实际到账总额
	 * @param fundDetailFlow
	 */
	public void delDetailByFundDetailFlow(String fundDetailFlow);
	
}
