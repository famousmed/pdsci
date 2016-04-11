package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edc.EdcVisitForm;
import com.pinde.sci.model.mo.EdcVisit;



public interface EdcVisitExtMapper {
	List<EdcVisit> searchVisitsByGroupFlow(Map<String,Object> paramMap);

	List<EdcVisitForm> searchVisitsByModuleCode(Map<String, Object> paramMap);

	List<EdcVisitForm> searchVisitsByElementCode(Map<String, Object> paramMap); 
}