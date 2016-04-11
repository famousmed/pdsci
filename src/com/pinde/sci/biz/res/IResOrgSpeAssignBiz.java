package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResOrgSpeAssign;


public interface IResOrgSpeAssignBiz {

	List<ResOrgSpeAssign> searchSpeAssign(String assignYear);

	int editSpeAssign(ResOrgSpeAssign speAssign);
	
	/**
	 * ���ݻ�����ˮ�ź���� ��ѯָ�����ĳ��ҽԺ������רҵ
	 * @param orgFlow
	 * @param assignYear
	 * @return
	 */
	List<ResOrgSpeAssign> searchSpeAssign(String orgFlow , String assignYear);
	
	ResOrgSpeAssign searchSpeAssign(String orgFlow , String assignYear , String speId);
	
	/**
	 * ����������ѯרҵ
	 * @param flow
	 * @return
	 */
	ResOrgSpeAssign findSpeAssignByFlow(String flow);

	int editSpeAssignUnSelective(ResOrgSpeAssign speAssign);
	
	/**
	 * ��ѯָ��רҵ������ҽԺ��¼�ƻ�
	 * @param speId
	 * @return
	 */
	List<ResOrgSpeAssign> searchSpeAssignBySpeIdAndYear(String speId , String year);
	

	
}
