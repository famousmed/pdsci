package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.PubMsgExample;


public interface IMsgBiz {

//	public void addEdcInviteMsg(SysUser user);

	public void addEmailMsg(String receiver, String title, String content);

	public void addSmsMsg(String receiver, String content);

	public void addSysMsg(String receiver, String title, String content);

	public void addWeixinMsg(String receiver, String title, String content);

	public Integer countErrorMsg(String msgType);

	public List<PubMsg> searchMessage(PubMsgExample example);

	public PubMsg readMsg(String msgFlow);

	List<PubMsg> searchMessageWithBLOBs(PubMsgExample example);

	int updateMsg(PubMsg msg); 

}
