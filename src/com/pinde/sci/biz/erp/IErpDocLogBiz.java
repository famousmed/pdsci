package com.pinde.sci.biz.erp;

import java.util.List;

import com.pinde.sci.model.mo.ErpDocLog;


public interface IErpDocLogBiz {

	/**
	 * 文档查阅记录
	 * @param docFlow
	 * @return
	 */
	int docLog(ErpDocLog docLog);
	
	/**
	 * 保存日志记录
	 * @param docLog
	 * @return
	 */
	int save(ErpDocLog docLog);

	/**
	 * 查询日志记录
	 * @param docLog
	 * @return
	 */
	List<ErpDocLog> searchErpDocLogList(ErpDocLog docLog);
	
}
