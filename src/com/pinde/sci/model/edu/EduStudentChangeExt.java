package com.pinde.sci.model.edu;


import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.EduUserChangeApply;
import com.pinde.sci.model.mo.SysUser;

public class EduStudentChangeExt extends EduUserChangeApply {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8244537837304774622L;
	private EduUser eduUser;
	private SysUser sysUser;
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	public EduUser getEduUser() {
		return eduUser;
	}
	public void setEduUser(EduUser eduUser) {
		this.eduUser = eduUser;
	}
}
