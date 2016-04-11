package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.njmuedu.OneCourseCreditForm;
import com.pinde.sci.model.njmuedu.EduStudentCourseExt;

public interface NjmuEduStudentCourseExtMapper {

	/**
	 * ��ѯĳѧ��ѡ������пγ̼���ѧϰ���
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentCourseExt> searchEduStudentCourseExtByUserFlow(Map<String,Object> paramMap);
	/**
	 * ��������ͳ�ƿγ������Ϣ
	 * @param paramMap
	 * @return
	 */
	public int countCourseInfoByCondition(Map<String,Object> paramMap);
	
	/**
     * ��ѯѡ����ĳ�ڿε�ѧ����ѧ��
     * @param paramMap
     * @return
     */
	public List<OneCourseCreditForm> searchCourseCreditForm(Map<String,Object> paramMap);
}
