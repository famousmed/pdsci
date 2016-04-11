package com.pinde.sci.biz.exam.interceptor;

import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import com.pinde.sci.model.exam.QuestionFileVerifyInfo;

public class QuestionVerifyForCommon extends QuestionVerifyInterceptorAdapter{

	@Override
	public QuestionFileVerifyInfo handle(Object questionInfo,
			Integer questionNo, String questionTypeId , Object handler) {
		QuestionFileVerifyInfo verifyInfo = new QuestionFileVerifyInfo();
		@SuppressWarnings("unchecked")
		Map<Integer , String> questionData = (Map<Integer , String>)questionInfo;
		questionData.size();
		boolean isSize = questionData.size()==5 ? true : false;
		Set<Entry<Integer , String>> entrySet = questionData.entrySet();
		//顺序号
		int order = 0;
		for(Entry<Integer , String> entry:entrySet){
			//校验每一题的格式写法必须是5行 这5行分别是
		    //主题内容:
		    //题目内容:
		    //题目答案:
		    //正确答案:
		    //试题难度:
		    //并且他们是顺序
			order++;
			verifyInfo.setQuestionTypeId(questionTypeId);
			verifyInfo.setQuestionNo(questionNo);
			verifyInfo.setLineNum(entry.getKey());
			if(!isSize){
				verifyInfo.setMsg("该题的总行数不是5行");
			    return 	verifyInfo;
			}
			if(order==1){
				if(!entry.getValue().startsWith("主题内容:")){
					verifyInfo.setMsg("该行内容的开头不是以'主题内容:'开头");
					return verifyInfo;
				}
			}
			if(order==2){
				if(!entry.getValue().startsWith("题目内容:")){
					verifyInfo.setMsg("该行内容的开头不是以'题目内容:'开头");
					return verifyInfo;
				}
			}
			if(order==3){
				if(!entry.getValue().startsWith("题目答案:")){
					verifyInfo.setMsg("该行内容的开头不是以'题目答案:'开头");
					return verifyInfo;
				}
			}
			if(order==4){
				if(!entry.getValue().startsWith("正确答案:")){
					verifyInfo.setMsg("该行内容的开头不是以'正确答案:'开头");
					return verifyInfo;
				}
			}
			if(order==5){
				if(!entry.getValue().startsWith("试题难度:")){
					verifyInfo.setMsg("该行内容的开头不是以'试题难度:'开头");
					return verifyInfo;
				}
			}
		}
		return null;
	}

}
