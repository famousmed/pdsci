package com.pinde.sci.model.njmuedu;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseChapterExt extends EduCourseChapter {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2271188462554812566L;
	private SysUser teacher;
	private EduCourse course;
	private EduUser eduUser;
	public SysUser getTeacher() {
		return teacher;
	}
	public void setTeacher(SysUser teacher) {
		this.teacher = teacher;
	}
	public EduCourse getCourse() {
		return course;
	}
	public void setCourse(EduCourse course) {
		this.course = course;
	}
	public EduUser getEduUser() {
		return eduUser;
	}
	public void setEduUser(EduUser eduUser) {
		this.eduUser = eduUser;
	}
     
}
