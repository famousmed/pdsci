package com.pinde.sci.biz.job;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.PubMsgMapper;
import com.pinde.sci.enums.sys.MsgTypeEnum;
import com.pinde.sci.model.mo.PubMsg;
import com.pinde.sci.model.mo.PubMsgExample;

@Component 
@Transactional(rollbackFor=Exception.class)
public class WeiXinSendJobBizImpl {
	private static Logger logger = LoggerFactory.getLogger(WeiXinSendJobBizImpl.class);
	@Resource
	private PubMsgMapper pubMsgMapper;
	
	@Value("#{configProperties['thread.switch']}") 
	private String threadSwitch;

	@Scheduled(cron="*/10 * * * * *") 
	public void doJob() {
//		logger.debug("starting WeiXinSendJobBizImpl doJob.....");
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch)  || !StringUtil.isEquals(InitConfig.getSysCfg("sys_weixin_qiye_flag"), GlobalConstant.FLAG_Y)){
			return;
		}	
		String maxErrorTimes = StringUtil.defaultIfEmpty(InitConfig.getSysCfg("sys_mail_max_error_times"),"5").trim();
		Integer iMaxErrorTimes = Integer.valueOf(maxErrorTimes);
		PubMsgExample example = new PubMsgExample();
		PubMsgExample.Criteria criteria = example.createCriteria();
		criteria.andMsgTypeIdEqualTo(MsgTypeEnum.Weixin.getId());
		criteria.andSendFlagEqualTo(GlobalConstant.FLAG_N).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("CREATE_TIME");
		
		List<PubMsg> pubMsgList = pubMsgMapper.selectByExample(example);
		for(PubMsg pubMsg : pubMsgList){
			pubMsg = pubMsgMapper.selectByPrimaryKey(pubMsg.getMsgFlow());
			try {
				String response = WeixinQiYeUtil.sendMsg(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_app_id"), pubMsg.getReceiver(), pubMsg.getMsgContent());
				Map responseMap = JSON.parseObject(response, Map.class);
				Integer errcode = (Integer)responseMap.get("errcode");
				if(errcode==0){
					pubMsg.setSendResult("发送成功");
					pubMsg.setSendFlag(GlobalConstant.FLAG_Y);	
					pubMsg.setSender(StringUtil.defaultString(InitConfig.getSysCfg("sys_weixin_qiye_app_id")));
					pubMsg.setSendTime(DateUtil.getCurrDateTime());
				}else{
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
					String errmsg = (String)responseMap.get("errmsg");
					pubMsg.setSendResult("发送失败:"+errmsg);
				}
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
