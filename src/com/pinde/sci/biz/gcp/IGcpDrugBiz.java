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
	 * 保存药物信息
	 * @param gcpDrug
	 * @return
	 */
	int saveDrugInfo(GcpDrug gcpDrug);
	/**
	 * 删除药物信息
	 * @param drugFlow
	 * @return
	 */
	int deleteDrugInfo(String drugFlow);
	/**
	 * 获取一种药品的详细信息
	 * @param drugFlow
	 * @return
	 */
	GcpDrug readDrugInfo(String drugFlow);
	/**
	 * 查询药物信息列表
	 * @param gcpDrug
	 * @param proj
	 * @return
	 */
	List<GcpDrugExt> searchDrugList(GcpDrug gcpDrug,PubProj proj);
    /**
     * 查询药物入库信息
     * @param gcpDrugIn
     * @return
     */
	List<GcpDrugIn> searchDrugInList(GcpDrugIn gcpDrugIn);
	/**
	 * 保存药物入库信息
	 * @param gcpDrugIn
	 * @return
	 */
	int saveDrugIn(GcpDrugIn gcpDrugIn, List<String> drugPacks);
	/**
	 * 获取一条入库记录的详细信息
	 * @param recordFlow
	 * @return
	 */
	GcpDrugIn readDrugIn(String recordFlow);
	/**
	 * 删除药物入库信息
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
