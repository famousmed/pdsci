package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubImpactorFactor;

public interface IImpactorFactorBiz {

	/**
	 * 导入Excel文件
	 * @param fileForm
	 * @param factor
	 */
	void importExcel(PubFileForm fileForm,PubImpactorFactor factor);

	/**
	 * 查询
	 * @param factor
	 * @return
	 */
	List<PubImpactorFactor> queryImpactorFactorList(PubImpactorFactor factor);
	
	/**
	 * 根据ISSN号查询最新的影响因子
	 * @param issn
	 * @return
	 */
	List<PubImpactorFactor> getImpactorFactorByISSN(String issn);


}
