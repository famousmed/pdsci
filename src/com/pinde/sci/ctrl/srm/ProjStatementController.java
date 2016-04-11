package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pinde.sci.biz.srm.IProjStatementBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.PubStatementExt;
import com.pinde.sci.model.srm.ReportForm;

@Controller
@RequestMapping("/srm/statement")
public class ProjStatementController extends GeneralController{
  
	@Autowired
	private IProjStatementBiz statementBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IPubProjBiz projBiz;
	
	@RequestMapping(value="/test")
	public String makeStatement(Model model,HttpServletRequest request){
		SysUser currUser=GlobalContext.getCurrentUser();
		PubProj proj=new PubProj();
		//存放报表明细项
		List<PubStatementExt> statementList=new ArrayList<PubStatementExt>();
		//存放合计明细项
		List<PubStatementExt> sumList=new ArrayList<PubStatementExt>();
		//定义用于统计的变量
		Integer allProjCount;
		Integer noSubmitProjCount;
		Integer submitProjCount;
		Integer approvingProjCount;
		Integer approveProjCount;
		//定义报表明细项对象
		PubStatementExt pubStatementExt;
	
		//查找当前机构所有下属机构
		List<SysOrg> orgList=orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
		/*List<SysOrg> needRemoveOrgList=new ArrayList<SysOrg>();
		for(SysOrg org:orgList){
			if(org.getOrgFlow().equals(currUser.getOrgFlow())){
				needRemoveOrgList.add(org);
			}
		}
		orgList.removeAll(needRemoveOrgList);*/
		//读取项目类型字典
		List<SysDict> projTypeList = new ArrayList<SysDict>();
		List<SysDict> kyList=(List<SysDict>) request.getServletContext().getAttribute("dictTypeEnumProjTypeList");
		List<SysDict> xkList=(List<SysDict>) request.getServletContext().getAttribute("dictTypeEnumSubjTypeList");
		List<SysDict> rcList=(List<SysDict>) request.getServletContext().getAttribute("dictTypeEnumTalentTypeList");
		if( kyList!=null &&  !kyList.isEmpty()){
			projTypeList.addAll(kyList);
		}
		if(null!=xkList && !xkList.isEmpty()){
			projTypeList.addAll(xkList);
		}
		if(null!=rcList && !rcList.isEmpty()){
			projTypeList.addAll(rcList);
		}

		//遍历所有下属机构和项目类型，查询指定机构指定项目类型所有项目
		for(SysOrg org:orgList){
			for(SysDict dict:projTypeList){
				proj.setApplyOrgFlow(org.getOrgFlow());
				proj.setProjTypeId(dict.getDictId());
				List<PubProj> projList=statementBiz.searchPuisneProj(proj);
				//统计各个状态的数量
				allProjCount=new Integer(0);
				noSubmitProjCount=new Integer(0);
				submitProjCount=new Integer(0);
				approvingProjCount=new Integer(0);
				approveProjCount=new Integer(0);
				pubStatementExt=new PubStatementExt();
				for(PubProj pp:projList){
					//计算项目总数
					allProjCount++;
					//计算未提交的项目数量
					 if(ProjStageEnum.Apply.getId().equals(pp.getProjStageId()) && ProjApplyStatusEnum.Apply.getId().equals(pp.getProjStatusId())){
						 noSubmitProjCount++;
					 }
					 //计算立项中的项目数量
					 if(ProjStageEnum.Approve.getId().equals(pp.getProjStageId())&& ProjApproveStatusEnum.Approving.getId().equals(pp.getProjStatusId())){
						 approvingProjCount++;
					 }
					 //计算立项通过的项目数量
					 if(ProjStageEnum.Contract.getId().equals(pp.getProjStageId())
							  || ProjStageEnum.Schedule.getId().equals(pp.getProjStageId())
							  || ProjStageEnum.Complete.getId().equals(pp.getProjStageId())
							  || ProjStageEnum.Archive.getId().equals(pp.getProjStageId())){
						 approveProjCount++;  
					}   	 
			}
				submitProjCount= allProjCount-noSubmitProjCount;
				//组织数据
				   pubStatementExt.setOrgFlow(org.getOrgFlow());
				   pubStatementExt.setOrgName(org.getOrgName());
				   pubStatementExt.setProjTypeName(dict.getDictId());
				   pubStatementExt.setProjTypeName(dict.getDictName());
				   pubStatementExt.setAllProjCount(allProjCount);
				   pubStatementExt.setNoSubmitProjCount(noSubmitProjCount);
				   pubStatementExt.setSubmitProjCount(submitProjCount);
				   pubStatementExt.setApprovingProjCount(approvingProjCount);
				   pubStatementExt.setApproveProjCount(approveProjCount);
				   statementList.add(pubStatementExt);
		  }
			   pubStatementExt=new PubStatementExt();
			   pubStatementExt.setOrgFlow(org.getOrgFlow());
			   pubStatementExt.setOrgName(org.getOrgName());
			   pubStatementExt.setProjTypeName("合     计");
			   pubStatementExt.setProjTypeId("hj");
			   pubStatementExt.setAllProjCount(0);
			   pubStatementExt.setNoSubmitProjCount(0);
			   pubStatementExt.setSubmitProjCount(0);
			   pubStatementExt.setApprovingProjCount(0);
			   pubStatementExt.setApproveProjCount(0);
			   for(PubStatementExt statementExt:statementList){
				   if(statementExt.getOrgFlow().equals(pubStatementExt.getOrgFlow())){
					   pubStatementExt.setAllProjCount(pubStatementExt.getAllProjCount()+statementExt.getAllProjCount());
					   pubStatementExt.setNoSubmitProjCount(pubStatementExt.getNoSubmitProjCount()+statementExt.getNoSubmitProjCount());
					   pubStatementExt.setSubmitProjCount(pubStatementExt.getSubmitProjCount()+statementExt.getSubmitProjCount());
					   pubStatementExt.setApprovingProjCount(pubStatementExt.getApprovingProjCount()+statementExt.getApprovingProjCount());
					   pubStatementExt.setApproveProjCount(pubStatementExt.getApproveProjCount()+statementExt.getApproveProjCount());
				   }
			   }
			   sumList.add(pubStatementExt);
   }
		
		  model.addAttribute("orgList", orgList);
		  model.addAttribute("projTypeList",projTypeList);
		  model.addAttribute("statementList", statementList);
		  model.addAttribute("sumList", sumList);
		  return "srm/statement/list";
	}
	
	@RequestMapping(value="/list")
	public String showReportForm(PubProj proj , Model model){
		List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
		model.addAttribute("chargeOrgList",chargeOrgList);
		List<ReportForm> reportForms = this.projBiz.findReportForm(proj);
		model.addAttribute("reportForms", reportForms);
		
		return "srm/statement/reportForm";
	}
}
