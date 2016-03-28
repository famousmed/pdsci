package com.pinde.sci.model.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseChapter;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class EduCourseExt extends EduCourse {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6567641627171207125L;
	/**
	 * 所有章节
	 */
	private List<EduCourseChapter> chapterList;
	/**
	 * 选课人数
	 */
	private String chooseCount;
	/**
	 * 课程平均得分
	 */
	private String avgScore;
	
	private String questionAmount;
	
	private List<EduStudentCourse> eduStudentCourseList;
	
	private List<EduCourseMajor> eduCourseMajorsList;
	
	public List<EduCourseMajor> getEduCourseMajorsList() {
		return eduCourseMajorsList;
	}
	public void setEduCourseMajorsList(List<EduCourseMajor> eduCourseMajorsList) {
		this.eduCourseMajorsList = eduCourseMajorsList;
	}
	public List<EduStudentCourse> getEduStudentCourseList() {
		return eduStudentCourseList;
	}
	public void setEduStudentCourseList(List<EduStudentCourse> eduStudentCourseList) {
		this.eduStudentCourseList = eduStudentCourseList;
	}
	public List<EduCourseChapter> getChapterList() {
		return chapterList;
	}
	public void setChapterList(List<EduCourseChapter> chapterList) {
		this.chapterList = chapterList;
	}
	public String getChooseCount() {
		return chooseCount;
	}
	public void setChooseCount(String chooseCount) {
		this.chooseCount = chooseCount;
	}
	
	public String getAvgScore() {
		return avgScore;
	}
	public void setAvgScore(String avgScore) {
		this.avgScore = avgScore;
	}
	public String getQuestionAmount() {
		return questionAmount;
	}
	public void setQuestionAmount(String questionAmount) {
		this.questionAmount = questionAmount;
	}	
}
