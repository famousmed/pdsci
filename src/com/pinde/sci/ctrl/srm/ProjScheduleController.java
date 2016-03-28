package com.pinde.sci.ctrl.srm;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IProjScheduleBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.PubProjRecExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/srm/proj/schedule")
public class ProjScheduleController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ProjScheduleController.class);
	
	@Autowired
	private IProjScheduleBiz projScheduleBiz; 
	@Autowired
	private IProjRecBiz pubProjRecBiz; 
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IOrgBiz orgBiz;
	
	@RequestMapping(value="/list/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj , Integer currentPage , Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		//手动设置阶段 此时阶段是申报阶段
		proj.setProjStageId(ProjStageEnum.Schedule.getId());//手动设置查询阶段
		//手动设置项目类型
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projScheduleBiz.searchLocalProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
			proj.setProjStatusId(ProjScheduleStatusEnum.FirstAudit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projScheduleBiz.searchChargeProj(proj,recTypeId);
			//加载下级医院
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(currUser.getOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
				//加载所有同级单位
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}else if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projScheduleBiz.searchGlobalProj(proj,recTypeId);
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		model.addAttribute("projList",projList);
		return  "srm/proj/schedule/list_"+projCateScope;
	}
	
	
	@RequestMapping(value="/exportExcel/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public void exportExcel(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj,HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		//手动设置阶段 此时阶段是申报阶段
		proj.setProjStageId(ProjStageEnum.Schedule.getId());//手动设置查询阶段
		//手动设置项目类型
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			projList = projScheduleBiz.searchLocalProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
			proj.setProjStatusId(ProjScheduleStatusEnum.FirstAudit.getId());
			projList = projScheduleBiz.searchChargeProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			projList = projScheduleBiz.searchGlobalProj(proj,recTypeId);
		}
		String fileName = "项目导出表.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, projList, PubProj.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
	
	
	@RequestMapping(value = {"/recList" },method={RequestMethod.GET})
	public  String  recList( String projFlow, Model model,HttpServletRequest request) {
		PubProjRecExample example = new PubProjRecExample();
		Criteria criteria  = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andProjFlowEqualTo(projFlow);
		if(ProjRecTypeEnum.ScheduleReport.getId().equals(getSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE))){
			criteria.andRecTypeIdEqualTo(ProjRecTypeEnum.ScheduleReport.getId());
		}else if(ProjRecTypeEnum.ChangeReport.getId().equals(getSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE))){
			criteria.andRecTypeIdEqualTo(ProjRecTypeEnum.ChangeReport.getId());
		}else if(ProjRecTypeEnum.TerminateReport.getId().equals(getSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE))){
			criteria.andRecTypeIdEqualTo(ProjRecTypeEnum.TerminateReport.getId());
		}
		example.setOrderByClause("OPER_TIME desc");
		List<PubProjRec> recList = pubProjRecBiz.searchProjRec(example);
		model.addAttribute("recList", recList);
		
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/schedule/recList_"+projCateScope;
	}
	
	@RequestMapping(value = {"/audit" },method={RequestMethod.GET})
	public String  audit( String recFlow, Model model,HttpServletRequest request) {
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		return "srm/proj/schedule/audit_"+projCateScope;
	}
	
	@RequestMapping(value = {"/saveAudit/{projListScope}/{projCateScope}" },method={RequestMethod.POST})
	@ResponseBody
	public   String  saveAudit( String recFlow,@PathVariable String projListScope,@PathVariable String projCateScope,String remark,String agreeFlag,String auditContent, Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		//PubProjRec rec = pubProjRecBiz.readProjRec(recFlow);
		//PubProj proj = pubProjBiz.readProject(rec.getProjFlow());
		this.projScheduleBiz.scheduleAudit(recFlow, projListScope, agreeFlag, auditContent);
		return GlobalConstant.SAVE_SUCCESSED;
	}
}
