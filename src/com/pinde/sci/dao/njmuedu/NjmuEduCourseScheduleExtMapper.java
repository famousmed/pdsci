package com.pinde.sci.dao.njmuedu;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.pinde.sci.form.njmuedu.CourseInfoForm;
import com.pinde.sci.form.njmuedu.SysOrgExt;
import com.pinde.sci.model.mo.EduCourseSchedule;
import com.pinde.sci.model.njmuedu.EduCourseScheduleExt;

public interface NjmuEduCourseScheduleExtMapper {
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
}
