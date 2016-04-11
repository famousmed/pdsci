package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.ProjFundDetailExt;


public interface IPaymentBiz {
	/**
	 * ��ѯ�����б�
	 * @return
	 */
	List<FundInfoExt> queryPaymentList(PubProj proj);
	
	/**
	 * ���ݾ�����ˮ�Ų��ұ�����ϸ
	 * @param fundFlow
	 * @return
	 */
	List<SrmProjFundDetail> getDetailByFundFlow(String fundFlow);

	
	/**
	 * ���汨����ϸ�������
	 * @param fundInfo
	 * @param dList
	 */
	void saveDetailList(String fundFlow,List<SrmProjFundDetail> detailList,SrmFundProcess fundProcess);
	
	/**
	 * ���汨����ϸ
	 * @param fundDetail
	 */
	void reimburse(SrmProjFundDetail fundDetail);
	
	/**
	 * ����schemeFlow����FundSchemeDetail
	 * @param schemeFlow
	 * @return
	 */
	List<SrmFundSchemeDetail> getSchemeDetailBySchemeFlow(String schemeFlow);


	/**
	 * ��ѯ����б�
	 * @return
	 */
	List<ProjFundDetailExt> queryFundDetailAuditList(ProjFundDetailExt fundDetailExt);
	
	/**
	 * 
	 * @param fundFlow
	 * @return
	 */
	SrmProjFundInfo getFundInfoByFundFlow(String fundFlow);
	
	/**
	 * ���ұ�����ϸ
	 * @param fundDetailFlow
	 * @return
	 */
	SrmProjFundDetail getDetailByDetailFlow(String fundDetailFlow);
	
	/**
	 * 
	 * @param fundDetail
	 * @param fundProcess
	 */
	void updateDetailStatus(SrmProjFundDetail fundDetail,SrmFundProcess fundProcess);
	
	/**
	 * ����ʾ�����б�ĵ�ʱ���ѯԤ����
	 * @param fundFlow
	 * @param itemFlow
	 * @return
	 */
	SrmProjFundDetail searchBudgetDetail(String fundFlow , String itemFlow);
	
	/**
	 * ��ѯû�б�ͨ���ľ��������
	 * @param fundDetail
	 * @return
	 */
	int searchFundDetailNoApproveCount(SrmProjFundDetail fundDetail);

	

}
