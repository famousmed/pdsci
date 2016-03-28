package com.pinde.sci.biz.pub.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubMsgMapper;
import com.pinde.sci.enums.sys.MsgTypeEnum;
import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.PubMsgExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class MsgBizImpl implements IMsgBiz {

	@Resource
	private PubMsgMapper pubMsgMapper;

	@Override
	public void addEmailMsg(String receiver,String title,String content){
		PubMsg msg = new PubMsg();
		String msgFlow = PkUtil.getUUID();
		msg.setMsgFlow(msgFlow);
		msg.setMsgCode(msgFlow);
		msg.setMsgTypeId(MsgTypeEnum.Email.getId());
		msg.setMsgTypeName(MsgTypeEnum.Email.getName());
		msg.setMsgTime(DateUtil.getCurrDateTime());
		msg.setMsgTitle(StringUtil.defaultString(title));
		msg.setMsgContent(StringUtil.defaultString(content));
		msg.setReceiver(receiver);
		msg.setSendFlag(GlobalConstant.FLAG_N);
		GeneralMethod.setRecordInfo(msg, true);		
		pubMsgMapper.insert(msg);
	}

	@Override
	public void addSmsMsg(String receiver,String content){
		PubMsg msg = new PubMsg();
		String msgFlow = PkUtil.getUUID();
		msg.setMsgFlow(msgFlow);
		msg.setMsgCode(msgFlow);
		msg.setMsgTypeId(MsgTypeEnum.Sms.getId());
		msg.setMsgTypeName(MsgTypeEnum.Sms.getName());
		msg.setMsgTime(DateUtil.getCurrDateTime());
		msg.setMsgTitle("");
		msg.setMsgContent(StringUtil.defaultString(content));
		msg.setReceiver(receiver);
		msg.setSendFlag(GlobalConstant.FLAG_N);
		GeneralMethod.setRecordInfo(msg, true);		
		pubMsgMapper.insert(msg);
	}

	@Override
	public void addSysMsg(String receiver,String title,String content){
		PubMsg msg = new PubMsg();
		String msgFlow = PkUtil.getUUID();
		msg.setMsgFlow(msgFlow);
		msg.setMsgCode(msgFlow);
		msg.setMsgTypeId(MsgTypeEnum.Sys.getId());
		msg.setMsgTypeName(MsgTypeEnum.Sys.getName());
		msg.setMsgTime(DateUtil.getCurrDateTime());
		msg.setMsgTitle(StringUtil.defaultString(title));
		msg.setMsgContent(StringUtil.defaultString(content));
		msg.setReceiver(receiver);
		msg.setSendFlag(GlobalConstant.FLAG_N);
		GeneralMethod.setRecordInfo(msg, true);		
		pubMsgMapper.insert(msg);
	}

	@Override
	public void addWeixinMsg(String receiver, String title, String content) {
		PubMsg msg = new PubMsg();
		String msgFlow = PkUtil.getUUID();
		msg.setMsgFlow(msgFlow);
		msg.setMsgCode(msgFlow);
		msg.setMsgTypeId(MsgTypeEnum.Weixin.getId());
		msg.setMsgTypeName(MsgTypeEnum.Weixin.getName());
		msg.setMsgTime(DateUtil.getCurrDateTime());
		msg.setMsgTitle(StringUtil.defaultString(title));
		msg.setMsgContent(StringUtil.defaultString(content));
		msg.setReceiver(receiver);
		msg.setSendFlag(GlobalConstant.FLAG_N);
		GeneralMethod.setRecordInfo(msg, true);		
		pubMsgMapper.insert(msg);
		
	}

	@Override
	public Integer countErrorMsg(String msgType) {
		PubMsgExample example = new PubMsgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andMsgTypeIdEqualTo(msgType).andSendFlagEqualTo(GlobalConstant.FLAG_N);
		return pubMsgMapper.countByExample(example);
	}

	@Override
	public List<PubMsg> searchMessage(PubMsgExample example) {
		return pubMsgMapper.selectByExample(example);
	}
	
	@Override
	public List<PubMsg> searchMessageWithBLOBs(PubMsgExample example) {
		return pubMsgMapper.selectByExampleWithBLOBs(example);
	}

	@Override
	public PubMsg readMsg(String msgFlow) {
		return pubMsgMapper.selectByPrimaryKey(msgFlow); 
	}
	
	@Override
	public int updateMsg(PubMsg msg){
		GeneralMethod.setRecordInfo(msg, false);
		return pubMsgMapper.updateByPrimaryKeySelective(msg);
	}

}
