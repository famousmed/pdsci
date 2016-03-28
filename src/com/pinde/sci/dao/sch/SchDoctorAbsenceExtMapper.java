package com.pinde.sci.dao.sch;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.SchDoctorAbsence;

public interface SchDoctorAbsenceExtMapper {

	public List<SchDoctorAbsence> searchDoctorAbsence(Map<String,Object> paramMap);
	
	/**
	 * ����һ��ҽʦ�����������
	 * @param doctorFlows
	 * @return
	 */
	public List<Map<String,Object>> countAbsenceDays(@Param(value="doctorFlows")List<String> doctorFlows);
} 
