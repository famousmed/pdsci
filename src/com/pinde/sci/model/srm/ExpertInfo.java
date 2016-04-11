package com.pinde.sci.model.srm;

import java.io.Serializable;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

public class ExpertInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 732673589555401466L;

	private SysUser user;
	
	private SrmExpert expert;
	
	private SrmExpertGroupUser expertGroupUser;
	
	private SysOrg sysOrg;
	
	public SrmExpertGroupUser getExpertGroupUser() {
		return expertGroupUser;
	}

	public void setExpertGroupUser(SrmExpertGroupUser expertGroupUser) {
		this.expertGroupUser = expertGroupUser;
	}

	public SysUser getUser() {
		return user;
	}

	public void setUser(SysUser user) {
		this.user = user;
	}

	public SrmExpert getExpert() {
		return expert;
	}

	public void setExpert(SrmExpert expert) {
		this.expert = expert;
	}

	public SysOrg getSysOrg() {
		return sysOrg;
	}

	public void setSysOrg(SysOrg sysOrg) {
		this.sysOrg = sysOrg;
	}
	
	
	
}
