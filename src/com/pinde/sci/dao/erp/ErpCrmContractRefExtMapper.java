package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractRefExt;

public interface ErpCrmContractRefExtMapper {

	/**
	 * 查询已合同关联的主合同
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractRefExt> searchContractListByRef(Map<String,Object> paramMap);
}
