package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edc.EdcPatientVisitDataForm;
import com.pinde.sci.form.edc.ElementSerialSeqForm;
import com.pinde.sci.model.mo.EdcPatientVisitData;



public interface EdcPatientVisitDataExtMapper {

	void modifyPatientVisitDataValue1(Map<String,String> paramMap); 
	void modifyPatientVisitDataValue2(Map<String,String> paramMap); 
	List<ElementSerialSeqForm> selectSeq(Map<String,String> map);
	List<EdcPatientVisitDataForm> searchVisitDataReport(Map<String,String> map);
	List<EdcPatientVisitData> searchVisitDataDistinct(Map<String,String> map);
}