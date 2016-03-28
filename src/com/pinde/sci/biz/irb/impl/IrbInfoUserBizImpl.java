package com.pinde.sci.biz.irb.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbInfoUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbInfoUserMapper;
import com.pinde.sci.dao.irb.IrbInfoUserExtMapper;
import com.pinde.sci.model.irb.IrbInfoUserExt;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbInfoUserExample;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.IrbInfoUserExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbInfoUserBizImpl implements IIrbInfoUserBiz {
	@Autowired
	private IrbInfoUserMapper irbInfoUserMapper;
	@Autowired
	private IrbInfoUserExtMapper irbInfoUserExtMapper;

	@Override
	public int edit(IrbInfoUser user) {
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(user, false);
				return this.irbInfoUserMapper.updateByPrimaryKeySelective(user);
			}else{//ÐÂÔö
				user.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(user, true);
				return this.irbInfoUserMapper.insertSelective(user);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	

	@Override
	public void editUsers(List<IrbInfoUser> users) {
		for (IrbInfoUser user : users) {
			this.edit(user);
		}
	}

	@Override
	public List<IrbInfoUser> queryUserList(IrbInfoUser user) {
		IrbInfoUserExample example = new IrbInfoUserExample();
		Criteria criteria = example.createCriteria();
		if(user!=null){
			if(StringUtil.isNotBlank(user.getIrbInfoFlow())){
				criteria.andIrbInfoFlowEqualTo(user.getIrbInfoFlow());
			}
			if(StringUtil.isNotBlank(user.getRecordStatus())){
				criteria.andRecordStatusEqualTo(user.getRecordStatus());
			}
			if(StringUtil.isNotBlank(user.getUserFlow())){
				criteria.andUserFlowEqualTo(user.getUserFlow());
			}
			if(StringUtil.isNotBlank(user.getRoleFlow())){
				criteria.andRoleFlowEqualTo(user.getRoleFlow());
			}
		}
		example.setOrderByClause("ORDINAL");
		return this.irbInfoUserMapper.selectByExample(example);
	}


	@Override
	public int delete(IrbInfoUser user) {
		IrbInfoUserExample example = new IrbInfoUserExample();
		Criteria criteria = example.createCriteria();
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordFlow())){
				criteria.andRecordFlowEqualTo(user.getRecordFlow());
			}
			if(StringUtil.isNotBlank(user.getIrbInfoFlow())){
				criteria.andIrbInfoFlowEqualTo(user.getIrbInfoFlow());
			}
		}
		return 0;
	}


	@Override
	public List<IrbInfoUserExt> queryUserExtList(IrbInfoUser user) {
		return this.irbInfoUserExtMapper.selectExtList(user);
	}


	@Override
	public IrbInfoUser queryUserByFlow(String flow) {
		if(StringUtil.isNotBlank(flow)){
			return this.irbInfoUserMapper.selectByPrimaryKey(flow);
		}
		return null;
	}


	@Override
	public void saveOrder(String[] userFlow,String irbInfoFlow) {
		if(userFlow==null) return;
			int i=1;
			IrbInfoUser infoUser = new IrbInfoUser();
			for(String flow : userFlow){
				IrbInfoUserExample example = new IrbInfoUserExample();
				example.createCriteria().andUserFlowEqualTo(flow).andIrbInfoFlowEqualTo(irbInfoFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
				infoUser.setOrdinal((i++));
				irbInfoUserMapper.updateByExampleSelective(infoUser, example);		
			}	
	}
}
