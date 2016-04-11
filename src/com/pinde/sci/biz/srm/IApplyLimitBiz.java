package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.form.srm.ApplyLimitNumForm;
import com.pinde.sci.model.mo.SrmApplyLimit;

public interface IApplyLimitBiz {
	
	/**
	 * ��������ޱ�
	 * @param applyLimitList
	 * @return
	 */
	int saveApplyLimitList(List<SrmApplyLimit> applyLimitList);
	
	/**
	 * ����SrmApplyLimit
	 * @param applyLimit
	 * @return
	 */
	int saveApplyLimit(SrmApplyLimit applyLimit);

	/**
	 * ��ѯ�����ޱ�
	 * @param applyLimit
	 * @return
	 */
	List<SrmApplyLimit> searchApplyLimitList(SrmApplyLimit applyLimit);

	/**
	 * �������ޱ�
	 * @param projListScope
	 * @param agreeFlag
	 * @param projFlow
	 * @return
	 */
	ApplyLimitNumForm checkApplyLimit(String projListScope, String agreeFlag, String projFlow);

}
