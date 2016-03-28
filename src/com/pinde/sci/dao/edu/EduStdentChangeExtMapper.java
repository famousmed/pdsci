package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edu.EduStudentChangeExt;

public interface EduStdentChangeExtMapper {
	/**
	 * 查询学生异动扩展信息
	 * @param paramMap
	 * @return
	 */
	List<EduStudentChangeExt> searchStdentChangeExtsList(Map<String, Object> paramMap);
}
