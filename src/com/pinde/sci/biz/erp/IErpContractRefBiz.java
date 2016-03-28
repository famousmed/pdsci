package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.erp.ErpCrmContractRefExt;
import com.pinde.sci.model.mo.ErpCrmContractRef;

public interface IErpContractRefBiz {
    /**
     * 保存合同关联记录
     * @param refList
     * @return
     */
	public String saveRefList(List<ErpCrmContractRef> refList,String contractFlow);
	/**
	 * 查询一合同关联的主合同
	 * @param subContractFlow
	 * @return
	 */
	public List<ErpCrmContractRefExt> searchContractListByRef(String subContractFlow,String contractFlow);
	/**
	 * 查询合同关联记录
	 * @param ref
	 * @return
	 */
	public List<ErpCrmContractRef> searchRefList(ErpCrmContractRef ref);
	
	/**
	 * 查询所有状态为Y和N的合同关联记录
	 * @param ref
	 * @return
	 */
	public List<ErpCrmContractRef> searchAllRefList(ErpCrmContractRef ref);
	/**
	 * 修改某合同所有关联记录状态
	 * @param contractFlow
	 * @return
	 */
	public String updateOneContractRef(String contractFlow);
	
}
