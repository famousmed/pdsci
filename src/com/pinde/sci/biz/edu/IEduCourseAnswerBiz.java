package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.mo.EduAnswer;

public interface IEduCourseAnswerBiz {
   
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
