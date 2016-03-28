package com.pinde.sci.biz.srm.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjProcessMapper;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.PubProjProcessExample;
import com.pinde.sci.model.mo.PubProjProcessExample.Criteria;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjProcessBizImpl implements IProjProcessBiz{

	@Autowired
	private PubProjProcessMapper projProcessDao;
	
	private PubProjProcess _getProcess(PubProjRec rec) {
		SysUser currUser = GlobalContext.getCurrentUser();
		//过程表默认第一条记录
		PubProjProcess process = new PubProjProcess();
		process.setProcessFlow(PkUtil.getUUID());
		process.setProjFlow(rec.getProjFlow());
		process.setProjStageId(rec.getProjStageId());
		process.setProjStageName(rec.getProjStageName());
		process.setProjStatusId(rec.getProjStatusId());
		process.setProjStatusName(rec.getProjStatusName());
		
		process.setOperUserFlow(currUser.getUserFlow());
		process.setOperUserName(currUser.getUserName());
		process.setOperOrgFlow(currUser.getOrgFlow());
		process.setOperOrgName(currUser.getOrgName());
		
		process.setRecFlow(rec.getRecFlow());
		process.setRecTypeId(rec.getRecTypeId());
		process.setRecTypeName(rec.getRecTypeName());
		GeneralMethod.setRecordInfo(process,true);
		return process;
	}

	@Override
	public void addProcess(PubProjProcess process) {
		process.setProcessFlow(PkUtil.getUUID());
		SysUser currUser = GlobalContext.getCurrentUser();
		process.setOperUserFlow(currUser.getUserFlow());
		process.setOperUserName(currUser.getUserName());
		process.setOperOrgFlow(currUser.getOrgFlow());
		process.setOperOrgName(currUser.getOrgName());
		GeneralMethod.setRecordInfo(process,true);
		projProcessDao.insertSelective(process); 
	}
	
	@Override
	public void addProcess(PubProjRec rec, String remark,String auditContent) {
		PubProjProcess process =  _getProcess(rec);
		process.setAuditContent(auditContent);
		process.setProcessRemark(remark);
		process.setOperTime(DateUtil.getCurrDateTime());
		projProcessDao.insert(process); 
	}
	

	@Override
	public void addProcess(PubProjRec rec) {
		PubProjProcess process =  _getProcess(rec);
		projProcessDao.insert(process); 
	}

	@Override
	public List<PubProjProcess> searchProjProcess(PubProjProcess projProcess) {
		PubProjProcessExample example = new PubProjProcessExample();
		example.setOrderByClause("CREATE_TIME");
		Criteria criteria =  example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(projProcess.getProjFlow())){
			criteria.andProjFlowEqualTo(projProcess.getProjFlow());
		}
		if(StringUtil.isNotBlank(projProcess.getProjStageId())){
			criteria.andProjStageIdEqualTo(projProcess.getProjStageId());
		}
		if(StringUtil.isNotBlank(projProcess.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(projProcess.getProjStatusId());
		}
		return this.projProcessDao.selectByExample(example);
		
	}

	@Override
	public List<PubProjProcess> searchAuditProjProcess(PubProjProcess projProcess, String orderByClause) {
		PubProjProcessExample example = new PubProjProcessExample();
		Criteria criteria =  example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andProcessRemarkIsNotNull();
		if(StringUtil.isNotBlank(projProcess.getProjFlow())){
			criteria.andProjFlowEqualTo(projProcess.getProjFlow());
		}
		if(StringUtil.isNotBlank(orderByClause)){
			example.setOrderByClause(orderByClause);
		}
		return this.projProcessDao.selectByExample(example);
	}

	@Override
	public List<PubProjProcess> searchApproveProcess(PubProjProcess process) {
		PubProjProcessExample example = new PubProjProcessExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(process.getRecTypeId())){
			criteria.andRecTypeIdEqualTo(process.getRecTypeId());
		}
		if(StringUtil.isNotBlank(process.getProjFlow())){
			criteria.andProjFlowEqualTo(process.getProjFlow());
		}
		if(StringUtil.isNotBlank(process.getProjStageId())){
			criteria.andProjStageIdEqualTo(process.getProjStageId());
		}
		if(StringUtil.isNotBlank(process.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(process.getProjStatusId());
		}
		criteria.andRecFlowIsNull();
		example.setOrderByClause("CREATE_TIME DESC");
		return  this.projProcessDao.selectByExample(example);
	}

	@Override
	public List<PubProjProcess> searchProjProcessByProjFlowList(
			List<String> projFlowList) {
		PubProjProcessExample example = new PubProjProcessExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andProjFlowIn(projFlowList);
		example.setOrderByClause("CREATE_TIME DESC");
		return this.projProcessDao.selectByExample(example);
	}

	@Override
	public PubProjProcess searchLastProcess(PubProjProcess process) {
		PubProjProcessExample example = new PubProjProcessExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if(StringUtil.isNotBlank(process.getProjFlow())){
			criteria.andProjFlowEqualTo(process.getProjFlow());
		}
		if(StringUtil.isNotBlank(process.getProjStageId())){
			criteria.andProjStageIdEqualTo(process.getProjStageId());
		}
		if(StringUtil.isNotBlank(process.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(process.getProjStatusId());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		List<PubProjProcess> processList = this.projProcessDao.selectByExample(example);
		return processList.get(0);
	}

	


	
}
