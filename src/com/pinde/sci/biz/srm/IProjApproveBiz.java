package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjFundPlan;

/**
 * ��Ŀ����׶ε�ҵ���
 * @author shenzhen
 *
 */
public interface IProjApproveBiz {

	/**
	 * ��Ŀ����
	 * 1:������Ŀ�׶�Ϊ����׶� �� ��ͬ��д״̬
	 * 2��process������һ����¼
	 * @param proj ������Ҫ��д��һЩ��Ŀ��Ϣ���µ�proj��
	 * @param remark ����������
	 * @param sug �������
	 */
	void setUp(PubProj proj , String remark , String sug , String setUpXml);
	
	/**
	 * ��ѯ
	 * 
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchApproveProjList(PubProj proj);
	
	/**
	 * ��ѯ�²��б�
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchFundPlanList(PubProj proj);
	
	/**
	 * ������Ŀ����ƻ���������Բ�ѯ��Ŀ����ƻ��б�
	 * @param projFlow
	 * @return
	 */
	public List<PubProjFundPlan> searchProjFundPlanList(PubProjFundPlan projFindPlan);
	
	/**
	 * �²�
	 * @param fundPlan
	 */
	public void addFundPlan(PubProj proj , List<PubProjFundPlan> fundPlans , String flag);
	
	/**
	 * ���������Ų�ѯ
	 * @param projNo
	 * @return
	 */
	List<PubProj> getPubProjByProjNo(String projNo);
	
}
