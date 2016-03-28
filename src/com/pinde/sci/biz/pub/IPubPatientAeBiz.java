package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubPatientAe;

public interface IPubPatientAeBiz {
	/**
	 * ��ѯ
	 * @param patientAe
	 * @return
	 */
	List<PubPatientAe> searchPatientAeList(PubPatientAe patientAe);
	
	/**
	 * ����
	 * @param patientAe
	 */
	int save(PubPatientAe patientAe);
	
	/**
	 * ��ȡһ��AE
	 * @param recordFlow
	 * @return
	 */
	PubPatientAe readPatientAe(String recordFlow);
	
	/**
	 * ����projFlowList��ѯ
	 * @param projFlowList
	 * @return
	 */
	List<PubPatientAe> searchSaeList(List<String> projFlowList);

}
