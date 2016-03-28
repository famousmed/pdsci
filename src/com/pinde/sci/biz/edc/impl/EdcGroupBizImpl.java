package com.pinde.sci.biz.edc.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edc.IEdcGroupBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EdcGroupMapper;
import com.pinde.sci.model.mo.EdcGroup;
import com.pinde.sci.model.mo.EdcGroupExample;
import com.pinde.sci.model.mo.EdcGroupExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class EdcGroupBizImpl implements IEdcGroupBiz {
	
	@Resource
	private EdcGroupMapper groupMapper;

	@Override
	public List<EdcGroup> searchEdcGroup(String projFlow) {
		EdcGroupExample example = new EdcGroupExample();
		Criteria criteria = example.createCriteria();
		criteria.andProjFlowEqualTo(projFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return groupMapper.selectByExample(example);
	}

	@Override
	public EdcGroup read(String gruopFlow) {
		return groupMapper.selectByPrimaryKey(gruopFlow);
	}
	
	@Override
	public void save(EdcGroup gruop) {
		if (StringUtil.isBlank(gruop.getGroupFlow())) {
			add(gruop);
		} else {
			mod(gruop);
		}
		groupMapper.updateByPrimaryKeySelective(gruop);		
	}
	
	@Override
	public void add(EdcGroup gruop) {
		gruop.setGroupFlow(PkUtil.getUUID());
		GeneralMethod.setRecordInfo(gruop, true);
		groupMapper.insert(gruop);		
	}

	@Override
	public void mod(EdcGroup gruop) {
		GeneralMethod.setRecordInfo(gruop, false);
		groupMapper.updateByPrimaryKeySelective(gruop);		
	}

	@Override
	public void del(EdcGroup gruop) {
		GeneralMethod.setRecordInfo(gruop, false);
		gruop.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		groupMapper.updateByPrimaryKeySelective(gruop);			
	}
	
	@Override
	public List<EdcGroup> searchEdcGroup(EdcGroup group) {
		EdcGroupExample example = new EdcGroupExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(group.getProjFlow())) {
			criteria.andProjFlowEqualTo(group.getProjFlow());
		}
		if (StringUtil.isNotBlank(group.getGroupName())) {
			criteria.andGroupNameEqualTo(group.getGroupName());
		}
		example.setOrderByClause("ORDINAL");
		return groupMapper.selectByExample(example);
	}
	
	@Override
	public EdcGroup searchEdcGroup(String projFlow,String groupName) {
		EdcGroupExample example = new EdcGroupExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andProjFlowEqualTo(projFlow).andGroupNameEqualTo(groupName);
		example.setOrderByClause("ORDINAL");
		List<EdcGroup> list = groupMapper.selectByExample(example);
		EdcGroup group = null;
		if (list != null && list.size() >0 ) {
			group = list.get(0);
		}
		return group;
	}

}
