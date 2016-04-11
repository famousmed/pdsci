package com.pinde.sci.biz.irb;

import java.util.List;
import java.util.Map;

import com.pinde.sci.form.irb.IrbApplyForm;
import com.pinde.sci.model.mo.IrbApply;

public interface IIrbApplyBiz {
	/**
	 * 按主键查找
	 * @param irbFlow
	 * @return
	 */
	public IrbApply queryByFlow(String irbFlow);
	/**
	 * 新增或修改
	 * @param irbApply
	 * @return
	 */
	public int edit(IrbApply irbApply);
	/**
	 * 查询列表
	 * @param form
	 * @return
	 */
	public List<IrbApply> queryList(IrbApplyForm form);
	/**
	 * 查询
	 * @param projFlow
	 */
	List<IrbApply> queryIrbApply(IrbApply irb);
	
	/**
	 * 根据项目流水号查询
	 * @param projFlow
	 */
	List<IrbApply> queryIrbApplyListByProjFlows(List<String> projFlowList,String irbTypeId);
	/**
	 * 更改阶段
	 * @param apply
	 */
	void changeStage(IrbApply apply);
	public List<IrbApply> searchIrbList(String userFlow);
	public void modifyIrbApply(IrbApply apply);
	
	/**
	 * 查询委员主审的项目
	 * @param paramMap
	 * @return
	 */
	List<IrbApply> searchCommitteeIrbList(Map<String,Object> paramMap);
	public Integer searchMeetingIrbList(String meetingFlow,String arrange);
	
	/**
	 * 查询跟踪审查日期不为空的审查
	 * @return
	 */
	List<IrbApply> searchTrackIrbList();
	
	/**
	 * 查询meetingFlow不为空的IrbApply
	 * @return
	 */
	List<IrbApply> queryIrbMeeting();  
	
	/**
	 * 查询当前委员主审项目中为审查（审查决定为空）的审查
	 * @param paramMap
	 * @return
	 */
	public List<IrbApply> searchUnReviewIrbs(Map<String, Object> paramMap);
	
	List<IrbApply> searchIrbApply(IrbApply irb);
	public List<IrbApply> queryIrbApply(String startDate, String endDate,
			IrbApply irb);
	/**
	 * 按条件查询记录数
	 * @param irb
	 * @return
	 */
	long queryIrbApplyCount(IrbApply irb);
	List<IrbApply> searchIrbs(IrbApply irb);
	List<IrbApply> sortApplyByIrbType(List<IrbApply> applyList);
	/**
	 * 查询机构下已提交伦理的项目数
	 * @param orgFlow
	 * @return
	 */
	int queryIrbApplyCount(String orgFlow);
	List<IrbApply> searchUnDecisionIrbApply(String meetingFlow);
}
