package com.pinde.sci.ctrl.srm;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundInfoBiz;
import com.pinde.sci.biz.srm.IFundInfoDetailBiz;
import com.pinde.sci.biz.srm.IFundProcessBiz;
import com.pinde.sci.biz.srm.IFundSchemeBiz;
import com.pinde.sci.biz.srm.IFundSchemeDetailBiz;
import com.pinde.sci.biz.srm.IProjMineBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.ProjCategroyEnum;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjFundTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.PubProjExt;

@Controller
@RequestMapping("/srm/fund/scheme")
public class FundSchemeController extends GeneralController {
	
	private static Logger logger =LoggerFactory.getLogger(FundSchemeController.class);
	@Autowired
	private IFundSchemeBiz schemeBiz;
	@Autowired
	private IFundSchemeDetailBiz detailBiz;
	@Autowired
	private IProjMineBiz projMineBiz;
	@Autowired
	private IFundInfoBiz fundInfoBiz;
	@Autowired
	private IFundInfoDetailBiz fundInfoDetailBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IFundProcessBiz processBiz;
	
	/**
	 * 跳转到经费方案列表页面
	 * @return
	 */
	@RequestMapping(value="/list" , method={RequestMethod.POST,RequestMethod.GET})
	public String list(SrmFundScheme scheme,Model model){
		List<SrmFundScheme> schemeList=schemeBiz.searchFundScheme(scheme);
		model.addAttribute("schemeList", schemeList);
		return "srm/fund/scheme/list";
	}
	/**
	 * 跳转到经费项列表
	 * @return
	 */
	@RequestMapping(value="/itemList" , method={RequestMethod.POST,RequestMethod.GET})
	public String list2(String schemeFlow,Model model){
		SrmFundSchemeDetail schemeDtl = new SrmFundSchemeDetail();
		schemeDtl.setSchemeFlow(schemeFlow);
		schemeDtl.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SrmFundSchemeDetail> schemeDtlList=detailBiz.searchFundSchemeDetail(schemeDtl);
		model.addAttribute("schemeDtlList", schemeDtlList);
		model.addAttribute("schemeFlow", schemeFlow);
		return "srm/fund/scheme/itemList";
	}
	/**
	 * 添加经费方案信息界面
	 * @return
	 */
	@RequestMapping(value="/edit" , method={RequestMethod.POST,RequestMethod.GET})
	public String editItem(Model model){
		SrmFundScheme scheme = new SrmFundScheme();
		List<SrmFundScheme> schemeList = schemeBiz.searchFundScheme(scheme);
		List<SysDict> usableProjTypeList = new ArrayList<SysDict>();
		List<SysDict> projTypeList = DictTypeEnum.sysListDictMap.get(DictTypeEnum.ProjType.getId());
		for(SysDict dict:projTypeList){
			boolean usable = true;
			for(SrmFundScheme existScheme:schemeList){
		           if(dict.getDictId().equals(existScheme.getProjTypeId())){
		        	   usable = false;
		           }
			}
			if(usable){
				usableProjTypeList.add(dict);
			}
		}
		model.addAttribute("existProjTypeIds", usableProjTypeList);
		return "srm/fund/scheme/edit";
	}
	/**
	 * 保存经费方案信息
	 * @param scheme
	 * @return
	 */
	@RequestMapping(value="/saveScheme" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
    public String saveScheme(SrmFundScheme scheme){
		scheme.setProjTypeName(DictTypeEnum.ProjType.getDictNameById(scheme.getProjTypeId()));
		schemeBiz.saveFundScheme(scheme);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * 修改经费方案信息
	 * @param scheme
	 * @return
	 */
	@RequestMapping(value="/updateScheme" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
    public String updateScheme(SrmFundScheme scheme){
		
		scheme.setProjTypeName(DictTypeEnum.ProjType.getDictNameById(scheme.getProjTypeId()));
		scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		schemeBiz.saveFundScheme(scheme);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	@RequestMapping(value="/updateDetail" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
    public String updateDetail(@RequestBody List<SrmFundSchemeDetail> schemeDtlList){
		SrmFundScheme scheme=schemeBiz.readFundScheme(schemeDtlList.get(0).getSchemeFlow());
		for(int i=0;i<schemeDtlList.size();i++){
			SrmFundSchemeDetail schemeDtl = schemeDtlList.get(i);
			schemeDtl.setSchemeName(scheme.getSchemeName());
			schemeDtl.setItemName(DictTypeEnum.BudgetItem.getDictNameById(schemeDtlList.get(i).getItemId()));
			detailBiz.saveFundSchemeDetail(schemeDtl);
		}
		//detailBiz.updateFundSchemeDetail(schemeDtlList);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	/**
	 * 启用经费方案
	 * @param schemeFlow
	 * @return
	 */
	@RequestMapping(value="/startScheme" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String startScheme(String schemeFlow){
		SrmFundScheme scheme=schemeBiz.readFundScheme(schemeFlow);
		List<SrmFundScheme> schemeList=schemeBiz.searchStartScheme(scheme.getProjTypeId());
		if(schemeList.size()>0){
			return GlobalConstant.NOT_START;
		}
		scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		schemeBiz.deleteFundScheme(scheme);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	
	
	/**
	 * 停用经费方案
	 * @param schemeFlow
	 * @return
	 */
	@RequestMapping(value="/stopScheme" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String stopScheme(String schemeFlow){
		SrmFundScheme scheme=schemeBiz.readFundScheme(schemeFlow);
		scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		schemeBiz.deleteFundScheme(scheme);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
	

	
	/**
	 * 申请预算列表--项目负责人适用
	 * @param proj
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/applyList" , method={RequestMethod.POST,RequestMethod.GET})
	public String applyList(PubProj proj,Model model ){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, GlobalConstant.PROJ_STATUS_SCOPE_PERSONAL);
		SysUser currUser = GlobalContext.getCurrentUser();
		proj.setApplyUserFlow(currUser.getUserFlow());
		proj.setProjCategoryId(ProjCategroyEnum.Ky.getId());
		List<PubProj> projList = projMineBiz.searchProjListForBudget(proj);
		HashMap<String, SrmProjFundInfo> map=new HashMap<String, SrmProjFundInfo>();
		for(int i=0;i<projList.size();i++){
			SrmProjFundInfo fundInfo=new SrmProjFundInfo();
			fundInfo.setProjFlow(projList.get(i).getProjFlow());
			List<SrmProjFundInfo> projFundInfoList = fundInfoBiz.searchFundInfo(fundInfo);
			if(projFundInfoList.size()==1){
				map.put(fundInfo.getProjFlow(), projFundInfoList.get(0));
			}
			
		}
		SrmFundScheme scheme=new SrmFundScheme();
		List<SrmFundScheme> schemeList=schemeBiz.searchFundScheme(scheme);
		model.addAttribute("schemeList",schemeList);	
		model.addAttribute("fundMap", map);
		model.addAttribute("projList", projList);
		return "srm/fund/scheme/applyList";
	}
	
	@RequestMapping(value="/applyEdit" , method={RequestMethod.POST,RequestMethod.GET})
	public String applyEdit(String projFlow, Model model,String look){
		//查询该项目是否已申请预算，如果已申请，查出该预算方案及其预算项信息
		model.addAttribute("projFlow", projFlow);
		SrmProjFundInfo fundInfo = new SrmProjFundInfo();
		fundInfo.setProjFlow(projFlow);
		List<SrmProjFundInfo> fundInfoList=fundInfoBiz.searchFundInfo(fundInfo);
		SrmFundSchemeDetail schemeDtl=new SrmFundSchemeDetail();
		if(fundInfoList.size()>0){
			model.addAttribute("fundInfo", fundInfoList.get(0));
			String schemeFlow = fundInfoList.get(0).getSchemeFlow();
			if(StringUtil.isNotBlank(schemeFlow)){
				//查询该项目经费的预算方案信息及其预算项信息
				SrmFundScheme fundScheme=schemeBiz.readFundScheme(schemeFlow);
				model.addAttribute("fundScheme", fundScheme); 
				schemeDtl.setSchemeFlow(fundScheme.getSchemeFlow());
				List<SrmFundSchemeDetail> schemeDtlList=detailBiz.searchFundSchemeDetail(schemeDtl);
				model.addAttribute("schemeDtlList",schemeDtlList);
			}
			
			//先从经费表详细中查经费明细，如果空则从预算项明细中查
			SrmProjFundDetail fundDtl = new SrmProjFundDetail();
			fundDtl.setFundFlow(fundInfoList.get(0).getFundFlow());
			fundDtl.setFundTypeId(ProjFundTypeEnum.Budget.getId());
			List<SrmProjFundDetail> fundDtlList = fundInfoDetailBiz.searchFundDetail(fundDtl);
			if(fundDtlList.size()>0){
			   model.addAttribute("fundDtlList", fundDtlList);
			}
		}
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj" , proj);
	    //查询该项目类型的方案
		SrmFundScheme scheme = new SrmFundScheme();
		scheme.setRecordStatus(GlobalConstant.FLAG_Y);
		scheme.setProjTypeId(proj.getProjTypeId());
	    List<SrmFundScheme> schemeList=schemeBiz.searchFundScheme(scheme);
		if(schemeList.size()>0){
			scheme = schemeList.get(0);
			model.addAttribute("scheme", scheme);
		}
		if(fundInfoList.size()==0 && StringUtil.isNotBlank(scheme.getSchemeFlow())){
			 SrmFundSchemeDetail sfsd=new SrmFundSchemeDetail();
			 sfsd.setSchemeFlow(scheme.getSchemeFlow());
			 List<SrmFundSchemeDetail> sfsdList=detailBiz.searchFundSchemeDetailSee(sfsd);
			 model.addAttribute("sfsdList" , sfsdList);
		}	
		model.addAttribute("look", look);
		return "srm/fund/scheme/applyEdit";
	}
	
	@RequestMapping(value="/changeScheme" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Object changeScheme(String schemeFlow,Model model){
		//根据预算方案号查询预算
	    SrmFundSchemeDetail schemeDtl=new SrmFundSchemeDetail();
		schemeDtl.setSchemeFlow(schemeFlow);
		List<SrmFundSchemeDetail> schemeDtlList=detailBiz.searchFundSchemeDetailSee(schemeDtl);
		return schemeDtlList;
	}
	
	@RequestMapping(value="/saveFundInfoDetail" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String saveFundInfoDetail(@RequestBody List<SrmProjFundDetail> fundDtlList,SrmProjFundInfo fundInfo){
		if(fundInfo!=null){
			//创建经费信息，设置相关属性
			PubProj proj=pubProjBiz.readProject(fundInfo.getProjFlow());
			fundInfo.setProjName(proj.getProjName());
			fundInfo.setBudgetStatusId(AchStatusEnum.Submit.getId());
			fundInfo.setBudgetStatusName(AchStatusEnum.Submit.getName());
			BigDecimal budgetAllValue = new BigDecimal("0.0");
			for(int i=0;i<fundDtlList.size();i++){
				budgetAllValue = budgetAllValue.add(fundDtlList.get(i).getMoney());	
			}
		
			fundInfo.setBudgetAmount(budgetAllValue);
			//创建过程信息
			SrmFundProcess process=new SrmFundProcess();
			SysUser currUser = GlobalContext.getCurrentUser();
		    process.setOperateUserFlow(currUser.getUserFlow());
		    process.setOperateUserName(currUser.getUserName());
		    process.setOperStatusId(AchStatusEnum.Submit.getId());
		    process.setOperStatusName(AchStatusEnum.Submit.getName());
		    fundInfoBiz.saveFundInfo(fundInfo, fundDtlList, process);
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
		
	}
	
	
	@RequestMapping(value="/auditList/{scope}" , method={RequestMethod.POST,RequestMethod.GET})
	public String auditList(@PathVariable String scope,String projFlow,PubProjExt projExt,SrmProjFundInfo fundInfo, Model model){
		SysUser currUser = GlobalContext.getCurrentUser();
		SrmFundScheme scheme=new SrmFundScheme();
		List<SrmFundScheme> schemeList=schemeBiz.searchFundScheme(scheme);
		model.addAttribute("scope", scope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(scope)){
			return "srm/fund/scheme/auditListGlobal";
		}
			
		else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(scope)){
	    	return "srm/fund/scheme/auditListCharge";
	    }
				
		else{
			projExt.setApplyOrgFlow(currUser.getOrgFlow());
			//SrmProjFundInfo projFundInfo = new SrmProjFundInfo();
			
			//projFundInfo.setBudgetStatusId(AchStatusEnum.Submit.getId());
			//projExt.setProjFundInfo(projFundInfo);
			if(projExt.getProjFundInfo()!=null&&StringUtil.isBlank(projExt.getProjFundInfo().getBudgetStatusId())){
				List<String> statuIds = new ArrayList<String>();
				statuIds.add(AchStatusEnum.Submit.getId());
				statuIds.add(AchStatusEnum.FirstAudit.getId());
				projExt.setStatusids(statuIds);
			}
			
			projExt.setProjFundInfo(fundInfo);
			projExt.setProjFlow(projFlow);
			projExt.setProjCategoryId(ProjCategroyEnum.Ky.getId());
			List<PubProjExt> fundInfoList = this.fundInfoBiz.searchBudgetAuditList(projExt);
			model.addAttribute("schemeList",schemeList);	
			model.addAttribute("fundInfoList", fundInfoList);
	    	return "srm/fund/scheme/auditListLocal";
	    }
		
	}
	
	@RequestMapping(value="/audit" , method={RequestMethod.POST,RequestMethod.GET})
	public String audit(String fundFlow,Model model){
		//查询经费下所有明细
		SrmProjFundDetail fundDtl = new SrmProjFundDetail();
		fundDtl.setFundFlow(fundFlow);
		fundDtl.setFundTypeId(ProjFundTypeEnum.Budget.getId());
		List<SrmProjFundDetail> fundDtlList = fundInfoDetailBiz.searchFundDetail(fundDtl);
		SrmProjFundInfo fundInfo = this.fundInfoBiz.getFundInfoByFlow(fundFlow);
		HashMap<String, SrmFundSchemeDetail> map=new HashMap<String, SrmFundSchemeDetail>();
		SrmFundSchemeDetail schemeDtl;
		String itemFlow;
	    if(fundDtlList.size()>0){
	    	for(int i=0;i<fundDtlList.size();i++){
	    		itemFlow=fundDtlList.get(i).getItemFlow();
	    		schemeDtl=detailBiz.read(itemFlow);
	    		map.put(itemFlow, schemeDtl);
	    	}
	    model.addAttribute("schemeMap", map);
	    }
		model.addAttribute("fundDtlList", fundDtlList);
		model.addAttribute("fundFlow", fundFlow);
		model.addAttribute("fundInfo", fundInfo);
		return "srm/fund/scheme/audit";
	}
	@RequestMapping(value="/saveAudit" , method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String saveAudit(String agreeFlag,String content,String fundFlow){
		
		SrmProjFundInfo fundInfo=new SrmProjFundInfo();
		fundInfo.setFundFlow(fundFlow);
		List<SrmProjFundInfo> fundInfoList=fundInfoBiz.searchFundInfo(fundInfo);
		
		SrmFundProcess process=new SrmFundProcess();
		process.setFundFlow(fundFlow);
		process.setOperStatusId(AchStatusEnum.Submit.getId());
		SrmFundProcess readProcess=processBiz.readFundProcess(process);
		readProcess.setContent(content);
		if(fundInfoList.size()>0){
			SrmProjFundInfo projFundInfo=fundInfoList.get(0);
			if(agreeFlag.equals(GlobalConstant.FLAG_Y)){
			   projFundInfo.setBudgetStatusId(AchStatusEnum.FirstAudit.getId());
			   projFundInfo.setBudgetStatusName(AchStatusEnum.FirstAudit.getName());
			   readProcess.setOperStatusId(AchStatusEnum.FirstAudit.getId());
			   readProcess.setOperStatusName(AchStatusEnum.FirstAudit.getName());
			}else{
		       projFundInfo.setBudgetStatusId(AchStatusEnum.RollBack.getId());
		       projFundInfo.setBudgetStatusName(AchStatusEnum.RollBack.getName());	
		       readProcess.setOperStatusId(AchStatusEnum.RollBack.getId());
		       readProcess.setOperStatusName(AchStatusEnum.RollBack.getName());
			}	
			fundInfoBiz.budgetAudit(projFundInfo, readProcess);
		}
		
		return GlobalConstant.OPERATE_SUCCESSED;
	}
}
