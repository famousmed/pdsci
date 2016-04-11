package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.FundSum;

/**
 *��Ŀ����
 */
public interface IFundBiz {
	/**
	 * �����б�
	 * @param proj
	 * @return
	 */
	public List<FundInfoExt> getList(PubProj proj);
	/**
	 * ������ϸ
	 * @param fundFlow
	 * @return
	 */
	public List<SrmProjFundDetail> getDetails(String fundFlow);
	/**
	 * ���澭����ϸ
	 * @param detail
	 * @return
	 */
	public void saveDetail(SrmProjFundDetail detail );
	/**
	 * ��ȡ����
	 * @param fundFlow ������ˮ��
	 * @return
	 */
	public SrmProjFundInfo getFund(String fundFlow);
	/**
	 * ���㾭���ܼ�
	 * @param list �����б�
	 * @return
	 */
	public FundSum getFundSum(List<FundInfoExt> list);
	/**
	 * ��ȡ������չ
	 * @param fundFlow ������ˮ��
	 * @return
	 */
	public FundInfoExt getFundExt(String fundFlow);
	
	/**
	 * ���ݾ�����ϸ��ˮ��ɾ���þ�����ϸ��
	 * ͬʱ����ʵ�ʵ��˽� ������� �����ݵ������;��������²�ʵ�ʵ����ܶ������ʵ�ʵ����ܶ�
	 * @param fundDetailFlow
	 */
	public void delDetailByFundDetailFlow(String fundDetailFlow);
	
}
