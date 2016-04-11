package com.pinde.sci.biz.res.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResOrgSpeAssignMapper;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResOrgSpeAssignExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResOrgSpeAssignBizImpl implements IResOrgSpeAssignBiz {
	@Autowired
	private ResOrgSpeAssignMapper speAssignMapper;
	
	@Override
	public List<ResOrgSpeAssign> searchSpeAssign(String assignYear){
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andAssignYearEqualTo(assignYear);
		return speAssignMapper.selectByExample(example);
	}
	
	@Override
	public int editSpeAssign(ResOrgSpeAssign speAssign){
		if(speAssign!=null){
			if(StringUtil.isNotBlank(speAssign.getRecordFlow())){
				GeneralMethod.setRecordInfo(speAssign, false);
				return speAssignMapper.updateByPrimaryKeySelective(speAssign);
			}else{
				speAssign.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(speAssign, true);
				return speAssignMapper.insertSelective(speAssign);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int editSpeAssignUnSelective(ResOrgSpeAssign speAssign){
		if(speAssign!=null){
			
			String orgFlow = speAssign.getOrgFlow();
			String speId = speAssign.getSpeId();
			ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andOrgFlowEqualTo(orgFlow)
			.andSpeIdEqualTo(speId);
			int count = this.speAssignMapper.countByExample(example);
			if(count==0){
				speAssign.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(speAssign, true);
				return speAssignMapper.insert(speAssign);
			}else{
				GeneralMethod.setRecordInfo(speAssign, false);
				return speAssignMapper.updateByExampleSelective(speAssign, example);
			}
			
//			if(StringUtil.isNotBlank(speAssign.getRecordFlow())){
//				
//			}else{
//				
//			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<ResOrgSpeAssign> searchSpeAssign(String orgFlow,
			String assignYear) {
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow).andAssignYearEqualTo(assignYear);
		return this.speAssignMapper.selectByExample(example);
	}
	
	public ResOrgSpeAssign searchSpeAssign(String orgFlow , String assignYear , String speId){
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andOrgFlowEqualTo(orgFlow)
		.andAssignYearEqualTo(assignYear)
		.andSpeIdEqualTo(speId);
		List<ResOrgSpeAssign> spes = speAssignMapper.selectByExample(example);
		if(spes.size()==1){
			return spes.get(0);
		}
		return null;
	}

	@Override
	public ResOrgSpeAssign findSpeAssignByFlow(String flow) {
		return this.speAssignMapper.selectByPrimaryKey(flow);
	}

	@Override
	public List<ResOrgSpeAssign> searchSpeAssignBySpeIdAndYear(String speId , String year) {
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andSpeIdEqualTo(speId)
		.andAssignYearEqualTo(year);
		return this.speAssignMapper.selectByExample(example);
	}
	
}
