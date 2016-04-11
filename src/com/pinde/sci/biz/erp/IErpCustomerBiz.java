package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.erp.CustomerUserForm;
import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpCustomerBiz {
	/**
	 * 保存客户及联系人
	 * @param customerUserForm
	 * @return
	 */
	int saveCustomerAndUser(CustomerUserForm form);
	
	/**
	 * 保存客户
	 * @param customer
	 * @return
	 */
	int saveCustomer(ErpCrmCustomer customer);
	

	/**
	 * 客户查询
	 * @param paramMap
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomerList(Map<String, Object> paramMap);
	
	/**
	 * 获取一条客户记录
	 * @param customerFlow
	 * @return
	 */
	ErpCrmCustomer readCustomer(String customerFlow);
	
	/**
	 * 保存客户
	 * @param customer
	 * @return
	 */
	int EditCustomer(ErpCrmCustomer customer);
	
	
	/**
	 * 根据客户名称查找客户
	 * @param customerName
	 * @return
	 */
	ErpCrmCustomer findCustomerByCustomerName(String customerName);
	
	/**
	 * 查询符合条件的客户
	 * @param customer
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomer(ErpCrmCustomer customer);

	List<InputReportForm> searchCrmInput(Map<String, Object> paramMap);

	List<ErpCrmCustomerUser> searchCustomerUsers(String customerFlow,
			String userName);

}
