package com.pinde.sci.biz.exam.interceptor;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.model.exam.QuestionFileVerifyInfo;
import com.pinde.sci.model.mo.ExamQuestionDetailWithBLOBs;

public class QuestionVerifyForTK extends QuestionVerifyInterceptorAdapter{

	@Override
	public QuestionFileVerifyInfo handle(Object questionInfo,
			Integer questionNo, String questionTypeId , Object handler) {
		QuestionFileVerifyInfo verifyInfo = new QuestionFileVerifyInfo();
		@SuppressWarnings("unchecked")
		Map<Integer , String> questionData = (Map<Integer , String>)questionInfo;
		verifyInfo.setQuestionTypeId(questionTypeId);
		verifyInfo.setQuestionNo(questionNo);
		Set<Entry<Integer , String>> questionEntrySet = questionData.entrySet();
		Iterator<Entry<Integer , String>> iterator = questionEntrySet.iterator();
		while(iterator.hasNext()){
			Entry<Integer , String> iteratorEntry = iterator.next();
			if(iteratorEntry.getValue().startsWith("题目内容:")){
				 Pattern p = Pattern.compile("_+");
		         Matcher m = p.matcher(iteratorEntry.getValue());
		         while (m.find()) {
		        	 if(m.group().length()!=10){
		        		 verifyInfo.setLineNum(iteratorEntry.getKey());
		        		 verifyInfo.setMsg("填空题必须要是__________(10个'_')");
		 			    return 	verifyInfo;
		        	 }
		         }
			}
			
		}
		
		return null;
	}

}
