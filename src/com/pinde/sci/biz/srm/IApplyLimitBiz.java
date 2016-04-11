package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.form.srm.ApplyLimitNumForm;
import com.pinde.sci.model.mo.SrmApplyLimit;

public interface IApplyLimitBiz {
	
	/**
	 * 保存机构限报
	 * @param applyLimitList
	 * @return
	 */
	int saveApplyLimitList(List<SrmApplyLimit> applyLimitList);
	
	/**
	 * 保存SrmApplyLimit
	 * @param applyLimit
	 * @return
	 */
	int saveApplyLimit(SrmApplyLimit applyLimit);

	/**
	 * 查询机构限报
	 * @param applyLimit
	 * @return
	 */
	List<SrmApplyLimit> searchApplyLimitList(SrmApplyLimit applyLimit);

	/**
	 * 检查机构限报
	 * @param projListScope
	 * @param agreeFlag
	 * @param projFlow
	 * @return
	 */
	ApplyLimitNumForm checkApplyLimit(String projListScope, String agreeFlag, String projFlow);

}
