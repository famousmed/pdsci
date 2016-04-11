package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.srm.FundItemInfo;

public interface IFundSchemeDetailBiz {
	/**
	 * ��Ӿ�����
	 * @param schemeFlow
	 * @param itemFlows
	 */
	public void saveFundSchemeDetail(SrmFundSchemeDetail schemeDtl);
	/**
	 * ���»�������
	 * @param fundSchemeDetail
	 * @return
	 */
	public void updateFundSchemeDetail(List<SrmFundSchemeDetail> schemeDtlList);
	/**
	 * ��ѯ��Ӧ�ľ�����Ŀ��Ϣ
	 */
	public List<FundItemInfo> searchFundSchemeDetailInfo(SrmFundSchemeDetail fundSchemeDetail);
	
	/**
	 * ��ѯδ����ľ�����Ŀ
	 */
	public List<FundItemInfo> searchSrmFundItemNotInBySchemeFlow(String schemeFlow);
	
	/**
	 * ��ѯ���ѷ�����������Ŀ--����ά������
	 */
	public List<SrmFundSchemeDetail> searchFundSchemeDetail(SrmFundSchemeDetail fundSchemeDtl);
	
	/**
	 * ����������ѯ
	 * @param fundItemFlow
	 * @return
	 */
	public SrmFundSchemeDetail read(String fundItemFlow);
	/**
	 * ��ѯ���ѷ�����������Ŀ--����Ԥ������
	 */
	public List<SrmFundSchemeDetail> searchFundSchemeDetailSee(SrmFundSchemeDetail fundSchemeDtl);

}
