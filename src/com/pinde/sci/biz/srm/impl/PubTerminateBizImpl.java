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
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//��ӽ׶β�ѯ����ʹ���׶���������Ŀ����ͬ�����������ղ�ѯ��Ŀͨ��)
		String _statusEnumIdForEditing = "";				//�״��ύ���������Ŀ
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//�걨�׶�
			_statusEnumIdForEditing = ProjApplyStatusEnum.Submit.getId(); 
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // ���˷�������Ŀ
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){		//����׶�
			_statusEnumIdForEditing = ProjContractStatusEnum.Submit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//ʵʩ�׶�
			_statusEnumIdForEditing = ProjScheduleStatusEnum.Submit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//�����׶�
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
		//��չ��ѯ����Բ�ͬrecType��Ŀͨ��
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
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//��ӽ׶β�ѯ����ʹ���׶���������Ŀ����ͬ�����������ղ�ѯ��Ŀͨ��)
		String _statusEnumIdForEditing = "";				//�������ͨ����ļ�¼
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//�걨�׶�
			_statusEnumIdForEditing = ProjApplyStatusEnum.FirstAudit.getId(); 
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // ���˷�������Ŀ
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){	//����׶�
			_statusEnumIdForEditing = ProjContractStatusEnum.FirstAudit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//ʵʩ�׶�
			_statusEnumIdForEditing = ProjScheduleStatusEnum.FirstAudit.getId(); 
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//�����׶�
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
		//��չ��ѯ����Բ�ͬrecType��Ŀͨ��
		return pubProjExtMapper.selectChargeProj(paramMap);
		*/
		return commBiz.searchProjList(proj, recTypeId);
	
	}

	@Override
	public List<PubProj> searchGlobalProj(PubProj proj, String recTypeId) {
		/*
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//��ӽ׶β�ѯ����ʹ���׶���������Ŀ����ͬ�����������ղ�ѯ��Ŀͨ��)
		String _statusEnumIdForEditing = "";				//������д��
		String _statusEnumIdForThrirdAudit = "";			//����������˼�¼
		if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//�걨�׶�
			_statusEnumIdForEditing = ProjApplyStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjApplyStatusEnum.ThirdAudit.getId();
			criteria.andProjStatusIdNotEqualTo(ProjApplyStatusEnum.NotApprove.getId()); // ���˷�������Ŀ
		}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){	//����׶�
			_statusEnumIdForEditing = ProjContractStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjContractStatusEnum.ThirdAudit.getId();
		}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//ʵʩ�׶�
			_statusEnumIdForEditing = ProjScheduleStatusEnum.Apply.getId(); 
			_statusEnumIdForThrirdAudit = ProjScheduleStatusEnum.ThirdAudit.getId();
		}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//�����׶�
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
		//��չ��ѯ����Բ�ͬrecType��Ŀͨ��
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
