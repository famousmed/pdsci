package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edu.EduCourseTestPaperExt;

public interface EduCourseTestPaperExtMapper {
    
	/**
	 * ��ѯ�γ��Ծ�
	 * @return
	 */
	public List<EduCourseTestPaperExt> searchCourseTestPaper(Map<String, Object> paramMap);
	
}
