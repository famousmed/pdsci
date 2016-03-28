package com.pinde.sci.biz.srm.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertGroupBiz;
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.biz.srm.IExpertGroupsUserBiz;
import com.pinde.sci.biz.srm.IExpertProjBiz;
import com.pinde.sci.biz.srm.IProjEvaluationBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.srm.EvaluationEnum;
import com.pinde.sci.enums.srm.EvaluationStatusEnum;
import com.pinde.sci.enums.srm.EvaluationWayEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjEvaluationStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SrmExpertGroupUser;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.srm.PubProjExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjEvaluationBizImpl implements IProjEvaluationBiz{
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;
	@Autowired
	private IExpertGroupProjBiz expertGroupProjBiz; 
	@Autowired
	private IExpertProjBiz expertProjBiz;
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private IExpertGroupsUserBiz expertGroupsUserBiz;
	@Autowired
	private IExpertGroupBiz expertGroupBiz;
	
	@Override
	public List<PubProjExt> searchProjList(PubProjExt projExt) {
		return this.pubProjExtMapper.selectEvaluationProjList(projExt);
	}



	@Override
	public void saveEvaluationSettingForNetWork(SrmExpertProjEval groupProj) {
		this.expertGroupProjBiz.save(groupProj);
		if(EvaluationStatusEnum.Submit.getId().equals(groupProj.getEvalStatusId())){
			//当评审状态时提交的时候 ， 向项目过程表中插一条 该项目处于评审中的记录
			PubProjProcess process = new PubProjProcess();
			process.setProjFlow(groupProj.getProjFlow());
			if(EvaluationEnum.ApproveEvaluation.getId().equals(groupProj.getEvaluationId())){
				process.setProjStageId(ProjStageEnum.Approve.getId());
				process.setProjStageName(ProjStageEnum.Approve.getName());
			}else if(EvaluationEnum.CompleteEvaluation.getId().equals(groupProj.getEvaluationId())){
				process.setProjStageId(ProjStageEnum.Complete.getId());
				process.setProjStageName(ProjStageEnum.Complete.getName());
			}
			process.setProjStatusId(ProjEvaluationStatusEnum.Evaluation.getId());
			process.setProjStatusName(ProjEvaluationStatusEnum.Evaluation.getName());
			this.projProcessBiz.addProcess(process);
		}
		
	}



	@Override
	public void saveEvaluationSettingForMeeting(SrmExpertProjEval groupProj) {
//      注释的这段代码是为了实现评审设置保存后还可以继续修改 评审方式的 现在统一提交后不允许修改 所以注释掉
//		if(StringUtil.isNotBlank(groupProj.getEvalSetFlow())){
//			SrmExpertProjEval oldGroupProj = this.expertGroupProjBiz.read(groupProj.getEvalSetFlow());
//			if(EvaluationWayEnum.NetWorkWay.getId().equals(oldGroupProj.getEvaluationWayId())){
//				//如果原先是网评  就将网评中设置的专家和项目关联的记录状态改为N
//				SrmExpertProj expertProj = new SrmExpertProj();
//				expertProj.setEvalSetFlow(groupProj.getEvalSetFlow());
//				expertProj.setRecordStatus(GlobalConstant.FLAG_N);
//				this.expertProjBiz.modify(expertProj);
//			}
//			
//		}
		//保存或更新评审设置
		this.expertGroupProjBiz.save(groupProj);
		//向项目过程表中添加一条记录
		if(EvaluationStatusEnum.Submit.getId().equals(groupProj.getEvalStatusId())){
			//当评审状态时提交的时候 ， 向项目过程表中插一条 该项目处于评审中的记录
			PubProjProcess process = new PubProjProcess();
			process.setProjFlow(groupProj.getProjFlow());
			if(EvaluationEnum.ApproveEvaluation.getId().equals(groupProj.getEvaluationId())){
				process.setProjStageId(ProjStageEnum.Approve.getId());
				process.setProjStageName(ProjStageEnum.Approve.getName());
			}else if(EvaluationEnum.CompleteEvaluation.getId().equals(groupProj.getEvaluationId())){
				process.setProjStageId(ProjStageEnum.Complete.getId());
				process.setProjStageName(ProjStageEnum.Complete.getName());
			}
			process.setProjStatusId(ProjEvaluationStatusEnum.Evaluation.getId());
			process.setProjStatusName(ProjEvaluationStatusEnum.Evaluation.getName());
			this.projProcessBiz.addProcess(process);
		}
		
		this.expertGroupBiz.addEvalProj(groupProj.getGroupFlow(), groupProj.getEvalSetFlow());
	}



//	@Override
//	public void saveExpertProjWhenAddProjForMeeting(
//			SrmExpertProjEval expertProjEval) {
//		String groupFlow = expertProjEval.getGroupFlow();
//		//新增 给这次会议上的所有专家 和 这个评审设置关联上
//		//查询这个会议上的所有专家
//		SrmExpertGroupUser expertGroupUser = new SrmExpertGroupUser();
//		expertGroupUser.setRecordStatus(GlobalConstant.FLAG_Y);
//		expertGroupUser.setGroupFlow(groupFlow);
//		List<SrmExpertGroupUser> expertGroupUserList = this.expertGroupsUserBiz.searchSrmExpertGroupUser(expertGroupUser);
//		for(SrmExpertGroupUser segu:expertGroupUserList){
//			SrmExpertProj expertProj = new SrmExpertProj();
//			expertProj.setEvalSetFlow(expertProjEval.getEvalSetFlow());
//			expertProj.setUserFlow(segu.getUserFlow());
//			expertProj.setProjFlow(expertProjEval.getProjFlow());
//			//需不需要groupFlow呢?
//			expertProj.setGroupFlow(groupFlow);
//			this.expertProjBiz.save(expertProj);
//		}
//		
//	}



}
