package com.pinde.sci.biz.irb.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbMeetingUserBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbMeetingUserMapper;
import com.pinde.sci.dao.irb.IrbMeetingUserExtMapper;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbMeetingUserExample;
import com.pinde.sci.model.mo.IrbMeetingUserExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class IrbMeetingUserBizImpl implements IIrbMeetingUserBiz {
	@Autowired
	private IrbMeetingUserMapper meetingUserMapper;
	@Autowired
	private IrbMeetingUserExtMapper meetingUserExtMapper;

	@Override
	public List<IrbMeetingUser> searchMeetingUserList(IrbMeetingUser meetingUser) {
		IrbMeetingUserExample example = new IrbMeetingUserExample();
		com.pinde.sci.model.mo.IrbMeetingUserExample.Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(meetingUser.getMeetingFlow())){
			criteria.andMeetingFlowEqualTo(meetingUser.getMeetingFlow());
		}
		return meetingUserMapper.selectByExample(example);
	}

	@Override
	public long queryMeetingUserCount(List<String> meetingFlows) {
		IrbMeetingUserExample example = new IrbMeetingUserExample();
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(meetingFlows!=null&&!meetingFlows.isEmpty()){
			criteria.andMeetingFlowIn(meetingFlows);
		}
		return this.meetingUserMapper.countByExample(example);
	}
	
	@Override
	public List<IrbMeetingUser> searchMeetingUserList(String year) {
		return this.meetingUserExtMapper.searchMeetingUserList(year);
	}

}
