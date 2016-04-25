package com.pinde.sci.biz.pub;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientExample;
import com.pinde.sci.model.mo.PubPatientVisit;

public interface IPubPatientBiz {
	List<PubPatient> searchPatient(PubPatientExample example);

	PubPatient readPatient(String patientFlow);

	List<PubPatient> searchPatientByProjFlow(String projFlow);

	void addPatient(String projFlow, String orgFlow, String patientType, String code,Integer seq,boolean isRandom);

	List<PubPatient> searchPatient(String projFlow, String orgFlow);

	void modifyPatient(PubPatient patient);

	void disPatient(String projFlow, String orgFlow, String patientType);

	void disPatient(String projFlow, String orgFlow, String patientType, String code);

	PubPatient readPatient(String projFlow, String orgFlow, String patientType, String code);

	Integer getPatientMaxCount(String projFlow);

	int count(PubPatientExample example);

	void resetPatient(PubPatient patient);

	List<PubPatient> getUnAssignPatientList(String projFlow,String orgFlow);

	List<PubPatient> searchAssignPatientByProjFlow(String projFlow,String orgFlow);

	List<PubPatient> searchIndatePatientByProjFlow(String projFlow);

	Map<String, String> getOrgInDateMap(String projFlow);

	Map<String, String> searchMaxVisitDateMap(String projFlow, String orgFlow, String patientStage);
	int count(PubPatient pubPatient);
	List<PubPatient> searchPatient(PubPatient patient);

	int savePubPatient(PubPatient patient, String in, String ex);

	List<PubPatient> searchPatientByGroup(String projFlow, String orgFlow, boolean isRandom, String groupName);

	List<PubPatient> searchAssignPatientByGroup(String projFlow, String orgFlow, String groupName);

	int countPatient(PubPatient pubPatient);

	int savePatient(PubPatient patient);

	List<PubPatient> searchPatientNotFilter(String projFlow, String orgFlow);
	
	List<PubPatient> searchPatientList(PubPatient patient);
	
	List<GcpDrugStoreRec> searchGcpDrugStoreRecList(GcpDrugStoreRec drugStoreRec);
	
	List<PubPatient> searchPatientStageList(List<String> projFlowList);

	List<PubPatient> searchPatientByProjFlow(String projFlow, String patientType,String sort);

	List<PubPatient> searchAllPatients(String projFlow);

	int createPatientWindow(String patientFlow);

	List<PubPatientVisit> searchPatientVisit(String projFlow, String orgFlow,
			String patientStage);

	int savePubPatient(PubPatient patient);

	List<PubPatient> searchPatientList(List<String> patientFlows);

	PubPatient searchMaxInDatePatient(String projFlow, String orgFlow);

	PubPatient readPatientByCode(String projFlow, String patientCode);

	List<PubPatient> searchPatientExt(PubPatient patient);

}  
  