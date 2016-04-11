package com.pinde.sci.biz.srm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ICommonBiz;
import com.pinde.sci.biz.srm.IProjApplyBiz;
import com.pinde.sci.biz.srm.IProjContractBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.SysOrgMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.srm.ProcessRemarkEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjContractBizImpl implements IProjContractBiz{

	
	@Autowired
	private IProjApplyBiz applyBiz;
	@Autowired
	private IProjRecBiz projRecBiz;
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;
	@Autowired
	private SysOrgMapper sysOrgMapper;
	@Autowired
	private ICommonBiz commonBiz;
	@Autowired
	private IPubProjBiz projBiz;

	@Override
	public List<PubProj> searchLocalProj(PubProj proj,String recTypeId) {
		
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			currentOrgFlow = proj.getApplyOrgFlow();
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		proj.setRecordStatus(GlobalConstant.FLAG_Y);
		paramMap.put("status1", ProjContractStatusEnum.Submit.getId());
		paramMap.put("status2", ProjContractStatusEnum.SecondBack.getId());
		paramMap.put("status3", ProjContractStatusEnum.ThirdBack.getId());
		paramMap.put("orgFlow", currentOrgFlow);
		paramMap.put("proj", proj);
		paramMap.put("scope", GlobalConstant.USER_LIST_LOCAL);
		paramMap.put("chargeOrgFlow", InitConfig.getSysCfg("global_org_flow"));
		return this.pubProjExtMapper.selectContractAduitProjList(paramMap);
		
		
	}

	@Override
	public List<PubProj> searchChargeProj(PubProj proj,String recTypeId) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		proj.setRecordStatus(GlobalConstant.FLAG_Y);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status1", ProjContractStatusEnum.FirstAudit.getId());
		paramMap.put("status2", ProjContractStatusEnum.ThirdBack.getId());
		paramMap.put("proj", proj);
		paramMap.put("scope", GlobalConstant.USER_LIST_CHARGE);
		paramMap.put("chargeOrgFlow", currentUser.getOrgFlow());
		return this.pubProjExtMapper.selectContractAduitProjList(paramMap);
		
	}

	@Override
	public List<PubProj> searchGlobalProj(PubProj proj,String recTypeId) {
	    
		proj.setRecordStatus(GlobalConstant.FLAG_Y);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status1", ProjContractStatusEnum.SecondAudit.getId());
		paramMap.put("status2", ProjContractStatusEnum.FirstAudit.getId());
		paramMap.put("proj", proj);
		paramMap.put("scope", GlobalConstant.USER_LIST_GLOBAL);
		paramMap.put("chargeOrgFlow", InitConfig.getSysCfg("global_org_flow"));
		return this.pubProjExtMapper.selectContractAduitProjList(paramMap);
	}

	@Override
	public void contractAudit(String projFlow, String projListScope,
			String agreeFlag, String auditContent) {
		String _statusId = "";
		String _statusName = "";
		String _remark = "";
		
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			//合同
			_statusId = ProjContractStatusEnum.FirstAudit.getId();
			_statusName = ProjContractStatusEnum.FirstAudit.getName();
			_remark = ProcessRemarkEnum.FirstAuditAgree.getName();
		}
		else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
			//合同
			_statusId =  ProjContractStatusEnum.SecondAudit.getId();
			_statusName = ProjContractStatusEnum.SecondAudit.getName();
			 _remark = ProcessRemarkEnum.SecondAuditAgree.getName();
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			//合同
			_statusId =  ProjContractStatusEnum.ThirdAudit.getId();
			_statusName =ProjContractStatusEnum.ThirdAudit.getName();
			_remark = ProcessRemarkEnum.ThirdAuditAgree.getName();
		}
		//是否退回填写状态
		if(GlobalConstant.FLAG_N.equals(agreeFlag)){
			//合同
			_statusId = ProjContractStatusEnum.Apply.getId();
			_statusName = ProjContractStatusEnum.Apply.getName();
			if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
				_remark = ProcessRemarkEnum.FirstAuditNotAgree.getName();
			}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
				_remark = ProcessRemarkEnum.SecondAuditNotAgree.getName();
				_statusId = ProjContractStatusEnum.SecondBack.getId();
				_statusName = ProjContractStatusEnum.SecondBack.getName();
			}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
				_remark = ProcessRemarkEnum.ThirdAuditNotAgree.getName();
				_statusId = ProjContractStatusEnum.ThirdBack.getId();
				_statusName = ProjContractStatusEnum.ThirdBack.getName();
			}
		}
		PubProj proj = this.projBiz.readProject(projFlow);
		proj.setProjStatusId(_statusId);
		proj.setProjStatusName(_statusName);
		PubProjRec rec = this.projRecBiz.selectProjRecByProjFlowAndRecType(projFlow, ProjRecTypeEnum.Contract.getId());
		if(rec!=null){
		    rec.setProjStatusId(_statusId);
		    rec.setProjStatusName(_statusName);
		    this.projProcessBiz.addProcess(rec,_remark,auditContent);
		}else{
			PubProjProcess process = new PubProjProcess();
			process.setProjFlow(proj.getProjFlow());
			process.setProjStageId(proj.getProjStageId());
			process.setProjStageName(proj.getProjStageName());
			process.setProjStatusId(proj.getProjStatusId());
			process.setProjStatusName(proj.getProjStatusName());
			process.setAuditContent(auditContent);
			process.setProcessRemark(_remark);
			process.setOperTime(DateUtil.getCurrDateTime());
			this.projProcessBiz.addProcess(process);
		}
		
		String backApplyUser = InitConfig.getSysCfg("srm_back_apply_user");
		if(GlobalConstant.FLAG_Y.equals(backApplyUser) && GlobalConstant.FLAG_N.equals(agreeFlag)){
			//直接退回到项目负责人
			_statusId =  ProjApplyStatusEnum.Apply.getId();
			_statusName = ProjApplyStatusEnum.Apply.getName();
			proj.setProjStatusId(_statusId);
			proj.setProjStatusName(_statusName);
		}
		
		if(rec!=null){
			rec.setProjStatusId(_statusId);
			rec.setProjStatusName(_statusName);
			GeneralMethod.setRecordInfo(rec, false);
			this.projRecBiz.modProjRec(rec);
		}
		
		//如果是最高部门审核通过 则将阶段改为进展阶段 状态改为填写状态
		if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL) && ProjContractStatusEnum.ThirdAudit.getId().equals(_statusId)){
			proj.setProjStageId(ProjStageEnum.Schedule.getId());
			proj.setProjStageName(ProjStageEnum.Schedule.getName());
			proj.setProjStatusId(ProjScheduleStatusEnum.Apply.getId());
			proj.setProjStatusName(ProjScheduleStatusEnum.Apply.getName());
		}else if(StringUtil.isEquals(InitConfig.getSysCfg("srm_for_use") , GlobalConstant.PROJ_STATUS_SCOPE_LOCAL) && ProjContractStatusEnum.FirstAudit.getId().equals(_statusId)){
			proj.setProjStageId(ProjStageEnum.Schedule.getId());
			proj.setProjStageName(ProjStageEnum.Schedule.getName());
			proj.setProjStatusId(ProjScheduleStatusEnum.Apply.getId());
			proj.setProjStatusName(ProjScheduleStatusEnum.Apply.getName());
		}
		
		//回写项目阶段和状态
		GeneralMethod.setRecordInfo(proj, false);
		projBiz.modProject(proj);
		
	}

	@Override
	public void controctBackForThridAudit(String recFlow) {
		PubProjRec contract = this.projRecBiz.selectProjRecNoContentByFlow(recFlow);
		if(contract!=null){
			contract.setProjStatusId(ProjContractStatusEnum.Apply.getId());
			contract.setProjStatusName(ProjContractStatusEnum.Apply.getName());
			GeneralMethod.setRecordInfo(contract, false);
			this.projRecBiz.modProjRec(contract);
			
			PubProj proj = new PubProj();
			proj.setProjFlow(contract.getProjFlow());
			proj.setProjStageId(ProjStageEnum.Contract.getId());
			proj.setProjStageName(ProjStageEnum.Contract.getName());
			proj.setProjStatusId(ProjContractStatusEnum.Apply.getId());
			proj.setProjStatusName(ProjContractStatusEnum.Apply.getName());
			this.projBiz.modProject(proj);
			
			PubProjProcess process = new PubProjProcess();
			process.setProjFlow(contract.getProjFlow());
			process.setRecFlow(contract.getRecFlow());
			process.setProjStageId(ProjStageEnum.Contract.getId());
			process.setProjStageName(ProjStageEnum.Contract.getName());
			process.setProjStatusId(ProjContractStatusEnum.ThirdBack.getId());
			process.setProjStatusName(ProjContractStatusEnum.ThirdBack.getName());
			process.setRecTypeId(ProjRecTypeEnum.Contract.getId());
			process.setRecTypeName(ProjRecTypeEnum.Contract.getName());
			process.setProcessRemark(ProcessRemarkEnum.ThirdAuditNotAgree.getName());
			process.setAuditContent(ProcessRemarkEnum.ThirdAuditNotAgree.getName());
			this.projProcessBiz.addProcess(process);
		}
		
	}
	
	
}
