package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.srm.ExpertInfo;

public interface IExpertGroupsUserBiz {
	/**
	 * 传groupFlow(专家流水号) userFlows(用户流水号) 添加到对应的专家组中
	 * @param user
	 * @return
	 */
	public void saveExpertGroupUser(String groupFlow,String [] userFlows);
	/**
	 * 查询专家组中对应的专家信息
	 * @param expertGroupUser
	 * @return
	 */
	public List<ExpertInfo> searchExpertGroupUserInfo(SrmExpertGroupUser expertGroupUser);
	/**
	 * 更新专家组信息
	 * @param expertGroupUser
	 * @return
	 */
	public int updateExpertGroupUser(SrmExpertGroupUser expertGroupUser);
	/**
	 * 查询未加入当前组的专家
	 * @param groupFlow 
	 * @return
	 */
	public List<ExpertInfo> searchSysUserNotInByGroupFlow(String groupFlow);
	/**
	 * 查询未加入当前组并满足查询条件的专家
	 * @param groupFlow
	 * @param expertInfo
	 * @return
	 */
	public List<ExpertInfo> searchSysUserNotInByExpertInfo(String groupFlow, ExpertInfo expertInfo);
	
	/**
	 * 根据条件查询专家和专家组(会议)关联表
	 * @param expertGroupUser
	 * @return
	 */
	public List<SrmExpertGroupUser> searchSrmExpertGroupUser(SrmExpertGroupUser expertGroupUser);
	
	/**
	 * 根据专家和组(会议)流水号(主键)查询专家和组关联信息
	 * @param recordFlow
	 * @return
	 */
	public SrmExpertGroupUser read(String recordFlow);
	
	/**
	 * 专家签到
	 * 1:更新专家和组的关联表中的sing_flag字段 为Y
	 * 2：更新这个组下某个专家被分配的需要评审的所有项目将agreeFlag更新为Y
	 * @param recordFlow
	 */
	public void expertSing(String recordFlow);
	
	
}
