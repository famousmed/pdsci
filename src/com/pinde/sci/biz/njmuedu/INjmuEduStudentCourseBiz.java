package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduStudentCourseBiz {
    
	/**
	 * �޸�ѧ��ѡ�����
	 * @param eduStudentCourse
	 * @return
	 */
	public int edit(EduStudentCourse eduStudentCourse);
	/**
	 * ��ѯѧ��ѡ��Ŀγ̵���ϸ��Ϣ
	 * @param eduUserExtList
	 * @return
	 */
	public Map<String,Map<String,Object>> searchStudentChooseCourses(List<EduUserExt> eduUserExtList);
    /**
     * ��ѯѡ����ĳ�ڿε�ѧ����ѧ��
     * @param paramMap
     * @return
     */
	public Map<String,Object> searchCourseCreditForm(String courseFlow);
	/**
	 * ������޿�
	 * @return
	 */
	public int insertRequireCourse(String userFlow);
}
