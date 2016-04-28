package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.gcp.GcpDrugExt;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugIn;
import com.pinde.sci.model.mo.GcpDrugOut;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubProj;

public interface IGcpDrugBiz {
	
	/**
	 * ����ҩ����Ϣ
	 * @param gcpDrug
	 * @return
	 */
	int saveDrugInfo(GcpDrug gcpDrug);
	/**
	 * ɾ��ҩ����Ϣ
	 * @param drugFlow
	 * @return
	 */
	int deleteDrugInfo(String drugFlow);
	/**
	 * ��ȡһ��ҩƷ����ϸ��Ϣ
	 * @param drugFlow
	 * @return
	 */
	GcpDrug readDrugInfo(String drugFlow);
	/**
	 * ��ѯҩ����Ϣ�б�
	 * @param gcpDrug
	 * @param proj
	 * @return
	 */
	List<GcpDrugExt> searchDrugList(GcpDrug gcpDrug,PubProj proj);
    /**
     * ��ѯҩ�������Ϣ
     * @param gcpDrugIn
     * @return
     */
	List<GcpDrugIn> searchDrugInList(GcpDrugIn gcpDrugIn);
	/**
	 * ����ҩ�������Ϣ
	 * @param gcpDrugIn
	 * @return
	 */
	int saveDrugIn(GcpDrugIn gcpDrugIn, List<String> drugPacks);
	/**
	 * ��ȡһ������¼����ϸ��Ϣ
	 * @param recordFlow
	 * @return
	 */
	GcpDrugIn readDrugIn(String recordFlow);
	/**
	 * ɾ��ҩ�������Ϣ
	 * @param drugFlow
	 * @return
	 */
	int deleteDrugIn(String drugFlow);
	List<GcpDrugStoreRec> searchDrugStoreRecByPacks(String projFlow, String orgFlow,
			String drugFlow,List<String> packs,String drugStatusId);
	int getMaxOrdinal(String orgFlow, String projFlow, String drugFlow);
	int editDrugStoreRec(GcpDrugStoreRec drugStoreRec);
	List<GcpDrug> searchDrugByProj(String projFlow);
	GcpDrugStoreRec searchDrugStoreRecByProj(String projFlow,String orgFlow,
			String drugPack,List<String> drugStatusList);
	Map<String, List<String>> getPatientDrugPackMap(List<String> patientFlows);
	List<GcpDrugStoreRec> searchDrugStoreRec(GcpDrugStoreRec storeRec);
	int saveDrugOut(GcpDrugOut gcpDrugOut, List<String> drugPacks);
	GcpDrugStoreRec searchDrugStoreRecByPack(String projFlow, String orgFlow,
			String drugFlow, String drugPack);
	List<GcpDrugOut> searchDrugOutList(GcpDrugOut gcpDrugOut);
	List<GcpDrugIn> searchDrugIns(GcpDrug gcpDrug, PubProj proj);
	GcpDrugOut readDrugOut(String recordFlow);
	int deleteDrugOut(String recordFlow);
	List<GcpDrug> searchDrugList(GcpDrug gcpDrug);
	int saveRecipe(PubPatientRecipe patientRecipe, String[] drugFlows,
			String drugPack);
	int saveRecipe(PubPatientRecipe patientRecipe, String drugFlow,
			String lotNo,String drugAmount);
	int dispensDrug(PubPatientRecipe recipe, GcpDrugStoreRec drugStoreRec);
	List<String> searchDrugPacks(String projFlow,String orgFlow,String recipeStatusId);
	List<GcpDrugStoreRec> searchDrugStoreRec(String projFlow,
			String drugFlow, List<String> drugStatusList);
	List<GcpDrug> searchDrugByDrugFlows(List<String> drugFlows);
}
