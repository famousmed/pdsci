package com.pinde.sci.biz.job;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.common.util.WeixinQiYeUtil;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;

@Component 
@Transactional(rollbackFor=Exception.class)

public class WeiXinStatusJobBizImpl {
	private static Logger logger = LoggerFactory.getLogger(WeiXinStatusJobBizImpl.class);
	
	@Resource
	private SysUserMapper sysUserMapper;
	
	@Value("#{configProperties['thread.switch']}") 
	private String threadSwitch;

	@Scheduled(cron="0 0 6,12,18 * * ?") //正式用
//	@Scheduled(cron="*/10 * * * * *") //临时用
	public void doJob() {
//		logger.debug("starting WeiXinStatusJobBizImpl doJob.....");
		if(!GlobalConstant.FLAG_Y.equals(threadSwitch) || !StringUtil.isEquals(InitConfig.getSysCfg("sys_weixin_qiye_flag"), GlobalConstant.FLAG_Y)){
			return;
		}	
		List<SysUser> sysUserList = WeixinQiYeUtil.getDeptUser(InitConfig.getSysCfg("sys_weixin_qiye_corp_id"), InitConfig.getSysCfg("sys_weixin_qiye_secret"), InitConfig.getSysCfg("sys_weixin_qiye_dept_id"));
		for(SysUser sysUser : sysUserList){
			sysUserMapper.updateByPrimaryKeySelective(sysUser);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
		}
	}

}
