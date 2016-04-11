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
import com.pinde.sci.biz.srm.IExpertGroupProjBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.SrmExpertProjEvalMapper;
import com.pinde.sci.dao.base.SrmExpertProjMapper;
import com.pinde.sci.dao.srm.SrmExpertGroupExtMapper;
import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmExpertProjEvalExample;
import com.pinde.sci.model.mo.SrmExpertProjEvalExample.Criteria;
import com.pinde.sci.model.mo.SrmExpertProjExample;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SrmExpertGroupProjExt;
@Service
@Transactional(rollbackFor=Exception.class)
public class ExpertGroupProjBizImpl implements IExpertGroupProjBiz{
	@Autowired
	private SrmExpertProjEvalMapper srmExpertGroupProjMapper;
	@Autowired
	private SrmExpertGroupExtMapper srmExpertGroupExtMapper;
	@Autowired
	private SrmExpertProjMapper expertProjMapper;
	
	@Override
	public SrmExpertProjEval searchSrmExpertGroupProjByProjFlowAndEvaluationId(
			String projFlow, String evaluationId) {
		
//		Map<String, Object> paramMap = new HashMap<String , Object>();
//		paramMap.put("projFlow", projFlow);
//		paramMap.put("evaluationId" , evaluationId);
//		return this.srmExpertGroupExtMapper.searchGroupProjByProjFlowAndEvaluationId(paramMap);
		
		SrmExpertProjEvalExample example = new SrmExpertProjEvalExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y).andProjFlowEqualTo(projFlow).andEvaluationIdEqualTo(evaluationId);
		List<SrmExpertProjEval> groupProjList = this.srmExpertGroupProjMapper.selectByExample(example);
		if(groupProjList!=null && groupProjList.size()==1){
			return groupProjList.get(0);
		}
		
		return null;
	}


	@Override
	public void save(SrmExpertProjEval expGroupProj) {
		SysUser currUser = GlobalContext.getCurrentUser();
		if(StringUtil.isNotBlank(expGroupProj.getEvalSetFlow())){
			expGroupProj.setModifyTime(DateUtil.getCurrDateTime());
			expGroupProj.setModifyUserFlow(currUser.getUserFlow());
			srmExpertGroupProjMapper.updateByPrimaryKeySelective(expGroupProj);
		}else {
			expGroupProj.setEvalSetFlow(PkUtil.getUUID());
			expGroupProj.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			expGroupProj.setCreateTime(DateUtil.getCurrDateTime());
			expGroupProj.setCreateUserFlow(currUser.getUserFlow());
			expGroupProj.setModifyTime(DateUtil.getCurrDateTime());
			expGroupProj.setModifyUserFlow(currUser.getUserFlow());
			srmExpertGroupProjMapper.insert(expGroupProj);
		}
	}


	@Override
	public Map<String, SrmExpertProjEval> orgExperGroupProjMap() {
		SrmExpertProjEvalExample example = new SrmExpertProjEvalExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<SrmExpertProjEval> list = srmExpertGroupProjMapper.selectByExample(example);
		Map<String,SrmExpertProjEval> resultMap = new HashMap<String, SrmExpertProjEval>();
		for(SrmExpertProjEval temp : list){
			resultMap.put(temp.getProjFlow(), temp);
		}
		return resultMap;
	}


	@Override
	public SrmExpertProjEval searchSrmExpertGroupProjByFlow(String recordFlow) {
		return this.srmExpertGroupProjMapper.selectByPrimaryKey(recordFlow);
	}


	@Override
	public List<SrmExpertGroupProjExt> searchSrmExpertGroupProjList(
			SrmExpertGroupProjExt srmExpertGroupProjExt) {
		return this.srmExpertGroupExtMapper.selectExpertGroupProjList(srmExpertGroupProjExt);
	}


	@Override
	public void modExpertGroupProjByFlow(SrmExpertProjEval expertGroupProj) {
		this.srmExpertGroupProjMapper.updateByPrimaryKeySelective(expertGroupProj);
	}


	@Override
	public void cancelEvalSet(SrmExpertProjEval expertGroupProj) {
		//更新该评审设置 ， 将该评审设置状态标记为N
		this.modExpertGroupProjByFlow(expertGroupProj);
		//更新专家需要评审的项目 将该次评审设置下设置的专家记录状态设置为N
		SrmExpertProjExample example = new SrmExpertProjExample();
		example.createCriteria().andEvalSetFlowEqualTo(expertGroupProj.getEvalSetFlow());
		SrmExpertProj record = new SrmExpertProj();
		record.setRecordStatus(GlobalConstant.FLAG_N);
		this.expertProjMapper.updateByExampleSelective(record , example);
		
	}


	@Override
	public SrmExpertProjEval read(String evalSetFlow) {
		return this.srmExpertGroupProjMapper.selectByPrimaryKey(evalSetFlow);
	}


	@Override
	public List<SrmExpertProjEval> searchSrmExpertGroupProj(
			SrmExpertProjEval srmExpertGroupProj) {
		SrmExpertProjEvalExample example = new SrmExpertProjEvalExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(srmExpertGroupProj.getRecordStatus())){
			criteria.andRecordStatusEqualTo(srmExpertGroupProj.getRecordStatus());
		}
		if(StringUtil.isNotBlank(srmExpertGroupProj.getGroupFlow())){
			criteria.andGroupFlowEqualTo(srmExpertGroupProj.getGroupFlow());
		}
		if(StringUtil.isNotBlank(srmExpertGroupProj.getProjFlow())){
			criteria.andProjFlowEqualTo(srmExpertGroupProj.getProjFlow());
		}
		return this.srmExpertGroupProjMapper.selectByExample(example );
	}


	
}
