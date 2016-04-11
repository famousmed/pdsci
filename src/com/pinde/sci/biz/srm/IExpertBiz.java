package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.srm.SysUserExt;

public interface IExpertBiz {

	/**
	 * 根据用户流水号查找专家(唯一)
	 * @param userFlow
	 * @return
	 */
	public SrmExpert readExpert(String userFlow);
	
	/**
	 * 修改专家信息
	 * @param user
	 * @param expert
	 */
	int updateSysUserAndSrmExpert(SysUser user, SrmExpert expert);
	
	/**
	 * 根据条件查询专家
	 * @param sysUser
	 * @param srmExpert
	 * @return
	 */
	public List<SysUser> searchExpertFormSysUser(SysUser sysUser);
	
	/**
	 * 查询不在某个评审设置下的专家 , 当evalSetFlow为null或者""时  查询所有专家
	 * @param evalSetFlow
	 * @return
	 */
	public List<SysUserExt> searchExpertNotInEvalSetByEvalSetFlow(String evalSetFlow);

	/**
	 * 查询流水号专家列表
	 * @param expertFlowList
	 * @return
	 */
	List<SrmExpert> searchExpertList(List<String> userFlowList);
	
	void addOrModifyExpertByUserFlow(SrmExpert expert);

}
