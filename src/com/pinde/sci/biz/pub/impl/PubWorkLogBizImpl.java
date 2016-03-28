package com.pinde.sci.biz.pub.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IPubWorkLogBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.PubWorkLogMapper;
import com.pinde.sci.enums.pub.LogTypeEnum;
import com.pinde.sci.model.mo.PubWorkLog;
import com.pinde.sci.model.mo.PubWorkLogExample;
import com.pinde.sci.model.mo.SysUser;
@Service
@Transactional(rollbackFor = Exception.class)
public class PubWorkLogBizImpl implements IPubWorkLogBiz {
	@Resource
	private PubWorkLogMapper workLogMapper;

	@Override
	public int saveWorkLog(PubWorkLog workLog) {
		if(StringUtil.isBlank(workLog.getLogFlow())){
			SysUser currUser =  GlobalContext.getCurrentUser();
			workLog.setUserFlow(currUser.getUserFlow());
			workLog.setUserName(currUser.getUserName());
			workLog.setLogFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(workLog, true);
			return workLogMapper.insert(workLog);
		}else{
			GeneralMethod.setRecordInfo(workLog, false);
			return workLogMapper.updateByPrimaryKeySelective(workLog);
		}
	}

	@Override
	public List<PubWorkLog> searchWorkLogList(PubWorkLog workLog, String startDate, String endDate, String withBLOBs) {
		PubWorkLogExample example = new PubWorkLogExample();
		com.pinde.sci.model.mo.PubWorkLogExample.Criteria  criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(startDate)){
			criteria.andFillDateGreaterThanOrEqualTo(startDate);
		}
		if(StringUtil.isNotBlank(endDate)){
			criteria.andFillDateLessThanOrEqualTo(endDate);
		}
		String logTypeId = workLog.getLogTypeId();
		if(StringUtil.isNotBlank(logTypeId)){
			criteria.andLogTypeIdEqualTo(logTypeId);
			if(LogTypeEnum.Week.getId().equals(logTypeId)){
				example.setOrderByClause("substr(FILL_DATE, 1, 7) desc, WEEK_NUM desc");
			}else if(LogTypeEnum.Month.getId().equals(logTypeId)){
				example.setOrderByClause("FILL_DATE desc");
			}
		}
		if(GlobalConstant.RECORD_STATUS_Y.equals(withBLOBs)){
			return workLogMapper.selectByExampleWithBLOBs(example);
		}else{
			return workLogMapper.selectByExample(example);
		}
		
	}

	@Override
	public PubWorkLog readWorkLog(String logFlow) {
		return workLogMapper.selectByPrimaryKey(logFlow);
	}

}
