package com.pinde.sci.model.njmuedu;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;

public class EduStudentCourseExt extends EduStudentCourse{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5907200765182867013L;
	private EduCourse course;

	public EduCourse getCourse() {
		return course;
	}

	public void setCourse(EduCourse course) {
		this.course = course;
	}
	  
}
