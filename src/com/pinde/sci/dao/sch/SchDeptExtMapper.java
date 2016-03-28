package com.pinde.sci.dao.sch;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;

public interface SchDeptExtMapper {
	List<SchDept> searchTeachDept(@Param(value="teacherUserFlow")String teacherUserFlow);
	
	/**
	 * 获取医师的轮转计划内科室
	 * @param userFlow
	 * @return
	 */
	List<SchDept> searchrotationDept(@Param(value="userFlow")String userFlow);
	
	/**
	 * 按条件筛选医师们的轮转科室范围
	 * @param doctor
	 * @return
	 */
	List<SchDept> countDeptArea(@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * 获取该用户的所有轮转科室
	 * @param userFlow
	 * @return
	 */
	List<SchDept> userSchDept(@Param(value="userFlow")String userFlow);
} 
