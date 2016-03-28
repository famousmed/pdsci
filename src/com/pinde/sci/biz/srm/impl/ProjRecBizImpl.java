package com.pinde.sci.biz.srm.impl;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjApplyBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjProcessMapper;
import com.pinde.sci.dao.base.PubProjRecMapper;
import com.pinde.sci.enums.srm.ProcessRemarkEnum;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjRecTypeEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.form.gcp.GcpMeetingForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.PubProjRecExample;
import com.pinde.sci.model.mo.PubProjRecExample.Criteria;
import com.pinde.sci.model.mo.SysUser;
import com.sun.org.apache.bcel.internal.generic.GETSTATIC;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjRecBizImpl implements IProjRecBiz{

	@Autowired
	private PubProjRecMapper projRecMapper;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private ProjProcessBizImpl processBiz;
	
	
//	@Override
//	public void addProjRec(PubProjRec projRec) {
//		this.projRecMapper.insertSelective(projRec);
//	}
	
//	@Override
//	public void saveProjRec(PubProjRec projProcessRec,
//			SysUser user) {
//		if(StringUtil.isBlank(projProcessRec.getRecFlow())){
//			projProcessRec.setModifyUserFlow(user.getUserFlow());
//			projProcessRec.setCreateUserFlow(user.getUserFlow());
//			saveProjRec(projProcessRec);
//		}else{
//			updateProjRec(projProcessRec , user);
//		}
//	}
	
//	@Override
//	public void updateProjRec(PubProjRec projProcessRec) {
//		String currDateTime = DateUtil.getCurrDateTime();
//		projProcessRec.setModifyTime(currDateTime);
//		this.projRecDao.updateByPrimaryKeySelective(projProcessRec);
//	}
	
//	@Override
//	public void updateProjRec(PubProjRec projProcessRec,
//			SysUser user) {
//		projProcessRec.setModifyUserFlow(user.getUserFlow());
//		updateProjRec(projProcessRec);
//		
//	}

	@Override
	public PubProjRec readProjRec(String flow) {
		return this.projRecMapper.selectByPrimaryKey(flow);
	}
	
	@Override
	public PubProjRec selectProjRecNoContentByFlow(String flow) {
		PubProjRecExample example = new PubProjRecExample();
		example.createCriteria().andRecFlowEqualTo(flow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<PubProjRec> projRecList = this.projRecMapper.selectByExample(example);
		if(projRecList!=null && projRecList.size()==1){
			return projRecList.get(0);
		}
		return null;
	}

	@Override
	public void addProjRec(PubProjRec projRec) {
		projRec.setRecFlow(PkUtil.getUUID());
		String currDateTime = DateUtil.getCurrDateTime();
		projRec.setCreateTime(currDateTime);
		projRec.setModifyTime(currDateTime);
		projRec.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		projRec.setOperTime(currDateTime);
		GeneralMethod.setRecordInfo(projRec,true);
		this.projRecMapper.insertSelective(projRec);
		
	}

//	@Override
//	public void addProjRec(PubProjRec projRec, SysUser user) {
//		projRec.setCreateUserFlow(user.getUserFlow());
//		projRec.setModifyUserFlow(user.getUserFlow());
//		projRec.setOperUserFlow(user.getUserFlow());
//		projRec.setOperUserName(user.getUserName());
//		this.addProjRec(projRec);
//		
//	}

	@Override
	public List<PubProjRec> searchProjRec(PubProjRecExample example) {
		return projRecMapper.selectByExample(example) ;
	}

	@Override
	public void modProjRec(PubProjRec applyRec) {
		projRecMapper.updateByPrimaryKeySelective(applyRec);
	}

//	@Override
//	public void addPubProjRec(String recTypeId,PubProj proj) {
//		SysUser currUser =GlobalContext.getCurrentUser();
//		String _stageId = "";
//		String _stageName = "";
//		String _statusId = "";
//		String _statusName = "";
//		String _recTypeName = "";
//		if(ProjRecTypeEnum.ScheduleReport.getId().equals(recTypeId)){ 
//			 _stageId = ProjStageEnum.Schedule.getId();
//			 _stageName = ProjStageEnum.Schedule.getName();
//			 _statusId = ProjScheduleStatusEnum.Apply.getId();
//			 _statusName = ProjScheduleStatusEnum.Apply.getName();
//			 _recTypeName = ProjRecTypeEnum.ScheduleReport.getName();
//		}else if(ProjRecTypeEnum.CompleteReport.getId().equals(recTypeId)){ 
//			 _stageId = ProjStageEnum.Complete.getId();
//			 _stageName = ProjStageEnum.Complete.getName();
//			 _statusId = ProjCompleteStatusEnum.Apply.getId();
//			 _statusName = ProjCompleteStatusEnum.Apply.getName();
//			 _recTypeName = ProjRecTypeEnum.CompleteReport.getName();
//		}
//		
//		//1.添加rec信息
//		PubProjRec rec = new PubProjRec();
//		rec.setRecFlow(PkUtil.getUUID());
//		rec.setProjFlow(proj.getProjFlow());
//		rec.setProjStageId(_stageId);
//		rec.setProjStageName(_stageName);
//		rec.setProjStatusId(_statusId);
//		rec.setProjStatusName(_statusName);
//		rec.setRecTypeId(recTypeId);
//		rec.setRecTypeName(_recTypeName);
//		rec.setOperUserFlow(currUser.getUserFlow());
//		rec.setOperUserName(currUser.getUserName());
//		rec.setOperTime(DateUtil.getCurrDateTime());
//		orgRecordInfo(rec,currUser,true);
//		projRecMapper.insert(rec);
//		
//		//2.回写proj stage status
//		proj.setProjStageId(rec.getProjStageId());
//		proj.setProjStageName(rec.getProjStageName());
//		proj.setProjStatusId(rec.getProjStatusId());
//		proj.setProjStatusName(rec.getProjStatusName());
//		projBiz.modProject(proj);
//		
//		//3.添加process
//		processBiz.addProcess(rec);
//	}
	

	private void orgRecordInfo(Object obj,SysUser currUser,boolean isAdd){
		Class<?> clazz = obj.getClass();
		try {
			if(isAdd){
				Method setRecordStatusMethod = clazz.getMethod("setRecordStatus",String.class);
				setRecordStatusMethod.invoke(obj,GlobalConstant.RECORD_STATUS_Y);
				Method setCreateTime = clazz.getMethod("setCreateTime",String.class);
				setCreateTime.invoke(obj,DateUtil.getCurrDateTime());
				Method setCreateUserFlow = clazz.getMethod("setCreateUserFlow",String.class);
				setCreateUserFlow.invoke(obj,currUser.getUserFlow());
			}
			Method setModifyTime = clazz.getMethod("setModifyTime",String.class);
			setModifyTime.invoke(obj,DateUtil.getCurrDateTime());
			Method setModifyUserFlow = clazz.getMethod("setModifyUserFlow",String.class);
			setModifyUserFlow.invoke(obj,currUser.getUserFlow());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void delProjRec(PubProjRec rec) {
		rec.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		GeneralMethod.setRecordInfo(rec,  false);
		projRecMapper.updateByPrimaryKeySelective(rec);
	}

//	@Override
//	public void submitRecAudit(String recTypeId,PubProjRec rec) {
//		SysUser currUser =GlobalContext.getCurrentUser();
//		String _statusId = "";
//		String _statusName = "";
//		if(ProjRecTypeEnum.ScheduleReport.getId().equals(recTypeId)){ 
//			 _statusId = ProjScheduleStatusEnum.Submit.getId();
//			 _statusName = ProjScheduleStatusEnum.Submit.getName();
//		}else if(ProjRecTypeEnum.CompleteReport.getId().equals(recTypeId)){ 
//			 _statusId =   ProjCompleteStatusEnum.Submit.getId();
//			 _statusName = ProjCompleteStatusEnum.Submit.getName();
//		}
//		//1.修改rec状态
//		rec.setProjStatusId(_statusId);
//		rec.setProjStatusName(_statusName);
//		GeneralMethod.setRecordInfo(rec,false);
//		projRecMapper.updateByPrimaryKey(rec);
//		
//		//2.回写proj stage status
//		PubProj proj = projBiz.readProject(rec.getProjFlow());
//		proj.setProjStatusId(rec.getProjStatusId());
//		proj.setProjStatusName(rec.getProjStatusName());
//		projBiz.modProject(proj);
//		
//		//3.添加process
//		processBiz.addProcess(rec);
//	}

	@Override
	public void changeRecStatusForAudit(String recTypeId,PubProj proj,PubProjRec rec, String projListScope,String agreeFlag,String auditContent) {
		SysUser currUser =GlobalContext.getCurrentUser();
		String _statusId = "";
		String _statusName = "";
		String _remark = "";
		
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
			//申请
			if(recTypeId.equals(ProjRecTypeEnum.Apply.getId())){
				 _statusId =  ProjApplyStatusEnum.FirstAudit.getId();
				 _statusName = ProjApplyStatusEnum.FirstAudit.getName();
			}
			//合同
			if(recTypeId.equals(ProjRecTypeEnum.Contract.getId()) ){
				 _statusId = ProjContractStatusEnum.FirstAudit.getId();
				 _statusName = ProjContractStatusEnum.FirstAudit.getName();
			}
			//季报
			if(recTypeId.equals(ProjRecTypeEnum.ScheduleReport.getId())){
				 _statusId =  ProjScheduleStatusEnum.FirstAudit.getId();
				 _statusName =ProjScheduleStatusEnum.FirstAudit.getName();
			}
			//验收报告
			if(recTypeId.equals(ProjRecTypeEnum.CompleteReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.FirstAudit.getId();
				 _statusName =ProjCompleteStatusEnum.FirstAudit.getName();
			}
			//中止报告
			if(recTypeId.equals(ProjRecTypeEnum.TerminateReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.FirstAudit.getId();
				 _statusName =ProjCompleteStatusEnum.FirstAudit.getName();
			}
			_remark = ProcessRemarkEnum.FirstAuditAgree.getName();
		}
		else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
			//申请
			if(recTypeId.equals(ProjRecTypeEnum.Apply.getId())){
				 _statusId =  ProjApplyStatusEnum.SecondAudit.getId();
				 _statusName = ProjApplyStatusEnum.SecondAudit.getName();
			}
			//合同
			if(recTypeId.equals(ProjRecTypeEnum.Contract.getId()) ){
				 _statusId =  ProjContractStatusEnum.SecondAudit.getId();
				 _statusName = ProjContractStatusEnum.SecondAudit.getName();
			}
			//季报
			if(recTypeId.equals(ProjRecTypeEnum.ScheduleReport.getId()) ){
				 _statusId =  ProjScheduleStatusEnum.SecondAudit.getId();
				 _statusName =ProjScheduleStatusEnum.SecondAudit.getName();
			}
			//验收报告
			if(recTypeId.equals(ProjRecTypeEnum.CompleteReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.SecondAudit.getId();
				 _statusName =ProjCompleteStatusEnum.SecondAudit.getName();
			}
			//中止报告
			if(recTypeId.equals(ProjRecTypeEnum.TerminateReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.SecondAudit.getId();
				 _statusName =ProjCompleteStatusEnum.SecondAudit.getName();
			}
			 _remark = ProcessRemarkEnum.SecondAuditAgree.getName();
		}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
			//申请
			if(recTypeId.equals(ProjRecTypeEnum.Apply.getId())){
				 _statusId =  ProjApplyStatusEnum.ThirdAudit.getId();
				 _statusName = ProjApplyStatusEnum.ThirdAudit.getName();
			}
			//合同
			if(recTypeId.equals(ProjRecTypeEnum.Contract.getId()) ){
				 _statusId =  ProjContractStatusEnum.ThirdAudit.getId();
				 _statusName =ProjContractStatusEnum.ThirdAudit.getName();
			}
			//季报
			if(recTypeId.equals(ProjRecTypeEnum.ScheduleReport.getId()) ){
				 _statusId =  ProjScheduleStatusEnum.ThirdAudit.getId();
				 _statusName =ProjScheduleStatusEnum.ThirdAudit.getName();
			}
			//验收报告
			if(recTypeId.equals(ProjRecTypeEnum.CompleteReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.ThirdAudit.getId();
				 _statusName =ProjCompleteStatusEnum.ThirdAudit.getName();
			}
			//中止报告
			if(recTypeId.equals(ProjRecTypeEnum.TerminateReport.getId()) ){
				_statusId =  ProjCompleteStatusEnum.ThirdAudit.getId();
				 _statusName =ProjCompleteStatusEnum.ThirdAudit.getName();
			}
			 _remark = ProcessRemarkEnum.ThirdAuditAgree.getName();
		}
		//是否退回填写状态
		if(GlobalConstant.FLAG_N.equals(agreeFlag)){
			//申请
			if(recTypeId.equals(ProjRecTypeEnum.Apply.getId())){
				 _statusId =  ProjApplyStatusEnum.Apply.getId();
				 _statusName = ProjApplyStatusEnum.Apply.getName();
			}
			//合同
			if(recTypeId.equals(ProjRecTypeEnum.Contract.getId()) ){
				_statusId = ProjContractStatusEnum.Apply.getId();
				_statusName = ProjContractStatusEnum.Apply.getName();
			}
			//季报
			if(recTypeId.equals(ProjRecTypeEnum.ScheduleReport.getId()) ){
				_statusId = ProjScheduleStatusEnum.Apply.getId();
				_statusName = ProjScheduleStatusEnum.Apply.getName();
			}
			//验收报告
			if(recTypeId.equals(ProjRecTypeEnum.CompleteReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.Apply.getId();
				 _statusName =ProjCompleteStatusEnum.Apply.getName();
			}
			//中止报告
			if(recTypeId.equals(ProjRecTypeEnum.TerminateReport.getId()) ){
				 _statusId =  ProjCompleteStatusEnum.Apply.getId();
				 _statusName =ProjCompleteStatusEnum.Apply.getName();
			}
			if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope)){
				_remark = ProcessRemarkEnum.FirstAuditNotAgree.getName();
			}else if(GlobalConstant.PROJ_STATUS_SCOPE_CHARGE.equals(projListScope)){
				_remark = ProcessRemarkEnum.SecondAuditNotAgree.getName();
			}else if(GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL.equals(projListScope)){
				_remark = ProcessRemarkEnum.ThirdAuditNotAgree.getName();
			}
		}
		
		//1.修改Rec状态：审核
		rec.setProjStatusId(_statusId);
		rec.setProjStatusName(_statusName);
		orgRecordInfo(rec, currUser, false);
		modProjRec(rec);
		
		//2.回写项目状态
		proj.setProjStatusId(_statusId);
		proj.setProjStatusName(_statusName);
		projBiz.modProject(proj);
		
		//3.新增process
		processBiz.addProcess(rec,_remark,auditContent);
	}
	
	@Override
	public PubProjRec selectProjRecByProjFlowAndRecType(String projFlow , String recTypeId){
		PubProjRecExample example = new PubProjRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).
			andProjFlowEqualTo(projFlow).
			andRecTypeIdEqualTo(recTypeId);
		example.setOrderByClause("MODIFY_TIME DESC");
		List<PubProjRec> projRecList = this.projRecMapper.selectByExampleWithBLOBs(example);
		if(!projRecList.isEmpty()){
			return projRecList.get(0);
		}
		return null;
	}
	
	@Override
	public Integer selectRecCountByProjFlowAndRecType(String projFlow , String recTypeId){
		PubProjRecExample example = new PubProjRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).
			andProjFlowEqualTo(projFlow).
			andRecTypeIdEqualTo(recTypeId);
		example.setOrderByClause("MODIFY_TIME DESC");
		return this.projRecMapper.countByExample(example);
	}
	
	@Override
	public PubProjRec selectProjRecWithContentByProjFlowAndRecType(
			String projFlow, String recTypeId) {
		PubProjRecExample example = new PubProjRecExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).
			andProjFlowEqualTo(projFlow).
			andRecTypeIdEqualTo(recTypeId);
		List<PubProjRec> projRecList = this.projRecMapper.selectByExampleWithBLOBs(example);
		if(projRecList.size()==1){
			return projRecList.get(0);
		}
		return null;
	}
    
	
	@Override
	public List<PubProjRec> selectProjRecByProjFlowAndRecList(String projFlow,
			List<String> recTypeList) {
		PubProjRecExample example = new PubProjRecExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotEmpty(projFlow)){
			criteria.andProjFlowEqualTo(projFlow);
		}
		if(null!=recTypeList && !recTypeList.isEmpty()){
			criteria.andRecTypeIdIn(recTypeList);
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return projRecMapper.selectByExample(example); 
	}

	@Override
	public void modProjRecWithXml(PubProjRec applyRec) {
		String currDateTime = DateUtil.getCurrDateTime();
		applyRec.setModifyTime(currDateTime);
		this.projRecMapper.updateByPrimaryKeyWithBLOBs(applyRec);
		
	}

	@Override
	public List<PubProjRec> searchCompleteAndTerminate(String projFlow,
			String projStatusId) {
		PubProjRecExample example = new PubProjRecExample();
		example.setOrderByClause("OPER_TIME DESC");
		example.createCriteria().andProjFlowEqualTo(projFlow)
		.andProjStageIdEqualTo(projStatusId)
		.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		List<PubProjRec> recList=this.projRecMapper.selectByExample(example);
		return recList;
	}

	@Override
	public List<PubProjRec> searchProjRec(PubProjRec projRec) {
		
		PubProjRecExample example = new PubProjRecExample();
		example.setOrderByClause("OPER_TIME");
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(projRec.getProjFlow())){
			criteria.andProjFlowEqualTo(projRec.getProjFlow());
		}
		return projRecMapper.selectByExample(example);
	}

	@Override
	public List<PubProjRec> searchProjRecNotInApply(PubProjRec projRec) {
		PubProjRecExample example = new PubProjRecExample();
		example.setOrderByClause("OPER_TIME");
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(projRec.getProjFlow())){
			criteria.andProjFlowEqualTo(projRec.getProjFlow());
		}
	    List<String> status=new ArrayList<String>();
	    status.add(ProjApplyStatusEnum.Apply.getId());
	    status.add(ProjContractStatusEnum.Apply.getId());
	    status.add(ProjScheduleStatusEnum.Apply.getId());
	    status.add(ProjCompleteStatusEnum.Apply.getId());
	    criteria.andProjStatusIdNotIn(status);
		return projRecMapper.selectByExample(example);
	}
}
