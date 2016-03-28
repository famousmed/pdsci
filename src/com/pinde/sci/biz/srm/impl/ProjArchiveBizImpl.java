package com.pinde.sci.biz.srm.impl;


import java.util.List;




import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;




import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IProjArchiveBiz;
import com.pinde.sci.biz.srm.IProjProcessBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubProjMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjExample;
import com.pinde.sci.model.mo.PubProjProcess;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.PubProjExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class ProjArchiveBizImpl implements IProjArchiveBiz{

	@Resource
	private PubProjMapper pubProjMapper;
	@Autowired
	private IPubProjBiz projBiz;		
	@Autowired
	private IProjProcessBiz projProcessBiz;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;
	
	
	@Override
	public List<PubProj> searchProj(PubProj proj) {
//		SysUser currentUser = GlobalContext.getCurrentUser();
//		String currentOrgFlow = currentUser.getOrgFlow();
//		if(StringUtil.isBlank(proj.getApplyOrgFlow())){
//			proj.setApplyOrgFlow(currentOrgFlow);
//		}
//		
//		PubProjExample projectExample  = new PubProjExample();
//		Criteria criteria =  projectExample.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
//		criteria.andProjStageIdEqualTo(proj.getProjStageId());
//		if(StringUtil.isNotBlank(proj.getProjStatusId())){
//			criteria.andProjStatusIdEqualTo(proj.getProjStatusId());
//		}
//		if(StringUtil.isNotBlank(proj.getApplyOrgFlow())){
//			currentOrgFlow = proj.getApplyOrgFlow();
//			criteria.andApplyOrgFlowEqualTo(currentOrgFlow);
//		}
//		if(StringUtil.isNotBlank(proj.getProjName())){
//			criteria.andProjNameLike("%"+proj.getProjName()+"%");
//		}
//		if(StringUtil.isNotBlank((proj.getProjNo()))){
//			criteria.andProjNoEqualTo(proj.getProjNo());
//		}
//		if(StringUtil.isNotBlank((proj.getProjYear()))){
//			criteria.andProjYearEqualTo(proj.getProjYear());
//		}
//		if(StringUtil.isNotBlank(proj.getProjTypeId())){
//			criteria.andProjTypeIdEqualTo(proj.getProjTypeId());
//		}
//		projectExample.setOrderByClause("CREATE_TIME DESC");
		return pubProjExtMapper.selectCommonProjList(proj);
	
	}


	@Override
	public void saveArchiveResult(PubProj project, PubProjProcess process) {
	     GeneralMethod.setRecordInfo(project, false);
	     pubProjMapper.updateByPrimaryKeySelective(project);
	     projProcessBiz.addProcess(process);
	}

}
