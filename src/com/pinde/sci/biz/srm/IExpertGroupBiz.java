package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupUser;

public interface IExpertGroupBiz {
	/**
	 * ������ˮ�Ų���ר����(Ψһ)
	 * @param groupFlow
	 * @return
	 */
	public SrmExpertGroup readSrmExpertGroup(String groupFlow);
	/**
	 * ����ר����
	 * @param expert
	 * @return
	 */
	public int saveExpertGroup(SrmExpertGroup expertGroup);
	
	/**
	 * ɾ��ר����/����
	 * @param expertGroup
	 */
	public void deleteExpertGroup(SrmExpertGroup srmExpertGroup);
	/**
	 * ��ѯ����ר����Ϣ
	 * @param expert
	 * @return
	 */
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert);
	
	/**
	 * ��ѯ������Ϣ (��ĳ��ʱ���)
	 * @param expert
	 * @return
	 */
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert , String startDate , String endDate);
	
	/**
	 * ��ѯ��ʼʱ��ͽ���ʱ���ʱ��ֵ
	 * @param currDateTime
	 * @return
	 */
	//public List<SrmExpertGroup> searchExpert(String currDateTime);
	
	/**
	 * �ڻ��������������Ŀ
	 * ͬʱ�û������Ѿ����ڵ�ר�Ҷ�Ҫ���������ӵ�������Ŀ����
	 * @param groupFlow
	 * @param evalSetFlow
	 */
	public void addEvalProj(String groupFlow , String evalSetFlow);
	
	/**
	 * �ڻ������������ר��
	 * ͬʱ�û�������Ҫ�������Ŀ����������ӵ�����ίԱ����
	 * @param groupFlow
	 * @param userFlow
	 */
	public void addEvalExpert(String groupFlow,String [] userFlow);
	
	/**
	 * ɾ���û����ϵ�ĳ��ר��
	 * ͬʱȡ������ר�������������Ҫ�����������Ŀ�Ĺ���
	 * @param expertGroupUser
	 */
	public void delEvalExpert(SrmExpertGroupUser expertGroupUser);
	
	/**
	 * ȡ����Ŀ�ڻ����ϵ�����
	 * ͬʱȡ������Ŀ���������������ר�ҵĹ���
	 * @param evalSetFlow
	 */
	public void delEvalProj(String evalSetFlow);
	
}
