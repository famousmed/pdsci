package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.edu.EduStudentChangeExt;

public interface EduStdentChangeExtMapper {
	/**
	 * ��ѯѧ���춯��չ��Ϣ
	 * @param paramMap
	 * @return
	 */
	List<EduStudentChangeExt> searchStdentChangeExtsList(Map<String, Object> paramMap);
}
