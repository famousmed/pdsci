package com.pinde.sci.biz.srm.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ICommonBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.biz.srm.IProjTerminateBiz;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubTerminateBizImpl implements IProjTerminateBiz{

	@Autowired
	private IProjRecBiz projRecBiz;
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;
	@Autowired
	private ICommonBiz commBiz;
	
	
	@Override
	public List<PubProj> searchLocalProj(PubProj proj, String recTypeId) {
		/*
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//添加阶段查询，可使各阶段审批（项目、合同、季报、验收查询项目通用)
		String _statusEnumIdForEditing = "";				//首次提交机构审核项目
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//申报阶段
			_statusEnumIdForEditing = ProjApplyStatusEnum.Submit.getId(); 
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // 过滤非立项项目
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){		//立项阶段
			_statusEnumIdForEditing = ProjContractStatusEnum.Submit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//实施阶段
			_statusEnumIdForEditing = ProjScheduleStatusEnum.Submit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//结束阶段
			_statusEnumIdForEditing = ProjCompleteStatusEnum.Submit.getId(); 
		}
		//criteria.andProjStatusIdEqualTo(_statusEnumIdForEditing);		
		criteria.andApplyOrgFlowEqualTo(currentOrgFlow);
		projectExample.setOrderByClause("proj_year desc,apply_org_flow,create_time");
		pageConditionForSearchProj(proj, criteria);
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("example", projectExample);
		paramMap.put("_statusEnumIdForEditing", _statusEnumIdForEditing);
		paramMap.put("recTypeId", recTypeId);
		//return pubProjMapper.selectByExample(projectExample);
		//扩展查询，针对不同recType项目通用
		return pubProjExtMapper.selectLocalProj(paramMap);
		*/
		return commBiz.searchProjList(proj, recTypeId);

	}

	@Override
	public List<PubProj> searchChargeProj(PubProj proj, String recTypeId) {
		/*
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//添加阶段查询，可使各阶段审批（项目、合同、季报、验收查询项目通用)
		String _statusEnumIdForEditing = "";				//机构审核通过后的记录
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//申报阶段
			_statusEnumIdForEditing = ProjApplyStatusEnum.FirstAudit.getId(); 
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // 过滤非立项项目
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){	//立项阶段
			_statusEnumIdForEditing = ProjContractStatusEnum.FirstAudit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//实施阶段
			_statusEnumIdForEditing = ProjScheduleStatusEnum.FirstAudit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//结束阶段
			_statusEnumIdForEditing = ProjCompleteStatusEnum.FirstAudit.getId(); 
		}
//		criteria.andProjStatusIdEqualTo(_statusEnumIdForEditing);		
		projectExample.setOrderByClause("proj_year desc,apply_org_flow,create_time");
		pageConditionForSearchProj(proj, criteria);
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("example", projectExample);
		paramMap.put("currentOrgFlow", currentOrgFlow);
		paramMap.put("_statusEnumIdForEditing", _statusEnumIdForEditing);
		paramMap.put("recTypeId", recTypeId);
//		return pubProjExtMapper.selectChargeProj(paramMap);
		//扩展查询，针对不同recType项目通用
		return pubProjExtMapper.selectChargeProj(paramMap);
		*/
		return commBiz.searchProjList(proj, recTypeId);
	
	}

	@Override
	public List<PubProj> searchGlobalProj(PubProj proj, String recTypeId) {
		/*
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//添加阶段查询，可使各阶段审批（项目、合同、季报、验收查询项目通用)
		String _statusEnumIdForEditing = "";				//过滤填写中
		String _statusEnumIdForThrirdAudit = "";			//过滤最终审核记录
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//申报阶段
			_statusEnumIdForEditing = ProjApplyStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjApplyStatusEnum.ThirdAudit.getId();
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // 过滤非立项项目
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){	//立项阶段
			_statusEnumIdForEditing = ProjContractStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjContractStatusEnum.ThirdAudit.getId();
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//实施阶段
			_statusEnumIdForEditing = ProjScheduleStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjScheduleStatusEnum.ThirdAudit.getId();
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//结束阶段
			_statusEnumIdForEditing = ProjCompleteStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjCompleteStatusEnum.ThirdAudit.getId();
		}
//		criteria.andProjStatusIdNotEqualTo(_statusEnumIdForEditing);		
//		criteria.andProjStatusIdNotEqualTo(_statusEnumIdForThrirdAudit); 
		projectExample.setOrderByClause("proj_year desc,apply_org_flow,create_time");
		pageConditionForSearchProj(proj, criteria);
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("example", projectExample);
		paramMap.put("_statusEnumIdForEditing", _statusEnumIdForEditing);
		paramMap.put("_statusEnumIdForThrirdAudit", _statusEnumIdForThrirdAudit);
		paramMap.put("recTypeId", recTypeId);
//		return pubProjMapper.selectByExample(projectExample);
		//扩展查询，针对不同recType项目通用
		return pubProjExtMapper.selectGlobalProj(paramMap);
		*/
		return commBiz.searchProjList(proj, recTypeId);
	
	}
    
	
	private void pageConditionForSearchProj(PubProj proj, Criteria criteria) {
		if(StringUtil.isNotBlank(proj.getProjName())){
			criteria.andProjNameLike("%"+proj.getProjName()+"%");
		}
		if(StringUtil.isNotBlank((proj.getProjNo()))){
			criteria.andProjNoEqualTo(proj.getProjNo());
		}
		if(StringUtil.isNotBlank((proj.getProjYear()))){
			criteria.andProjYearEqualTo(proj.getProjYear());
		}
		if(StringUtil.isNotBlank(proj.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
		}
		if(StringUtil.isNotBlank(proj.getProjSubTypeId())){
			criteria.andProjSubTypeIdEqualTo(proj.getProjSubTypeId());
		}
	}
}
