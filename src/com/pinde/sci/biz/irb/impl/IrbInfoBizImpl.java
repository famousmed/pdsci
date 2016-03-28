package com.pinde.sci.biz.irb.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.irb.IIrbInfoBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.IrbInfoMapper;
import com.pinde.sci.dao.sys.SysUserExtMapper;
import com.pinde.sci.enums.pub.UserStatusEnum;
import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoExample;
import com.pinde.sci.model.mo.IrbInfoExample.Criteria;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class IrbInfoBizImpl implements IIrbInfoBiz {
	@Autowired
	private IrbInfoMapper irbInfoMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IDeptBiz deptBiz;
	@Autowired
	private IRoleBiz roleBiz;
	@Autowired
	private SysUserExtMapper sysUserExtMapper;
	
	@Override
	public int editInfo(IrbInfo info) {
		if(info!=null){
			if(StringUtil.isNotBlank(info.getRecordFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(info, false);
				return  this.irbInfoMapper.updateByPrimaryKeySelective(info);
			}else{//ÐÂÔö
				info.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(info, true);
				return this.irbInfoMapper.insertSelective(info);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<IrbInfo> queryInfo(IrbInfo info) {
		IrbInfoExample example = new IrbInfoExample();
		Criteria criteria = example.createCriteria();
		if(info!=null){
			if(StringUtil.isNotBlank(info.getRecordStatus())){
				criteria.andRecordStatusEqualTo(info.getRecordStatus());
			}
		}
		example.setOrderByClause("create_time asc");
		return this.irbInfoMapper.selectByExample(example);
	}

	@Override
	public IrbInfo queryInfo(String recordFlow) {
		return this.irbInfoMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public List<SysDept> queryIrbDept() {
		SysUser currentUser = GlobalContext.getCurrentUser();
		SysDept dep = new SysDept();
		dep.setOrgFlow(currentUser.getOrgFlow());
		dep.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
		return this.deptBiz.searchDept(dep);
	}

	@Override
	public List<SysUser> queryIrbUser(SysUserForm form) {
		SysUser currentUser = GlobalContext.getCurrentUser();
		form.getUser().setOrgFlow(currentUser.getOrgFlow());
		form.getUser().setStatusId(UserStatusEnum.Activated.getId());
		return sysUserExtMapper.selectIrbUserByForm(form);
	}
	
}
