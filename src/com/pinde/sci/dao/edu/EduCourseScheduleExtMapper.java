package com.pinde.sci.dao.edu;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.CourseInfoForm;
import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduCourseScheduleExt;
import com.pinde.sci.model.mo.EduCourseSchedule;

public interface EduCourseScheduleExtMapper {
	/**
	 * ��ѯ�γ�
	 * @param courseFlow �γ���ˮ��
	 * @return
	 */
	BigDecimal selectAvgScore(EduCourseSchedule schedule);
	/**
	 * ��ѯĳ��ʦ�����½ڸ�����Ϣ
	 * @param paramMap
	 * @return
	 */
	CourseInfoForm countInfoOfTeacher(Map<String,Object> paramMap);
	
	List<EduCourseScheduleExt> searchChapterScheduleMap(Map<String, Object> paramMap);
	
	/**
	 * ��ѯ����ʦ���ڿγ̵�����ѧУ
	 * @param paramMap
	 * @return
	 */
	List<SysOrgExt> selectOrgOfSchedule(Map<String, Object> paramMap);
	
	List<EduCourseScheduleExt> searchCourseSchedule(Map<String, Object> paramMap);
	
	/**
	 * ��ѯ
	 * @param paramMap
	 * @return
	 */
	List<EduCourseSchedule> searchEduCourseScheduleList(Map<String, Object> paramMap);
}
