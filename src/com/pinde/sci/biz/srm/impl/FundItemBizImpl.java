package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundItemBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmFundItemMapper;
import com.pinde.sci.model.mo.SrmFundItem;
import com.pinde.sci.model.mo.SrmFundItemExample;
import com.pinde.sci.model.mo.SrmFundItemExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class FundItemBizImpl implements IFundItemBiz {
	@Resource
	private SrmFundItemMapper srmFundItemMapper;
	@Override
	public SrmFundItem readFundItem(String itemFlow) {
		return srmFundItemMapper.selectByPrimaryKey(itemFlow);
	}

	@Override
	public int saveFundItem(SrmFundItem item) {
		if(StringUtil.isNotBlank(item.getItemFlow())){
			GeneralMethod.setRecordInfo(item, false);//方法调用显示记录状态
			return srmFundItemMapper.updateByPrimaryKeySelective(item);
		}else{
			item.setItemFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(item, true);
			return srmFundItemMapper.insert(item);
		}
	}
	
	@Override
	public List<SrmFundItem> searchFundItem(SrmFundItem item) {
		SrmFundItemExample example=new SrmFundItemExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(item.getItemFlow())){
			criteria.andItemFlowEqualTo(item.getItemFlow());
		}
		if(StringUtil.isNotBlank(item.getItemName())){
			criteria.andItemNameLike("%"+item.getItemName()+"%");
		}
		return srmFundItemMapper.selectByExample(example);
	}
}	
