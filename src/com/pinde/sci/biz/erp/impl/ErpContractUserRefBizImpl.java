package com.pinde.sci.biz.erp.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractUserRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractUserRefMapper;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmContractUserRefExample;
import com.pinde.sci.model.mo.ErpCrmContractUserRefExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContractUserRefBizImpl implements IErpContractUserRefBiz{

	@Autowired
	private ErpCrmContractUserRefMapper userRefMapper;

	
	@Override
	public List<ErpCrmContractUserRef> searchContractUserRefList(
			ErpCrmContractUserRef ref) {
		ErpCrmContractUserRefExample example=new ErpCrmContractUserRefExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(ref.getUserRecordFlow())){
			criteria.andUserRecordFlowEqualTo(ref.getUserRecordFlow());
		}
		if(StringUtil.isNotBlank(ref.getUserFlow())){
			criteria.andUserFlowEqualTo(ref.getUserFlow());
		}
		if(StringUtil.isNotBlank(ref.getContractFlow())){
			criteria.andContractFlowEqualTo(ref.getContractFlow());
		}
		if(StringUtil.isNotBlank(ref.getProductFlow())){
			criteria.andProductFlowEqualTo(ref.getProductFlow());
		}
		if(StringUtil.isNotBlank(ref.getUserCategoryId())){
			criteria.andUserCategoryIdEqualTo(ref.getUserCategoryId());
		}
		example.setOrderByClause("CREATE_TIME");
		return this.userRefMapper.selectByExample(example);
	}

	@Override
	public int saveContractUserRef(ErpCrmContractUserRef userRef) {
		if(StringUtil.isNotBlank(userRef.getRecordFlow())){
			GeneralMethod.setRecordInfo(userRef, false);
			return this.userRefMapper.updateByPrimaryKeySelective(userRef);
		}else{
			userRef.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(userRef, true);
			return this.userRefMapper.insertSelective(userRef);
		}
	}

	@Override
	public ErpCrmContractUserRef readContractUserRef(String recordFlow) {
	    return this.userRefMapper.selectByPrimaryKey(recordFlow);
	}
	
}
