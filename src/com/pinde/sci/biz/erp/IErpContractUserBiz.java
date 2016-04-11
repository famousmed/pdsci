package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractUserExt;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpContractUserBiz {

	/**
	 * 保存合同联系人
	 * @param userList
	 * @return
	 */
	public String saveCustomerAndContractUser(List<ErpCrmCustomerUser> userList,String contractFlow);
	/**
	 * 查询合同联系人
	 * @param user
	 * @return
	 */
	public List<ErpCrmContractUser> searchContractUserList(ErpCrmContractUser user);
	/**
	 * 修改合同联系人
	 * @param user
	 * @return
	 */
	public int saveOneContractUser(ErpCrmContractUser user,ErpCrmCustomerUser customerUser);
	/**
	 * 修改合同联系人
	 * @param user
	 * @return
	 */
	public int saveContractUser(ErpCrmContractUser user);
	/**
	 * 查询合同联系人详细信息
	 * @param userFlow
	 * @return
	 */
	public ErpCrmContractUser readContractUser(String userFlow);
	List<ErpCrmContractUser> searchContractUsers(String contractFlow,
			String userName);
	String updateContractUsers(String[] recordFlows);
	
	public int deleteContractUser(String recordFlow);
	void updateUser(ErpCrmContractUser user, Boolean newUser,ErpCrmContractUserRef userRef,
			List<ErpCrmContractUserRef> userRefList);
	/**
	 * 查询合同联系人列表
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractUserExt> searchContractUserExtList(Map<String,Object> paramMap);
	/**
	 * 查询合同联系人的人员类别
	 * @param contractFlow
	 * @return
	 */
	Map<String, String> searchUserCategoryMap(String contractFlow);
}
