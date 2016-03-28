package com.pinde.sci.biz.pub.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubPatientAeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.PubPatientAeMapper;
import com.pinde.sci.model.mo.PubPatientAe;
import com.pinde.sci.model.mo.PubPatientAeExample;

@Service
@Transactional(rollbackFor=Exception.class)
public class PubPatientAeBizImpl implements IPubPatientAeBiz {
	@Resource
	private PubPatientAeMapper patientAeMapper;

	@Override
	public List<PubPatientAe> searchPatientAeList(PubPatientAe patientAe) {
		PubPatientAeExample example = new PubPatientAeExample();
		com.pinde.sci.model.mo.PubPatientAeExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(patientAe.getProjFlow())){
			criteria.andProjFlowEqualTo(patientAe.getProjFlow());
		}
		if(StringUtil.isNotBlank(patientAe.getOrgFlow())){
			criteria.andOrgFlowEqualTo(patientAe.getOrgFlow());
		}
		if(StringUtil.isNotBlank(patientAe.getPatientFlow())){
			criteria.andPatientFlowEqualTo(patientAe.getPatientFlow());
		}
		example.setOrderByClause("PATIENT_CODE, REPORT_DATE");
		return patientAeMapper.selectByExample(example);
	}

	@Override
	public int save(PubPatientAe patientAe) {
		if(StringUtil.isNotBlank(patientAe.getRecordFlow())){
			GeneralMethod.setRecordInfo(patientAe, false);
			return patientAeMapper.updateByPrimaryKeySelective(patientAe);
		}else{
			patientAe.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(patientAe, true);
			return patientAeMapper.insert(patientAe);
		}
		
	}

	@Override
	public PubPatientAe readPatientAe(String recordFlow) {
		if(StringUtil.isNotBlank(recordFlow)){
			return patientAeMapper.selectByPrimaryKey(recordFlow);
		}
		return null;
	}

	@Override
	public List<PubPatientAe> searchSaeList(List<String> projFlowList) {
		if(projFlowList != null && !projFlowList.isEmpty()){
			PubPatientAeExample example = new PubPatientAeExample();
			example.createCriteria().andProjFlowIn(projFlowList).andIsSaeEqualTo(GlobalConstant.RECORD_STATUS_Y).andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
			return patientAeMapper.selectByExample(example);
		}
		return null;
	}

}
