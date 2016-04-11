package com.pinde.sci.biz.jsres.impl;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.jsres.IResOrgSpeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.dao.base.ResOrgSpeMapper;
import com.pinde.sci.enums.res.TrainCategoryTypeEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.ResOrgSpe;
import com.pinde.sci.model.mo.ResOrgSpeExample;
/**
 * @author tiger
 *
 */
@Service
@Transactional(rollbackFor=Exception.class)
public class ResOrgSpeBizImpl implements IResOrgSpeBiz{

	@Autowired
	private ResOrgSpeMapper resOrgSpeMapper;


	@Override
	public List<ResOrgSpe> searchResOrgSpeList(ResOrgSpe resOrgSpe,String trainCategoryType) {
		ResOrgSpeExample example=new ResOrgSpeExample();
		com.pinde.sci.model.mo.ResOrgSpeExample.Criteria criteria =example.createCriteria();
		List<String>speTypeIdList=new ArrayList<String>();
		if (TrainCategoryTypeEnum.Before2014.getId().equals(trainCategoryType)) {
			speTypeIdList.add(DictTypeEnum.WMFirst.getId());
			speTypeIdList.add(DictTypeEnum.WMSecond.getId());
			speTypeIdList.add(DictTypeEnum.AssiGeneral.getId());
		}
		if (TrainCategoryTypeEnum.After2014.getId().equals(trainCategoryType)) {
			speTypeIdList.add(DictTypeEnum.WM.getId());
			speTypeIdList.add(DictTypeEnum.TCM.getId());
		}
		if (StringUtil.isBlank(trainCategoryType)&&StringUtil.isNotBlank(resOrgSpe.getSpeTypeId())) {
			criteria.andSpeTypeIdEqualTo(resOrgSpe.getSpeTypeId());
		}
		if (StringUtil.isNotBlank(resOrgSpe.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(resOrgSpe.getOrgFlow());
		}
		if (StringUtil.isNotBlank(resOrgSpe.getSpeId())) {
			criteria.andSpeIdEqualTo(resOrgSpe.getSpeId());
		}
		if (speTypeIdList!=null && !speTypeIdList.isEmpty()) {
			criteria.andSpeTypeIdIn(speTypeIdList);
		}
		if(StringUtil.isNotBlank(resOrgSpe.getRecordStatus())){
			criteria.andRecordStatusEqualTo(resOrgSpe.getRecordStatus());
		}
		
		return resOrgSpeMapper.selectByExample(example);

	}
	
	@Override
	public int saveResOrgSpe(ResOrgSpe resOrgSpe) {
		if(StringUtil.isNotBlank(resOrgSpe.getOrgSpeFlow())){
			GeneralMethod.setRecordInfo(resOrgSpe, false);
			return resOrgSpeMapper.updateByPrimaryKeySelective(resOrgSpe);
		}else{
			resOrgSpe.setOrgSpeFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(resOrgSpe, true);
			return resOrgSpeMapper.insert(resOrgSpe);
		}
	}
}
