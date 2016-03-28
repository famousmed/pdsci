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
import com.pinde.sci.biz.srm.IApplyLimitBiz;
import com.pinde.sci.biz.srm.IProjApplyBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.form.srm.ApplyLimitNumForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/srm/proj/apply")
public class ProjApplyController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ProjApplyController.class);
	
	@Autowired
	private IProjApplyBiz projApplyBiz; 
	@Autowired
	private IProjRecBiz projRecBiz; 
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IApplyLimitBiz applyLimitBiz;
	
	/**
	 * ��ʾ����б�
	 * @param projListScope
	 * @param recTypeId
	 * @param proj
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String projListScope,@PathVariable String projCateScope,String recTypeId, PubProj proj , Integer currentPage , Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		//�ֶ����ý׶� ��ʱ�׶����걨�׶�
		proj.setProjStageId(ProjStageEnum.Apply.getId());
		//�ֶ�������Ŀ����
		proj.setProjCategoryId(projCateScope);
		//���ڲ�ѯ�����б�
		//SysOrg sysOrg = new SysOrg();
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setProjStatusId(ProjApplyStatusEnum.Submit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projApplyBiz.searchLocalProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setProjStatusId(ProjApplyStatusEnum.FirstAudit.getId());
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projApplyBiz.searchChargeProj(proj,recTypeId);
			//�����¼�ҽԺ
			List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(currUser.getOrgFlow());
			model.addAttribute("orgList",orgList);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(projListScope)){
			if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
				//��������ͬ����λ
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}else if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(proj.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}

			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projApplyBiz.searchGlobalProj(proj,recTypeId);
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		model.addAttribute("projList",projList);
		setSessionAttribute(GlobalConstant.PROJ_RECORD_TYPE, recTypeId);
		return "srm/proj/apply/list_"+projCateScope;
		//return "srm/proj/apply/test2";
	}
	
	@RequestMapping(value="/exportExcel/{projListScope}/{projCateScope}", method={RequestMethod.POST,RequestMethod.GET})
	public void exportExcel(@PathVariable String projListScope, @PathVariable String projCateScope, String recTypeId, PubProj proj, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String[] titles = new String[]{
			"projYear:���",
			"projTypeName:��Ŀ���",
			"projName:��Ŀ����",
			"projNo:������",
			"projStartTime:��ʼʱ��",
			"projEndTime:����ʱ��",
			"applyUserName:��Ŀ������",
			"projStageName:��ǰ�׶�",
			"projStatusName:��ǰ״̬",
			"applyOrgName:�걨��λ"
		};
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		//�ֶ����ý׶� ��ʱ�׶����걨�׶�
		proj.setProjStageId(ProjStageEnum.Apply.getId());
		//�ֶ�������Ŀ����
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setProjStatusId(ProjApplyStatusEnum.Submit.getId());
			projList = projApplyBiz.searchLocalProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setProjStatusId(ProjApplyStatusEnum.FirstAudit.getId());
			projList = projApplyBiz.searchChargeProj(proj,recTypeId);
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(projListScope)){
			projList = projApplyBiz.searchGlobalProj(proj,recTypeId);
		}
		String fileName = "��Ŀ������.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, projList, PubProj.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
	
	
	/**
	 * �����˲���
	 * @param projFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value = {"/audit"},method={RequestMethod.GET})
	public  String  audit( String projFlow, Model model,HttpServletRequest request) {
		String projCateScope = (String) getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		PubProj proj = pubProjBiz.readProject(projFlow);
		model.addAttribute("proj",proj);
		return "srm/proj/apply/audit_"+projCateScope;
	}
	
	/**
	 * �������
	 * @param projListScope
	 * @param agreeFlag
	 * @param auditContent
	 * @param projFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveAudit/{projListScope}/{projCateScope}",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public String saveAudit(@PathVariable String projListScope,@PathVariable String projCateScope,String agreeFlag,String auditContent, String projFlow, Model model,HttpServletRequest request) {
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		this.projApplyBiz.applyAudit(projFlow,projListScope,agreeFlag,auditContent);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * �������ޱ���
	 * @param projListScope
	 * @param agreeFlag
	 * @param projFlow
	 * @return
	 */
	@RequestMapping(value="/checkApplyLimit/{projListScope}",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ApplyLimitNumForm checkApplyLimit(@PathVariable String projListScope, String agreeFlag, String projFlow) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		return applyLimitBiz.checkApplyLimit(projListScope, agreeFlag, projFlow);
	}

}
