package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjSearchBiz;
import com.pinde.sci.biz.sys.impl.OrgBizImpl;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.PubProjExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjSearchBizImpl implements IProjSearchBiz{


	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private OrgBizImpl orgBiz;
	
	@Override
	public List<PubProj> searchProj(PubProj proj,List<SysOrg> orgList) {
		
		PubProjExample example  = new PubProjExample();
		example.setOrderByClause("CREATE_TIME DESC");
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		String projCateScope = (String)GlobalContext.getSessionAttribute(GlobalConstant.PROJ_CATE_SCOPE);
		criteria.andProjCategoryIdEqualTo(projCateScope);
		
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
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			criteria.andProjStageIdEqualTo(proj.getProjStageId());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
	    List<PubProj> projList=pubProjMapper.selectByExample(example);
		//查询在列表中的机构下的项目
	    List<String> orgFlowList=null;
	    List<PubProj> needRemoveList=new ArrayList<PubProj>();
		if(null!=orgList && !orgList.isEmpty()){
			orgFlowList=new ArrayList<String>();
			for(SysOrg org:orgList){
				orgFlowList.add(org.getOrgFlow());
			}
			//过滤掉申报机构流水号不在orgFlowList中的项目
	        if(null!=projList && !projList.isEmpty()){
	        	for(PubProj project:projList){
	        		if(!orgFlowList.contains(project.getApplyOrgFlow())){
	        		   needRemoveList.add(project);
	        		}
	        	}
	        }
		}
		
        projList.removeAll(needRemoveList);
        return projList;
		
	}

	@Override
	public List<PubProj> searchProj(PubProj proj) {
		PubProjExample example  = new PubProjExample();
		example.setOrderByClause("CREATE_TIME DESC");
		Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		if(StringUtil.isNotBlank(proj.getProjCategoryId())){
			criteria.andProjCategoryIdEqualTo(proj.getProjCategoryId());	
		}
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
		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
			criteria.andApplyOrgFlowEqualTo(proj.getApplyOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getChargeOrgFlow())){
			criteria.andChargeOrgFlowEqualTo(proj.getChargeOrgFlow());
		}
		if(StringUtil.isNotBlank(proj.getProjStageId())){
			criteria.andProjStageIdEqualTo(proj.getProjStageId());
		}
		if(StringUtil.isNotBlank(proj.getProjStatusId())){
			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
		}
	    List<PubProj> projList=pubProjMapper.selectByExample(example);
	    return projList;
	}

	

}
