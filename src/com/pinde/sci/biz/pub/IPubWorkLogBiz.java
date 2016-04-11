package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.model.mo.PubWorkLog;

public interface IPubWorkLogBiz {
	
	/**
	 * ����
	 * @param workLog
	 * @return
	 */
	int saveWorkLog(PubWorkLog workLog);

	/**��ѯ
	 * @param workLog
	 * @return
	 */
	List<PubWorkLog> searchWorkLogList(PubWorkLog workLog, String startDate, String endDate, String withBLOBs);

	/**
	 * ��ȡһ����¼
	 * @param logFlow
	 * @return
	 */
	PubWorkLog readWorkLog(String logFlow);
	
} 
 