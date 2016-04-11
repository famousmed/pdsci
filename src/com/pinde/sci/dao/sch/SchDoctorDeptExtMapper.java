package com.pinde.sci.dao.sch;

import org.apache.ibatis.annotations.Param;

/**
 * proj¿©’πmapper
 * @author Administrator
 *
 */
public interface SchDoctorDeptExtMapper {
	
	int countRotationUse(@Param(value="rotationFlow")String rotationFlow);
} 
