package com.pinde.sci.dao.sch;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.SchRotation;

public interface SchRotationExtMapper {
//	List<SchRotation> searchRotationByRole(@Param(value="roleFlag")String roleFlag,@Param(value="rotation")SchRotation rotation);
	
	List<SchRotation> searchNotExistRotation(@Param(value="orgFlow")String orgFlow);
} 
