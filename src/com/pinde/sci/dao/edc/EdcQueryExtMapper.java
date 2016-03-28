package com.pinde.sci.dao.edc;

import java.util.List;

import com.pinde.sci.model.mo.EdcQuery;



public interface EdcQueryExtMapper {

	List<EdcQuery> searchUnSolveSdvQuery(String dataRecordFlow);


}