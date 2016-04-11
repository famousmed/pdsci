package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;

public interface IProjProcessBiz {
	
	/**
	 * 新增一个process 
	 * @param process
	 */
	public void addProcess(PubProjProcess process);
	
	/**
	 * 根据rec新增process
	 * @param projProcess
	 */
	public void addProcess(PubProjRec rec);
	/**
	 * 新增的重载  用于记录审核的操作
	 * @param rec
	 * @param remark 用于存放审核意见
	 */
	public void addProcess(PubProjRec rec,String remark,String auditContent);
	
	/**
	 * 查询某个项目的申报过程
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchProjProcess(PubProjProcess projProcess);
	
	/**
	 * 
	 * 查询某个项目的审核信息
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchAuditProjProcess(PubProjProcess projProcessm, String orderByClause);
	
	
	/**
	 * 查询立项审核的过程
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchApproveProcess(PubProjProcess projProcess);
	
	/**
	 * 根据流水号集合 一次查询多个项目的记录过程 按照时间降序排序
	 * @param projFlowList
	 * @return
	 */
	public List<PubProjProcess> searchProjProcessByProjFlowList(List<String> projFlowList);
	
	/**
	 * 
	 * 根据条件查询最后一次的符合该条件的操作
	 * @param process
	 * @return
	 */
	public PubProjProcess searchLastProcess(PubProjProcess process);
	
}
