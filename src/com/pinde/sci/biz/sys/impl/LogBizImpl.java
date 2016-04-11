package com.pinde.sci.biz.sys.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.ILogBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SysLogMapper;
import com.pinde.sci.dao.sys.SysLogExtMapper;
import com.pinde.sci.model.mo.SysLog;
import com.pinde.sci.model.mo.SysLogExample;
import com.pinde.sci.model.mo.SysLogExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class LogBizImpl implements ILogBiz {

	@Autowired
	private SysLogMapper logMapper;
	@Autowired
	private SysLogExtMapper logExtMapper;
	
	
	@Override
	public List<SysLog> searcherLog(SysLog log){
		SysLogExample logExample = new SysLogExample();
		Criteria criteria = logExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(log.getResourceFlow())) {
			criteria.andResourceFlowEqualTo(log.getResourceFlow());
		}
		logExample.setOrderByClause("log_time desc");
		return logMapper.selectByExample(logExample);
	}
	
	@Override
	public List<SysLog> searchLog(Map<String,Object> paramMap){
		return logExtMapper.searchLog(paramMap);
	}
	
}
