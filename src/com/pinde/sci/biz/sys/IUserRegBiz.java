package com.pinde.sci.biz.sys;

import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.UserRegForm;

public interface IUserRegBiz {
	
	/**
	 * �����û�
	 * @param sysUser
	 */
	public void activatSysUser(SysUser sysUser);

	public void regUser(SysUser sysUser, String roleFlow);
	
	/**
	 * ע���û�
	 * @param form
	 */
	public void regUser(UserRegForm form , SysRole role);
	
	/**
	 * srm ע��У��
	 * @param form
	 * @param role
	 */
	public String srmRegValidate(UserRegForm form , SysRole role);

}
