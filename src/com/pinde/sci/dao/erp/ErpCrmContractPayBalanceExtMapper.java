package com.pinde.sci.dao.erp;

import java.math.BigDecimal;
import java.util.Map;

import com.pinde.sci.model.mo.ErpCrmContractPayBalance;
public interface ErpCrmContractPayBalanceExtMapper {

	BigDecimal getBalanceFund(ErpCrmContractPayBalance payBalance);
	
	BigDecimal countBalanceFund(Map<String,Object> paramMap);
}
