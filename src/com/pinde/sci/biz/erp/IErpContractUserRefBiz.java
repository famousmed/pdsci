package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractUserRef;


public interface IErpContractUserRefBiz {
    
	/**
	 * ��ѯ��ͬ��ϵ�˱�ע��Ϣ�б�
	 * @param ref
	 * @return
	 */
	List<ErpCrmContractUserRef> searchContractUserRefList(ErpCrmContractUserRef ref);
    /**
     * �����ͬ��ϵ�˱�ס��Ϣ
     * @param userRef
     * @return
     */
	int saveContractUserRef(ErpCrmContractUserRef userRef);
    
	/**
	 * ��ѯһ����ͬ��ϵ��
	 * @param recordFlow
	 * @return
	 */
	ErpCrmContractUserRef readContractUserRef(String recordFlow);

}
