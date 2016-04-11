package com.pinde.sci.biz.inx.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.inx.IInxInfoBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.InxColumnMapper;
import com.pinde.sci.dao.base.InxInfoMapper;
import com.pinde.sci.dao.inx.InxInfoExtMapper;
import com.pinde.sci.enums.inx.InfoStatusEnum;
import com.pinde.sci.form.inx.InxInfoForm;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.InxInfoExample;
import com.pinde.sci.model.mo.InxInfoExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class InxInfoBizImpl implements IInxInfoBiz {
	@Resource
	private InxInfoExtMapper inxInfoExtMapper;
	@Resource
	private InxColumnMapper inxColumnMapper;
	@Resource
	private InxInfoMapper inxInfoMapper;


	@Override
	public List<InxInfo> queryByForm(InxInfoForm form) {

		List<InxInfo> infoList = inxInfoExtMapper.selectByForm(form);
		return infoList;
	}
	
	@Override
	public List<InxInfo> queryByFormWithBlobs(InxInfoForm form) {

		List<InxInfo> infoList = inxInfoExtMapper.selectByFormWithBlobs(form);
		return infoList;
	}
	
	@Override
	public InxInfo getByInfoFlow(String infoFlow) {
		return inxInfoMapper.selectByPrimaryKey(infoFlow);
	}

	@Override
	public List<InxInfo> queryImgNews(InxInfoForm form) {

		List<InxInfo> imgNewsList = inxInfoExtMapper.selectByFormWithBlobs(form);
		return imgNewsList;
	}

	@Override
	public List<InxInfo> getList(InxInfoForm form) {
		InxInfoExample example = new InxInfoExample();
		Criteria criteria = example.createCriteria();
		Criteria criteria2 = example.createCriteria();
		criteria.andInfoStatusIdEqualTo(InfoStatusEnum.Passed.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria2.andInfoStatusIdEqualTo(InfoStatusEnum.Passed.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(form.getRecordStatus())){
			criteria.andRecordStatusEqualTo(form.getRecordStatus());
			criteria2.andRecordStatusEqualTo(form.getRecordStatus());
		}
		if(StringUtil.isNotBlank(form.getColumnId())){
			criteria.andColumnIdLike(form.getColumnId()+"%");
			criteria2.andColumnIdLike(form.getColumnId()+"%");
		}
		if(StringUtil.isNotBlank(form.getInfoTitle())){
			criteria.andInfoTitleLike("%"+form.getInfoTitle()+"%");
			criteria2.andInfoTitleLike("%"+form.getInfoTitle()+"%");
		}
		if(StringUtil.isNotBlank(form.getInfoKeyword())){
			criteria.andInfoTitleLike("%"+form.getInfoKeyword()+"%");
			criteria2.andInfoKeywordLike("%"+form.getInfoKeyword()+"%");
		}
		if(GlobalConstant.FLAG_Y.equals(form.getHasImage())){
			criteria.andTitleImgIsNotNull();
			criteria2.andTitleImgIsNotNull();
		}
		if(StringUtil.isNotBlank(form.getEndDate())){//²éÑ¯ÏÂÒ»Æª
			criteria.andCreateTimeLessThanOrEqualTo(form.getEndDate());
			criteria2.andCreateTimeLessThanOrEqualTo(form.getEndDate());
		}
		example.or(criteria2);
	    if(GlobalConstant.FLAG_Y.equals(form.getOrderByViewNum())){
			example.setOrderByClause("VIEW_NUM DESC nulls last, IS_TOP DESC nulls last, INFO_TIME DESC, CREATE_TIME DESC");
		}else{
			example.setOrderByClause("IS_TOP DESC nulls last, INFO_TIME DESC, CREATE_TIME DESC");
		}
		if(GlobalConstant.FLAG_Y.equals(form.getIsWithBlobs())){
			return this.inxInfoMapper.selectByExampleWithBLOBs(example);
		}
		return this.inxInfoMapper.selectByExample(example);
	}

	@Override
	public List<InxInfo> queryClassifyList(InxInfoForm form) {
		InxInfoExample example = new InxInfoExample();
		Criteria criteria = example.createCriteria();
		Criteria criteria2 = example.createCriteria();
		criteria.andInfoStatusIdEqualTo(InfoStatusEnum.Passed.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria2.andInfoStatusIdEqualTo(InfoStatusEnum.Passed.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(form.getRecordStatus())){
			criteria.andRecordStatusEqualTo(form.getRecordStatus());
			criteria2.andRecordStatusEqualTo(form.getRecordStatus());
		}
		if(StringUtil.isNotBlank(form.getColumnId())){
			criteria.andColumnIdLike(form.getColumnId());
			criteria2.andColumnIdLike(form.getColumnId());
		}
		if(StringUtil.isNotBlank(form.getInfoTitle())){
			criteria.andInfoTitleLike("%"+form.getInfoTitle()+"%");
			criteria2.andInfoTitleLike("%"+form.getInfoTitle()+"%");
		}
		if(StringUtil.isNotBlank(form.getInfoKeyword())){
			criteria.andInfoTitleLike("%"+form.getInfoKeyword()+"%");
			criteria2.andInfoKeywordLike("%"+form.getInfoKeyword()+"%");
		}
		if(GlobalConstant.FLAG_Y.equals(form.getHasImage())){
			criteria.andTitleImgIsNotNull();
			criteria2.andTitleImgIsNotNull();
		}
		example.or(criteria2);
		if(GlobalConstant.FLAG_Y.equals(form.getOrderByViewNum())){
			example.setOrderByClause("VIEW_NUM DESC nulls last, IS_TOP DESC nulls last, INFO_TIME DESC, CREATE_TIME DESC");
		}else{
			example.setOrderByClause("IS_TOP DESC nulls last, INFO_TIME DESC, CREATE_TIME DESC");
		}
		if(GlobalConstant.FLAG_Y.equals(form.getIsWithBlobs())){
			return this.inxInfoMapper.selectByExampleWithBLOBs(example);
		}
		return this.inxInfoMapper.selectByExample(example);
	}

	@Override
	public int modifyInxInfo(InxInfo info) {
		if(StringUtil.isNotBlank(info.getInfoFlow())){
			GeneralMethod.setRecordInfo(info, false);
			return inxInfoMapper.updateByPrimaryKeySelective(info);
		}
		return GlobalConstant.ZERO_LINE;
	}


}
