package com.pinde.sci.ctrl.srm;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.ExpertInfo;

@Controller
@RequestMapping("/srm/expert/groupUser")
public class ExpertGroupUserController extends GeneralController{
	
	private static Logger logger = LoggerFactory.getLogger(ExpertGroupUserController.class);
	
	@Autowired
	private IExpertGroupsUserBiz expertGroupsUserBiz;
	@Autowired
	private IExpertGroupBiz expertGroupBiz;
	@Autowired
	private IUserBiz userBiz;
	
	/**
	 * ��ѯδ���뵱ǰ���ר��
	 * @param groupFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/addExpert",method={RequestMethod.GET})
	public String addExpert(ExpertInfo expertInfo,String groupFlow,Model model){
		List<ExpertInfo> expertInfoList = expertGroupsUserBiz.searchSysUserNotInByGroupFlow(groupFlow);	
		model.addAttribute("expertInfoList",expertInfoList);	
		return "srm/expert/groupUser/addExpert";
	}	
	
	/**
	 * ͨ��groupFlow��userFlow��ˮ�����ר�ҵ���Ϣ
	 * @param groupFlow
	 * @param userFlow
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/saveExpertGroupUser",method={RequestMethod.POST})
	@ResponseBody
	public String saveExpertGroupUser(String groupFlow,String [] userFlow,Model model){ 
		expertGroupsUserBiz.saveExpertGroupUser(groupFlow,userFlow);//��groupFlow(ר����ˮ��) userFlows(�û���ˮ��) ��ӵ���Ӧ��ר������
		return GlobalConstant.SAVE_SUCCESSED;
	}
	/**
	 * ��ʾ��ǰר������ר�ҵĵ���Ϣ
	 * @param expertGroupUser
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/list",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SrmExpertGroupUser expertGroupUser,Model model){
		SrmExpertGroup expertGroup = expertGroupBiz.readSrmExpertGroup(expertGroupUser.getGroupFlow());
		model.addAttribute("group", expertGroup);
		
		if(StringUtil.isNotBlank(expertGroupUser.getGroupFlow())){
			SrmExpertGroupUser groupUser = new SrmExpertGroupUser();
			groupUser.setGroupFlow(expertGroupUser.getGroupFlow());//������ˮ�Ż�ȡ��ǰר�ҵ���Ϣ
			List<ExpertInfo> expertInfoList = expertGroupsUserBiz.searchExpertGroupUserInfo(expertGroupUser);//��ѯר�����ж�Ӧ��ר����Ϣ
			model.addAttribute("expertInfoList",expertInfoList);			
		}
		return "srm/expert/groupUser/list";
	}
	
	/**
	 *  ɾ��ר�����µ�ר����Ϣ
	 * @param expertGroupUser
	 * @return
	 */
	@RequestMapping(value="/delete",method={RequestMethod.GET})
	@ResponseBody
	public  String delete(SrmExpertGroupUser expertGroupUser){
		expertGroupUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
		return GlobalConstant.DELETE_SUCCESSED;
	}
//	/**
//	 * jspҳ�� ajax���� ����ר������ר�ҵ�ѡ����Ϣ
//	 * @param recordFlow
//	 * @param expertStatusId
//	 * @return
//	 */
//	@RequestMapping(value="/expertStatusId",method={RequestMethod.POST})
//	@ResponseBody
//	public String test(@RequestParam String recordFlow , @RequestParam String expertStatusId){
//		SrmExpertGroupUser expertGroupUser=new SrmExpertGroupUser();
//		expertGroupUser.setRecordFlow(recordFlow);
//		expertGroupUser.setExpertStatusId(expertStatusId);
//		expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
//	/**
//	 * jspҳ��ajax���� ����ר������ר�ҵ�ר�ҷ��������Ϣ
//	 * @param recordFlow
//	 * @param feedbackInfo
//	 * @return
//	 */
//	@RequestMapping(value="/feedbackInfo",method={RequestMethod.POST})
//	@ResponseBody
//	public String feedbackInfo(@RequestParam String recordFlow , @RequestParam String feedbackInfo){
//		SrmExpertGroupUser expertGroupUser=new SrmExpertGroupUser();
//		expertGroupUser.setRecordFlow(recordFlow);
//		expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
	
	@RequestMapping(value="/search",method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Object search(SysUser user,SysOrg org, String groupFlow,Model model){
	    ExpertInfo expertInfo=new ExpertInfo();
	    expertInfo.setUser(user);
	    expertInfo.setSysOrg(org);
		List<ExpertInfo> expertInfoList = expertGroupsUserBiz.searchSysUserNotInByExpertInfo(groupFlow,expertInfo);	
		return expertInfoList;
	}
	
//	/**
//	 * jspҳ��ajax���� ����ר������ר�ҵ��ʼ�֪ͨ��Ϣ
//	 * @param recordFlow
//	 * @param emailNotifyFlag
//	 * @return
//	 */
//	 
//	@RequestMapping(value="/emailFlag",method={RequestMethod.POST})
//	@ResponseBody
//	public String emailFlag(@RequestParam String recordFlow , @RequestParam String emailNotifyFlag){
//		SrmExpertGroupUser expertGroupUser=new SrmExpertGroupUser();
//		expertGroupUser.setRecordFlow(recordFlow);
//		expertGroupUser.setEmailNotifyFlag(emailNotifyFlag);
//		expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
//	/**
//	 * jspҳ��ajax���� ����ר������ר�ҵ��ֻ�֪ͨ��Ϣ
//	 * @param recordFlow
//	 * @param phoneNotifyFlag
//	 * @return
//	 */
//	@RequestMapping(value="/phoneFlag" ,method={RequestMethod.POST})
//	@ResponseBody
//	public String phoneFlag(@RequestParam String recordFlow , @RequestParam String phoneNotifyFlag){
//		SrmExpertGroupUser expertGroupUser=new SrmExpertGroupUser();
//		expertGroupUser.setRecordFlow(recordFlow);
//		expertGroupUser.setPhoneNotifyFlag(phoneNotifyFlag);
//		expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
//		return GlobalConstant.SAVE_SUCCESSED;
//	}
}
