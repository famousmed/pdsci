package com.pinde.sci.biz.res.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorBiz;
import com.pinde.sci.biz.res.IResDoctorOrgHistoryBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResDoctorOrgHistoryMapper;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorOrgHistory;
import com.pinde.sci.model.mo.ResDoctorOrgHistoryExample;
import com.pinde.sci.model.mo.ResDoctorOrgHistoryExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResDoctorOrgHistoryBizImpl implements IResDoctorOrgHistoryBiz{
	@Autowired
	private ResDoctorOrgHistoryMapper docOrgHistoryMapper;
	@Autowired
	private IResDoctorBiz doctorBiz;
	
	@Override
	public int editDocOrgHistory(ResDoctorOrgHistory docOrgHistory) {
		if(docOrgHistory!=null){
			if(StringUtil.isNotBlank(docOrgHistory.getRecordFlow())){
				GeneralMethod.setRecordInfo(docOrgHistory, false);
				return docOrgHistoryMapper.updateByPrimaryKeySelective(docOrgHistory);
			}else{
				docOrgHistory.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(docOrgHistory, true);
				return docOrgHistoryMapper.insertSelective(docOrgHistory);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int editDocOrgHistoryAndDoc(ResDoctorOrgHistory docOrgHistory,ResDoctor doctor) {
		doctorBiz.editDoctor(doctor);
		return editDocOrgHistory(docOrgHistory);
	}

	@Override
	public ResDoctorOrgHistory readDocOrgHistory(String recordFlow) {
		return docOrgHistoryMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public List<ResDoctorOrgHistory> searchIsInDocByDocOrgHis(ResDoctorOrgHistory docOrgHistory) {
		ResDoctorOrgHistoryExample example = new ResDoctorOrgHistoryExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		setCriteria(docOrgHistory,criteria);
		example.setOrderByClause("OUT_DATE");
		return docOrgHistoryMapper.selectByExample(example);
	}
	
	private void setCriteria(ResDoctorOrgHistory docOrgHistory,Criteria criteria){
		if(docOrgHistory!=null){
			if(StringUtil.isNotBlank(docOrgHistory.getOrgFlow())){
				criteria.andOrgFlowEqualTo(docOrgHistory.getOrgFlow());
			}
			if(StringUtil.isNotBlank(docOrgHistory.getOrgName())){
				criteria.andOrgNameLike("%"+docOrgHistory.getOrgName()+"%");
			}
			if(StringUtil.isNotBlank(docOrgHistory.getHistoryOrgFlow())){
				criteria.andHistoryOrgFlowEqualTo(docOrgHistory.getHistoryOrgFlow());
			}
			if(StringUtil.isNotBlank(docOrgHistory.getHistoryOrgName())){
				criteria.andHistoryOrgNameLike("%"+docOrgHistory.getHistoryOrgName()+"%");
			}
			if(StringUtil.isNotBlank(docOrgHistory.getChangeStatusId())){
				criteria.andChangeStatusIdEqualTo(docOrgHistory.getChangeStatusId());
			}
			if(StringUtil.isNotBlank(docOrgHistory.getDoctorFlow())){
				criteria.andDoctorFlowEqualTo(docOrgHistory.getDoctorFlow());
			}
			if(StringUtil.isNotBlank(docOrgHistory.getDoctorName())){
				criteria.andDoctorNameLike("%"+docOrgHistory.getDoctorName()+"%");
			}
		}
	}
	
	@Override
	public List<ResDoctorOrgHistory> searchHistoryByDoctorFlows(List<String> doctorFlows) {
		ResDoctorOrgHistoryExample example = new ResDoctorOrgHistoryExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andDoctorFlowIn(doctorFlows);
		example.setOrderByClause("OUT_DATE");
		return docOrgHistoryMapper.selectByExample(example);
	}
}
