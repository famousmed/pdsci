package com.pinde.sci.dao.edc;

import java.util.List;

import com.pinde.sci.model.mo.EdcPatientVisit;



public interface EdcPatientVisitExtMapper {
	List<EdcPatientVisit> searchEdcPatientVisitList(String param1, 
			String param2); 
	String searchSdvStatus(String param1, 
			String param2,String param3);
	String searchEdcPatientVistMap(String param1, String param2, String param3); 
}