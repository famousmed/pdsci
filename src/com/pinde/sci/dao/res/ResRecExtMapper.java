package com.pinde.sci.dao.res;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorSchProcessExt;
import com.pinde.sci.model.res.ResRecExt;

public interface ResRecExtMapper {
	List<Map<String,Object>> searchAuditCount(@Param(value="userFlow") String userFlow,@Param(value="roleFlag") String roleFlag);
	
	List<ResRecExt> searchAuditList(@Param(value="userFlow") String userFlow,
			@Param(value="roleFlag") String roleFlag,
			@Param(value="recTypeId") String recTypeId,
			@Param(value="doctorFlow") String doctorFlow,
			@Param(value="isCurrentFlag") String isCurrentFlag);
	
	List<ResRecExt> searchRegistryList(@Param(value="userFlow") String userFlow,
			@Param(value="roleFlag") String roleFlag,
			@Param(value="rec") ResRec rec,
			@Param(value="process") ResDoctorSchProcess process);
	
	List<ResRecExt> searchScoreList(@Param(value="userFlow") String userFlow,
			@Param(value="roleFlag") String roleFlag,
			@Param(value="sessionNumber") String sessionNumber,
			@Param(value="recTypeId") String recTypeId,
			@Param(value="isCurrentFlag") String isCurrentFlag);
	
	List<ResRecExt> searchTeacherAudit(@Param(value="schDeptFlow") String schDeptFlow,
			@Param(value="isCurrentFlag") String isCurrentFlag,
			@Param(value="userFlow") String userFlow);
	
	List<ResDoctorSchProcessExt> searchProcessExt(@Param(value="processExt") ResDoctorSchProcessExt processExt);
	
	List<ResRec> searchRecByUserAndSchdept(@Param(value="userFlows") List<String> userFlows,
			@Param(value="schDeptFlows") List<String> schDeptFlows,
			@Param(value="recTypeId") String recTypeId,
			@Param(value="itemName") String itemName);
	
	List<ResRecExt> searchRecExtByRecExt(@Param(value="recExt") ResRecExt recExt);
	
	List<Map<String,Object>> countRecWithDoc(@Param(value="userFlows")List<String> userFlows,@Param(value="schDeptFlows")List<String> schDeptFlows,@Param(value="isAudit")String isAudit);
	
	List<ResRec> searchByRecForAudit(@Param(value="recTypeId")String recTypeId,
			@Param(value="schDeptFlow")String schDeptFlow,
			@Param(value="operUserFlow")String operUserFlow);
	
	List<Map<String,Object>> searchTeacherAuditCount(@Param(value="headUserFlow")String headUserFlow,@Param(value="isAudit")String isAudit);
	
	List<Map<String,Object>> searchDoctorNotAuditCount(@Param(value="schDeptFlow")String schDeptFlow,@Param(value="teacherUserFlow")String teacherUserFlow,@Param(value="isAudit")String isAudit,@Param(value="recTypeIds")List<String> recTypeIds);
	
	/**
	 * 查询当前带教或科主任的待出科人员数据
	 * @param process
	 * @param user
	 * @param recTypeIds
	 * @return
	 */
	List<ResRec> searchAfterAuditRec(@Param(value="process")ResDoctorSchProcess process,@Param(value="user")SysUser user,@Param(value="recTypeIds")List<String> recTypeIds,@Param(value="roleFlagMap")Map<String,String> roleFlagMap);
}
