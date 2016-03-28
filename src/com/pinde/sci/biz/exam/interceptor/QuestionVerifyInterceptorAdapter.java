package com.pinde.sci.biz.exam.interceptor;

import com.pinde.sci.model.exam.QuestionFileVerifyInfo;

public abstract class QuestionVerifyInterceptorAdapter implements QuestionVerifyInterceptor{
	
	@Override
	public boolean preHandle(Object questionInfo, Integer questionNo,
			Object handler) {
		System.out.println("----------------------------预处理---------------------------");
		return true;
	}
	
	@Override
	public QuestionFileVerifyInfo handle(Object questionInfo,
			Integer questionNo, String questionTypeId , Object handler) {
		return null;
	}
	
	@Override
	public void afterHandle(Object questionInfo, Integer questionNo,
			Object handler, Exception ex) {
		System.out.println("----------------------------后处理---------------------------");
		
	}

}
