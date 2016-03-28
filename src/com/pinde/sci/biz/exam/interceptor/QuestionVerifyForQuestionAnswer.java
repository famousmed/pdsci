package com.pinde.sci.biz.exam.interceptor;

import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.exam.IQuestionManageBiz;
import com.pinde.sci.biz.exam.impl.QuestionManageBizImpl;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;

public class QuestionVerifyForQuestionAnswer extends QuestionVerifyInterceptorAdapter{

	private IQuestionManageBiz questionBiz;
	
	public QuestionVerifyForQuestionAnswer(){
		this.questionBiz = new QuestionManageBizImpl();
	}
	
	@Override
	public QuestionFileVerifyInfo handle(Object questionInfo,
			Integer questionNo, String questionTypeId , Object handler) {
		QuestionFileVerifyInfo verifyInfo = new QuestionFileVerifyInfo();
		@SuppressWarnings("unchecked")
		Map<Integer , String> questionData = (Map<Integer , String>)questionInfo;
		Set<Entry<Integer , String>> entrySet = questionData.entrySet();
		for(Entry<Integer , String> entry:entrySet){
			verifyInfo.setQuestionTypeId(questionTypeId);
			verifyInfo.setQuestionNo(questionNo);
			verifyInfo.setLineNum(entry.getKey());
			if(entry.getValue().startsWith("题目答案:")){
				String content = entry.getValue(); 
				String questionAnswer = content.substring(content.indexOf(":")+1);
				if(StringUtil.isBlank(questionAnswer)){
					verifyInfo.setMsg("该题型必须要有题目答案");
					return verifyInfo;
				}else{
					if(verifyQuestionOption(questionAnswer)){
						verifyInfo.setMsg("题目选型有误(包含大写字母加点)");
						return verifyInfo;
					}
				}
				
			}
		}
		return null;
	}
	
	private boolean verifyQuestionOption(String optionStr){
		String replaceAfterOptionStr = questionBiz.replaceQuestionStr(optionStr);
	    Pattern p2 = Pattern.compile("@@\\s*@@");
        Matcher m2 = p2.matcher(replaceAfterOptionStr);
        return m2.find();
	}

}
