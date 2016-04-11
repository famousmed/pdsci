package com.pinde.sci.biz.njmuedu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.njmuedu.EduCourseNoticeExt;

public interface INjmuEduCourseNoticeBiz {
	
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

	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow);
}
