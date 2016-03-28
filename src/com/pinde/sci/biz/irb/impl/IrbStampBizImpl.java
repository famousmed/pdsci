package com.pinde.sci.biz.irb.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbStampBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.IrbStampMapper;
import com.pinde.sci.model.mo.IrbStamp;
import com.pinde.sci.model.mo.IrbStampExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbStampBizImpl implements IIrbStampBiz {
	@Resource
	private IrbStampMapper stampMapper;
	
	@Override
	public List<IrbStamp> queryStampList(IrbStamp stamp,String stampEndDate) {
		IrbStampExample example = new IrbStampExample();
		com.pinde.sci.model.mo.IrbStampExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotEmpty(stamp.getProjName())){
			criteria.andProjNameLike("%" + stamp.getProjName() +"%");
		}
		if(StringUtil.isNotEmpty(stamp.getStampDate())){
			criteria.andStampDateGreaterThanOrEqualTo(stamp.getStampDate());
		}
		if(StringUtil.isNotEmpty(stampEndDate)){
			criteria.andStampDateLessThanOrEqualTo(stampEndDate);
		}
		return stampMapper.selectByExample(example);
	}

	@Override
	public int saveStamp(IrbStamp stamp) {
		if(null != stamp){
			if(StringUtil.isNotEmpty(stamp.getStampFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(stamp, false);
				stampMapper.updateByPrimaryKeySelective(stamp);
			}else{//ÐÂÔö
				stamp.setStampFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(stamp, true);
				stampMapper.insert(stamp);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public IrbStamp getStampByFlow(String stampFlow) {
		if(StringUtil.isNotBlank(stampFlow)){
			return stampMapper.selectByPrimaryKey(stampFlow);
		}
		return null;
	}

}
