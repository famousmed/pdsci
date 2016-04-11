package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundInfoDetailBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmProjFundDetailMapper;
import com.pinde.sci.dao.srm.ProjFundExtMapper;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundDetailExample;
import com.pinde.sci.model.mo.SrmProjFundDetailExample.Criteria;
import com.pinde.sci.model.srm.ProjFundDetailExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class SrmpProjFundDetailBizImpl implements IFundInfoDetailBiz{

@Resource
private SrmProjFundDetailMapper fundDetailMapper;
@Autowired
private ProjFundExtMapper fundExtMapper;
	
	@Override
	public List<SrmProjFundDetail> searchFundDetail(SrmProjFundDetail fundDtl) {
		SrmProjFundDetailExample example=new SrmProjFundDetailExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(fundDtl.getFundFlow())){
			criteria.andFundFlowEqualTo(fundDtl.getFundFlow());
		}
		if(StringUtil.isNotBlank(fundDtl.getFundTypeId())){
			criteria.andFundTypeIdEqualTo(fundDtl.getFundTypeId());
		}
		return fundDetailMapper.selectByExample(example);
	}

	@Override
	public void saveFundDetail(SrmProjFundDetail fundDtl) {
		fundDetailMapper.insert(fundDtl);
		
	}

	@Override
	public void updateFundDetail(SrmProjFundDetail fundDtl) {
		fundDetailMapper.updateByPrimaryKeySelective(fundDtl);
		
	}

	@Override
	public int deleteFundDetail(String fundDetailFlow) {
		SrmProjFundDetail detail = new SrmProjFundDetail();
		detail.setFundDetailFlow(fundDetailFlow);
		detail.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		return this.fundDetailMapper.updateByPrimaryKeySelective(detail);
	}

	@Override
	public int updateRecordStatusByFundFlow(String fundFlow,String recordStatus) {
		SrmProjFundDetailExample example = new SrmProjFundDetailExample();
		example.createCriteria().andFundFlowEqualTo(fundFlow);
		SrmProjFundDetail detail = new SrmProjFundDetail();
		detail.setRecordStatus(recordStatus);
		return this.fundDetailMapper.updateByExampleSelective(detail, example);
	}

	@Override
	public ProjFundDetailExt selectProjFundDetailExt(String fundDetailFlow) {
		return this.fundExtMapper.selectProjFundDetailExt(fundDetailFlow);
	}
	

}
