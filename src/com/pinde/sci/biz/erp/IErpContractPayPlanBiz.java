package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractPayPlan;

public interface IErpContractPayPlanBiz {
    
	/**
	 * 保存合同回款计划
	 * @param payPlanList
	 * @return
	 */
	public String saveContractPayPlan(List<ErpCrmContractPayPlan> payPlanList,String contractFlow);
	/**
	 * 查询合同回款计划
	 * @param payPlan
	 * @return
	 */
	public List<ErpCrmContractPayPlan> searchContractPayPlanList(ErpCrmContractPayPlan payPlan);
	
	/**
	 * 保存
	 * @param payPlan
	 * @return
	 */
	int save(ErpCrmContractPayPlan payPlan);
	
	
	/**
	 * 获取一条记录
	 * @param planFlow
	 * @return
	 */
	ErpCrmContractPayPlan readPayPlan(String planFlow);
}
