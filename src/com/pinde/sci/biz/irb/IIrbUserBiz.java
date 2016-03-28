package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.model.mo.IrbUser;

public interface IIrbUserBiz {
	/**
	 * 新增和修改
	 * @param user
	 * @return
	 */
	int edit(IrbUser user);
	/**
	 * 查询列表
	 * @param user
	 * @return
	 */
	List<IrbUser> queryList(IrbUser user);
	/**
	 * 查询
	 * @param recordFlow
	 * @return
	 */
	IrbUser query(String recordFlow);
	
	/**
	 * 查询审查的主审委员
	 * @param irbFlow
	 * @return
	 */
	List<IrbUser> searchCommitteeList(String irbFlow);
	
	/**
	 * 查询主审项目
	 * @return
	 */
	List<IrbUser> queryIrbUserList();
	IrbUser searchConsultant(String irbFlow);
	IrbUser searchCommitteeICF(String irbFlow);
	List<IrbUser> searchCommitteePROList(String irbFlow);
	List<IrbUser> queryIrbUserList(String year);
}
