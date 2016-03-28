package com.pinde.sci.biz.edu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseQuestionBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.dao.base.EduQuestionMapper;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.dao.edu.EduQuestionExtMapper;
import com.pinde.sci.enums.edu.EduQuestionStatusEnum;
import com.pinde.sci.form.edu.EduQuestionForm;
import com.pinde.sci.form.edu.MajorForm;
import com.pinde.sci.form.edu.SysOrgExt;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.edu.EduUserExt;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseQuestionBizImpl implements IEduCourseQuestionBiz{

	@Autowired
	private EduQuestionMapper questionMapper;
	@Autowired
	private EduCourseExtMapper eduCourseExtMapper;
	@Autowired
	private EduQuestionExtMapper eduQuestionExtMapper;
	
	
	@Override
	public int saveQuestion(EduQuestion eduQuestion) {
		if(StringUtil.isNotBlank(eduQuestion.getQuestionFlow())){
			 GeneralMethod.setRecordInfo(eduQuestion, false);
			 return questionMapper.updateByPrimaryKeySelective(eduQuestion);
		}else{
			eduQuestion.setQuestionFlow(PkUtil.getUUID());
			 GeneralMethod.setRecordInfo(eduQuestion, true); 
			 return questionMapper.insertSelective(eduQuestion);
		}
	}
   

	@Override
	public List<EduQuestion> searchEduQuestionsList(EduQuestion eduQuestion,SysUser sysUser) {
		 Map<String,Object> paramMap=new HashMap<String, Object>();
		 paramMap.put("question", eduQuestion);
		 paramMap.put("user", sysUser);
		 List<EduQuestion> questionsList=eduCourseExtMapper.searchTchEduQuestionsList(paramMap);
		 return questionsList;
	}


	@Override
	public List<EduQuestionExt> searchQuestionsListWithAnswer(
			EduQuestion question) {
		return this.eduQuestionExtMapper.selectListWithAnswers(question);
	}


	@Override
	public Map<String, Map<String, Integer>> countQuestionMap(
			List<EduUserExt> eduUserExtList) {
		Map<String, Map<String, Integer>> countQuestionMap=new HashMap<String, Map<String,Integer>>();
		Map<String, Integer> questionAllCountMap=new HashMap<String,Integer>();
		Map<String, Integer> questionAnsweredCountMap=new HashMap<String,Integer>();
		Map<String, Integer> questionUnansweredCountMap=new HashMap<String,Integer>();
		for(EduUserExt eduUserExt:eduUserExtList){
			int countAll=0;
			int countAnswered=0;
			int countUnanswered=0;
			EduQuestion eduQuestion=new EduQuestion();
			eduQuestion.setQuestionStatusId(EduQuestionStatusEnum.Answered.getId());
			SysUser user=new SysUser();
			user.setUserFlow(eduUserExt.getUserFlow());
			List<EduQuestion> questionAnsweredList=searchEduQuestionsList(eduQuestion,user);
			eduQuestion.setQuestionStatusId(EduQuestionStatusEnum.Unanswered.getId());
			List<EduQuestion> questionUnansweredList=searchEduQuestionsList(eduQuestion,user);
			if(questionAnsweredList!=null){
				countAnswered=questionAnsweredList.size();
				countAll=countAll+countAnswered;
			}
			if(questionUnansweredList!=null){
				countUnanswered=questionUnansweredList.size();
				countAll=countAll+countUnanswered;
			}
			questionAllCountMap.put(eduUserExt.getUserFlow(), countAll);
			questionAnsweredCountMap.put(eduUserExt.getUserFlow(), countAnswered);
			questionUnansweredCountMap.put(eduUserExt.getUserFlow(), countUnanswered);
		}
		countQuestionMap.put("All", questionAllCountMap);
		countQuestionMap.put(EduQuestionStatusEnum.Answered.getId(), questionAnsweredCountMap);
		countQuestionMap.put(EduQuestionStatusEnum.Unanswered.getId(), questionUnansweredCountMap);
		return countQuestionMap;
	}


	@Override
	public EduQuestion readEduQuestion(String questionFlow) {
		return this.questionMapper.selectByPrimaryKey(questionFlow);
	}


	@Override
	public Map<String,Map<String, Map<String, Integer>>> questionCountMap(List<SysOrgExt> orgList,
			Map<String, Object> paramMap) {
		//问题状态-学校-专业-数量
		Map<String,Map<String, Map<String, Integer>>> questionCountFormMap=new HashMap<String, Map<String,Map<String,Integer>>>();
		
		//学校-专业-数量
		Map<String, Map<String, Integer>> questionCountFormOrgAllMap=null;
		Map<String, Map<String, Integer>> questionCountFormOrgAnsweredMap=null;
		Map<String, Map<String, Integer>> questionCountFormOrgUnansweredMap=null;
		//专业-数量
		Map<String,Integer> questionCountFormMajorAllMap=null;
		Map<String,Integer> questionCountFormMajorAnsweredMap=null;
		Map<String,Integer> questionCountFormMajorUnansweredMap=null;
		
		questionCountFormOrgAllMap=new HashMap<String, Map<String,Integer>>();
		questionCountFormOrgAnsweredMap=new HashMap<String, Map<String,Integer>>();
		questionCountFormOrgUnansweredMap=new HashMap<String, Map<String,Integer>>();
		
		int allCount=0;
		int answeredCount=0;
		int unansweredCount=0;
		if(orgList!=null && !orgList.isEmpty()){
			
			for(SysOrgExt orgExt:orgList){
				paramMap.put("orgFlow", orgExt.getOrgFlow());
				questionCountFormMajorAllMap=new HashMap<String, Integer>();
				questionCountFormMajorAnsweredMap=new HashMap<String, Integer>();
				questionCountFormMajorUnansweredMap=new HashMap<String, Integer>();
				for(MajorForm majorForm:orgExt.getMajorFormList()){
					paramMap.put("majorId", majorForm.getMajorId());
					allCount=this.eduQuestionExtMapper.selectQuestionCount(paramMap);
					
					paramMap.put("questionStatusId", EduQuestionStatusEnum.Answered.getId());
					answeredCount=this.eduQuestionExtMapper.selectQuestionCount(paramMap);
					
					paramMap.put("questionStatusId", EduQuestionStatusEnum.Unanswered.getId());
					unansweredCount=this.eduQuestionExtMapper.selectQuestionCount(paramMap);
					//删除问题状态参数
					paramMap.remove("questionStatusId");
					questionCountFormMajorAllMap.put(majorForm.getMajorId(), allCount);
					questionCountFormMajorAnsweredMap.put(majorForm.getMajorId(), answeredCount);
					questionCountFormMajorUnansweredMap.put(majorForm.getMajorId(), unansweredCount);
					
				}
				questionCountFormOrgAllMap.put(orgExt.getOrgFlow(), questionCountFormMajorAllMap);
				questionCountFormOrgAnsweredMap.put(orgExt.getOrgFlow(), questionCountFormMajorAnsweredMap);
				questionCountFormOrgUnansweredMap.put(orgExt.getOrgFlow(), questionCountFormMajorUnansweredMap);
				
				
			}
			questionCountFormMap.put("all",questionCountFormOrgAllMap);
			questionCountFormMap.put(EduQuestionStatusEnum.Answered.getId(),questionCountFormOrgAnsweredMap);
			questionCountFormMap.put(EduQuestionStatusEnum.Unanswered.getId(),questionCountFormOrgUnansweredMap);
		}
		
		
		return questionCountFormMap;
	}


	@Override
	public List<SysOrgExt> searchOrgOfQuestion(Map<String,Object> paramMap) {
		return this.eduQuestionExtMapper.selectOrgOfQuestion(paramMap);
	}


	@Override
	public List<EduQuestionExt> searchExtList(EduQuestionForm form) {
		List<EduQuestionExt> qList = null;
		if(form!=null){
			qList = this.eduQuestionExtMapper.selectExtList(form);
		}
		return qList;
	}


	@Override
	public List<EduAnswerExt> searchAnswers(String questionFlow) {
		List<EduAnswerExt> answerList = null;
		if(StringUtil.isNotBlank(questionFlow)){
			answerList =  this.eduQuestionExtMapper.selectAnswers(questionFlow);
		}
		return answerList;
	}


	@Override
	public EduQuestionExt searchOneWithExt(String questionFlow) {
		EduQuestionExt qExt = null;
		if(StringUtil.isNotBlank(questionFlow)){
			qExt = this.eduQuestionExtMapper.selectOneWithExt(questionFlow);
		}
		return qExt;
	}
}
