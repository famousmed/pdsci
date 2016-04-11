package com.pinde.sci.biz.erp;

import java.util.List;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpCustomerUserBiz {
	
	/**
	 * 保存CustomerUser
	 * @param customerUser
	 * @return
	 */
	int saveCustomerUser(ErpCrmCustomerUser customerUser);
	
	/**
	 * 查询联系人信息
	 * @param customerUser
	 * @return
	 */
	List<ErpCrmCustomerUser> searchCustomerUserList(ErpCrmCustomerUser customerUser);
	
	/**
	 * 保存联系人
	 * @param userList
	 * @param customerFlow
	 * @return
	 */
	int saveCustomerUserList(List<ErpCrmCustomerUser> customerUserList,String customerFlow);
	
	/**
	 * 获取一条联系人记录
	 * @param userFlow
	 * @return
	 */
	ErpCrmCustomerUser readCustomerUser(String userFlow);

    /**
     * 根据用户流水号查询客户联系人
     * @param userFlows
     * @return
     */
	List<ErpCrmCustomerUser> searchUsersByUserFlows(String userFlows);
	
	List<ErpCrmCustomerUser> searchCustomerUserList(List<String> userFlowList);
	
    String deleteCustomerUser(String userFlow);

	int updateCustomerUser(ErpCrmCustomerUser customerUser);
}
