package com.pinde.sci.biz.edc;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.form.edc.EdcPatientVisitDataForm;
import com.pinde.sci.model.edc.PatientVisitForm;
import com.pinde.sci.model.mo.EdcPatientVisit;
import com.pinde.sci.model.mo.EdcPatientVisitData;
import com.pinde.sci.model.mo.EdcPatientVisitDataExample;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientVisit;
import com.pinde.sci.model.mo.PubPatientVisitExample;



public interface IInputBiz {
 
	EdcProjParam readProjParam(String projFlow);

	Map<String,Map<String,PatientVisitForm>>  searchPatientVisitMap(String projFlow, String orgFlow);

	PubPatientVisit readPatientVisit(String projFlow, String visitFlow,
			String patientFlow);

	PubPatient readPatient(String patientFlow);

	EdcVisit readVisit(String visitFlow);
 
	void modifyPatientVisit(PubPatientVisit pateintVisit);

	void addPatientVisit(PubPatientVisit pateintVisit,EdcPatientVisit edcPatientVisit);

	List<EdcPatientVisitData> searchPatientVisitData(String recordFlow,String attrCode,String elementSerialSeq);

	void modifyPatientVisit(EdcPatientVisit pateintVisit, boolean isOper1);
	
	void modifyPatientVisit(EdcPatientVisit pateintVisit, EdcPatientVisitData visitData);

	void addPatientVisit(PubPatientVisit pateintVisit,EdcPatientVisit edcPatientVisit, EdcPatientVisitData data);

	void addVisitData(EdcPatientVisitData data);

	void modifyVisitData(EdcPatientVisitData data);
  
	List<EdcPatientVisitData> searchPatientVisitData(String recordFlow);

	void delVisitData(String recordFlow, String elementCode, 
			String elementSerialSeq);

	List<PubPatientVisit> searchPatientVisit(PubPatientVisitExample example);

	List<PubPatientVisit> searchPatientVisit(String projFlow, String orgFlow,String patientFlow);

	EdcPatientVisit readEdcPatientVisit(String recordFlow);

	void addEdcPatientVisit(EdcPatientVisit visit); 

	void modifyEdcPatientVisit(EdcPatientVisit edcPatientVisit);

	void addPatientVisit(PubPatientVisit pateintVisit);

	List<EdcPatientVisitData> searchPatientVisitData(
			EdcPatientVisitDataExample dataExample);

	List<PubPatient> searPatientList(String projFlow);

	PatientVisitForm selectPatientVisit(String recordFlow);

	EdcPatientVisitData readEdcPatientVisitData(String recordFlow);


	Map<String, PatientVisitForm> getPatientSubmitVisitMap(String projFlow,
			String patientFlow); 

	Map<String, Map<String, Map<String, EdcPatientVisitData>>> getelementSerialSeqValueMap(
			String recordFlow);

	List<EdcPatientVisitDataForm> searchVisitDataFormList(
			Map<String, String> conditionMap);

	List<PubPatientVisit> searchPatientVisit(String projFlow, String orgFlow);

	Map<String, String> searchEdcPatientVistMap(String projFlow);

	void uploadPatientVisitFile( PubPatientVisit pateintVisit, String filetype,MultipartFile file);

	String createVisitInfoXml(String visitInfo, String string,
			String value,String attr,boolean isSingle);

	Map<String, Object> createVisitInfoMap(String visitInfo);

	void delRecipeFile(PubPatientVisit pateintVisit,String type, String url);


}   
  