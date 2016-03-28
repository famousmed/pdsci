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
	 * 保存ErpDocShare
	 * @param erpDocShare
	 * @return
	 */
	int saveErpDocShare(ErpDocShare erpDocShare);

	/**
	 * 查询
	 * @param docShare
	 * @return
	 */
	List<ErpDocShare> searchErpDocShareList(ErpDocShare docShare);
	
	
	/**
	 * 批量共享
	 * @param docFlow
	 * @param docShare
	 * @return
	 */
	String batchShare(String[] docFlow, String shareTypeId, String shareRecordFlow, String shareRecordName, String recordStatus);

	/**
	 * 查询共享文档
	 * @param paramMap
	 * @return
	 */
	List<ErpDocShareExt> searchErpDocShareExtList(Map<String, Object> paramMap);
	
}
