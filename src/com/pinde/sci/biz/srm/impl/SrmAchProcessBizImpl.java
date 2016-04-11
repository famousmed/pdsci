package com.pinde.sci.biz.srm.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.srm.ISrmAchProcessBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.SrmAchProcessMapper;
import com.pinde.sci.enums.srm.AchStatusEnum;
import com.pinde.sci.model.mo.SrmAchPatentExample;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchProcessExample;
import com.pinde.sci.model.mo.SrmAchProcessExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class SrmAchProcessBizImpl implements ISrmAchProcessBiz{
@Resource
 private SrmAchProcessMapper srmAchProcessMapper;
	
    @Override
	public int saveAchProcess(SrmAchProcess srmAchProcess) {
		return srmAchProcessMapper.insert(srmAchProcess);
	}

	@Override
	public List<SrmAchProcess> searchAchProcess(String achFlow,String statusId) {
		SrmAchProcessExample example=new SrmAchProcessExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
		.andAchFlowEqualTo(achFlow).andOperStatusIdEqualTo(statusId);
		example.setOrderByClause("CREATE_TIME DESC");
		return srmAchProcessMapper.selectByExample(example);
	}

	@Override
	public List<SrmAchProcess> searchAchProcess(SrmAchProcess achProcess) {

		SrmAchProcessExample example = new SrmAchProcessExample();
		Criteria criteria = example.createCriteria();
		criteria.andOperStatusIdNotEqualTo(AchStatusEnum.Apply.getId());
		
		if(StringUtil.isNotBlank(achProcess.getAchFlow())){
			criteria.andAchFlowEqualTo(achProcess.getAchFlow());
		}
		if(StringUtil.isNotBlank(achProcess.getRecordStatus())){
			criteria.andRecordStatusEqualTo(achProcess.getRecordStatus());
		}
		if(StringUtil.isNotBlank(achProcess.getTypeId())){
			criteria.andTypeIdEqualTo(achProcess.getTypeId());
		}
		example.setOrderByClause("CREATE_TIME DESC");
		return this.srmAchProcessMapper.selectByExample(example);
	}

}
