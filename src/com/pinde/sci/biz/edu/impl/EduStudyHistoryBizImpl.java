package com.pinde.sci.biz.edu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseAnswerBiz;
import com.pinde.sci.biz.edu.IEduCourseChapterBiz;
import com.pinde.sci.biz.edu.IEduCourseQuestionBiz;
import com.pinde.sci.biz.edu.IEduStudyHistoryBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.EduStudyHistoryMapper;
import com.pinde.sci.enums.edu.EduStudyHistoryTypeEnum;
import com.pinde.sci.model.edu.EduAnswerExt;
import com.pinde.sci.model.edu.EduCourseChapterExt;
import com.pinde.sci.model.edu.EduQuestionExt;
import com.pinde.sci.model.mo.EduStudyHistory;
import com.pinde.sci.model.mo.EduStudyHistoryExample;
@Service
@Transactional(rollbackFor=Exception.class)
public class EduStudyHistoryBizImpl implements IEduStudyHistoryBiz {

	@Autowired
	private EduStudyHistoryMapper eduStudyHistoryMapper;
	@Autowired
	private IEduCourseQuestionBiz eduCourseQuestionBiz;
	@Autowired
	private IEduCourseChapterBiz eduCourseChapterBiz;
	@Autowired
	private IEduCourseAnswerBiz eduCourseAnswerBiz;
	@Override
	public int edit(EduStudyHistory history) {
		if(history!=null){
			if(StringUtil.isNotBlank(history.getRecordFlow())){//修改
				GeneralMethod.setRecordInfo(history, false);
				return this.eduStudyHistoryMapper.updateByPrimaryKeySelective(history);
			}else{//新增
				history.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(history, true);
				return this.eduStudyHistoryMapper.insertSelective(history);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public int save(String operTypeId, String resourceFlow) {
		if(StringUtil.isNotBlank(operTypeId)&&StringUtil.isNotBlank(resourceFlow)){
			EduStudyHistory history = new EduStudyHistory();
			history.setOperTypeId(operTypeId);
			history.setOperTypeName(EduStudyHistoryTypeEnum.getNameById(operTypeId));
			history.setUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			history.setResourceFlow(resourceFlow);
			history.setOperTime(DateUtil.getCurrDateTime());
			return this.edit(history);
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public List<EduStudyHistory> searchList() {
		EduStudyHistoryExample example = new EduStudyHistoryExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("oper_time desc");
		return this.eduStudyHistoryMapper.selectByExample(example);
	}
	@Override
	public Map<String, Object> searchExtData(List<EduStudyHistory> historyList) {
		Map<String,Object> dataMap = null;
		if(historyList != null && !historyList.isEmpty()){
			dataMap = new HashMap<String,Object>();
			for (EduStudyHistory h : historyList) {
				if(EduStudyHistoryTypeEnum.Question.getId().equals(h.getOperTypeId())){//提问
					EduQuestionExt questionExt = this.eduCourseQuestionBiz.searchOneWithExt(h.getResourceFlow());
					dataMap.put(h.getRecordFlow(), questionExt);
				}else if(EduStudyHistoryTypeEnum.Course.getId().equals(h.getOperTypeId())){//学习课程
					EduCourseChapterExt chapterExt = this.eduCourseChapterBiz.seachOneWithExt(h.getResourceFlow());
					dataMap.put(h.getRecordFlow(), chapterExt);
				}else if(EduStudyHistoryTypeEnum.Reply.getId().equals(h.getOperTypeId())){//回复
					EduAnswerExt answerExt = this.eduCourseAnswerBiz.searchAnswerExt(h.getResourceFlow());
					dataMap.put(h.getRecordFlow(), answerExt);
				}else if(EduStudyHistoryTypeEnum.Test.getId().equals(h.getOperTypeId())){//测验
					
				}
			}
		}
		return dataMap;
	}

}
