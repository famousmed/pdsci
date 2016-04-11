package com.pinde.sci.form.edu;

import java.util.List;

public class EduCourseSearchConditionForm {
	
    private String upLoadTimeStart;
    
    private String upLoadTimeEnd;
    
    private List<String> courseStatusIdList;

	public String getUpLoadTimeStart() {
		return upLoadTimeStart;
	}

	public void setUpLoadTimeStart(String upLoadTimeStart) {
		this.upLoadTimeStart = upLoadTimeStart;
	}

	public String getUpLoadTimeEnd() {
		return upLoadTimeEnd;
	}

	public void setUpLoadTimeEnd(String upLoadTimeEnd) {
		this.upLoadTimeEnd = upLoadTimeEnd;
	}

	public List<String> getCourseStatusIdList() {
		return courseStatusIdList;
	}

	public void setCourseStatusIdList(List<String> courseStatusIdList) {
		this.courseStatusIdList = courseStatusIdList;
	}
    
    
}
