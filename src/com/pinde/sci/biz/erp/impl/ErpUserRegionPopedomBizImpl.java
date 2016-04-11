package com.pinde.sci.biz.erp.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpUserRegionPopedomBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpUserRegionPopedomMapper;
import com.pinde.sci.model.mo.ErpUserRegionPopedom;
import com.pinde.sci.model.mo.ErpUserRegionPopedomExample;
import com.pinde.sci.model.mo.ErpUserRegionPopedomExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpUserRegionPopedomBizImpl implements IErpUserRegionPopedomBiz{

	@Autowired
	private ErpUserRegionPopedomMapper popedomMapper;
	
	@Override
	public List<ErpUserRegionPopedom> searchRegionPopList(
			ErpUserRegionPopedom regPop) {
		ErpUserRegionPopedomExample example=new ErpUserRegionPopedomExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(regPop!=null){
			if(StringUtil.isNotBlank(regPop.getUserFlow())){
				criteria.andUserFlowEqualTo(regPop.getUserFlow());
			}
			return popedomMapper.selectByExample(example);
		}
		return null;
	}
     
}
