package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupUser;

public interface IExpertGroupBiz {
	/**
	 * 根据流水号查找专家组(唯一)
	 * @param groupFlow
	 * @return
	 */
	public SrmExpertGroup readSrmExpertGroup(String groupFlow);
	/**
	 * 增加专家组
	 * @param expert
	 * @return
	 */
	public int saveExpertGroup(SrmExpertGroup expertGroup);
	
	/**
	 * 删除专家组/会议
	 * @param expertGroup
	 */
	public void deleteExpertGroup(SrmExpertGroup srmExpertGroup);
	/**
	 * 查询加载专家信息
	 * @param expert
	 * @return
	 */
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert);
	
	/**
	 * 查询会议信息 (在某个时间段)
	 * @param expert
	 * @return
	 */
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert , String startDate , String endDate);
	
	/**
	 * 查询开始时间和结束时间的时间值
	 * @param currDateTime
	 * @return
	 */
	//public List<SrmExpertGroup> searchExpert(String currDateTime);
	
	/**
	 * 在会议上添加评审项目
	 * 同时该会议上已经存在的专家都要跟这个新添加的评审项目关联
	 * @param groupFlow
	 * @param evalSetFlow
	 */
	public void addEvalProj(String groupFlow , String evalSetFlow);
	
	/**
	 * 在会议上添加评审专家
	 * 同时该会议上需要评审的项目都得这新添加的评审委员关联
	 * @param groupFlow
	 * @param userFlow
	 */
	public void addEvalExpert(String groupFlow,String [] userFlow);
	
	/**
	 * 删除该会议上的某个专家
	 * 同时取消掉该专家在这个会议上要评审的所有项目的关联
	 * @param expertGroupUser
	 */
	public void delEvalExpert(SrmExpertGroupUser expertGroupUser);
	
	/**
	 * 取消项目在会议上的评审
	 * 同时取消该项目和这个会议上所有专家的关联
	 * @param evalSetFlow
	 */
	public void delEvalProj(String evalSetFlow);
	
}
