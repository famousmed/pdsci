package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IGradeItemBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmGradeItemMapper;
import com.pinde.sci.model.mo.SrmGradeItem;
import com.pinde.sci.model.mo.SrmGradeItemExample;
import com.pinde.sci.model.mo.SrmGradeItemExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class GradeItemBizImpl implements IGradeItemBiz {
	@Resource
	private SrmGradeItemMapper srmGradeItemMapper;
	
	@Override
	public SrmGradeItem readGradeItem(String schemeFlow) {
		return srmGradeItemMapper.selectByPrimaryKey(schemeFlow);
	}
	@Override
	public int saveGradeItem(SrmGradeItem item) {
		if(StringUtil.isNotBlank(item.getItemFlow())){
			GeneralMethod.setRecordInfo(item, false);
			return srmGradeItemMapper.updateByPrimaryKeySelective(item);
		}else{
			item.setItemFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(item, true);
			return srmGradeItemMapper.insert(item);
		}
	}

	@Override
	public List<SrmGradeItem> searchGradeItem(SrmGradeItem item) {
		SrmGradeItemExample example=new SrmGradeItemExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(item.getItemName())){
			criteria.andItemNameLike("%"+item.getItemName()+"%");
		}
		if(StringUtil.isNotBlank(item.getSchemeFlow())){
			criteria.andSchemeFlowEqualTo(item.getSchemeFlow());
		}
		example.setOrderByClause("ORDINAL");
		return srmGradeItemMapper.selectByExample(example);
	}
	
	
}
