package com.pinde.sci.model.res;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.SysUser;

public class ResDoctorRecruitExt extends ResDoctorRecruit {
	
	private static final long serialVersionUID = 1653348979684312753L;
	private SysUser sysUser;
	private ResDoctor doctor;

	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	public ResDoctor getDoctor() {
		return doctor;
	}
	public void setDoctor(ResDoctor doctor) {
		this.doctor = doctor;
	}
}
