package com.pinde.sci.ctrl.srm;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjContractBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
/**
 * 合同功能的controller
 * @author shenzhen
 *
 */
@Controller
@RequestMapping("/srm/proj/contract")
public class ProjContractController extends GeneralController{

	@Autowired
	private IPubProjBiz pubProjBiz;	
	@Autowired
	private IProjContractBiz projContractBiz;	
	@Autowired
	private IProjRecBiz projRecBiz;
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
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj,Integer currentPage , Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		proj.setProjCategoryId(projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		proj.setProjStageId(ProjStageEnum.Contract.getId());
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setProjStatusId(ProjContractStatusEnum.Submit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projContractBiz.searchLocalProj(proj, recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setProjStatusId(ProjContractStatusEnum.FirstAudit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projContractBiz.searchChargeProj(proj,recTypeId);
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
			projList = projContractBiz.searchGlobalProj(proj,recTypeId);
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		model.addAttribute("projList",projList);
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		return "srm/proj/contract/list_"+projCateScope;
	}
	
	@RequestMapping(value="/exportExcel/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public void exportExcel(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj,HttpServletRequest request,HttpServletResponse response) throws Exception, Exception {
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
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		proj.setProjCategoryId(projCateScope);
		List<PubProj> projList = new ArrayList<PubProj>();
		proj.setProjStageId(ProjStageEnum.Contract.getId());
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setProjStatusId(ProjContractStatusEnum.Submit.getId());
			projList = projContractBiz.searchLocalProj(proj, recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setProjStatusId(ProjContractStatusEnum.FirstAudit.getId());
			projList = projContractBiz.searchChargeProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(projListScope)){
			projList = projContractBiz.searchGlobalProj(proj,recTypeId);
		}
		String fileName = "项目导出表.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, projList, PubProj.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
	

	@RequestMapping(value = {"/audit" },method={RequestMethod.GET})
	public  String  audit(String projFlow, Model model,HttpServletRequest request) {
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/contract/audit_"+projCateScope;
	}
	
	@RequestMapping(value = {"/saveAudit/{projListScope}/{projCateScope}" },method={RequestMethod.POST})
	@ResponseBody
	public String saveAudit(String projFlow, @PathVariable String projListScope,@PathVariable String projCateScope,String remark,String agreeFlag,String auditContent, Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		this.projContractBiz.contractAudit(projFlow, projListScope, agreeFlag, auditContent);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 合同卫生局审核通过后需要退回(非流程操作)
	 * @return
	 */
	@RequestMapping("/controctbackforthridaudit")
	@ResponseBody
	public String controctBackForThridAudit(String recFlow){
		this.projContractBiz.controctBackForThridAudit(recFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}
}
