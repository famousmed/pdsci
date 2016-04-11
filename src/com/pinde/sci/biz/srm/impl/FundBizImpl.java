package com.pinde.sci.biz.srm.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IFundBiz;
import com.pinde.sci.biz.srm.IProjMineBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.SrmFundItemMapper;
import com.pinde.sci.dao.base.SrmFundProcessMapper;
import com.pinde.sci.dao.base.SrmFundSchemeDetailMapper;
import com.pinde.sci.dao.base.SrmFundSchemeMapper;
import com.pinde.sci.dao.base.SrmProjFundDetailMapper;
import com.pinde.sci.dao.base.SrmProjFundInfoMapper;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.enums.srm.ProjFundAccountsTypeEnum;
import com.pinde.sci.enums.srm.ProjFundTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundProcess;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundDetailExample;
import com.pinde.sci.model.mo.SrmProjFundInfo;
import com.pinde.sci.model.mo.SrmProjFundInfoExample;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.srm.FundDetailExt;
import com.pinde.sci.model.srm.FundInfoExt;
import com.pinde.sci.model.srm.FundSum;

@Service
@Transactional(rollbackFor=Exception.class)
public class FundBizImpl implements IFundBiz {

	@Autowired
	private SrmProjFundInfoMapper fundInfoMapper;
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private SrmProjFundDetailMapper fundDetailMapper;
	@Autowired
	private SrmFundSchemeMapper fundSchemeMapper;
	@Autowired
	private SrmFundItemMapper fundItemMapper;
	@Autowired
	private SrmFundProcessMapper fundProcessMapper;
	@Autowired
	private IProjMineBiz projMineBiz;
	@Autowired
	private SrmFundSchemeDetailMapper fundSchemeDetailMapper;
	
	@Override
	public List<FundInfoExt> getList(PubProj proj){
		//proj.setProjStageId(ProjStageEnum.Schedule.getId());
		//proj.setProjStatusId(ProjScheduleStatusEnum.FirstAudit.getId());
		
		List<PubProj> proList = this.projMineBiz.searchProjListForBudget(proj);
		List<String> proFlows = new ArrayList<String>();
		for (PubProj p : proList) {
			proFlows.add(p.getProjFlow());
		}
		SrmProjFundInfoExample fundExample  = new SrmProjFundInfoExample();
		List<SrmProjFundInfo> funds = new ArrayList<SrmProjFundInfo>();
		if(!proFlows.isEmpty()){
			fundExample.createCriteria().andProjFlowIn(proFlows).andBudgetStatusIdEqualTo(AchStatusEnum.FirstAudit.getId());
			funds = this.fundInfoMapper.selectByExample(fundExample);
		}
		List<FundInfoExt> fundExts = new ArrayList<FundInfoExt>();
		FundInfoExt fundInfoExt = null;
		for (SrmProjFundInfo f : funds) {
			for (PubProj p : proList) {
				if(f.getProjFlow().equals(p.getProjFlow())){
					fundInfoExt = new FundInfoExt();
					fundInfoExt.setFund(f);
					fundInfoExt.setProject(p);
					fundExts.add(fundInfoExt);
					continue;
				}
			}
		}
		return fundExts;
	}
	@Override
	public List<SrmProjFundDetail> getDetails(String fundFlow) {
		if(StringUtil.isNotBlank(fundFlow)){
			SrmProjFundDetailExample example = new SrmProjFundDetailExample();
			example.createCriteria().andFundFlowEqualTo(fundFlow).andFundTypeIdEqualTo(ProjFundTypeEnum.Income.getId()).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			example.setOrderByClause("create_time asc");
			return this.fundDetailMapper.selectByExample(example);
		}
		return null;
	}
	@Override
	public void saveDetail(SrmProjFundDetail detail) {
		 if(detail!=null){
			 detail.setFundDetailFlow(PkUtil.getUUID());
			 GeneralMethod.setRecordInfo(detail, true);
			 detail.setRealityTypeName(ProjFundAccountsTypeEnum.getNameById(detail.getRealityTypeId()));
			 detail.setFundTypeId(ProjFundTypeEnum.Income.getId());
			 detail.setFundTypeName(ProjFundTypeEnum.Income.getName());
			 detail.setOperStatusId(AchStatusEnum.Apply.getId());
			 detail.setOperStatusName(AchStatusEnum.Apply.getName());
			 this.fundDetailMapper.insertSelective(detail);
			 
			 /*插入过程*/
			 SrmFundProcess pro = new SrmFundProcess();
			 pro.setFundProcessFlow(PkUtil.getUUID());
			 pro.setFundFlow(detail.getFundFlow());
			 pro.setFundDetailFlow(detail.getFundDetailFlow());
			 pro.setOperateUserFlow(GlobalContext.getCurrentUser().getUserFlow());
			 pro.setOperateUserName(GlobalContext.getCurrentUser().getUserName());
			 pro.setOperateTime(DateUtil.getCurrDateTime());
			 pro.setOperStatusId(AchStatusEnum.Apply.getId());
			 pro.setOperStatusName(AchStatusEnum.Apply.getName());
			 GeneralMethod.setRecordInfo(pro, true);
			 this.fundProcessMapper.insertSelective(pro);
			 
			 //计算下拨和配套的总值 更新到fundInfo中
			 BigDecimal realityGoveAmount = new BigDecimal(0);
			 BigDecimal realityOrgAmount = new BigDecimal(0);
			 SrmProjFundDetailExample example = new SrmProjFundDetailExample();
			 example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andFundFlowEqualTo(detail.getFundFlow());
			 List<SrmProjFundDetail> fundDetailList = this.fundDetailMapper.selectByExample(example);
			 for(SrmProjFundDetail fundDetail : fundDetailList){
				 if(ProjFundAccountsTypeEnum.Allocate.getId().equals(fundDetail.getRealityTypeId())){//更新实际下拨总额
					 realityGoveAmount = realityGoveAmount.add(fundDetail.getMoney());
				 }
				 if(ProjFundAccountsTypeEnum.Matching.getId().equals(fundDetail.getRealityTypeId())){//更新实际配套总额
					 realityOrgAmount = realityOrgAmount.add(fundDetail.getMoney());
				 }
				 
			 }
			 SrmProjFundInfo fund = this.getFund(detail.getFundFlow());
			 if(fund!=null){
				 GeneralMethod.setRecordInfo(fund, false);
//				 if(ProjFundAccountsTypeEnum.Allocate.getId().equals(detail.getRealityTypeId())){//更新实际下拨总额
//					 fund.setRealityGoveAmount(fund.getRealityGoveAmount().add(detail.getMoney()));
//				 }else if(ProjFundAccountsTypeEnum.Matching.getId().equals(detail.getRealityTypeId())){//更新实际配套总额
//					 fund.setRealityOrgAmount(fund.getRealityOrgAmount().add(detail.getMoney()));
//				 }
				 fund.setRealityGoveAmount(realityGoveAmount);
				 fund.setRealityOrgAmount(realityOrgAmount);
				 fund.setRealityAmount(fund.getRealityGoveAmount().add(fund.getRealityOrgAmount()));//更新实际到账总额
				 fund.setRealityBalance(fund.getRealityBalance().add(detail.getMoney()));//更新到账余额
				 this.fundInfoMapper.updateByPrimaryKeySelective(fund);
			 }
		 }
		 
		 
	}
	@Override
	public SrmProjFundInfo getFund(String fundFlow) {
		return this.fundInfoMapper.selectByPrimaryKey(fundFlow);
	}
	@Override
	public FundSum getFundSum(List<FundInfoExt> list) {
		if(list!=null){
			BigDecimal amountFundSum = new BigDecimal(0.00) ;//经费总计
			BigDecimal goveFundSum = new BigDecimal(0.00);//下拨总计
			BigDecimal orgFundSum = new BigDecimal(0.00);//配套总计
			BigDecimal realityAmountSum = new BigDecimal(0.00);//到账总计
			BigDecimal yetPaymentAmountSum = new BigDecimal(0.00);//支出总计
			BigDecimal realityBalanceSum = new BigDecimal(0.00);//剩余经费总计
			for (FundInfoExt fundExt : list) {
				amountFundSum = amountFundSum.add(fundExt.getFund().getAmountFund());
				goveFundSum = goveFundSum.add(fundExt.getFund().getGoveFund());
				orgFundSum = orgFundSum.add(fundExt.getFund().getOrgFund());
				realityAmountSum = realityAmountSum.add(fundExt.getFund().getRealityAmount());
				yetPaymentAmountSum = yetPaymentAmountSum.add(fundExt.getFund().getYetPaymentAmount());
				realityBalanceSum = realityBalanceSum.add(fundExt.getFund().getRealityBalance());
			}
			return new FundSum(amountFundSum, goveFundSum, orgFundSum, realityAmountSum, yetPaymentAmountSum, realityBalanceSum);
		}
		return null;
	}
	@Override
	public FundInfoExt getFundExt(String fundFlow){
		if(StringUtil.isNotBlank(fundFlow)){
			SrmProjFundInfo fund = this.getFund(fundFlow);
			PubProj proj = this.pubProjMapper.selectByPrimaryKey(fund.getProjFlow());
			FundInfoExt fundExt = new FundInfoExt();
			fundExt.setFund(fund);
			fundExt.setProject(proj);
			SrmProjFundDetailExample example = new SrmProjFundDetailExample();
			example.createCriteria().andFundFlowEqualTo(fundFlow).andFundTypeIdEqualTo(ProjFundTypeEnum.Reimburse.getId()).andOperStatusIdEqualTo(AchStatusEnum.FirstAudit.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			example.setOrderByClause(" create_time asc");
			List<SrmProjFundDetail> alaimList = this.fundDetailMapper.selectByExample(example);//报销明细
			List<FundDetailExt> alaimExtList = new ArrayList<FundDetailExt>();
			FundDetailExt ae = null;
			for (SrmProjFundDetail a : alaimList) {
				ae = new FundDetailExt();
				ae.setFundDetail(a);
				SrmFundSchemeDetail item = this.fundSchemeDetailMapper.selectByPrimaryKey(a.getItemFlow());
				ae.setItem(item);
				alaimExtList.add(ae);
			}
			fundExt.setAlaimList(alaimExtList);
			SrmProjFundDetailExample example2 = new SrmProjFundDetailExample();
			example2.createCriteria().andFundFlowEqualTo(fundFlow).andFundTypeIdEqualTo(ProjFundTypeEnum.Budget.getId());
			List<SrmProjFundDetail> budgetList = this.fundDetailMapper.selectByExample(example);//预算明细
			fundExt.setBudgetList(budgetList);
			SrmFundScheme scheme = this.fundSchemeMapper.selectByPrimaryKey(fund.getSchemeFlow());
			fundExt.setFundScheme(scheme);
			return fundExt;
		}
		return null;
	}
	@Override
	public void delDetailByFundDetailFlow(String fundDetailFlow) {
		SrmProjFundDetail fundDetail = this.fundDetailMapper.selectByPrimaryKey(fundDetailFlow);
		fundDetail.setRecordStatus(GlobalConstant.FLAG_N);
		BigDecimal money = fundDetail.getMoney();
		String realityTypeId = fundDetail.getRealityTypeId();
		String fundFlow = fundDetail.getFundFlow();
		SrmProjFundInfo fundInfo = this.fundInfoMapper.selectByPrimaryKey(fundFlow);
		fundInfo.setRealityAmount(fundInfo.getRealityAmount().subtract(money));
		fundInfo.setRealityBalance(fundInfo.getRealityBalance().subtract(money));
		if(ProjFundAccountsTypeEnum.Allocate.getId().equals(realityTypeId)){
			//更改实际到账中的下拨金额
			fundInfo.setRealityGoveAmount(fundInfo.getRealityGoveAmount().subtract(money));
			
		}else if(ProjFundAccountsTypeEnum.Matching.getId().equals(realityTypeId)){
			//更改实际到账中的配套金额
			fundInfo.setRealityOrgAmount(fundInfo.getRealityOrgAmount().subtract(money));
		}
		GeneralMethod.setRecordInfo(fundDetail, false);
		this.fundDetailMapper.updateByPrimaryKeySelective(fundDetail);
		GeneralMethod.setRecordInfo(fundInfo, false);
		this.fundInfoMapper.updateByPrimaryKeySelective(fundInfo);
		
	}
	
	

}
