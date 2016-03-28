package com.pinde.sci.dao.irb;

import java.util.List;

import com.pinde.sci.form.irb.irbMeetingForm;
import com.pinde.sci.model.mo.IrbMeeting;

public interface IrbMeetingExtMapper {
	List<IrbMeeting> selectList(irbMeetingForm form);

	List<IrbMeeting> searchList(irbMeetingForm form);
}
