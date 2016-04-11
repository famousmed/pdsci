package com.pinde.sci.dao.edu;

import java.util.List;
import com.pinde.sci.model.edu.EduCourseNoticeExt;

public interface EduCourseNoticeExtMapper {
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
