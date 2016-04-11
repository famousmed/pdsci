package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundItemBiz;
import com.pinde.sci.biz.srm.IFundSchemeDetailBiz;
import com.pinde.sci.biz.sys.IDictBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmFundItemMapper;
import com.pinde.sci.dao.base.SrmFundSchemeDetailMapper;
import com.pinde.sci.dao.base.SrmFundSchemeMapper;
import com.pinde.sci.dao.srm.FundItemExtMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.SrmFundItem;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmFundSchemeDetailExample;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SrmFundSchemeDetailExample.Criteria;
import com.pinde.sci.model.srm.FundItemInfo;
@Service
@Transactional(rollbackFor=Exception.class)
public class FundSchemeDetailBizImpl implements IFundSchemeDetailBiz {
	@Resource
	private SrmFundItemMapper srmFundItemMapper;
	
	@Resource 
	private SrmFundSchemeMapper srmFundSchemeMapper;
	
	@Resource
	private SrmFundSchemeDetailMapper srmFundSchemeDetailMapper;
	
	@Resource
	private FundItemExtMapper fundItemExtMapper;
	
	@Autowired
	private IFundItemBiz fundItemBiz;
	
	@Resource
	private IDictBiz dictBiz;
	
	/**
	 * 传schemeFlow(方案项目流水号) itemFlows(经费项目流水号) 添加到对应的经费项目维护中
	 */
	@Override
	public void saveFundSchemeDetail(SrmFundSchemeDetail schemeDtl) {
//			List<SysDict> sysDictList = DictTypeEnum.BudgetItem.getSysDictList();
//			SrmFundSchemeDetail schemeDtl=new SrmFundSchemeDetail();
//			for(int i=0;i<sysDictList.size();i++){
//				schemeDtl.setItemFlow(PkUtil.getUUID());
//				schemeDtl.setSchemeFlow(scheme.getSchemeFlow());
//				schemeDtl.setSchemeName(scheme.getSchemeName());
//				schemeDtl.setItemId(sysDictList.get(i).getDictId());
//				schemeDtl.setItemName(sysDictList.get(i).getDictName());
//				GeneralMethod.setRecordInfo(schemeDtl, true);
//				schemeDtl.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
//				srmFundSchemeDetailMapper.insert(schemeDtl);
//			}
		if(StringUtil.isNotBlank(schemeDtl.getItemFlow())){
			GeneralMethod.setRecordInfo(schemeDtl, false);
			schemeDtl.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			srmFundSchemeDetailMapper.updateByPrimaryKeySelective(schemeDtl);
		}else{
			schemeDtl.setItemFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(schemeDtl, true);
			schemeDtl.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			srmFundSchemeDetailMapper.insert(schemeDtl);
		}
		
    }
	
	/**
	 * 更新
	 */
	@Override
	public void updateFundSchemeDetail(List<SrmFundSchemeDetail> schemeDtlList) {
		SrmFundSchemeDetail schemeDtl=new SrmFundSchemeDetail();
		schemeDtl.setSchemeFlow(schemeDtlList.get(0).getSchemeFlow());
		List<SrmFundSchemeDetail> schemeDtlAll=searchFundSchemeDetail(schemeDtl);
		schemeDtlAll.removeAll(schemeDtlList);
		if(schemeDtlAll.size()>0){
		  for(int i=0;i<schemeDtlAll.size();i++){
			  schemeDtlAll.get(i).setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			  schemeDtlAll.get(i).setRemark("");
			  schemeDtlAll.get(i).setMaxLimit("");
			  srmFundSchemeDetailMapper.updateByPrimaryKeySelective(schemeDtlAll.get(i));
		  }
		}
		for(int i=0;i<schemeDtlList.size();i++){
			GeneralMethod.setRecordInfo(schemeDtlList.get(i), false);
			schemeDtlList.get(i).setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			srmFundSchemeDetailMapper.updateByPrimaryKeySelective(schemeDtlList.get(i));
		}
		
	}
	/**
	 * 查询对应的经费方案信息
	 */
	@Override
	public List<FundItemInfo> searchFundSchemeDetailInfo(
			SrmFundSchemeDetail fundSchemeDetail) {
		List<FundItemInfo> fundItemInfoList=new ArrayList<FundItemInfo>();
		SrmFundSchemeDetailExample example=new SrmFundSchemeDetailExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(fundSchemeDetail.getSchemeName())){
			criteria.andSchemeNameLike("%"+fundSchemeDetail.getSchemeName()+"%");
		}
		if(StringUtil.isNotBlank(fundSchemeDetail.getItemName())){
			criteria.andItemNameLike("%"+fundSchemeDetail.getItemName()+"%");
		}
		if(StringUtil.isNotBlank(fundSchemeDetail.getSchemeFlow())){
			criteria.andSchemeFlowEqualTo(fundSchemeDetail.getSchemeFlow());
		}
		List<SrmFundSchemeDetail> fundSchemeDetailList=srmFundSchemeDetailMapper.selectByExample(example);
		for(SrmFundSchemeDetail fundSchemeDetails :fundSchemeDetailList ){
			FundItemInfo fundItemInfo=new FundItemInfo();
			String itemFlow=fundSchemeDetails.getItemFlow();
			SrmFundItem item=this.srmFundItemMapper.selectByPrimaryKey(itemFlow);
			SrmFundScheme scheme=this.srmFundSchemeMapper.selectByPrimaryKey(itemFlow);
			fundItemInfo.setItem(item);
			fundItemInfo.setScheme(scheme);
			fundItemInfo.setFundSchemeDetail(fundSchemeDetails);
			fundItemInfoList.add(fundItemInfo);
		}
		return fundItemInfoList;
	}
	/**
	 * 查询未加入的经费项目
	 */
	@Override
	public List<FundItemInfo> searchSrmFundItemNotInBySchemeFlow(
			String schemeFlow) {
		List<FundItemInfo> fundItemList=new ArrayList<FundItemInfo>();
		List<SrmFundItem> srmFundItemList=fundItemExtMapper.searchSrmFundItemNotInBySchemeFlow(schemeFlow);
		for(SrmFundItem fundItem : srmFundItemList){
			FundItemInfo funditemInfo=new FundItemInfo();
			SrmFundScheme scheme=this.srmFundSchemeMapper.selectByPrimaryKey(fundItem.getItemFlow());
			funditemInfo.setItem(fundItem);
			funditemInfo.setScheme(scheme);
			fundItemList.add(funditemInfo);
		}
		return fundItemList;
	}
	/**
	 * 查询经费方案下的经费项
	 */
	@Override
	public List<SrmFundSchemeDetail> searchFundSchemeDetail(
			SrmFundSchemeDetail schemeDtl) {
		   SrmFundSchemeDetailExample schemeDetailExample=new SrmFundSchemeDetailExample();
		   Criteria criteria = schemeDetailExample.createCriteria();
		   if(StringUtil.isNotBlank(schemeDtl.getSchemeFlow())){
			   criteria.andSchemeFlowEqualTo(schemeDtl.getSchemeFlow());
		   }
		   if(StringUtil.isNotBlank(schemeDtl.getRecordStatus())){
			   criteria.andRecordStatusEqualTo(schemeDtl.getRecordStatus());
		   }
		   
		return srmFundSchemeDetailMapper.selectByExample(schemeDetailExample);
	}

	@Override
	public SrmFundSchemeDetail read(String itemFlow) {
		return this.srmFundSchemeDetailMapper.selectByPrimaryKey(itemFlow);
	}
	@Override
	public List<SrmFundSchemeDetail> searchFundSchemeDetailSee(
			SrmFundSchemeDetail fundSchemeDtl) {
		
		   SrmFundSchemeDetailExample schemeDetailExample=new SrmFundSchemeDetailExample();
		 Criteria criteria = schemeDetailExample.createCriteria().andSchemeFlowEqualTo(fundSchemeDtl.getSchemeFlow())
		   .andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		   if(StringUtil.isNotBlank(fundSchemeDtl.getSchemeFlow())){
			   criteria.andSchemeFlowEqualTo(fundSchemeDtl.getSchemeFlow());
		   }
		return srmFundSchemeDetailMapper.selectByExample(schemeDetailExample);
	}
}
