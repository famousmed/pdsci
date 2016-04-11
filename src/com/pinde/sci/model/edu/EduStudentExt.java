package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduStudentCourse;

public class EduStudentExt extends EduStudentCourse{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1467422084852215654L;

	private String courseName;
	
	private String courseImg;

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseImg() {
		return courseImg;
	}

	public void setCourseImg(String courseImg) {
		this.courseImg = courseImg;
	}
	
	
}
