package com.pinde.sci.biz.irb;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.irb.IrbMinutesForm;
import com.pinde.sci.form.irb.irbMeetingForm;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingUser;


public interface IIrbMeetingBiz {

	List<IrbMeeting> searchIrbMeeting();

	void addIrbMeeting(IrbMeeting meeting);

	IrbMeeting readIrbMeeting(String meetingFlow);

	Map<String, List<IrbMeetingUser>> searchIrbMeetingUserMap(String meetingFlow);

	List<IrbMeetingUser> searchIrbMeetingUser(String meetingFlow);

	List<IrbInfoUser> searchIrbInfoUser(String irbInfoFlow); 
	int editMeetingUser(IrbMeetingUser user); 
	/**
	 * �����û���Ҫ�μӵ����л���
	 * @param userFlow
	 * @return
	 */
	List<IrbMeeting> queryList(irbMeetingForm form);
	/**
	 * ��װForm
	 * @param list
	 * @return
	 */
	List<irbMeetingForm> queryFormList(List<IrbMeeting> list);
	/**
	 * ��������¼
	 * @param irbFlow
	 * @param form
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveMinutes(String irbFlow,IrbMinutesForm form,String[] userFlows) throws Exception;
	/**
	 * ��ȡ�����¼
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	IrbMinutesForm readMinutes(String irbFlow) throws Exception;
	/**
	 * ����ͬһ���û�
	 * @param meetingFlow
	 * @return
	 */
	List<IrbMeetingUser> filterUserList(String meetingFlow);
	/**
	 * �������޸�
	 * @param meeting
	 * @return
	 */
	int edit(IrbMeeting meeting);

	List<IrbMeeting> searchList(irbMeetingForm mForm);
	/**
	 * ��ѯ
	 * @param meeting
	 * @return
	 */
	List<IrbMeeting> searchList(IrbMeeting meeting);

	int editMeetingUserList(List<IrbMeetingUser> users);

	/**
	 * ͨ��userFlowɾ����Ա
	 * @param userFlow
	 * @return
	 */
	int delMeetingUser(String meetingFlow, String userFlow);

	/**
	 * ��ѯ����ͶƱ��Ա
	 * @param meetingFlow
	 * @return
	 */
	List<IrbMeetingUser> filterVoteUserList(String meetingFlow);
	
	/**
	 * ��ѯ����
	 */
	List<IrbMeeting> queryMeetingList(String meetingStartDate, String meetingEndDate);

	List<IrbMeeting> queryIrbMeeting();
}
