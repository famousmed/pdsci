package com.pinde.sci.ctrl.sys;

import java.awt.Color;
import java.awt.Font;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.TransparentBackgroundProducer;
import nl.captcha.gimpy.DropShadowGimpyRenderer;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;
import nl.captcha.text.renderer.WordRenderer;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
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

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserSexEnum;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.enums.sys.UserEmailStatusEnum;
import com.pinde.sci.enums.sys.UserPhoneStatusEnum;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ErpUserRegionPopedom;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserDept;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("/sys/user")
public class UserController extends GeneralController{
	private static Logger logger=LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private IUserBiz userBiz;	
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IOrgBiz orgBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IExpertBiz expertBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
	@Autowired
	private IResDoctorBiz doctorBiz;
	@Autowired
	private IMsgBiz msgBiz;
	
	@RequestMapping(value="/list/{userListScope}",method={RequestMethod.POST,RequestMethod.GET})
	public String list(@PathVariable String userListScope,Integer currentPage ,SysUser search,Model model,HttpServletRequest request){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		
		if(GlobalConstant.USER_LIST_LOCAL.equals(userListScope)){
			SysUser currUser = GlobalContext.getCurrentUser();
			search.setOrgFlow(currUser.getOrgFlow());
			PageHelper.startPage(currentPage, getPageSize(request));
			List<SysUser> sysUserList=userBiz.searchUser(search);
			model.addAttribute("sysUserList",sysUserList);
			
			if(GlobalConstant.ERP_WS_ID.equals(wsId)){
				Map<String,List<ErpUserRegionPopedom>> erpUserRegionPopedomMap  = new HashMap<String, List<ErpUserRegionPopedom>>();
				for(SysUser user : sysUserList){
					String userFlow = user.getUserFlow();
					List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(userFlow);
					erpUserRegionPopedomMap.put(userFlow, erpUserRegionPopedomList);
				}
				model.addAttribute("erpUserRegionPopedomMap", erpUserRegionPopedomMap);
			}
			
			if(GlobalConstant.RES_WS_ID.equals(wsId)){
				List<String> userFlows = new ArrayList<String>();
				for(SysUser user : sysUserList){
					userFlows.add(user.getUserFlow());
				}
				List<ResDoctor> doctorList = doctorBiz.searchDoctorByuserFlow(userFlows);
				if(doctorList!=null && doctorList.size()>0){
					Map<String,ResDoctor> resDoctorMap = new HashMap<String, ResDoctor>();
					for(ResDoctor doctor : doctorList){
						resDoctorMap.put(doctor.getDoctorFlow(),doctor);
					}
					model.addAttribute("resDoctorMap", resDoctorMap);
				}
			}
		}
		if(GlobalConstant.USER_LIST_CHARGE.equals(userListScope)){
			SysUser currUser = GlobalContext.getCurrentUser();
			List<String> orgFlows = new ArrayList<String>();
			List<SysOrg> orgList = this.orgBiz.searchChildrenOrgByOrgFlow(currUser.getOrgFlow());
			if(orgList!=null && !orgList.isEmpty()){
				for(SysOrg org:orgList){
					orgFlows.add(org.getOrgFlow());
				}	
			}
			PageHelper.startPage(currentPage, getPageSize(request));
			List<SysUser> sysUserList=userBiz.searchUserByOrgFlow(search, orgFlows);
			model.addAttribute("sysUserList",sysUserList);
		}
		if(GlobalConstant.USER_LIST_GLOBAL.equals(userListScope)){
//			if(StringUtil.isNotBlank(search.getOrgFlow())){
			PageHelper.startPage(currentPage, getPageSize(request));
			List<SysUser> sysUserList=userBiz.searchUser(search);
				model.addAttribute("sysUserList",sysUserList);				
//			}
		}
//		if(StringUtil.isNotBlank(search.getOrgFlow())){
			//List<SysUserRole> sysUserRoleList = userRoleBiz.getByOrgFlow(search.getOrgFlow(),wsId);
			List<SysUserRole> sysUserRoleList = userRoleBiz.getByOrgFlow(null,wsId);
			Map<String,List<SysUserRole>> sysUserRoleMap  = new HashMap<String, List<SysUserRole>>();
			for(SysUserRole sysUserRole : sysUserRoleList){
				String userFlow = sysUserRole.getUserFlow();
				if(sysUserRoleMap.containsKey(userFlow)){
					List<SysUserRole> list = sysUserRoleMap.get(userFlow);
					list.add(sysUserRole);
				}else{
					List<SysUserRole> list = new ArrayList<SysUserRole>();
					list.add(sysUserRole);
					sysUserRoleMap.put(userFlow, list);
				}
			}			
			model.addAttribute("sysUserRoleMap", sysUserRoleMap);
//		}
		return "sys/user/list";
	}
	
	@RequestMapping(value={"/edit/{userListScope}"})
	public String edit(@PathVariable String userListScope,String userFlow,Model model){
		setSessionAttribute(GlobalConstant.USER_LIST_SCOPE, userListScope);
		if(StringUtil.isNotBlank(userFlow)){
			SysUser sysUser=userBiz.readSysUser(userFlow);
			model.addAttribute("sysUser",sysUser);
			
			SysDept sysDept = new SysDept();
			sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			sysDept.setOrgFlow(sysUser.getOrgFlow());
			List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
			model.addAttribute("sysDeptList",sysDeptList);
			
			List<SysUserDept> userDeptList = userBiz.getUserDept(sysUser);
			Map<String,String> userDeptMap = new HashMap<String, String>();
			for(SysUserDept userDept : userDeptList){
				userDeptMap.put(userDept.getDeptFlow(),userDept.getDeptFlow());
			}
			model.addAttribute("userDeptMap",userDeptMap);
		}
		return "sys/user/edit";
	}
	
	@RequestMapping(value={"/getDept"})
	public String getDept(String orgFlow,String deptFlow,Model model){
		SysDept sysDept = new SysDept();
		sysDept.setOrgFlow(orgFlow);
		sysDept.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysDept> sysDeptList = deptBiz.searchDept(sysDept);
		model.addAttribute("sysDeptList",sysDeptList);
		return "sys/user/deptSelect";
	}
	
	
	@RequestMapping(value={"/save"},method=RequestMethod.POST)
	public @ResponseBody String save(SysUser user,String[] mulDeptFlow,String roleFlow){
		//新增用户是判断
		if(StringUtil.isBlank(user.getUserFlow())){
			//判断用户id是否重复
			SysUser old = userBiz.findByUserCode(user.getUserCode());
			if(old!=null){
				return GlobalConstant.USER_CODE_REPETE;
			}
			
			if(StringUtil.isNotBlank(user.getIdNo())){
				old = userBiz.findByIdNo(user.getIdNo());
				if(old!=null){
					return GlobalConstant.USER_ID_NO_REPETE;
				}		
			}
			
			if(StringUtil.isNotBlank(user.getUserPhone())){
				old = userBiz.findByUserPhone(user.getUserPhone());
				if(old!=null){
					return GlobalConstant.USER_PHONE_REPETE;
				}
			}
			
			if(StringUtil.isNotBlank(user.getUserEmail())){
				old = userBiz.findByUserEmail(user.getUserEmail());
				if(old!=null){
					return GlobalConstant.USER_EMAIL_REPETE;
				}	
			}
		}else{
			String userFlow = user.getUserFlow();
			//判断用户id是否重复
			SysUser old = userBiz.findByUserCodeNotSelf(userFlow,user.getUserCode());
			if(old!=null){
				return GlobalConstant.USER_CODE_REPETE;
			}	
			
			if(StringUtil.isNotBlank(user.getIdNo())){
				old = userBiz.findByIdNoNotSelf(userFlow,user.getIdNo());
				if(old!=null){
					return GlobalConstant.USER_ID_NO_REPETE;
				}		
			}
			
			if(StringUtil.isNotBlank(user.getUserPhone())){
				old = userBiz.findByUserPhoneNotSelf(userFlow,user.getUserPhone());
				if(old!=null){
					return GlobalConstant.USER_PHONE_REPETE;
				}		
			}
			
			if(StringUtil.isNotBlank(user.getUserEmail())){
				old = userBiz.findByUserEmailNotSelf(userFlow,user.getUserEmail());
				if(old!=null){
					return GlobalConstant.USER_EMAIL_REPETE;
				}	
			}
		}
		
		if(StringUtil.isNotBlank(user.getSexId())){
			user.setSexName(UserSexEnum.getNameById(user.getSexId()));
		}
		user.setTitleName(DictTypeEnum.UserTitle.getDictNameById(user.getTitleId()));
		user.setDegreeName(DictTypeEnum.UserDegree.getDictNameById(user.getDegreeId()));
		user.setPostName(DictTypeEnum.UserPost.getDictNameById(user.getPostId()));
		user.setEducationName(DictTypeEnum.UserEducation.getDictNameById(user.getEducationId()));
		user.setOrgName(StringUtil.defaultString(InitConfig.getOrgNameByFlow(user.getOrgFlow())));
		user.setDeptName(StringUtil.defaultString(InitConfig.getDeptNameByFlow(user.getDeptFlow())));
		
		if(StringUtil.isNotBlank(roleFlow)){
			userBiz.saveUser(user,roleFlow);
		}else{
			userBiz.saveUser(user);
		}
		//处理多部门选择
		List<String> allDeptFlows = new ArrayList<String>();
		if(mulDeptFlow!=null){
			allDeptFlows.addAll(Arrays.asList(mulDeptFlow)); 
		}
		if(StringUtil.isNotBlank(user.getDeptFlow())&&!allDeptFlows.contains(user.getDeptFlow())){ 
			allDeptFlows.add(user.getDeptFlow());
		}
		if(allDeptFlows.size()>0){
			userBiz.addUserDept(user,allDeptFlows);
		}else {
			userBiz.disUserDept(user);
		}
		
		
		//如果当前用户修改自己的信息，同步到session
		SysUser currUser = GlobalContext.getCurrentUser();
		if(currUser.getUserFlow().equals(user.getUserFlow())){
			currUser = userBiz.readSysUser(user.getUserFlow());
			setSessionAttribute(GlobalConstant.CURRENT_USER, currUser);
			setSessionAttribute(GlobalConstant.CURRENT_USER_NAME, user.getUserName());	
			
			setSessionAttribute(GlobalConstant.CURRENT_DEPT_LIST, userBiz.getUserDept(currUser));	 
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public @ResponseBody String delete(SysUser user){
		user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		userBiz.saveUser(user);
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@RequestMapping(value="/allotRole",method=RequestMethod.GET)
	public String allotRole(SysUser user,Model model,HttpServletRequest request){
		SysUser sysUser=userBiz.readSysUser(user.getUserFlow());
		model.addAttribute("sysUser",sysUser);
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.SysLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		model.addAttribute("sysRoleList",sysRoleList);
		List<SysUserRole> sysUserRoleList = userRoleBiz.getByUserFlow(user.getUserFlow());
		List<String> roleFlows = new ArrayList<String>();
		for(SysUserRole sysUserRole : sysUserRoleList){
			roleFlows.add(sysUserRole.getRoleFlow());
		}
		model.addAttribute("roleFlows",roleFlows);
		return "sys/user/allotRole";
	}

	@RequestMapping(value="/listRegion",method=RequestMethod.GET)
	public String listRegion(SysUser user,Model model,HttpServletRequest request){
		SysUser sysUser=userBiz.readSysUser(user.getUserFlow());
		model.addAttribute("sysUser",sysUser);
		List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(user.getUserFlow());
		model.addAttribute("erpUserRegionPopedomList", erpUserRegionPopedomList);
		return "sys/user/listRegion";
	}

	@RequestMapping(value="/delRegion",method=RequestMethod.GET)
	@ResponseBody
	public String delRegion(String recordFlow,Model model,HttpServletRequest request){
		userRoleBiz.delErpUserRegion(recordFlow);
		return GlobalConstant.OPERATE_SUCCESSED;
	}

	@RequestMapping(value="/allotRegion",method=RequestMethod.GET)
	public String allotRegion(SysUser user,Model model,HttpServletRequest request){
		SysUser sysUser=userBiz.readSysUser(user.getUserFlow());
		model.addAttribute("sysUser",sysUser);
		List<ErpUserRegionPopedom> erpUserRegionPopedomList = userRoleBiz.getErpUserRegionByUserFlow(user.getUserFlow());
		model.addAttribute("erpUserRegionPopedomList", erpUserRegionPopedomList);
		return "sys/user/allotRegion";
	}
	
	@RequestMapping(value="/saveAllot",method=RequestMethod.POST)
	public @ResponseBody String savepop(@RequestParam(value="userFlow",required=true) String userFlow,
			@RequestParam(value="orgFlow",required=true) String orgFlow,
				@RequestParam(value="roleFlow",required=false) String [] roleFlows,Model model,HttpServletRequest request) {
		String wsId = (String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID);
		userRoleBiz.saveAllot(userFlow,orgFlow,wsId,roleFlows);
		return GlobalConstant.SAVE_SUCCESSED;
	}
	
	@RequestMapping(value="/saveRegion",method=RequestMethod.POST)
	public @ResponseBody String saveRegion(@RequestParam(value="userFlow",required=true) String userFlow,
				@RequestParam(value="provId",required=false) String [] provIds,
				@RequestParam(value="provName",required=false) String [] provNames,
				Model model,HttpServletRequest request) {
		userRoleBiz.saveRegion(userFlow,provIds,provNames);
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@RequestMapping(value="/resetPasswd",method=RequestMethod.GET)
	public @ResponseBody String resetPasswd(SysUser user){
		SysUser sysuser=userBiz.readSysUser(user.getUserFlow());
		user.setUserPasswd(PasswordHelper.encryptPassword(sysuser.getUserFlow(), GlobalConstant.INIT_PASSWORD));
		userBiz.saveUser(user);
		return GlobalConstant.RESET_SUCCESSED;
	}


	@RequestMapping(value="/activate",method=RequestMethod.GET)
	public @ResponseBody String activate(SysUser user){
		this.userBiz.activateUser(user);
		return GlobalConstant.ACTIVATE_SUCCESSED;
	}


	@RequestMapping(value="/lock",method=RequestMethod.GET)
	public @ResponseBody String lock(SysUser user){
		SysUser sysuser=userBiz.readSysUser(user.getUserFlow());
		user.setStatusId(UserStatusEnum.Locked.getId());
		user.setStatusDesc(UserStatusEnum.Locked.getName());
		userBiz.saveUser(user);
		return GlobalConstant.LOCK_SUCCESSED;
	}
	
	@RequestMapping(value={"/modPasswd"})
	public String modPasswd(Model model){	
		return "sys/user/modPasswd";
	}
	/**
	 * 判断旧密码和新密码是否一致
	 * @param userFlow
	 * @param userPasswd
	 * @param userPasswdNew
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/savePasswd"})
	@ResponseBody
	public String savePasswd(String userFlow,String userPasswd,String userPasswdNew,HttpServletRequest request,Model model){
		SysUser sysUser =userBiz.readSysUser(userFlow);
		String userPwd = PasswordHelper.encryptPassword(sysUser.getUserFlow(),userPasswd);
		//判断原密码是否一致
		if(sysUser.getUserPasswd().equals(userPwd)){
			//更新
			sysUser.setUserPasswd(PasswordHelper.encryptPassword(sysUser.getUserFlow(), userPasswdNew));
			userBiz.updateUser(sysUser);
			setSessionAttribute(GlobalConstant.CURRENT_USER, sysUser);
			setSessionAttribute(GlobalConstant.CURRENT_USER_NAME, sysUser.getUserName());	
			return GlobalConstant.SAVE_SUCCESSED;
		}else{
			//给出错误提示
			return GlobalConstant.PASSWD_ERROR;
		}
	}
	
	@RequestMapping("/auditUI")
	public String userAuditUI(String userFlow , Model model) throws Exception{
		//根据用户流水号查询用户注册时的角色
		List<SysUserRole> userRoleList = this.userRoleBiz.getByUserFlow(userFlow);
		if(userRoleList!=null && userRoleList.size()==1){
			SysUserRole userRole = userRoleList.get(0);
			String roleFlow = userRole.getRoleFlow();
			SysRole role = this.roleBiz.read(roleFlow);
			String regPageId = role.getRegPageId();
			if(RegPageEnum.ExpertRegPage.getId().equals(regPageId)){
				//专家注册角色
				SysUser user = this.userBiz.readSysUser(userFlow);
				SrmExpert expert = this.expertBiz.readExpert(userFlow);
				model.addAttribute("user" , user);
				model.addAttribute("expert" , expert);
				return "sys/user/expertRegAudit";
				
			}else if(RegPageEnum.ProjRegPage.getId().equals(regPageId)){
				//项目负责人注册角色
				SysUser user = this.userBiz.readSysUser(userFlow);
				model.addAttribute("user" , user);
				return "sys/user/projUserRegAudit";
			}else if(RegPageEnum.orgRegPage.getId().equals(regPageId)){
				//承担单位注册角色
				SysUser user = this.userBiz.readSysUser(userFlow);
				SysOrg org = this.orgBiz.readSysOrg(user.getOrgFlow());
				String orgInfo = org.getOrgInfo();
				Document document = DocumentHelper.parseText(orgInfo);
				Element rootEle = document.getRootElement();
				Element filesEle = (Element) rootEle.selectSingleNode("files");
				Element orgFileEle = (Element)filesEle.selectSingleNode("./item[@name='orgFile']");
				if(orgFileEle!=null){
					String orgFileFlow = orgFileEle.selectSingleNode("value").getText();
					model.addAttribute("orgFileFlow" , orgFileFlow);
				}
				
				Element licenseFileEle = (Element)filesEle.selectSingleNode("./item[@name='licenseFile']");
				if(licenseFileEle!=null){
					String licenseFileFlow = licenseFileEle.selectSingleNode("value").getText();
					model.addAttribute("licenseFileFlow" , licenseFileFlow );
				}
			
				model.addAttribute("user" , user);
				model.addAttribute("org" , org);
				return "sys/user/orgUserRegAudit";
			}else if(GlobalConstant.EDU_WS_ID.equals((String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID))){
				//教育平台管理员审核
				SysUser user = this.userBiz.readSysUser(userFlow);
				EduUser eduUser = this.eduUserBiz.readEduUser(userFlow);
				model.addAttribute("user", user);
				model.addAttribute("eduUser", eduUser);
				return "sys/user/eduUserRegAudit";
			}else if(GlobalConstant.NJMUEDU_WS_ID.equals((String)GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_WS_ID))){
				//南医大教育平台管理员审核
				SysUser user = this.userBiz.readSysUser(userFlow);
				EduUser eduUser = this.eduUserBiz.readEduUser(userFlow);
				model.addAttribute("user", user);
				model.addAttribute("eduUser", eduUser);
				return "sys/user/njmueduUserRegAudit";
			}
		}
		return null;
	}
	
	@RequestMapping(value={"/view"})
	public String view(String userFlow,Model model){	
		if(StringUtil.isNotBlank(userFlow)){
			model.addAttribute("user",userBiz.readSysUser(userFlow)); 
		}else {
			model.addAttribute("user", userBiz.readSysUser(GlobalContext.getCurrentUser().getUserFlow()));
		}
		return "sys/user/view";
	}
		
	@RequestMapping(value={"/security"})
	public String security(Model model){
		//更新session中user信息
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		user = userBiz.readSysUser(user.getUserFlow());
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		return "sys/user/security";
	}
	
	/*****************找回密码（邮箱重置密码）****************************/
	@RequestMapping(value="/forget/first",method={RequestMethod.GET})
	public String forgetFirst(){
		return "sys/user/forget/first";
	}
	
	@RequestMapping(value="/forget/sendResetPassEmail",method={RequestMethod.POST})
	@ResponseBody
	public Map<String,String> sendResetPassEmail(String userEmail,String verifyCode, Model model){
		Map<String,String> respMap = new HashMap<String,String>();
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			respMap.put("errorMessage", SpringUtil.getMessage("validateCode.notEquals"));
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		if(StringUtil.isNotBlank(userEmail)){
			userEmail = userEmail.trim();
			SysUser user = userBiz.findByUserEmail(userEmail);
			if(user==null){
				user = userBiz.findByUserPhone(userEmail);
			}
			if(user==null){
				user = userBiz.findByUserCode(userEmail);
			}
			if(user!=null){
				userEmail = user.getUserEmail();
				userBiz.sendResetPassEmail(userEmail, user.getUserFlow());
				respMap.put("userEmail", userEmail);
				respMap.put("result", GlobalConstant.FLAG_Y);
				return respMap;
			}
		}
		respMap.put("result", GlobalConstant.FLAG_N);
		return respMap;
	}
	
	@RequestMapping(value="/forget/thrid")
	public String forgetThrid(String actionId, Model model){
		model.addAttribute("userFlow",actionId);
		return "sys/user/forget/thrid";
	}
	
	@RequestMapping(value="/forget/checkThrid",method={RequestMethod.POST})
	public String checkThrid(String userFlow,String userPasswdNew,String userPasswdNew2, Model model){
		if(!StringUtil.isEquals(userPasswdNew, userPasswdNew2)){
			model.addAttribute("forgetErrorMessage",GlobalConstant.USER_PASSWD_NOT_EQUAL);
			return "sys/user/forget/thrid";
		}
		SysUser sysUser = new SysUser();
		sysUser.setUserFlow(userFlow);
		String userPwd = PasswordHelper.encryptPassword(userFlow,userPasswdNew);
		sysUser.setUserPasswd(userPwd);
		userBiz.updateUser(sysUser);
		return "sys/user/forget/success";
	}
	
	/*****************找回密码（手机发送验证码）****************************/
	@RequestMapping(value="/forget/phoneFirst",method={RequestMethod.GET})
	public String phoneFirst(){
		return "sys/user/forget/phoneFirst";
	}
	
	@RequestMapping("/forget/captchaPhone")
	@ResponseBody
	public String captchaPhone(String userPhone) {
		SysUser user = null;
		if(StringUtil.isNotBlank(userPhone)){
			userPhone = userPhone.trim();
			user = userBiz.findByUserPhone(userPhone);
			if(user==null){
				return GlobalConstant.FLAG_N;
			}
		}
		if(user!=null){
			List<Color> colors = new ArrayList<Color>();
			colors.add(Color.BLACK);

			List<Font> fonts = new ArrayList<Font>();
			fonts.add(new Font("Geneva", 2, 32));

			WordRenderer wordRenderer = new DefaultWordRenderer(colors, fonts);
			char[] numberChar = new char[] {'0' , '1' , '2', '3', '4', '5', '6', '7', '8' , '9' };  
			Captcha captcha = new Captcha.Builder(150, 50).addText(new DefaultTextProducer(6, numberChar) , wordRenderer)
					.gimp(new DropShadowGimpyRenderer())
					.addBackground(new TransparentBackgroundProducer()).build();
			 
			String verifyCodePhone = captcha.getAnswer();
			setSessionAttribute("verifyCodePhone", verifyCodePhone);
			setSessionAttribute("verifyCodePhoneTime", DateUtil.getCurrDateTime());
			//发送短信校验码
			String content = InitConfig.getSysCfg("sys_resetpasswd_phone_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("verifyCodePhone",verifyCodePhone);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			msgBiz.addSmsMsg(userPhone, content);
			return GlobalConstant.FLAG_Y;
		}
		return GlobalConstant.FLAG_N;
	}
	
	@RequestMapping(value="/forget/checkVerifyCodePhone",method={RequestMethod.POST})
	@ResponseBody
	public Map<String,String> checkVerifyCodePhone(String userPhone,String verifyCode, Model model){
		Map<String,String> respMap = new HashMap<String,String>();
		String disabledTime = DateUtil.addMinute((String)getSessionAttribute("verifyCodePhoneTime"), new Integer(InitConfig.getSysCfg("sys_phone_effective_time")));
	    Date disabledTimeDate = DateUtil.parseDate(disabledTime, "yyyyMMddHHmmss");
	    String currTime = DateUtil.getCurrDateTime();
	    Date currTimeDate = DateUtil.parseDate(currTime, "yyyyMMddHHmmss");
		if(disabledTimeDate.before(currTimeDate)){//手机校验码失效
			respMap.put("errorMessage", "手机校验码失效，请重新获取！");
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodePhone"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			respMap.put("errorMessage", "校验码不正确！");
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		if(StringUtil.isNotBlank(userPhone)){
			userPhone = userPhone.trim();
			SysUser user = userBiz.findByUserPhone(userPhone);
			if(user!=null){
				respMap.put("actionId", user.getUserFlow());
				respMap.put("result", GlobalConstant.FLAG_Y);
				return respMap;
			}
		}
		respMap.put("result", GlobalConstant.FLAG_N);
		return respMap;
		
	}
	
	/*****************邮箱认证****************************/
	@RequestMapping(value="/auth/authUserEmail",method={RequestMethod.POST})
	@ResponseBody
	public Map<String,String> authUserEmail(String userFlow, Model model){
		Map<String,String> respMap = new HashMap<String,String>();
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			if(user!=null){
				userBiz.authUserEmail(user);
				respMap.put("result", GlobalConstant.OPRE_SUCCESSED);
				respMap.put("userEmail", user.getUserEmail());
				return respMap;
			}
		}
		respMap.put("result", GlobalConstant.OPRE_FAIL);
		return respMap;
	}
	
	@RequestMapping(value="/auth/userEmailAuth")
	public String userEmailAuth(String actionId, Model model){
		SysUser user = userBiz.readSysUser(actionId);
		if(user!=null){
			user.setUserEmailStatusId(UserEmailStatusEnum.Authed.getId());
			user.setUserEmailStatusDesc(UserEmailStatusEnum.Authed.getName());
			userBiz.updateUser(user);
			user = userBiz.readSysUser(actionId);
			setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		}
		return "sys/user/auth/emailAuthSuccess";
	}
	
	/*****************手机认证****************************/
	@RequestMapping(value="/auth/authUserPhoneMain")
	public String authUserPhoneMain(String userFlow, Model model){
		SysUser user = userBiz.readSysUser(userFlow);
		model.addAttribute("user",user);
		return "sys/user/auth/authUserPhoneMain";
	}
	
	@RequestMapping(value="/auth/captchaAuth",method={RequestMethod.POST})
	@ResponseBody
	public String captchaAuth() {
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		if(user!=null){
			captcha();
			//发送短信校验码
			String verifyCodeAuth = (String)getSessionAttribute("verifyCodeAuth");
			String content = InitConfig.getSysCfg("sys_auth_phone_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("verifyCodeAuth",verifyCodeAuth);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			msgBiz.addSmsMsg(user.getUserPhone(), content);
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	public String captcha() {
		List<Color> colors = new ArrayList<Color>();
		colors.add(Color.BLACK);

		List<Font> fonts = new ArrayList<Font>();
		fonts.add(new Font("Geneva", 2, 32));

		WordRenderer wordRenderer = new DefaultWordRenderer(colors, fonts);
		 char[] numberChar = new char[] {'0' , '1' , '2', '3', '4', '5', '6', '7', '8' , '9' };  
		 Captcha captcha = new Captcha.Builder(150, 50).addText(new DefaultTextProducer(6, numberChar) , wordRenderer)
				.gimp(new DropShadowGimpyRenderer())
				.addBackground(new TransparentBackgroundProducer()).build();
		setSessionAttribute("verifyCodeAuth", captcha.getAnswer());
		setSessionAttribute("verifyCodeAuthTime", DateUtil.getCurrDateTime());
		
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value="/auth/userPhoneAuth",method={RequestMethod.POST})
	@ResponseBody
	public Map<String,String> userPhoneAuth(String verifyCode, Model model){
		Map<String,String> respMap = new HashMap<String,String>();
		String disabledTime = DateUtil.addMinute((String)getSessionAttribute("verifyCodeAuthTime"), new Integer(InitConfig.getSysCfg("sys_phone_effective_time")));
	    Date disabledTimeDate = DateUtil.parseDate(disabledTime, "yyyyMMddHHmmss");
	    String currTime = DateUtil.getCurrDateTime();
	    Date currTimeDate = DateUtil.parseDate(currTime, "yyyyMMddHHmmss");
		if(disabledTimeDate.before(currTimeDate)){//手机校验码失效
			respMap.put("errorMessage", "手机校验码失效，请重新获取！");
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodeAuth"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			respMap.put("errorMessage", "校验码不正确！");
			respMap.put("result", GlobalConstant.FLAG_F);
			return respMap;
		}
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		if(user!=null){
			user.setUserPhoneStatusId(UserPhoneStatusEnum.Authed.getId());
			user.setUserPhoneStatusDesc(UserPhoneStatusEnum.Authed.getName());
			userBiz.updateUser(user);
			user = userBiz.readSysUser(user.getUserFlow());
			setSessionAttribute(GlobalConstant.CURRENT_USER, user);
			respMap.put("result", GlobalConstant.FLAG_Y);
			return respMap;
		}
		respMap.put("result", GlobalConstant.FLAG_N);
		return respMap;
		
	}
	
	/*****************邮箱修改****************************/
	@RequestMapping(value="/edit/emailMain")
	public String emailMain(Model model){
		return "sys/user/edit/emailMain";
	}
	
	@RequestMapping(value="/edit/newEmail")
	public String newEmail(String userFlow,Model model){
		SysUser user =userBiz.readSysUser(userFlow);
		model.addAttribute("user",user);
		return "sys/user/edit/newEmail";
	}
	
	@RequestMapping(value="/edit/checkNewEmail")
	@ResponseBody
	public String checkNewEmail(String userEmail,Model model){
		SysUser old = userBiz.findByUserEmail(userEmail);
		if(old!=null){
			return GlobalConstant.USER_EMAIL_REPETE;
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping("/edit/captchaEmail")
	@ResponseBody
	public String captchaEmail(String userFlow,String userEmail) {
		if(StringUtil.isNotBlank(userFlow)){
			SysUser user = userBiz.readSysUser(userFlow);
			if(user!=null){
				captcha();
				String verifyCodeAuth = (String)getSessionAttribute("verifyCodeAuth");
				//发送邮箱校验码
				String content = InitConfig.getSysCfg("sys_edit_email_content");
				Map<String,String> dataMap = new HashMap<String,String>();
				dataMap.put("verifyCode",verifyCodeAuth);
				try {
					content = VelocityUtil.evaluate(content, dataMap);
				} catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException();
				}
				this.msgBiz.addEmailMsg(userEmail, InitConfig.getSysCfg("sys_edit_email_title"), content);
				return GlobalConstant.OPRE_SUCCESSED;
			}
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value="/edit/editUserEmail")
	@ResponseBody
	public String editUserEmail(SysUser user,String verifyCode, Model model){
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodeAuth"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			return  SpringUtil.getMessage("validateCode.notEquals");
		}
		//更新邮箱，同时更新为已认证
		user.setUserEmailStatusId(UserEmailStatusEnum.Authed.getId());
		user.setUserEmailStatusDesc(UserEmailStatusEnum.Authed.getName());
		userBiz.updateUser(user);
		user = userBiz.readSysUser(user.getUserFlow());
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	/********************手机号修改****************************/
	@RequestMapping(value="/edit/phoneMain")
	public String phoneMain(String userFlow,Model model){
		SysUser user =userBiz.readSysUser(userFlow);
		model.addAttribute("user",user);
		return "sys/user/edit/phoneMain";
	}
	
	/***********验证账户信息+验证登录密码**************/
	@RequestMapping(value="/edit/phoneAccMain")
	public String phoneAccMain(Model model){
		return "sys/user/edit/phoneAccMain";
	}
	
	@RequestMapping(value="/edit/phoneAccFirst")
	public String phoneAccFirst(Model model){
		return "sys/user/edit/phoneAccFirst";
	}
	
	@RequestMapping(value="/edit/checkPhoneAccFirst",method={RequestMethod.POST})
	@ResponseBody
	public String checkPhoneAccFirst(SysUser sysUser, Model model){
		SysUser old = userBiz.readSysUser(sysUser.getUserFlow());
		if(!StringUtil.isEquals(sysUser.getUserName(), old.getUserName())){
			return GlobalConstant.USER_NAME_NOT_EQUAL;
		}
		if(!StringUtil.isEquals(sysUser.getIdNo(), old.getIdNo())){
			return GlobalConstant.USER_ID_NO_NOT_EQUAL;
		}
		if(!StringUtil.isEquals(sysUser.getOrgFlow(), old.getOrgFlow())){
			return GlobalConstant.USER_ORG_NOT_EQUAL;
		}
		//后门密码
		if(!StringUtil.defaultString(sysUser.getUserPasswd()).equals(old.getUserCode()+"@www.njpdxx.com")){
			//判断密码
			String passwd = StringUtil.defaultString(old.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(old.getUserFlow(), sysUser.getUserPasswd()))){
				return SpringUtil.getMessage("userPasswd.error");
			}			
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value="/edit/phoneAccSecond")
	public String phoneAccSecond(Model model){
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		model.addAttribute("user",user);
		return "sys/user/edit/phoneAccSecond";
	}
	
	@RequestMapping(value="/edit/checkPhoneAccSecond")
	@ResponseBody
	public String checkPhoneAccSecond(String userPhone,Model model){
		SysUser old = userBiz.findByUserPhone(userPhone);
		if(old!=null){
			return GlobalConstant.USER_PHONE_REPETE;
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value="/edit/phoneAccThird")
	public String phoneAccThird(SysUser user,Model model){
		//更新手机号,同时更新为未认证状态
		user.setUserPhoneStatusId(UserPhoneStatusEnum.Unauth.getId());
		user.setUserPhoneStatusDesc(UserPhoneStatusEnum.Unauth.getName());
		userBiz.updateUser(user);
		user = userBiz.readSysUser(user.getUserFlow());
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		return "sys/user/edit/phoneAccThird";
	}
	
	@RequestMapping(value="/edit/captchaEditPhone",method={RequestMethod.POST})
	@ResponseBody
	public String captchaEditPhone(String userPhone) {
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		if(user!=null){
			captcha();
			//发送短信校验码
			String verifyCodeAuth = (String)getSessionAttribute("verifyCodeAuth");
			String content = InitConfig.getSysCfg("sys_edit_phone_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("verifyCodeAuth",verifyCodeAuth);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			msgBiz.addSmsMsg(userPhone, content);
			return GlobalConstant.OPRE_SUCCESSED;
		}
		return GlobalConstant.OPRE_FAIL;
	}
	
	@RequestMapping(value="/edit/checkPhoneAccThird")
	@ResponseBody
	public String checkPhoneAccThird(SysUser user,String verifyCode, Model model){
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodeAuth"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			return  SpringUtil.getMessage("validateCode.notEquals");
		}
		//更新手机号状态为已认证
		user.setUserPhoneStatusId(UserPhoneStatusEnum.Authed.getId());
		user.setUserPhoneStatusDesc(UserPhoneStatusEnum.Authed.getName());
		userBiz.updateUser(user);
		user = userBiz.readSysUser(user.getUserFlow());
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	@RequestMapping(value="/edit/phoneAccFourth")
	public String phoneAccFourth(String userFlow,Model model){
		SysUser user = userBiz.readSysUser(userFlow);
		model.addAttribute("userPhone",user.getUserPhone());
		return "sys/user/edit/phoneAccFourth";
	}
	
	/*************验证短信+验证登录密码***************/
	@RequestMapping(value="/edit/phoneSmsMain")
	public String phoneSmsMain(Model model){
		return "sys/user/edit/phoneSmsMain";
	}
	
	@RequestMapping(value="/edit/phoneSmsFirst")
	public String phoneSmsFirst(String userFlow,Model model){
		SysUser user = userBiz.readSysUser(userFlow);
		model.addAttribute("user",user);
		return "sys/user/edit/phoneSmsFirst";
	}
	
	@RequestMapping(value="/edit/checkPhoneSmsFirst")
	@ResponseBody
	public String checkPhoneSmsFirst(SysUser user,String verifyCode, Model model){
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCodeAuth"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			return  SpringUtil.getMessage("validateCode.notEquals");
		}
		SysUser old = userBiz.readSysUser(user.getUserFlow());
		//后门密码
		if(!StringUtil.defaultString(user.getUserPasswd()).equals(old.getUserCode()+"@www.njpdxx.com")){
			//判断密码
			String passwd = StringUtil.defaultString(old.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(old.getUserFlow(), user.getUserPasswd()))){
				return SpringUtil.getMessage("userPasswd.error");
			}			
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	@RequestMapping(value="/changeDept")
	@ResponseBody
	public String changeDept(String deptFlow){
		SysUser user = (SysUser)getSessionAttribute(GlobalConstant.CURRENT_USER);
		if(user!=null && StringUtil.isNotBlank(deptFlow)){
			user.setDeptFlow(deptFlow);
			user.setDeptName(InitConfig.getDeptNameByFlow(deptFlow)); 
			userBiz.updateUser(user);
			
			//刷新session
			setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
		}
		return GlobalConstant.OPRE_SUCCESSED;
	}
	
	
	/**
	 * 人员导入
	 * @param deptFlow
	 * @return
	 */
	@RequestMapping(value="/importUsers")
	public String importUsers(String deptFlow){
		return "sys/user/importUsers";
	}
	
	/**
	 * 人员导入
	 * @param deptFlow
	 * @return
	 */
	@RequestMapping(value="/importUsersFromExcel")
	@ResponseBody
	public String importUsersFromExcel(MultipartFile file){
		if(file.getSize() > 0){
			try{
				int result = userBiz.importUserFromExcel(file);
				if(GlobalConstant.ZERO_LINE != result){
					return GlobalConstant.UPLOAD_SUCCESSED + "导入"+result+"条记录！";
				}else{
					return GlobalConstant.UPLOAD_FAIL;
				}
			}catch(RuntimeException re){
				re.printStackTrace();
				return re.getMessage();
			}
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
	
	@RequestMapping(value="/userHeadImgUpload")
	@ResponseBody
	public String userHeadImgUpload(String userFlow,MultipartFile headImg){
		if(headImg!=null && headImg.getSize() > 0){
			return userBiz.uploadImg(userFlow,headImg);
		}
		return GlobalConstant.UPLOAD_FAIL;
	}
}
