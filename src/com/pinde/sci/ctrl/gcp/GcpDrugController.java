package com.pinde.sci.ctrl.gcp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.gcp.IGcpDrugBiz;
import com.pinde.sci.biz.pub.IPubPatientBiz;
import com.pinde.sci.biz.pub.IPubPatientRecipeBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.gcp.GcpDrugStoreStatusEnum;
import com.pinde.sci.enums.gcp.GcpDrugTypeEnum;
import com.pinde.sci.enums.gcp.GcpProjStageEnum;
import com.pinde.sci.enums.pub.PatientRecipeStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.gcp.GcpDrugExt;
import com.pinde.sci.model.mo.GcpDrug;
import com.pinde.sci.model.mo.GcpDrugIn;
import com.pinde.sci.model.mo.GcpDrugOut;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubPatientRecipe;
import com.pinde.sci.model.mo.PubPatientRecipeDrug;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.pub.PubPatientRecipeExt;

@Controller
@RequestMapping("/gcp/drug")
public class GcpDrugController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(GcpDrugController.class);
	private static Integer DEFAULT_START_PAGE_INDEX = 1;//默认起始分页索引
	private static Integer DEFAULT_PAGE_SIZE = 15;//默认分页数大小
	
	@Autowired
	private IGcpDrugBiz gcpDrugBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IPubPatientRecipeBiz recipeBiz;
	@Autowired
	private IPubPatientBiz pubPatientBiz;
	
	@RequestMapping(value="/list")
	public String gcpDrugList(PubProj proj,GcpDrug gcpDrug,Model model){
		List<GcpDrugExt> gcpDrugList=gcpDrugBiz.searchDrugList(gcpDrug, proj);
		model.addAttribute("gcpDrugList",gcpDrugList);
		return "gcp/drug/list";
	}
	
	@RequestMapping(value="/editDrugInfo")
	public String editDrugInfo(String drugFlow,String projFlow,Model model){
		PubProj proj=new PubProj();
		proj.setApplyOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		proj.setProjStageId(GcpProjStageEnum.Schedule.getId());
		List<PubProj> projList = this.pubProjBiz.queryProjList(proj);
		model.addAttribute("projList", projList);
		if(StringUtil.isNotBlank(drugFlow)){
			GcpDrug gcpDrug = this.gcpDrugBiz.readDrugInfo(drugFlow);
			if(null!=gcpDrug){
				model.addAttribute("drug", gcpDrug);
				if (gcpDrug != null) {
					projFlow = gcpDrug.getProjFlow();
				}
			}
		}
		
		PubProj currProj = pubProjBiz.readProject(projFlow);
		model.addAttribute("currProj", currProj);
		return "gcp/drug/edit";
	}
	@RequestMapping(value="/saveDrugInfo")
	@ResponseBody
	public String saveDrugInfo(GcpDrug gcpDrug,Model model){
	    if(StringUtil.isNotBlank(gcpDrug.getDrugTypeId())){
	    	gcpDrug.setDrugTypeName(GcpDrugTypeEnum.getNameById(gcpDrug.getDrugTypeId()));
	    }
	    if(StringUtil.isNotBlank(gcpDrug.getDoseUnitId())){
	    	gcpDrug.setDoseUnitName(DictTypeEnum.DoseUnit.getDictNameById(gcpDrug.getDoseUnitId()));
	    }
	    if(StringUtil.isNotBlank(gcpDrug.getPreparationUnitId())){
	    	gcpDrug.setPreparationUnitName(DictTypeEnum.PreparationUnit.getDictNameById(gcpDrug.getPreparationUnitId()));
	    }
	    if(StringUtil.isNotBlank(gcpDrug.getUsageId())){
	    	gcpDrug.setUsageName(DictTypeEnum.Usage.getDictNameById(gcpDrug.getUsageId()));
	    }
	    if(StringUtil.isNotBlank(gcpDrug.getSolutionId())){
	    	gcpDrug.setSolutionName(DictTypeEnum.Solution.getDictNameById(gcpDrug.getSolutionId()));
	    }
	    if(StringUtil.isNotBlank(gcpDrug.getMinPackUnitId())){
	    	gcpDrug.setMinPackUnitName(DictTypeEnum.MiniPackUnit.getDictNameById(gcpDrug.getMinPackUnitId()));
	    }
	    int result = this.gcpDrugBiz.saveDrugInfo(gcpDrug);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	@RequestMapping(value="/delDrugInfo")
	@ResponseBody
	public String delDrugInfo(String drugFlow){
		if(StringUtil.isNotBlank(drugFlow)){
			int result = this.gcpDrugBiz.deleteDrugInfo(drugFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
		
	}
	@RequestMapping(value="/saveDrugIn")
	@ResponseBody
	public String saveDrugIn(GcpDrugIn gcpDrugIn,Model model){
		SysUser currUser=GlobalContext.getCurrentUser();
		PubProj proj = pubProjBiz.readProject(gcpDrugIn.getProjFlow());
		gcpDrugIn.setOrgFlow(proj.getApplyOrgFlow());
		gcpDrugIn.setInOperator(currUser.getUserName());
		List<String> packList = null;
		if(StringUtil.isNotBlank(gcpDrugIn.getDrugPack())){
			String[] drugPacks = gcpDrugIn.getDrugPack().split(",");
			packList = new ArrayList<String>();
			for(String pack : drugPacks){
				String[] drugPack = pack.split("-");
				if(drugPack.length>1){
					int startPack = Integer.parseInt(drugPack[0]);
					int endPack = Integer.parseInt(drugPack[1]);
					while(startPack<=endPack){
						packList.add(startPack+"");
						startPack++;
					}
				}else{
					packList.add(drugPack[0]);
				}
			}
			List<GcpDrugStoreRec> drugStoreRecList = 
				gcpDrugBiz.searchDrugStoreRecByPacks(gcpDrugIn.getProjFlow(),gcpDrugIn.getOrgFlow(),gcpDrugIn.getDrugFlow(),packList,"");
			if(drugStoreRecList!=null && drugStoreRecList.size()>0){
				String reResul = "";
				for(GcpDrugStoreRec drugStoreRec : drugStoreRecList){
					if(StringUtil.isNotBlank(reResul)){
						reResul+=",";
					}
					reResul+=drugStoreRec.getDrugPack();
				}
				return "药物编码 "+reResul+" 已存在!";
			}
		}
	    int result = this.gcpDrugBiz.saveDrugIn(gcpDrugIn,packList);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/stockList")
	public String stockList(PubProj proj,GcpDrug gcpDrug,Integer currentPage,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<GcpDrugExt> gcpDrugList = gcpDrugBiz.searchDrugList(gcpDrug, proj);
		model.addAttribute("gcpDrugList",gcpDrugList);
		Map<String,List<GcpDrugStoreRec>> drugRecMap = new HashMap<String,List<GcpDrugStoreRec>>();
		if (gcpDrugList != null && gcpDrugList.size() > 0) {
			for (GcpDrugExt drug:gcpDrugList) {
				GcpDrugStoreRec temp = new GcpDrugStoreRec();
				temp.setProjFlow(drug.getProjFlow());
				temp.setDurgFlow(drug.getDrugFlow());
				temp.setDrugStatusId(GcpDrugStoreStatusEnum.Storaged.getId());
				List<GcpDrugStoreRec> drugRecList = 
					gcpDrugBiz.searchDrugStoreRec(temp);
				drugRecMap.put(drug.getDrugFlow(),drugRecList);
			}
		}
		model.addAttribute("drugRecMap",drugRecMap);
		return "gcp/drug/stock/list";
	}
	
	@RequestMapping(value="/editDrugIn")
	public String editDrugIn(String drugFlow,Model model){
		if(StringUtil.isNotBlank(drugFlow)){
			GcpDrug gcpDrug=gcpDrugBiz.readDrugInfo(drugFlow);
			model.addAttribute("drug", gcpDrug);
		}
		return "gcp/drug/stock/drugIn";
	}
	
	@RequestMapping(value="/drugInRecord")
	public String drugInRecord(GcpDrugIn gcpDrugIn,Model model){
		GcpDrug drug = gcpDrugBiz.readDrugInfo(gcpDrugIn.getDrugFlow());
		model.addAttribute("drug",drug);
		List<GcpDrugIn> drugInList=gcpDrugBiz.searchDrugInList(gcpDrugIn);
		model.addAttribute("drugInList",drugInList);
		return "gcp/drug/stock/drugInRecord";
	}
	
	@RequestMapping(value = {"/delDrugInConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delDrugInConfirm(String recordFlow){
		GcpDrugIn gcpDrugIn = gcpDrugBiz.readDrugIn(recordFlow);
		String[] drugPacks = gcpDrugIn.getDrugPack().split(",");
		List<String> packList = new ArrayList<String>();
		if (drugPacks != null && drugPacks.length > 0) {
			for(String pack : drugPacks){
				String[] drugPack = pack.split("-");
				if(drugPack.length>1){
					int startPack = Integer.parseInt(drugPack[0]);
					int endPack = Integer.parseInt(drugPack[1]);
					while(startPack<=endPack){
						packList.add(startPack+"");
						startPack++;
					}
				}else{
					packList.add(drugPack[0]);
				}
			}
		}
		List<GcpDrugStoreRec> drugStoreRecList = 
			gcpDrugBiz.searchDrugStoreRecByPacks(gcpDrugIn.getProjFlow(),gcpDrugIn.getOrgFlow(),gcpDrugIn.getDrugFlow(),packList,GcpDrugStoreStatusEnum.Storaged.getId());
		if(drugStoreRecList!=null && drugStoreRecList.size()>0){
			String reResul = "";
			for(GcpDrugStoreRec drugStoreRec : drugStoreRecList){
				if(StringUtil.isNotBlank(reResul)){
					reResul+=",";
				}
				reResul+=drugStoreRec.getDrugPack();
			}
			return "该入库记录药物编码："+reResul+"已出库，不能删除!";
		}
		
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/delDrugIn")
	@ResponseBody
	public String delDrugIn(String recordFlow){
		if(StringUtil.isNotBlank(recordFlow)){
			int result = this.gcpDrugBiz.deleteDrugIn(recordFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
		
	}
	
	@RequestMapping(value="/editDrugOut")
	public String editDrugOut(String drugFlow,Model model){
		if(StringUtil.isNotBlank(drugFlow)){
			GcpDrug gcpDrug = gcpDrugBiz.readDrugInfo(drugFlow);
			model.addAttribute("drug", gcpDrug);
			if (gcpDrug != null) {
				PubProj proj = pubProjBiz.readProject(gcpDrug.getProjFlow());
				if (proj != null) {
					GcpDrugStoreRec temp = new GcpDrugStoreRec();
					temp.setProjFlow(gcpDrug.getProjFlow());
					temp.setDurgFlow(drugFlow);
					temp.setDrugStatusId(GcpDrugStoreStatusEnum.Storaged.getId());
					List<GcpDrugStoreRec> drugStoreRecs = gcpDrugBiz.searchDrugStoreRec(temp);
					model.addAttribute("drugStoreRecs", drugStoreRecs);
				}
			}
		}
		return "gcp/drug/stock/drugOut";
	}
	
	@RequestMapping(value="/saveDrugOut")
	@ResponseBody
	public String saveDrugOut(GcpDrugOut gcpDrugOut,@RequestBody List<String> drugPacks){
		SysUser currUser=GlobalContext.getCurrentUser();
		PubProj proj = pubProjBiz.readProject(gcpDrugOut.getProjFlow());
		gcpDrugOut.setOrgFlow(proj.getApplyOrgFlow());
		gcpDrugOut.setOutOperator(currUser.getUserName());
	    int result = this.gcpDrugBiz.saveDrugOut(gcpDrugOut,drugPacks);
		if(result==GlobalConstant.ONE_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/drugOutRecord")
	public String drugOutRecord(GcpDrugOut gcpDrugOut,Model model){
		GcpDrug drug = gcpDrugBiz.readDrugInfo(gcpDrugOut.getDrugFlow());
		model.addAttribute("drug",drug);
		List<GcpDrugOut> drugOutList = gcpDrugBiz.searchDrugOutList(gcpDrugOut);
		model.addAttribute("drugOutList",drugOutList);
		return "gcp/drug/stock/drugOutRecord";
	}
	
	@RequestMapping(value = {"/delDrugOutConfirm" },method={RequestMethod.GET})
	@ResponseBody
	public String delDrugOutConfirm(String recordFlow){
		GcpDrugOut gcpDrugOut = gcpDrugBiz.readDrugOut(recordFlow);
		String[] drugPacks = gcpDrugOut.getDrugPack().split(",");
		List<String> packList = new ArrayList<String>();
		if (drugPacks != null && drugPacks.length > 0) {
			for(String pack : drugPacks){
				packList.add(pack);
			}
		}
		List<GcpDrugStoreRec> drugStoreRecList = 
			gcpDrugBiz.searchDrugStoreRecByPacks(gcpDrugOut.getProjFlow(),gcpDrugOut.getOrgFlow(),gcpDrugOut.getDrugFlow(),packList,GcpDrugStoreStatusEnum.UnSend.getId());
		if(drugStoreRecList!=null && drugStoreRecList.size()>0){
			String reResul = "";
			for(GcpDrugStoreRec drugStoreRec : drugStoreRecList){
				if(StringUtil.isNotBlank(reResul)){
					reResul+=",";
				}
				reResul+=drugStoreRec.getDrugPack();
			}
			return "该出库记录药物编码："+reResul+"已发药，不能删除!";
		}
		
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/delDrugOut")
	@ResponseBody
	public String delDrugOut(String recordFlow){
		if(StringUtil.isNotBlank(recordFlow)){
			int result = this.gcpDrugBiz.deleteDrugOut(recordFlow);
			if(result== GlobalConstant.ONE_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
		
	}
	
	@RequestMapping(value="/storeList")
	public String storeList(PubProj proj,GcpDrug gcpDrug,Integer currentPage,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<GcpDrugExt> gcpDrugList = gcpDrugBiz.searchDrugList(gcpDrug, proj);
		model.addAttribute("gcpDrugList",gcpDrugList);
		Map<String,List<GcpDrugStoreRec>> drugRecSendMap = new HashMap<String,List<GcpDrugStoreRec>>();
		Map<String,List<GcpDrugStoreRec>> drugRecUnSendMap = new HashMap<String,List<GcpDrugStoreRec>>();
		if (gcpDrugList != null && gcpDrugList.size() > 0) {
			List<String> drugStatusList = new ArrayList<String>();
			drugStatusList.add(GcpDrugStoreStatusEnum.UnStorage.getId());
			drugStatusList.add(GcpDrugStoreStatusEnum.Storaged.getId());
			drugStatusList.add(GcpDrugStoreStatusEnum.UnSend.getId());
			for (GcpDrugExt drug:gcpDrugList) {
				List<GcpDrugStoreRec> drugRecSendList = 
						gcpDrugBiz.searchDrugStoreRec(drug.getProjFlow(), drug.getDrugFlow(), drugStatusList);
				drugRecSendMap.put(drug.getDrugFlow(),drugRecSendList);
				GcpDrugStoreRec temp = new GcpDrugStoreRec();
				temp.setProjFlow(drug.getProjFlow());
				temp.setDurgFlow(drug.getDrugFlow());
				temp.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
				List<GcpDrugStoreRec> drugRecUnSendList = 
					gcpDrugBiz.searchDrugStoreRec(temp);
				drugRecUnSendMap.put(drug.getDrugFlow(),drugRecUnSendList);
			}
		}
		model.addAttribute("drugRecSendMap",drugRecSendMap);
		model.addAttribute("drugRecUnSendMap",drugRecUnSendMap);
		return "gcp/drug/store/list";
	}
	
	@RequestMapping(value="/drugStore")
	public String drugStores(String drugFlow,Model model){
		GcpDrug drug = gcpDrugBiz.readDrugInfo(drugFlow);
		model.addAttribute("drug",drug);
		List<String> drugStatusList = new ArrayList<String>();
		drugStatusList.add(GcpDrugStoreStatusEnum.UnStorage.getId());
		drugStatusList.add(GcpDrugStoreStatusEnum.Storaged.getId());
		drugStatusList.add(GcpDrugStoreStatusEnum.UnSend.getId());
		List<GcpDrugStoreRec> drugRecSendList = 
				gcpDrugBiz.searchDrugStoreRec(drug.getProjFlow(), drugFlow, drugStatusList);
		GcpDrugStoreRec temp = new GcpDrugStoreRec();
		temp.setProjFlow(drug.getProjFlow());
		temp.setDurgFlow(drug.getDrugFlow());
		temp.setDrugStatusId(GcpDrugStoreStatusEnum.UnSend.getId());
		List<GcpDrugStoreRec> drugRecUnSendList = 
				gcpDrugBiz.searchDrugStoreRec(temp);
		model.addAttribute("drugRecSendList",drugRecSendList);
		model.addAttribute("drugRecUnSendList",drugRecUnSendList);
		return "gcp/drug/store/drugStore";
	}
	
	@RequestMapping(value="/dispensRecord")
	public String dispensRecord(String patientName,String drugName,String projName,Integer currentPage,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubPatientRecipeExt> recipeList = 
			recipeBiz.searchPatientRecipe(GlobalContext.getCurrentUser().getOrgFlow(),patientName,
					projName,PatientRecipeStatusEnum.Dispensed.getId());
		model.addAttribute("recipeList",recipeList);
		Map<String,List<PubPatientRecipeDrug>> recipeDrugMap = new HashMap<String,List<PubPatientRecipeDrug>>();
		if (recipeList != null && recipeList.size() > 0) {
			for (PubPatientRecipeExt recipe:recipeList) {
				List<PubPatientRecipeDrug> temp = recipeBiz.searchPatientRecipeDrug(recipe.getRecipeFlow());
				recipeDrugMap.put(recipe.getRecipeFlow(),temp);
			}
		}
		model.addAttribute("recipeDrugMap",recipeDrugMap);
		return "gcp/drug/store/dispensRecord";
	}
	
	@RequestMapping(value="/recipeList")
	public String recipeList(String patientName,String drugName,String projName,Integer currentPage,HttpServletRequest request,Model model){
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubPatientRecipeExt> recipeList = 
				recipeBiz.searchPatientRecipe(GlobalContext.getCurrentUser().getOrgFlow(),patientName,
						projName,PatientRecipeStatusEnum.UnDispens.getId());
		model.addAttribute("recipeList",recipeList);
		return "gcp/drug/store/recipeList";
	}
	
	@RequestMapping(value="/editDispensDrug")
	public String editDispensDrug(String recipeFlow,Model model){
		PubPatientRecipe recipe = recipeBiz.readPatientRecipe(recipeFlow);
		if (recipe != null) {
			Map<String,GcpDrug> drugMap = new HashMap<String,GcpDrug>();
			List<PubPatientRecipeDrug> recipeDrugList= recipeBiz.searchPatientRecipeDrug(recipeFlow);
			if (recipeDrugList != null && recipeDrugList.size() > 0) {
				for (PubPatientRecipeDrug recipeDrug:recipeDrugList) {
					String drugFlow = recipeDrug.getDrugFlow();
					GcpDrug drug = gcpDrugBiz.readDrugInfo(drugFlow);
					drugMap.put(drugFlow, drug);
				}
			}
			model.addAttribute("recipeDrugList",recipeDrugList);
			model.addAttribute("drugMap",drugMap);
			
			String defaultPack = "";//有未发药的处方则取最新的未发药处方的药物编码
			String projFlow = recipe.getProjFlow();
			String patientFlow = recipe.getPatientFlow();
			String orgFlow = GlobalContext.getCurrentUser().getOrgFlow();
			List<PubPatientRecipe> recipeList = recipeBiz.searchPatientRecipe(patientFlow);
			if (recipeList != null && recipeList.size() >0) {
				PubPatientRecipe recipeTemp = recipeList.get(0);
				if (PatientRecipeStatusEnum.UnDispens.getId().equals(recipeTemp.getRecipeStatusId())) {
					List<PubPatientRecipeDrug> recipeDrugs = recipeBiz.searchPatientRecipeDrug(recipeTemp.getRecipeFlow());
					if (recipeDrugs != null && recipeDrugs.size() >0) {
						defaultPack = recipeDrugs.get(0).getDrugPack();
					}
				}
			}
			if (StringUtil.isNotBlank(defaultPack)) {
				model.addAttribute("defaultPack",defaultPack);
			} else {
				List<String> drugPackList = gcpDrugBiz.searchDrugPacks(projFlow,orgFlow,PatientRecipeStatusEnum.UnDispens.getId());
				boolean flag = drugPackList != null && drugPackList.size() > 0?true:false;
				
				GcpDrugStoreRec temp = new GcpDrugStoreRec();
				temp.setProjFlow(projFlow);
				temp.setOrgFlow(orgFlow);
				List<GcpDrugStoreRec> drugStoreRecList = gcpDrugBiz.searchDrugStoreRec(temp);
				if(drugStoreRecList!=null && drugStoreRecList.size()>0){
					GcpDrugStoreRec usedDrugStoreRec = null;
					GcpDrugStoreRec freeDrugStoreRec = null;
					for(GcpDrugStoreRec drugStoreRec : drugStoreRecList){
						if(StringUtil.isNotBlank(drugStoreRec.getPatientFlow()) && patientFlow.equals(drugStoreRec.getPatientFlow())){
							if(usedDrugStoreRec == null){
								usedDrugStoreRec = drugStoreRec;
								
							}else if(usedDrugStoreRec.getModifyTime().compareTo(drugStoreRec.getModifyTime())<0){
								usedDrugStoreRec = drugStoreRec;
							}
						}else if(StringUtil.isBlank(drugStoreRec.getPatientFlow())){
							String drugPack = drugStoreRec.getDrugPack();
							if(freeDrugStoreRec == null && !(flag && StringUtil.isNotBlank(drugPack) && drugPackList.indexOf(drugPack) > -1)){
								freeDrugStoreRec = drugStoreRec;
							}
						}
					}
					if(usedDrugStoreRec!=null){
						model.addAttribute("defaultPack",usedDrugStoreRec.getDrugPack());
					}else{
						model.addAttribute("defaultPack",freeDrugStoreRec == null?"":freeDrugStoreRec.getDrugPack());
					}
				}
			}
		}
		model.addAttribute("recipe",recipe);
		return "gcp/drug/store/dispensDrug";
	}
	
	@RequestMapping(value={"/dispensDrug"},method={RequestMethod.POST})
	@ResponseBody
	public String dispensDrug(String recipeFlow,String drugPack,Model model){
		if(StringUtil.isNotBlank(recipeFlow)){
			SysUser user = GlobalContext.getCurrentUser();
			PubPatientRecipe recipe = recipeBiz.readPatientRecipe(recipeFlow);
			if (recipe != null) {
				String projFlow = recipe.getProjFlow();
				String patientFlow = recipe.getPatientFlow();
				List<String> drugStatusList = new ArrayList<String>();
				drugStatusList.add(GcpDrugStoreStatusEnum.UnStorage.getId());
				drugStatusList.add(GcpDrugStoreStatusEnum.Storaged.getId());
				GcpDrugStoreRec drugStoreRec = 
					gcpDrugBiz.searchDrugStoreRecByProj(projFlow,user.getOrgFlow(),drugPack,drugStatusList);
				if(drugStoreRec!=null){
					if(StringUtil.isNotBlank(drugStoreRec.getPatientFlow()) && !patientFlow.equals(drugStoreRec.getPatientFlow())){
						return "发药失败,该药物编码的药物已被占用!";
					}
					recipe.setSendDate(DateUtil.getCurrDateTime());
					recipe.setSendUserFlow(user.getUserFlow());
					recipe.setSendUserName(user.getUserName());
					recipe.setRecipeStatusId(PatientRecipeStatusEnum.Dispensed.getId());
					recipe.setRecipeStatusName(PatientRecipeStatusEnum.Dispensed.getName());
					int result = gcpDrugBiz.dispensDrug(recipe,drugStoreRec);
					if(GlobalConstant.ONE_LINE == result){
						return "发药成功";
					}
				}else{
					return "发药失败,该药物编码没有库存!";
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
}
