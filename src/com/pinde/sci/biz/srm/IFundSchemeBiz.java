package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmProjFundInfo;

public interface IFundSchemeBiz {
	/**
	 * ����schemeFlow�������
	 * @param schemeFlow
	 * @return
	 */
	public SrmFundScheme readFundScheme(String schemeFlow);
	/**
	 * �ݲ����������ӻ��߸���
	 * @param scheme
	 * @return
	 */
	public int saveFundScheme(SrmFundScheme scheme);
	/**
	 * �鿴���з���
	 * @param scheme
	 * @return
	 */
	public List<SrmFundScheme> searchFundScheme(SrmFundScheme scheme);
	/**
	 * ��ѯһ����Ŀ��Դ���Ƿ��Ѿ��������ķ���
	 * @param scheme
	 * @return
	 */
	public List<SrmFundScheme> searchStartScheme(String projTypeId);
	/**
	 * ɾ��������Ϣ
	 * @param scheme
	 * @return
	 */
	public int deleteFundScheme(SrmFundScheme scheme);
	/**
	 * ��ѯ������Ԥ�����Ŀ��Ϣ
	 * @param projFundInfo
	 * @return
	 */
	public List<SrmProjFundInfo> searchProjFundInfo(SrmProjFundInfo projFundInfo);
}
