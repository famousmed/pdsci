package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubPatientAe;

public interface IPubPatientAeBiz {
	/**
	 * 查询
	 * @param patientAe
	 * @return
	 */
	List<PubPatientAe> searchPatientAeList(PubPatientAe patientAe);
	
	/**
	 * 保存
	 * @param patientAe
	 */
	int save(PubPatientAe patientAe);
	
	/**
	 * 读取一条AE
	 * @param recordFlow
	 * @return
	 */
	PubPatientAe readPatientAe(String recordFlow);
	
	/**
	 * 根据projFlowList查询
	 * @param projFlowList
	 * @return
	 */
	List<PubPatientAe> searchSaeList(List<String> projFlowList);

}
