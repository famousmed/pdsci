package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edc.RandomMinMaxAssignForm;


public interface GcpDrugStoreRecExtMapper {
	List<RandomMinMaxAssignForm> selectAssignDate(String projFlow); 
	Integer selectMaxOrd(Map<String,String> drugStoreRec);
}