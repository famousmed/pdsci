package com.pinde.sci.ctrl.sys;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRegBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.srm.RegPageEnum;
import com.pinde.sci.enums.sys.RoleLevelEnum;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.UserRegForm;

@Controller
@RequestMapping("/reg")
@SessionAttributes({"form" , "noRegOrgList"})
public class RegisterController extends GeneralController {
	
	@Autowired
	private IUserRegBiz userRegBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private IOrgBiz orgBiz;

	private static Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@ModelAttribute("form")
	public UserRegForm initForm() {
		logger.debug("initForm()");
		return new UserRegForm();
	}
	
	@RequestMapping(value="/edc/go",method={RequestMethod.GET})
	public String edcReg(String userFlow,Model model){
		if(StringUtil.isBlank(userFlow)){
			return "sys/reg/edc/fail";
		}else{
			SysUser sysUser = userBiz.readSysUser(userFlow);
			if(sysUser == null || StringUtil.isNotEquals(sysUser.getStatusId(), UserStatusEnum.Added.toString())){
				//没有注册 
				//model.addAttribute("message", "没有注册！");
				return "sys/reg/edc/fail";
			}else{
				model.addAttribute("sysUser", sysUser);
				//进入注册页面
				return "sys/reg/edc/reg";
			}
		}
	}
	
	@RequestMapping(value="/edc/saveReg",method={RequestMethod.POST})
	@ResponseBody
	public String edcSaveReg(SysUser sysUser){
		//判断用户id是否重复
		SysUser old = userBiz.findByUserCode(sysUser.getUserCode());
		if(old!=null){
			return GlobalConstant.USER_CODE_REPETE;
		}	
		old = userBiz.readSysUser(sysUser.getUserFlow());
		if(!StringUtil.isEquals(sysUser.getUserName(), old.getUserName())){
			return GlobalConstant.USER_NAME_NOT_EQUAL;
		}
		if(!StringUtil.isEquals(sysUser.getIdNo(), old.getIdNo())){
			return GlobalConstant.USER_ID_NO_NOT_EQUAL;
		}
		if(!StringUtil.isEquals(sysUser.getUserPhone(), old.getUserPhone())){
			return GlobalConstant.USER_PHONE_NOT_EQUAL;
		}
		if(!StringUtil.isEquals(sysUser.getUserEmail(), old.getUserEmail())){
			return GlobalConstant.USER_EMAIL_NOT_EQUAL;
		}
		
		if(StringUtil.isNotBlank(sysUser.getUserFlow())){	
			userRegBiz.activatSysUser(sysUser);
		}
		return GlobalConstant.USER_REG_SUCCESSED;
	}
	
	@RequestMapping(value="/edc/success",method={RequestMethod.GET})
	public String edcSuccess(){
		return "sys/reg/edc/success";
	}
	
	/*************************SRM 注册开始**************************************************/
	@ModelAttribute("sysRoleList")
	public List<SysRole> initInterests() {
		SysRole sysRole = new SysRole();
		sysRole.setWsId((String)getSessionAttribute(GlobalConstant.CURRENT_WS_ID));
		sysRole.setRoleLevelId(RoleLevelEnum.SysLevel.getId());
		sysRole.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		sysRole.setAllowRegFlag(GlobalConstant.FLAG_Y);
		List<SysRole> sysRoleList = roleBiz.search(sysRole);
		return sysRoleList;
	}
	
	@RequestMapping(value="/srm/go",method={RequestMethod.GET})
	public String srmReg(Model model){
		return "sys/reg/srm/reg";
	}
	
	@RequestMapping(value = "/srm/regist", method = {RequestMethod.POST}, params = {"_next", "!_prev", "!_finish"})
	public String processNext( @ModelAttribute("form") UserRegForm form , Model model) {
		String roleFlow = form.getRoleFlow();
		SysRole role = this.roleBiz.read(roleFlow);
		if(RegPageEnum.orgRegPage.getId().equals(role.getRegPageId())){
			//机构管理员注册角色
			//没有被机构管理员角色注册过的机构
			List<SysOrg> noRegOrgList = this.orgBiz.searchOrgNoRegByRoleFlow(roleFlow);
			model.addAttribute("noRegOrgList" , noRegOrgList);
		}
		return role.getRegPageId();
	}
	
	@RequestMapping(value = "/srm/regist", method = {RequestMethod.POST}, params = {"!_next", "_prev", "!_finish"})
	public String processPrev( @ModelAttribute("form") UserRegForm form , Model model) {
		return "sys/reg/srm/reg";
	}
	
	@RequestMapping(value = "/srm/regist", method = {RequestMethod.POST}, params = {"!_next", "!_prev", "_finish"})
	public String processFinish(@ModelAttribute("form") UserRegForm form, BindingResult bindingResult, SessionStatus sessionStatus , Model model) {
		String roleFlow = form.getRoleFlow();
		SysRole role = this.roleBiz.read(roleFlow);
		//srm 注册校验
		String eroMsg = this.userRegBiz.srmRegValidate(form , role);
		if(StringUtil.isNotBlank(eroMsg)){
			model.addAttribute("eroMsg" , eroMsg);
			return role.getRegPageId();
		}else{
			this.userRegBiz.regUser(form , role);
			sessionStatus.setComplete();
			return "redirect:/reg/success";
		}	
		
	}
	
	@RequestMapping("/success")
	public String success(){
		return "sys/reg/srm/success";
	}
	
	@RequestMapping(value="/srm/success",method={RequestMethod.GET})
	public String srmSuccess(){
		return "sys/reg/srm/success";
	}
	/*************************SRM 注册结束**************************************************/
	
	@RequestMapping(value="/forget/first",method={RequestMethod.GET})
	public String forgetFirst(){
		return "sys/reg/forget/first";
	}
	
	@RequestMapping(value="/forget/checkFirst",method={RequestMethod.POST})
	public String checkFirst(String forgetType,String forgetName,String verifyCode, Model model){
		SysUser old = null;
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			model.addAttribute("forgetErrorMessage",SpringUtil.getMessage("validateCode.notEquals"));
			return "sys/reg/forget/first";
		}
		if("userCode".equals(forgetType)){
			old = userBiz.findByUserCode(forgetName);
			if(old==null){
				model.addAttribute("forgetErrorMessage",GlobalConstant.USER_CODE_NOT_EXIST);
				return "sys/reg/forget/first";
			}
		}
		if("userPhone".equals(forgetType)){
			old = userBiz.findByUserPhone(forgetName);
			if(old==null){
				model.addAttribute("forgetErrorMessage",GlobalConstant.USER_PHONE_NOT_EXIST);
				return "sys/reg/forget/first";
			}		
		}
		if("userEmail".equals(forgetType)){
			old = userBiz.findByUserEmail(forgetName);
			if(old==null){
				model.addAttribute("forgetErrorMessage",GlobalConstant.USER_EMAIL_NOT_EXIST);
				return "sys/reg/forget/first";
			}		
		}
		if("idNo".equals(forgetType)){
			old = userBiz.findByIdNo(forgetName);
			if(old==null){
				model.addAttribute("forgetErrorMessage",GlobalConstant.ID_NO_NOT_EXIST);
				return "sys/reg/forget/first";
			}		
		}
		if(null==old){
			return "sys/reg/forget/first";			
		}
		model.addAttribute("forgetType",forgetType);
		return "redirect:/reg/forget/second?userFlow="+old.getUserFlow();
	}
	
	@RequestMapping(value="/forget/second",method={RequestMethod.GET})
	public String forgetSecond(String userFlow, Model model){
//		SysUser old = userBiz.readSysUser(userFlow);
		return "sys/reg/forget/second";
	}
	
	@RequestMapping(value="/forget/checkSecond",method={RequestMethod.POST})
	public String checkSecond(SysUser sysUser,String forgetType, Model model){

		SysUser old = userBiz.readSysUser(sysUser.getUserFlow());
		if(!StringUtil.isEquals(sysUser.getUserName(), old.getUserName())){
			model.addAttribute("forgetErrorMessage",GlobalConstant.USER_NAME_NOT_EQUAL);
			return "sys/reg/forget/second";
		}
		if(!"idNo".equals(forgetType) && !StringUtil.isEquals(sysUser.getIdNo(), old.getIdNo())){
			model.addAttribute("forgetErrorMessage",GlobalConstant.USER_ID_NO_NOT_EQUAL);
			return "sys/reg/forget/second";
		}
		if(!StringUtil.isEquals(sysUser.getOrgFlow(), old.getOrgFlow())){
			model.addAttribute("forgetErrorMessage",GlobalConstant.USER_ORG_NOT_EQUAL);
			return "sys/reg/forget/second";
		}
		return "redirect:/reg/forget/thrid?userFlow="+old.getUserFlow();
	}
	
	@RequestMapping(value="/forget/thrid",method={RequestMethod.GET})
	public String forgetThrid(String userFlow, Model model){
//		SysUser old = userBiz.readSysUser(userFlow);
		return "sys/reg/forget/thrid";
	}
	
	@RequestMapping(value="/forget/checkThrid",method={RequestMethod.POST})
	public String checkThrid(String userFlow,String userPasswdNew,String userPasswdNew2, Model model){

		if(!StringUtil.isEquals(userPasswdNew, userPasswdNew2)){
			model.addAttribute("forgetErrorMessage",GlobalConstant.USER_PASSWD_NOT_EQUAL);
			return "sys/reg/forget/thrid";
		}
		SysUser sysUser = new SysUser();
		sysUser.setUserFlow(userFlow);
		String userPwd = PasswordHelper.encryptPassword(userFlow,userPasswdNew);
		sysUser.setUserPasswd(userPwd);
		userBiz.updateUser(sysUser);
		return "sys/reg/forget/success";
	}
	
	
	
}
