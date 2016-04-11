package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.erp.InputReportForm;
import com.pinde.sci.model.mo.ErpCrmCustomer;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface ErpCrmCustomerExtMapper {
	/**
	 * ��ѯ�ͻ�
	 * @param paramMap
	 * @return
	 */
	List<ErpCrmCustomer> searchCustomerList(Map<String, Object> paramMap);

	List<InputReportForm> searchCrmInput(Map<String, Object> paramMap);
	/**
	 * ����һ����ˮ�Ų�ѯ�ͻ���ϵ��
	 * @param userFlowList
	 * @return
	 */
	List<ErpCrmCustomerUser> searchCustomerUserList(List<String> userFlowList);
	
	public int countCustomerHasContract(Map<String,Object> paramMap);
}
