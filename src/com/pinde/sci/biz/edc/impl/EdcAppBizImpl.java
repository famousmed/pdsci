package com.pinde.sci.biz.edc.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.edc.IEdcAppBiz;
import com.pinde.sci.dao.base.EdcAppLogMapper;
import com.pinde.sci.model.mo.EdcAppLog;

@Service
@Transactional(rollbackFor=Exception.class)
public class EdcAppBizImpl implements IEdcAppBiz{

	@Resource
	private EdcAppLogMapper appLogMapper;
	
	@Override
	public void add(EdcAppLog applog) {
		appLogMapper.insert(applog);
	}
 
}  
  