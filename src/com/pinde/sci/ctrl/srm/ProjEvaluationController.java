package com.pinde.sci.ctrl.srm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.biz.srm.IGradeSchemeBiz;
import com.pinde.sci.biz.srm.IProjEvaluationBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.srm.EvaluationEnum;
import com.pinde.sci.enums.srm.EvaluationStatusEnum;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmGradeScheme;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.ExpertInfo;
import com.pinde.sci.model.srm.PubProjExt;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;

@Controller
@RequestMapping("/srm/proj/evaluation")
public class ProjEvaluationController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(ProjEvaluationController.class);
	
	@Autowired
	private IProjEvaluationBiz projEvaluationBiz; 
	@Autowired
	private IExpertGroupProjBiz expertGroupProjBiz;
	@Autowired
	private IExpertProjBiz expertProjBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IExpertGroupsUserBiz expertGroupUserBiz;
	@Autowired
	private IExpertGroupBiz experGroupBiz;
	@Autowired
	private IGradeSchemeBiz gradeSchemeBiz;
	@Autowired
	private IExpertBiz expertBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private IPubProjBiz projBiz; 
	
	/**
	 * 立项评审页面
	 * @param projListScope
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/approveList/{projListScope}/{projCateScope}",method={RequestMethod.GET,RequestMethod.POST})
	public String approveList(@PathVariable String projListScope,@PathVariable String projCateScope,
			String projFlow,PubProjExt projExt , Integer currentPage ,HttpServletRequest request, Model model) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		//SysUser currUser = GlobalContext.getCurrentUser();
		if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			//申报单位
			if(StringUtil.isNotBlank(projExt.getApplyOrgFlow())){
				//加载所有同级单位
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(projExt.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}else if(StringUtil.isNotBlank(projExt.getChargeOrgFlow())){
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(projExt.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		projExt.setProjStageId(ProjStageEnum.Approve.getId());
		projExt.setProjStatusId(ProjApproveStatusEnum.Approving.getId());
		projExt.setRecordStatus(GlobalConstant.FLAG_Y);
		projExt.setProjFlow(projFlow);
		projExt.setProjCateScope(projCateScope);
		SrmExpertProjEval srmExpertGroupProj = new SrmExpertProjEval();
		srmExpertGroupProj.setEvaluationId(EvaluationEnum.ApproveEvaluation.getId());//查询条件为立项评审的
		projExt.setSrmExpertGroupProj(srmExpertGroupProj);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProjExt> projList = projEvaluationBiz.searchProjList(projExt);
		model.addAttribute("projList",projList);
		model.addAttribute("evaluationId", EvaluationEnum.ApproveEvaluation.getId());//立项评审标志
		return "srm/proj/evaluation/list_"+projCateScope;
	}
	
	/**
	 * 验收评审页面
	 * @param projListScope
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/completeList/{projListScope}/{projCateScope}",method={RequestMethod.GET,RequestMethod.POST})
	public String completeList(@PathVariable String projListScope,@PathVariable String projCateScope,
			String projFlow,PubProjExt projExt , SysOrg org ,Integer currentPage ,HttpServletRequest request, Model model) {
		setSessionAttribute(GlobalConstant.PROJ_LIST_SCOPE, projListScope);
		setSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE, projCateScope);
		//SysUser currUser = GlobalContext.getCurrentUser();
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			projExt.setProjStatusId(ProjCompleteStatusEnum.FirstAudit.getId());
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			projExt.setProjStatusId(ProjCompleteStatusEnum.ThirdAudit.getId());
			//申报单位
			if(StringUtil.isNotBlank(projExt.getApplyOrgFlow())){
				//加载所有同级单位
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(projExt.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}else if(StringUtil.isNotBlank(projExt.getChargeOrgFlow())){
				List<SysOrg> orgList = this.orgBiz.searchOrgListByChargeOrgFlow(projExt.getChargeOrgFlow());
				model.addAttribute("orgList",orgList);
			}
			List<SysOrg> chargeOrgList = this.orgBiz.searchChargeOrg();
			model.addAttribute("chargeOrgList",chargeOrgList);
		}
		projExt.setProjStageId(ProjStageEnum.Complete.getId());
		projExt.setRecordStatus(GlobalConstant.FLAG_Y);
		projExt.setProjFlow(projFlow);
		projExt.setRecTypeId(ProjRecTypeEnum.CompleteReport.getId());
		SrmExpertProjEval srmExpertGroupProj = new SrmExpertProjEval();
		srmExpertGroupProj.setEvaluationId(EvaluationEnum.CompleteEvaluation.getId());//查询条件为验收评审的
		projExt.setSrmExpertGroupProj(srmExpertGroupProj);
		PageHelper.startPage(currentPage, getPageSize(request));
		List<PubProjExt> projList = projEvaluationBiz.searchProjList(projExt);
		model.addAttribute("projList",projList);
		model.addAttribute("evaluationId", EvaluationEnum.CompleteEvaluation.getId());//验收评审标志
		return "srm/proj/evaluation/list_"+projCateScope;
	}
	
	/**
	 * 评审设置
	 * @param projFlow
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/groupProjConfig",method={RequestMethod.GET})
	public String groupProjConfig(String projFlow , String evaluationId ,String groupFlow,Model model){
		
		PubProj proj = projBiz.readProject(projFlow);
		model.addAttribute("proj", proj);
		
		SrmExpertProjEval groupProj = expertGroupProjBiz.searchSrmExpertGroupProjByProjFlowAndEvaluationId(projFlow, evaluationId);
		model.addAttribute("groupProj", groupProj);
		
		if(groupProj!=null){
			if(StringUtil.isBlank(groupFlow)){
				groupFlow = groupProj.getGroupFlow();
			}
			List<ExpertInfo> expertInfoList = new ArrayList<ExpertInfo>();
			//已选择委员
			List<SrmExpertProj> expertProjList = expertProjBiz.searchExperProjByEvaluationFlow(groupProj.getEvalSetFlow());
			for(SrmExpertProj sep:expertProjList){
				ExpertInfo expertInfo = new ExpertInfo();
				SrmExpert expert = this.expertBiz.readExpert(sep.getUserFlow());
				SysUser user = this.userBiz.readSysUser(sep.getUserFlow());
				 expertInfo.setExpert(expert);
				 expertInfo.setUser(user);
				 expertInfoList.add(expertInfo);
			}
			model.addAttribute("expertInfoList" , expertInfoList);
			Map<String,SrmExpertProj> expertProjMap =  new HashMap<String, SrmExpertProj>();
			for(SrmExpertProj record : expertProjList){
				expertProjMap.put(record.getUserFlow(), record);
			}
			model.addAttribute("expertProjMap",expertProjMap);
			
		}
		
		//今天之后的会议
		SrmExpertGroup expert = new SrmExpertGroup();
		expert.setEvaluationWayId(EvaluationWayEnum.MeetingWay.getId()); 
		List<SrmExpertGroup> meetList = this.experGroupBiz.searchExpertGroup(expert);
		//过滤今天之前的会议
		List<SrmExpertGroup> groupList = new ArrayList<SrmExpertGroup>();
		for(SrmExpertGroup temp : meetList){
			if(temp.getMeetingDate().compareTo(DateUtil.getCurrDate())>-1){
				groupList.add(temp);
			}
		}
		model.addAttribute("groupList" , groupList);
		if(StringUtil.isNotBlank(groupFlow)){ 
			SrmExpertGroup group = experGroupBiz.readSrmExpertGroup(groupFlow);
			model.addAttribute("group",group);
			
			//查询当前会议中分配的专家
			SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
			groupUser.setGroupFlow(groupFlow);//根据流水号获取当前专家的信息expertGroupUserBiz
			List<ExpertInfo> expertMeetingInfoList = this.expertGroupUserBiz.searchExpertGroupUserInfo(groupUser);//查询专家组中对应的专家信息
			model.addAttribute("expertMeetingInfoList",expertMeetingInfoList);	
		}
		
		//评分方案
		SrmGradeScheme srmGradeScheme = new SrmGradeScheme();
		srmGradeScheme.setEvaluationId(evaluationId);
		List<SrmGradeScheme> schemes = gradeSchemeBiz.searchGradeScheme(srmGradeScheme);
		model.addAttribute("schemes", schemes);
		
		return "srm/proj/evaluation/groupProjConfig"; 
	}
	
	@RequestMapping("changeMeeting")
	public String changeMeeting(String groupFlow , Model model){
		if(StringUtil.isNotBlank(groupFlow)){ 
			SrmExpertGroup group = experGroupBiz.readSrmExpertGroup(groupFlow);
			model.addAttribute("group",group);
			
			//查询当前会议中分配的专家
			SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
			groupUser.setGroupFlow(groupFlow);//根据流水号获取当前专家的信息expertGroupUserBiz
			List<ExpertInfo> expertMeetingInfoList = this.expertGroupUserBiz.searchExpertGroupUserInfo(groupUser);//查询专家组中对应的专家信息
			model.addAttribute("expertMeetingInfoList",expertMeetingInfoList);	
		}
		return "srm/proj/evaluation/meetingConfig";
	}
	
	/**
	 * 在网评中选择评审委员
	 * @return
	 */
	@RequestMapping("/chooseExpert")
	public String chooseExpert(String evalSetFlow , Model model){
		List<SysUserExt> expertInfoList = null;
		String evalSetFlowExists = GlobalConstant.FLAG_N;
		if(StringUtil.isNotBlank(evalSetFlow)){
			SrmExpertProjEval expertProjEval = this.expertGroupProjBiz.read(evalSetFlow);
			if(expertProjEval!=null){
				//查询没有被该评审设置选择过的专家
				expertInfoList = this.expertBiz.searchExpertNotInEvalSetByEvalSetFlow(evalSetFlow);
				model.addAttribute("expertInfoList" , expertInfoList);
				//委员会
				//查询网评的委员会
				SrmExpertGroup searchExpertGroup = new  SrmExpertGroup();
				searchExpertGroup.setEvaluationWayId(EvaluationWayEnum.NetWorkWay.getId());
				List<SrmExpertGroup> expertGroupList = experGroupBiz.searchExpertGroup(searchExpertGroup);
				model.addAttribute("expertGroupList", expertGroupList);
				evalSetFlowExists = GlobalConstant.FLAG_Y;
			
			}
		}
		model.addAttribute("evalSetFlowExists" , evalSetFlowExists);
		return "srm/proj/evaluation/chooseExpert";
	}
	
	/**
	 * 显示专家组专家
	 * @param groupFlow
	 * @param projFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/groupProjConfigExpert",method={RequestMethod.GET})
	public String groupProjConfigExpert(String groupFlow,String evalSetFlow ,Model model){
		//委员
		SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
		groupUser.setGroupFlow(groupFlow);
		List<ExpertInfo> expertInfos = expertGroupUserBiz.searchExpertGroupUserInfo(groupUser);
		model.addAttribute("expertInfos", expertInfos);
		
		//已选择委员
		List<SrmExpertProj> expertProjList = expertProjBiz.searchExperProjByEvaluationFlow(evalSetFlow);
		Map<String,SrmExpertProj> expertProjMap =  new HashMap<String, SrmExpertProj>();
		for(SrmExpertProj record : expertProjList){
			expertProjMap.put(record.getUserFlow(), record);
		}
		model.addAttribute("expertProjMap",expertProjMap);
		return "srm/proj/evaluation/groupProjConfigExpert";
	}
	
	/**
	 * 查看专家评审
	 * @param projFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/viewExpertAudit",method={RequestMethod.GET})
	public  String viewExpertAudit(String projFlow , String evaluationId , Model model,HttpServletRequest request) {
		SrmExpertProjEval expertGroupProj = this.expertGroupProjBiz.searchSrmExpertGroupProjByProjFlowAndEvaluationId(projFlow, evaluationId);
		if(expertGroupProj!=null){
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setEvalSetFlow(expertGroupProj.getEvalSetFlow());
			//expertProj.setEvalStatusId(EvaluationStatusEnum.Submit.getId());
			List<SrmExpertProjExt> expertProjList = this.expertProjBiz.searchExpertProjExtAndUserExt(expertProj);
			model.addAttribute("expertProjList", expertProjList);
		}
		return "srm/proj/evaluation/viewExpertAudit";
	}
	
	
	/**
	 * 提交评审设置
	 * @param groupProj
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveEvalSet",method={RequestMethod.POST})
	@ResponseBody
	public String saveEvalSet(SrmExpertProjEval groupProj, Model model){
		groupProj.setEvaluationWayName(EvaluationWayEnum.getNameById(groupProj.getEvaluationWayId()));//设置评审形式名称
		groupProj.setEvaluationName(EvaluationEnum.getNameById(groupProj.getEvaluationId()));//设置评审名称
		groupProj.setEvalStatusName(EvaluationStatusEnum.getNameById(groupProj.getEvalStatusId()));//设置评审状态名称
		if(EvaluationWayEnum.NetWorkWay.getId().equals(groupProj.getEvaluationWayId())){
			this.projEvaluationBiz.saveEvaluationSettingForNetWork(groupProj);
		}else if(EvaluationWayEnum.MeetingWay.getId().equals(groupProj.getEvaluationWayId())){
			this.projEvaluationBiz.saveEvaluationSettingForMeeting(groupProj);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	/**
	 * 保存评审专家(网评)
	 * @param groupProj
	 * @param userFlow
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveExpert",method={RequestMethod.POST})
	@ResponseBody
	public String saveExpert( SrmExpertProjEval groupProj , String[] userFlow  ,  Model model){
		if(userFlow==null || userFlow.length==0){
			return "请至少选择一个专家";
		}
		expertProjBiz.saveExpertProj(groupProj,Arrays.asList(userFlow));
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	
	
	/**
	 * 评审中的专家通知(短信和邮件)
	 * @param projFlow
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/sendNotice")
	@ResponseBody
	public String sendNotice(String evalSetFlow , String userFlow , String type){
		try{
			if("Phone".equals(type)){
				this.expertProjBiz.sendPhoneNotice(evalSetFlow, userFlow);
			}else if("Email".equals(type)){
				this.expertProjBiz.sendEmailNotice(evalSetFlow, userFlow);
			}
			return GlobalConstant.OPRE_SUCCESSED_FLAG;
		}catch(RuntimeException e){
		    return e.getMessage();	
		}
		
	}
	
	@RequestMapping(value="/delExpert",method={RequestMethod.GET})
	@ResponseBody
	public String delExpert(String projFlow , String userFlow , Model model){
		//先要查询该专家有没有同意过 ， 如果同意字段为null就可以删除，否则不可以删除
		SrmExpertProj sep = expertProjBiz.read(projFlow, userFlow);
		if(sep != null){
			if(StringUtil.isBlank(sep.getAgreeFlag())){
				sep.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
				expertProjBiz.modifyWithOutBlobsByFlow(sep);
				return GlobalConstant.DELETE_SUCCESSED;
			}else{
				return "该专家已经操作过该项目,不得删除！";
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping("/changeEvalWay")
	public String changeEvalWay(String evaluationWayId ,String evaluationId ,  Model model){
		if(EvaluationWayEnum.NetWorkWay.getId().equals(evaluationWayId)){
			return "srm/proj/evaluation/netWorkConfig";
		}else{
			return "srm/proj/evaluation/meetingConfig";
		}
	}

}
