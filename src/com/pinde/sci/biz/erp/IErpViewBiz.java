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
	 * 查询客户数量
	 * @param customer
	 * @return
	 */
	public int countCustomer(ErpCrmCustomer customer);
	
	/**
	 * 查询有合同的客户数量
	 * @return
	 */
	public int countCustomerHasContract();
	
	/**
	 * 查询合同数量
	 * @param contract
	 * @return
	 */
	public int countContract(ErpCrmContract contract);
	/**
	 * 查询合同资金情况
	 * @param contract
	 * @return
	 */
	public BigDecimal countContractFund(ErpCrmContract contract);
	/**
	 * 查询合同回款情况
	 * @param payPlan
	 * @return
	 */
	public BigDecimal countPayPlanFund(ErpCrmContract contract,ErpCrmContractPayPlan plan);
	/**
	 * 查询联系单数量
	 * @param contactOrder
	 * @return
	 */
	public int countContactOrderByStatus(List<String> statusList);
	/**
	 * 查询派工单数量
	 * @param workOrder
	 * @return
	 */
	public int countWorkOrderByStatus(List<String> statusList);
	
	public int countContactOrder(ErpOaContactOrder contactOrder);
	
	public int countWorkOrder(ErpOaWorkOrder workOrder);
}
