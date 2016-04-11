package com.pinde.sci.biz.irb;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.model.mo.IrbApply;

public interface IIrbApplyBiz {
	/**
	 * ����������
	 * @param irbFlow
	 * @return
	 */
	public IrbApply queryByFlow(String irbFlow);
	/**
	 * �������޸�
	 * @param irbApply
	 * @return
	 */
	public int edit(IrbApply irbApply);
	/**
	 * ��ѯ�б�
	 * @param form
	 * @return
	 */
	public List<IrbApply> queryList(IrbApplyForm form);
	/**
	 * ��ѯ
	 * @param projFlow
	 */
	List<IrbApply> queryIrbApply(IrbApply irb);
	
	/**
	 * ������Ŀ��ˮ�Ų�ѯ
	 * @param projFlow
	 */
	List<IrbApply> queryIrbApplyListByProjFlows(List<String> projFlowList,String irbTypeId);
	/**
	 * ���Ľ׶�
	 * @param apply
	 */
	void changeStage(IrbApply apply);
	public List<IrbApply> searchIrbList(String userFlow);
	public void modifyIrbApply(IrbApply apply);
	
	/**
	 * ��ѯίԱ�������Ŀ
	 * @param paramMap
	 * @return
	 */
	List<IrbApply> searchCommitteeIrbList(Map<String,Object> paramMap);
	public Integer searchMeetingIrbList(String meetingFlow,String arrange);
	
	/**
	 * ��ѯ����������ڲ�Ϊ�յ����
	 * @return
	 */
	List<IrbApply> searchTrackIrbList();
	
	/**
	 * ��ѯmeetingFlow��Ϊ�յ�IrbApply
	 * @return
	 */
	List<IrbApply> queryIrbMeeting();  
	
	/**
	 * ��ѯ��ǰίԱ������Ŀ��Ϊ��飨������Ϊ�գ������
	 * @param paramMap
	 * @return
	 */
	public List<IrbApply> searchUnReviewIrbs(Map<String, Object> paramMap);
	
	List<IrbApply> searchIrbApply(IrbApply irb);
	public List<IrbApply> queryIrbApply(String startDate, String endDate,
			IrbApply irb);
	/**
	 * ��������ѯ��¼��
	 * @param irb
	 * @return
	 */
	long queryIrbApplyCount(IrbApply irb);
	List<IrbApply> searchIrbs(IrbApply irb);
	List<IrbApply> sortApplyByIrbType(List<IrbApply> applyList);
	/**
	 * ��ѯ���������ύ�������Ŀ��
	 * @param orgFlow
	 * @return
	 */
	int queryIrbApplyCount(String orgFlow);
	List<IrbApply> searchUnDecisionIrbApply(String meetingFlow);
}
