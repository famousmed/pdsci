package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.EduStudentCourse;

public class EduStudentCourseExt extends EduStudentCourse{

	private static final long serialVersionUID = 400539611091936315L;
	private EduCourse course;
	private EduCourseMajor courseMajor;
	
	
	public EduCourseMajor getCourseMajor() {
		return courseMajor;
	}

	public void setCourseMajor(EduCourseMajor courseMajor) {
		this.courseMajor = courseMajor;
	}

	public EduCourse getCourse() {
		return course;
	}

	public void setCourse(EduCourse course) {
		this.course = course;
	}
	  
}
