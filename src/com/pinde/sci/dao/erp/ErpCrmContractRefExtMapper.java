package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpCrmContractRefExt;

public interface ErpCrmContractRefExtMapper {

	/**
	 * ��ѯ�Ѻ�ͬ����������ͬ
	 * @param paramMap
	 * @return
	 */
	public List<ErpCrmContractRefExt> searchContractListByRef(Map<String,Object> paramMap);
}
