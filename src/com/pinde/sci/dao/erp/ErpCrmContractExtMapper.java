package com.pinde.sci.dao.erp;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractExt;

public interface ErpCrmContractExtMapper {
    /**
     * 查询合同及其客户信息
     * @param paramMap
     * @return
     */
	public List<ErpCrmContractExt> searchContractList(Map<String,Object> paramMap);

	public List<ErpCrmContractExt> searchContracts(Map<String, Object> paramMap);
	
	public BigDecimal countContractFundNumber(Map<String,Object> paramMap);
	
}
