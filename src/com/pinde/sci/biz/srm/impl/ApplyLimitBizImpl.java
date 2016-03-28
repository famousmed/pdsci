package com.pinde.sci.biz.srm.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IApplyLimitBiz;
import com.pinde.sci.biz.srm.IPubProjBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SrmApplyLimitMapper;
import com.pinde.sci.dao.pub.PubProjExtMapper;
import com.pinde.sci.enums.srm.ProjApplyStatusEnum;
import com.pinde.sci.enums.srm.ProjApproveStatusEnum;
import com.pinde.sci.enums.srm.ProjScheduleStatusEnum;
import com.pinde.sci.enums.srm.ProjStageEnum;
import com.pinde.sci.form.srm.ApplyLimitNumForm;
import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmApplyLimit;
import com.pinde.sci.model.mo.SrmApplyLimitExample;
@Service
@Transactional(rollbackFor = Exception.class)
public class ApplyLimitBizImpl implements IApplyLimitBiz {
	@Autowired
	private SrmApplyLimitMapper applyLimitMapper;
	@Autowired
	private IPubProjBiz projBiz;
	@Autowired
	private PubProjExtMapper pubProjExtMapper;

	@Override
	public int saveApplyLimitList(List<SrmApplyLimit> applyLimitList) {
		if(applyLimitList != null && !applyLimitList.isEmpty()){
			int addCount = 0 ;
			for(SrmApplyLimit al : applyLimitList){
//				if(null == al.getLimitNum()){
//					al.setLimitNum(new Short("0"));
//				}
				saveApplyLimit(al);
				addCount ++;
			}
			return addCount;
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int saveApplyLimit(SrmApplyLimit applyLimit) {
		if(StringUtil.isNotBlank(applyLimit.getLimitFlow())){
			SrmApplyLimit exitApplyLimit = this.applyLimitMapper.selectByPrimaryKey(applyLimit.getLimitFlow());
			exitApplyLimit.setLimitNum(applyLimit.getLimitNum());
			GeneralMethod.setRecordInfo(applyLimit, false);
			return applyLimitMapper.updateByPrimaryKey(exitApplyLimit);
		}else{
			applyLimit.setLimitFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(applyLimit, true);
			return applyLimitMapper.insert(applyLimit);
		}
	}

	@Override
	public List<SrmApplyLimit> searchApplyLimitList(SrmApplyLimit applyLimit) {
		SrmApplyLimitExample example = new SrmApplyLimitExample();
		com.pinde.sci.model.mo.SrmApplyLimitExample.Criteria criteria =  example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(applyLimit.getOrgFlow())){
			criteria.andOrgFlowEqualTo(applyLimit.getOrgFlow());
		}
		if(StringUtil.isNotBlank(applyLimit.getProjCategroyId())){
			criteria.andProjCategroyIdEqualTo(applyLimit.getProjCategroyId());
		}
		if(StringUtil.isNotBlank(applyLimit.getProjTypeId())){
			criteria.andProjTypeIdEqualTo(applyLimit.getProjTypeId());
		}
		return applyLimitMapper.selectByExample(example);
	}

	@Override
	public ApplyLimitNumForm checkApplyLimit(String projListScope, String agreeFlag, String projFlow) {
		ApplyLimitNumForm form = new ApplyLimitNumForm();
		form.setResultFlag(GlobalConstant.FLAG_Y);
		if(GlobalConstant.PROJ_STATUS_SCOPE_LOCAL.equals(projListScope) && GlobalConstant.FLAG_Y.equals(agreeFlag) && StringUtil.isNotBlank(projFlow)){
			PubProj proj = projBiz.readProject(projFlow);
			if(proj != null){
				SrmApplyLimit applyLimit = new SrmApplyLimit();
				applyLimit.setOrgFlow(proj.getApplyOrgFlow());
				applyLimit.setProjCategroyId(proj.getProjCategoryId());
				applyLimit.setProjTypeId(proj.getProjTypeId());
				List<SrmApplyLimit> applyLimitList = searchApplyLimitList(applyLimit);
				if(applyLimitList != null && !applyLimitList.isEmpty()){
					applyLimit = applyLimitList.get(0);
					Short limitNum = applyLimit.getLimitNum();
					if(null != limitNum){
						//查询已审核通过的项目数
						Map<String, Object> paramMap = new HashMap<String, Object>(); 
						PubProj searchProj = new PubProj();
						searchProj.setApplyOrgFlow(proj.getApplyOrgFlow());
						searchProj.setProjCategoryId(proj.getProjCategoryId());
						searchProj.setProjTypeId(proj.getProjTypeId());
						searchProj.setProjYear(DateUtil.getYear());
						paramMap.put("pubProj", searchProj);
						paramMap.put("projStageId", ProjStageEnum.Apply.getId());
						paramMap.put("projApplyStatusId1", ProjApplyStatusEnum.Apply.getId());
						paramMap.put("projApplyStatusId2", ProjApplyStatusEnum.Submit.getId());
						int auditCount = pubProjExtMapper.searchAuditCount(paramMap);
						if(auditCount >= limitNum){
							form.setLimitNum(limitNum);
							form.setAuditCount(auditCount);
							form.setResultFlag(GlobalConstant.FLAG_N);
						}
					}
				}
			}
		}
		return form;
	}
}
