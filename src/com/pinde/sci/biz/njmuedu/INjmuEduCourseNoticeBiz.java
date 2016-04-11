package com.pinde.sci.biz.njmuedu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseNotice;
import com.pinde.sci.model.njmuedu.EduCourseNoticeExt;

public interface INjmuEduCourseNoticeBiz {
	
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

	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow);
}
