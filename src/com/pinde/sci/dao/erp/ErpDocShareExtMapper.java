package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;
import com.pinde.sci.model.erp.ErpDocShareExt;

public interface ErpDocShareExtMapper {

	/**
	 * ��ѯ�����ĵ�
	 * @param paramMap
	 * @return
	 */
	List<ErpDocShareExt> searchErpDocShareExtList(Map<String, Object> paramMap);
}
