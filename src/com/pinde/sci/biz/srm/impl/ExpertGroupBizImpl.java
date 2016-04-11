package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmExpertGroupMapper;
import com.pinde.sci.model.mo.SrmExpertGroup;
import com.pinde.sci.model.mo.SrmExpertGroupExample;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmExpertGroupExample.Criteria;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
@Service
@Transactional(rollbackFor=Exception.class)
public class ExpertGroupBizImpl implements IExpertGroupBiz {
	
	@Resource
	private SrmExpertGroupMapper srmExpertGroupMapper;
	
	@Autowired
	private IExpertGroupProjBiz expertGroupProjBiz;
	
	@Autowired
	private IExpertGroupsUserBiz expertGroupsUserBiz;
	
	@Autowired
	private IExpertProjBiz expertProjBiz;
	
	/**
	 * 根据流水号查找专家组(唯一)
	 */
	@Override
	public SrmExpertGroup readSrmExpertGroup(String groupFlow) {
		return srmExpertGroupMapper.selectByPrimaryKey(groupFlow);
	}
	/**
	 * 1 增加专家组信息
	 * 2 更新专家组信息
	 */
	@Override
	public int saveExpertGroup(SrmExpertGroup expertGroup) {
		if(StringUtil.isNotBlank(expertGroup.getGroupFlow())){
			GeneralMethod.setRecordInfo(expertGroup, false);
			return srmExpertGroupMapper.updateByPrimaryKeySelective(expertGroup);
		}else{
			expertGroup.setGroupFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(expertGroup, true);
			return srmExpertGroupMapper.insert(expertGroup);
		}
	}
	/**
	 * 1 查询加载专家组信息
	 * 2 根据专家组名进行模糊查询
	 * 3根据开始日期以及开始结束日期进行范围查询
	 */
	@Override
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert) {
		return this.searchExpertGroup(expert, null, null);
	}
	
	@Override
	public List<SrmExpertGroup> searchExpertGroup(SrmExpertGroup expert,
			String startDate, String endDate) {
		SrmExpertGroupExample example=new SrmExpertGroupExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(expert.getGroupName())){
			criteria.andGroupNameLike("%"+expert.getGroupName()+"%");
		}
		if(StringUtil.isNotBlank(expert.getEvaluationWayId())){
			criteria.andEvaluationWayIdEqualTo(expert.getEvaluationWayId());
		}
		if(StringUtil.isNotBlank(startDate) && StringUtil.isNotBlank(endDate)){
			criteria.andMeetingDateBetween(startDate, endDate);
		}
		example.setOrderByClause("meeting_date");
		return srmExpertGroupMapper.selectByExample(example);
	}
	
	/**
	 * 根据开始日期以及开始结束日期进行范围查询
	 */
//	@Override
//	public List<SrmExpertGroup> searchExpert(String currDateTime) {
//		SrmExpertGroupExample example=new SrmExpertGroupExample();
////		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
////		if(StringUtil.isNotBlank(currDateTime)){
////			criteria.andBeginDateLessThanOrEqualTo(currDateTime).andEndDateGreaterThanOrEqualTo(currDateTime); 
////		}
//		return srmExpertGroupMapper.selectByExample(example);
//	}
	
	@Override
	public void addEvalProj(String groupFlow, String evalSetFlow) {
		//更新 将评审设置和这个会议关联上
		SrmExpertProjEval expertGroupProj = this.expertGroupProjBiz.read(evalSetFlow);
		expertGroupProj.setGroupFlow(groupFlow);
		this.expertGroupProjBiz.modExpertGroupProjByFlow(expertGroupProj);
	
		//新增 给这次会议上的所有专家 和 这个评审设置关联上
		//查询这个会议上的所有专家
		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
		expertGroupUser.setRecordStatus(GlobalConstant.FLAG_Y);
		expertGroupUser.setGroupFlow(groupFlow);
		List<SrmExpertGroupUser> expertGroupUserList = this.expertGroupsUserBiz.searchSrmExpertGroupUser(expertGroupUser);
		for(SrmExpertGroupUser segu:expertGroupUserList){
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setEvalSetFlow(expertGroupProj.getEvalSetFlow());
			expertProj.setUserFlow(segu.getUserFlow());
			expertProj.setProjFlow(expertGroupProj.getProjFlow());
			//需不需要groupFlow呢?
			expertProj.setGroupFlow(expertGroupProj.getGroupFlow());
			this.expertProjBiz.save(expertProj);
		}
		
	}
	@Override
	public void addEvalExpert(String groupFlow, String[] userFlow) {
		//将专家添加到该次会议中
		this.expertGroupsUserBiz.saveExpertGroupUser(groupFlow,userFlow);//传groupFlow(专家流水号) userFlows(用户流水号) 添加到对应的专家组中
				
		// 给添加的这些专家添加该次会议上评审的项目
		//查询该次会议上要评审的项目
		SrmExpertProjEval srmExpertGroupProj = new SrmExpertProjEval();
		srmExpertGroupProj.setRecordStatus(GlobalConstant.FLAG_Y);
		srmExpertGroupProj.setGroupFlow(groupFlow);
		List<SrmExpertProjEval> groupProjList = this.expertGroupProjBiz.searchSrmExpertGroupProj(srmExpertGroupProj);
		for(SrmExpertProjEval segp:groupProjList){
			for(String uf:userFlow){
				SrmExpertProj expertProj = new SrmExpertProj();
				expertProj.setEvalSetFlow(segp.getEvalSetFlow());
				expertProj.setUserFlow(uf);
				expertProj.setProjFlow(segp.getProjFlow());
				//需不需要groupFlow呢?
				expertProj.setGroupFlow(segp.getGroupFlow());
				this.expertProjBiz.save(expertProj);
			}
		}
		
	}
	@Override
	public void delEvalExpert(SrmExpertGroupUser expertGroupUser) {
		//查询会议和专家的关联 拿到会议流水号和专家流水号
		expertGroupUser = this.expertGroupsUserBiz.read(expertGroupUser.getRecordFlow());
		expertGroupUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		this.expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
		
		//去掉该次会议上该专家要评审的项目
		SrmExpertProj expertProj = new SrmExpertProj();
		expertProj.setRecordStatus(GlobalConstant.FLAG_N);
		expertProj.setUserFlow(expertGroupUser.getUserFlow());
		expertProj.setGroupFlow(expertGroupUser.getGroupFlow());
		this.expertProjBiz.modify(expertProj);
		
	}
	@Override
	public void delEvalProj(String evalSetFlow) {
		SrmExpertProjEval expertGroupProj = new SrmExpertProjEval();
		expertGroupProj.setEvalSetFlow(evalSetFlow);
		expertGroupProj.setGroupFlow("");
		this.expertGroupProjBiz.cancelEvalSet(expertGroupProj);
		
	}
	@Override
	public void deleteExpertGroup(SrmExpertGroup srmExpertGroup) {
		if(StringUtil.isNotBlank(srmExpertGroup.getGroupFlow())){
			GeneralMethod.setRecordInfo(srmExpertGroup, false);
			srmExpertGroup.setRecordStatus(GlobalConstant.RECORD_STATUS_N); 
			srmExpertGroupMapper.updateByPrimaryKeySelective(srmExpertGroup);
		}
		
	}
	
}
