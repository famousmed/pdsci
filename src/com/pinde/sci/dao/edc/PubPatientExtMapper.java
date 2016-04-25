package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edc.PatientMinMaxIndateForm;
import com.pinde.sci.model.mo.PubPatient;


public interface PubPatientExtMapper {
	List<PatientMinMaxIndateForm> selectInDate(String projFlow);

	List<PubPatient> searchPatientByGroup(Map<String, Object> paramMap);

	List<PubPatient> searchAssignPatientByGroup(Map<String, Object> paramMap); 
	
	List<PubPatient> searchPatient(Map<String, Object> paramMap);
}