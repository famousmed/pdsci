package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseChapterExt extends EduCourseChapter {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1818441257878634196L;
	private SysUser teacher;
	private EduCourse course;
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

}
