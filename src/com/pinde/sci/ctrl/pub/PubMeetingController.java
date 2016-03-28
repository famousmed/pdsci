package com.pinde.sci.ctrl.pub;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubMeetingBiz;
import com.pinde.sci.biz.pub.IPubTrainUserBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.enums.pub.MeetingTypeEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.mo.PubMeeting;
import com.pinde.sci.model.mo.PubMeetingFile;
import com.pinde.sci.model.mo.PubMeetingUser;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/pub/meeting")
public class PubMeetingController extends GeneralController{    
	
	private static Logger logger = LoggerFactory.getLogger(PubMeetingController.class);
	
	@Autowired
	private IPubMeetingBiz pubMeetingBiz;
	@Autowired
	private IPubTrainUserBiz trainUserBiz;
	@Autowired
	private IUserBiz userBiz;
	
	/**
	 * 会议管理
	 */

	@RequestMapping(value = {"/{meetingType}" },method={RequestMethod.GET})
	public String meetingList(@PathVariable String meetingType,String meetingName,String startDate,String endDate,Model model) {
		List<PubMeeting> meetingList = pubMeetingBiz.searchPubMeetingByConditions(startDate, endDate, meetingName,meetingType);
		model.addAttribute("meetingList",meetingList);
		
		model.addAttribute("meetingType",meetingType);
		return "pub/meeting/list";
	}
	
	@RequestMapping(value = {"/search{meetingType}" },method={RequestMethod.POST})
	public String searchMeeting(@PathVariable String meetingType,String meetingName,String startDate,String endDate,Model model) {
		return meetingList(meetingType,meetingName,startDate,endDate,model);
	}
	
	@RequestMapping(value = {"/editMeeting{meetingType}" }, method = RequestMethod.GET)
	public String editMeeting (@PathVariable String meetingType,String meetingFlow,Model model) throws Exception{
		if(StringUtil.isNotBlank(meetingFlow)){
			PubMeeting meeting = pubMeetingBiz.readPubMeeting(meetingFlow);
			model.addAttribute("meeting",meeting);
			
			List<String> meetingFlows = new ArrayList<String>();
			meetingFlows.add(meetingFlow);
			
			List<PubMeetingUser> meetingUserList = pubMeetingBiz.searchPubMeetingUserByMeetingFlow(meetingFlows);
			model.addAttribute("meetingUserList",meetingUserList);
			
			List<PubMeetingFile> meetingFileList = pubMeetingBiz.searchPubMeetingFileByMeetingFlow(meetingFlows);
			model.addAttribute("meetingFileList",meetingFileList);
			
			SysUser user = new SysUser();
			user.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
			List<SysUser> sysUserList = userBiz.searchUser(user);
			if(sysUserList != null && sysUserList.size()>0){
				Map<String,SysUser> sysUserMap = new HashMap<String,SysUser>();
				for(SysUser userTemp : sysUserList){
					sysUserMap.put(userTemp.getUserFlow(),userTemp);
				}
				model.addAttribute("sysUserMap", sysUserMap);
			}
		}
		
		model.addAttribute("meetingType",meetingType);
		return "pub/meeting/editMeeting";
	}
	
	@RequestMapping(value={"/userMain"},method={RequestMethod.GET,RequestMethod.POST})
	public String  userMain(SysUser search,String meetingFlow,Model model){
		List<SysDept> deptList = trainUserBiz.queryIrbDept();
		model.addAttribute("deptList", deptList);
		
		search.setOrgFlow(GlobalContext.getCurrentUser().getOrgFlow());
		search.setStatusId(UserStatusEnum.Activated.getId());
		List<SysUser> sysUserList = userBiz.searchUser(search);
		model.addAttribute("sysUserList", sysUserList);
		
		if(StringUtil.isNotBlank(meetingFlow)){
			List<String> meetingFlows = new ArrayList<String>();
			meetingFlows.add(meetingFlow);
			List<PubMeetingUser> meetingUserList = pubMeetingBiz.searchPubMeetingUserByMeetingFlow(meetingFlows);
			if(meetingUserList != null && meetingUserList.size()>0){
				Map<String,PubMeetingUser> selMeetingUserMap = new HashMap<String,PubMeetingUser>();
				for(PubMeetingUser meetingUser : meetingUserList){
					selMeetingUserMap.put(meetingUser.getUserFlow(),meetingUser);
				}
				model.addAttribute("selMeetingUserMap",selMeetingUserMap);
			}
		}
		
		return "pub/meeting/userMain";
	}
	
	@RequestMapping(value = "/saveMeeting",method={RequestMethod.POST})
	@ResponseBody
	public String saveMeeting(@RequestParam(value="file", required=false)MultipartFile[] files,String[] userFlow,PubMeeting meeting,Model model) throws Exception{
		meeting.setMeetingTypeName(MeetingTypeEnum.getNameById(meeting.getMeetingTypeId()));
		if(pubMeetingBiz.saveMeeting(files,userFlow, meeting) != GlobalConstant.ZERO_LINE){
			return GlobalConstant.SAVE_SUCCESSED;
		}
		return GlobalConstant.SAVE_FAIL;
	}
	
	@RequestMapping(value = "/delMeetingUser",method={RequestMethod.POST})
	@ResponseBody
	public String delMeetingUser(String recordFlow,Model model){
		if(StringUtil.isNotBlank(recordFlow)){
			PubMeetingUser meetingUser = new PubMeetingUser();
			meetingUser.setRecordFlow(recordFlow);
			meetingUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			int result = pubMeetingBiz.savePubMeetingUser(meetingUser);
			if(result != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}
	
	@RequestMapping(value={"/delMeetingFiles"},method={RequestMethod.POST})
	@ResponseBody
	public String delMeetingFiles(String[] fileFlows,Model model) throws Exception{
		if(fileFlows != null && fileFlows.length>0){
			List<String> fileFlowList = new ArrayList<String>();
			for(String fileFlow : fileFlows){
				fileFlowList.add(fileFlow);
			}
			if(pubMeetingBiz.delMeetingFiles(fileFlowList) != GlobalConstant.ZERO_LINE){
				return GlobalConstant.DELETE_SUCCESSED;
			}
		}
		return GlobalConstant.DELETE_FAIL;
	}

	@RequestMapping(value={"/delMeeting"},method={RequestMethod.POST})
	@ResponseBody
	public String delMeeting(String meetingFlow,Model model){
		if(pubMeetingBiz.delPubMeeting(meetingFlow) != GlobalConstant.ZERO_LINE){
			return GlobalConstant.DELETE_SUCCESSED;
		}
		return GlobalConstant.DELETE_FAIL;
	}
}
