package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmFundProcess;

public interface IFundProcessBiz {
	/**
	 * 保存操作过程
	 * @param fundProcess 
	 * @return
	 */
	void saveFundProcess(SrmFundProcess fundProcess);
	
	/**
	 * 查询操作流程
	 * @param fundFlow 经费流水号
	 * @param statusId 操作状态
	 * @return
	 */
	List<SrmFundProcess> searchFundProcess(String detailFlow,String statusId);
	
	/**
	 * 根据自身条件查询经费过程列表
	 * @param process
	 * @return
	 */
	List<SrmFundProcess> searchFundProcesses(SrmFundProcess process);
    
	SrmFundProcess readFundProcess(SrmFundProcess process);
}
