package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractUserRef;


public interface IErpContractUserRefBiz {
    
	/**
	 * 查询合同联系人标注信息列表
	 * @param ref
	 * @return
	 */
	List<ErpCrmContractUserRef> searchContractUserRefList(ErpCrmContractUserRef ref);
    /**
     * 保存合同联系人抱住信息
     * @param userRef
     * @return
     */
	int saveContractUserRef(ErpCrmContractUserRef userRef);
    
	/**
	 * 查询一条合同联系人
	 * @param recordFlow
	 * @return
	 */
	ErpCrmContractUserRef readContractUserRef(String recordFlow);

}
