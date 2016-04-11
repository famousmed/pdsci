package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduCourseNoticeExt;
import com.pinde.sci.model.mo.EduCourseNotice;

public interface IEduCourseNoticeBiz {
	
	/**
	 * ��ѯ
	 * @param courseNotice
	 * @return
	 */
	List<EduCourseNotice> searchCourseNoticeList(EduCourseNotice courseNotice);
	
	/**
	 * ����֪ͨ
	 * @param courseNotice
	 * @return
	 */
	int save(EduCourseNotice courseNotice);
	
	/**
	 * ��ȡһ��֪ͨ
	 * @param noticeFlow
	 * @return
	 */
	EduCourseNotice readCourseNotice(String noticeFlow);
    /**
     * ��ѯ�γ�֪ͨ
     * @param courseFlow
     * @return
     */
	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow);
	/**
	 * ��ѯ�γ�֪ͨres
	 * @param courseFlow
	 * @return
	 */
	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlowRes(String courseFlow);
}
