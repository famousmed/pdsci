package com.pinde.sci.dao.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edc.RandomDrugGroupForm;


public interface EdcRandomRecExtMapper {
	List<RandomDrugGroupForm> searchDurgGroups(String projFlow);


	void updateBlock(Map<String, Object> map);


	void resetBlock(Map<String, Object> map);


	Integer searchMaxVisit(String projFlow);


	Integer searchMaxVisitFollow(Map<String, Object> map);   
}