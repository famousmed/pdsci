package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractUserExt;

public interface ErpCrmContractUserExtMapper {

	public List<ErpCrmContractUserExt> searchContractUserExtList(Map<String,Object> paramMap);
}
