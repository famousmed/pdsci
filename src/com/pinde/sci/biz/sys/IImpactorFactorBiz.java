package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubImpactorFactor;

public interface IImpactorFactorBiz {

	/**
	 * ����Excel�ļ�
	 * @param fileForm
	 * @param factor
	 */
	void importExcel(PubFileForm fileForm,PubImpactorFactor factor);

	/**
	 * ��ѯ
	 * @param factor
	 * @return
	 */
	List<PubImpactorFactor> queryImpactorFactorList(PubImpactorFactor factor);
	
	/**
	 * ����ISSN�Ų�ѯ���µ�Ӱ������
	 * @param issn
	 * @return
	 */
	List<PubImpactorFactor> getImpactorFactorByISSN(String issn);


}
