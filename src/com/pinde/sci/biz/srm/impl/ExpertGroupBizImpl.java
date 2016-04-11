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
	 * ������ˮ�Ų���ר����(Ψһ)
	 */
	@Override
	public SrmExpertGroup readSrmExpertGroup(String groupFlow) {
		return srmExpertGroupMapper.selectByPrimaryKey(groupFlow);
	}
	/**
	 * 1 ����ר������Ϣ
	 * 2 ����ר������Ϣ
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
	 * 1 ��ѯ����ר������Ϣ
	 * 2 ����ר����������ģ����ѯ
	 * 3���ݿ�ʼ�����Լ���ʼ�������ڽ��з�Χ��ѯ
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
	 * ���ݿ�ʼ�����Լ���ʼ�������ڽ��з�Χ��ѯ
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
		//���� ���������ú�������������
		SrmExpertProjEval expertGroupProj = this.expertGroupProjBiz.read(evalSetFlow);
		expertGroupProj.setGroupFlow(groupFlow);
		this.expertGroupProjBiz.modExpertGroupProjByFlow(expertGroupProj);
	
		//���� ����λ����ϵ�����ר�� �� ����������ù�����
		//��ѯ��������ϵ�����ר��
		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
		expertGroupUser.setRecordStatus(GlobalConstant.FLAG_Y);
		expertGroupUser.setGroupFlow(groupFlow);
		List<SrmExpertGroupUser> expertGroupUserList = this.expertGroupsUserBiz.searchSrmExpertGroupUser(expertGroupUser);
		for(SrmExpertGroupUser segu:expertGroupUserList){
			SrmExpertProj expertProj = new SrmExpertProj();
			expertProj.setEvalSetFlow(expertGroupProj.getEvalSetFlow());
			expertProj.setUserFlow(segu.getUserFlow());
			expertProj.setProjFlow(expertGroupProj.getProjFlow());
			//�費��ҪgroupFlow��?
			expertProj.setGroupFlow(expertGroupProj.getGroupFlow());
			this.expertProjBiz.save(expertProj);
		}
		
	}
	@Override
	public void addEvalExpert(String groupFlow, String[] userFlow) {
		//��ר����ӵ��ôλ�����
		this.expertGroupsUserBiz.saveExpertGroupUser(groupFlow,userFlow);//��groupFlow(ר����ˮ��) userFlows(�û���ˮ��) ��ӵ���Ӧ��ר������
				
		// ����ӵ���Щר����Ӹôλ������������Ŀ
		//��ѯ�ôλ�����Ҫ�������Ŀ
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
				//�費��ҪgroupFlow��?
				expertProj.setGroupFlow(segp.getGroupFlow());
				this.expertProjBiz.save(expertProj);
			}
		}
		
	}
	@Override
	public void delEvalExpert(SrmExpertGroupUser expertGroupUser) {
		//��ѯ�����ר�ҵĹ��� �õ�������ˮ�ź�ר����ˮ��
		expertGroupUser = this.expertGroupsUserBiz.read(expertGroupUser.getRecordFlow());
		expertGroupUser.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		this.expertGroupsUserBiz.updateExpertGroupUser(expertGroupUser);
		
		//ȥ���ôλ����ϸ�ר��Ҫ�������Ŀ
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
