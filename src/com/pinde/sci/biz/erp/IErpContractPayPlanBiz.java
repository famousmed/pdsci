package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractPayPlan;

public interface IErpContractPayPlanBiz {
    
	/**
	 * �����ͬ�ؿ�ƻ�
	 * @param payPlanList
	 * @return
	 */
	public String saveContractPayPlan(List<ErpCrmContractPayPlan> payPlanList,String contractFlow);
	/**
	 * ��ѯ��ͬ�ؿ�ƻ�
	 * @param payPlan
	 * @return
	 */
	public List<ErpCrmContractPayPlan> searchContractPayPlanList(ErpCrmContractPayPlan payPlan);
	
	/**
	 * ����
	 * @param payPlan
	 * @return
	 */
	int save(ErpCrmContractPayPlan payPlan);
	
	
	/**
	 * ��ȡһ����¼
	 * @param planFlow
	 * @return
	 */
	ErpCrmContractPayPlan readPayPlan(String planFlow);
}
