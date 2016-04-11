package com.pinde.sci.biz.res.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sys.IOrgBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResJointOrgMapper;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.ResJointOrgExample;
import com.pinde.sci.model.mo.SysOrgExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResJointOrgBizImpl implements IResJointOrgBiz{
	@Resource
	private ResJointOrgMapper resJointOrgMapper;
	@Resource
	private IOrgBiz orgBiz;
	
	@Override
	public int save(ResJointOrg resJointOrg) {
		if(StringUtil.isNotBlank(resJointOrg.getJointFlow())){
			GeneralMethod.setRecordInfo(resJointOrg, false);
			return resJointOrgMapper.updateByPrimaryKeySelective(resJointOrg);
		}else{
			resJointOrg.setJointFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(resJointOrg, true);
			return resJointOrgMapper.insertSelective(resJointOrg);
		}
	}
	@Override
	public int editJointOrgList(List<ResJointOrg> jointOrgList){
		if(jointOrgList!=null&&jointOrgList.size()>0){
			for(ResJointOrg jointOrg : jointOrgList){
				save(jointOrg);
			}
		}
		return GlobalConstant.ONE_LINE;
	}
	
	@Override
	public List<ResJointOrg> searchResJointByOrgFlow(String orgFlow){
		ResJointOrgExample example = new ResJointOrgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		return resJointOrgMapper.selectByExample(example);
	}
	
	@Override
	public List<ResJointOrg> searchResJoint(ResJointOrg joint){
		ResJointOrgExample example = new ResJointOrgExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return resJointOrgMapper.selectByExample(example);
	}
	
	@Override
	public List<ResJointOrg> searchJointOrgAll(){
		return searchResJoint(null);
	}

}
