package com.pinde.sci.biz.xjgl;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.SubmitApplyForm;
import com.pinde.sci.form.edu.UserChangeApplyForm;
import com.pinde.sci.model.edu.EduStudentChangeExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.EduUserChangeApply;

public interface IChangeApplyBiz {
	/**
	 * ����ѧ����Ϣ
	 * @return
	 */
	public EduUser readEduUser(String userFlow);
	/**
	 * ����ÿ��ѧ����ѡ�Ŀγ�
	 */
	public List<EduCourse> searchStuCourseList(Map<String,Object> paramMap);
	/**
	 * ����������Ϣ
	 * @param eduUserChangeApply
	 * @return
	 */
	public int saveAndUpdateChangeApplyInfo(SubmitApplyForm form,UserChangeApplyForm applyForm,String userFlow,String recordFlow);
	/**
	 * ����eduUserChangeApply��Ϣ
	 * @param userFlow
	 * @return
	 */
	public List<EduUserChangeApply> searchEduUserChangeApply(EduUserChangeApply user);
	/**
	 * ���»�����Ϣ
	 * @param user
	 * @return
	 */
	public int updataApplyInfo(EduUserChangeApply user,SubmitApplyForm form);
	/**
	 * ����changeInfo��չ
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentChangeExt> searchStdentChangeExtsList(Map<String, Object> paramMap);
	/**
	 * ��ѯһ��EduUserChangeApply
	 * @param recordFlow
	 * @return
	 */
	public EduUserChangeApply readEduUserChangeApply(String recordFlow);
}
