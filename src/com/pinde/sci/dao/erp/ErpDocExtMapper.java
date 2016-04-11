package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;
import com.pinde.sci.model.mo.ErpDoc;

public interface ErpDocExtMapper {
	
	/**
	 * ��ѯ�ĵ�����
	 * @return
	 */
	List<String> searchFileTypeList();

	/**
	 * ��ѯ
	 * @param paramMap
	 * @return
	 */
	List<ErpDoc> searchErpDocList(Map<String, Object> paramMap);

	/**
	 * ����ɾ��
	 * @param docFlowList
	 * @return
	 */
	int batchDelByDocFlowList(List<String> docFlowList);
}
