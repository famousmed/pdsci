package com.pinde.sci.biz.gcp;

import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;

import com.pinde.sci.form.gcp.GCPMonitorForm;
import com.pinde.sci.form.gcp.GcpCfgFileForm;
import com.pinde.sci.form.gcp.GcpIrbForm;
import com.pinde.sci.model.irb.ProjInfoForm;
import com.pinde.sci.model.irb.ProjOrgForm;
import com.pinde.sci.model.mo.GcpRec;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjProcessExample;
import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysUser;

public interface IGcpProjBiz {
	/**
	 * 新增伦理
	 * @param form
	 * @return
	 */
	int saveIrb(GcpIrbForm form);
	/**
	 * 查询病人数量
	 * @param projFlow 项目流水号
	 * @return
	 */
	Map<String, Object> searchPatientCount(String projFlow, String orgFlow);
	/**
	 * 更改阶段或状态
	 * @param process
	 * @return
	 */
	int changeProj(PubProjProcess process);
	
	/**
	 * 查询项目列表
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	List<ProjInfoForm> searchProjFormList(PubProj proj) throws Exception;

	
	/**
	 * 查询一般信息
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	ProjInfoForm searchGeneralInfo(String projFlow) throws Exception;
	
	/**
	 * 保存项目信息
	 * @param proj
	 * @param projInfoForm
	 * @return
	 */
	String addProjInfo(PubProj proj, ProjInfoForm projInfoForm);
	
	/**
	 * 修改项目信息
	 * @param proj
	 * @return
	 */
	int modifyProj(PubProj proj);
	
	/**
	 * 保存项目 项目来源/CRO
	 * @param projInfo
	 * @param projInfoForm
	 * @return
	 */
	int addSponsor(PubProj proj, ProjInfoForm projInfoForm);
	
	/**
	 * 查询 项目来源/CRO
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	ProjInfoForm searchDeclarerAndCRO(String projFlow) throws Exception;
	
	/**
	 * 保存
	 * @param proj 
	 * @param projOrgForm
	 * @param projInfoForm
	 * @return
	 */
	int addResearchOrg(ProjOrgForm projOrgForm, String projFlow);
	
	/**
	 * 查询 临床试验负责单位联系人
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	ProjOrgForm searchLeader(String projFlow) throws Exception;
	
	
	/**
	 * 保存项目和研究者
	 * @param proj
	 * @param projUser
	 * @return
	 */
	int saveProjAndProjUser(PubProj proj, PubProjUser projUser);

	/**
	 * 保存监督者
	 * @param monitorListForm
	 * @param searchProj
	 * @return
	 * @throws Exception 
	 */
	int saveMonitor(List<GCPMonitorForm> monitorFormList, String projFlow) throws Exception;
	
	/**
	 * 查询 监察员
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	List<GCPMonitorForm> searchMonitor(String projFlow) throws Exception;
	/**
	 * 删除  监察员
	 * @param ids
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	int delMonitorByIds(String[] ids, String projFlow) throws Exception;
	/**
	 * 审核意见列表
	 * @param projFlow
	 * @return
	 */
	List<PubProjProcess> optionList(String projFlow);
	/**
	 * 获取用户gcp培训日期
	 * @param userList
	 * @return
	 */
	Map<String,String> searchGcpTrainDate(List<SysUser> userList);
	/**
	 * 按条件统计项目数
	 * @param proj
	 * @return
	 */
	int count(PubProj proj);
	/**
	 * 统计机构下各类别项目数
	 * @param orgFlow 
	 * @return
	 */
	Map<String,Integer> countOrgProj(String orgFlow);
	/**
	 * 统计机构机构主界面相关数据
	 * @param orgFlow
	 * @return
	 */
	Map<String,Object> countOrgData(String orgFlow);
	int saveResearcher(String userFlow,String projFlow,String deptFlow);
	
	int saveArchiveToRec(List<GcpCfgFileForm> fileFormList,GcpRec gcpRec) throws DocumentException;
	List<PubProj> searchProjList(PubProj proj);
	PubProj readProject(String projFlow);
	List<ProjInfoForm> searchProjFormList(List<String> projFlows);
	List<PubProj> queryTerminateProjList();
	Map<String, ProjInfoForm> projInfoFormMap(List<PubProj> projList)
			throws Exception;
	List<PubProjProcess> searchProjProcess(String projFlow); 
	void saveProcess(PubProjProcess process);
	List<PubProjProcess> searchProjProcessExample(PubProjProcessExample example);
}
