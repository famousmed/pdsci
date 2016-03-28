package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;

public interface IProjMineBiz {
	/**
	 * ��ѯ��ǰ��¼�û�Ȩ�޷�Χ��Ŀ
	 * 
	 * @param proj
	 * @param currUser
	 * @return
	 */
	public List<PubProj> searchProjList(PubProj proj);

	/**
	 * ������Ŀ
	 * 
	 * @param proj
	 * @param currUser
	 */
	public void addProjInfo(PubProj proj);
	
	/**
	 * ��ѯʵʩ�׶α����б�
	 * @param projFlow
	 * @return
	 */
	public List<PubProjRec> searchScheduleReport(String projFlow); 
	/**
	 * ����rec ͬʱ���process
	 * @param projRec
	 * @param currUser
	 */
	void addRecAndProcess(PubProjRec projRec);
	/**
	 * ���recContent
	 * @param projFlow
	 * @param recTypeId
	 */
	public void delRecContent(String projFlow, String recTypeId);
	/**
	 * ����
	 * 1����process������һ����¼
	 * 2������proj
	 * @param projProcess
	 * @param currUser
	 */
	void prepareReview(PubProjRec projRec);
	
	/**
	 * ���� �������걨�� ֱ��������Ŀ
	 * 1����process������һ����¼
	 * 2������proj
	 * @param projProcess
	 * @param currUser
	 */
	void prepareReview(PubProj proj);
	
	/**
	 * Ϊ����׼������Ŀ��ѯ����
	 * @param proj
	 * @return
	 */
	public List<PubProj> searchProjListForFund(PubProj proj);
	
	/**
	 * Ϊ��д����Ԥ��׼���Ĳ�ѯ����(Ժ��)
	 * @return
	 */
	public List<PubProj> searchProjListForBudget(PubProj proj);

	/**
	 * ��ѯ��Ŀ��
	 * @param proj
	 * @return
	 */
	int searchProjCount(PubProj proj);

}
