package com.pinde.sci.dao.njmuedu;

import java.util.List;

import com.pinde.sci.model.njmuedu.EduCourseNoticeExt;

public interface NjmuEduCourseNoticeExtMapper {
	List<EduCourseNoticeExt> searchCourseNoticeListByCourseFlow(String courseFlow);
}
