package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpDocLog;


public interface IErpDocLogBiz {

	/**
	 * �ĵ����ļ�¼
	 * @param docFlow
	 * @return
	 */
	int docLog(ErpDocLog docLog);
	
	/**
	 * ������־��¼
	 * @param docLog
	 * @return
	 */
	int save(ErpDocLog docLog);

	/**
	 * ��ѯ��־��¼
	 * @param docLog
	 * @return
	 */
	List<ErpDocLog> searchErpDocLogList(ErpDocLog docLog);
	
}
