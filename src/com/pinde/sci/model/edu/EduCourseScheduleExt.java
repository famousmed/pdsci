package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseScheduleExt extends EduCourseSchedule{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3328927852442882702L;
	private SysUser sysUser;
	private EduCourseChapter courseChapter;
	
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	public EduCourseChapter getCourseChapter() {
		return courseChapter;
	}
	public void setCourseChapter(EduCourseChapter courseChapter) {
		this.courseChapter = courseChapter;
	}

}
