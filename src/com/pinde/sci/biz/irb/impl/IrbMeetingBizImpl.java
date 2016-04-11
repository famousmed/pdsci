package com.pinde.sci.biz.irb.impl;


import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbApplyBiz;
import com.pinde.sci.biz.irb.IIrbCommitteeBiz;
import com.pinde.sci.biz.irb.IIrbMeetingBiz;
import com.pinde.sci.biz.irb.IIrbRecBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.IrbInfoUserMapper;
import com.pinde.sci.dao.base.IrbMeetingMapper;
import com.pinde.sci.dao.base.IrbMeetingUserMapper;
import com.pinde.sci.dao.irb.IrbMeetingExtMapper;
import com.pinde.sci.enums.irb.IrbRecTypeEnum;
import com.pinde.sci.enums.irb.IrbReviewTypeEnum;
import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.form.irb.IrbArchiveForm;
import com.pinde.sci.form.irb.IrbMinutesForm;
import com.pinde.sci.form.irb.irbMeetingForm;
import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.IrbInfoUserExample;
import com.pinde.sci.model.mo.IrbMeeting;
import com.pinde.sci.model.mo.IrbMeetingExample;
import com.pinde.sci.model.mo.IrbMeetingExample.Criteria;
import com.pinde.sci.model.mo.IrbMeetingUser;
import com.pinde.sci.model.mo.IrbMeetingUserExample;
import com.pinde.sci.model.mo.IrbRec;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbMeetingBizImpl implements IIrbMeetingBiz {
	@Autowired
	private IrbMeetingMapper irbMeetingMapper;
	@Autowired
	private IrbMeetingUserMapper irbMeetingUserMapper;
	@Autowired
	private IrbInfoUserMapper irbInfoUserMapper;
	@Autowired
	private IrbMeetingExtMapper irbMeetingExtMapper;
	@Autowired
	private IIrbApplyBiz irbApplyBiz;
	@Autowired
	private IIrbRecBiz irbRecBiz;
	@Autowired
	private IIrbCommitteeBiz irbCommitteeBiz;

	@Override
	public List<IrbMeeting> searchIrbMeeting() {
		IrbMeetingExample example = new IrbMeetingExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("MEETING_DATE");
		return irbMeetingMapper.selectByExample(example);
	}
	
	@Override
	public List<IrbMeeting> queryIrbMeeting() {
		IrbMeetingExample example = new IrbMeetingExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("MEETING_DATE desc");
		return irbMeetingMapper.selectByExample(example);
	}

	@Override
	public void addIrbMeeting(IrbMeeting meeting) {
		if(StringUtil.isNotBlank(meeting.getMeetingFlow())){//修改
			GeneralMethod.setRecordInfo(meeting, false);
			irbMeetingMapper.updateByPrimaryKeySelective(meeting);
		}
		else{//新增
			meeting.setMeetingFlow(PkUtil.getUUID());
			meeting.setIrbName(InitConfig.irbInfoMap.get(meeting.getIrbInfoFlow()).getIrbName());
			GeneralMethod.setRecordInfo(meeting, true);
			irbMeetingMapper.insert(meeting);
		}
	}

	@Override
	public IrbMeeting readIrbMeeting(String meetingFlow) {
		return irbMeetingMapper.selectByPrimaryKey(meetingFlow);
	}

	@Override
	public Map<String, List<IrbMeetingUser>> searchIrbMeetingUserMap(
			String meetingFlow) {
		Map<String,List<IrbMeetingUser>> meetingUserMap = new LinkedHashMap<String, List<IrbMeetingUser>>();
		
		List<IrbMeetingUser> meetingUserList = searchIrbMeetingUser(meetingFlow);
		for(IrbMeetingUser meetingUser : meetingUserList){
			List<IrbMeetingUser> userList = meetingUserMap.get(meetingUser.getRoleFlow());
			if(userList == null){
				userList = new ArrayList<IrbMeetingUser>();
			}
			userList.add(meetingUser);
			meetingUserMap.put(meetingUser.getRoleFlow(), userList);
		}
		return meetingUserMap;
	}

	@Override
	public List<IrbMeetingUser> searchIrbMeetingUser(String meetingFlow) {
		IrbMeetingUserExample	example = new IrbMeetingUserExample();
		example.createCriteria().andMeetingFlowEqualTo(meetingFlow).andAttendStatusEqualTo(GlobalConstant.FLAG_Y).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ROLE_NAME desc");
		return irbMeetingUserMapper.selectByExample(example);
	}

	@Override
	public List<IrbInfoUser> searchIrbInfoUser(String irbInfoFlow) {
		IrbInfoUserExample	example = new IrbInfoUserExample();
		example.createCriteria().andIrbInfoFlowEqualTo(irbInfoFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ROLE_NAME DESC");
		return irbInfoUserMapper.selectByExample(example);
	}

	@Override
	public int editMeetingUser(IrbMeetingUser user) {
		if(user!=null){
			if(StringUtil.isNotBlank(user.getRecordFlow())){//修改
				GeneralMethod.setRecordInfo(user, false);
				this.irbMeetingUserMapper.updateByPrimaryKeySelective(user);
			}else{//新增
				user.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(user, true);
				this.irbMeetingUserMapper.insertSelective(user);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<IrbMeeting> queryList(irbMeetingForm form) {
		List<IrbMeeting> list = null;
		if(form!=null){
			list = this.irbMeetingExtMapper.selectList(form);
		}
		return list;
	}

	@Override
	public List<irbMeetingForm> queryFormList(List<IrbMeeting> list) {
		List<irbMeetingForm> formList = null;
		if(list!=null&&!list.isEmpty()){
			formList = new ArrayList<irbMeetingForm>();
			IrbApply apply = null;
			irbMeetingForm meetingForm = null;
			for (IrbMeeting m : list) {
				int fastCount = 0;//会议报告项目数
				int meetingCount = 0;//会议审查项目数
				meetingForm = new irbMeetingForm();
				meetingForm.setMeeting(m);
				apply = new IrbApply();
				apply.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
				apply.setMeetingFlow(m.getMeetingFlow());
				IrbApplyForm form = new IrbApplyForm();
				form.setIrbApply(apply);
				List<IrbApply> applyList = this.irbApplyBiz.queryList(form);
				for (IrbApply irbApply : applyList) {
					if(IrbReviewTypeEnum.Fast.getId().equals(irbApply.getMeetingArrange())){//快审
						fastCount++;
						continue;
					}else if(IrbReviewTypeEnum.Meeting.getId().equals(irbApply.getMeetingArrange())){//会审
						meetingCount++;
					}else if(IrbReviewTypeEnum.UrgentMeeting.getId().equals(irbApply.getMeetingArrange())){//会审
						meetingCount++;
					}
				}
				meetingForm.setFastCount(fastCount);
				meetingForm.setMeetingCount(meetingCount);
				formList.add(meetingForm);
			}
		}
		return formList;
	}

	@Override
	public int saveMinutes(String irbFlow, IrbMinutesForm form,String[] userFlows) throws Exception {
		if(StringUtil.isNotBlank(irbFlow) && form!=null){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.Minutes.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec==null){
				irbRec.setRecTypeName(IrbRecTypeEnum.Minutes.getName());
				IrbApply irbApply = this.irbApplyBiz.queryByFlow(irbFlow);
				irbRec.setProjFlow(irbApply.getProjFlow());
				irbRec.setIrbStageId(irbApply.getIrbStageId());
				irbRec.setIrbStageName(irbApply.getIrbStageName());
				findIrbRec = irbRec;
			}
			Document dom = DocumentHelper.createDocument();
			Element root = dom.addElement("minutes"); 
			/*会议报告的会议记录*/
			String reportMinutes = form.getReportMinutes();
			String question = form.getQuestion();
			String discussion = form.getDiscussion();
			String title = form.getTitle();
			if(StringUtil.isNotBlank(reportMinutes)){
				root.addElement("reportMinutes").setText(reportMinutes);
			}
			if(StringUtil.isNotBlank(title)){
				root.addElement("title").setText(title);
			}
			if(StringUtil.isNotBlank(question)){
				root.addElement("question").setText(question);
			}
			if(StringUtil.isNotBlank(discussion)){
				root.addElement("discussion").setText(discussion);
			}
			String recContent = dom.asXML();
			findIrbRec.setRecContent(recContent);
			this.irbCommitteeBiz.saveConflict(irbFlow, userFlows);
			this.irbRecBiz.edit(findIrbRec);
			/*插入存档文件*/
			IrbArchiveForm aForm = new IrbArchiveForm();
			aForm.setIrbFlow(irbFlow);
			aForm.setName(IrbRecTypeEnum.Minutes.getName());
			aForm.setRecType(IrbRecTypeEnum.Minutes.getId());
			aForm.setFileFlow(null);
			IrbApply curApply = this.irbApplyBiz.queryByFlow(irbFlow);
			String url =  GlobalContext.getRequest().getContextPath()+"/irb/meeting/minutes?irbFlow="+irbFlow+"&meetingArrange="+curApply.getMeetingArrange()+"&meetingCheck=Y";
			aForm.setUrl(url);
			this.irbRecBiz.saveArchiveFile(aForm);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public IrbMinutesForm readMinutes(String irbFlow) throws Exception {
		IrbMinutesForm form = null;
		if(StringUtil.isNotBlank(irbFlow)){
			IrbRec irbRec = new IrbRec(); 
			irbRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			irbRec.setIrbFlow(irbFlow);
			irbRec.setRecTypeId(IrbRecTypeEnum.Minutes.getId());
			IrbRec findIrbRec = this.irbRecBiz.readIrbRec(irbRec);
			if(findIrbRec!=null&&StringUtil.isNotBlank(findIrbRec.getRecContent())){
				form = new IrbMinutesForm(); 
				Document dom = DocumentHelper.parseText(findIrbRec.getRecContent());
				Element root = dom.getRootElement();
				Element reportMinutesEl = root.element("reportMinutes");
				Element titleEl = root.element("title");
				Element questionEl = root.element("question");
				Element discussionEl = root.element("discussion");
				if(reportMinutesEl!=null){
					form.setReportMinutes(reportMinutesEl.getText());
				}
				if(titleEl!=null){
					form.setTitle(titleEl.getText());
				}
				if(questionEl!=null){
					form.setQuestion(questionEl.getText());
				}
				if(discussionEl!=null){
					form.setDiscussion(discussionEl.getText());
				}
			}
		}
		return form;
	}

	@Override
	public List<IrbMeetingUser> filterUserList(String meetingFlow) {
		List<IrbMeetingUser> filterUserList = new ArrayList<IrbMeetingUser>();
		List<String> userFlowList = new ArrayList<String>();
		if(StringUtil.isNotBlank(meetingFlow)){
			List<IrbMeetingUser> list = this.searchIrbMeetingUser(meetingFlow);
			if(list!=null&&!list.isEmpty()){
				filterUserList = new ArrayList<IrbMeetingUser>();
				for (IrbMeetingUser user : list) {
					if (!userFlowList.contains(user.getUserFlow())) {
						filterUserList.add(user);
						userFlowList.add(user.getUserFlow());
					}
				}
			}
		}
		return filterUserList;
	}
	
	@Override
	public List<IrbMeetingUser> filterVoteUserList(String meetingFlow) {
		List<IrbMeetingUser> filterUserList = new ArrayList<IrbMeetingUser>();
		List<String> userFlowList = new ArrayList<String>();
		if(StringUtil.isNotBlank(meetingFlow)){
			List<IrbMeetingUser> list = this.searchIrbMeetingUser(meetingFlow);
			if(list!=null && list.size() > 0){
				filterUserList = new ArrayList<IrbMeetingUser>();
				for (IrbMeetingUser user : list) {
					String userFlow = user.getUserFlow();
					String roleFlow = user.getRoleFlow();
					if (!userFlowList.contains(userFlow)) {
						if (GlobalConstant.RECORD_STATUS_Y.equals(InitConfig.getSysCfg("vote_flag_"+roleFlow))) {
							filterUserList.add(user);
							userFlowList.add(userFlow);
						}
					}
				}
			}
		}
		return filterUserList;
	}

	@Override
	public int edit(IrbMeeting meeting) {
		if(meeting!=null){
			if(StringUtil.isNotBlank(meeting.getMeetingFlow())){//修改
				GeneralMethod.setRecordInfo(meeting, false);
				return this.irbMeetingMapper.updateByPrimaryKeySelective(meeting);
			}else{//新增
				meeting.setMeetingFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(meeting, true);
				return this.irbMeetingMapper.insertSelective(meeting);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public List<IrbMeeting> searchList(irbMeetingForm form) {
		List<IrbMeeting> list = null;
		if(form!=null){
			list = this.irbMeetingExtMapper.searchList(form);
		}
		return list;
	}
	
	@Override
	public int editMeetingUserList(List<IrbMeetingUser> users) {
		if (users != null && users.size() > 0) {
			for (IrbMeetingUser user:users) {
				if(StringUtil.isNotBlank(user.getRecordFlow())){//修改
					GeneralMethod.setRecordInfo(user, false);
					this.irbMeetingUserMapper.updateByPrimaryKeySelective(user);
				}else{//新增
					user.setRecordFlow(PkUtil.getUUID());
					GeneralMethod.setRecordInfo(user, true);
					this.irbMeetingUserMapper.insertSelective(user);
				}
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delMeetingUser(String meetingFlow,String userFlow) {
		if(StringUtil.isNotBlank(userFlow)){
			IrbMeetingUser user = new IrbMeetingUser();
			user.setUserFlow(userFlow);
			user.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(user, false);
			IrbMeetingUserExample	example = new IrbMeetingUserExample();
			example.createCriteria().andMeetingFlowEqualTo(meetingFlow).andUserFlowEqualTo(userFlow);
			this.irbMeetingUserMapper.updateByExampleSelective(user, example);
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<IrbMeeting> queryMeetingList(String meetingStartDate, String meetingEndDate) {
		IrbMeetingExample example = new IrbMeetingExample();
		com.pinde.sci.model.mo.IrbMeetingExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(meetingStartDate)){
			criteria.andMeetingDateGreaterThanOrEqualTo(meetingStartDate);
		}
		if(StringUtil.isNotBlank(meetingEndDate)){
			criteria.andMeetingDateLessThanOrEqualTo(meetingEndDate);
		}
		example.setOrderByClause("MEETING_DATE DESC");
		return irbMeetingMapper.selectByExample(example);
	}
	
	@Override
	public List<IrbMeeting> searchList(IrbMeeting meeting) {
		IrbMeetingExample example = new IrbMeetingExample();
		Criteria criteria =example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(meeting!=null){
			String meetingDate = meeting.getMeetingDate();
			if(StringUtil.isNotBlank(meetingDate)){
				if(meetingDate.length()==4){
					criteria.andMeetingDateLike(meetingDate+"-%");
				}else{
					criteria.andMeetingDateEqualTo(meetingDate);
				}
			}
			String irbInfoFlow = meeting.getIrbInfoFlow();
			if(StringUtil.isNotBlank(irbInfoFlow)){
				criteria.andIrbInfoFlowEqualTo(irbInfoFlow);
			}
			String meetingStatus = meeting.getMeetingStatus();
			if(StringUtil.isNotBlank(meetingStatus)){
				criteria.andMeetingStatusEqualTo(meetingStatus);
			}
		}
		return this.irbMeetingMapper.selectByExample(example);
	}
	
}
