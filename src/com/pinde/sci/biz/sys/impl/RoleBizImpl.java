package com.pinde.sci.biz.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sys.IRoleBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SysRoleMapper;
import com.pinde.sci.dao.base.SysRolePopedomMapper;
import com.pinde.sci.dao.base.SysUserRoleMapper;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysRoleExample;
import com.pinde.sci.model.mo.SysRoleExample.Criteria;
import com.pinde.sci.model.mo.SysRolePopedom;
import com.pinde.sci.model.mo.SysRolePopedomExample;
import com.pinde.sci.model.mo.SysUserRole;
import com.pinde.sci.model.mo.SysUserRoleExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class RoleBizImpl implements IRoleBiz {
	
	@Resource
	private SysRoleMapper sysRoleMapper;
	
	@Resource
	private SysRolePopedomMapper sysRolePopedomMapper;
	@Resource
	private SysUserRoleMapper sysUserRoleMapper;

	@Override
	public List<SysRole> search(SysRole sysRole) {
		SysRoleExample example = new SysRoleExample();
		Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(sysRole.getRoleName())){
			criteria.andRoleNameLike("%"+sysRole.getRoleName()+"%");			
		}
		if(StringUtil.isNotBlank(sysRole.getWsId())){
			criteria.andWsIdEqualTo(sysRole.getWsId());			
		}
		if(StringUtil.isNotBlank(sysRole.getRecordStatus())){
			criteria.andRecordStatusEqualTo(sysRole.getRecordStatus());	
		}
		if(StringUtil.isNotBlank(sysRole.getRoleLevelId())){
			criteria.andRoleLevelIdEqualTo(sysRole.getRoleLevelId());	
		}
		if(StringUtil.isNotBlank(sysRole.getAllowRegFlag())){
			criteria.andAllowRegFlagEqualTo(sysRole.getAllowRegFlag());	
		}
		example.setOrderByClause("ORDINAL");
		return sysRoleMapper.selectByExample(example);
	}

	@Override
	public boolean save(SysRole sysRole){
		if(StringUtil.isNotBlank(sysRole.getRoleFlow())){
			GeneralMethod.setRecordInfo(sysRole, false);
			sysRoleMapper.updateByPrimaryKeySelective(sysRole);				
		}else{
			sysRole.setRoleFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(sysRole, true);
			sysRoleMapper.insert(sysRole);	
		}
		return true;
	}

	@Override
	public SysRole read(String roleFlow) {
		return sysRoleMapper.selectByPrimaryKey(roleFlow);
	}

	@Override
	public boolean delete(String roleFlow,String recordStatus) {
		SysRole sysRole = new SysRole();
		sysRole.setRoleFlow(roleFlow);
		sysRole.setRecordStatus(recordStatus);
		GeneralMethod.setRecordInfo(sysRole, false);
		sysRoleMapper.updateByPrimaryKeySelective(sysRole);
		return true;
	}

	@Override
	public List<String> getPopedom(String roleFlow) {
		SysRolePopedomExample example = new SysRolePopedomExample();
		com.pinde.sci.model.mo.SysRolePopedomExample.Criteria criteria = example.createCriteria();
		criteria.andRoleFlowEqualTo(roleFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<SysRolePopedom> sysRolePopedomList = sysRolePopedomMapper.selectByExample(example);
		List<String> menuIdList = new ArrayList<String>();
		for(SysRolePopedom sysRolePopedom : sysRolePopedomList){
			menuIdList.add(sysRolePopedom.getMenuId());
		}
		return menuIdList;
	}

	@Override
	public boolean savePop(SysRole sysRole, String[] menuIds) {
		//将原先该角色的功能都删除
		SysRolePopedom update = new SysRolePopedom();
		update.setRoleFlow(sysRole.getRoleFlow());
		update.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		SysRolePopedomExample example = new SysRolePopedomExample();
		com.pinde.sci.model.mo.SysRolePopedomExample.Criteria criteria = example.createCriteria();
		criteria.andRoleFlowEqualTo(sysRole.getRoleFlow()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		sysRolePopedomMapper.updateByExampleSelective(update, example);
		
		for(String menuId : menuIds){
			SysRolePopedom insert = new SysRolePopedom();
			insert.setRoleFlow(sysRole.getRoleFlow());
			insert.setMenuId(menuId);
			insert.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			insert.setRecordFlow(PkUtil.getUUID());
			sysRolePopedomMapper.insert(insert);
		}
		return false;
	}

	@Override
	public void saveOrder(String[] roleFlow) {
		if(roleFlow==null) return;
		int i=1;
		for(String flow : roleFlow){
			SysRole role = new SysRole();
			role.setRoleFlow(flow);
			role.setOrdinal((i++));
			sysRoleMapper.updateByPrimaryKeySelective(role);		}	
		
	}

	@Override
	public List<SysRole> search(String userFlow, String wsId) {
		List<SysRole> roleList = null;
		if(StringUtil.isNotBlank(userFlow)&&StringUtil.isNotBlank(wsId)){
			SysUserRoleExample example = new SysUserRoleExample();
			example.createCriteria().andUserFlowEqualTo(userFlow).andWsIdEqualTo(wsId).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			List<SysUserRole> userRoleList = this.sysUserRoleMapper.selectByExample(example);
			List<String> roleFlowList = new ArrayList<String>();
			if(userRoleList!=null&&!userRoleList.isEmpty()){
				for (SysUserRole userRole : userRoleList) {
					roleFlowList.add(userRole.getRoleFlow());
				}
			}
			SysRoleExample example2 = new SysRoleExample();
			example2.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andRoleFlowIn(roleFlowList);
			roleList = this.sysRoleMapper.selectByExample(example2);
		}
		return roleList;
	}

}
