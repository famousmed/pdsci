package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;

public interface IProjMineBiz {
	/**
	 * 查询当前登录用户权限范围项目
	 * 
	 * @param proj
	 * @param currUser
	 * @return
	 */
	public List<PubProj> searchProjList(PubProj proj);

	/**
	 * 保存项目
	 * 
	 * @param proj
	 * @param currUser
	 */
	public void addProjInfo(PubProj proj);
	
	/**
	 * 查询实施阶段报告列表
	 * @param projFlow
	 * @return
	 */
	public List<PubProjRec> searchScheduleReport(String projFlow); 
	/**
	 * 新增rec 同时添加process
	 * @param projRec
	 * @param currUser
	 */
	void addRecAndProcess(PubProjRec projRec);
	/**
	 * 清空recContent
	 * @param projFlow
	 * @param recTypeId
	 */
	public void delRecContent(String projFlow, String recTypeId);
	/**
	 * 送审
	 * 1：在process中新增一条记录
	 * 2：更新proj
	 * @param projProcess
	 * @param currUser
	 */
	void prepareReview(PubProjRec projRec);
	
	/**
	 * 送审 不存在申报书 直接送审项目
	 * 1：在process中新增一条记录
	 * 2：更新proj
	 * @param projProcess
	 * @param currUser
	 */
	void prepareReview(PubProj proj);
	
	/**
	 * 为经费准备的项目查询方法
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchProjListForFund(PubProj proj);
	
	/**
	 * 为填写经费预算准备的查询方法(院版)
	 * @return
	 */
	public List<PubProj> searchProjListForBudget(PubProj proj);

	/**
	 * 查询项目数
	 * @param proj
	 * @return
	 */
	int searchProjCount(PubProj proj);

}
