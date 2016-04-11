package com.pinde.sci.biz.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcNormalValueExample;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.PubFileForm;

public interface IEdcNormalValueBiz {

	Map<String, List<EdcNormalValue>> getNormalValueMap(String projFlow,
			String orgFlow);

	String addNormalValue(EdcNormalValue normalValue);

	void modifyNormalValue(EdcNormalValue normalValue);

	EdcNormalValue readNormalValue(String recordFlow);

	void copyRecord(EdcNormalValue normalValue);

	void delRecord(EdcNormalValue normalValue);

	void lockNormalValue(String projFlow, String orgFlow);

	EdcProjOrg searchEdcProjOrg(String projFlow, String orgFlow);

	void addNormalValueFile(String projFlow,String orgFlow,PubFileForm fileForm);
	void updateNormalValueFile(String projFlow,String orgFlow,PubFileForm fileForm);

	void unLockNormalValue(EdcProjOrg projOrg);


	List<EdcNormalValue> searchEdcNormalValue(EdcNormalValueExample example);

	EdcProjParam readProjParam(String projFlow);

	List<EdcNormalValue> searchNormalValue(String projFlow, String orgFlow);

}  
  