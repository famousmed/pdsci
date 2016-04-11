package com.pinde.sci.ctrl.edc;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjOrgBiz;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjOrg;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

@Controller
@RequestMapping("/edc/projUser")
public class ProjUserController extends GeneralController {	
	private static Logger logger=LoggerFactory.getLogger(ProjUserController.class);
	
	@Autowired
	private IProjUserBiz projUserBiz;
	@Autowired
	private IProjOrgBiz projOrgBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IMsgBiz msgBiz;
	
	@RequestMapping(value = "/list/{userListScope}",method={RequestMethod.GET,RequestMethod.POST})
	public String list(SysUser search,@PathVariable String userListScope,HttpServletRequest request,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
			List<PubProjOrg> pubProjOrgList = projOrgBiz.searchProjOrg(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);	
		}
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){			
			SysUser currUser = GlobalContext.getCurrentUser();
			search.setOrgFlow(currUser.getOrgFlow());
		}
		
		
		if(StringUtil.isNotBlank(search.getOrgFlow())){
			PubProjUser pubProjUserSearch = new PubProjUser();
			pubProjUserSearch.setProjFlow(projFlow);
			List<PubProjUser> pubProjUserList = projUserBiz.search(pubProjUserSearch);
			Map<String,List<PubProjUser>> pubProjUserMap  = new HashMap<String, List<PubProjUser>>();
			for(PubProjUser pubProjUser : pubProjUserList){
				String userFlow = pubProjUser.getUserFlow();
				if(pubProjUserMap.containsKey(userFlow)){
					List<PubProjUser> list = pubProjUserMap.get(userFlow);
					list.add(pubProjUser);
				}else{
					List<PubProjUser> list = new ArrayList<PubProjUser>();
					list.add(pubProjUser);
					pubProjUserMap.put(userFlow, list);
				}
			}			
			model.addAttribute("pubProjUserMap", pubProjUserMap);			

			List<SysUser> sysUserList=userBiz.searchUser(search);
			model.addAttribute("sysUserList",sysUserList);	
		}
		return "edc/projUser/list";
	}
	

	
	@RequestMapping(value={"/add"})
	public String add(Model model){
		
		String userListScope = (String) getSessionAttribute(GlobalConstant.USER_LIST_SCOPE);		
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
			List<PubProjOrg> pubProjOrgList = projOrgBiz.search(projFlow);
			model.addAttribute("pubProjOrgList", pubProjOrgList);		
		}
		
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.ProjLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		model.addAttribute("sysRoleList",sysRoleList);
		
		return "edc/projUser/add";
	}
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	public @ResponseBody String save(SysUser user,String [] roleFlow){
		if(StringUtil.isNotBlank(user.getSexId())){
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		}
		user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
		user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		user.setOrgName(InitConfig.getOrgNameByFlow(user.getOrgFlow()));
		user.setDeptName(InitConfig.getDeptNameByFlow(user.getDeptFlow()));
		//新增用户是判断
		if(StringUtil.isBlank(user.getUserFlow())){
			//判断用户id是否重复
//			SysUser old = userBiz.findByUserCode(user.getUserCode());
//			if(old!=null){
//				return GlobalConstant.USER_CODE_REPETE;
//			}	
			SysUser old = userBiz.findByIdNo(user.getIdNo());
			if(old!=null){
				return GlobalConstant.USER_ID_NO_REPETE;
			}		
			old = userBiz.findByUserPhone(user.getUserPhone());
			if(old!=null){
				return GlobalConstant.USER_PHONE_REPETE;
			}		
			old = userBiz.findByUserEmail(user.getUserEmail());
			if(old!=null){
				return GlobalConstant.USER_EMAIL_REPETE;
			}	
		}

		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		projUserBiz.addUserWithRole(user,projFlow,roleFlow,wsId);
		//发送邀请链接的Email
		_sendInviteEmail(user);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	private void _sendInviteEmail(SysUser user){		
		String title = StringUtil.defaultString(InitConfig.getSysCfg("edc_reg_email_tile"));
		String content = StringUtil.defaultString(InitConfig.getSysCfg("edc_reg_email_content"));
		String url = StringUtil.defaultString(InitConfig.getSysCfg("edc_reg_email_url")).trim()+"?userFlow="+user.getUserFlow();
		content = content+"<p>系统激活链接地址为：<a href='"+url+"' target='_blank'>"+url+"</a></p>";
		//发送注册邮件	
		msgBiz.addEmailMsg(user.getUserEmail(), title, content);
	}
	
	@RequestMapping(value={"/inviteEmail"})
	@ResponseBody
	public String inviteEmail(String userFlow,Model model){		
		SysUser user = userBiz.readSysUser(userFlow);
		_sendInviteEmail(user);
		return GlobalConstant.SEND_INVITE_EMAIL_SUCCESSED;
	}

	@RequestMapping(value="/allotRole",method=RequestMethod.GET)
	public String allotRole(PubProjUser user,Model model,HttpServletRequest request){
		String userFlow = user.getUserFlow();
		SysUser sysUser=userBiz.readSysUser(userFlow);
		model.addAttribute("sysUser",sysUser);
		
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.ProjLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		model.addAttribute("sysRoleList",sysRoleList);

		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		PubProjUser pubProjUserSearch = new PubProjUser();
		pubProjUserSearch.setProjFlow(projFlow);
		pubProjUserSearch.setUserFlow(userFlow);
		List<PubProjUser> pubProjUserList = projUserBiz.search(pubProjUserSearch);
		List<String> roleFlows = new ArrayList<String>();
		for(PubProjUser pubProjUser : pubProjUserList){
			roleFlows.add(pubProjUser.getRoleFlow());
		}
		model.addAttribute("roleFlows",roleFlows);
		return "edc/projUser/allotRole";
	}
	
	@RequestMapping(value="/saveAllot",method=RequestMethod.POST)
	public @ResponseBody String savepop(@RequestParam(value="userFlow",required=true) String userFlow,
				@RequestParam(value="orgFlow",required=true) String orgFlow,
				@RequestParam(value="roleFlow",required=false) String [] roleFlows,Model model,HttpServletRequest request) {
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		
		PubProj edcCurrProj = (PubProj) getSessionAttribute(GlobalConstant.EDC_CURR_PROJ);
		String projFlow = edcCurrProj.getProjFlow();
		
		projUserBiz.saveAllot(projFlow,userFlow,orgFlow,wsId,roleFlows);
		return GlobalConstant.SAVE_SUCCESSED;
	}
}
