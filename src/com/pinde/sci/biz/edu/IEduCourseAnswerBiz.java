package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.mo.EduAnswer;

public interface IEduCourseAnswerBiz {
   
	/**
	 * 保存一条答案
	 * @param eduAnswer
	 * @return
	 */
	public int saveAnswer(EduAnswer eduAnswer);
	/**
	 * 根据问题流水号查询相应答案
	 * @param questionFlowList
	 * @return
	 */
	List<EduAnswer> searchAnswerList(String questionFlow);
	/**
	 * 查询回复
	 * @param answerFlow
	 * @return
	 */
	EduAnswerExt searchAnswerExt(String answerFlow);
}
