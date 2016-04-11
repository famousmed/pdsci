package com.pinde.sci.biz.srm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ICommonBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IProjRecBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjCompleteStatusEnum;
import com.pinde.sci.enums.srm.ProjContractStatusEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.PubProjExample.Criteria;

@Service
public class CommonBizImpl implements ICommonBiz{

	@Autowired
	private IProjRecBiz projRecBiz;
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;
	
	

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

	@Override
	public List<PubProj> searchProjList(PubProj proj, String recTypeId) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		String currentOrgFlow = currentUser.getOrgFlow();
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			currentOrgFlow = proj.getApplyOrgFlow();
		}
		PubProjExample projectExample  = new PubProjExample();
		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		String projCateScope = (String)GlobalContext.getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		criteria.andProjCategoryIdEqualTo(projCateScope);
		criteria.andProjStageIdEqualTo(proj.getProjStageId());//添加阶段查询，可使各阶段审批（项目、合同、季报、验收查询项目通用)
		String _statusEnumIdForEditing = "";				
		//卫生局查询时才会用到  , 用于表示不是该项目状态的项目
		String statusEnumIdForNoSearch1 = "";
		String statusEnumIdForNoSearch2 = "";
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			_statusEnumIdForEditing = proj.getProjStatusId();
			
		}else{
			if(proj.getProjStageId().equals(ProjStageEnum.Apply.getId())){		//申报阶段
				statusEnumIdForNoSearch1  = ProjApplyStatusEnum.Apply.getId(); 
				statusEnumIdForNoSearch2  = ProjApplyStatusEnum.ThirdAudit.getId();
				
			}else if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){	//立项阶段
				//statusEnumIdForNoSearch1  = ProjContractStatusEnum.Apply.getId(); 
				//statusEnumIdForNoSearch2  = ProjContractStatusEnum.ThirdAudit.getId();
				criteria.andProjStatusIdNotEqualTo(ProjApproveStatusEnum.NotApprove.getId()); // 过滤非立项项目
			}else if(proj.getProjStageId().equals(ProjStageEnum.Contract.getId())){
				statusEnumIdForNoSearch1  = ProjContractStatusEnum.Apply.getId(); 
				statusEnumIdForNoSearch2  = ProjContractStatusEnum.ThirdAudit.getId();
			}else if(proj.getProjStageId().equals(ProjStageEnum.Schedule.getId())){	//实施阶段
				statusEnumIdForNoSearch1  = ProjScheduleStatusEnum.Apply.getId(); 
				statusEnumIdForNoSearch2  = ProjScheduleStatusEnum.ThirdAudit.getId();
			}else if(proj.getProjStageId().equals(ProjStageEnum.Complete.getId())){	//结束阶段
				statusEnumIdForNoSearch1  = ProjCompleteStatusEnum.Apply.getId(); 
				statusEnumIdForNoSearch2  = ProjCompleteStatusEnum.ThirdAudit.getId();
			}
		}
		if(proj.getProjStageId().equals(ProjStageEnum.Approve.getId())){		//申报阶段
			criteria.andProjStatusIdNotEqualTo(ProjApproveStatusEnum.NotApprove.getId()); // 过滤非立项项目
		}
		
		projectExample.setOrderByClause("proj_year desc,apply_org_flow,create_time");
		pageConditionForSearchProj(proj, criteria);
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("example", projectExample);
		paramMap.put("orgFlow", currentOrgFlow);
		paramMap.put("_statusEnumIdForEditing", _statusEnumIdForEditing);
		paramMap.put("recTypeId", recTypeId);
		paramMap.put("statusEnumIdForNoSearch1", statusEnumIdForNoSearch1);
		paramMap.put("statusEnumIdForNoSearch2", statusEnumIdForNoSearch2);
		//扩展查询，针对不同recType项目通用
		return pubProjExtMapper.selectProjList(paramMap);
	}
	
	

}
