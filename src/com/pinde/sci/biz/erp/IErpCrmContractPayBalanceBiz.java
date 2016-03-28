package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractPayBalance;

public interface IErpCrmContractPayBalanceBiz {
	 
	/**
	 * ����
	 * @param balance
	 * @return
	 */
	int save(ErpCrmContractPayBalance balance);
	
	/**
	 * ��ѯ
	 * @param balance
	 * @return
	 */
	List<ErpCrmContractPayBalance> searchBalanceList(ErpCrmContractPayBalance balance);

	/**
	 * ���浽��
	 * @param balance
	 * @return
	 */
	int saveBalance(ErpCrmContractPayBalance balance);
	
}
