package com.pinde.sci.biz.njmuedu;

import java.util.List;

import com.pinde.sci.model.mo.EduAnswer;
import com.pinde.sci.model.njmuedu.EduAnswerExt;

public interface INjmuEduCourseAnswerBiz {
   
	/**
	 * ����һ����
	 * @param eduAnswer
	 * @return
	 */
	public int saveAnswer(EduAnswer eduAnswer);
	/**
	 * ����������ˮ�Ų�ѯ��Ӧ��
	 * @param questionFlowList
	 * @return
	 */
	List<EduAnswer> searchAnswerList(String questionFlow);
	/**
	 * ��ѯ�ظ�
	 * @param answerFlow
	 * @return
	 */
	EduAnswerExt searchAnswerExt(String answerFlow);
}
