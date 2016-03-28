package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbUser;

public interface IIrbUserBiz {
	/**
	 * �������޸�
	 * @param user
	 * @return
	 */
	int edit(IrbUser user);
	/**
	 * ��ѯ�б�
	 * @param user
	 * @return
	 */
	List<IrbUser> queryList(IrbUser user);
	/**
	 * ��ѯ
	 * @param recordFlow
	 * @return
	 */
	IrbUser query(String recordFlow);
	
	/**
	 * ��ѯ��������ίԱ
	 * @param irbFlow
	 * @return
	 */
	List<IrbUser> searchCommitteeList(String irbFlow);
	
	/**
	 * ��ѯ������Ŀ
	 * @return
	 */
	List<IrbUser> queryIrbUserList();
	IrbUser searchConsultant(String irbFlow);
	IrbUser searchCommitteeICF(String irbFlow);
	List<IrbUser> searchCommitteePROList(String irbFlow);
	List<IrbUser> queryIrbUserList(String year);
}
