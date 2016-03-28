package com.pinde.sci.ctrl.irb;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Node;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.pdf.DocumentVo;
import com.pinde.core.pdf.PdfDocumentGenerator;
import com.pinde.core.pdf.utils.ResourceLoader;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.biz.irb.IIrbSecretaryBiz;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.NumTrans;
import com.pinde.sci.enums.irb.IrbDecisionEnum;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.enums.irb.IrbStageEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.enums.pub.ProjOrgTypeEnum;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbMinutesForm;
import com.pinde.sci.form.irb.IrbQuickOpinionForm;
import com.pinde.sci.form.irb.IrbVoteForm;
import com.pinde.sci.form.irb.irbMeetingForm;
import com.pinde.sci.model.irb.IrbForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/irb/meeting")
public class IrbMeetingController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(IrbMeetingController.class);
	
	@Autowired
	private IIrbMeetingBiz meetingBiz;
	@Autowired
	private IIrbInfoUserBiz irbInfoUserBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbSecretaryBiz secretaryBiz;
	@Autowired
	private IIrbCommitteeBiz  irbCommitteeBiz;
	@Autowired
	private IIrbInfoBiz irbInfoBiz;
	@Autowired
	private IIrbUserBiz irbUserBiz;
	@Autowired
	private IFileBiz pubFileBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IPubProjBiz projBiz;
	
	@RequestMapping(value={"/arrange"},method={RequestMethod.GET})
	public String  arrange(String type,Model model){
		List<IrbMeeting> meetingList = meetingBiz.queryIrbMeeting();
		model.addAttribute("meetingList", meetingList);
		model.addAttribute("type", type);
		return "irb/meeting/arrange";
	}
	
	@RequestMapping(value={"/meetingList"},method={RequestMethod.POST})
	public String  meetingList(irbMeetingForm form,Model model){
		List<IrbMeeting> meetingList = meetingBiz.queryList(form);
		model.addAttribute("meetingList", meetingList);
		model.addAttribute("type", "meetingList");
		return "irb/meeting/arrange";
	}
	
	/**
	 * 会议安排
	 * @param meetingFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/agenda"},method={RequestMethod.GET})
	public String  meeting(String meetingFlow, String meetingCheck, Model model) throws Exception{
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			model.addAttribute("meeting", meeting);
			Map<String,List<IrbMeetingUser>> meetingUserMap = meetingBiz.searchIrbMeetingUserMap(meetingFlow);
			model.addAttribute("meetingUserMap", meetingUserMap);
			
			IrbApply irbApply = new IrbApply();
			irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbApply.setMeetingFlow(meetingFlow);
			List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
			
			Map<String,IrbVoteForm> voteMap = new HashMap<String,IrbVoteForm>();//当前委员的投票
			List<IrbForm> fastFormList = null;	//快审列表
			List<IrbForm> meetFormList = null;	//会审列表
			if(list!=null && list.size() > 0){
				String userFlow = GlobalContext.getCurrentUser().getUserFlow();
				for (IrbApply irb : list) {
					if (GlobalConstant.FLAG_Y.equals(meetingCheck)) {	//委员的会议安排页面
						List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irb.getIrbFlow(), userFlow);
						if(formList!=null&&!formList.isEmpty()){
							voteMap.put(irb.getIrbFlow(), formList.get(0));
						}
					}
					PubProj proj = this.projBiz.readProjectNoBlogs(irb.getProjFlow());
					IrbForm irbForm = new IrbForm();
					irbForm.setIrb(irb);
					irbForm.setProj(proj);
					String reviewWay = irb.getReviewWayId();
					String meetingArrange = irb.getMeetingArrange();
					if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
						reviewWay = meetingArrange;
					}
					if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {	//快审
						if (fastFormList == null) {
							fastFormList = new ArrayList<IrbForm>();
						}
						fastFormList.add(irbForm);
					}
					if (IrbReviewTypeEnum.Meeting.getId().equals(reviewWay)) {	//会审
						if (meetFormList == null) {
							meetFormList = new ArrayList<IrbForm>();
						}
						meetFormList.add(irbForm);
					}
				}
			}
			model.addAttribute("fastFormList", fastFormList);
			model.addAttribute("meetFormList", meetFormList);
			model.addAttribute("voteMap", voteMap);
			model.addAttribute("meetingCheck", meetingCheck);
		}
		return "irb/meeting/agenda";
	}
	@RequestMapping(value={"/addMeeting"},method={RequestMethod.GET})
	public String  addMeeting(Model model){
		model.addAttribute("irbInfoList", getSessionAttribute("irbInfoList"));
		return "irb/meeting/addMeeting";
	}
	@RequestMapping(value={"/addMeeting"},method={RequestMethod.POST})
	@ResponseBody
	public String  addMeeting(IrbMeeting  meeting ){
		meetingBiz.addIrbMeeting(meeting);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value={"/toEditMeeting"},method={RequestMethod.GET})
	public String  toEditMeeting(String meetingFlow, Model model){
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			model.addAttribute("meeting", meeting);
		}
		return "irb/meeting/addMeeting";
	}
	
	
	/**
	 * 审查决定
	 * @param irbFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/voteDesction"},method={RequestMethod.GET})
	public String  voteDesction(String irbFlow, Model model)throws Exception {
		if(StringUtil.isNotBlank(irbFlow)){
			IrbForm irbForm = this.secretaryBiz.readIrbForm(irbFlow);
			IrbApply curApply = irbForm.getIrb();
			if(curApply!=null){
				String meetingFlow = curApply.getMeetingFlow();
				IrbMeeting meeting = this.meetingBiz.readIrbMeeting(meetingFlow);
				List<IrbMeetingUser> filterUserList = this.meetingBiz.filterVoteUserList(meetingFlow);//投票人员
				List<String> userFlowList = new ArrayList<String>();
				if (filterUserList != null && filterUserList.size() > 0) {
					for (IrbMeetingUser user:filterUserList) {
						userFlowList.add(user.getUserFlow());
					}
				}
				
				IrbInfo irbInfo = this.irbInfoBiz.queryInfo(curApply.getIrbInfoFlow());
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
				Map<String, Integer> voteCountMap = new HashMap<String, Integer>();	//统计各决定投票数
				Map<String, String> voteMap = new HashMap<String, String>();
				int cCount = 0;//冲突数
				if(formList != null && formList.size() > 0){
					for (IrbVoteForm form : formList) {
						String userFlow = form.getUserFlow();
						String decId = StringUtil.defaultIfEmpty(form.getDecisionId(), "");
						
						voteMap.put("vote_"+userFlow,decId);
						
						if (userFlowList.contains(userFlow)) {	//过滤已经删除的参会人员
							if (StringUtil.isNotBlank(decId)) {
								int dCount = 1;
								if (voteCountMap.get(decId) != null) {
									dCount = voteCountMap.get(decId) +1;
								}
								voteCountMap.put(decId, dCount);
							}
							if(GlobalConstant.FLAG_Y.equals(form.getConflict())){
								voteMap.put("conflict_"+userFlow,GlobalConstant.FLAG_Y);
								cCount++;
							}
						}
					}
				}
				voteCountMap.put(GlobalConstant.IRB_DECISION_CONFLICT, cCount);
				
				/*决定选项*/
				List<IrbDecisionEnum> decisionList = new ArrayList<IrbDecisionEnum>();
				String maxVoteDec = "";
				int maxVoteCount = 0;
				String irbTypeId = curApply.getIrbTypeId();
				for (IrbDecisionEnum irbDecisionEnum : IrbDecisionEnum.values()) {
					if(StringUtil.countMatches(irbDecisionEnum.getIrbTypeId(),irbTypeId)==1){
						decisionList.add(irbDecisionEnum);
						String decId = irbDecisionEnum.getId();
						if (voteCountMap.get(decId) != null && maxVoteCount<voteCountMap.get(decId)) {
							maxVoteCount = voteCountMap.get(decId);
							maxVoteDec = decId;
						}
					}
				}
				model.addAttribute("maxVoteDec", maxVoteDec);
				
				model.addAttribute("meeting", meeting);
				model.addAttribute("irbForm", irbForm);
				model.addAttribute("irbInfo", irbInfo);
				model.addAttribute("voteMap", voteMap);
				model.addAttribute("voteCountMap", voteCountMap);
				model.addAttribute("decisionList", decisionList);
				model.addAttribute("filterUserList", filterUserList);
			}
			
		}
		return "irb/secretary/decision/voteDecision";
	}
	/**
	 * 会议记录
	 * @param meetingArrange
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/minutes"},method={RequestMethod.GET})
	public String  minutes(String meetingArrange,String irbFlow, Model model) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)){
			IrbMinutesForm form = this.meetingBiz.readMinutes(irbFlow);
			model.addAttribute("form", form);
			IrbForm irbForm = this.secretaryBiz.readIrbForm(irbFlow);
			model.addAttribute("irbForm", irbForm);
			IrbApply curApply = irbForm.getIrb();
			
			IrbMeeting meeting = this.meetingBiz.readIrbMeeting(curApply.getMeetingFlow());
			model.addAttribute("meeting", meeting);
			
			if(IrbReviewTypeEnum.Fast.getId().equals(meetingArrange)){
				IrbQuickOpinionForm qForm = this.secretaryBiz.readQuickOpinion(irbFlow);
				if (qForm != null) {
					String reviewOpinon = StringUtil.defaultString(qForm.getReviewOpinion());
					model.addAttribute("reviewOpinon", reviewOpinon);
				}
				return "irb/meeting/minutesFast";
			}else if(IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)){
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);//所有投票
				//利益冲突退出
				Map<String, String> conflictMap = new HashMap<String, String>();
				List<IrbVoteForm> quitList = new ArrayList<IrbVoteForm>();
				if(formList!=null&&!formList.isEmpty()){
					for (IrbVoteForm temp : formList) {
						String userFlow = temp.getUserFlow();
						if(GlobalConstant.FLAG_Y.equals(temp.getConflict())){
							conflictMap.put(userFlow,GlobalConstant.FLAG_Y);
							quitList.add(temp);
						}
					}
				}
				model.addAttribute("conflictMap", conflictMap);
				model.addAttribute("quitList", quitList);
				
				String meetingFlow = meeting.getMeetingFlow();
				List<IrbMeetingUser> filterUserList = this.meetingBiz.filterVoteUserList(meetingFlow);//投票人员
				model.addAttribute("filterUserList", filterUserList);
				
				return "irb/meeting/minutesMeeting";
			}
		}
		return "error/404";
	}
	/**
	 * 调整上会项目
	 * @param reviewWayId
	 * @param meetingFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/irbSettle")
	public String  irbSettle(String meetingArrange,String meetingFlow, String irbInfoFlow,Model model){
		if(StringUtil.isNotBlank(meetingArrange)&&StringUtil.isNotBlank(meetingFlow)){
			IrbApply irbApply = new IrbApply();
			irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbApply.setMeetingFlow(meetingFlow);
			irbApply.setIrbStageId(IrbStageEnum.Review.getId());
			irbApply.setIrbInfoFlow(irbInfoFlow);
			irbApply.setMeetingArrange(meetingArrange);//meetingArrange='-1'时 包含快审 审查阶段和传达决定阶段两部分数据。
			IrbApplyForm form = new IrbApplyForm();
			form.setIrbApply(irbApply);
			form.setForMeeting(GlobalConstant.FLAG_Y);
			List<IrbApply> irbList = this.irbApplyBiz.queryList(form);
			model.addAttribute("irbList", irbList);
		}
		return "irb/meeting/irbSettle";
	}
	
	/**
	 * 选择参会人员
	 * @param meetingFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/selMeetingUser"},method={RequestMethod.GET})
	public String  selMeetingUser(String meetingFlow, Model model){
		IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
		model.addAttribute("meetingFlow", meetingFlow);
		String irbInfoFLow = meeting.getIrbInfoFlow();
		IrbInfo irbInfo = this.irbInfoBiz.queryInfo(irbInfoFLow);
		model.addAttribute("irbInfoFlow", irbInfoFLow);
		model.addAttribute("irbName", irbInfo.getIrbName());
		
		List<IrbMeetingUser> existUserList = meetingBiz.searchIrbMeetingUser(meetingFlow);
		Map<String,IrbMeetingUser> existUserMap = new HashMap<String, IrbMeetingUser>();
		for(IrbMeetingUser irbMeetingUser : existUserList){
			existUserMap.put(irbMeetingUser.getUserFlow(), irbMeetingUser);
		}
		model.addAttribute("existUserMap", existUserMap);
		/*IrbInfoUser user = new IrbInfoUser();
		user.setIrbInfoFlow(meeting.getIrbInfoFlow());
		List<IrbInfoUserExt> irbInfoUserExtList = this.irbInfoUserBiz.queryUserExtList(user);
		model.addAttribute("irbInfoUserExtList", irbInfoUserExtList);*/
		IrbInfoUser user = new IrbInfoUser();
		user.setIrbInfoFlow(irbInfoFLow);
		user.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<IrbInfoUser> userList = this.irbInfoUserBiz.queryUserList(user); 
		Map<String, SysUser> sysUserMap = new LinkedHashMap<String, SysUser>();
		List<IrbInfoUser> filterList = new ArrayList<IrbInfoUser>();//过滤一个用户多个角色
		SysUser sysUser = null;
		for (IrbInfoUser irbUser : userList) {
			sysUser = this.userBiz.readSysUser(irbUser.getUserFlow());
			sysUserMap.put(irbUser.getUserFlow(), sysUser);
			boolean canAdd = false;
			/*过滤一个用户多个角色*/
			for (IrbInfoUser filterUser : filterList) {
				if(irbUser.getUserFlow().equals(filterUser.getUserFlow())&&irbUser.getIrbInfoFlow().equals(filterUser.getIrbInfoFlow())){
					filterUser.setRoleName(filterUser.getRoleName()+"，"+irbUser.getRoleName());
					canAdd = false;
					break;
				}else{
					canAdd = true;
				}
			}
			if(filterList.isEmpty()||canAdd){
				filterList.add(irbUser);
			}
		}
		model.addAttribute("userList", filterList);
		model.addAttribute("sysUserMap", sysUserMap);
		return "/irb/meeting/selMeetingUser";
	}
	/**
	 * 保存参会人员
	 * @param userFlows
	 * @param meetingFlow
	 * @return
	 */
	@RequestMapping(value="/saveMeetingUser")
	@ResponseBody
	public String saveMeetingUser(String[] userFlows,String meetingFlow,String irbInfoFlow){
		if(userFlows!=null&&userFlows.length>0&&StringUtil.isNotBlank(meetingFlow)){
			List<IrbMeetingUser> existUserList = meetingBiz.searchIrbMeetingUser(meetingFlow);//已勾选的人员
			Map<String,IrbMeetingUser> existUserMap = new HashMap<String, IrbMeetingUser>();//需要删除的人员
			if(existUserList==null){
				existUserList = new ArrayList<IrbMeetingUser>();
			}
			for(IrbMeetingUser irbMeetingUser : existUserList){
				existUserMap.put(irbMeetingUser.getUserFlow(), irbMeetingUser);
			}
			for (String flow : userFlows) {
				boolean canAdd = true;
					for (IrbMeetingUser existUser : existUserList) {
						if(existUser.getUserFlow().equals(flow)){
							canAdd = false;
							if(existUserMap.size()>0){
								existUserMap.remove(flow);
							}
							break;
						}
					}
					List<IrbMeetingUser> irbMeetingUsers = new ArrayList<IrbMeetingUser>();
					/*添加人员*/
					if(canAdd){
						IrbInfoUser temp = new IrbInfoUser();
						temp.setIrbInfoFlow(irbInfoFlow);
						temp.setUserFlow(flow);
						temp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						List<IrbInfoUser> irbInfoUsers = this.irbInfoUserBiz.queryUserList(temp);//查询该人员在该伦理委员会的所有岗位
						if (irbInfoUsers != null && irbInfoUsers.size() > 0) {//保存该人员的所有岗位
							for (IrbInfoUser irbInfoUser:irbInfoUsers) {
								IrbMeetingUser user = new IrbMeetingUser();
								user.setMeetingFlow(meetingFlow);
								user.setUserName(irbInfoUser.getUserName());
								user.setUserFlow(flow);
								user.setRoleFlow(irbInfoUser.getRoleFlow());
								user.setRoleName(irbInfoUser.getRoleName());
								user.setAttendStatus(GlobalConstant.FLAG_Y);
								irbMeetingUsers.add(user);
							}
						}
					}
					if (irbMeetingUsers.size()>0) {
						this.meetingBiz.editMeetingUserList(irbMeetingUsers);
					}
			}
			/*删除人员*/
			if(existUserMap.size()>0){
				for (Map.Entry<String,IrbMeetingUser> entry : existUserMap.entrySet()) {
					IrbMeetingUser findUser = entry.getValue();
					this.meetingBiz.delMeetingUser(meetingFlow,findUser.getUserFlow());
				}
			}
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	/**
	 * 上会/撤销
	 * @param irbFlow
	 * @param meetingFlow
	 * @return
	 */
	@RequestMapping(value="/saveIrbSettle")
	@ResponseBody
	public String saveIrbSettle(String irbFlow,String meetingFlow){
		if(StringUtil.isNotBlank(irbFlow)&&StringUtil.isNotBlank(meetingFlow)){
			IrbApply irbApply = this.irbApplyBiz.queryByFlow(irbFlow);
			if(irbApply!=null){
				if(StringUtil.isNotBlank(irbApply.getMeetingFlow())){//撤销
					irbApply.setMeetingDate("");
					irbApply.setMeetingFlow("");
				}else{//上会
					IrbMeeting meeting = this.meetingBiz.readIrbMeeting(meetingFlow);
					if(meeting!=null){
						irbApply.setMeetingDate(meeting.getMeetingDate());
						irbApply.setMeetingFlow(meetingFlow);
					}
				}
				int result = this.irbApplyBiz.edit(irbApply);
				if(result == GlobalConstant.ONE_LINE){
					return GlobalConstant.OPRE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	/**
	 * 保存会议记录
	 * @param irbFlow
	 * @param form
	 * @return
	 */
	@RequestMapping(value="/saveMinutes")
	@ResponseBody
	public String saveMinutes(String irbFlow,IrbMinutesForm form,String[] userFlows) throws Exception{
		if(StringUtil.isNotBlank(irbFlow)&&form!=null){
			int result = this.meetingBiz.saveMinutes(irbFlow, form,userFlows);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	/**
	 * 保存审查决定
	 * @param form
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/saveVoteDecision")
	@ResponseBody
	public String saveVoteDesction(@RequestBody IrbVoteForm form) throws Exception{
		if(form!=null){
			int result = this.irbCommitteeBiz.saveVoteDecision(form);
			if(result==GlobalConstant.ONE_LINE){
				return GlobalConstant.SAVE_SUCCESSED;
			}
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value="/finishMeetingConfirm")
	@ResponseBody
	public Integer finishMeetingConfirm(String meetingFlow){
		if(StringUtil.isNotBlank(meetingFlow)){
			List<IrbApply> irbList = this.irbApplyBiz.searchUnDecisionIrbApply(meetingFlow);
			return irbList==null?0:irbList.size();
		}
		return 0;
	}
	
	/**
	 * 结束会议
	 * @param meetingFlow
	 * @return
	 */
	@RequestMapping(value="/finishMeeting")
	@ResponseBody
	public String finishMeeting(String meetingFlow){
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbMeeting meeting = this.meetingBiz.readIrbMeeting(meetingFlow);
			if(meeting!=null){
				meeting.setMeetingStatus(GlobalConstant.FLAG_Y);
				int result = this.meetingBiz.edit(meeting);
				if(result== GlobalConstant.ONE_LINE){
					return GlobalConstant.OPRE_SUCCESSED;
				}
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value={"/meetingRecord"},method={RequestMethod.GET})
	public String  meetingRecord(String meetingFlow , Model model) throws Exception{
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			model.addAttribute("meeting", meeting);
			Map<String,List<IrbMeetingUser>> meetingUserMap = meetingBiz.searchIrbMeetingUserMap(meetingFlow);
			model.addAttribute("meetingUserMap", meetingUserMap);
			
			IrbApply irbApply = new IrbApply();
			irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbApply.setMeetingFlow(meetingFlow);
			List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
			List<IrbForm> fastFormList = null;
			Map<String,List<IrbForm>> irbTypeMap = new HashMap<String,List<IrbForm>>();
			Map<String,String> isLeaderMap = new HashMap<String,String>();
			Map<String,List<SysDict>> decisionMap = new HashMap<String,List<SysDict>>();//审查决定listmap
			Map<String, String> voteCountMap = new HashMap<String, String>();
			Map<String,IrbMinutesForm> minutesMap = new HashMap<String,IrbMinutesForm>();//审查记录map
			Map<String,List<IrbUser>> committeesMap = new HashMap<String,List<IrbUser>>();//主审委员map
			if(list!=null&&!list.isEmpty()){
				for (IrbApply irb : list) {
					String irbFlow = irb.getIrbFlow();
					String irbTypeId = irb.getIrbTypeId();
					PubProj proj = this.projBiz.readProject(irb.getProjFlow());
					IrbForm irbForm = new IrbForm();
					irbForm.setIrb(irb);
					irbForm.setProj(proj);
					String reviewWay = irb.getReviewWayId();
					String meetingArrange = irb.getMeetingArrange();
					if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
						reviewWay = meetingArrange;
					}
					if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {
						if (fastFormList == null) {
							fastFormList = new ArrayList<IrbForm>();
						}
						fastFormList.add(irbForm);
					}
					//irbTypeMap
					if (IrbReviewTypeEnum.Meeting.getId().equals(reviewWay)) {
						List<IrbForm> tempList = irbTypeMap.get(irbTypeId);
						if (tempList == null) {
							tempList = new ArrayList<IrbForm>();
						}
						tempList.add(irbForm);
						irbTypeMap.put(irbTypeId, tempList);
						
						String isLeader = "";
						if (proj != null) {
							String content = proj.getProjInfo();
							if (StringUtil.isNotBlank(content)) {
								Document doc = DocumentHelper.parseText(content);
								Node isLeaderNode = doc.selectSingleNode("projInfo/generalInfo/isLeader");
								if (isLeaderNode != null) {
									isLeader = StringUtil.defaultString(isLeaderNode.getText());
								}
							}
						}
						isLeaderMap.put(irb.getProjFlow(), isLeader);
					}
					
					/*决定选项*/
					List<SysDict> decisionList = new ArrayList<SysDict>();
					//voteCountMap
					List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
					/*统计各决定投票数*/
					for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
						SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
						dict.setDictId(de.getId());
						dict.setDictName(de.getName());
						if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
							decisionList.add(dict);
						}
						
						int dCount = 0;//投票数
						if(StringUtil.countMatches(de.getIrbTypeId(), irbTypeId)==1&&formList!=null&&!formList.isEmpty()){
							for (IrbVoteForm form : formList) {
								if(de.getId().equals(form.getDecisionId())){
									dCount++;
								}
							}
						}
						voteCountMap.put(irbFlow+de.getId(), dCount+"");
					}
					decisionMap.put(irbFlow, decisionList);
					//审查记录
					IrbMinutesForm form = this.meetingBiz.readMinutes(irbFlow);
					minutesMap.put(irbFlow, form);
					//主审委员
					List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);//主审委员
					List<String> userFlowList = new ArrayList<String>();
					List<IrbUser> filterList = new ArrayList<IrbUser>();	//过滤主审方案和知情同意为同一个人的情况
					if (committeeList != null && committeeList.size() > 0) {
						for (IrbUser user:committeeList) {
							if (!userFlowList.contains(user.getUserFlow())) {
								filterList.add(user);
								userFlowList.add(user.getUserFlow());
							}
						}
					}
					committeesMap.put(irbFlow, filterList);
				}
			}
			model.addAttribute("isLeaderMap", isLeaderMap);
			model.addAttribute("fastFormList", fastFormList);
			model.addAttribute("irbTypeMap", irbTypeMap);
			model.addAttribute("decisionMap", decisionMap);
			model.addAttribute("voteCountMap", voteCountMap);
			model.addAttribute("minutesMap", minutesMap);
			model.addAttribute("committeesMap", committeesMap);
		}
		return "irb/meeting/meetingRecord";
	}
	
	@RequestMapping(value = {"/downMeetingRecord" },method={RequestMethod.GET})
	public void downMeetingRecord(String meetingFlow,final HttpServletResponse response) throws Exception{
		final Map<String,Object> root=new HashMap<String,Object>();
		IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
		root.put("meeting", meeting);
		Map<String,List<IrbMeetingUser>> meetingUserMap = meetingBiz.searchIrbMeetingUserMap(meetingFlow);
		root.put("meetingUserMap", meetingUserMap);
		
		IrbApply irbApply = new IrbApply();
		irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		irbApply.setMeetingFlow(meetingFlow);
		List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
		List<IrbForm> fastFormList = null;
		Map<String,List<IrbForm>> irbTypeMap = new HashMap<String,List<IrbForm>>();
		Map<String,String> isLeaderMap = new HashMap<String,String>();
		Map<String,List<SysDict>> decisionMap = new HashMap<String,List<SysDict>>();//审查决定listmap
		Map<String,String> voteCountMap = new HashMap<String,String>();
		Map<String,IrbMinutesForm> minutesMap = new HashMap<String,IrbMinutesForm>();//审查记录map
		Map<String,List<IrbUser>> committeesMap = new HashMap<String,List<IrbUser>>();//主审委员map
		if(list!=null&&!list.isEmpty()){
			for (IrbApply irb : list) {
				String irbFlow = irb.getIrbFlow();
				String irbTypeId = irb.getIrbTypeId();
				PubProj proj = this.projBiz.readProject(irb.getProjFlow());
				IrbForm irbForm = new IrbForm();
				irbForm.setIrb(irb);
				irbForm.setProj(proj);
				String reviewWay = irb.getReviewWayId();
				String meetingArrange = irb.getMeetingArrange();
				if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
					reviewWay = meetingArrange;
				}
				if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {
					if (fastFormList == null) {
						fastFormList = new ArrayList<IrbForm>();
					}
					fastFormList.add(irbForm);
				}
				//irbTypeMap
				if (IrbReviewTypeEnum.Meeting.getId().equals(reviewWay)) {
					List<IrbForm> tempList = irbTypeMap.get(irbTypeId);
					if (tempList == null) {
						tempList = new ArrayList<IrbForm>();
					}
					tempList.add(irbForm);
					irbTypeMap.put(irbTypeId, tempList);
					
					String isLeader = "";
					if (proj != null) {
						String content = proj.getProjInfo();
						if (StringUtil.isNotBlank(content)) {
							Document doc = DocumentHelper.parseText(content);
							Node isLeaderNode = doc.selectSingleNode("projInfo/generalInfo/isLeader");
							if (isLeaderNode != null) {
								isLeader = StringUtil.defaultString(isLeaderNode.getText());
							}
						}
					}
					isLeaderMap.put(irb.getProjFlow(), isLeader);
				}
				
				/*决定选项*/
				List<SysDict> decisionList = new ArrayList<SysDict>();
				//voteCountMap
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
				/*统计各决定投票数*/
				for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
					SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
					dict.setDictId(de.getId());
					dict.setDictName(de.getName());
					if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
						decisionList.add(dict);
					}
					
					int dCount = 0;//投票数
					if(StringUtil.countMatches(de.getIrbTypeId(), irbTypeId)==1&&formList!=null&&!formList.isEmpty()){
						for (IrbVoteForm form : formList) {
							if(de.getId().equals(form.getDecisionId())){
								dCount++;
							}
						}
					}
					voteCountMap.put(irbFlow+de.getId(), dCount+"");
				}
				decisionMap.put(irbFlow, decisionList);
				//审查记录
				IrbMinutesForm form = this.meetingBiz.readMinutes(irbFlow);
				minutesMap.put(irbFlow, form);
				//主审委员
				List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//主审委员
				committeesMap.put(irbFlow, committeeList);
			}
		}
		
		List<SysDict> irbTypeEnumList = new ArrayList<SysDict>();
		for(IrbTypeEnum temp : IrbTypeEnum.values()){
			SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
			dict.setDictId(temp.getId());
			dict.setDictName(temp.getName());
			irbTypeEnumList.add(dict);
		}
		
		root.put("irbTypeEnumList", irbTypeEnumList);
		root.put("fastFormList", fastFormList);
		root.put("irbTypeMap", irbTypeMap);
		root.put("isLeaderMap", isLeaderMap);
		root.put("leader", ProjOrgTypeEnum.Leader.getId());
		root.put("parti", ProjOrgTypeEnum.Parti.getId());
		root.put("isLeaderMap", isLeaderMap);
		root.put("decisionMap", decisionMap);
		root.put("voteCountMap", voteCountMap);
		root.put("minutesMap", minutesMap);
		root.put("committeesMap", committeesMap);
		root.put("transNum", new NumTrans());
		
		//下载pdf
		final String fileName = meeting.getMeetingDate() + "会议记录";
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass)
		.getParentFile().getParent() + "/load/" + fileName + ".pdf" ;
		
		File file = new File(outputFile);
		try {
			// 模板数据
			DocumentVo vo = new DocumentVo() {
				@Override
				public String findPrimaryKey() {
					return fileName;
				}
				@Override
				public Map<String, Object> fillDataMap() {
					return root;
				}
			};
				
			String template = "meetingRecordTemplate.ftl";
			PdfDocumentGenerator pdfGenerator = new PdfDocumentGenerator();
			// 生成pdf
			pdfGenerator.generate(template, vo, outputFile);
		} catch (Exception ex) {
			System.err.println(" \n pdf生成失败");
			ex.printStackTrace();
		}
		
		pubFileBiz.downFile(file,response);
	}
	
	@RequestMapping(value={"/meetingAgenda"},method={RequestMethod.GET})
	public String  meetingAgenda(String meetingFlow , Model model) throws Exception{
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
			model.addAttribute("meeting", meeting);
			Map<String,List<IrbMeetingUser>> meetingUserMap = meetingBiz.searchIrbMeetingUserMap(meetingFlow);
			model.addAttribute("meetingUserMap", meetingUserMap);
			
			IrbApply irbApply = new IrbApply();
			irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbApply.setMeetingFlow(meetingFlow);
			List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
			List<IrbForm> fastFormList = null;
			Map<String,List<IrbForm>> irbTypeMap = new HashMap<String,List<IrbForm>>();
			Map<String,List<SysDict>> decisionMap = new HashMap<String,List<SysDict>>();//审查决定listmap
			Map<String, String> voteCountMap = new HashMap<String, String>();
			Map<String,IrbMinutesForm> minutesMap = new HashMap<String,IrbMinutesForm>();//审查记录map
			Map<String,List<IrbUser>> committeesMap = new HashMap<String,List<IrbUser>>();//主审委员map
			Map<String,IrbUser> consultantMap = new HashMap<String,IrbUser>();//独立顾问map
			if(list!=null&&!list.isEmpty()){
				for (IrbApply irb : list) {
					String irbFlow = irb.getIrbFlow();
					String irbTypeId = irb.getIrbTypeId();
					PubProj proj = this.projBiz.readProjectNoBlogs(irb.getProjFlow());
					IrbForm irbForm = new IrbForm();
					irbForm.setIrb(irb);
					irbForm.setProj(proj);
					String reviewWay = irb.getReviewWayId();
					String meetingArrange = irb.getMeetingArrange();
					if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
						reviewWay = meetingArrange;
					}
					if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {
						if (fastFormList == null) {
							fastFormList = new ArrayList<IrbForm>();
						}
						fastFormList.add(irbForm);
					}
					//irbTypeMap
					if (IrbReviewTypeEnum.Meeting.getId().equals(reviewWay)) {
						List<IrbForm> tempList = irbTypeMap.get(irbTypeId);
						if (tempList == null) {
							tempList = new ArrayList<IrbForm>();
						}
						tempList.add(irbForm);
						irbTypeMap.put(irbTypeId, tempList);
					}
					
					/*决定选项*/
					List<SysDict> decisionList = new ArrayList<SysDict>();
					//voteCountMap
					List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
					/*统计各决定投票数*/
					for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
						SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
						dict.setDictId(de.getId());
						dict.setDictName(de.getName());
						if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
							decisionList.add(dict);
						}
						
						int dCount = 0;//投票数
						if(StringUtil.countMatches(de.getIrbTypeId(), irbTypeId)==1&&formList!=null&&!formList.isEmpty()){
							for (IrbVoteForm form : formList) {
								if(de.getId().equals(form.getDecisionId())){
									dCount++;
								}
							}
						}
						voteCountMap.put(irbFlow+de.getId(), dCount+"");
					}
					decisionMap.put(irbFlow, decisionList);
					
					//审查记录
					IrbMinutesForm form = this.meetingBiz.readMinutes(irbFlow);
					minutesMap.put(irbFlow, form);
					
					//主审委员
					List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);//主审委员
					List<String> userFlowList = new ArrayList<String>();
					List<IrbUser> filterList = new ArrayList<IrbUser>();	//过滤主审方案和知情同意为同一个人的情况
					if (committeeList != null && committeeList.size() > 0) {
						for (IrbUser user:committeeList) {
							if (!userFlowList.contains(user.getUserFlow())) {
								filterList.add(user);
								userFlowList.add(user.getUserFlow());
							}
						}
					}
					committeesMap.put(irbFlow, filterList);
					
					//独立顾问
					IrbUser consultant = this.irbUserBiz.searchConsultant(irbFlow);//独立顾问
					consultantMap.put(irbFlow, consultant);
				}
			}
			model.addAttribute("fastFormList", fastFormList);
			model.addAttribute("irbTypeMap", irbTypeMap);
			model.addAttribute("decisionMap", decisionMap);
			model.addAttribute("voteCountMap", voteCountMap);
			model.addAttribute("minutesMap", minutesMap);
			model.addAttribute("committeesMap", committeesMap);
			model.addAttribute("consultantMap", consultantMap);
		}
		return "irb/meeting/meetingAgenda";
	}
	
	@RequestMapping(value = {"/downMeetingAgenda" },method={RequestMethod.GET})
	public void downMeetingAgenda(String meetingFlow,final HttpServletResponse response) throws Exception{
		final Map<String,Object> root=new HashMap<String,Object>();
		IrbMeeting meeting = meetingBiz.readIrbMeeting(meetingFlow);
		root.put("meeting", meeting);
		Map<String,List<IrbMeetingUser>> meetingUserMap = meetingBiz.searchIrbMeetingUserMap(meetingFlow);
		root.put("meetingUserMap", meetingUserMap);
		
		IrbApply irbApply = new IrbApply();
		irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		irbApply.setMeetingFlow(meetingFlow);
		List<IrbApply> list = this.irbApplyBiz.searchIrbs(irbApply);
		
		List<IrbForm> fastFormList = null;
		Map<String,List<IrbForm>> irbTypeMap = new HashMap<String,List<IrbForm>>();
		Map<String,List<SysDict>> decisionMap = new HashMap<String,List<SysDict>>();//审查决定listmap
		Map<String,String> voteCountMap = new HashMap<String,String>();
		Map<String,IrbMinutesForm> minutesMap = new HashMap<String,IrbMinutesForm>();//审查记录map
		Map<String,List<IrbUser>> committeesMap = new HashMap<String,List<IrbUser>>();//主审委员map
		Map<String,IrbUser> consultantMap = new HashMap<String,IrbUser>();//独立顾问map
		if(list!=null&&!list.isEmpty()){
			for (IrbApply irb : list) {
				String irbFlow = irb.getIrbFlow();
				String irbTypeId = irb.getIrbTypeId();
				PubProj proj = this.projBiz.readProjectNoBlogs(irb.getProjFlow());
				IrbForm irbForm = new IrbForm();
				irbForm.setIrb(irb);
				irbForm.setProj(proj);
				String reviewWay = irb.getReviewWayId();
				String meetingArrange = irb.getMeetingArrange();
				if (IrbReviewTypeEnum.Meeting.getId().equals(meetingArrange)) {
					reviewWay = meetingArrange;
				}
				if (IrbReviewTypeEnum.Fast.getId().equals(reviewWay)) {
					if (fastFormList == null) {
						fastFormList = new ArrayList<IrbForm>();
					}
					fastFormList.add(irbForm);
				}
				//irbTypeMap
				if (IrbReviewTypeEnum.Meeting.getId().equals(reviewWay)) {
					List<IrbForm> tempList = irbTypeMap.get(irbTypeId);
					if (tempList == null) {
						tempList = new ArrayList<IrbForm>();
					}
					tempList.add(irbForm);
					irbTypeMap.put(irbTypeId, tempList);
				}
				
				/*决定选项*/
				List<SysDict> decisionList = new ArrayList<SysDict>();
				//voteCountMap
				List<IrbVoteForm> formList = this.irbCommitteeBiz.queryIrbVoteList(irbFlow, null);
				/*统计各决定投票数*/
				for (IrbDecisionEnum de : IrbDecisionEnum.values()) {
					SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
					dict.setDictId(de.getId());
					dict.setDictName(de.getName());
					if(StringUtil.countMatches(de.getIrbTypeId(),irbTypeId)==1){
						decisionList.add(dict);
					}
					
					int dCount = 0;//投票数
					if(StringUtil.countMatches(de.getIrbTypeId(), irbTypeId)==1&&formList!=null&&!formList.isEmpty()){
						for (IrbVoteForm form : formList) {
							if(de.getId().equals(form.getDecisionId())){
								dCount++;
							}
						}
					}
					voteCountMap.put(irbFlow+de.getId(), dCount+"");
				}
				decisionMap.put(irbFlow, decisionList);
				//审查记录
				IrbMinutesForm form = this.meetingBiz.readMinutes(irbFlow);
				minutesMap.put(irbFlow, form);
				//主审委员
				List<IrbUser> committeeList = this.irbUserBiz.searchCommitteeList(irbFlow);	//主审委员
				committeesMap.put(irbFlow, committeeList);
				//独立顾问
				IrbUser consultant = this.irbUserBiz.searchConsultant(irbFlow);//独立顾问
				consultantMap.put(irbFlow, consultant);
			}
		}
		
		List<SysDict> irbTypeEnumList = new ArrayList<SysDict>();
		for(IrbTypeEnum temp : IrbTypeEnum.values()){
			SysDict dict = new SysDict();	//借用SysDict表结构放irbTypeEnumList
			dict.setDictId(temp.getId());
			dict.setDictName(temp.getName());
			irbTypeEnumList.add(dict);
		}
		
		root.put("irbTypeEnumList", irbTypeEnumList);
		root.put("fastFormList", fastFormList);
		root.put("irbTypeMap", irbTypeMap);
		root.put("decisionMap", decisionMap);
		root.put("voteCountMap", voteCountMap);
		root.put("minutesMap", minutesMap);
		root.put("committeesMap", committeesMap);
		root.put("consultantMap", consultantMap);
		root.put("transNum", new NumTrans());
		
		//下载pdf
		final String fileName = meeting.getMeetingDate() + "会议议程";
		String outputFileClass = ResourceLoader.getPath("");
		String outputFile = new File(outputFileClass)
		.getParentFile().getParent() + "/load/" + fileName + ".pdf" ;
		
		File file = new File(outputFile);
		try {
			// 模板数据
			DocumentVo vo = new DocumentVo() {
				@Override
				public String findPrimaryKey() {
					return fileName;
				}
				@Override
				public Map<String, Object> fillDataMap() {
					return root;
				}
			};
				
			String template = "meetingAgendaTemplate.ftl";
			PdfDocumentGenerator pdfGenerator = new PdfDocumentGenerator();
			// 生成pdf
			pdfGenerator.generate(template, vo, outputFile);
		} catch (Exception ex) {
			System.err.println(" \n pdf生成失败");
			ex.printStackTrace();
		}
		
		pubFileBiz.downFile(file,response);
	}
	
	@RequestMapping(value={"/showMeetingFile"},method={RequestMethod.GET})
	public String  showMeetingFile(String meetingFlow , Model model) throws Exception{
		if(StringUtil.isNotBlank(meetingFlow)){
			IrbApply irbApply = new IrbApply();
			irbApply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbApply.setMeetingFlow(meetingFlow);
			irbApply.setMeetingArrange(IrbReviewTypeEnum.Meeting.getId());	//会审
			List<IrbApply> irbList = this.irbApplyBiz.searchIrbs(irbApply);
			model.addAttribute("irbList", irbList);
		}
		return "irb/meeting/meetingFile";
	}
}

