package com.pinde.sci.ctrl.srm;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.jspform.Page;
import com.pinde.core.jspform.PageGroup;
import com.pinde.core.page.PageHelper;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.biz.srm.IProjApproveBiz;
import com.pinde.sci.biz.srm.IProjPageBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.JspFormUtil;
import com.pinde.sci.enums.srm.EvaluationEnum;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.enums.srm.ProcessRemarkEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjFundPlanTypeEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjFundPlan;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmExpertProjExt;
/**
 * 立项阶段的controller
 * @author shenzhen
 *
 */
@Controller
@RequestMapping("/srm/proj/approve")
public class ProjApproveController extends GeneralController{
	
	@Autowired
	private IProjApproveBiz projApproveBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;	
	@Autowired
	private IProjRecBiz projRecBiz;
	@Autowired
	private IProjPageBiz projPageBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IProjOrgBiz projOrg;
	@Autowired
	private IExpertGroupProjBiz evalSetBiz;
	@Autowired
	private IExpertProjBiz expertProjBiz;
	@Autowired
	private IExpertGroupBiz experGroupBiz;
		
	/**
	 * 显示立项管理的项目列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list/{projListScope}/{projCateScope}")
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope, PubProj proj , Integer currentPage ,HttpServletRequest request,  Model model){
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		proj.setProjCategoryId(getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE).toString());
		proj.setProjStageId(ProjStageEnum.Approve.getId());//申报阶段
		proj.setProjStatusId(ProjApproveStatusEnum.Approving.getId());
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProj> projList = projApproveBiz.searchApproveProjList(proj);
		model.addAttribute("projList" , projList);
		//申报单位
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			//加载所有同级单位
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
			model.addAttribute("orgList",orgList);
		}
		List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
		model.addAttribute("chargeOrgList",chargeOrgList);
		
		return "srm/proj/approve/list_"+projCateScope;
	}
	
	@RequestMapping(value="/exportExcel/{projListScope}/{projCateScope}")
	public void exportExcel(@PathVariable String projListScope,@PathVariable String projCateScope, PubProj proj, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String[] titles = new String[]{
			"projYear:年份",
			"projTypeName:项目类别",
			"projName:项目名称",
			"projNo:立项编号",
			"projStartTime:开始时间",
			"projEndTime:结束时间",
			"applyUserName:项目负责人",
			"projStageName:当前阶段",
			"projStatusName:当前状态",
			"applyOrgName:申报单位"
		};
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		proj.setProjCategoryId(getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE).toString());
		proj.setProjStageId(ProjStageEnum.Approve.getId());//申报阶段
		proj.setProjStatusId(ProjApproveStatusEnum.Approving.getId());
		List<PubProj> projList = projApproveBiz.searchApproveProjList(proj);
		String fileName = "项目导出表.xls";
		fileName = URLEncoder.encode(fileName, "UTF-8");
		ExcleUtile.exportSimpleExcle(titles, projList, PubProj.class, response.getOutputStream());
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
		response.setContentType("application/octet-stream;charset=UTF-8");
	}
	
	
	/**
	 * 显示立项界面
	 * @return
	 */
	@RequestMapping("/setUp")
	public String setUp(@RequestParam(value="projFlow")String projFlow , Model model){
		PubProj proj = this.pubProjBiz.readProject(projFlow);
		model.addAttribute("proj" , proj);
		//该项目类型立项是否需要表单
		String pageGroupName = InitConfig.configMap.get(ProjRecTypeEnum.SetUp.getId()).get(proj.getProjTypeId());
		PageGroup pageGroup = InitConfig.projSetUpPageMap.get(pageGroupName);
		if(pageGroup!=null){
			Page page = pageGroup.getPageMap().get(pageGroup.getFirstPage());
			String setupFormPath = page.getJsp();
			model.addAttribute("setupFormPath" , setupFormPath);
		}
		
		SrmExpertProjEval evalSet = this.evalSetBiz.searchSrmExpertGroupProjByProjFlowAndEvaluationId(projFlow, EvaluationEnum.ApproveEvaluation.getId());
		model.addAttribute("evalSet" , evalSet);
		if(evalSet!=null){
			if(EvaluationWayEnum.MeetingWay.getId().equals(evalSet.getEvaluationWayId())){
				//如果是会议评审 需要查询会议的信息
				SrmExpertGroup meeting = this.experGroupBiz.readSrmExpertGroup(evalSet.getGroupFlow());
				model.addAttribute("meeting" , meeting);
			}
			//根据evalSetFlow 查询评审涉及到的专家和得分
			String evalSetFlow = evalSet.getEvalSetFlow();
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setEvalSetFlow(evalSetFlow);
			List<SrmExpertProjExt> expertProjList = this.expertProjBiz.searchExpertProjExtAndUserExt(expertProj);
			model.addAttribute("expertProjList" , expertProjList);
			
		}
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/approve/setUp_"+projCateScope;
		
	}
	
	@RequestMapping("/saveSetUp")
	@ResponseBody
	public String saveSetUp(PubProj proj , String pageName , HttpServletRequest request , Model model){
		String remark = "";
		String result = request.getParameter("result");
		proj.setProjStageId(ProjStageEnum.Approve.getId());
		proj.setProjStageName(ProjStageEnum.Approve.getName());
		if(GlobalConstant.FLAG_Y.equals(result)){
			//检查立项编号是否唯一
			List<PubProj> projList = projApproveBiz.getPubProjByProjNo(proj.getProjNo());
			if(projList!=null && !projList.isEmpty()){
				return GlobalConstant.FLAG_N;
			}
			proj.setProjStatusId(ProjApproveStatusEnum.Approve.getId());
			proj.setProjStatusName(ProjApproveStatusEnum.Approve.getName());
			remark = ProcessRemarkEnum.ApproveAgree.getName();
		}else if(GlobalConstant.FLAG_N.equals(result)){
			proj.setProjStatusId(ProjApproveStatusEnum.NotApprove.getId());
			proj.setProjStatusName(ProjApproveStatusEnum.NotApprove.getName());
			remark = ProcessRemarkEnum.ApproveNotAgree.getName();
		}
		String sug = (String)request.getParameter("sug");
		
		String setUpXml = "";
		PubProj exitProj = this.pubProjBiz.readProject(proj.getProjFlow());
		Page page = _getPage(pageName , exitProj.getProjTypeId());
		if(page!=null){
			Map<String , String[]> dataMap = JspFormUtil.getParameterMap(request);
			setUpXml = JspFormUtil.updateXmlStr("",page, dataMap);
		}
		this.projApproveBiz.setUp(proj , remark , sug , setUpXml);
		return GlobalConstant.FLAG_Y;
	}
	
	private Page _getPage(String pageName , String typeId){
		Map<String , String> pageProjTypeMap =  InitConfig.configMap.get(ProjRecTypeEnum.SetUp.getId());
		if(pageProjTypeMap!=null && !pageProjTypeMap.isEmpty()){
			String pageGroupName = pageProjTypeMap.get(typeId);
			if(pageGroupName!=null){
				PageGroup pageGroup = InitConfig.projSetUpPageMap.get(pageGroupName);
				if(pageGroup!=null){
					Page page = pageGroup.getPageMap().get(pageName);
					return page;
				}
			}
		}
		return null;
		
	}
	
	/**
	 * 下拨列表
	 * @return
	 */
	@RequestMapping("/fundPlanList")
	public String fundPlanList(PubProj proj , Integer currentPage ,HttpServletRequest request, Model model){
		//SysUser currUser = GlobalContext.getCurrentUser();
		//SysOrg sysOrg = new SysOrg();
		//申报单位
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
		    //加载所有同级单位
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
		    List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
			model.addAttribute("orgList",orgList);
		}
		List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
		model.addAttribute("chargeOrgList",chargeOrgList);
		
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProj> projList =  this.projApproveBiz.searchFundPlanList(proj);
		model.addAttribute("projList" , projList);
		return "srm/proj/approve/fundPlanList";
	}
	
	/**
	 * 编辑拨款计划
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/editFundPlan")
	public String editFundPlan(PubProjFundPlan  projFundPlan,  Model model){
		String projFlow = projFundPlan.getProjFlow();
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj" , proj);
		List<PubProjFundPlan> projFundPlanList = this.projApproveBiz.searchProjFundPlanList(projFundPlan);
		if(projFundPlanList != null && !projFundPlanList.isEmpty()){
			List<PubProjFundPlan> yearAmountList = new ArrayList<PubProjFundPlan>();
			for(PubProjFundPlan fp : projFundPlanList){
				if(ProjFundPlanTypeEnum.SumAmount.getId().equals(fp.getPlanTypeId())){
					model.addAttribute("sumAmount", fp);
				}
				if(ProjFundPlanTypeEnum.MatchingAmount.getId().equals(fp.getPlanTypeId())){
					model.addAttribute("matchingAmount", fp);
				}
				if(ProjFundPlanTypeEnum.YearAmount.getId().equals(fp.getPlanTypeId())){
					yearAmountList.add(fp);
				}
			}
			model.addAttribute("yearAmountList", yearAmountList);
		}
		model.addAttribute("projFundPlanList" , projFundPlanList);
		return "srm/proj/approve/editFundPlan";
	}
	
	/**
	 * 保存项目拨款计划
	 * @param fundPlan
	 * @return
	 */
	@RequestMapping("/saveFundPlan")
	@ResponseBody
	public String saveFundPlan(HttpServletRequest request){
		String flag = request.getParameter("flag");
		List<PubProjFundPlan> fundPlans = new ArrayList<PubProjFundPlan>();
		PubProj proj = new PubProj();
		String projFlow = request.getParameter("projFlow");
		proj.setProjStageId(ProjStageEnum.Approve.getId());
		proj.setProjStageName(ProjStageEnum.Approve.getName());
		proj.setProjFlow(projFlow);
		if(ProjApproveStatusEnum.Save.getId().equals(flag)){
			proj.setProjStatusId(ProjApproveStatusEnum.Save.getId());
			proj.setProjStatusName(ProjApproveStatusEnum.Save.getName());
		}else if(ProjApproveStatusEnum.Confirm.getId().equals(flag)){
			proj.setProjStatusId(ProjApproveStatusEnum.Confirm.getId());
			proj.setProjStatusName(ProjApproveStatusEnum.Confirm.getName());
		}
		
		String sumAmount = request.getParameter("sumAmount");
		if(StringUtil.isBlank(sumAmount)){
			sumAmount = "0.0";
		}
		PubProjFundPlan sumFundPlan = new PubProjFundPlan();
		sumFundPlan.setProjFlow(projFlow);
		sumFundPlan.setAmount(new BigDecimal(sumAmount));
		sumFundPlan.setPlanTypeId(ProjFundPlanTypeEnum.SumAmount.getId());
		sumFundPlan.setPlanTypeName(ProjFundPlanTypeEnum.SumAmount.getName());
		fundPlans.add(sumFundPlan);
		
		String matchingAmount = request.getParameter("matchingAmount");
		if(StringUtil.isBlank(matchingAmount)){
			matchingAmount = "0.0";
		}
		PubProjFundPlan govFundPlan = new PubProjFundPlan();
		govFundPlan.setProjFlow(projFlow);
		govFundPlan.setAmount(new BigDecimal(matchingAmount));
		govFundPlan.setPlanTypeId(ProjFundPlanTypeEnum.MatchingAmount.getId());
		govFundPlan.setPlanTypeName(ProjFundPlanTypeEnum.MatchingAmount.getName());
		fundPlans.add(govFundPlan);
		
		String[] yearAmounts = request.getParameterValues("yearAmount");
		PubProjFundPlan yearFundPlan;
		for(int i =0 ; i<yearAmounts.length;i++){
			String yearAmount = yearAmounts[i];
			yearFundPlan = new PubProjFundPlan();
			yearFundPlan.setPlanTypeId(ProjFundPlanTypeEnum.YearAmount.getId());
			yearFundPlan.setPlanTypeName(ProjFundPlanTypeEnum.YearAmount.getName());
			yearFundPlan.setYear(String.valueOf(i));
			yearFundPlan.setProjFlow(projFlow);
			if(StringUtil.isBlank(yearAmount)){
				yearFundPlan.setAmount(null);
			}else{
				yearFundPlan.setAmount(new BigDecimal(yearAmount));
			}
			fundPlans.add(yearFundPlan);
		}
		this.projApproveBiz.addFundPlan(proj, fundPlans , flag);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value={"/checkProjNo"},method={RequestMethod.GET})
	@ResponseBody
	public String checkProjNo(String projNo,  Model model){
		if(StringUtil.isNotBlank(projNo)){
			List<PubProj> projList = projApproveBiz.getPubProjByProjNo(projNo);
			if(projList != null && !projList.isEmpty()){
				return GlobalConstant.FLAG_N;
			}else{
				return GlobalConstant.FLAG_Y;
			}
		}
		return null;
	}
}
