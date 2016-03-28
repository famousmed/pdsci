package com.pinde.sci.dao.sch;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;

public interface SchDeptExtMapper {
	List<SchDept> searchTeachDept(@Param(value="teacherUserFlow")String teacherUserFlow);
	
	/**
	 * ��ȡҽʦ����ת�ƻ��ڿ���
	 * @param userFlow
	 * @return
	 */
	List<SchDept> searchrotationDept(@Param(value="userFlow")String userFlow);
	
	/**
	 * ������ɸѡҽʦ�ǵ���ת���ҷ�Χ
	 * @param doctor
	 * @return
	 */
	List<SchDept> countDeptArea(@Param(value="doctor")ResDoctor doctor);
	
	/**
	 * ��ȡ���û���������ת����
	 * @param userFlow
	 * @return
	 */
	List<SchDept> userSchDept(@Param(value="userFlow")String userFlow);
} 
