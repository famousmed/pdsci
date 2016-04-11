package com.pinde.sci.biz.hbres.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.IResExamDoctorBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResExamDoctorMapper;
import com.pinde.sci.model.mo.ResExamDoctor;
import com.pinde.sci.model.mo.ResExamDoctorExample;
import com.pinde.sci.model.mo.ResExamDoctorExample.Criteria;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResExamDoctorBizImpl implements IResExamDoctorBiz{

	@Autowired
	private ResExamDoctorMapper examDoctorMapper;
	
	@Override
	public ResExamDoctor readResExamDoctor(String recordFlow) {
		return this.examDoctorMapper.selectByPrimaryKey(recordFlow);
	}
	
	@Override
	public List<ResExamDoctor> searchExamDoctorList(ResExamDoctor examDoctor) {
		ResExamDoctorExample example = new ResExamDoctorExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(examDoctor.getDoctorFlow())) {
			criteria.andDoctorFlowEqualTo(examDoctor.getDoctorFlow());
		}
		return this.examDoctorMapper.selectByExample(example);
	}
	
}
