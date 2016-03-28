package com.pinde.sci.biz.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.njmuedu.EduQuestionForm;
import com.pinde.sci.form.njmuedu.SysOrgExt;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduAnswerExt;
import com.pinde.sci.model.njmuedu.EduQuestionExt;
import com.pinde.sci.model.njmuedu.EduUserExt;

public interface INjmuEduCourseQuestionBiz{
    
	/**
	 * 保存一个问题
	 * @param eduQuestion
	 * @return
	 */
	int saveQuestion(EduQuestion eduQuestion);
	
	public List<EduQuestion> searchEduQuestionsList(EduQuestion eduQuestion,SysUser sysUser);
	/**
	 * 查询问题（包含所有回复）
	 * @return
	 */
	public List<EduQuestionExt> searchQuestionsListWithAnswer(EduQuestion question);
	/**
	 * 统计老师的问题数量(分类型)
	 * @param eduUserExtList
	 * @return
	 */
    public Map<String,Map<String,Integer>> countQuestionMap(List<EduUserExt> eduUserExtList);
    /**
     * 根据问题流水号查询一个问题信息
     * @param questionFlow
     * @return
     */
    public EduQuestion readEduQuestion(String questionFlow);
    /**
     * 课程概况-问题统计表
     * @param paramMap
     * @return
     */
    public Map<String,Map<String, Map<String, Integer>>> questionCountMap(List<SysOrgExt> orgList,Map<String,Object> paramMap);
    /**
     * 查询某课程提出问题的学校
     * @param paramMap
     * @return
     */
    public List<SysOrgExt> searchOrgOfQuestion(Map<String,Object> paramMap);
    /**
     * 查询扩展列表
     * @param form
     * @return
     */
    public List<EduQuestionExt> searchExtList(EduQuestionForm form);
    /**
     * 查询一个问题的所有回复
     * @param questionFlow 问题流水号
     * @return
     */
    List<EduAnswerExt> searchAnswers(String questionFlow);
    /**
     * 查询问题
     * @param questionFlow
     * @return
     */
    EduQuestionExt searchOneWithExt(String questionFlow);
}
