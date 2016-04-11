package com.pinde.sci.dao.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmExpertProj;
import com.pinde.sci.model.srm.SrmExpertProjExt;
import com.pinde.sci.model.srm.SysUserExt;

public interface SrmExpertProjExtMapper {

	/**
	 * 关联评审设置表 查询某个专家评审的项目
	 * @param srmExpertProjExt
	 * @return
	 */
	List<SrmExpertProjExt> selectExpertProj(SrmExpertProjExt srmExpertProjExt);
	
	/**
	 * 根据评审专家和评审项目关联表 查询专家信息
	 * @param expertProj
	 * @return
	 */
	List<SysUserExt> selectJoinEvalSetExpertList(SrmExpertProj expertProj);
	
	/**
	 * 查询专家评审的项目 关联用户表和专家表
	 * @param expertProj
	 * @return
	 */
	List<SrmExpertProjExt> selectExpertProjAndUserExt(SrmExpertProj expertProj);
}
