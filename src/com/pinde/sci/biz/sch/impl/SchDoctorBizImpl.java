package com.pinde.sci.biz.sch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchDoctorBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResDoctorMapper;
import com.pinde.sci.dao.res.ResDoctorExtMapper;
import com.pinde.sci.enums.res.ResDoctorStatusEnum;
import com.pinde.sci.form.sch.DoctorSearchForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.ResDoctorExample;
import com.pinde.sci.model.mo.ResDoctorExample.Criteria;
import com.pinde.sci.model.res.ResDoctorExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchDoctorBizImpl implements ISchDoctorBiz {
	@Autowired
	private ResDoctorMapper doctorMapper;
	@Autowired
	private ResDoctorExtMapper doctorExtMapper;

	@Override
	public List<ResDoctor> searchResDoctorAll(String orgFlow,DoctorSearchForm doctorSearchForm) {
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrgFlowEqualTo(orgFlow);
		example.setOrderByClause("DOCTOR_CODE");
		if(doctorSearchForm == null){
			return doctorMapper.selectByExample(example);
		}else{
			searchConditions(criteria,doctorSearchForm);
			return doctorMapper.selectByExample(example);
		}
	}
	
	@Override
	public List<ResDoctor> searchResDoctor(String orgFlow) {
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("DOCTOR_CODE");
		return doctorMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctor> searchResDoctorByFlows(String orgFlow,List<String> doctorFlowList){
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andDoctorFlowIn(doctorFlowList).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("DOCTOR_CODE");
		return doctorMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctor> searchTerminatResDoctor(String orgFlow,DoctorSearchForm doctorSearchForm){
		ResDoctorExample example = new ResDoctorExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrgFlowEqualTo(orgFlow).andDoctorStatusIdEqualTo(ResDoctorStatusEnum.Terminat.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("DOCTOR_CODE");
		if(doctorSearchForm == null){
			return doctorMapper.selectByExample(example);
		}else{
			searchConditions(criteria,doctorSearchForm);
			return doctorMapper.selectByExample(example);
		}
	}
	
	@Override
	public List<ResDoctor> searchNotTerminatResDoctor(String orgFlow){
		ResDoctorExample example = new ResDoctorExample();
		example.createCriteria().andOrgFlowEqualTo(orgFlow).andDoctorStatusIdNotEqualTo(ResDoctorStatusEnum.Terminat.getId()).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("DOCTOR_CODE");
		return doctorMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctor> searchResDoctor(String orgFlow,DoctorSearchForm doctorSearchForm){
		if(doctorSearchForm == null){
			return searchResDoctor(orgFlow);
		}else{
			ResDoctorExample example = new ResDoctorExample();
			Criteria criteria = example.createCriteria();
			criteria.andOrgFlowEqualTo(orgFlow).andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
			searchConditions(criteria,doctorSearchForm);
			example.setOrderByClause("DOCTOR_CODE");
			return doctorMapper.selectByExample(example);
		}
	}
	
	private void searchConditions(Criteria criteria,DoctorSearchForm doctorSearchForm){
//		if(StringUtil.isNotBlank(doctorSearchForm.getDoctorName())){
//			criteria.andDoctorNameEqualTo(doctorSearchForm.getDoctorName());
//		}
		if(StringUtil.isNotBlank(doctorSearchForm.getGraduatedId())){
			criteria.andGraduatedIdEqualTo(doctorSearchForm.getGraduatedId());
		}
		if(StringUtil.isNotBlank(doctorSearchForm.getSessionNumber())){
			criteria.andSessionNumberEqualTo(doctorSearchForm.getSessionNumber());
		}
//		if(StringUtil.isNotBlank(doctorSearchForm.getSexId())){
//			criteria.andSexIdEqualTo(doctorSearchForm.getSexId());
//		}
		if(StringUtil.isNotBlank(doctorSearchForm.getTrainingSpeId())){
			criteria.andTrainingSpeIdEqualTo(doctorSearchForm.getTrainingSpeId());
		}
		if(StringUtil.isNotBlank(doctorSearchForm.getRotationFlow())){
			criteria.andRotationFlowEqualTo(doctorSearchForm.getRotationFlow());
		}
		if(StringUtil.isNotBlank(doctorSearchForm.getDoctorCategoryId())){
			criteria.andDoctorCategoryIdEqualTo(doctorSearchForm.getDoctorCategoryId());
		}
	}

	@Override
	public ResDoctor readResDoctor(String doctorFlow) {
		return doctorMapper.selectByPrimaryKey(doctorFlow);
	}

	@Override
	public int saveResDoctor(ResDoctor doctor) {
		if(doctor != null){
			if(StringUtil.isNotBlank(doctor.getDoctorFlow())){
				GeneralMethod.setRecordInfo(doctor, false);
				return doctorMapper.updateByPrimaryKeySelective(doctor);
			}else{
				doctor.setDoctorFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(doctor, true);
				doctor.setSelDeptFlag(GlobalConstant.FLAG_N);
				doctor.setSchFlag(GlobalConstant.FLAG_N);
				return doctorMapper.insertSelective(doctor);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public List<ResDoctorExt> searchResDoctor(ResDoctorExt doctorExt) {
		List<ResDoctorExt> doctoerExtList=this.doctorExtMapper.searchResDoctorUser(doctorExt);
		return doctoerExtList;
	}

	
}
