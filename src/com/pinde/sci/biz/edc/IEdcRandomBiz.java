package com.pinde.sci.biz.edc;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edc.RandomDrugGroupForm;
import com.pinde.sci.model.edc.RandomInfo;
import com.pinde.sci.model.mo.EdcProjOrg;
import com.pinde.sci.model.mo.EdcProjParam;
import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.EdcRandomRecExample;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubFileForm;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubPatientIe;
import com.pinde.sci.model.mo.SysUser;

public interface IEdcRandomBiz {

	EdcProjParam readProjParam(String projFlow);

	void addRandomFile(EdcProjParam projParam, PubFileForm fileForm,String projFlow);

	Map<String, EdcRandomRec> getPatientRandomMap(String projFlow,String orgFlow);

	String assign(Map<String,String> ieValueMap,EdcProjParam projParam,String assignLabel, PubPatient currPatient, String layerFactors,String assignTypeId
			,SysUser assignUser);
 
	void modify(EdcProjParam param);

	void addProjParam(EdcProjParam param);

	List<EdcRandomRec> searchPatientRandomRec(
			String patientFlow);

	RandomInfo getRandomInfo(String patientFlow);

	Map<String, String> getOrgAssignDateMap(String projFlow);

	List<EdcRandomRec> searchRandomRecList(EdcRandomRecExample example);
 
	int modifyEdcRandomRec(EdcRandomRec randomRec);

	EdcProjOrg readEdcProjParam(String projFlow, String orgFlow);

	void addEdcProjOrg(EdcProjOrg epo);

	void modifyEdcProjOrg(EdcProjOrg epo);

	Map<String, EdcProjOrg> getEdcPropOrgMap(String projFlow);

	Integer countAssign(String projFlow);

	List<GcpDrugStoreRec> searchDrugAssignRec(String projFlow,String orgFlow);

	GcpDrugStoreRec readGcpDrugStoreRec(String recFlow);

	void modifyGcpDrugStoreRec(GcpDrugStoreRec rec);

	void modifyEdcRandomRecForCancle(EdcRandomRec randomRec);

	Map<String,String> getRandomInfo(String projFlow,
			String orgFlow);

	int savePatientIe(String patientFlow,Map<String,String> ieValueMap);

	PubPatientIe readPubPatientIe(String patientFlow);

	Map<String, String> getPatientIeMap(String patientFlow);

	Map<String,Object> getOrgAssignMap(String projFlow,String orgFlow);

	Integer countPatient(String projFlow, String orgFlow);

	Map<String, List<PubPatient>> getOrgCount(String projFlow,
			String patientStageId);

	List<RandomDrugGroupForm> searchDurgGroups(String projFlow);

	List<EdcRandomRec> searchPatientRandom(String projFlow, String orgFlow);

	EdcRandomRec readEdcRandomRec(String recFlow);

	GcpDrugStoreRec seachGcpDrugStoreRec(String patientFlow, String drugPack);

	String searchPatientDrugGroup(String patientFlow);

	List<EdcRandomRec> searchRandomRec(EdcRandomRecExample example);

	void resetBlock(EdcRandomRec rec);

	List<EdcRandomRec> searchRandomRec(List<String> patientFlows);

	List<GcpDrugStoreRec> searchDrugStoreList(String projFlow, String orgFlow);

	Integer countAssignDrug(String projFlow, String orgFlow);

	Integer countUnAssignDrug(String projFlow, String orgFlow);

	Integer searchMaxVisit(String projFlow);

	Integer searchMaxVisitFollow(String projFlow, int i);
	  
} 
