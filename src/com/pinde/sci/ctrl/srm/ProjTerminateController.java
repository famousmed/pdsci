package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjCompleteBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IProjTerminateBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

/**
 * 中止功能的controller
 * @author wuhao
 *
 */
@Controller
@RequestMapping("/srm/proj/terminate")
public class ProjTerminateController extends GeneralController{

	private static Logger logger = LoggerFactory.getLogger(ProjCompleteController.class);
	
	@Autowired
	private IProjTerminateBiz projTerminateBiz;
	@Autowired
	private IProjCompleteBiz projCompleteBiz;
	@Autowired
	private IProjRecBiz projRecBiz; 
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	@RequestMapping(value="/list/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj, Integer currentPage , Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		proj.setProjCategoryId(projCateScope);
		proj.setProjStageId(ProjStageEnum.Complete.getId());
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			//proj.setProjStatusId(ProjApplyStatusEnum.Submit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = this.projCompleteBiz.searchLocalProj(proj, recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			//proj.setProjStatusId(ProjApplyStatusEnum.FirstAudit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = this.projCompleteBiz.searchChargeProj(proj,recTypeId);
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(currUser.getOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
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
			projList = this.projCompleteBiz.searchGlobalProj(proj,recTypeId);
			//List<SysOrg> chargeOrgList = this.orgBiz.searchOrgListByChargeOrgFlow(currUser.getOrgFlow());
			//model.addAttribute("chargeOrgList",chargeOrgList);
		}
		model.addAttribute("projList",projList);
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		return  "srm/proj/terminate/list_"+projCateScope;
	}
	
	@RequestMapping(value = {"/audit" },method={RequestMethod.GET})
	public  String  audit( String projFlow, Model model,HttpServletRequest request) {
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/terminate/audit_"+projCateScope;
	}
	
	@RequestMapping(value = {"/saveAudit/{projListScope}/{projCateScope}" },method={RequestMethod.POST})
	@ResponseBody
	public   String  saveAudit(String projFlow, @PathVariable String projListScope,@PathVariable String projCateScope,String remark,String agreeFlag,String auditContent, Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
//		PubProjRec rec = this.projRecBiz.selectProjRecByProjFlowAndRecType(projFlow, ProjRecTypeEnum.TerminateReport.getId());
//		if(rec!=null){
//			PubProj proj = pubProjBiz.readProject(rec.getProjFlow());
//			this.projRecBiz.changeRecStatusForAudit(ProjRecTypeEnum.TerminateReport.getId(),proj,rec,projListScope,agreeFlag,auditContent);
//		}
		this.projCompleteBiz.completeAudit(projFlow, ProjRecTypeEnum.TerminateReport.getId(), projListScope, agreeFlag, auditContent);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
}
