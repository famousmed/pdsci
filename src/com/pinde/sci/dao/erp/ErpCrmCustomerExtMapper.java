package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface ErpCrmCustomerExtMapper {
	/**
	 * 查询客户
	 * @param paramMap
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomerList(Map<String, Object> paramMap);

	List<InputReportForm> searchCrmInput(Map<String, Object> paramMap);
	/**
	 * 根据一批流水号查询客户联系人
	 * @param userFlowList
	 * @return
	 */
	List<ErpCrmCustomerUser> searchCustomerUserList(List<String> userFlowList);
	
	public int countCustomerHasContract(Map<String,Object> paramMap);
}
