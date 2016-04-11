package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractUserExt;
import com.pinde.sci.model.mo.ErpCrmContractUser;
import com.pinde.sci.model.mo.ErpCrmContractUserRef;
import com.pinde.sci.model.mo.ErpCrmCustomerUser;

public interface IErpContractUserBiz {

	/**
	 * �����ͬ��ϵ��
	 * @param userList
	 * @return
	 */
	public String saveCustomerAndContractUser(List<ErpCrmCustomerUser> userList,String contractFlow);
	/**
	 * ��ѯ��ͬ��ϵ��
	 * @param user
	 * @return
	 */
	public List<ErpCrmContractUser> searchContractUserList(ErpCrmContractUser user);
	/**
	 * �޸ĺ�ͬ��ϵ��
	 * @param user
	 * @return
	 */
	public int saveOneContractUser(ErpCrmContractUser user,ErpCrmCustomerUser customerUser);
	/**
	 * �޸ĺ�ͬ��ϵ��
	 * @param user
	 * @return
	 */
	public int saveContractUser(ErpCrmContractUser user);
	/**
	 * ��ѯ��ͬ��ϵ����ϸ��Ϣ
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
	 * ��ѯ��ͬ��ϵ���б�
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractUserExt> searchContractUserExtList(Map<String,Object> paramMap);
	/**
	 * ��ѯ��ͬ��ϵ�˵���Ա���
	 * @param contractFlow
	 * @return
	 */
	Map<String, String> searchUserCategoryMap(String contractFlow);
}
