package com.pinde.sci.model.res;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.SysUser;

public class ResDoctorExt extends ResDoctor {
	private static final long serialVersionUID = -438010526424360596L;
	
	private SysUser sysUser;
	
	private ResDoctorRecruit doctorRecruit;

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	public ResDoctorRecruit getDoctorRecruit() {
		return doctorRecruit;
	}

	public void setDoctorRecruit(ResDoctorRecruit doctorRecruit) {
		this.doctorRecruit = doctorRecruit;
	}
	
	
}
