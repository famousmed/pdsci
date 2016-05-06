package com.pinde.sci.biz.gcp.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpDrugBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientRecipeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.GcpDrugInMapper;
import com.pinde.sci.dao.base.GcpDrugMapper;
import com.pinde.sci.dao.base.GcpDrugOutMapper;
import com.pinde.sci.dao.base.GcpDrugStoreRecMapper;
import com.pinde.sci.dao.edc.GcpDrugStoreRecExtMapper;
import com.pinde.sci.dao.gcp.GcpDrugExtMapper;
import com.pinde.sci.dao.gcp.GcpDrugInExtMapper;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.model.gcp.GcpDrugExt;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugExample;
import com.pinde.sci.model.mo.GcpDrugIn;
import com.pinde.sci.model.mo.GcpDrugInExample;
import com.pinde.sci.model.mo.GcpDrugOut;
import com.pinde.sci.model.mo.GcpDrugOutExample;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.GcpDrugStoreRecExample;
import com.pinde.sci.model.mo.GcpDrugStoreRecExample.Criteria;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubProj;

@Service
@Transactional(rollbackFor = Exception.class)
public class GcpDrugBizImpl implements IGcpDrugBiz{

	@Autowired
	private GcpDrugMapper gcpDrugMapper;
	@Autowired
	private GcpDrugExtMapper gcpDrugExtMapper;
	@Autowired
	private GcpDrugInMapper gcpDrugInMapper;
	@Autowired
	private GcpDrugInExtMapper gcpDrugInExtMapper;
	@Autowired
	private GcpDrugStoreRecMapper gcpDrugStoreRecMapper;
	@Autowired
	private GcpDrugStoreRecExtMapper gcpDrugStoreRecExtMapper;
	@Resource
	private IPubPatientBiz pubPatientBiz;
	@Autowired
	private GcpDrugOutMapper gcpDrugOutMapper;
	@Autowired
	private IPubPatientRecipeBiz recipeBiz;
	
	@Override
	public List<GcpDrugStoreRec> searchDrugStoreRecByPacks(String projFlow,String orgFlow,String drugFlow,
			List<String> packs,String drugStatusId){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andDurgFlowEqualTo(drugFlow)
		.andDrugPackIn(packs);
		if (StringUtil.isNotBlank(drugStatusId)) {
			criteria.andDrugStatusIdNotEqualTo(drugStatusId);	//不等于
		}
		example.setOrderByClause("ORDINAL");
		return gcpDrugStoreRecMapper.selectByExample(example);
	}
	
	@Override
	public int saveDrugInfo(GcpDrug gcpDrug) {
		 if(StringUtil.isNotBlank(gcpDrug.getDrugFlow())){
		    	GeneralMethod.setRecordInfo(gcpDrug, false);
		    	return this.gcpDrugMapper.updateByPrimaryKeySelective(gcpDrug);
		 }else{
			    gcpDrug.setDrugFlow(PkUtil.getUUID());
		    	GeneralMethod.setRecordInfo(gcpDrug, true);
		    	return this.gcpDrugMapper.insertSelective(gcpDrug);
		 }
	}
	
	@Override
	public int getMaxOrdinal(String orgFlow,String projFlow,String drugFlow){
		Map<String,String> drugStoreRec = new HashMap<String, String>();
		drugStoreRec.put("orgFlow",orgFlow);
		drugStoreRec.put("projFlow",projFlow);
		drugStoreRec.put("drugFlow",drugFlow);
		Integer max = gcpDrugStoreRecExtMapper.selectMaxOrd(drugStoreRec);
		if(max==null){
			max=0;
		}
		return max;
	}

	@Override
	public int deleteDrugInfo(String drugFlow) {
		GcpDrug gcpDrug=this.readDrugInfo(drugFlow);
		if(null!=gcpDrug){
			gcpDrug.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(gcpDrug, false);
			return gcpDrugMapper.updateByPrimaryKeySelective(gcpDrug);
		}
	   return GlobalConstant.ZERO_LINE;
	}

	
	@Override
	public GcpDrug readDrugInfo(String drugFlow) {
		return gcpDrugMapper.selectByPrimaryKey(drugFlow);
	}
	
	@Override
	public List<GcpDrug> searchDrugList(GcpDrug gcpDrug) {
		GcpDrugExample example = new GcpDrugExample();
		com.pinde.sci.model.mo.GcpDrugExample.Criteria criteria = 
				example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(gcpDrug.getProjFlow())) {
			criteria.andProjFlowEqualTo(gcpDrug.getProjFlow());
		}
		if (StringUtil.isNotBlank(gcpDrug.getDrugTypeId())) {
			criteria.andDrugTypeIdEqualTo(gcpDrug.getDrugTypeId());
		}
		if (StringUtil.isNotBlank(gcpDrug.getDrugFlow())) {
			criteria.andDrugFlowEqualTo(gcpDrug.getDrugFlow());
		}
		List<GcpDrug> list = gcpDrugMapper.selectByExample(example);
		return list;
	}

	@Override
	public List<GcpDrug> searchDrugByDrugFlows(List<String> drugFlows){
		GcpDrugExample example = new GcpDrugExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDrugFlowIn(drugFlows);
		return gcpDrugMapper.selectByExample(example);
	}
	
	@Override
	public List<GcpDrugExt> searchDrugList(GcpDrug gcpDrug,PubProj proj) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(null!=gcpDrug){
			map.put("drug", gcpDrug);
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			map.put("projName",proj.getProjName());
		}
		return gcpDrugExtMapper.searchGcpDrugList(map);
	}

	@Override
	public List<GcpDrugIn> searchDrugInList(GcpDrugIn gcpDrugIn) {
		GcpDrugInExample example = new GcpDrugInExample();
		com.pinde.sci.model.mo.GcpDrugInExample.Criteria criteria = 
				example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(gcpDrugIn.getProjFlow())) {
			criteria.andProjFlowEqualTo(gcpDrugIn.getProjFlow());
		}
		if (StringUtil.isNotBlank(gcpDrugIn.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(gcpDrugIn.getOrgFlow());
		}
		if (StringUtil.isNotBlank(gcpDrugIn.getDrugFlow())) {
			criteria.andDrugFlowEqualTo(gcpDrugIn.getDrugFlow());
		}
		example.setOrderByClause("IN_DATE desc,CREATE_TIME desc");
		List<GcpDrugIn> drugInList = gcpDrugInMapper.selectByExample(example);
		return drugInList;
	}

	@Override
	public int saveDrugIn(GcpDrugIn gcpDrugIn,List<String> drugPacks) {
		if(StringUtil.isNotBlank(gcpDrugIn.getRecordFlow())){
		    GeneralMethod.setRecordInfo(gcpDrugIn, false);
		    this.gcpDrugInMapper.updateByPrimaryKeySelective(gcpDrugIn);
		}else{
			gcpDrugIn.setRecordFlow(PkUtil.getUUID());
		    GeneralMethod.setRecordInfo(gcpDrugIn, true);
		    this.gcpDrugInMapper.insertSelective(gcpDrugIn);
		}
		if(drugPacks!=null && drugPacks.size()>0){
			int maxOrd = getMaxOrdinal(gcpDrugIn.getOrgFlow(),gcpDrugIn.getProjFlow(),gcpDrugIn.getDrugFlow());
			GcpDrugStoreRec drugStoreRec = new GcpDrugStoreRec();
			drugStoreRec.setOrgFlow(gcpDrugIn.getOrgFlow());
			drugStoreRec.setProjFlow(gcpDrugIn.getProjFlow());
			drugStoreRec.setDurgFlow(gcpDrugIn.getDrugFlow());
			drugStoreRec.setDrugStatusId(GcpDrugStoreStatusEnum.Storaged.getId());
			drugStoreRec.setDrugStatusName(GcpDrugStoreStatusEnum.Storaged.getName());
			for(String drugPack : drugPacks){
				drugStoreRec.setRecordFlow(null);
				drugStoreRec.setDrugPack(drugPack);
				drugStoreRec.setOrdinal(++maxOrd);
				editDrugStoreRec(drugStoreRec);
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public int editDrugStoreRec(GcpDrugStoreRec drugStoreRec){
		if(drugStoreRec!=null){
			if(StringUtil.isNotBlank(drugStoreRec.getRecordFlow())){
				GeneralMethod.setRecordInfo(drugStoreRec,false);
				return gcpDrugStoreRecMapper.updateByPrimaryKeySelective(drugStoreRec);
			}else{
				drugStoreRec.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(drugStoreRec,true);
				return gcpDrugStoreRecMapper.insertSelective(drugStoreRec);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int dispensDrug(PubPatientRecipe recipe,GcpDrugStoreRec drugStoreRec){
		if(drugStoreRec!=null && recipe!=null){
			recipeBiz.savePatientRecipe(recipe);
			
			if(StringUtil.isBlank(drugStoreRec.getPatientFlow())){
				drugStoreRec.setPatientCode(recipe.getPatientCode());
				drugStoreRec.setPatientFlow(recipe.getPatientFlow());
				drugStoreRec.setAssignTime(recipe.getSendDate());
				drugStoreRec.setAssignUserFlow(recipe.getSendUserFlow());
				drugStoreRec.setAssignUserName(recipe.getSendUserName());
				drugStoreRec.setDrugStatusId(GcpDrugStoreStatusEnum.Send.getId());
				drugStoreRec.setDrugStatusName(GcpDrugStoreStatusEnum.Send.getName());
			}
			drugStoreRec.setSendUserFlow(recipe.getSendUserFlow());
			drugStoreRec.setSendUserName(recipe.getSendUserName());
			editDrugStoreRec(drugStoreRec);
			
			String drugPack = drugStoreRec.getDrugPack();
			List<PubPatientRecipeDrug> recipeDrugList= recipeBiz.searchPatientRecipeDrug(recipe.getRecipeFlow());
			if (recipeDrugList != null && recipeDrugList.size() > 0) {
				for (PubPatientRecipeDrug drug:recipeDrugList) {
					drug.setDrugPack(drugPack);
					recipeBiz.savePatientRecipeDrug(drug);
				}
			}
			
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public GcpDrugIn readDrugIn(String recordFlow) {
		return gcpDrugInMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public int deleteDrugIn(String recordFlow) {
		GcpDrugIn gcpDrugIn=this.readDrugIn(recordFlow);
		if(gcpDrugIn != null){
			String[] drugPacks = gcpDrugIn.getDrugPack().split(",");
			for(String pack : drugPacks){
				String[] drugPack = pack.split("-");
				if(drugPack.length>1){
					int startPack = Integer.parseInt(drugPack[0]);
					int endPack = Integer.parseInt(drugPack[1]);
					while(startPack<=endPack){
						GcpDrugStoreRec drugStoreRec = 
							searchDrugStoreRecByPack(gcpDrugIn.getProjFlow(),gcpDrugIn.getOrgFlow(),gcpDrugIn.getDrugFlow(),startPack+"");
						if (drugStoreRec != null) {
							drugStoreRec.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
							editDrugStoreRec(drugStoreRec);
						}
						startPack++;
					}
				}else{
					GcpDrugStoreRec drugStoreRec = 
						searchDrugStoreRecByPack(gcpDrugIn.getProjFlow(),gcpDrugIn.getOrgFlow(),gcpDrugIn.getDrugFlow(),drugPack[0]);
					if (drugStoreRec != null) {
						drugStoreRec.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
						editDrugStoreRec(drugStoreRec);
					}
				}
			}
			
			gcpDrugIn.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(gcpDrugIn, false);
			return gcpDrugInMapper.updateByPrimaryKeySelective(gcpDrugIn);
		}
	   return GlobalConstant.ZERO_LINE;
		
	}
    
	@Override
	public List<GcpDrug> searchDrugByProj(String projFlow){
		GcpDrugExample example = new GcpDrugExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		example.setOrderByClause("create_time");
		return gcpDrugMapper.selectByExample(example);
	}
	
	@Override
	public GcpDrugStoreRec searchDrugStoreRecByProj(String projFlow,String orgFlow,String drugPack,List<String> drugStatusList){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		Criteria criteria = example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow)
		.andDrugPackEqualTo(drugPack).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (drugStatusList != null && drugStatusList.size() > 0) {
			criteria.andDrugStatusIdNotIn(drugStatusList);
		}
		GcpDrugStoreRec drugStoreRec = null;
		List<GcpDrugStoreRec> drugStoreRecList = gcpDrugStoreRecMapper.selectByExample(example);
		if(drugStoreRecList!=null && drugStoreRecList.size()>0){
			drugStoreRec = drugStoreRecList.get(0);
		}
		return drugStoreRec;
	}
	
	/**
	 * 药物编码展示Map
	 * */
	@Override
	public Map<String,List<String>> getPatientDrugPackMap(List<String> patientFlows){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowIn(patientFlows);
		example.setOrderByClause("ORDINAL");
		List<GcpDrugStoreRec> drugStoreRecList = gcpDrugStoreRecMapper.selectByExample(example);
		Map<String,List<String>> patientDrugPackMap = null;
		if(drugStoreRecList!=null && drugStoreRecList.size()>0){
			patientDrugPackMap = new HashMap<String, List<String>>();
			for(GcpDrugStoreRec drugStoreRec : drugStoreRecList){
				if(patientDrugPackMap.get(drugStoreRec.getPatientFlow())==null){
					List<String> drugPacks = new ArrayList<String>();
					drugPacks.add(drugStoreRec.getDrugPack());
					patientDrugPackMap.put(drugStoreRec.getPatientFlow(),drugPacks);
				}else if(!patientDrugPackMap.get(drugStoreRec.getPatientFlow()).contains(drugStoreRec.getDrugPack())){
					patientDrugPackMap.get(drugStoreRec.getPatientFlow()).add(drugStoreRec.getDrugPack());
				}
			}
		}
		return patientDrugPackMap;
	}
	
	@Override
	public List<GcpDrugStoreRec> searchDrugStoreRec(GcpDrugStoreRec storeRec){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(storeRec.getProjFlow())) {
			criteria.andProjFlowEqualTo(storeRec.getProjFlow());
		}
		if (StringUtil.isNotBlank(storeRec.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(storeRec.getOrgFlow());
		}
		if (StringUtil.isNotBlank(storeRec.getDurgFlow())) {
			criteria.andDurgFlowEqualTo(storeRec.getDurgFlow());
		}
		if (StringUtil.isNotBlank(storeRec.getDrugStatusId())) {
			criteria.andDrugStatusIdEqualTo(storeRec.getDrugStatusId());
		}
		example.setOrderByClause("ORDINAL");
		return gcpDrugStoreRecMapper.selectByExample(example);
	}
	
	@Override
	public GcpDrugStoreRec searchDrugStoreRecByPack(String projFlow,String orgFlow,String drugFlow,String drugPack){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		example.createCriteria().andProjFlowEqualTo(projFlow).andOrgFlowEqualTo(orgFlow).andDurgFlowEqualTo(drugFlow)
		.andDrugPackEqualTo(drugPack).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		GcpDrugStoreRec drugStoreRec = null;
		List<GcpDrugStoreRec> drugStoreRecList = gcpDrugStoreRecMapper.selectByExample(example);
		if(drugStoreRecList!=null && drugStoreRecList.size()>0){
			drugStoreRec = drugStoreRecList.get(0);
		}
		return drugStoreRec;
	}
	
	@Override
	public int saveDrugOut(GcpDrugOut gcpDrugOut,List<String> drugPacks) {
		StringBuilder drugpack = new StringBuilder();
		if(drugPacks!=null && drugPacks.size()>0){
			for(String drugPack : drugPacks){
				GcpDrugStoreRec drugStoreRec = searchDrugStoreRecByPack(gcpDrugOut.getProjFlow(),gcpDrugOut.getOrgFlow(),gcpDrugOut.getDrugFlow(),drugPack);
				if (drugStoreRec != null) {
					drugpack.append(drugPack).append(",");
					drugStoreRec.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
					drugStoreRec.setDrugStatusName(GcpDrugStoreStatusEnum.UnSend.getName());
					editDrugStoreRec(drugStoreRec);
				}
			}
		}
		if (drugpack.length() > 0) {
			drugpack.deleteCharAt(drugpack.length()-1);
	    }
		gcpDrugOut.setDrugPack(drugpack.toString());
		if(StringUtil.isNotBlank(gcpDrugOut.getRecordFlow())){
		    GeneralMethod.setRecordInfo(gcpDrugOut, false);
		    this.gcpDrugOutMapper.updateByPrimaryKeySelective(gcpDrugOut);
		}else{
			gcpDrugOut.setRecordFlow(PkUtil.getUUID());
		    GeneralMethod.setRecordInfo(gcpDrugOut, true);
		    this.gcpDrugOutMapper.insertSelective(gcpDrugOut);
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public List<GcpDrugOut> searchDrugOutList(GcpDrugOut gcpDrugOut) {
		GcpDrugOutExample example = new GcpDrugOutExample();
		com.pinde.sci.model.mo.GcpDrugOutExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(gcpDrugOut.getProjFlow())) {
			criteria.andProjFlowEqualTo(gcpDrugOut.getProjFlow());
		}
		if (StringUtil.isNotBlank(gcpDrugOut.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(gcpDrugOut.getOrgFlow());
		}
		if (StringUtil.isNotBlank(gcpDrugOut.getDrugFlow())) {
			criteria.andDrugFlowEqualTo(gcpDrugOut.getDrugFlow());
		}
		List<GcpDrugOut> drugOutList = gcpDrugOutMapper.selectByExample(example);
		return drugOutList;
	}
	
	@Override
	public List<GcpDrugIn> searchDrugIns(GcpDrug gcpDrug,PubProj proj) {
		Map<String,Object> map=new HashMap<String, Object>();
		if(null!=gcpDrug){
			map.put("drug", gcpDrug);
		}
		if(StringUtil.isNotBlank(proj.getProjName())){
			map.put("projName",proj.getProjName());
		}
		return gcpDrugInExtMapper.searchDrugIns(map);
	}
	
	@Override
	public GcpDrugOut readDrugOut(String recordFlow) {
		return gcpDrugOutMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public int deleteDrugOut(String recordFlow) {
		GcpDrugOut gcpDrugOut = readDrugOut(recordFlow);
		if(gcpDrugOut != null){
			String[] drugPacks = gcpDrugOut.getDrugPack().split(",");
			for(String pack : drugPacks){
				GcpDrugStoreRec drugStoreRec = 
					searchDrugStoreRecByPack(gcpDrugOut.getProjFlow(),gcpDrugOut.getOrgFlow(),gcpDrugOut.getDrugFlow(),pack);
				if (drugStoreRec != null) {
					drugStoreRec.setDrugStatusId(GcpDrugStoreStatusEnum.Storaged.getId());
					drugStoreRec.setDrugStatusName(GcpDrugStoreStatusEnum.Storaged.getName());
					editDrugStoreRec(drugStoreRec);
				}
			}
			gcpDrugOut.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(gcpDrugOut, false);
			return gcpDrugOutMapper.updateByPrimaryKeySelective(gcpDrugOut);
		}
	   return GlobalConstant.ZERO_LINE;
		
	}
	
	@Override
	public int saveRecipe(PubPatientRecipe patientRecipe,String[] drugFlows,String drugPack){
		if(drugFlows!=null && drugFlows.length>0){
			recipeBiz.savePatientRecipe(patientRecipe);
			
			for(String drugFlow : drugFlows){
				PubPatientRecipeDrug patientRecipeDrug = new PubPatientRecipeDrug();
				patientRecipeDrug.setRecipeFlow(patientRecipe.getRecipeFlow());
				patientRecipeDrug.setDrugFlow(drugFlow);
				patientRecipeDrug.setProjFlow(patientRecipe.getProjFlow());
				patientRecipeDrug.setOrgFlow(patientRecipe.getOrgFlow());
				GcpDrug drug = readDrugInfo(drugFlow);
				if(drug!=null){
					patientRecipeDrug.setDrugName(drug.getDrugName());
				}
				if (StringUtil.isNotBlank(drugPack)) {
					patientRecipeDrug.setDrugPack(drugPack);
				}
				if (StringUtil.isNotBlank(drugPack)) {
					patientRecipeDrug.setDrugPack(drugPack);
				}
				recipeBiz.savePatientRecipeDrug(patientRecipeDrug);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public int saveRecipe(PubPatientRecipe patientRecipe,String drugFlow,String lotNo,String drugAmount){
		recipeBiz.savePatientRecipe(patientRecipe);
		
		PubPatientRecipeDrug patientRecipeDrug = new PubPatientRecipeDrug();
		patientRecipeDrug.setRecipeFlow(patientRecipe.getRecipeFlow());
		patientRecipeDrug.setDrugFlow(drugFlow);
		patientRecipeDrug.setProjFlow(patientRecipe.getProjFlow());
		patientRecipeDrug.setOrgFlow(patientRecipe.getOrgFlow());
		patientRecipeDrug.setDrugAmount(drugAmount);
		GcpDrug drug = readDrugInfo(drugFlow);
		if(drug!=null){
			patientRecipeDrug.setDrugName(drug.getDrugName());
		}
		if (StringUtil.isNotBlank(lotNo)) {
			patientRecipeDrug.setLotNo(lotNo);
		}
		recipeBiz.savePatientRecipeDrug(patientRecipeDrug);
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<String> searchDrugPacks(String projFlow,String orgFlow,String recipeStatusId) {
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("projFlow",projFlow);
		map.put("orgFlow",orgFlow);
		map.put("recipeStatusId",recipeStatusId);
		return gcpDrugExtMapper.searchDrugPacks(map);
	}
	
	@Override
	public List<GcpDrugStoreRec> searchDrugStoreRec(String projFlow,String drugFlow,List<String> drugStatusList){
		GcpDrugStoreRecExample example = new GcpDrugStoreRecExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjFlowEqualTo(projFlow).andDurgFlowEqualTo(drugFlow);
		if (drugStatusList != null && drugStatusList.size() > 0) {
			criteria.andDrugStatusIdNotIn(drugStatusList);
		}
		example.setOrderByClause("ORDINAL");
		return gcpDrugStoreRecMapper.selectByExample(example);
	}
}
