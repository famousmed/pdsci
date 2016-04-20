package com.pinde.sci.biz.job;

import java.rmi.RemoteException;
import java.util.List;

import javax.annotation.Resource;
import javax.xml.rpc.ServiceException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.tempuri.WmgwLocator;

import com.pinde.core.page.PageHelper;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubMsgMapper;
import com.pinde.sci.enums.sys.MsgTypeEnum;
import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.PubMsgExample;

@Component 
@Transactional(rollbackFor=Exception.class)
public class SmsSendJobBizImpl {
	
	private static Logger logger = LoggerFactory.getLogger(SmsSendJobBizImpl.class);
	@Resource
	private PubMsgMapper pubMsgMapper;
	@Resource
	private PubFileMapper pubFileMapper;

	@Value("#{configProperties['smsThread.switch']}") 
	private String smsThreadSwitch;
	
	private WmgwLocator wmgwLocator = null;
	
	String strArgs[] = new String[10];
	
	public SmsSendJobBizImpl(){
		_init();
	}
	
	private void _init(){
		if(wmgwLocator==null){
			try {
				wmgwLocator = new WmgwLocator();
				strArgs[0] = "JC2157";		//帐号
				strArgs[1] = "766253";		//密码
				strArgs[2] = "15252452508";//手机号
				strArgs[3] = "测试短信";	//测试信息
				strArgs[4] = "1";			//手机个数
				strArgs[5] = "8";			//子端口 
				//String strMsg = new String(strArgs[3].getBytes("UTF-8"));//web服务端只接受UTF—8方式的编码
			}catch (Throwable e) {
				e.printStackTrace();
				wmgwLocator = null;
			}
		}
	}
	
	@Scheduled(cron="*/10 * * * * *") 
	public void doJob() {
		
		if(!GlobalConstant.FLAG_Y.equals(smsThreadSwitch) 
				|| !StringUtil.isEquals(InitConfig.getSysCfg("sys_sysSmsSendJob"), GlobalConstant.FLAG_Y)
				){
			return;
		}
		logger.info("doJob sendSms ...");
		String maxErrorTimes = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("sys_mail_max_error_times"),"5").trim();
		Integer iMaxErrorTimes = Integer.valueOf(maxErrorTimes);
		PubMsgExample example = new PubMsgExample();
		PubMsgExample.Criteria criteria = example.createCriteria();
		criteria.andMsgTypeIdEqualTo(MsgTypeEnum.Sms.getId());
		criteria.andSendFlagEqualTo(GlobalConstant.FLAG_N).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("SEND_ERROR_TIMES,CREATE_TIME");
		
		PageHelper.startPage(1, 10);
		
		List<PubMsg> pubMsgList = pubMsgMapper.selectByExample(example);
		for(PubMsg pubMsg : pubMsgList){
			pubMsg = pubMsgMapper.selectByPrimaryKey(pubMsg.getMsgFlow());
			if(StringUtil.isBlank(pubMsg.getReceiver())){
				continue;
			}
			try {
				_init();
//				发短信
				try {
					logger.info("Test mongateCsSendSmsExNew ...");
					String result = wmgwLocator.getwmgwSoap().mongateCsSpSendSmsNew(strArgs[0],
							strArgs[1], pubMsg.getReceiver(),  pubMsg.getMsgContent(), Integer.valueOf(strArgs[4]).intValue(),strArgs[5]);	
					logger.info("back value is :"+ result);
					logger.info("send mongateCsSendSmsExNew end !");
					
					if(result.length()>10){
						pubMsg.setSendResult("发送成功");
						pubMsg.setSendFlag(GlobalConstant.FLAG_Y);	
						//pubMsg.setSender(StringUtil.defaultString(InitConfig.getSysCfg("sys_mail_from")));
						pubMsg.setSendTime(DateUtil.getCurrDateTime());
					}else {
						Integer errorTimes = pubMsg.getSendErrorTimes();
						if(errorTimes==null){
							errorTimes = new Integer(0);
						}
						errorTimes++;				
						pubMsg.setSendErrorTimes(errorTimes);
						
						if(errorTimes>iMaxErrorTimes){
							pubMsg.setSendFlag(GlobalConstant.FLAG_F);	
						}else{
							pubMsg.setSendFlag(GlobalConstant.FLAG_N);	
						}
						pubMsg.setSendResult("back value is :"+ result);
					}
					
					Thread.sleep(10000);
				} catch (RemoteException e) {
					e.printStackTrace();
				} catch (ServiceException e) {
					e.printStackTrace();
				}
//			
				
			} catch (Exception e) {
				e.printStackTrace();
				
				Integer errorTimes = pubMsg.getSendErrorTimes();
				if(errorTimes==null){
					errorTimes = new Integer(0);
				}
				errorTimes++;				
				pubMsg.setSendErrorTimes(errorTimes);
				
				if(errorTimes>iMaxErrorTimes){
					pubMsg.setSendFlag(GlobalConstant.FLAG_F);	
				}else{
					pubMsg.setSendFlag(GlobalConstant.FLAG_N);	
				}
				pubMsg.setSendResult("发送失败:"+e.getMessage());
				
			}
			
			pubMsgMapper.updateByPrimaryKeySelective(pubMsg);
			
		}
		
	}

}
