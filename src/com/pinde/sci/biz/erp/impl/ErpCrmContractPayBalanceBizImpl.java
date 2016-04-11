package com.pinde.sci.biz.erp.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractPayPlanBiz;
import com.pinde.sci.biz.erp.IErpCrmContractPayBalanceBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractMapper;
import com.pinde.sci.dao.base.ErpCrmContractPayBalanceMapper;
import com.pinde.sci.dao.erp.ErpCrmContractPayBalanceExtMapper;
import com.pinde.sci.enums.erp.PayPlanStatusEnum;
import com.pinde.sci.model.mo.ErpCrmContractPayBalance;
import com.pinde.sci.model.mo.ErpCrmContractPayBalanceExample;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpCrmContractPayBalanceBizImpl implements IErpCrmContractPayBalanceBiz {
	@Autowired
	private ErpCrmContractPayBalanceMapper contractPayBalanceMapper;
	@Autowired
	private ErpCrmContractPayBalanceExtMapper contractPayBalanceExtMapper;
	@Autowired
	private IErpContractPayPlanBiz payPlanBiz;

	@Override
	public int save(ErpCrmContractPayBalance balance) {
		if(StringUtil.isBlank(balance.getRecordFlow())){
			balance.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(balance, true);
			return contractPayBalanceMapper.insert(balance);
		}else{
			GeneralMethod.setRecordInfo(balance, false);
			return contractPayBalanceMapper.updateByPrimaryKeySelective(balance);
		}
	}

	@Override
	public List<ErpCrmContractPayBalance> searchBalanceList(ErpCrmContractPayBalance balance) {
		ErpCrmContractPayBalanceExample example = new ErpCrmContractPayBalanceExample();
		com.pinde.sci.model.mo.ErpCrmContractPayBalanceExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(balance.getContractFlow())){
			criteria.andContractFlowEqualTo(balance.getContractFlow());
		}
		if(StringUtil.isNotBlank(balance.getPlanFlow())){
			criteria.andPlanFlowEqualTo(balance.getPlanFlow());
		}
		example.setOrderByClause("CREATE_TIME");
		return contractPayBalanceMapper.selectByExample(example);
	}

	@Override
	public int saveBalance(ErpCrmContractPayBalance balance) {
		save(balance);
		String planFlow =  balance.getPlanFlow();
		BigDecimal balanceFund = contractPayBalanceExtMapper.getBalanceFund(balance);
		ErpCrmContractPayPlan payPlan = payPlanBiz.readPayPlan(planFlow);
		//µ½ÕË/¸¶¿î½ð¶î
		payPlan.setBalanceFund(balanceFund);
		//×´Ì¬
		BigDecimal payFund = payPlan.getPayFund();
		int result = payFund.compareTo(balanceFund);
		if(result == 1){
			payPlan.setPlanStatusId(PayPlanStatusEnum.InProgress.getId());
			payPlan.setPlanStatusName(PayPlanStatusEnum.InProgress.getName());
		}else if(result == 0 || result == -1){
			payPlan.setPlanStatusId(PayPlanStatusEnum.Complete.getId());
			payPlan.setPlanStatusName(PayPlanStatusEnum.Complete.getName());
		}else {
			payPlan.setPlanStatusId(PayPlanStatusEnum.NotStart.getId());
			payPlan.setPlanStatusName(PayPlanStatusEnum.NotStart.getName());
		}
		return payPlanBiz.save(payPlan);
	}

}
