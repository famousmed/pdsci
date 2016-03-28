package com.pinde.sci.ctrl.srm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.srm.EvaluationStatusEnum;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.enums.srm.ExpertScoreResultEnum;
import com.pinde.sci.form.srm.ExpertProjForm;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.ExpertInfo;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;
import com.pinde.sci.model.srm.SrmExpertProjExt;

@Controller
@RequestMapping("/srm/meeting")
public class MeetingController extends GeneralController{
	
	@Autowired
	private IExpertGroupBiz expertGroupBiz;
	@Autowired
	private IExpertGroupsUserBiz expertGroupsUserBiz;
	@Autowired
	private IExpertGroupProjBiz expertGroupProjBiz;
	@Autowired
	private IExpertProjBiz expertProjBiz;
	
	/**
	 * 会议安排
	 * @return
	 */
	@RequestMapping("/plan")
	public String plan(Model model){
		return "srm/meeting/plan";
	}
	
	/**
	 * 添加会议
	 * @return
	 */
	@RequestMapping("/add")
	public String add(String date){
		return "srm/meeting/addMeeting";
	}
	
	
	/**
	 * 会议安排
	 * @return
	 */
	@RequestMapping("/getMeetingDataJson")
	@ResponseBody
	public Object getMeetingDataJson(String startDate,String endDate,Model model){
		SrmExpertGroup expert = new SrmExpertGroup();
		expert.setEvaluationWayId(EvaluationWayEnum.MeetingWay.getId());
		List<SrmExpertGroup> meetingList = this.expertGroupBiz.searchExpertGroup(expert , startDate , endDate);
		return meetingList;
	}
	
	/**
	 * 增加专家组(会议)信息
	 * @param expert
	 * @return
	 */
	@RequestMapping(value={"/save"},method={RequestMethod.POST})
	@ResponseBody
	public  String save(SrmExpertGroup meeting){
		meeting.setEvaluationWayId(EvaluationWayEnum.MeetingWay.getId());
		meeting.setEvaluationWayName(EvaluationWayEnum.MeetingWay.getName());
		this.expertGroupBiz.saveExpertGroup(meeting);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 会议过程
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/process")
	public String process(String groupFlow , Model model){
		SrmExpertGroup meeting = this.expertGroupBiz.readSrmExpertGroup(groupFlow);
		model.addAttribute("meeting" , meeting);
		//查询当前会议中分配的专家
		SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
		groupUser.setGroupFlow(groupFlow);//根据流水号获取当前专家的信息
		List<ExpertInfo> expertInfoList = this.expertGroupsUserBiz.searchExpertGroupUserInfo(groupUser);//查询专家组中对应的专家信息
		model.addAttribute("expertInfoList",expertInfoList);	
		return "srm/meeting/process";
	}
	/**
	 * 编辑会议信息
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(String groupFlow , Model model){
		SrmExpertGroup meeting = this.expertGroupBiz.readSrmExpertGroup(groupFlow);
		model.addAttribute("meeting" , meeting);
		return "srm/meeting/editMeeting";
	}
    
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(String groupFlow){
		SrmExpertGroup meeting = this.expertGroupBiz.readSrmExpertGroup(groupFlow);
		this.expertGroupBiz.deleteExpertGroup(meeting);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	/**
	 * 查询未加入当前组的专家
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addExpertUI",method={RequestMethod.GET})
	public String addExpertUI(ExpertInfo expertInfo, String groupFlow,Model model){
		List<ExpertInfo> expertInfoList = expertGroupsUserBiz.searchSysUserNotInByGroupFlow(groupFlow);	
		model.addAttribute("expertInfoList",expertInfoList);	
		return "srm/meeting/addEvalExpertList";
	}	
	
	/**
	 * 通过groupFlow，userFlow流水号添加专家的信息
	 * @param groupFlow
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addEvalExpert",method={RequestMethod.POST})
	@ResponseBody
	public  String addEvalExpert(String groupFlow,String [] userFlow,Model model){ 
		if(userFlow==null || userFlow.length==0){
			return "至少选取一个委员,该次操作无效";
		}
		this.expertGroupBiz.addEvalExpert(groupFlow, userFlow);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	/**
	 * 在该次会议上去掉该专家
	 * 同时将该专家原先在该次会议上需要评审的项目去掉
	 * @return
	 */
	@RequestMapping("delEvalExpert")
	@ResponseBody
	public String delEvalExpert(SrmExpertGroupUser expertGroupUser){
		this.expertGroupBiz.delEvalExpert(expertGroupUser);
		return GlobalConstant.DELETE_SUCCESSED;
	}
	
	/**
	 * 添加这次会议上需要评审的项目
	 * @return
	 */
	@RequestMapping("/addEvalProjUI")
	public String addEvalProjUI(String groupFlow , Model model){
		SrmExpertGroupProjExt srmExpertGroupProjExt = new SrmExpertGroupProjExt();
		srmExpertGroupProjExt.setEvaluationWayId(EvaluationWayEnum.MeetingWay.getId());
		//srmExpertGroupProjExt.setEvalStatusId(EvaluationStatusEnum.Submit.getId());
		srmExpertGroupProjExt.setGroupFlow(GlobalConstant.NULL);
		List<SrmExpertGroupProjExt> groupProjList = expertGroupProjBiz.searchSrmExpertGroupProjList(srmExpertGroupProjExt);
		model.addAttribute("groupProjList" , groupProjList);
		return "srm/meeting/addEvalProjList";
	}
	
	/**
	 * 确认添加该项目到该次会议上
	 * @return
	 */
	@RequestMapping("/addEvalProj")
	@ResponseBody
	public String addEvalProj(String groupFlow , String evalSetFlow , Model model){
		this.expertGroupBiz.addEvalProj(groupFlow, evalSetFlow);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 委员签到
	 * @param recordFlow
	 * @return
	 */
	@RequestMapping("/sign")
	@ResponseBody
	public String sign(String recordFlow){
		this.expertGroupsUserBiz.expertSing(recordFlow);
		return  GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 显示签到列表
	 * @param groupFlow
	 * @param model
	 * @return
	 */
//	@RequestMapping("/showSignUI")
//	public String showSignUI(String groupFlow , Model model){
//		SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
//		groupUser.setGroupFlow(groupFlow);//根据流水号获取当前专家的信息
//		List<ExpertInfo> expertInfoList = this.expertGroupsUserBiz.searchExpertGroupUserInfo(groupUser);//查询专家组中对应的专家信息
//		model.addAttribute("expertInfoList",expertInfoList);	
//		return "srm/meeting/signTable";
//	}
	
	/**
	 * 显示该次会议上需要评审的项目
	 * @return
	 */
	@RequestMapping("/showEvalProj")
	public String showEvalProjUI(String groupFlow , Model model){
		SrmExpertGroupProjExt srmExpertGroupProjExt = new SrmExpertGroupProjExt();
		srmExpertGroupProjExt.setGroupFlow(groupFlow);
		srmExpertGroupProjExt.setRecordStatus(GlobalConstant.FLAG_Y);
		List<SrmExpertGroupProjExt> expertGroupProjList = this.expertGroupProjBiz.searchSrmExpertGroupProjList(srmExpertGroupProjExt);
		model.addAttribute("expertGroupProjList",expertGroupProjList);
		Map<String , Boolean> isDelMap = new HashMap<String , Boolean>();
		//当项目被打过分后 是不可以删除的
		for(SrmExpertGroupProjExt sgpe:expertGroupProjList){
			String projFlow = sgpe.getProjFlow();
			isDelMap.put(projFlow , this.expertProjBiz.searchExpertIsSetScoreByProjFlow(projFlow));
		}
		model.addAttribute("isDelMap",isDelMap);
		return "srm/meeting/evalProjTable";
	}

	/**
	 * 取消该项目在会议上的评审
	 * @param evalSetFlow
	 * @return
	 */
	@RequestMapping("/cancelEvalSet")
	@ResponseBody
	public String cancelEvalSet(String evalSetFlow){
		this.expertGroupBiz.delEvalProj(evalSetFlow);
		return  GlobalConstant.OPERATE_SUCCESSED;
	}
	
	/**
	 * 邮件通知
	 * @return
	 */
	@RequestMapping("/emailNotify")
	@ResponseBody
	public String emailNotify(String recordFlow){
		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
		expertGroupUser.setRecordFlow(recordFlow);
		expertGroupUser.setEmailNotifyFlag(GlobalConstant.FLAG_Y);
		this.expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 手机通知
	 * @return
	 */
	@RequestMapping("/phoneNotify")
	@ResponseBody
	public String phoneNotify(String recordFlow){
		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
		expertGroupUser.setRecordFlow(recordFlow);
		expertGroupUser.setPhoneNotifyFlag(GlobalConstant.FLAG_Y);
		this.expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/**
	 * 评分
	 * @param evalSetFlow
	 * @param model
	 * @return
	 */
	@RequestMapping("/expertScore")
	public String expertRecord(SrmExpertProj expertProj ,String evalSetFlow, Model model){
		List<SrmExpertProjExt> expertProjList =  this.expertProjBiz.searchExpertProjExtAndUserExt(expertProj);
		model.addAttribute("expertProjList" , expertProjList);
		
		SrmExpertProjEval experGroupProj = expertGroupProjBiz.read(evalSetFlow);
		if(experGroupProj != null){
			model.addAttribute("evalOpinion",experGroupProj.getEvalOpinion());
		}
		return "srm/meeting/expertScore";
	}
	
	@RequestMapping("/saveExpertScore")
	@ResponseBody
	public String saveExpertRecord(ExpertProjForm expertProjForm ,String evalSetFlow, String status){
		List<SrmExpertProj> expertProjList = expertProjForm.getSrmExpertProjList();
		for(SrmExpertProj sep:expertProjList){
			sep.setEvalStatusId(status);
			sep.setEvalStatusName(EvaluationStatusEnum.getNameById(status));
			sep.setScoreResultName(ExpertScoreResultEnum.getNameById(sep.getScoreResultId()));
			this.expertProjBiz.modifyWithOutBlobsByFlow(sep);
		}
		SrmExpertProjEval experGroupProj = expertGroupProjBiz.read(evalSetFlow);
		if(experGroupProj != null){
			experGroupProj.setEvalOpinion(expertProjForm.getEvalOpinion());
			expertGroupProjBiz.modExpertGroupProjByFlow(experGroupProj);
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}
}
