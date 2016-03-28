package com.pinde.sci.model.jsres;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

public class JsResDoctorExt extends ResDoctor{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2779906176472381468L;
	private SysUser sysUser;
	
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
}
