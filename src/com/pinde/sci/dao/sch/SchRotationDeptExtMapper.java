package com.pinde.sci.dao.sch;



import java.util.List;

import org.apache.ibatis.annotations.Param;

/**
 * proj扩展mapper
 * @author Administrator
 *
 */
public interface SchRotationDeptExtMapper {
	/**
	 * 计算未关联的科室数量
	 * @param orgFlow
	 * @param rotationFlow
	 * @return
	 */
	int getUnrelCount(@Param(value="orgFlow")String orgFlow,@Param(value="rotationFlow")String rotationFlow);
	
	/**
	 * 已经同步该方案的机构
	 * @param rotationFlow
	 * @return
	 */
	List<String> isUpdateOrg(@Param(value="rotationFlow")String rotationFlow);
} 
