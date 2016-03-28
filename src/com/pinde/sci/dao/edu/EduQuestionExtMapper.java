package com.pinde.sci.dao.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.EduQuestionForm;
import com.pinde.sci.form.edu.QuestionCountForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.SysOrg;

public interface EduQuestionExtMapper {
	
	/**
	 * 查询问题（包含所有回答）
	 * @param question
	 * @return
	 */
	List<EduQuestionExt> selectListWithAnswers(EduQuestion question);
	/**
	 * 查询提出问题的
	 * @return
	 */
	List<SysOrgExt> selectOrgOfQuestion(Map<String,Object> paramMap);
	/**
	 * 按条件检索统计问题数量并且按学校专业分组
	 * @param paramMap
	 * @return
	 */
	int selectQuestionCount(Map<String,Object> paramMap);
	/**
	 * 查询扩展列表
	 * @param form
	 * @return
	 */
	List<EduQuestionExt> selectExtList(EduQuestionForm form);
	/**
	 * 查询一个问题的所有回复
	 * @param questionFlow
	 * @return
	 */
	List<EduAnswerExt> selectAnswers(String questionFlow);
	/**
	 * 查询回复
	 * @param answerFlow
	 * @return
	 */
	EduAnswerExt selectAnswerExt(String answerFlow);
	/**
	 * 按主键查询扩展
	 * @param questionFlow
	 * @return
	 */
	EduQuestionExt selectOneWithExt(String questionFlow);
}
