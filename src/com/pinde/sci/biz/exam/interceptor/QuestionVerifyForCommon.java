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
		//˳���
		int order = 0;
		for(Entry<Integer , String> entry:entrySet){
			//У��ÿһ��ĸ�ʽд��������5�� ��5�зֱ���
		    //��������:
		    //��Ŀ����:
		    //��Ŀ��:
		    //��ȷ��:
		    //�����Ѷ�:
		    //����������˳��
			order++;
			verifyInfo.setQuestionTypeId(questionTypeId);
			verifyInfo.setQuestionNo(questionNo);
			verifyInfo.setLineNum(entry.getKey());
			if(!isSize){
				verifyInfo.setMsg("���������������5��");
			    return 	verifyInfo;
			}
			if(order==1){
				if(!entry.getValue().startsWith("��������:")){
					verifyInfo.setMsg("�������ݵĿ�ͷ������'��������:'��ͷ");
					return verifyInfo;
				}
			}
			if(order==2){
				if(!entry.getValue().startsWith("��Ŀ����:")){
					verifyInfo.setMsg("�������ݵĿ�ͷ������'��Ŀ����:'��ͷ");
					return verifyInfo;
				}
			}
			if(order==3){
				if(!entry.getValue().startsWith("��Ŀ��:")){
					verifyInfo.setMsg("�������ݵĿ�ͷ������'��Ŀ��:'��ͷ");
					return verifyInfo;
				}
			}
			if(order==4){
				if(!entry.getValue().startsWith("��ȷ��:")){
					verifyInfo.setMsg("�������ݵĿ�ͷ������'��ȷ��:'��ͷ");
					return verifyInfo;
				}
			}
			if(order==5){
				if(!entry.getValue().startsWith("�����Ѷ�:")){
					verifyInfo.setMsg("�������ݵĿ�ͷ������'�����Ѷ�:'��ͷ");
					return verifyInfo;
				}
			}
		}
		return null;
	}

}
