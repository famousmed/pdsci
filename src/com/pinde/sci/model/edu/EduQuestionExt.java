package com.pinde.sci.model.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

public class EduQuestionExt extends EduQuestion {

	private static final long serialVersionUID = 1887829563180670370L;
	/**
	 * ���б�
	 */
	private List<EduAnswerExt> answerList;
	/**
	 * ������
	 */
	private SysUser user;
	/**
	 * �γ�
	 */
	private EduCourse course;
	/**
	 * �½�
	 */
	private EduCourseChapterExt chapterExt;
	private EduUser eduUser;
	
	public SysUser getUser() {
		return user;
	}
	public void setUser(SysUser user) {
		this.user = user;
	}
	public List<EduAnswerExt> getAnswerList() {
		return answerList;
	}
	public void setAnswerList(List<EduAnswerExt> answerList) {
		this.answerList = answerList;
	}
	public EduCourse getCourse() {
		return course;
	}
	public void setCourse(EduCourse course) {
		this.course = course;
	}
	public EduCourseChapterExt getChapterExt() {
		return chapterExt;
	}
	public void setChapterExt(EduCourseChapterExt chapterExt) {
		this.chapterExt = chapterExt;
	}
	public EduUser getEduUser() {
		return eduUser;
	}
	public void setEduUser(EduUser eduUser) {
		this.eduUser = eduUser;
	}
	
}
