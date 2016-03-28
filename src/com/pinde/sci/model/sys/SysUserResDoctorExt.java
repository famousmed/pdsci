package com.pinde.sci.model.sys;

import java.util.List;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SysUser;

public class SysUserResDoctorExt extends SysUser{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2686353456324323455L;
	
	private ResDoctor doctor;
	
	private List<ResDoctorSchProcess> resDoctorSchProcessList;

	public ResDoctor getDoctor() {
		return doctor;
	}

	public void setDoctor(ResDoctor doctor) {
		this.doctor = doctor;
	}

	public List<ResDoctorSchProcess> getResDoctorSchProcessList() {
		return resDoctorSchProcessList;
	}

	public void setResDoctorSchProcessList(
			List<ResDoctorSchProcess> resDoctorSchProcessList) {
		this.resDoctorSchProcessList = resDoctorSchProcessList;
	}

	
	
	
}
