package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpCrmContractPayBalance;

public interface IErpCrmContractPayBalanceBiz {
	 
	/**
	 * 保存
	 * @param balance
	 * @return
	 */
	int save(ErpCrmContractPayBalance balance);
	
	/**
	 * 查询
	 * @param balance
	 * @return
	 */
	List<ErpCrmContractPayBalance> searchBalanceList(ErpCrmContractPayBalance balance);

	/**
	 * 保存到账
	 * @param balance
	 * @return
	 */
	int saveBalance(ErpCrmContractPayBalance balance);
	
}
