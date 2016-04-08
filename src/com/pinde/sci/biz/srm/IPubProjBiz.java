package com.pinde.sci.biz.srm;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubFile;
import com.pinde.sci.model.mo.PubPatient;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.srm.PubProjExt;
import com.pinde.sci.model.srm.ReportForm;

public interface IPubProjBiz {

	/**
	 * 更新项目信息的重载
	 * 
	 * @param proj
	 * @param currUser
	 */
	public void modProject(PubProj proj);
	
	/**
	 * 根据项目流水号读取项目信息
	 * @param projFlow
	 * @return
	 */
	public PubProj readProject(String projFlow);
	
	/**
	 * 查询项目 关联机构表 查询结果是该机构下所有的项目(包过子机构下的项目 一般用于上级单位查询)
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchPubProjList(PubProj proj);
	
	/**
	 * 查询某个项目的下拨计划情况
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> searchPubProjListForFundPlan(Map<Object , Object> paramMap);
	
	/**
	 * 查询全部  (irb 和 ResumeController 用到了 SRM没用到)
	 * @return
	 */
	public List<PubProj> queryProjList(PubProj proj);

	/**
	 * 根据多个流水号查询项目列表(IRB用到了 SRM没用到)
	 * @param projFlows
	 * @return
	 */
	List<PubProj> searchProjByProjFlows(List<String> projFlows);
	
	/**
	 * 从项目表单中获取文件信息
	 * @param resultMap
	 * @return
	 */
	Map<String , PubFile> getFile(Map<String , Object> resultMap);
	/**
	 * 从项目表单中获取文件流水号
	 * @param resultMap
	 * @return
	 */
	List<String> getFileFlows(Map<String , Object> resultMap);

	PubProj readProjectNoBlogs(String projFlow);
	
	/**
	 * 查询项目列表（基本信息包含大字段）
	 * @param proj
	 * @return
	 */
	List<PubProj> searchProjListWithBlob(PubProj proj);
	/**
	 * 查询列表
	 * @param projExt
	 * @return
	 */
	List<PubProj> queryProjList(PubProjExt projExt);
	
	/**
	 * 报表查询
	 * @return
	 */
	List<ReportForm> findReportForm(PubProj proj);

	public List<PubPatient> searchPubProjListByPatientCode(String projFlow,
			String patientCode, Map<String, PubProj> projMap);

}
