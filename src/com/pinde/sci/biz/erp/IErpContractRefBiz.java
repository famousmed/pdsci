package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.erp.ErpCrmContractRefExt;
import com.pinde.sci.model.mo.ErpCrmContractRef;

public interface IErpContractRefBiz {
    /**
     * �����ͬ������¼
     * @param refList
     * @return
     */
	public String saveRefList(List<ErpCrmContractRef> refList,String contractFlow);
	/**
	 * ��ѯһ��ͬ����������ͬ
	 * @param subContractFlow
	 * @return
	 */
	public List<ErpCrmContractRefExt> searchContractListByRef(String subContractFlow,String contractFlow);
	/**
	 * ��ѯ��ͬ������¼
	 * @param ref
	 * @return
	 */
	public List<ErpCrmContractRef> searchRefList(ErpCrmContractRef ref);
	
	/**
	 * ��ѯ����״̬ΪY��N�ĺ�ͬ������¼
	 * @param ref
	 * @return
	 */
	public List<ErpCrmContractRef> searchAllRefList(ErpCrmContractRef ref);
	/**
	 * �޸�ĳ��ͬ���й�����¼״̬
	 * @param contractFlow
	 * @return
	 */
	public String updateOneContractRef(String contractFlow);
	
}
