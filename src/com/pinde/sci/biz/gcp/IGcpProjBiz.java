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
	 * ��������
	 * @param form
	 * @return
	 */
	int saveIrb(GcpIrbForm form);
	/**
	 * ��ѯ��������
	 * @param projFlow ��Ŀ��ˮ��
	 * @return
	 */
	Map<String, Object> searchPatientCount(String projFlow, String orgFlow);
	/**
	 * ���Ľ׶λ�״̬
	 * @param process
	 * @return
	 */
	int changeProj(PubProjProcess process);
	
	/**
	 * ��ѯ��Ŀ�б�
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	List<ProjInfoForm> searchProjFormList(PubProj proj) throws Exception;

	
	/**
	 * ��ѯһ����Ϣ
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	ProjInfoForm searchGeneralInfo(String projFlow) throws Exception;
	
	/**
	 * ������Ŀ��Ϣ
	 * @param proj
	 * @param projInfoForm
	 * @return
	 */
	String addProjInfo(PubProj proj, ProjInfoForm projInfoForm);
	
	/**
	 * �޸���Ŀ��Ϣ
	 * @param proj
	 * @return
	 */
	int modifyProj(PubProj proj);
	
	/**
	 * ������Ŀ ��Ŀ��Դ/CRO
	 * @param projInfo
	 * @param projInfoForm
	 * @return
	 */
	int addSponsor(PubProj proj, ProjInfoForm projInfoForm);
	
	/**
	 * ��ѯ ��Ŀ��Դ/CRO
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	ProjInfoForm searchDeclarerAndCRO(String projFlow) throws Exception;
	
	/**
	 * ����
	 * @param proj 
	 * @param projOrgForm
	 * @param projInfoForm
	 * @return
	 */
	int addResearchOrg(ProjOrgForm projOrgForm, String projFlow);
	
	/**
	 * ��ѯ �ٴ����鸺��λ��ϵ��
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	ProjOrgForm searchLeader(String projFlow) throws Exception;
	
	
	/**
	 * ������Ŀ���о���
	 * @param proj
	 * @param projUser
	 * @return
	 */
	int saveProjAndProjUser(PubProj proj, PubProjUser projUser);

	/**
	 * ����ල��
	 * @param monitorListForm
	 * @param searchProj
	 * @return
	 * @throws Exception 
	 */
	int saveMonitor(List<GCPMonitorForm> monitorFormList, String projFlow) throws Exception;
	
	/**
	 * ��ѯ ���Ա
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	List<GCPMonitorForm> searchMonitor(String projFlow) throws Exception;
	/**
	 * ɾ��  ���Ա
	 * @param ids
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	int delMonitorByIds(String[] ids, String projFlow) throws Exception;
	/**
	 * �������б�
	 * @param projFlow
	 * @return
	 */
	List<PubProjProcess> optionList(String projFlow);
	/**
	 * ��ȡ�û�gcp��ѵ����
	 * @param userList
	 * @return
	 */
	Map<String,String> searchGcpTrainDate(List<SysUser> userList);
	/**
	 * ������ͳ����Ŀ��
	 * @param proj
	 * @return
	 */
	int count(PubProj proj);
	/**
	 * ͳ�ƻ����¸������Ŀ��
	 * @param orgFlow 
	 * @return
	 */
	Map<String,Integer> countOrgProj(String orgFlow);
	/**
	 * ͳ�ƻ��������������������
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
