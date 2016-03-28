package com.pinde.sci.biz.erp.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.erp.IErpOaLicKeyBiz;
import com.pinde.sci.dao.base.ErpOaLicKeyMapper;
import com.pinde.sci.model.mo.ErpOaLicKey;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpOaLicKeyBizImpl implements IErpOaLicKeyBiz{

	@Autowired
	private ErpOaLicKeyMapper licKeyMapper;
	
	@Override
	public ErpOaLicKey readLicKey(String licFlow) {
		return licKeyMapper.selectByPrimaryKey(licFlow);
	}
    
	
}
