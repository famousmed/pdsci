package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseNoticeExt extends EduCourseNotice {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4889004776548502770L;

	private EduUser eduUser;
	
	private SysUser sysUser;

	public EduUser getEduUser() {
		return eduUser;
	}

	public void setEduUser(EduUser eduUser) {
		this.eduUser = eduUser;
	}

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
	
}
