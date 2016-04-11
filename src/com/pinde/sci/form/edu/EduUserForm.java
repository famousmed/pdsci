package com.pinde.sci.form.edu;

import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SysUser;

public class EduUserForm {
	
	private EduUserExtInfoForm eduUserExtInfoForm;
	private SysUser sysUser;
	private EduUser eduUser;
	private ResDoctor resDoctor;
	public EduUserExtInfoForm getEduUserExtInfoForm() {
		return eduUserExtInfoForm;
	}
	public void setEduUserExtInfoForm(EduUserExtInfoForm eduUserExtInfoForm) {
		this.eduUserExtInfoForm = eduUserExtInfoForm;
	}
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
	public ResDoctor getResDoctor() {
		return resDoctor;
	}
	public void setResDoctor(ResDoctor resDoctor) {
		this.resDoctor = resDoctor;
	}
	
}
