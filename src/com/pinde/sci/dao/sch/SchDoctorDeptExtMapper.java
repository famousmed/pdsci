package com.pinde.sci.dao.sch;

import org.apache.ibatis.annotations.Param;

/**
 * proj��չmapper
 * @author Administrator
 *
 */
public interface SchDoctorDeptExtMapper {
	
	int countRotationUse(@Param(value="rotationFlow")String rotationFlow);
} 
