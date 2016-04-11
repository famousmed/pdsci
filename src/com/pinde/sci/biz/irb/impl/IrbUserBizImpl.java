package com.pinde.sci.biz.irb.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbUserMapper;
import com.pinde.sci.dao.irb.IrbUserExtMapper;
import com.pinde.sci.enums.irb.IrbAuthTypeEnum;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.IrbUserExample;
import com.pinde.sci.model.mo.IrbUserExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbUserBizImpl implements IIrbUserBiz {
	@Autowired
	private IrbUserMapper irbUserMapper;
	@Autowired
	private IrbUserExtMapper irbUserExtMapper;

	@Override
	public int edit(IrbUser user) {
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(user, false);
				return this.irbUserMapper.updateByPrimaryKeySelective(user);
			}else{//ÐÂÔö
				user.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(user, true);
				return this.irbUserMapper.insertSelective(user);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<IrbUser> queryList(IrbUser user) {
		IrbUserExample example = new IrbUserExample();
		Criteria criteria =example.createCriteria();
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordStatus())){
				criteria.andRecordStatusEqualTo(user.getRecordStatus());
			}
			if(StringUtil.isNotBlank(user.getIrbFlow())){
				criteria.andIrbFlowEqualTo(user.getIrbFlow());
			}
			if(StringUtil.isNotBlank(user.getUserFlow())){
				criteria.andUserFlowEqualTo(user.getUserFlow());
			}
			if(StringUtil.isNotBlank(user.getAuthId())){
				criteria.andAuthIdEqualTo(user.getAuthId());
			}
		}
		example.setOrderByClause("AUTH_ID");
		return this.irbUserMapper.selectByExample(example);
	}

	@Override
	public IrbUser query(String recordFlow) {
		return this.irbUserMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public List<IrbUser> searchCommitteeList(String irbFlow) {
		IrbUserExample example = new IrbUserExample();
		Criteria criteria =example.createCriteria();
		criteria.andIrbFlowEqualTo(irbFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andAuthIdNotEqualTo(IrbAuthTypeEnum.Consultant.getId());
		example.setOrderByClause("AUTH_ID desc");
		return this.irbUserMapper.selectByExample(example);
	}
	@Override
	public List<IrbUser> searchCommitteePROList(String irbFlow) {
		IrbUserExample example = new IrbUserExample();
		Criteria criteria =example.createCriteria();
		criteria.andIrbFlowEqualTo(irbFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andAuthIdEqualTo(IrbAuthTypeEnum.CommitteePRO.getId());
		example.setOrderByClause("CREATE_TIME");
		return this.irbUserMapper.selectByExample(example);
	}

	@Override
	public List<IrbUser> queryIrbUserList() {
		IrbUserExample example = new IrbUserExample();
		example.createCriteria().andAuthIdNotEqualTo(IrbAuthTypeEnum.Consultant.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return irbUserMapper.selectByExample(example);
	}
	
	@Override
	public IrbUser searchConsultant(String irbFlow) {
		IrbUser user = new IrbUser();
		IrbUserExample example = new IrbUserExample();
		Criteria criteria =example.createCriteria();
		criteria.andIrbFlowEqualTo(irbFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andAuthIdEqualTo(IrbAuthTypeEnum.Consultant.getId());
		List<IrbUser> list = this.irbUserMapper.selectByExample(example);
		if (list != null && list.size() > 0) {
			user = list.get(0);
		}
		return user;
	}
	
	@Override
	public IrbUser searchCommitteeICF(String irbFlow) {
		IrbUser user = new IrbUser();
		IrbUserExample example = new IrbUserExample();
		Criteria criteria =example.createCriteria();
		criteria.andIrbFlowEqualTo(irbFlow);
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andAuthIdEqualTo(IrbAuthTypeEnum.CommitteeICF.getId());
		List<IrbUser> list = this.irbUserMapper.selectByExample(example);
		if (list != null && list.size() > 0) {
			user = list.get(0);
		}
		return user;
	}
	
	@Override
	public List<IrbUser> queryIrbUserList(String year) {
		return this.irbUserExtMapper.queryIrbUserList(year);
	}

}
