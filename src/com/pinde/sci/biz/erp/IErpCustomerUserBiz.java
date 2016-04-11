package com.pinde.sci.biz.erp;

import java.util.List;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpCustomerUserBiz {
	
	/**
	 * ����CustomerUser
	 * @param customerUser
	 * @return
	 */
	int saveCustomerUser(ErpCrmCustomerUser customerUser);
	
	/**
	 * ��ѯ��ϵ����Ϣ
	 * @param customerUser
	 * @return
	 */
	List<ErpCrmCustomerUser> searchCustomerUserList(ErpCrmCustomerUser customerUser);
	
	/**
	 * ������ϵ��
	 * @param userList
	 * @param customerFlow
	 * @return
	 */
	int saveCustomerUserList(List<ErpCrmCustomerUser> customerUserList,String customerFlow);
	
	/**
	 * ��ȡһ����ϵ�˼�¼
	 * @param userFlow
	 * @return
	 */
	ErpCrmCustomerUser readCustomerUser(String userFlow);

    /**
     * �����û���ˮ�Ų�ѯ�ͻ���ϵ��
     * @param userFlows
     * @return
     */
	List<ErpCrmCustomerUser> searchUsersByUserFlows(String userFlows);
	
	List<ErpCrmCustomerUser> searchCustomerUserList(List<String> userFlowList);
	
    String deleteCustomerUser(String userFlow);

	int updateCustomerUser(ErpCrmCustomerUser customerUser);
}
