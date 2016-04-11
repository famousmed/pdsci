package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubWorkLog;

public interface IPubWorkLogBiz {
	
	/**
	 * 保存
	 * @param workLog
	 * @return
	 */
	int saveWorkLog(PubWorkLog workLog);

	/**查询
	 * @param workLog
	 * @return
	 */
	List<PubWorkLog> searchWorkLogList(PubWorkLog workLog, String startDate, String endDate, String withBLOBs);

	/**
	 * 获取一条记录
	 * @param logFlow
	 * @return
	 */
	PubWorkLog readWorkLog(String logFlow);
	
} 
 