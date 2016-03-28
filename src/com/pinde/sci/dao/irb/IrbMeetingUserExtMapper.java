package com.pinde.sci.dao.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbMeetingUser;

public interface IrbMeetingUserExtMapper {

	List<IrbMeetingUser> searchMeetingUserList(String year);
	
}
