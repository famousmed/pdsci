package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundSchemeBiz;
import com.pinde.sci.biz.srm.IFundSchemeDetailBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.biz.sys.impl.DictBizImpl;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmFundSchemeMapper;
import com.pinde.sci.dao.base.SrmProjFundInfoMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmFundSchemeExample;
import com.pinde.sci.model.mo.SrmFundSchemeExample.Criteria;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SrmProjFundInfoExample;
import com.pinde.sci.model.mo.SysDict;

@Service
@Transactional(rollbackFor=Exception.class)
public class FundSchemeBizImpl implements IFundSchemeBiz {

	@Resource
	private SrmFundSchemeMapper srmFundSchemeMapper;
	@Resource
	private IDictBiz dictBiz;
	@Resource
	private IFundSchemeDetailBiz schemeDetailBiz;
	@Resource
	private SrmProjFundInfoMapper srmProjFundInfoMapper;
	
	@Override
	public SrmFundScheme readFundScheme(String schemeFlow) {
		return srmFundSchemeMapper.selectByPrimaryKey(schemeFlow);
	}

	@Override
	public int saveFundScheme(SrmFundScheme scheme) {
		if(StringUtil.isNotBlank(scheme.getSchemeFlow())){
			GeneralMethod.setRecordInfo(scheme, false);
			scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			return srmFundSchemeMapper.updateByPrimaryKeySelective(scheme);
		}else{
			scheme.setSchemeFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(scheme, true);
			scheme.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			//schemeDetailBiz.saveFundSchemeDetail(scheme);
			return srmFundSchemeMapper.insert(scheme);
		}
	}

	@Override
	public List<SrmFundScheme> searchFundScheme(SrmFundScheme scheme) {
		SrmFundSchemeExample example=new SrmFundSchemeExample();
		Criteria criteria=example.createCriteria();
		if(StringUtil.isNotBlank(scheme.getRecordStatus())){
			criteria.andRecordStatusEqualTo(scheme.getRecordStatus());
		}
		if(StringUtil.isNotBlank(scheme.getSchemeName())){
			criteria.andSchemeNameLike("%"+scheme.getSchemeName()+"%");
		}
		if(StringUtil.isNotBlank(scheme.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(scheme.getProjTypeId());
		}
		return srmFundSchemeMapper.selectByExample(example);
	}

	@Override
	public int deleteFundScheme(SrmFundScheme scheme) {
		if(StringUtil.isNotBlank(scheme.getSchemeFlow())){
			GeneralMethod.setRecordInfo(scheme, false);
		}
	 return srmFundSchemeMapper.updateByPrimaryKeySelective(scheme);
		
	}

	@Override
	public List<SrmFundScheme> searchStartScheme(String projTypeId) {
		SrmFundSchemeExample example=new SrmFundSchemeExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
				.andProjTypeIdEqualTo(projTypeId);
	
		return srmFundSchemeMapper.selectByExample(example);
	}

	@Override
	public List<SrmProjFundInfo> searchProjFundInfo(SrmProjFundInfo projFundInfo) {
		SrmProjFundInfoExample example=new SrmProjFundInfoExample();
		com.pinde.sci.model.mo.SrmProjFundInfoExample.Criteria criteria=example.createCriteria()
			.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(projFundInfo.getProjSourceId())){
			criteria.andProjSourceIdEqualTo(projFundInfo.getProjSourceId());
		}
		if(StringUtil.isNotBlank(projFundInfo.getProjName())){
			criteria.andProjNameLike(projFundInfo.getProjName());
		}
		
		return srmProjFundInfoMapper.selectByExample(example);
	}
}
