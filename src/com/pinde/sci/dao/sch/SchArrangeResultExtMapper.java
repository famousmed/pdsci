package com.pinde.sci.dao.sch;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrangeResult;

public interface SchArrangeResultExtMapper {
	List<Map<String,Object>> countResultByUser(@Param(value="userFlows")List<String> userFlows);
	
	Map<String,String> countDateArea(@Param(value="doctor")ResDoctor doctor);
	
	List<Map<String,Object>> countMonthNum(@Param(value="month")String month,@Param(value="doctor")ResDoctor doctor);
	
	List<SchArrangeResult> searchInMonthResult(@Param(value="schDeptFlow")String schDeptFlow,@Param(value="month")String month,@Param(value="doctor")ResDoctor doctor);
	
	List<SchArrangeResult> willInDoctor(@Param(value="orgFlow")String orgFlow,@Param(value="userFlow")String userFlow);
	
	int countRotationUse(@Param(value="rotationFlow")String rotationFlow);
	
	/**
	 * ����ҽʦ�ҳ�������ת��δ��ת�ļƻ�
	 * @param doctorFlows
	 * @return
	 */
	List<SchArrangeResult> cutAfterResult(@Param(value="doctorFlows")List<String> doctorFlows);
	
	/**
	 * Ϊ��ҽʦ�ļƻ�����׼��������
	 * @param doctorFlow
	 * @return
	 */
	int sortResult(@Param(value="doctorFlow")String doctorFlow);
} 
