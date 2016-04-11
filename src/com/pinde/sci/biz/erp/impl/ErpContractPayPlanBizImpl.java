package com.pinde.sci.biz.erp.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpContractPayPlanBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractPayPlanMapper;
import com.pinde.sci.enums.erp.PayPlanStatusEnum;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmContractPayPlanExample;
import com.pinde.sci.model.mo.ErpCrmContractPayPlanExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class ErpContractPayPlanBizImpl implements IErpContractPayPlanBiz{
	
	@Autowired
	private ErpCrmContractPayPlanMapper payPlanMapper;

	@Override
	public String saveContractPayPlan(List<ErpCrmContractPayPlan> payPlanList,String contractFlow) {
		if(payPlanList!=null && !payPlanList.isEmpty()){
			for(ErpCrmContractPayPlan payPlan:payPlanList){
				if(StringUtil.isBlank(payPlan.getContractFlow())){
					payPlan.setContractFlow(contractFlow);
				}
				save(payPlan);
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<ErpCrmContractPayPlan> searchContractPayPlanList(
			ErpCrmContractPayPlan payPlan) {
		ErpCrmContractPayPlanExample example=new ErpCrmContractPayPlanExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(payPlan.getContractFlow())){
			criteria.andContractFlowEqualTo(payPlan.getContractFlow());
		}
		return this.payPlanMapper.selectByExample(example);
	}

	@Override
	public int save(ErpCrmContractPayPlan payPlan) {
		if(StringUtil.isNotBlank(payPlan.getPlanFlow())){
			GeneralMethod.setRecordInfo(payPlan, false);
			return payPlanMapper.updateByPrimaryKeySelective(payPlan);
		}else{
			payPlan.setPlanFlow(PkUtil.getUUID());
			payPlan.setPlanStatusId(PayPlanStatusEnum.NotStart.getId());
			payPlan.setPlanStatusName(PayPlanStatusEnum.NotStart.getName());
			payPlan.setBalanceFund(new BigDecimal(0));
			GeneralMethod.setRecordInfo(payPlan, true);
			return payPlanMapper.insertSelective(payPlan);
		}
	}

	@Override
	public ErpCrmContractPayPlan readPayPlan(String planFlow) {
		if(StringUtil.isNotBlank(planFlow)){
			return payPlanMapper.selectByPrimaryKey(planFlow);
		}
		return null;
	}

}
