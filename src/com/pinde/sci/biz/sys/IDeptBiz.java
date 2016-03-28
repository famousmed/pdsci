package com.pinde.sci.biz.sys;

import java.util.List;

import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysRole;

public interface IDeptBiz {
	public SysDept readSysDept(String sysDeptFlow);
	
	public int saveDept(SysDept sysDept);
	
	public List<SysDept> searchDept(SysDept sysDept);

	public void saveOrder(String[] deptFlow);

	List<SysDept> searchDeptByOrg(String orgFlow);

	/**
	 * 根据流水集合获取部门列表
	 * @param deptFlows
	 * @return
	 */
	List<SysDept> searchDeptByFlows(List<String> deptFlows);
}
