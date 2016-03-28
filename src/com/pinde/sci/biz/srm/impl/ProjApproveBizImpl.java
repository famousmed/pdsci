package com.pinde.sci.biz.srm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjApproveBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.PubProjFundPlanMapper;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.base.PubProjRecMapper;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
import com.pinde.sci.model.mo.PubProjFundPlan;
import com.pinde.sci.model.mo.PubProjFundPlanExample;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SrmApplyLimit;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjApproveBizImpl implements IProjApproveBiz{
	
	@Resource
	private PubProjMapper pubProjMapper;
	@Autowired
	private IPubProjBiz projBiz;		
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private PubProjFundPlanMapper projFundPlanMapper;
	@Autowired
	private PubProjRecMapper projRecMapper;
	
	@Override
	public void setUp(PubProj proj , String remark , String sug , String setUpXml) {
		SysUser currUser = GlobalContext.getCurrentUser();
		PubProjProcess process = new PubProjProcess();
		process.setProjFlow(proj.getProjFlow());
		process.setProjStageId(proj.getProjStageId());
		process.setProjStageName(proj.getProjStageName());
		process.setProjStatusId(proj.getProjStatusId());
		process.setProjStatusName(proj.getProjStatusName());
		process.setProcessRemark(remark);
		process.setAuditContent(sug);
		process.setOperOrgFlow(currUser.getOrgFlow());
		process.setOperOrgName(currUser.getOrgName());
		process.setOperUserFlow(currUser.getUserFlow());
		process.setOperUserName(currUser.getUserName());
		this.projProcessBiz.addProcess(process);
		//为立项rec添加记录
		if(StringUtil.isNotBlank(setUpXml)){
			PubProjRec record = new PubProjRec();
			record.setRecFlow(PkUtil.getUUID());
			record.setProjFlow(proj.getProjFlow());
			record.setProjStageId(proj.getProjStageId());
			record.setProjStageName(proj.getProjStageName());
			record.setProjStatusId(proj.getProjStatusId());
			record.setProjStatusName(proj.getProjStatusName());
			record.setRecTypeId(ProjRecTypeEnum.SetUp.getId());
			record.setRecTypeName(ProjRecTypeEnum.SetUp.getName());
			record.setRecContent(setUpXml);
			record.setOperUserFlow(currUser.getUserFlow());
			record.setOperUserName(currUser.getUserName());
			record.setOperTime(DateUtil.getCurrDateTime());
			GeneralMethod.setRecordInfo(record, true);
			this.projRecMapper.insertSelective(record);
		}
		//如果同意立项
		if(ProjApproveStatusEnum.Approve.getId().equals(proj.getProjStatusId())){
			//如果配置了合同表单  阶段改为合同阶段 状态改为填写状态
			String projTypeId = this.projBiz.readProject(proj.getProjFlow()).getProjTypeId();
			String pageGroupName = InitConfig.configMap.get(ProjRecTypeEnum.Contract.getId()).get(projTypeId);
			if(StringUtil.isNotBlank(pageGroupName)){
			    proj.setProjStageId(ProjStageEnum.Contract.getId());
			    proj.setProjStageName(ProjStageEnum.Contract.getName());
			    proj.setProjStatusId(ProjContractStatusEnum.Apply.getId());
			    proj.setProjStatusName(ProjContractStatusEnum.Apply.getName());
			}else{
				//否则跳到进展阶段 填写状态
				proj.setProjStageId(ProjStageEnum.Schedule.getId());
				proj.setProjStageName(ProjStageEnum.Schedule.getName());
				proj.setProjStatusId(ProjScheduleStatusEnum.Apply.getId());
				proj.setProjStatusName(ProjScheduleStatusEnum.Apply.getName());
			}
		}
		GeneralMethod.setRecordInfo(proj, false);
		this.projBiz.modProject(proj);
		
	}

	@Override
	public List<PubProj> searchApproveProjList(PubProj project) {
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjCategoryIdEqualTo(project.getProjCategoryId());
		if(StringUtil.isNotBlank(project.getProjName())){
			criteria.andProjNameLike("%"+project.getProjName()+"%");
		}
		if(StringUtil.isNotBlank((project.getProjNo()))){
			criteria.andProjNoEqualTo(project.getProjNo());
		}
		if(StringUtil.isNotBlank(project.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(project.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(project.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(project.getChargeOrgFlow());
		}
		if(StringUtil.isNotBlank(project.getProjStageId())){
			criteria.andProjStageIdEqualTo(project.getProjStageId());
		}
		if(StringUtil.isNotBlank(project.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(project.getProjStatusId());
		}
		if(StringUtil.isNotBlank(project.getProjYear())){
			criteria.andProjYearEqualTo(project.getProjYear());
		}
		if(StringUtil.isNotBlank(project.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(project.getProjTypeId());
		}
		projectExample.setOrderByClause("CREATE_TIME DESC");
		return pubProjMapper.selectByExample(projectExample);
	}

	@Override
	public List<PubProj> searchFundPlanList(PubProj proj) {
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("proj", proj);
		paramMap.put("stage", ProjStageEnum.Approve.getId());
		paramMap.put("status", ProjApproveStatusEnum.Approve.getId());
		return this.projBiz.searchPubProjListForFundPlan(paramMap );
	}

	@Override
	public List<PubProjFundPlan> searchProjFundPlanList(
			PubProjFundPlan projFindPlan) {
		PubProjFundPlanExample example = new PubProjFundPlanExample();
		com.pinde.sci.model.mo.PubProjFundPlanExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(projFindPlan.getProjFlow())){
			criteria.andProjFlowEqualTo(projFindPlan.getProjFlow());
		}
		/*if(StringUtil.isNotBlank(projFindPlan.getRecordStatus())){
			criteria.andRecordStatusEqualTo(projFindPlan.getRecordStatus());
		}*/
		example.setOrderByClause("YEAR nulls first");
		return this.projFundPlanMapper.selectByExample(example);
	}

	@Override
	public void addFundPlan(PubProj proj , List<PubProjFundPlan> fundPlans , String flag) {
		PubProjFundPlanExample example = new PubProjFundPlanExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andProjFlowEqualTo(proj.getProjFlow());
		example.setOrderByClause("YEAR nulls first");
		List<PubProjFundPlan> oldProjFundPlans = this.projFundPlanMapper.selectByExample(example);
		for(int i = 0;i<oldProjFundPlans.size();i++){
			fundPlans.get(i).setFundPlanFlow(oldProjFundPlans.get(i).getFundPlanFlow());
		}
		for(PubProjFundPlan ppjf:fundPlans){
			this.saveProjFundPlan(ppjf);
		}
		
		//新增process
		PubProjProcess process = new PubProjProcess();
		process.setProjFlow(proj.getProjFlow());
		process.setProjStageId(proj.getProjStageId());
		process.setProjStageName(proj.getProjStageName());
		process.setProjStatusId(proj.getProjStatusId());
		process.setProjStatusName(proj.getProjStatusName());
		this.projProcessBiz.addProcess(process);
		
		//更改proj的状态
		//this.pubProjMapper.updateByPrimaryKeySelective(proj);
	}
	
	private void saveProjFundPlan(PubProjFundPlan projFundPlan){
		if(StringUtil.isNotBlank(projFundPlan.getFundPlanFlow())){
			PubProjFundPlan exitProjFundPlan = projFundPlanMapper.selectByPrimaryKey(projFundPlan.getFundPlanFlow());
			exitProjFundPlan.setAmount(projFundPlan.getAmount());
			GeneralMethod.setRecordInfo(exitProjFundPlan, false);
			this.projFundPlanMapper.updateByPrimaryKey(exitProjFundPlan);
		}else{
			projFundPlan.setFundPlanFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(projFundPlan, true);
			this.projFundPlanMapper.insertSelective(projFundPlan);
		}
	}

	@Override
	public List<PubProj> getPubProjByProjNo(String projNo) {
		List<PubProj> projList =  null;
		if(StringUtil.isNotBlank(projNo)){
			PubProjExample example  = new PubProjExample();
			example.createCriteria().andProjNoEqualTo(projNo).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			projList = pubProjMapper.selectByExample(example);
		}
		return projList;
	}

}
