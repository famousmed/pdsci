package com.pinde.sci.biz.sch.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchDeptBiz;
import com.pinde.sci.biz.sch.ISchDoctorBiz;
import com.pinde.sci.biz.sch.ISchDoctorDeptBiz;
import com.pinde.sci.biz.sch.ISchRotationGroupBiz;
import com.pinde.sci.biz.sys.IDeptBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchDoctorDeptMapper;
import com.pinde.sci.dao.sch.SchDoctorDeptExtMapper;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchDept;
import com.pinde.sci.model.mo.SchDoctorDept;
import com.pinde.sci.model.mo.SchDoctorDeptExample;
import com.pinde.sci.model.mo.SchRotationGroup;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchDoctorDeptBizImpl implements ISchDoctorDeptBiz {
	@Autowired
	private SchDoctorDeptMapper doctorDeptMapper;
	@Resource
	private ISchDeptBiz schDeptBiz;
	@Resource
	private IDeptBiz deptBiz;
	@Resource
	private ISchRotationGroupBiz schRotationtGroupBiz;
	@Resource
	private ISchDoctorBiz schDoctortBiz;
	@Resource
	private SchDoctorDeptExtMapper doctorDeptExtMapper;

	@Override
	public List<SchDoctorDept> searchSchDoctorDept() {
		SchDoctorDeptExample example = new SchDoctorDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("ORDINAL");
		return doctorDeptMapper.selectByExample(example);
	}
	
	@Override
	public List<SchDoctorDept> searchDoctorDeptByDoctorFlows(List<String> doctorFlows){
		SchDoctorDeptExample example = new SchDoctorDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowIn(doctorFlows);
		example.setOrderByClause("ORDINAL");
		return doctorDeptMapper.selectByExample(example);
	}

	@Override
	public List<SchDoctorDept> searchSchDoctorDept(String doctorFlow) {
		SchDoctorDeptExample example = new SchDoctorDeptExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andDoctorFlowEqualTo(doctorFlow);
		example.setOrderByClause("ORDINAL");
		return doctorDeptMapper.selectByExample(example);
	}

	@Override
	public SchDoctorDept readSchDoctorDept(String recordFlow) {
		return doctorDeptMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public SchDoctorDept readSchDoctorDeptByObj(String doctorFlow,String schDeptFlow,String groupFlow,String standardDeptId) {
		SchDoctorDept doctorDept = null;
		if(StringUtil.isNotBlank(doctorFlow) && StringUtil.isNotBlank(schDeptFlow)){
			SchDoctorDeptExample example = new SchDoctorDeptExample();
			example.createCriteria().andDoctorFlowEqualTo(doctorFlow)
			.andSchDeptFlowEqualTo(schDeptFlow)
			.andGroupFlowEqualTo(groupFlow)
			.andStandardDeptIdEqualTo(standardDeptId);
			List<SchDoctorDept> doctorDeptList = doctorDeptMapper.selectByExample(example);
			if(doctorDeptList != null && doctorDeptList.size()>0){
				doctorDept = doctorDeptList.get(0);
			}
		}
		return doctorDept;
	}

	@Override
	public int editDoctorDept(SchDoctorDept doctorDept){
		if(doctorDept!=null){
			if(StringUtil.isNotBlank(doctorDept.getRecordFlow())){
				GeneralMethod.setRecordInfo(doctorDept,false);
				return doctorDeptMapper.updateByPrimaryKeySelective(doctorDept);
			}else{
				doctorDept.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(doctorDept,true);
				return doctorDeptMapper.insertSelective(doctorDept);
			}
			//return saveSelDeptFlag(doctorDept);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int saveSchDoctorDept(SchDoctorDept doctorDept) {
		if(doctorDept != null){
			if(StringUtil.isNotBlank(doctorDept.getRecordFlow())){
				return update(doctorDept);
			}else{
				return save(doctorDept);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int save(SchDoctorDept doctorDept){
		if(doctorDept!=null){
			SchDept schDept = schDeptBiz.readSchDept(doctorDept.getSchDeptFlow());
			if(schDept!=null){
				doctorDept.setDeptFlow(schDept.getDeptFlow());
				doctorDept.setDeptName(schDept.getDeptName());
			}
			doctorDept.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(doctorDept, true);
			return doctorDeptMapper.insertSelective(doctorDept);
			//return saveSelDeptFlag(doctorDept);
		}
		return GlobalConstant.ZERO_LINE;
	}
	
	@Override
	public int update(SchDoctorDept doctorDept){
		GeneralMethod.setRecordInfo(doctorDept, false);
		return doctorDeptMapper.updateByPrimaryKeySelective(doctorDept);
		//return saveSelDeptFlag(doctorDept);
	}
	
	private int saveSelDeptFlag(SchDoctorDept doctorDept){
		doctorDept = readSchDoctorDept(doctorDept.getRecordFlow());
		int deptNumCount = schRotationtGroupBiz.sumDeptNumByRotation(doctorDept.getRotationFlow());
		
		List<SchDoctorDept> doctorDeptList = searchSchDoctorDept(doctorDept.getDoctorFlow());
		
		ResDoctor doctor = new ResDoctor();
		doctor.setDoctorFlow(doctorDept.getDoctorFlow());
		doctor.setSelDeptFlag(GlobalConstant.FLAG_N);
		
		if(doctorDeptList != null && !doctorDeptList.isEmpty() && doctorDeptList.size() == deptNumCount){
			doctor.setSelDeptFlag(GlobalConstant.FLAG_Y);
		}
		return schDoctortBiz.saveResDoctor(doctor);
	}
	
	@Override
	public int countRotationUse(String rotationFlow){
		return doctorDeptExtMapper.countRotationUse(rotationFlow);
	}

}
