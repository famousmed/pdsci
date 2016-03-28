package com.pinde.sci.biz.srm.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.IExpertBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmExpertMapper;
import com.pinde.sci.dao.base.SysOrgMapper;
import com.pinde.sci.dao.base.SysUserMapper;
import com.pinde.sci.dao.srm.ExpertExtMapper;
import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SrmExpertExample;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.srm.SysUserExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class ExpertBizImpl implements IExpertBiz{

	@Resource
	private SrmExpertMapper srmExpertMapper;
	@Resource
	private SysUserMapper sysUserMapper;
	@Resource
	SysOrgMapper sysOrgMapper;
	
	@Autowired
	private ExpertExtMapper expertExtMapper;
	
	@Override
	public SrmExpert readExpert(String userFlow) {
		return this.srmExpertMapper.selectByPrimaryKey(userFlow);
	}

	@Override
	public int updateSysUserAndSrmExpert(SysUser user, SrmExpert expert) {

		//更新机构名称
		SysOrg org = sysOrgMapper.selectByPrimaryKey(user.getOrgFlow());
		user.setOrgName(org.getOrgName());
		
		GeneralMethod.setRecordInfo(user, false);
		sysUserMapper.updateByPrimaryKeySelective(user);

		if(srmExpertMapper.selectByPrimaryKey(expert.getUserFlow())==null){
			expert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			expert.setCreateTime(DateUtil.getCurrDateTime());
			return srmExpertMapper.insert(expert);
		}else{
			GeneralMethod.setRecordInfo(expert, false);
			return srmExpertMapper.updateByPrimaryKeySelective(expert);			
		}
	}

	@Override
	public List<SysUser> searchExpertFormSysUser(SysUser sysUser) {
		
		SysUserExample example = new SysUserExample();
		com.pinde.sci.model.mo.SysUserExample.Criteria criteria =  example.createCriteria().andSrmExpertFlagEqualTo(GlobalConstant.FLAG_Y).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(sysUser.getUserName())){
			criteria.andUserNameLike("%" + sysUser.getUserName() + "%");
		}
		if(StringUtil.isNotBlank(sysUser.getOrgFlow())){
			criteria.andOrgFlowEqualTo(sysUser.getOrgFlow());
		}
		return sysUserMapper.selectByExample(example);
	}

	@Override
	public List<SysUserExt> searchExpertNotInEvalSetByEvalSetFlow(
			String evalSetFlow) {
		return this.expertExtMapper.selectExpertNotInEvalSettingByEvalSetFlow(evalSetFlow);
	}

	@Override
	public List<SrmExpert> searchExpertList(List<String> userFlowList) {
		SrmExpertExample example = new SrmExpertExample();
		com.pinde.sci.model.mo.SrmExpertExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(userFlowList != null && !userFlowList.isEmpty()){
			criteria.andUserFlowIn(userFlowList);
		}
		return srmExpertMapper.selectByExample(example);
	}

	@Override
	public void addOrModifyExpertByUserFlow(SrmExpert expert) {
		SrmExpert exitExpert = this.readExpert(expert.getUserFlow());
		if(exitExpert!=null){
			GeneralMethod.setRecordInfo(expert, false);
			this.srmExpertMapper.updateByPrimaryKeySelective(expert);
		}else if(GlobalConstant.RECORD_STATUS_Y.equals(expert.getRecordStatus())){
			GeneralMethod.setRecordInfo(expert, true);
			this.srmExpertMapper.insertSelective(expert);
		}
		SysUser record = new SysUser();
		record.setUserFlow(expert.getUserFlow());
		record.setSrmExpertFlag(expert.getRecordStatus());
		this.sysUserMapper.updateByPrimaryKeySelective(record);
		
	}
	
	
}
