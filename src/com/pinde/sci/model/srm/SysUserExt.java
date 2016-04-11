package com.pinde.sci.model.srm;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysUser;

public class SysUserExt extends SysUser{

	/**
	 * 
	 */
	private static final long serialVersionUID = 537704965409046838L;
	private SrmExpert expert;

	public SrmExpert getExpert() {
		return expert;
	}

	public void setExpert(SrmExpert expert) {
		this.expert = expert;
	}
	
	
	
}
