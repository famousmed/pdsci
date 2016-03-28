package com.pinde.sci.biz.exam.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.exam.IQuestionManageBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ExamQuestionBookMapper;
import com.pinde.sci.dao.base.ExamQuestionDetailMapper;
import com.pinde.sci.dao.base.ExamQuestionMapper;
import com.pinde.sci.dao.base.ExamQuestionSubjectMapper;
import com.pinde.sci.dao.exam.ExamQuestionExtMapper;
import com.pinde.sci.enums.exam.QuestionTypeEnum;
import com.pinde.sci.model.exam.ExamQuestionExt;
import com.pinde.sci.model.mo.ExamBookImp;
import com.pinde.sci.model.mo.ExamQuestionBook;
import com.pinde.sci.model.mo.ExamQuestionBookExample;
import com.pinde.sci.model.mo.ExamQuestionDetailExample;
import com.pinde.sci.model.mo.ExamQuestionDetailWithBLOBs;
import com.pinde.sci.model.mo.ExamQuestionSubject;
import com.pinde.sci.model.mo.ExamQuestionSubjectExample;
import com.pinde.sci.model.mo.ExamQuestionWithBLOBs;

@Service
@Transactional(rollbackFor = Exception.class)
public class QuestionManageBizImpl implements IQuestionManageBiz{
	
	@Autowired
	private ExamQuestionMapper examQuestionMapper; 
	
	@Autowired
	private ExamQuestionExtMapper examQuestionExtMapper; 
	
	@Autowired
	private ExamQuestionSubjectMapper examQuestionSubjectMapper;
	
	@Autowired
	private ExamQuestionBookMapper examQuestionBookMapper;
	
	@Autowired
	private ExamQuestionDetailMapper examQuestionDetailMapper;

	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectQuestionType(String subjectFlow,String questionTypeId) {
		return examQuestionExtMapper.searchExamQuestionBySubjectQuestionType(subjectFlow,questionTypeId);
	}

	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectSubject(String subjectFlow, String subjectFlow2) {
		return examQuestionExtMapper.searchExamQuestionBySubjectSubject(subjectFlow, subjectFlow2);
	}

	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionBySubjectBook(String subjectFlow, String bookFlow) {
		return examQuestionExtMapper.searchExamQuestionBySubjectBook(subjectFlow, bookFlow);
	}


	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookQuestionType(String bookFlow, String questionTypeId) {
		return examQuestionExtMapper.searchExamQuestionByBookQuestionType(bookFlow, questionTypeId);
	}
	
	@Override
	public List<ExamQuestionExt> searchExamQuestionAndSubQuestionByBookQuestionType(String bookFlow,String questionTypeId){
		return examQuestionExtMapper.searchExamQuestionAndSubQuestionByBookQuestionType(bookFlow, questionTypeId);
	}
	
	@Override
	public List<ExamQuestionExt> searchExamQuestionAndSubQuestionBySubjectQuestionType(String subjectFlow,String questionTypeId){
		return examQuestionExtMapper.searchExamQuestionAndSubQuestionBySubjectQuestionType(subjectFlow, questionTypeId);
	}

	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookSubject(String bookFlow, String subjectFlow) {
		return examQuestionExtMapper.searchExamQuestionByBookSubject(bookFlow, subjectFlow);
	}

	@Override
	public List<ExamQuestionWithBLOBs> searchExamQuestionByBookBook(String bookFlow, String bookFlow2) {
		return examQuestionExtMapper.searchExamQuestionByBookBook(bookFlow, bookFlow2);
	}

	@Override
	public void del(String questionFlow) {
		
		ExamQuestionWithBLOBs update = new ExamQuestionWithBLOBs();
		update.setQuestionFlow(questionFlow);
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		examQuestionMapper.updateByPrimaryKeySelective(update);
		
		ExamQuestionDetailWithBLOBs updateD = new ExamQuestionDetailWithBLOBs();
		updateD.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionDetailExample exampleD = new ExamQuestionDetailExample();
		exampleD.createCriteria().andQuestionFlowEqualTo(questionFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		examQuestionDetailMapper.updateByExampleSelective(updateD, exampleD);
		
		ExamQuestionSubject qSubject = new ExamQuestionSubject();
		qSubject.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionSubjectExample eqsExample = new ExamQuestionSubjectExample();
		eqsExample.createCriteria().andQuestionFlowEqualTo(questionFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		examQuestionSubjectMapper.updateByExampleSelective(qSubject, eqsExample);
		
		ExamQuestionBook qBook = new ExamQuestionBook();
		qBook.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		ExamQuestionBookExample eqbExample = new ExamQuestionBookExample();
		eqbExample.createCriteria().andQuestionFlowEqualTo(questionFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		examQuestionBookMapper.updateByExampleSelective(qBook, eqbExample);
		
	}

	@Override
	public ExamQuestionExt createQuestion(String typeId, ExamBookImp bookImp , 
			Map<Integer, String> questionData){
		/**
		 * Type15("15","��ѡ��"),
	Type18("18","��ѡ��"),
	Type25("25","������"),
	Type26("26","������"),
	Type27("27","�Ƿ���"),
	Type28("28","�����"),
	Type29("29","���ʽ���"),
	Type30("30","�����"),
	Type31("31","������"),
	Type32("32","K����"),
	Type33("33","����������"),
	Type34("34","������"),
	Type35("35","�ʻ�ѡ��"),
	Type36("36","�Ķ��ж�"),
	Type37("37","������������ɾ���"),
	Type38("38","�Ķ����"),
	Type47("47","��ý����"),
	Type48("48","����")
		 */
		ExamQuestionExt question = null;
		try{
			if(QuestionTypeEnum.Type15.getId().equals(typeId)){
				question = createDanXQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type18.getId().equals(typeId)){
				question = createDuoXQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type25.getId().equals(typeId)){
				question = createBLQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type26.getId().equals(typeId)){
				question = createPWQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type27.getId().equals(typeId)){
				question = createSFQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type28.getId().equals(typeId)){
				question = createTKQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type29.getId().equals(typeId)){
				question = createMCJSQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type30.getId().equals(typeId)){
				question = createJDQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type31.getId().equals(typeId)){
				question = createLSQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type32.getId().equals(typeId)){
				question = createKXQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type33.getId().equals(typeId)){
				question = createBLFXQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type34.getId().equals(typeId)){
				question = createJSQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type35.getId().equals(typeId)){
				question = createCHXXQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type36.getId().equals(typeId)){
				question = createYDPDQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type37.getId().equals(typeId)){
				question = createGKDYYWCJZQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type38.getId().equals(typeId)){
				question = createYDLJQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type47.getId().equals(typeId)){
				question = createDMTQuestion(bookImp, questionData);
			}else if(QuestionTypeEnum.Type48.getId().equals(typeId)){
				question = createZWQuestion(bookImp, questionData);
			}else{
				throw new RuntimeException("��֧�ָ�����");
			}
		}catch(Exception e){
			throw new RuntimeException("���������ļ�ʧ��,����Ϊ:"+QuestionTypeEnum.getNameById(typeId));
		}
		
		return question;
	}
	
	@Override
	public String replaceQuestionStr(String data){
	    Pattern p = Pattern.compile("[A-Z]\\.{1}");
        Matcher m = p.matcher(data);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
        	if(m.group().equals("A.")){
        		m.appendReplacement(sb, "");
        	}
        	else{
        		m.appendReplacement(sb, "@@");	
        	}
        }
        m.appendTail(sb);
        return sb.toString();
	}
	
	/**
	 * ������������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createZWQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = new ExamQuestionExt();
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type48.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type48.getName());
		questionExt.setCreateBookFlow(bookImp.getBookFlow());
		questionExt.setCreateSubjectFlow(bookImp.getSubjectFlow());
		Set<Integer> linenumSet = questionData.keySet();
		for(Integer lineNum :linenumSet){
			String content =  questionData.get(lineNum);
			if(content.startsWith("��Ŀ����:")){
				questionExt.setQuestionContent(content.substring(content.indexOf(":")+1));
			}else if(content.startsWith("��Ŀ��:")){
				questionExt.setQuestionAnswer(content.substring(content.indexOf(":")+1));
			}else if(content.startsWith("��ȷ��:")){
				questionExt.setRightAnswer(content.substring(content.indexOf(":")+1));
			}
		}
		return questionExt;
	}
	
	/**
	 * �����Ķ��ж�����
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createYDPDQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = new ExamQuestionExt();
		List<ExamQuestionDetailWithBLOBs> questionDetails = new ArrayList<ExamQuestionDetailWithBLOBs>();
		ExamQuestionDetailWithBLOBs questionDetail = null;
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type36.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type36.getName());
		questionExt.setCreateBookFlow(bookImp.getBookFlow());
		questionExt.setCreateSubjectFlow(bookImp.getSubjectFlow());
		Set<Entry<Integer , String>> questionEntrySet = questionData.entrySet();
		Iterator<Entry<Integer , String>> iterator = questionEntrySet.iterator();
		int i = 0 ;
		while(iterator.hasNext()){
			Entry<Integer , String> iteratorEntry = iterator.next();
			if(i==0){
				questionExt.setQuestionContent(iteratorEntry.getValue());
			}else{
				questionDetail = new ExamQuestionDetailWithBLOBs();
				questionDetail.setQuestionContent(iteratorEntry.getValue());
				if(iterator.hasNext()){
					iteratorEntry = iterator.next();
					//questionDetail.setQuestionAnswer(replaceQuestionStr(iteratorEntry.getValue()));
					questionDetail.setQuestionAnswer(iteratorEntry.getValue());
				}
				if(iterator.hasNext()){
					iteratorEntry = iterator.next();
					questionDetail.setRightAnswer(iteratorEntry.getValue());
				}
				questionDetails.add(questionDetail);
			}
			i++;
		}
		questionExt.setQuestionDetails(questionDetails);
		return questionExt;
	}
	
	/**
	 * �����Ķ������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createYDLJQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createYDPDQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type38.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type38.getName());
		return questionExt;
	}
	
	/**
	 * ���������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createTKQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type28.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type28.getName());
		return questionExt;
	}
	
	/**
	 * �����Ƿ���
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createSFQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = new ExamQuestionExt();
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type27.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type27.getName());
		questionExt.setCreateBookFlow(bookImp.getBookFlow());
		questionExt.setCreateSubjectFlow(bookImp.getSubjectFlow());
		Set<Integer> linenumSet = questionData.keySet();
		for(Integer lineNum :linenumSet){
			String content =  questionData.get(lineNum);
			if(content.startsWith("��Ŀ����:")){
				questionExt.setQuestionContent(content.substring(content.indexOf(":")+1));
			}else if(content.startsWith("��Ŀ��:")){
				//questionExt.setQuestionAnswer(replaceQuestionStr(content.substring(content.indexOf(":")+1)));
				questionExt.setQuestionAnswer(content.substring(content.indexOf(":")+1));
			}else if(content.startsWith("��ȷ��:")){
				questionExt.setRightAnswer(content.substring(content.indexOf(":")+1));
			}
		}
		return questionExt;
	}
	
	/**
	 * ����������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createPWQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = new ExamQuestionExt();
		List<ExamQuestionDetailWithBLOBs> questionDetails = new ArrayList<ExamQuestionDetailWithBLOBs>();
		ExamQuestionDetailWithBLOBs questionDetail = null;
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type26.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type26.getName());
		questionExt.setCreateBookFlow(bookImp.getBookFlow());
		questionExt.setCreateSubjectFlow(bookImp.getSubjectFlow());
		Set<Entry<Integer , String>> questionEntrySet = questionData.entrySet();
		Iterator<Entry<Integer , String>> iterator = questionEntrySet.iterator();
		int i = 0 ;
		while(iterator.hasNext()){
			Entry<Integer , String> iteratorEntry = iterator.next();
			if(i==0){
				//questionExt.setQuestionContent(replaceQuestionStr(iteratorEntry.getValue()));
				questionExt.setQuestionContent(iteratorEntry.getValue());
			}else{
				questionDetail = new ExamQuestionDetailWithBLOBs();
				questionDetail.setQuestionContent(iteratorEntry.getValue());
				if(iterator.hasNext()){
					iteratorEntry = iterator.next();
					questionDetail.setRightAnswer(iteratorEntry.getValue());
				}
				questionDetails.add(questionDetail);
			}
			i++;
		}
		questionExt.setQuestionDetails(questionDetails);
		return questionExt;
	}
	
	/**
	 * �������ʽ�����
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createMCJSQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type29.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type29.getName());
		return questionExt;
	}
	
	/**
	 * ����������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createLSQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type31.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type31.getName());
		return questionExt;
	}
	
	/**
	 * ���������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createJDQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type30.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type30.getName());
		return questionExt;
	}
	
	/**
	 * ����������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createJSQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type34.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type34.getName());
		return questionExt;
	}
	
	/**
	 * ����������������ɾ�������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createGKDYYWCJZQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createYDPDQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type37.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type37.getName());
		return questionExt;
	}
	
	/**
	 * ������ѡ��
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createDuoXQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createSFQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type18.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type18.getName());
		return questionExt;
	}
	
	/**
	 * ������ѡ��
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createDanXQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createSFQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type15.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type15.getName());
		return questionExt;
	}
	
	/**
	 * �����ʻ�ѡ����
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createCHXXQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createSFQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type35.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type35.getName());
		return questionExt;
	}
	
	/**
	 * ����������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createBLQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createYDPDQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type25.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type25.getName());
		return questionExt;
	}
	
	/**
	 * ��������������
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createBLFXQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createZWQuestion(bookImp , questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type33.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type33.getName());
		return questionExt;
	}
	
	/**
	 * ����K����
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createKXQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createDanXQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type32.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type32.getName());
		return questionExt;
	}
	
	/**
	 * ������ý����
	 * @param bookImp
	 * @param questionData
	 * @return
	 */
	private ExamQuestionExt createDMTQuestion(ExamBookImp bookImp , Map<Integer, String> questionData){
		ExamQuestionExt questionExt = createDanXQuestion(bookImp, questionData);
		questionExt.setQuestionTypeId(QuestionTypeEnum.Type47.getId());
		questionExt.setQuestionTypeName(QuestionTypeEnum.Type47.getName());
		return questionExt;
	}
	

}
