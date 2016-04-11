package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysRole;

public interface IRoleBiz {
	
	public List<SysRole> search(SysRole sysRole);
	
	public boolean save(SysRole sysRole);
	
	public SysRole read(String roleFlow);
	
	public boolean delete(String roleFlow,String recordStatus);
	
	public List<String> getPopedom(String roleFlow);
	
	public boolean savePop(SysRole sysRole,String [] menuIds);

	public void saveOrder(String[] roleFlow);
	/**
	 * 查询用户的所有角色
	 * @param userFlow 用户流水号
	 * @param wsId 工作站id
	 * @return
	 */
	public List<SysRole> search(String userFlow,String wsId);

}
