package com.pinde.sci.form.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;

public class MajorCourseForm {

    private String MajorId;
	
	private String MajorName;
	
	private List<EduCourseMajorExt> courseMajorExtList;
	

	public String getMajorId() {
		return MajorId;
	}

	public void setMajorId(String majorId) {
		MajorId = majorId;
	}

	public String getMajorName() {
		return MajorName;
	}

	public void setMajorName(String majorName) {
		MajorName = majorName;
	}

	public List<EduCourseMajorExt> getCourseMajorExtList() {
		return courseMajorExtList;
	}

	public void setCourseMajorExtList(List<EduCourseMajorExt> courseMajorExtList) {
		this.courseMajorExtList = courseMajorExtList;
	}

	
	
}
