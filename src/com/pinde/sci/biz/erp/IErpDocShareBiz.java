package com.pinde.sci.biz.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpDocShareExt;
import com.pinde.sci.model.mo.ErpDocShare;

/**
 * @author tiger
 *
 */
/**
 * @author tiger
 *
 */
public interface IErpDocShareBiz{
	
	/**
	 * ����ErpDocShare
	 * @param erpDocShare
	 * @return
	 */
	int saveErpDocShare(ErpDocShare erpDocShare);

	/**
	 * ��ѯ
	 * @param docShare
	 * @return
	 */
	List<ErpDocShare> searchErpDocShareList(ErpDocShare docShare);
	
	
	/**
	 * ��������
	 * @param docFlow
	 * @param docShare
	 * @return
	 */
	String batchShare(String[] docFlow, String shareTypeId, String shareRecordFlow, String shareRecordName, String recordStatus);

	/**
	 * ��ѯ�����ĵ�
	 * @param paramMap
	 * @return
	 */
	List<ErpDocShareExt> searchErpDocShareExtList(Map<String, Object> paramMap);
	
}
