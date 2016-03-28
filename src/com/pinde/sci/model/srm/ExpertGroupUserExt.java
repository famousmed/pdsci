package com.pinde.sci.model.srm;

import java.io.Serializable;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SysUser;

public class ExpertGroupUserExt extends SrmExpertGroupUser implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7869154765388052489L;

	private SysUser user;
	
	private SrmExpert expert;

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
	
	
	
}
