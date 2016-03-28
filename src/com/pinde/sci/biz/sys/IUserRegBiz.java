package com.pinde.sci.biz.sys;

import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.UserRegForm;

public interface IUserRegBiz {
	
	/**
	 * 激活用户
	 * @param sysUser
	 */
	public void activatSysUser(SysUser sysUser);

	public void regUser(SysUser sysUser, String roleFlow);
	
	/**
	 * 注册用户
	 * @param form
	 */
	public void regUser(UserRegForm form , SysRole role);
	
	/**
	 * srm 注册校验
	 * @param form
	 * @param role
	 */
	public String srmRegValidate(UserRegForm form , SysRole role);

}
