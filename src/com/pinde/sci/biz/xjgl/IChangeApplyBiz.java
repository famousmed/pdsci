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
	 * 查找学生信息
	 * @return
	 */
	public EduUser readEduUser(String userFlow);
	/**
	 * 查找每个学生所选的课程
	 */
	public List<EduCourse> searchStuCourseList(Map<String,Object> paramMap);
	/**
	 * 保存申请信息
	 * @param eduUserChangeApply
	 * @return
	 */
	public int saveAndUpdateChangeApplyInfo(SubmitApplyForm form,UserChangeApplyForm applyForm,String userFlow,String recordFlow);
	/**
	 * 查找eduUserChangeApply信息
	 * @param userFlow
	 * @return
	 */
	public List<EduUserChangeApply> searchEduUserChangeApply(EduUserChangeApply user);
	/**
	 * 更新基本信息
	 * @param user
	 * @return
	 */
	public int updataApplyInfo(EduUserChangeApply user,SubmitApplyForm form);
	/**
	 * 查找changeInfo扩展
	 * @param paramMap
	 * @return
	 */
	public List<EduStudentChangeExt> searchStdentChangeExtsList(Map<String, Object> paramMap);
	/**
	 * 查询一个EduUserChangeApply
	 * @param recordFlow
	 * @return
	 */
	public EduUserChangeApply readEduUserChangeApply(String recordFlow);
}
