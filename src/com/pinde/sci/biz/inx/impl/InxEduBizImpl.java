package com.pinde.sci.biz.inx.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.core.util.VelocityUtil;
import com.pinde.sci.biz.edu.IEduUserBiz;
import com.pinde.sci.biz.inx.IInxEduBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.security.PasswordHelper;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.biz.sys.IUserRoleBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserRole;
@Service
@Transactional(rollbackFor=Exception.class)
public class InxEduBizImpl implements IInxEduBiz{
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IUserRoleBiz userRoleBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IEduUserBiz eduUserBiz;
	
	@Override
	public int registerUser(SysUser user) {
		user.setUserFlow(PkUtil.getUUID());
		user.setUserPasswd(PasswordHelper.encryptPassword(user.getUserFlow(), user.getUserPasswd()));
		user.setStatusId(UserStatusEnum.Added.getId());
		user.setStatusDesc(UserStatusEnum.Added.getName());
		userBiz.insertUser(user);	
		SysUserRole userRole = new SysUserRole();
		userRole.setRoleFlow(PkUtil.getUUID());
		userRole.setUserFlow(user.getUserFlow());
		userRole.setWsId(GlobalConstant.EDU_WS_ID);
		//开关获取
		userRole.setRoleFlow(InitConfig.getSysCfg("student_role_flow"));
		userRole.setAuthTime(DateUtil.getCurrDateTime());
		return userRoleBiz.saveSysUserRole(userRole);
	}

	@Override
	public void sendEmail(String userEmail,String userFlow) {
		if(StringUtil.isNotBlank(userEmail)){
			String activationCode = userFlow;//激活码
			String content = InitConfig.getSysCfg("edu_reg_email_content");
			Map<String,String> dataMap = new HashMap<String,String>();
			dataMap.put("linkUrl", "<a href='"+InitConfig.getSysCfg("edu_effective_url")+"?activationCode="+activationCode+"'>"+InitConfig.getSysCfg("edu_effective_url")+"?activationCode="+activationCode+"</a>");
			try {
				content = VelocityUtil.evaluate(content, dataMap);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException();
			}
			this.msgBiz.addEmailMsg(userEmail, InitConfig.getSysCfg("edu_reg_email_title"), content);
		}
	}
}
