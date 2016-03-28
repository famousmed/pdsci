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
	 * 查找用户需要参加的所有会议
	 * @param userFlow
	 * @return
	 */
	List<IrbMeeting> queryList(irbMeetingForm form);
	/**
	 * 包装Form
	 * @param list
	 * @return
	 */
	List<irbMeetingForm> queryFormList(List<IrbMeeting> list);
	/**
	 * 保存会议记录
	 * @param irbFlow
	 * @param form
	 * @param userFlows
	 * @return
	 * @throws Exception
	 */
	int saveMinutes(String irbFlow,IrbMinutesForm form,String[] userFlows) throws Exception;
	/**
	 * 读取会议记录
	 * @param irbFlow
	 * @return
	 * @throws Exception
	 */
	IrbMinutesForm readMinutes(String irbFlow) throws Exception;
	/**
	 * 过滤同一个用户
	 * @param meetingFlow
	 * @return
	 */
	List<IrbMeetingUser> filterUserList(String meetingFlow);
	/**
	 * 新增或修改
	 * @param meeting
	 * @return
	 */
	int edit(IrbMeeting meeting);

	List<IrbMeeting> searchList(irbMeetingForm mForm);
	/**
	 * 查询
	 * @param meeting
	 * @return
	 */
	List<IrbMeeting> searchList(IrbMeeting meeting);

	int editMeetingUserList(List<IrbMeetingUser> users);

	/**
	 * 通过userFlow删除人员
	 * @param userFlow
	 * @return
	 */
	int delMeetingUser(String meetingFlow, String userFlow);

	/**
	 * 查询会议投票人员
	 * @param meetingFlow
	 * @return
	 */
	List<IrbMeetingUser> filterVoteUserList(String meetingFlow);
	
	/**
	 * 查询会议
	 */
	List<IrbMeeting> queryMeetingList(String meetingStartDate, String meetingEndDate);

	List<IrbMeeting> queryIrbMeeting();
}
