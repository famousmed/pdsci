package com.pinde.sci.ctrl.srm;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.EnumUtil;
import com.pinde.core.util.ExcleUtile;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundInfoBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IProjSearchBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjArchiveStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.ListToExcel;

@Controller
@RequestMapping("/srm/proj/search")
public class ProjSearchController extends GeneralController {
	@Autowired
	private IProjSearchBiz projSeeBiz;
	@Autowired
	private IPubProjBiz pubProjBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IProjRecBiz pubProjRecBiz;
	@Autowired
	private IFundInfoBiz fundInfoBiz;

	@RequestMapping(value = "/list/{projListScope}/{projCateScope}")
	public String projList2(@PathVariable String projListScope,
			@PathVariable String projCateScope, PubProj proj,
			String flag,Integer currentPage ,HttpServletRequest request, Model model) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		
		SysUser currUser = GlobalContext.getCurrentUser();
		List<PubProj> projList = new ArrayList<PubProj>();
		//�ֶ����ý׶� ��ʱ�׶����걨�׶�
		//�ֶ�������Ŀ����
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setApplyOrgFlow(currUser.getOrgFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setChargeOrgFlow(currUser.getOrgFlow());
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

			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		if(StringUtil.isNotBlank(flag)){
			PageHelper.startPage(currentPage, getPageSize(request));
			projList = projSeeBiz.searchProj(proj);
			model.addAttribute("projList", projList);
		}
		return "srm/proj/search/list_" + projCateScope;
	}
	
	
	/**
	 * ����Excel
	 * @param projListScope
	 * @param projCateScope
	 * @param proj
	 * @param response
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/exportExcel/{projListScope}/{projCateScope}")
	public void exportExcel(@PathVariable String projListScope, @PathVariable String projCateScope, PubProj proj, HttpServletResponse response) throws IOException, Exception{
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
		List<PubProj> searchList = new ArrayList<PubProj>();
		proj.setProjCategoryId(projCateScope);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL .equals(projListScope)){
			proj.setApplyOrgFlow(currUser.getOrgFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE .equals(projListScope)){
			proj.setChargeOrgFlow(currUser.getOrgFlow());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL .equals(projListScope)){
		}
		searchList = projSeeBiz.searchProj(proj);
		List<PubProj> projList = new ArrayList<PubProj>();
		if(searchList != null && !searchList.isEmpty()){
			for(PubProj p :searchList){
				if((!ProjStageEnum.Apply.getId().equals(p.getProjStageId())) || (!ProjApplyStatusEnum.Apply.getId().equals(p.getProjStatusId()))){
					projList.add(p);
				}
			}
		}
	    String fileName = "��Ŀ������.xls";
	    fileName = URLEncoder.encode(fileName, "UTF-8");
	    ExcleUtile.exportSimpleExcle(titles, projList, PubProj.class, response.getOutputStream());
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}

	@RequestMapping(value = "/recList")
	public String recList(String projFlow, Model model,
			HttpServletRequest request) {
		List<PubProjRec> recList = new ArrayList<PubProjRec>();
		PubProj proj = pubProjBiz.readProject(projFlow);
		// ��ѯ����Ŀ������д״̬��rec��¼
		PubProjRec projRec = new PubProjRec();
		projRec.setProjFlow(projFlow);
		//recList = pubProjRecBiz.searchProjRecNotInApply(projRec);
		List<String> status=new ArrayList<String>();
	    status.add(ProjApplyStatusEnum.Apply.getId());
	    status.add(ProjContractStatusEnum.Apply.getId());
	    status.add(ProjScheduleStatusEnum.Apply.getId());
	    status.add(ProjCompleteStatusEnum.Apply.getId());
	    List<PubProjRec> recs = this.pubProjRecBiz.searchProjRec(projRec);
	    if(recs!=null){
	    	for(PubProjRec rec:recs){
				if(!status.contains(rec.getProjStatusId())){
					recList.add(rec);
				}
			}
	    	model.addAttribute("recCount" , recs.size());
	    }
		
		model.addAttribute("proj", proj);
		model.addAttribute("recList", recList);
		

		// ��ѯʵʩ�׶�����һ����չ�����������
		List<String> recTypeList = new ArrayList<String>();
		recTypeList.add(ProjRecTypeEnum.ChangeReport.getId());
		recTypeList.add(ProjRecTypeEnum.ScheduleReport.getId());
		List<PubProjRec> scheduleRecList = pubProjRecBiz
				.selectProjRecByProjFlowAndRecList(projFlow, recTypeList);
		if (null != scheduleRecList && !scheduleRecList.isEmpty()) {
			PubProjRec scheduleRec = scheduleRecList.get(0);
			model.addAttribute("scheduleRec", scheduleRec);
		}

		// ��ѯʵʩ�׶�����һ����չ�����������
		recTypeList.removeAll(recTypeList);
		recTypeList.add(ProjRecTypeEnum.CompleteReport.getId());
		recTypeList.add(ProjRecTypeEnum.TerminateReport.getId());
		List<PubProjRec> completeRecList = pubProjRecBiz
				.selectProjRecByProjFlowAndRecList(projFlow, recTypeList);
		if (null != completeRecList && !completeRecList.isEmpty()) {
			PubProjRec completeRec = completeRecList.get(0);
			model.addAttribute("completeRec", completeRec);
		}

		SrmProjFundInfo fundInfo = new SrmProjFundInfo();
		fundInfo.setProjFlow(projFlow);
		fundInfo.setBudgetStatusId(AchStatusEnum.Submit.getId());
		List<SrmProjFundInfo> fundInfoList = fundInfoBiz
				.searchFundInfo(fundInfo);
		if (null != fundInfoList && !fundInfoList.isEmpty()) {
			model.addAttribute("projBudget", fundInfoList.get(0)
					.getBudgetStatusId());
		}

		return "srm/proj/search/recList";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/loadProjStatus")
	@ResponseBody
	public Object loadProjStatus(
			@RequestParam(value = "projStageId", required = true) String projStageId) {
		Map<String, String> statusMap = null;
		if (ProjStageEnum.Apply.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjApplyStatusEnum.class);
			if (StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use"),
					"global")) {
				// �����
				statusMap.remove(ProjApplyStatusEnum.FirstBack.getId());
				statusMap.remove(ProjApplyStatusEnum.ThirdAudit.getId());
			} else {
				// ҽԺ��
				statusMap.remove(ProjApplyStatusEnum.FirstAudit.getId());
				statusMap.remove(ProjApplyStatusEnum.FirstBack.getId());
				statusMap.remove(ProjApplyStatusEnum.SecondAudit.getId());
				statusMap.remove(ProjApplyStatusEnum.SecondBack.getId());
				statusMap.remove(ProjApplyStatusEnum.ThirdAudit.getId());
				statusMap.remove(ProjApplyStatusEnum.ThirdBack.getId());
			}

		} else if (ProjStageEnum.Approve.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjApproveStatusEnum.class);
			statusMap.remove(ProjApproveStatusEnum.Approve.getId());
			statusMap.remove(ProjApproveStatusEnum.Save.getId());
			statusMap.remove(ProjApproveStatusEnum.Confirm.getId());
		} else if (ProjStageEnum.Contract.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjContractStatusEnum.class);
			if (StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use"),
					"global")) {
				// �����
				statusMap.remove(ProjContractStatusEnum.FirstBack.getId());
				statusMap.remove(ProjContractStatusEnum.ThirdAudit.getId());
			} else {
				// ҽԺ��
				statusMap.remove(ProjContractStatusEnum.FirstBack.getId());
				statusMap.remove(ProjContractStatusEnum.SecondAudit.getId());
				statusMap.remove(ProjContractStatusEnum.SecondBack.getId());
				statusMap.remove(ProjContractStatusEnum.ThirdAudit.getId());
				statusMap.remove(ProjContractStatusEnum.ThirdBack.getId());
			}
		} else if (ProjStageEnum.Schedule.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjScheduleStatusEnum.class);
			if (StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use"),
					"global")) {
				// �����
				statusMap.remove(ProjScheduleStatusEnum.FirstBack.getId());
			} else {
				// ҽԺ��
				statusMap.remove(ProjScheduleStatusEnum.FirstBack.getId());
				statusMap.remove(ProjScheduleStatusEnum.SecondAudit.getId());
				statusMap.remove(ProjScheduleStatusEnum.SecondBack.getId());
				statusMap.remove(ProjScheduleStatusEnum.ThirdAudit.getId());
				statusMap.remove(ProjScheduleStatusEnum.ThirdBack.getId());
			}
		} else if (ProjStageEnum.Complete.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjCompleteStatusEnum.class);
			if (StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use"),
					"global")) {
				// �����
				statusMap.remove(ProjCompleteStatusEnum.FirstBack.getId());
			} else {
				// ҽԺ��
				statusMap.remove(ProjCompleteStatusEnum.FirstBack.getId());
				statusMap.remove(ProjCompleteStatusEnum.SecondAudit.getId());
				statusMap.remove(ProjCompleteStatusEnum.SecondBack.getId());
				statusMap.remove(ProjCompleteStatusEnum.ThirdAudit.getId());
				statusMap.remove(ProjCompleteStatusEnum.ThirdBack.getId());
			}
		} else if (ProjStageEnum.Archive.getId().equals(projStageId)) {
			statusMap = EnumUtil.toMap(ProjArchiveStatusEnum.class);
		}
		return statusMap;
	}

	@RequestMapping(value = "/toExcel/{projListScope}/{projCateScope}")
	public ModelAndView toExcel(@PathVariable String projListScope,
			@PathVariable String projCateScope, PubProj proj, SysOrg org,
			String flag, Model model) {
		SysUser currUser = GlobalContext.getCurrentUser();
		List<SysOrg> currOrgChildList = orgBiz
				.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
		Map<String, List<SysOrg>> resultMap = orgBiz.searchChargeAndApply(org,
				projListScope);
		List<SysOrg> secondGradeOrgList = (List<SysOrg>) resultMap
				.get("secondGradeOrgList");
		List<PubProj> searchList = null;
		if (StringUtil.isNotBlank(flag)) {
			if (StringUtil.isBlank(org.getOrgFlow())
					&& StringUtil.isBlank(org.getChargeOrgFlow())) {
				searchList = projSeeBiz.searchProj(proj, currOrgChildList);
			}

			if (StringUtil.isNotBlank(org.getOrgFlow())) {
				proj.setApplyOrgFlow(org.getOrgFlow());
				searchList = projSeeBiz.searchProj(proj, null);
			}

			if (StringUtil.isBlank(org.getOrgFlow())
					&& StringUtil.isNotBlank(org.getChargeOrgFlow())) {
				if (null == secondGradeOrgList || secondGradeOrgList.isEmpty()) {
					SysOrg sysOrg = orgBiz.readSysOrg(org.getChargeOrgFlow());
					List<SysOrg> selfOrgList = new ArrayList<SysOrg>();
					selfOrgList.add(sysOrg);
					searchList = projSeeBiz.searchProj(proj, selfOrgList);
				} else {
					searchList = projSeeBiz
							.searchProj(proj, secondGradeOrgList);
				}
			}
			if (null != searchList && !searchList.isEmpty()) {
				Map<String, Object> objMap = new HashMap<String, Object>();
				objMap.put("projList", searchList);
				ListToExcel listToExcel = new ListToExcel();
				return new ModelAndView(listToExcel, objMap);
			}
		}

		return null;
	}

}
