package com.pinde.sci.biz.pub.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubPatientRecipeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubPatientRecipeDrugMapper;
import com.pinde.sci.dao.base.PubPatientRecipeMapper;
import com.pinde.sci.dao.pub.PubPatientRecipeExtMapper;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubPatientRecipeDrugExample;
import com.pinde.sci.model.mo.PubPatientRecipeExample;
import com.pinde.sci.model.mo.PubPatientRecipeExample.Criteria;
import com.pinde.sci.model.pub.PubPatientRecipeExt;


@Service
@Transactional(rollbackFor=Exception.class)
public class PubPatientRecipeBizImpl implements IPubPatientRecipeBiz{

	@Resource
	private PubPatientRecipeMapper recipeMapper;
	@Resource
	private PubPatientRecipeDrugMapper recipeDrugMapper;
	@Resource
	private PubPatientRecipeExtMapper recipeExtMapper;
	
	@Override
	public List<PubPatientRecipe> searchPatientRecipe(PubPatientRecipeExample example) {
		return recipeMapper.selectByExample(example);
	}

	@Override
	public PubPatientRecipe readPatientRecipe(String recipeFlow) {
		return recipeMapper.selectByPrimaryKey(recipeFlow);
	}
	
	@Override
	public int savePatientRecipe(PubPatientRecipe patientRecipe) {
		if(patientRecipe!=null){
			if(StringUtil.isNotBlank(patientRecipe.getRecipeFlow())){//修改
				GeneralMethod.setRecordInfo(patientRecipe, false);
				return this.recipeMapper.updateByPrimaryKeySelective(patientRecipe);
			}else{//新增
				patientRecipe.setRecipeFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(patientRecipe, true);
				return this.recipeMapper.insertSelective(patientRecipe);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int savePatientRecipeDrug(PubPatientRecipeDrug patientRecipeDrug) {
		if(patientRecipeDrug!=null){
			if(StringUtil.isNotBlank(patientRecipeDrug.getRecordFlow())){//修改
				GeneralMethod.setRecordInfo(patientRecipeDrug, false);
				return this.recipeDrugMapper.updateByPrimaryKeySelective(patientRecipeDrug);
			}else{//新增
				patientRecipeDrug.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(patientRecipeDrug, true);
				return this.recipeDrugMapper.insertSelective(patientRecipeDrug);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<PubPatientRecipe> searchPatientRecipe(String patientFlow){
		PubPatientRecipeExample example = new PubPatientRecipeExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andPatientFlowEqualTo(patientFlow);
		example.setOrderByClause("SEND_DATE DESC,recipe_date desc");
		return recipeMapper.selectByExample(example);
	}
	
	@Override
	public List<PubPatientRecipeDrug> searchPatientRecipeDrugByRecipeFlows(List<String> recipeFlows){
		PubPatientRecipeDrugExample example = new PubPatientRecipeDrugExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecipeFlowIn(recipeFlows);
		return recipeDrugMapper.selectByExample(example);
	}
	
	@Override
	public List<PubPatientRecipeExt> searchPatientRecipe(String orgFlow,String patientName,String projName,String recipeStatusId){
		Map<String,Object> map=new HashMap<String, Object>();
		map.put("orgFlow",orgFlow);
		map.put("patientName",patientName);
		map.put("projName",projName);
		map.put("recipeStatusId",recipeStatusId);
		return recipeExtMapper.searchPatientRecipe(map);
	}
	
	@Override
	public List<PubPatientRecipeDrug> searchPatientRecipeDrug(String recipeFlow){
		PubPatientRecipeDrugExample example = new PubPatientRecipeDrugExample();
		example.createCriteria().andRecipeFlowEqualTo(recipeFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return recipeDrugMapper.selectByExample(example);
	}
	
	@Override
	public List<PubPatientRecipe> searchPatientRecipeByPatientRecipe(PubPatientRecipe patientRecipe){
		PubPatientRecipeExample example = new PubPatientRecipeExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(patientRecipe.getPatientFlow())){
			criteria.andPatientFlowEqualTo(patientRecipe.getPatientFlow());
		}
		if(StringUtil.isNotBlank(patientRecipe.getVisitFlow())){
			criteria.andVisitFlowEqualTo(patientRecipe.getVisitFlow());
		}
		example.setOrderByClause("SEND_DATE DESC,recipe_date desc");
		return recipeMapper.selectByExample(example);
	}
}  
 