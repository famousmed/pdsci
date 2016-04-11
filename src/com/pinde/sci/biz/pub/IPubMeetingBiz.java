package com.pinde.sci.biz.pub;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.PubMeeting;
import com.pinde.sci.model.mo.PubMeetingFile;
import com.pinde.sci.model.mo.PubMeetingUser;

public interface IPubMeetingBiz {
	List<PubMeeting> searchPubMeeting();
	
	List<PubMeetingUser> searchPubMeetingUser();
	
	List<PubMeetingFile> searchPubMeetingFile();
	
	List<PubMeetingUser> searchPubMeetingUserByMeetingFlow(List<String> meetingFlows);
	
	List<PubMeetingFile> searchPubMeetingFileByMeetingFlow(List<String> meetingFlows);
	
	PubMeeting readPubMeeting(String meetingFlow);
	
	PubMeetingUser readyPubMeetingUser(String recordFlow);
	
	PubMeetingFile readPubMeetingFile(String recordFlow);
	
	int savePubMeeting(PubMeeting meeting);
	
	int savePubMeetingUser(PubMeetingUser meetingUser);
	
	int savePubMeetingFile(PubMeetingFile meetingFile);

	List<PubMeeting> searchPubMeetingByConditions(String startDate,
			String endDate, String meetingName, String meetingTypeId);

	int saveMeeting(MultipartFile[] files, String[] userFlow, PubMeeting meeting)
			throws Exception;

	int delMeetingFiles(List<String> fileFlows);

	int delPubMeeting(String meetingFlow);
}  
  