package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduCourseNoticeExt;
import com.pinde.sci.model.mo.EduCourseNotice;

public interface IEduCourseNoticeBiz {
	
	/**
	 * 查询
	 * @param courseNotice
	 * @return
	 */
	List<EduCourseNotice> searchCourseNoticeList(EduCourseNotice courseNotice);
	
	/**
	 * 保存通知
	 * @param courseNotice
	 * @return
	 */
	int save(EduCourseNotice courseNotice);
	
	/**
	 * 读取一条通知
	 * @param noticeFlow
	 * @return
	 */
	EduCourseNotice readCourseNotice(String noticeFlow);
    /**
     * 查询课程通知
     * @param courseFlow
     * @return
     */
	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow);
	/**
	 * 查询课程通知res
	 * @param courseFlow
	 * @return
	 */
	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlowRes(String courseFlow);
}
