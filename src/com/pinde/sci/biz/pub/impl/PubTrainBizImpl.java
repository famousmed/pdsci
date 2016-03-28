package com.pinde.sci.biz.pub.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubTrainBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubFileMapper;
import com.pinde.sci.dao.base.PubTrainMapper;
import com.pinde.sci.dao.base.PubTrainUserMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.model.mo.PubTrain;
import com.pinde.sci.model.mo.PubTrainExample;
import com.pinde.sci.model.mo.PubTrainExample.Criteria;
/**
 * 
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class PubTrainBizImpl implements IPubTrainBiz {
	@Resource
	private PubTrainMapper trainMapper;
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	private PubTrainUserMapper trainUserMapper;
	@Resource
	private PubFileMapper fileMapper;

	@Override
	public PubTrain getTrainByFlow(String trainFlow) {
		return trainMapper.selectByPrimaryKey(trainFlow);
	}

	@Override
	public int saveTrain(PubTrain train) {
		if(null != train){
			if(StringUtil.isNotBlank(train.getTrainFlow())){
				GeneralMethod.setRecordInfo(train, false);
				trainMapper.updateByPrimaryKeySelective(train);
			}else{
				train.setTrainFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(train, true);
				trainMapper.insert(train);
			}
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public int deleteTrain(PubTrain train) {
		if(StringUtil.isNotBlank(train.getTrainFlow())){
			train.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(train, false);
			trainMapper.updateByPrimaryKeySelective(train);
			return GlobalConstant.ONE_LINE;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<PubTrain> queryTrainList(PubTrain train,String endTrainDate,List<String> trainFlows) {
		PubTrainExample example = new PubTrainExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(null != train){
			if(StringUtil.isNotBlank(train.getTrainCategoryId())){
				criteria.andTrainCategoryIdEqualTo(train.getTrainCategoryId());
			}
			String trainDate = train.getTrainDate();
			if(StringUtil.isNotBlank(trainDate)){
				if(trainDate.length()==4){
					criteria.andTrainDateLike(trainDate+"-%");
				}else{
					criteria.andTrainDateGreaterThanOrEqualTo(trainDate);
				}
			}
			if(StringUtil.isNotBlank(train.getTrainTypeId())){
				criteria.andTrainTypeIdEqualTo(train.getTrainTypeId());
			}
			if(StringUtil.isNotBlank(train.getTrainCategoryId())){
				criteria.andTrainCategoryIdEqualTo(train.getTrainCategoryId());
			}
			if(StringUtil.isNotBlank(train.getTrainTypeId())){
				criteria.andTrainTypeIdEqualTo(train.getTrainTypeId());
			}
		}
		if(StringUtil.isNotBlank(endTrainDate)){
			criteria.andTrainDateLessThanOrEqualTo(endTrainDate);
		}
		if(null != trainFlows && !trainFlows.isEmpty()){
			criteria.andTrainFlowIn(trainFlows);
		}
		example.setOrderByClause("TRAIN_DATE DESC, TRAIN_CATEGORY_NAME");
		return trainMapper.selectByExample(example);
	}

	@Override
	public List<PubTrain> searchList(PubTrain train) {
		PubTrainExample example = new PubTrainExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(train!=null){
			if(StringUtil.isNotBlank(train.getTrainCategoryId())){
				criteria.andTrainCategoryIdEqualTo(train.getTrainCategoryId());
			}
			if(StringUtil.isNotBlank(train.getTrainTypeId())){
				criteria.andTrainTypeIdEqualTo(train.getTrainTypeId());
			}
			String trainDate = train.getTrainDate();
			if(StringUtil.isNotBlank(trainDate)){
				if(trainDate.length()==4){
					criteria.andTrainDateLike(trainDate+"-%");
				}else{
					criteria.andTrainDateGreaterThanOrEqualTo(trainDate);
				}
			}
		}
		example.setOrderByClause("train_date desc");
		return this.trainMapper.selectByExample(example);
	}

	@Override
	public int countTrain(PubTrain train) {
		PubTrainExample example = new PubTrainExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(train!=null){
			if(StringUtil.isNotBlank(train.getTrainCategoryId())){
				criteria.andTrainCategoryIdEqualTo(train.getTrainCategoryId());
			}
			if(StringUtil.isNotBlank(train.getTrainTypeId())){
				criteria.andTrainTypeIdEqualTo(train.getTrainTypeId());
			}
			String trainDate = train.getTrainDate();
			if(StringUtil.isNotBlank(trainDate)){
				if(trainDate.length()==4){
					criteria.andTrainDateLike(trainDate+"-%");
				}else{
					criteria.andTrainDateGreaterThanOrEqualTo(trainDate);
				}
			}
		}
		return this.trainMapper.countByExample(example);
	}
}
