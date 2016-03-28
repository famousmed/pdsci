package com.pinde.sci.biz.sch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.sch.ISchArrangeDoctorBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SchArrangeDoctorMapper;
import com.pinde.sci.model.mo.SchArrangeDoctor;
import com.pinde.sci.model.mo.SchArrangeDoctorExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class SchArrangeDoctorBizImpl implements ISchArrangeDoctorBiz {
	@Autowired
	private SchArrangeDoctorMapper arrangeDoctorMapper;
	
	@Override
	public List<SchArrangeDoctor> searchSchArrangeDoctor() {
		SchArrangeDoctorExample example = new SchArrangeDoctorExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		return arrangeDoctorMapper.selectByExample(example);
	}

	@Override
	public SchArrangeDoctor readSchArrangeDoctor(String arrDocFlow) {
		return arrangeDoctorMapper.selectByPrimaryKey(arrDocFlow);
	}

	@Override
	public int saveSchArrangeDoctor(SchArrangeDoctor arrangeDoctor) {
		if(arrangeDoctor != null){
			if(StringUtil.isNotBlank(arrangeDoctor.getArrDocFlow())){
				GeneralMethod.setRecordInfo(arrangeDoctor, false);
				return arrangeDoctorMapper.updateByPrimaryKeySelective(arrangeDoctor);
			}else{
				arrangeDoctor.setArrDocFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(arrangeDoctor, true);
				return arrangeDoctorMapper.insertSelective(arrangeDoctor);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}
	
}
