package com.pinde.sci.form.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.SysUser;

public class ChapterForm {
	
	private String chapterFlow;
	private List<String> chapterFlowList;
	private String parentChapterFlow;
	
	private String orgFlow;//学校
	private EduCourseChapter chapter;
	private List<SysUser> userList;//教师List<SysUser>
	
	public String getChapterFlow() {
		return chapterFlow;
	}
	public void setChapterFlow(String chapterFlow) {
		this.chapterFlow = chapterFlow;
	}
	
	public List<String> getChapterFlowList() {
		return chapterFlowList;
	}
	public void setChapterFlowList(List<String> chapterFlowList) {
		this.chapterFlowList = chapterFlowList;
	}
	
	public String getParentChapterFlow() {
		return parentChapterFlow;
	}
	public void setParentChapterFlow(String parentChapterFlow) {
		this.parentChapterFlow = parentChapterFlow;
	}
	public String getOrgFlow() {
		return orgFlow;
	}
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}
	public EduCourseChapter getChapter() {
		return chapter;
	}
	public void setChapter(EduCourseChapter chapter) {
		this.chapter = chapter;
	}
	public List<SysUser> getUserList() {
		return userList;
	}
	public void setUserList(List<SysUser> userList) {
		this.userList = userList;
	}
	
}
