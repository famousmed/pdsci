package com.pinde.sci.biz.job;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Flags;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeUtility;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.sys.ICfgBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.enums.pub.WeixinStatusEnum;
import com.pinde.sci.model.mo.SysCfg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.sun.mail.imap.IMAPMessage;

@Component 
@Transactional(rollbackFor=Exception.class)

public class WeiXinEmailAlertJobBizImpl {
	
	private static Logger logger = LoggerFactory.getLogger(WeiXinEmailAlertJobBizImpl.class);
	
	@Resource
	private SysUserMapper sysUserMapper;
	@Autowired
	private ICfgBiz cfgBiz;
	@Resource
	private IMsgBiz msgBiz;
	
	@Value("#{configProperties['weixin.email.alert.switch']}") 
	private String weixinEmailAlertSwitch;

	@Scheduled(fixedDelay=60000)
	public void doJob() {
		try {
//			logger.debug("start WeiXinEmailAlertJobBizImpl doJob..................................");
			if(!GlobalConstant.FLAG_Y.equals(weixinEmailAlertSwitch) || !StringUtil.isEquals(InitConfig.getSysCfg("sys_weixin_qiye_flag"), GlobalConstant.FLAG_Y)){
				return;
			}	
			SysUserExample example = new SysUserExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<SysUser> sysUserList = sysUserMapper.selectByExample(example);
			Map<String,String> emailMap = new HashMap<String, String>();
			for(SysUser sysUser : sysUserList){
				emailMap.put(sysUser.getUserEmail(), sysUser.getUserName());
			}
			for(SysUser sysUser : sysUserList){
				logger.debug(sysUser.getUserEmail()+" imp4 mails ......");
				//锁定的不处理
				if(StringUtil.isNotEquals(UserStatusEnum.Activated.getId(),sysUser.getStatusId())){
					continue;
				}
				//没有关注的不处理
				if(StringUtil.isNotEquals(WeixinStatusEnum.Status1.getId(),sysUser.getWeiXinStatusId())){
					continue;
				}
				//没登记邮箱的不处理
				if(StringUtil.isBlank(sysUser.getUserEmail())){
					continue;
				}
				SysCfg cfg = cfgBiz.read(sysUser.getUserEmail());
				if(cfg!=null && GlobalConstant.RECORD_STATUS_N.equals(cfg.getRecordStatus())){
					continue;
				}
			    try {
					// 准备连接服务器的会话信息 
					Properties props = new Properties(); 
					props.setProperty("mail.store.protocol", "imap"); 
					props.setProperty("mail.imap.host", "localhost"); 
					props.setProperty("mail.imap.port", "143"); 

					// 创建Session实例对象 
					Session session = Session.getInstance(props); 

					// 创建IMAP协议的Store对象 
					Store store = session.getStore("imap"); 
					// 连接邮件服务器 
					String mailPasswd = sysUser.getUserCode()+"12345";
					if(cfg!=null){
						mailPasswd = cfg.getCfgValue();
					}else{
						cfg=new SysCfg();
						cfg.setCfgCode(sysUser.getUserEmail());
						cfg.setCfgValue(mailPasswd);
						cfg.setCfgDesc("品德邮箱密码");
						cfg.setWsId("mail");
						cfg.setWsName("");
						cfg.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
						cfgBiz.add(cfg);
					}
					
					try {
						store.connect(sysUser.getUserEmail(), mailPasswd);
					} catch (Exception e) {
						logger.debug(sysUser.getUserEmail()+" with passwod :"+mailPasswd+" maybe error");
//						cfg.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
//						cfgBiz.mod(cfg);
						continue;
					} 

					// 获得收件箱 
					Folder folder = store.getFolder("INBOX"); 
					// 以读写模式打开收件箱 
					folder.open(Folder.READ_WRITE); 

					// 获得收件箱的邮件列表 
					Message[] messages = folder.getMessages(); 

					// 解析邮件 
					for (Message message : messages) { 
					    IMAPMessage msg = (IMAPMessage) message; 
					    
					    Flags flags = message.getFlags();  
					    if (flags.contains(Flags.Flag.SEEN)) {
					    	
						}else {    
					        String subject = MimeUtility.decodeText(msg.getSubject()); 
					        InternetAddress sender = (InternetAddress) msg.getSender();
					        String senderName = StringUtil.defaultIfEmpty(emailMap.get(sender.getPersonal()), sender.getPersonal());
					        msgBiz.addWeixinMsg(sysUser.getUserFlow(), null, senderName+"给你发送了一份邮件,邮件主题："+StringUtil.defaultString(subject)+","+"发送时间：" + DateUtil.formatDate(msg.getSentDate(), DateUtil.defDtPtn02)+",请注意查收！");
					        msg.setFlag(Flag.SEEN, true);   //设置已读标志 
					    }    
					} 

					// 关闭资源 
					folder.close(false); 
					store.close();
				} catch (Exception e) {
					logger.debug(sysUser.getUserEmail()+" some error happen:"+e.getMessage());
					e.printStackTrace();
				} 
			
			}
		} catch (Exception e) {
			logger.debug("imp4 email some error happen:"+e.getMessage());
			e.printStackTrace();
		}
		logger.debug("end WeiXinEmailAlertJobBizImpl doJob..................................");
	}

}
