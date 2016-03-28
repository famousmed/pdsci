package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.OneCourseCreditForm;
import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.model.edu.EduStudentCourseExt;

/**
 * @author tiger
 *
 */
public interface EduStudentCourseExtMapper {

	/**
	 * ��ѯĳѧ��ѡ������пγ̼���ѧϰ���
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentCourseExt> searchEduStudentCourseExtByUserFlow(Map<String,Object> paramMap);
	/**
	 * ��ѯĳѧ��ѡ������пγ�(resedu)
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentCourseExt> searchEduStudentCourseExt(Map<String,Object> paramMap);
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
	/**
	 * ��ѯĳѧ����õ�ѧ�����(resedu)
	 * @param paramMap
	 * @return
	 */
	public int sumUserCredit(Map<String,Object> paramMap);
	
	List<StudentCourseNumForm> selectStudentCourse(Map<String, Object> paramMap);
	
	/**
	 * ��ѯ��ѡ�γ̼�¼
	 * @param paramMap
	 * @return
	 */
	List<StudentCourseNumForm> searchStudentCourseChooseCount(Map<String, Object> paramMap);
	
	
	/**
	 * ��ȡ����ȸ�ѧԱ������ѡ��γ�
	 * @param studentCourseExt
	 * @return
	 */
	List<EduStudentCourseExt> searchStudentCourseExtList(EduStudentCourseExt studentCourseExt);
	
}
