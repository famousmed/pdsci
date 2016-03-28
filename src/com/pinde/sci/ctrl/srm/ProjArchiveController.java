 package com.pinde.sci.ctrl.srm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjArchiveBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.ProjArchiveStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;


@Controller
@RequestMapping("/srm/proj/archive")
public class ProjArchiveController extends GeneralController{
	
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IProjArchiveBiz projArchiveBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;	
	@Autowired
	private IProjProcessBiz projProcessBiz;

	
	@RequestMapping(value="/list/{projListScope}/{projCateScope}")
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope, PubProj proj, Integer currentPage ,HttpServletRequest request, Model model){
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		//SysUser currUser = GlobalContext.getCurrentUser();
		
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			proj.setProjStatusId(ProjCompleteStatusEnum.FirstAudit.getId());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			proj.setProjStatusId(ProjCompleteStatusEnum.ThirdAudit.getId());
		}
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
		
		proj.setProjStageId(ProjStageEnum.Complete.getId());
		proj.setRecordStatus(GlobalConstant.FLAG_Y);
		proj.setProjCategoryId(projCateScope);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProj> projList=projArchiveBiz.searchProj(proj);
		model.addAttribute("projList", projList);
		return "srm/proj/archive/list_"+projCateScope;
	}
    
	/**
	 * 显示审核界面
	 * @return
	 */
	@RequestMapping("/audit")
	public String setUp(@RequestParam(value="projFlow")String projFlow , Model model){
		PubProj proj = this.pubProjBiz.readProject(projFlow);
		model.addAttribute("proj" , proj);
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/archive/audit_"+projCateScope;
		
	}
	
	@RequestMapping("/saveAudit/{projListScope}/{projCateScope}")
	@ResponseBody
	public String saveAudit(PubProj proj , @PathVariable String projListScope,@PathVariable String projCateScope, HttpServletRequest request , Model model){
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		String sug = (String)request.getParameter("sug");
		PubProj project = null;
		PubProjProcess process=null;
		if(StringUtil.isNotBlank(proj.getProjFlow())){    
			project = this.pubProjBiz.readProject(proj.getProjFlow()); 
			process=new PubProjProcess();
			process.setProjFlow(proj.getProjFlow());
			process.setProjStageId(ProjStageEnum.Archive.getId());
			process.setProjStageName(ProjStageEnum.Archive.getName());
			process.setAuditContent(sug);
			project.setProjStageId(ProjStageEnum.Archive.getId());
			project.setProjStageName(ProjStageEnum.Archive.getName());
		}
		String result = request.getParameter("result");
		//同意
		if(GlobalConstant.FLAG_Y.equals(result)){
			project.setProjStatusId(ProjArchiveStatusEnum.Archive.getId());
			project.setProjStatusName(ProjArchiveStatusEnum.Archive.getName());
			process.setProjStatusId(ProjArchiveStatusEnum.Archive.getId());
			process.setProjStatusName(ProjArchiveStatusEnum.Archive.getName());
		}
		//不同意 
		else if(GlobalConstant.FLAG_N.equals(result)){
			project.setProjStatusId(ProjArchiveStatusEnum.NotArchive.getId());
			project.setProjStatusName(ProjArchiveStatusEnum.NotArchive.getName());
			process.setProjStatusId(ProjArchiveStatusEnum.NotArchive.getId());
			process.setProjStatusName(ProjArchiveStatusEnum.NotArchive.getName());
		}
		  //调用Biz
		projArchiveBiz.saveArchiveResult(project, process);      
		return GlobalConstant.OPRE_SUCCESSED;
	}
}
