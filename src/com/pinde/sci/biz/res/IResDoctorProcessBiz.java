package com.pinde.sci.biz.res;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.SysUser;

public interface IResDoctorProcessBiz {
	/**
	 * 保存或修改
	 * @param process
	 * @return
	 */
	int edit(ResDoctorSchProcess process);
	/**
	 * 按轮转计划流水号查找
	 * @param resultFlow
	 * @return
	 */
	ResDoctorSchProcess searchByResultFlow(String resultFlow);
	/**
	 * 根据主键查找
	 * @param processFlow
	 * @return
	 */
	ResDoctorSchProcess read(String processFlow);

	List<ResDoctorSchProcess> searchDoctorProcess(ResDoctorSchProcess doctorProcess);
	List<ResDoctorSchProcess> searchByResultFlows(List<String> schResultFlows);
	ResDoctorSchProcess searchProcessByRec(String doctorFlow, String schDeptFlow);
	List<ResDoctorSchProcess> searchProcessByDoctor(String doctorFlow);
	List<ResDoctorSchProcess> searchProcessByDoctor(ResDoctor doctor,
			ResDoctorSchProcess process,Map<String,String> roleFlagMap);
	List<ResDoctorSchProcess> searchProcessByOrg(String orgFlow);
	
	/**
	 * 查询用户当前轮转科室
	 * @param userFlow
	 * @return
	 */
	ResDoctorSchProcess searchCurrDept(SysUser sysUser);
	
	/**
	 * 根据带教老师flow查询带教老师所带过的科室
	 * @param userFlow
	 * @return
	 */
	List<String> searchTeachDept(String userFlow);
	
	/**
	 * 筛去没有开始轮转的医师
	 * @param doctorFlows
	 * @return
	 */
	List<String> searchRotationDoctor(List<String> doctorFlows);
	
	/**
	 * 查询该用户所在部门下的所有轮转中学员
	 * @param userFlow
	 * @return
	 */
	List<ResDoctorSchProcess> searchCurrentProcessByUserFlow(String userFlow,
			String isCurrentFlag);
}
