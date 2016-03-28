package com.pinde.sci.biz.edu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.edu.EduQuestionForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.SysUser;

public interface IEduCourseQuestionBiz{
    
	/**
	 * ����һ������
	 * @param eduQuestion
	 * @return
	 */
	int saveQuestion(EduQuestion eduQuestion);
	
	public List<EduQuestion> searchEduQuestionsList(EduQuestion eduQuestion,SysUser sysUser);
	/**
	 * ��ѯ���⣨�������лظ���
	 * @return
	 */
	public List<EduQuestionExt> searchQuestionsListWithAnswer(EduQuestion question);
	/**
	 * ͳ����ʦ����������(������)
	 * @param eduUserExtList
	 * @return
	 */
    public Map<String,Map<String,Integer>> countQuestionMap(List<EduUserExt> eduUserExtList);
    /**
     * ����������ˮ�Ų�ѯһ��������Ϣ
     * @param questionFlow
     * @return
     */
    public EduQuestion readEduQuestion(String questionFlow);
    /**
     * �γ̸ſ�-����ͳ�Ʊ�
     * @param paramMap
     * @return
     */
    public Map<String,Map<String, Map<String, Integer>>> questionCountMap(List<SysOrgExt> orgList,Map<String,Object> paramMap);
    /**
     * ��ѯĳ�γ���������ѧУ
     * @param paramMap
     * @return
     */
    public List<SysOrgExt> searchOrgOfQuestion(Map<String,Object> paramMap);
    /**
     * ��ѯ��չ�б�
     * @param form
     * @return
     */
    public List<EduQuestionExt> searchExtList(EduQuestionForm form);
    /**
     * ��ѯһ����������лظ�
     * @param questionFlow ������ˮ��
     * @return
     */
    List<EduAnswerExt> searchAnswers(String questionFlow);
    /**
     * ��ѯ����
     * @param questionFlow
     * @return
     */
    EduQuestionExt searchOneWithExt(String questionFlow);
}
