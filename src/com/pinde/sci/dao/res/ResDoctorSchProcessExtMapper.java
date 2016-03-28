package com.pinde.sci.dao.res;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.res.ResDoctorExt;

public interface ResDoctorSchProcessExtMapper {
	List<Map<String,Object>> countProcessByUser(@Param(value="userFlows")List<String> userFlows);
	
	List<ResDoctorSchProcess> searchProcessByDoctor(@Param(value="doctor")ResDoctor doctor,@Param(value="process")ResDoctorSchProcess process,@Param(value="roleFlagMap")Map<String,String> roleFlagMap);
	
	List<String> searchTeachDept(@Param(value="userFlow")String userFlow);
	
	/**
	 * ɸȥû�п�ʼ��ת��ҽʦ
	 * @param doctorFlows
	 * @return
	 */
	List<String> searchRotationDoctor(@Param(value="doctorFlows")List<String> doctorFlows);
	
	/**
	 * ��ѯ���û����ڲ����µ�������ת��ѧԱ
	 * @param userFlow
	 * @return
	 */
	List<ResDoctorSchProcess> searchCurrentProcessByUserFlow(@Param(value="userFlow")String userFlow,@Param(value="isCurrentFlag")String isCurrentFlag);
}
