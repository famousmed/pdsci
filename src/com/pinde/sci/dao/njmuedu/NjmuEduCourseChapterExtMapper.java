package com.pinde.sci.dao.njmuedu;

import com.pinde.sci.form.njmuedu.ChapterForm;
import com.pinde.sci.model.njmuedu.EduCourseChapterExt;

public interface NjmuEduCourseChapterExtMapper {
	EduCourseChapterExt selectOneWithExt(String chapterFlow);
	/**
	 * ����ɾ��
	 * @param form
	 * @return
	 */
	int updateByChapterFlowList(ChapterForm form);
	
	short selectMAXChapterOrder();
	
}
