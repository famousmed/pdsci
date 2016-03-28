package com.pinde.sci.biz.pub.impl;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IFileBiz;
import com.pinde.sci.biz.pub.IPubMeetingBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubMeetingFileMapper;
import com.pinde.sci.dao.base.PubMeetingMapper;
import com.pinde.sci.dao.base.PubMeetingUserMapper;
import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubMeeting;
import com.pinde.sci.model.mo.PubMeetingExample;
import com.pinde.sci.model.mo.PubMeetingExample.Criteria;
import com.pinde.sci.model.mo.PubMeetingFile;
import com.pinde.sci.model.mo.PubMeetingFileExample;
import com.pinde.sci.model.mo.PubMeetingUser;
import com.pinde.sci.model.mo.PubMeetingUserExample;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubMeetingBizImpl implements IPubMeetingBiz {
	@Resource
	private PubMeetingMapper pubMeetingMapper;
	@Resource                                                         
	private PubMeetingUserMapper pubMeetingUserMapper;                
	@Resource                                                         
	private PubMeetingFileMapper pubMeetingFileMapper;  
	@Resource  
	private IUserBiz userBiz;
	@Autowired
	private IFileBiz fileBiz;
	                                                                  
	@Override                                                         
	public List<PubMeeting> searchPubMeeting() {
		PubMeetingExample example = new PubMeetingExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("meeting_date desc");
		return this.pubMeetingMapper.selectByExample(example);                                                  
	}                                                                 
                                                                      
	@Override                                                         
	public List<PubMeetingUser> searchPubMeetingUser() {  
		return null;                                      
	}

	@Override
	public List<PubMeetingFile> searchPubMeetingFile() {
		return null;
	}

	@Override
	public List<PubMeeting> searchPubMeetingByConditions(String startDate,String endDate, String meetingName,String meetingTypeId) {
		PubMeetingExample example = new PubMeetingExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(meetingName)){
			criteria.andMeetingNameLike("%"+meetingName+"%");
		}
		if(StringUtil.isNotBlank(startDate)){
			criteria.andMeetingDateGreaterThanOrEqualTo(startDate);
		}
		if(StringUtil.isNotBlank(endDate)){
			criteria.andMeetingDateLessThanOrEqualTo(endDate);
		}
		if(StringUtil.isNotBlank(meetingTypeId)){
			criteria.andMeetingTypeIdEqualTo(meetingTypeId);
		}
		example.setOrderByClause("MEETING_DATE");
		return pubMeetingMapper.selectByExample(example);
	}

	@Override
	public List<PubMeetingUser> searchPubMeetingUserByMeetingFlow(List<String> meetingFlows) {
		PubMeetingUserExample example = new PubMeetingUserExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andMeetingFlowIn(meetingFlows);
		return pubMeetingUserMapper.selectByExample(example);
	}

	@Override
	public List<PubMeetingFile> searchPubMeetingFileByMeetingFlow(List<String> meetingFlows) {
		PubMeetingFileExample example = new PubMeetingFileExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andMeetingFlowIn(meetingFlows);
		return pubMeetingFileMapper.selectByExample(example);
	}

	@Override
	public PubMeeting readPubMeeting(String meetingFlow) {
		return pubMeetingMapper.selectByPrimaryKey(meetingFlow);
	}

	@Override
	public PubMeetingUser readyPubMeetingUser(String recordFlow) {
		return pubMeetingUserMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public PubMeetingFile readPubMeetingFile(String recordFlow) {
		return pubMeetingFileMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public int savePubMeeting(PubMeeting meeting) {
		if(meeting != null){
			if(StringUtil.isNotBlank(meeting.getMeetingFlow())){
				return updateMeeting(meeting);
			}else{
				meeting.setMeetingFlow(PkUtil.getUUID());
				return saveMeeting(meeting);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private int saveMeeting(PubMeeting meeting){
		GeneralMethod.setRecordInfo(meeting,true);
		return pubMeetingMapper.insertSelective(meeting);
	}
	
	private int updateMeeting(PubMeeting meeting){
		GeneralMethod.setRecordInfo(meeting,false);
		return pubMeetingMapper.updateByPrimaryKeySelective(meeting);
	}

	@Override
	public int savePubMeetingUser(PubMeetingUser meetingUser) {
		if(meetingUser != null){
			if(StringUtil.isNotBlank(meetingUser.getRecordFlow())){
				GeneralMethod.setRecordInfo(meetingUser,false);
				return pubMeetingUserMapper.updateByPrimaryKeySelective(meetingUser);
			}else{
				meetingUser.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(meetingUser,true);
				return pubMeetingUserMapper.insertSelective(meetingUser);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int savePubMeetingFile(PubMeetingFile meetingFile) {
		if(meetingFile != null){
			if(StringUtil.isNotBlank(meetingFile.getFileFlow())){
				GeneralMethod.setRecordInfo(meetingFile,false);
				return pubMeetingFileMapper.updateByPrimaryKeySelective(meetingFile);
			}else{
				meetingFile.setFileFlow(PkUtil.getUUID());
				return saveMeetingFile(meetingFile);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	private int saveMeetingFile(PubMeetingFile meetingFile){
		GeneralMethod.setRecordInfo(meetingFile,true);
		return pubMeetingFileMapper.insertSelective(meetingFile);
	}
	
	@Override
	public int saveMeeting(MultipartFile[] files,String[] userFlow,PubMeeting meeting) throws Exception{
		if(meeting != null){
			int result = GlobalConstant.ZERO_LINE;
			if(StringUtil.isNotBlank(meeting.getMeetingFlow())){
				result = updateMeeting(meeting);
			}else{
				meeting.setMeetingFlow(PkUtil.getUUID());
				result = saveMeeting(meeting);
			}
			if(result != GlobalConstant.ZERO_LINE){
				if(userFlow != null && userFlow.length > 0){
					List<String> userFlows = new ArrayList<String>();
					for(String sUserFlow : userFlow){
						userFlows.add(sUserFlow);
					}
					List<SysUser> sysUserList = userBiz.searchSysUserByuserFlows(userFlows);
					PubMeetingUser meetingUserTemp = new PubMeetingUser();
					for(SysUser sysUser : sysUserList){
						meetingUserTemp.setRecordFlow("");
						meetingUserTemp.setUserFlow(sysUser.getUserFlow());
						meetingUserTemp.setUserName(sysUser.getUserName());
						meetingUserTemp.setMeetingFlow(meeting.getMeetingFlow());
						savePubMeetingUser(meetingUserTemp);
					}
				}
				if(files != null && files.length>0){
					for (int i=0;i<files.length;i++) {
						MultipartFile file = files[i];
						if(file!=null){
							String uuid = PkUtil.getUUID();
							String filename = file.getOriginalFilename();
							PubMeetingFile meetingFile = new PubMeetingFile();
							meetingFile.setFileFlow(uuid);
							meetingFile.setFileName(filename);
							meetingFile.setMeetingFlow(meeting.getMeetingFlow());
							
							PubFile pubFile = new PubFile();
							pubFile.setFileFlow(uuid);
							pubFile.setFileName(filename);
							String suffix = filename.substring(filename.lastIndexOf(".")+1);
							pubFile.setFileContent(file.getBytes());
							pubFile.setFileSuffix(suffix);
							
							saveMeetingFile(meetingFile);
							fileBiz.saveFile(pubFile);
						}
					}
				}
				return GlobalConstant.ONE_LINE;
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delMeetingFiles(List<String> fileFlows){
		if(fileFlows != null && fileFlows.size()>0){
			PubMeetingFile meetingFile = new PubMeetingFile();
			meetingFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			PubFile pubFile = new PubFile();
			pubFile.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			for(String fileFlow : fileFlows){
				meetingFile.setFileFlow(fileFlow);
				pubFile.setFileFlow(fileFlow);
				savePubMeetingFile(meetingFile);
				fileBiz.editFile(pubFile);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int delPubMeeting(String meetingFlow){
		if(StringUtil.isNotBlank(meetingFlow)){
			List<String> meetingFlowList = new ArrayList<String>();
			meetingFlowList.add(meetingFlow);
			PubMeeting meeting = new PubMeeting();
			meeting.setMeetingFlow(meetingFlow);
			meeting.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			savePubMeeting(meeting);
			
			PubMeetingUser meetingUser = new PubMeetingUser();
			meetingUser.setRecordStatus(meeting.getRecordStatus());
			PubMeetingUserExample userExample = new PubMeetingUserExample();
			userExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andMeetingFlowEqualTo(meetingFlow);
			pubMeetingUserMapper.updateByExampleSelective(meetingUser,userExample);
			
			List<PubMeetingFile> meetingFileList = searchPubMeetingFileByMeetingFlow(meetingFlowList);
			if(meetingFileList != null && meetingFileList.size()>0){
				List<String> fileFlows = new ArrayList<String>();
				for(PubMeetingFile meetingFileTemp : meetingFileList){
					fileFlows.add(meetingFileTemp.getFileFlow());
				}
				delMeetingFiles(fileFlows);
			}
			
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}
}
