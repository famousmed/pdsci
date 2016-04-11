package com.pinde.sci.dao.edu;

import java.math.BigDecimal;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.form.edu.ChapterForm;
import com.pinde.sci.model.edu.EduCourseChapterExt;

public interface EduCourseChapterExtMapper {
	EduCourseChapterExt selectOneWithExt(String chapterFlow);
	/**
	 * ÅúÁ¿É¾³ý
	 * @param form
	 * @return
	 */
	int updateByChapterFlowList(ChapterForm form);
	
	short selectMAXChapterOrder();
	
	BigDecimal sumAllChapterCredit(String courseFlow);
}
