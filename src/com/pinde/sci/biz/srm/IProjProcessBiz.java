package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;

public interface IProjProcessBiz {
	
	/**
	 * ����һ��process 
	 * @param process
	 */
	public void addProcess(PubProjProcess process);
	
	/**
	 * ����rec����process
	 * @param projProcess
	 */
	public void addProcess(PubProjRec rec);
	/**
	 * ����������  ���ڼ�¼��˵Ĳ���
	 * @param rec
	 * @param remark ���ڴ��������
	 */
	public void addProcess(PubProjRec rec,String remark,String auditContent);
	
	/**
	 * ��ѯĳ����Ŀ���걨����
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchProjProcess(PubProjProcess projProcess);
	
	/**
	 * 
	 * ��ѯĳ����Ŀ�������Ϣ
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchAuditProjProcess(PubProjProcess projProcessm, String orderByClause);
	
	
	/**
	 * ��ѯ������˵Ĺ���
	 * @param projProcess
	 * @return
	 */
	public List<PubProjProcess> searchApproveProcess(PubProjProcess projProcess);
	
	/**
	 * ������ˮ�ż��� һ�β�ѯ�����Ŀ�ļ�¼���� ����ʱ�併������
	 * @param projFlowList
	 * @return
	 */
	public List<PubProjProcess> searchProjProcessByProjFlowList(List<String> projFlowList);
	
	/**
	 * 
	 * ����������ѯ���һ�εķ��ϸ������Ĳ���
	 * @param process
	 * @return
	 */
	public PubProjProcess searchLastProcess(PubProjProcess process);
	
}
