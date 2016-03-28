package com.pinde.sci.biz.irb;

import java.util.List;

import com.pinde.sci.form.sys.SysUserForm;
import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.SysDept;
import com.pinde.sci.model.mo.SysUser;

/**
 * @Description 伦理委员会biz
 *
 */
public interface IIrbInfoBiz {
	/**
	 * 新增或修改
	 * @param info
	 * @return
	 */
	public int editInfo(IrbInfo info);
	/**
	 * 按条件查询
	 * @param info
	 * @return
	 */
	public List<IrbInfo> queryInfo (IrbInfo info);
	/**
	 * 按主键查询
	 * @param recordFlow
	 * @return
	 */
	public IrbInfo queryInfo(String recordFlow);
	/**
	 * 查询可选成员
	 * @param form
	 * @return
	 */
	public List<SysUser> queryIrbUser(SysUserForm form);
	/**
	 * 查询可选部门
	 * @return
	 */
	public List<SysDept> queryIrbDept();

}
