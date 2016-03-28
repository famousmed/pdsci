package com.pinde.sci.util;

import java.util.ArrayList;
import java.util.List;

import com.pinde.core.util.StringUtil;

public class ExamUtil {

	/**
	 * 解析试题答案
	 * eg:xxx@@ttt@@ooo --> A.xxx B.ttt C.ooo
	 * @param questionAnswer
	 * @return
	 */
	public static List<String> parseQuestionAnswer(String questionAnswer){
		List<String> answerList = new ArrayList<String>();
		if(StringUtil.isNotBlank(questionAnswer)){
			String[] answers = questionAnswer.split("@@");
			String[] selections = getSelection(answers.length);
			for(int i=0;i<answers.length;i++){
				answerList.add(selections[i]+"."+answers[i]);
			}
		}
		return answerList;
	}
	
	/**
	 * 更具给定长度,计算选项从A开始
	 * @param length
	 * @return
	 */
	public static String[] getSelection(int length){
		char a = 'A';
		String[] result = new String[length];
		for(int i=0;i<length;i++){
			result[i] = new Character((char)(a+i)).toString();
		}
		return result;
	}
}
