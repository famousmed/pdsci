package com.pinde.sci.biz.srm.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjStatementBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjExample.Criteria;
import com.pinde.sci.model.mo.SysOrg;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjStatementBizImpl implements IProjStatementBiz{

	@Autowired
	private PubProjMapper pubProjMapper;
	@Autowired
	private IOrgBiz orgBiz;
	
	
	@Override
	public List<PubProj> searchPuisneProj(PubProj proj) {
		List<SysOrg> orgList=null;
		PubProjExample example = new PubProjExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
	    if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
	    	orgList=orgBiz.searchChildrenOrgByOrgFlow(proj.getApplyOrgFlow());
	    } 
	    if(StringUtil.isNotBlank(proj.getProjTypeId())){
	    	criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
	    }
	    List<PubProj> projList=pubProjMapper.selectByExample(example);
	    List<String> orgFlowList=new ArrayList<String>();
	    if(null!=orgList && !orgList.isEmpty()){
	    	for(SysOrg org:orgList){
	    		orgFlowList.add(org.getOrgFlow());
	    	}
	    }
	    List<PubProj> needRemoveList=new ArrayList<PubProj>();
	    for(PubProj pubProj:projList){
	       if(!orgFlowList.contains(pubProj.getApplyOrgFlow())){
	    	   needRemoveList.add(pubProj);
	       }
	    }
	    projList.removeAll(needRemoveList);
		return projList;
	}

}
