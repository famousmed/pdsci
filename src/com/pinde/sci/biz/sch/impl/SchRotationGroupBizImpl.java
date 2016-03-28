package com.pinde.sci.biz.sch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchRotationDeptMapper;
import com.pinde.sci.dao.base.SchRotationGroupMapper;
import com.pinde.sci.dao.sch.SchRotationGroupExtMapper;
import com.pinde.sci.model.mo.SchRotationDept;
import com.pinde.sci.model.mo.SchRotationDeptExample;
import com.pinde.sci.model.mo.SchRotationGroup;
import com.pinde.sci.model.mo.SchRotationGroupExample;
import com.pinde.sci.model.mo.SchRotationGroupExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchRotationGroupBizImpl implements ISchRotationGroupBiz {
	@Autowired
	private SchRotationGroupMapper rotationGroupMapper;
	@Autowired
	private SchRotationGroupExtMapper rotationGroupExtMapper;
	@Autowired
	private SchRotationDeptMapper rotationDeptMapper;

	@Override
	public List<SchRotationGroup> searchSchRotationGroup() {
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationGroup> searchSchRotationGroupByorg(String orgFlow) {
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		return rotationGroupMapper.selectByExample(example);
	}

	@Override
	public List<SchRotationGroup> searchSchRotationGroup(String rotationFlow) {
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowEqualTo(rotationFlow)
		.andOrgFlowIsNull();
		example.setOrderByClause("ORDINAL");
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationGroup> searchOrgGroupOrAll(String rotationFlow,String orgFlow,String isRequired) {
		SchRotationGroupExample example = new SchRotationGroupExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andRotationFlowEqualTo(rotationFlow)
		.andOrgFlowEqualTo(orgFlow);
		if(StringUtil.isNotBlank(isRequired)){
			criteria.andIsRequiredEqualTo(isRequired);
		}
		example.setOrderByClause("ORDINAL");
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationDept> readSchRotationDept(String groupFlow) {
		SchRotationDeptExample example = new SchRotationDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andGroupFlowEqualTo(groupFlow);
		return rotationDeptMapper.selectByExample(example);
	}
	
	@Override
	public SchRotationGroup readSchRotationGroup(String groupFlow){
		return rotationGroupMapper.selectByPrimaryKey(groupFlow);
	}

	@Override
	public int saveSchRotationGroup(SchRotationGroup rotationGroup) {
		if(rotationGroup != null){
			if(StringUtil.isNotBlank(rotationGroup.getGroupFlow())){
				return update(rotationGroup);
			}else{
				return save(rotationGroup);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	public int save(SchRotationGroup rotationGroup){
		rotationGroup.setGroupFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(rotationGroup, true);
		return rotationGroupMapper.insertSelective(rotationGroup);
	}
	
	public int update(SchRotationGroup rotationGroup){
		GeneralMethod.setRecordInfo(rotationGroup, false);
		return rotationGroupMapper.updateByPrimaryKeySelective(rotationGroup);
	}
	
	@Override
	public List<SchRotationGroup> searchGroupByRotations(List<String> rotationFlows){
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRotationFlowIn(rotationFlows)
		.andOrgFlowIsNull();
		example.equals("ORDINAL");
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public List<SchRotationGroup> searchOrgGroupByRotations(List<String> rotationFlows,String orgFlow){
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andIsRequiredEqualTo(GlobalConstant.FLAG_N)
		.andRotationFlowIn(rotationFlows)
		.andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("ORDINAL");
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public int sumDeptNumByRotation(String rotationFlow){
		return rotationGroupExtMapper.sumDeptNumByRotation(rotationFlow);
	}
	
	@Override
	public List<SchRotationGroup> searchGroupByGroupFlows(List<String> groupFlows){
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andGroupFlowIn(groupFlows);
		return rotationGroupMapper.selectByExample(example);
	}
	
	@Override
	public SchRotationGroup readGroupByStandard(String orgFlow,String standardGroupFlow){
		SchRotationGroup group = null;
		SchRotationGroupExample example = new SchRotationGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andStandardGroupFlowEqualTo(standardGroupFlow).andOrgFlowEqualTo(orgFlow);
		List<SchRotationGroup> groups = rotationGroupMapper.selectByExample(example);
		if(groups!=null && groups.size()>0){
			group = groups.get(0);
		}
		return group;
	}
	
}
