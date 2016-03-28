package com.pinde.sci.dao.njmuedu;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.njmuedu.EduQuestionForm;
import com.pinde.sci.form.njmuedu.SysOrgExt;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.njmuedu.EduAnswerExt;
import com.pinde.sci.model.njmuedu.EduQuestionExt;

public interface NjmuEduQuestionExtMapper {
	
	/**
	 * ��ѯ���⣨�������лش�
	 * @param question
	 * @return
	 */
	List<EduQuestionExt> selectListWithAnswers(EduQuestion question);
	/**
	 * ��ѯ��������
	 * @return
	 */
	List<SysOrgExt> selectOrgOfQuestion(Map<String,Object> paramMap);
	/**
	 * ����������ͳ�������������Ұ�ѧУרҵ����
	 * @param paramMap
	 * @return
	 */
	int selectQuestionCount(Map<String,Object> paramMap);
	/**
	 * ��ѯ��չ�б�
	 * @param form
	 * @return
	 */
	List<EduQuestionExt> selectExtList(EduQuestionForm form);
	/**
	 * ��ѯһ����������лظ�
	 * @param questionFlow
	 * @return
	 */
	List<EduAnswerExt> selectAnswers(String questionFlow);
	/**
	 * ��ѯ�ظ�
	 * @param answerFlow
	 * @return
	 */
	EduAnswerExt selectAnswerExt(String answerFlow);
	/**
	 * ��������ѯ��չ
	 * @param questionFlow
	 * @return
	 */
	EduQuestionExt selectOneWithExt(String questionFlow);
}
