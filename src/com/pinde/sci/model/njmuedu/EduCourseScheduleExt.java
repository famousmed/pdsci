package com.pinde.sci.model.njmuedu;

import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseScheduleExt extends EduCourseSchedule{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 580443044828338274L;
	private SysUser sysUser;
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

}
