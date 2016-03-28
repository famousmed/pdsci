package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbMeetingUser;


public interface IIrbMeetingUserBiz{

	List<IrbMeetingUser> searchMeetingUserList(IrbMeetingUser meetingUser);
	/**
	 * 查询参会人员记录数
	 * @param meetingFlows
	 * @return
	 */
	long queryMeetingUserCount(List<String> meetingFlows);
	List<IrbMeetingUser> searchMeetingUserList(String year);
}
