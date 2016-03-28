package com.pinde.sci.biz.irb.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbResearcherBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbApplyMapper;
import com.pinde.sci.dao.irb.IrbApplyExtMapper;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.enums.irb.IrbTypeEnum;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbApplyExample;
import com.pinde.sci.model.mo.IrbApplyExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbApplyBizImpl implements IIrbApplyBiz {
	@Autowired
	private IrbApplyMapper irbApplyMapper;
	@Autowired
	private IrbApplyExtMapper irbApplyExtMapper;
	@Autowired
	private IIrbResearcherBiz irbResearcherBiz;
	
	@Override
	public IrbApply queryByFlow(String irbFlow) {
		return this.irbApplyMapper.selectByPrimaryKey(irbFlow);
	}
	@Override
	public int edit(IrbApply irbApply) {
		if(irbApply!=null){
			if(StringUtil.isNotBlank(irbApply.getIrbFlow())){//修改
				GeneralMethod.setRecordInfo(irbApply, false);
				return this.irbApplyMapper.updateByPrimaryKeySelective(irbApply);
			}else{//新增
				irbApply.setIrbFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(irbApply, true);
				return this.irbApplyMapper.insertSelective(irbApply);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public List<IrbApply> queryList(IrbApplyForm form) {
		return this.irbApplyExtMapper.queryList(form);
	}
		
	@Override
	public List<IrbApply> queryIrbApply(IrbApply irb) {
		IrbApplyExample example = new IrbApplyExample();
		com.pinde.sci.model.mo.IrbApplyExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(irb!=null){
			String projFlow = irb.getProjFlow();
			if(StringUtil.isNotBlank(projFlow)){
				criteria.andProjFlowEqualTo(projFlow);
			}
			String irbInfoFlow = irb.getIrbInfoFlow();
			if(StringUtil.isNotBlank(irbInfoFlow)){
				criteria.andIrbInfoFlowEqualTo(irbInfoFlow);
			}
			String irbApplyDate = irb.getIrbApplyDate();
			if(StringUtil.isNotBlank(irbApplyDate)){
				if(irbApplyDate.length()==4){
					criteria.andIrbApplyDateLike(irbApplyDate+"-%");
				}else{
					criteria.andIrbApplyDateEqualTo(irbApplyDate);
				}
			}
			String meetingFlow = irb.getMeetingFlow();
			if(StringUtil.isNotBlank(meetingFlow)){
				criteria.andMeetingFlowEqualTo(meetingFlow);
			}
			String meetingArrange = irb.getMeetingArrange();
			if(StringUtil.isNotBlank(meetingArrange)){
				criteria.andMeetingArrangeEqualTo(meetingArrange);
			}
		}
		
		example.setOrderByClause("IRB_APPLY_DATE,CREATE_TIME");
		return irbApplyMapper.selectByExample(example);
	}
	@Override
	public List<IrbApply> queryIrbApply(String startDate,String endDate,IrbApply irb) {
		IrbApplyExample example = new IrbApplyExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIrbDecisionIdIsNotNull().andIrbReviewDateIsNotNull();
		if (StringUtil.isBlank(endDate)) {	//默认当前日期
			endDate = DateUtil.getCurrDate();
		}
		if(StringUtil.isNotBlank(startDate)){
			criteria.andIrbReviewDateGreaterThanOrEqualTo(startDate);
		}
		if(StringUtil.isNotBlank(endDate)){
			criteria.andIrbReviewDateLessThanOrEqualTo(endDate);
		}
		if(irb!=null){
			String projFlow = irb.getProjFlow();
			if(StringUtil.isNotBlank(projFlow)){
				criteria.andProjFlowEqualTo(projFlow);
			}
			String irbInfoFlow = irb.getIrbInfoFlow();
			if(StringUtil.isNotBlank(irbInfoFlow)){
				criteria.andIrbInfoFlowEqualTo(irbInfoFlow);
			}
			String irbReviewDate = irb.getIrbReviewDate();
			if(StringUtil.isNotBlank(irbReviewDate)){
				if(irbReviewDate.length()==4){
					criteria.andIrbReviewDateLike(irbReviewDate+"-%");
				}else{
					criteria.andIrbReviewDateEqualTo(irbReviewDate);
				}
			}
			String meetingFlow = irb.getMeetingFlow();
			if(StringUtil.isNotBlank(meetingFlow)){
				criteria.andMeetingFlowEqualTo(meetingFlow);
			}
			if(StringUtil.isNotBlank(irb.getMeetingArrange())){
				criteria.andMeetingArrangeEqualTo(irb.getMeetingArrange());
			}
			if(StringUtil.isNotBlank(irb.getIrbTypeId())){
				criteria.andIrbTypeIdEqualTo(irb.getIrbTypeId());
			}
			if(StringUtil.isNotBlank(irb.getProjSubTypeId())){
				criteria.andProjSubTypeIdEqualTo(irb.getProjSubTypeId());
			}
			if(StringUtil.isNotBlank(irb.getIrbDecisionId())){
				criteria.andIrbDecisionIdEqualTo(irb.getIrbDecisionId());
			}
		}
		example.setOrderByClause("create_Time");
		return irbApplyMapper.selectByExample(example);
	}
	
	@Override
	public List<IrbApply> searchIrbApply(IrbApply irb) {
		IrbApplyExample example = new IrbApplyExample();
		com.pinde.sci.model.mo.IrbApplyExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(irb.getProjFlow())){
			criteria.andProjFlowEqualTo(irb.getProjFlow());
		}
		if(StringUtil.isNotBlank(irb.getMeetingFlow())){
			criteria.andMeetingFlowEqualTo(irb.getMeetingFlow());
		}
		if(StringUtil.isNotBlank(irb.getIrbTypeId())){
			criteria.andIrbTypeIdEqualTo(irb.getIrbTypeId());
		}
		example.setOrderByClause("TRACK_DATE");
		return irbApplyMapper.selectByExample(example);
	}
	@Override
	public void changeStage(IrbApply apply) {
		this.edit(apply);
		//this.irbResearcherBiz.handProcess(apply);
	}
	@Override
	public List<IrbApply> searchIrbList(String userFlow) {
		return irbApplyExtMapper.searchIrbList(userFlow);
	}
	@Override
	public void modifyIrbApply(IrbApply apply) {
		irbApplyMapper.updateByPrimaryKeySelective(apply);
	}
	
	@Override
	public List<IrbApply> searchCommitteeIrbList(Map<String,Object> paramMap) {
		List<IrbApply> applyList = irbApplyExtMapper.searchCommitteeIrbList(paramMap);
		applyList = sortApplyByIrbType(applyList);	//按审查类别排序
		return applyList;
	}
	@Override
	public Integer searchMeetingIrbList(String meetingFlow,String arrange) {
		IrbApplyExample example = new IrbApplyExample();
		example.createCriteria().andMeetingArrangeEqualTo(arrange).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andMeetingFlowEqualTo(meetingFlow);
		return irbApplyMapper.countByExample(example);
	}
	
	@Override
	public List<IrbApply> searchTrackIrbList() {
		return this.irbApplyExtMapper.searchTrackIrbList();
	}
	
	
	@Override
	public List<IrbApply> queryIrbApplyListByProjFlows(List<String> projFlowList,String irbTypeId) {
		IrbApplyExample example = new IrbApplyExample();
		com.pinde.sci.model.mo.IrbApplyExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(irbTypeId)) {
			criteria.andIrbTypeIdEqualTo(irbTypeId);
		}
		if(null != projFlowList && !projFlowList.isEmpty()){
			criteria.andProjFlowIn(projFlowList);
		}
		example.setOrderByClause("IRB_APPLY_DATE");
		List<IrbApply> applyList = irbApplyMapper.selectByExample(example);
		applyList = sortApplyByIrbType(applyList);	//按审查类别排序
		return applyList;
	}
	
	@Override
	public List<IrbApply> searchUnReviewIrbs(Map<String,Object> paramMap) {
		return irbApplyExtMapper.searchUnReviewIrbs(paramMap);
	}
	
	@Override
	public List<IrbApply> searchIrbs(IrbApply irb) {
		IrbApplyExample example = new IrbApplyExample();
		com.pinde.sci.model.mo.IrbApplyExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(irb.getProjNo())){
			criteria.andProjNoEqualTo(irb.getProjNo());
		}
		if(StringUtil.isNotBlank(irb.getProjName())){
			criteria.andProjNameLike("%"+irb.getProjName()+"%");
		}
		if(StringUtil.isNotBlank(irb.getIrbTypeId())){
			criteria.andIrbTypeIdEqualTo(irb.getIrbTypeId());
		}
		if(StringUtil.isNotBlank(irb.getIrbStageId())){
			criteria.andIrbStageIdEqualTo(irb.getIrbStageId());
		}
		if(StringUtil.isNotBlank(irb.getMeetingFlow())){
			criteria.andMeetingFlowEqualTo(irb.getMeetingFlow());
		}
		if(StringUtil.isNotBlank(irb.getMeetingArrange())){
			criteria.andMeetingArrangeEqualTo(irb.getMeetingArrange());
		}
		example.setOrderByClause("IRB_APPLY_DATE");
		List<IrbApply> applyList = irbApplyMapper.selectByExample(example);
		applyList = sortApplyByIrbType(applyList);	//按审查类别排序
		
		return applyList;
	}
	
	@Override
	public List<IrbApply> sortApplyByIrbType(List<IrbApply> applyList) {
		if (applyList != null && applyList.size() > 0) {
			Collections.sort(applyList, new Comparator<IrbApply>(){
				@Override
				public int compare(IrbApply apply1, IrbApply apply2) {
					return IrbTypeEnum.getOrdinalById(apply1.getIrbTypeId()).compareTo(IrbTypeEnum.getOrdinalById(apply2.getIrbTypeId()));
				}
			});
		}
		return applyList;
	}
	
	@Override
	public List<IrbApply> queryIrbMeeting() {
		IrbApplyExample example = new IrbApplyExample();
		example.createCriteria().andMeetingFlowIsNotNull().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("MEETING_DATE DESC");
		return irbApplyMapper.selectByExample(example);
	}
	@Override
	public long queryIrbApplyCount(IrbApply irb) {
		IrbApplyExample example = new IrbApplyExample();
		com.pinde.sci.model.mo.IrbApplyExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(irb!=null){
			String projFlow = irb.getProjFlow();
			if(StringUtil.isNotBlank(projFlow)){
				criteria.andProjFlowEqualTo(projFlow);
			}
			String irbInfoFlow = irb.getIrbInfoFlow();
			if(StringUtil.isNotBlank(irbInfoFlow)){
				criteria.andIrbInfoFlowEqualTo(irbInfoFlow);
			}
			String irbReviewDate = irb.getIrbReviewDate();
			if(StringUtil.isNotBlank(irbReviewDate)){
				if(irbReviewDate.length()==4){
					criteria.andIrbReviewDateLike(irbReviewDate+"-%");
				}else{
					criteria.andIrbReviewDateEqualTo(irbReviewDate);
				}
			}
			String meetingFlow = irb.getMeetingFlow();
			if(StringUtil.isNotBlank(meetingFlow)){
				criteria.andMeetingFlowEqualTo(meetingFlow);
			}
			String meetingArrange = irb.getMeetingArrange();
			if(StringUtil.isNotBlank(meetingArrange)){
				criteria.andMeetingArrangeEqualTo(meetingArrange);
			}
		}
		return irbApplyMapper.countByExample(example);
	}
	@Override
	public int queryIrbApplyCount(String orgFlow) {
		int count = GlobalConstant.ZERO_LINE;
		if(StringUtil.isNotBlank(orgFlow)){
			count = this.irbApplyExtMapper.searchOrgCount(orgFlow);
		}
		return count;
	}
	
	@Override
	public List<IrbApply> searchUnDecisionIrbApply(String meetingFlow) {
		IrbApplyExample example = new IrbApplyExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andMeetingFlowEqualTo(meetingFlow).andMeetingArrangeEqualTo(IrbReviewTypeEnum.Meeting.getId())
		.andIrbDecisionIdIsNull();
		return irbApplyMapper.selectByExample(example);
	}
}
