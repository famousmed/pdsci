package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.srm.ExpertInfo;

public interface IExpertGroupsUserBiz {
	/**
	 * ��groupFlow(ר����ˮ��) userFlows(�û���ˮ��) ��ӵ���Ӧ��ר������
	 * @param user
	 * @return
	 */
	public void saveExpertGroupUser(String groupFlow,String [] userFlows);
	/**
	 * ��ѯר�����ж�Ӧ��ר����Ϣ
	 * @param expertGroupUser
	 * @return
	 */
	public List<ExpertInfo> searchExpertGroupUserInfo(SrmExpertGroupUser expertGroupUser);
	/**
	 * ����ר������Ϣ
	 * @param expertGroupUser
	 * @return
	 */
	public int updateExpertGroupUser(SrmExpertGroupUser expertGroupUser);
	/**
	 * ��ѯδ���뵱ǰ���ר��
	 * @param groupFlow 
	 * @return
	 */
	public List<ExpertInfo> searchSysUserNotInByGroupFlow(String groupFlow);
	/**
	 * ��ѯδ���뵱ǰ�鲢�����ѯ������ר��
	 * @param groupFlow
	 * @param expertInfo
	 * @return
	 */
	public List<ExpertInfo> searchSysUserNotInByExpertInfo(String groupFlow, ExpertInfo expertInfo);
	
	/**
	 * ����������ѯר�Һ�ר����(����)������
	 * @param expertGroupUser
	 * @return
	 */
	public List<SrmExpertGroupUser> searchSrmExpertGroupUser(SrmExpertGroupUser expertGroupUser);
	
	/**
	 * ����ר�Һ���(����)��ˮ��(����)��ѯר�Һ��������Ϣ
	 * @param recordFlow
	 * @return
	 */
	public SrmExpertGroupUser read(String recordFlow);
	
	/**
	 * ר��ǩ��
	 * 1:����ר�Һ���Ĺ������е�sing_flag�ֶ� ΪY
	 * 2�������������ĳ��ר�ұ��������Ҫ�����������Ŀ��agreeFlag����ΪY
	 * @param recordFlow
	 */
	public void expertSing(String recordFlow);
	
	
}
