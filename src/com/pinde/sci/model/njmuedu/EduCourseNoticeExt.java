package com.pinde.sci.model.njmuedu;

import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseNoticeExt extends EduCourseNotice {

	

	/**
	 * 
	 */
	private static final long serialVersionUID = 2506438420472143605L;
	
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
