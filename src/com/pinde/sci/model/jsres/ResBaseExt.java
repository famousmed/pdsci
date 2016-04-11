package com.pinde.sci.model.jsres;

import com.pinde.sci.model.mo.ResBase;
import com.pinde.sci.model.mo.SysOrg;

public class ResBaseExt extends ResBase{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1099971312871117902L;
	private SysOrg sysOrg;

	public SysOrg getSysOrg() {
		return sysOrg;
	}

	public void setSysOrg(SysOrg sysOrg) {
		this.sysOrg = sysOrg;
	}
}
