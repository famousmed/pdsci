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
	 * ������Ŀ��Ϣ������
	 * 
	 * @param proj
	 * @param currUser
	 */
	public void modProject(PubProj proj);
	
	/**
	 * ������Ŀ��ˮ�Ŷ�ȡ��Ŀ��Ϣ
	 * @param projFlow
	 * @return
	 */
	public PubProj readProject(String projFlow);
	
	/**
	 * ��ѯ��Ŀ ���������� ��ѯ����Ǹû��������е���Ŀ(�����ӻ����µ���Ŀ һ�������ϼ���λ��ѯ)
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchPubProjList(PubProj proj);
	
	/**
	 * ��ѯĳ����Ŀ���²��ƻ����
	 * @param paramMap
	 * @return
	 */
	public List<PubProj> searchPubProjListForFundPlan(Map<Object , Object> paramMap);
	
	/**
	 * ��ѯȫ��  (irb �� ResumeController �õ��� SRMû�õ�)
	 * @return
	 */
	public List<PubProj> queryProjList(PubProj proj);

	/**
	 * ���ݶ����ˮ�Ų�ѯ��Ŀ�б�(IRB�õ��� SRMû�õ�)
	 * @param projFlows
	 * @return
	 */
	List<PubProj> searchProjByProjFlows(List<String> projFlows);
	
	/**
	 * ����Ŀ���л�ȡ�ļ���Ϣ
	 * @param resultMap
	 * @return
	 */
	Map<String , PubFile> getFile(Map<String , Object> resultMap);
	/**
	 * ����Ŀ���л�ȡ�ļ���ˮ��
	 * @param resultMap
	 * @return
	 */
	List<String> getFileFlows(Map<String , Object> resultMap);

	PubProj readProjectNoBlogs(String projFlow);
	
	/**
	 * ��ѯ��Ŀ�б�������Ϣ�������ֶΣ�
	 * @param proj
	 * @return
	 */
	List<PubProj> searchProjListWithBlob(PubProj proj);
	/**
	 * ��ѯ�б�
	 * @param projExt
	 * @return
	 */
	List<PubProj> queryProjList(PubProjExt projExt);
	
	/**
	 * �����ѯ
	 * @return
	 */
	List<ReportForm> findReportForm(PubProj proj);

	public List<PubPatient> searchPubProjListByPatientCode(String projFlow,
			String patientCode, Map<String, PubProj> projMap);

}
