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
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/srm/proj/complete")
public class ProjCompleteController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ProjCompleteController.class);
	
	@Autowired
	private IProjCompleteBiz projCompleteBiz; 
	@Autowired
	private IProjRecBiz projRecBiz; 
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IOrgBiz orgBiz;

	/**
	 * 显示审核列表
	 * @param projListScope
	 * @param recTypeId
	 * @param proj
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj, Integer currentPage , Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		proj.setProjStageId(ProjStageEnum.Complete.getId());
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			//proj.setProjStatusId(ProjApplyStatusEnum.Submit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projCompleteBiz.searchLocalProj(proj, recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			//proj.setProjStatusId(ProjApplyStatusEnum.FirstAudit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projCompleteBiz.searchChargeProj(proj,recTypeId);
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(currUser.getOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(projListScope)){
			if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
				//加载所有同级单位
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}else if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projCompleteBiz.searchGlobalProj(proj,recTypeId);
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		model.addAttribute("projList",projList);
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		return "srm/proj/complete/list_"+projCateScope;
	}
	
	
	@RequestMapping(value = {"/audit" },method={RequestMethod.GET})
	public  String  audit( String projFlow, Model model,HttpServletRequest request) {
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/complete/audit_"+projCateScope;
	}
	
	
	@RequestMapping(value = {"/saveAudit/{projListScope}/{projCateScope}" },method={RequestMethod.POST})
	@ResponseBody
	public   String  saveAudit(String projFlow, @PathVariable String projListScope,@PathVariable String projCateScope,String remark,String agreeFlag,String auditContent, Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		this.projCompleteBiz.completeAudit(projFlow, ProjRecTypeEnum.CompleteReport.getId(), projListScope, agreeFlag, auditContent);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
}
