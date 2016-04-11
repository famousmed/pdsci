package com.pinde.sci.biz.erp.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.erp.IErpViewBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ErpCrmContractMapper;
import com.pinde.sci.dao.base.ErpCrmCustomerMapper;
import com.pinde.sci.dao.base.ErpOaContactOrderMapper;
import com.pinde.sci.dao.base.ErpOaWorkOrderMapper;
import com.pinde.sci.dao.erp.ErpCrmContractExtMapper;
import com.pinde.sci.dao.erp.ErpCrmContractPayBalanceExtMapper;
import com.pinde.sci.dao.erp.ErpCrmCustomerExtMapper;
import com.pinde.sci.dao.erp.ErpOaContactOrderExtMapper;
import com.pinde.sci.dao.erp.ErpOaWorkOrderExtMapper;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractExample;
import com.pinde.sci.model.mo.ErpCrmContractExample.Criteria;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerExample;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaContactOrderExample;
import com.pinde.sci.model.mo.ErpOaWorkOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrderExample;
@Service
@Transactional(rollbackFor = Exception.class)
public class ErpViewBizImpl implements IErpViewBiz{
	@Autowired
	private ErpCrmCustomerExtMapper customerExtMapper;
	@Autowired
	private ErpCrmCustomerMapper customerMapper;
	@Autowired
	private ErpCrmContractMapper contractMapper;
	@Autowired
	private ErpCrmContractPayBalanceExtMapper balanceExtMapper;
	@Autowired
	private ErpOaContactOrderExtMapper contactOrderExtMapper;
	@Autowired
	private ErpOaContactOrderMapper contactOrderMapper;
	@Autowired
	private ErpOaWorkOrderExtMapper workOrderExtMapper;
	@Autowired
	private ErpOaWorkOrderMapper workOrderMapper;
	@Autowired
	private ErpCrmContractExtMapper contractExtMapper;

	@Override
	public int countCustomer(ErpCrmCustomer customer) {
		ErpCrmCustomerExample example=new ErpCrmCustomerExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return customerMapper.countByExample(example);
	}

	@Override
	public int countCustomerHasContract() {
		return customerExtMapper.countCustomerHasContract(null);
	}

	@Override
	public int countContract(ErpCrmContract contract) {
		ErpCrmContractExample example=new ErpCrmContractExample();
	    Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
          if(StringUtil.isNotBlank(contract.getSignDate())){
        	  criteria.andSignDateLike("%"+contract.getSignDate()+"%");
          }
		return contractMapper.countByExample(example);
	}

	
	@Override
	public BigDecimal countContractFund(ErpCrmContract contract) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("contract", contract);
		return contractExtMapper.countContractFundNumber(paramMap);
	}
	
	@Override
	public BigDecimal countPayPlanFund(ErpCrmContract contract,ErpCrmContractPayPlan plan) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(contract!=null){
			paramMap.put("contract", contract);
		}
		if(plan!=null){
			paramMap.put("plan", plan);
		}
		return balanceExtMapper.countBalanceFund(paramMap);
	}

	@Override
	public int countContactOrderByStatus(List<String> statusList) {
	    Map<String,Object> paramMap=new HashMap<String, Object>();
	    if(statusList!=null && !statusList.isEmpty()){
	    	paramMap.put("statusId", statusList);
	    }
	    return contactOrderExtMapper.countContactOrderList(paramMap);
	    
	}

	@Override
	public int countWorkOrderByStatus(List<String> statusList) {
		 Map<String,Object> paramMap=new HashMap<String, Object>();
		    if(statusList!=null && !statusList.isEmpty()){
		    	paramMap.put("statusId", statusList);
		    }
		    return workOrderExtMapper.countWorkOrderList(paramMap);
	}

	@Override
	public int countContactOrder(ErpOaContactOrder contactOrder) {
	    ErpOaContactOrderExample example=new ErpOaContactOrderExample();
	    com.pinde.sci.model.mo.ErpOaContactOrderExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
	    if(contactOrder!=null){
	    	if(StringUtil.isNotBlank(contactOrder.getContactStatusId())){
	    		criteria.andContactStatusIdEqualTo(contactOrder.getContactStatusId());
	    	}
	    }
		return contactOrderMapper.countByExample(example);
	}

	@Override
	public int countWorkOrder(ErpOaWorkOrder workOrder) {
		ErpOaWorkOrderExample example=new ErpOaWorkOrderExample();
		com.pinde.sci.model.mo.ErpOaWorkOrderExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(workOrder!=null){
			if(StringUtil.isNotBlank(workOrder.getWorkStatusId())){
				criteria.andWorkStatusIdEqualTo(workOrder.getWorkStatusId());
			}
		}
		return workOrderMapper.countByExample(example);
	}
    
}
