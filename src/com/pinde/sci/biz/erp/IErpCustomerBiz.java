package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.erp.CustomerUserForm;
import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpCustomerBiz {
	/**
	 * ����ͻ�����ϵ��
	 * @param customerUserForm
	 * @return
	 */
	int saveCustomerAndUser(CustomerUserForm form);
	
	/**
	 * ����ͻ�
	 * @param customer
	 * @return
	 */
	int saveCustomer(ErpCrmCustomer customer);
	

	/**
	 * �ͻ���ѯ
	 * @param paramMap
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomerList(Map<String, Object> paramMap);
	
	/**
	 * ��ȡһ���ͻ���¼
	 * @param customerFlow
	 * @return
	 */
	ErpCrmCustomer readCustomer(String customerFlow);
	
	/**
	 * ����ͻ�
	 * @param customer
	 * @return
	 */
	int EditCustomer(ErpCrmCustomer customer);
	
	
	/**
	 * ���ݿͻ����Ʋ��ҿͻ�
	 * @param customerName
	 * @return
	 */
	ErpCrmCustomer findCustomerByCustomerName(String customerName);
	
	/**
	 * ��ѯ���������Ŀͻ�
	 * @param customer
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomer(ErpCrmCustomer customer);

	List<InputReportForm> searchCrmInput(Map<String, Object> paramMap);

	List<ErpCrmCustomerUser> searchCustomerUsers(String customerFlow,
			String userName);

}
