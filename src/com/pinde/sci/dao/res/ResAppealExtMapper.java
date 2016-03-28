package com.pinde.sci.dao.res;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.form.res.AppealForm;
import com.pinde.sci.model.mo.ResAppeal;
import com.pinde.sci.model.mo.ResDoctor;

public interface ResAppealExtMapper {
	List<AppealForm> searchAppealFormList(@Param(value="appeal")ResAppeal appeal,@Param(value="doctor")ResDoctor doctor);
	
	List<Map<String,Object>> appealCountWithUser(@Param(value="userFlows")List<String> userFlows,
			@Param(value="schDeptFlows")List<String> schDeptFlows,
			@Param(value="roleFlag")String roleFlag);
	
	List<Map<String,Object>> searchAppealCount(@Param(value="schDeptFlow")String schDeptFlow,@Param(value="operUserFlow")String operUserFlow);
	
	List<ResAppeal> searchAppealForAudit(@Param(value="recTypeId")String recTypeId,
			@Param(value="schDeptFlow")String schDeptFlow,
			@Param(value="doctorFlow")String doctorFlow);
	
	List<Map<String,Object>> searchNotAuditAppealCount(@Param(value="schDeptFlow")String schDeptFlow,@Param(value="teacherUserFlow")String teacherUserFlow,@Param(value="isAudit")String isAudit);
}
