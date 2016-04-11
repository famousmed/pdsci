package com.pinde.sci.biz.edu.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseAnswerBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduAnswerMapper;
import com.pinde.sci.dao.base.EduQuestionMapper;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.dao.edu.EduQuestionExtMapper;
import com.pinde.sci.enums.edu.EduQuestionStatusEnum;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.mo.EduAnswer;
import com.pinde.sci.model.mo.EduQuestion;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseAnswerBizImpl implements IEduCourseAnswerBiz{
    
	@Autowired
	private EduAnswerMapper eduAnswerMapper;
	@Autowired
	private EduQuestionMapper eduQuestionMapper;
	@Autowired
	private EduCourseExtMapper eduCourseExtMapper;
	@Autowired
	private EduQuestionExtMapper eduQuestionExtMapper;
	
	@Override
	public List<EduAnswer> searchAnswerList(String questionFlow) {
		List<EduAnswer> answerList=eduCourseExtMapper.searchEduAnswerList(questionFlow);
		return answerList;
	}

	@Override
	public int saveAnswer(EduAnswer eduAnswer) {
		//获取当前登录者权限列表
		List<String> currRoleList=(List<String>) GlobalContext.getSessionAttribute(GlobalConstant.CURRENT_ROLE_LIST); 
		//获取学生角色流水号
		String stuRoleFlow=InitConfig.getSysCfg("student_role_flow");
		eduAnswer.setAnswerFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(eduAnswer, true);
		EduQuestion question=eduQuestionMapper.selectByPrimaryKey(eduAnswer.getQuestionFlow());
		if(null!=question){
			if(GlobalConstant.RECORD_STATUS_Y.equals(question.getSubmitTeacher())){
				if(currRoleList!=null && !currRoleList.isEmpty()){
					if(!currRoleList.contains(stuRoleFlow)){
						question.setQuestionStatusId(EduQuestionStatusEnum.Answered.getId());
						question.setQuestionStatusName(EduQuestionStatusEnum.Answered.getName());
					}
				}
			}
			GeneralMethod.setRecordInfo(question, false);
		}
		int questionResult = eduQuestionMapper.updateByPrimaryKey(question);		
		int answerResult = eduAnswerMapper.insertSelective(eduAnswer);
		if(GlobalConstant.ONE_LINE == questionResult && GlobalConstant.ONE_LINE == answerResult){
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public EduAnswerExt searchAnswerExt(String answerFlow) {
		EduAnswerExt answerExt = null;
		if(StringUtil.isNotBlank(answerFlow)){
			answerExt = this.eduQuestionExtMapper.selectAnswerExt(answerFlow);
		}
		return answerExt;
	}

	

	

}
