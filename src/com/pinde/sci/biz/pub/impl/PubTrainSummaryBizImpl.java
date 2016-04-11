package com.pinde.sci.biz.pub.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.biz.pub.IPubTrainSummaryBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubTrainSummaryMapper;
import com.pinde.sci.enums.irb.IrbTrainCategoryEnum;
import com.pinde.sci.enums.irb.IrbTrainTypeEnum;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainSummary;
import com.pinde.sci.model.mo.PubTrainSummaryExample;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class PubTrainSummaryBizImpl implements IPubTrainSummaryBiz {
	
	@Resource
	private PubTrainSummaryMapper summaryMapper;
	@Autowired
	private IPubTrainBiz pubTrainBiz;

	@Override
	public int save(PubTrainSummary summary) {
		summary.setOperTime(DateUtil.getCurrDateTime());
		SysUser currUser = GlobalContext.getCurrentUser();
		summary.setOperUserFlow(currUser.getUserFlow());
		summary.setOperUserName(currUser.getUserName());
		
		if(StringUtil.isNotBlank(summary.getRecordFlow())){//ÐÞ¸Ä
			GeneralMethod.setRecordInfo(summary, false);
			return summaryMapper.updateByPrimaryKeySelective(summary);
		}else{//ÐÂÔö
			summary.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(summary, true);
			return summaryMapper.insert(summary);
		}
	}

	@Override
	public List<PubTrainSummary> searchSummaryList() {
		PubTrainSummaryExample example = new PubTrainSummaryExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("CREATE_TIME DESC");
		return summaryMapper.selectByExample(example);
	}

	@Override
	public PubTrainSummary readSummary(String recordFlow) {
		return summaryMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public Map<String, Integer> countTrain(String year) {
		Map<String, Integer> countMap = null;
		if(StringUtil.isNotBlank(year)){
			countMap = new HashMap<String, Integer>();
			for (IrbTrainCategoryEnum cEunum : IrbTrainCategoryEnum.values()) {
				PubTrain train = new PubTrain();
				train.setTrainDate(year);
				train.setTrainCategoryId(cEunum.getId());
				int count  = this.pubTrainBiz.countTrain(train);
				countMap.put(cEunum.getId(), count);
			}
			for (IrbTrainTypeEnum cEunum : IrbTrainTypeEnum.values()) {
				PubTrain train = new PubTrain();
				train.setTrainDate(year);
				train.setTrainTypeId(cEunum.getId());
				int count  = this.pubTrainBiz.countTrain(train);
				countMap.put(cEunum.getId(), count);
			}
		}
		return countMap;
	}

}
