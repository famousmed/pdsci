package com.pinde.sci.biz.res.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.res.IResDoctorProcessBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResDoctorSchProcessMapper;
import com.pinde.sci.dao.res.ResDoctorSchProcessExtMapper;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResDoctorSchProcessExample;
import com.pinde.sci.model.mo.ResDoctorSchProcessExample.Criteria;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResDoctorProcessBizImpl implements IResDoctorProcessBiz {

	@Autowired
	private ResDoctorSchProcessMapper  resDoctorProcessMapper;
	@Autowired
	private ResDoctorSchProcessExtMapper  resDoctorProcessExtMapper;
	
	@Override
	public List<ResDoctorSchProcess> searchByResultFlows(List<String> schResultFlows) {
		List<ResDoctorSchProcess> processList = null;
		if(schResultFlows!=null&&!schResultFlows.isEmpty()){
			ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchResultFlowIn(schResultFlows);
			processList = this.resDoctorProcessMapper.selectByExample(example);
		}
		return processList;
	}
	@Override
	public int edit(ResDoctorSchProcess process) {
		if(process!=null){
			if(StringUtil.isNotBlank(process.getProcessFlow())){//ÐÞ¸Ä
				GeneralMethod.setRecordInfo(process, false);
				return this.resDoctorProcessMapper.updateByPrimaryKeySelective(process);
			}else{//ÐÂÔö
				process.setProcessFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(process, true);
				return this.resDoctorProcessMapper.insertSelective(process);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	@Override
	public ResDoctorSchProcess searchByResultFlow(String resultFlow) {
		ResDoctorSchProcess process = null;
		if(StringUtil.isNotBlank(resultFlow)){
			ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andSchResultFlowEqualTo(resultFlow);
			List<ResDoctorSchProcess> processList = this.resDoctorProcessMapper.selectByExample(example);
			if(processList!=null&&!processList.isEmpty()){
				process = processList.get(0);
			}
		}
		return process;
	}
	@Override
	public ResDoctorSchProcess read(String processFlow) {
		ResDoctorSchProcess process = null;
		if(StringUtil.isNotBlank(processFlow)){
			process = this.resDoctorProcessMapper.selectByPrimaryKey(processFlow);
		}
		return process;
	}
	
	@Override
	public List<ResDoctorSchProcess> searchDoctorProcess(ResDoctorSchProcess doctorProcess){
		ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(doctorProcess!=null){
			if(StringUtil.isNotBlank(doctorProcess.getOrgFlow())){
				criteria.andOrgFlowEqualTo(doctorProcess.getOrgFlow());
			}
			if(StringUtil.isNotBlank(doctorProcess.getTeacherUserFlow())){
				criteria.andTeacherUserFlowEqualTo(doctorProcess.getTeacherUserFlow());
			}
			if(StringUtil.isNotBlank(doctorProcess.getHeadUserFlow())){
				criteria.andHeadUserFlowEqualTo(doctorProcess.getHeadUserFlow());
			}
			if(StringUtil.isNotBlank(doctorProcess.getSchFlag())){
				criteria.andSchFlagEqualTo(doctorProcess.getSchFlag());
			}
			if(StringUtil.isNotBlank(doctorProcess.getIsCurrentFlag())){
				criteria.andIsCurrentFlagEqualTo(doctorProcess.getIsCurrentFlag());
			}
			if(StringUtil.isNotBlank(doctorProcess.getSchDeptFlow())){
				criteria.andSchDeptFlowEqualTo(doctorProcess.getSchDeptFlow());
			}
			if(StringUtil.isNotBlank(doctorProcess.getUserFlow())){
				criteria.andUserFlowEqualTo(doctorProcess.getUserFlow());
			}
		}
		example.setOrderByClause("START_DATE DESC");
		return resDoctorProcessMapper.selectByExample(example);
	}
	
	@Override
	public ResDoctorSchProcess searchProcessByRec(String doctorFlow,String schDeptFlow){
		ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(doctorFlow).andSchDeptFlowEqualTo(schDeptFlow);
		List<ResDoctorSchProcess> processList = resDoctorProcessMapper.selectByExample(example);
		ResDoctorSchProcess process = null;
		if(processList!=null && processList.size()>0){
			process = processList.get(0);
		}
		return process;
	}
	
	@Override
	public List<ResDoctorSchProcess> searchProcessByOrg(String orgFlow){
		ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("START_DATE DESC");
		return resDoctorProcessMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctorSchProcess> searchProcessByDoctor(String doctorFlow){
		ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(doctorFlow);
		return resDoctorProcessMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctorSchProcess> searchProcessByDoctor(ResDoctor doctor,ResDoctorSchProcess process,Map<String,String> roleFlagMap){
		return resDoctorProcessExtMapper.searchProcessByDoctor(doctor, process,roleFlagMap);
	}
	
	@Override
	public ResDoctorSchProcess searchCurrDept(SysUser sysUser){
		ResDoctorSchProcessExample example = new ResDoctorSchProcessExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(sysUser!=null){
			if(StringUtil.isNotBlank(sysUser.getUserFlow())){
				criteria.andUserFlowEqualTo(sysUser.getUserFlow());
			}
		}
		criteria.andIsCurrentFlagEqualTo(GlobalConstant.FLAG_Y);
		List<ResDoctorSchProcess> processes=this.resDoctorProcessMapper.selectByExample(example);
		if(processes!=null && !processes.isEmpty()){
			return processes.get(0);
		}
		return null;
	}
	
	@Override
	public List<String> searchTeachDept(String userFlow){
		return resDoctorProcessExtMapper.searchTeachDept(userFlow);
	}
	
	@Override
	public List<String> searchRotationDoctor(List<String> doctorFlows){
		return resDoctorProcessExtMapper.searchRotationDoctor(doctorFlows);
	}
	
	@Override
	public List<ResDoctorSchProcess> searchCurrentProcessByUserFlow(String userFlow,String isCurrentFlag){
		return resDoctorProcessExtMapper.searchCurrentProcessByUserFlow(userFlow,isCurrentFlag);
	}
}
