package com.pinde.sci.biz.erp;

import java.math.BigDecimal;
import java.util.List;

import com.pinde.sci.form.erp.ContractTimeForm;
import com.pinde.sci.model.mo.ErpCrmContract;
import com.pinde.sci.model.mo.ErpCrmContractPayPlan;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpOaContactOrder;
import com.pinde.sci.model.mo.ErpOaWorkOrder;

public interface IErpViewBiz {

	/**
	 * ��ѯ�ͻ�����
	 * @param customer
	 * @return
	 */
	public int countCustomer(ErpCrmCustomer customer);
	
	/**
	 * ��ѯ�к�ͬ�Ŀͻ�����
	 * @return
	 */
	public int countCustomerHasContract();
	
	/**
	 * ��ѯ��ͬ����
	 * @param contract
	 * @return
	 */
	public int countContract(ErpCrmContract contract);
	/**
	 * ��ѯ��ͬ�ʽ����
	 * @param contract
	 * @return
	 */
	public BigDecimal countContractFund(ErpCrmContract contract);
	/**
	 * ��ѯ��ͬ�ؿ����
	 * @param payPlan
	 * @return
	 */
	public BigDecimal countPayPlanFund(ErpCrmContract contract,ErpCrmContractPayPlan plan);
	/**
	 * ��ѯ��ϵ������
	 * @param contactOrder
	 * @return
	 */
	public int countContactOrderByStatus(List<String> statusList);
	/**
	 * ��ѯ�ɹ�������
	 * @param workOrder
	 * @return
	 */
	public int countWorkOrderByStatus(List<String> statusList);
	
	public int countContactOrder(ErpOaContactOrder contactOrder);
	
	public int countWorkOrder(ErpOaWorkOrder workOrder);
}
