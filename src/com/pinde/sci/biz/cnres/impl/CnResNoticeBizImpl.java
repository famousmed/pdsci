package com.pinde.sci.biz.cnres.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.cnres.ICnResNoticeBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.InxInfoMapper;
import com.pinde.sci.enums.inx.InfoStatusEnum;
import com.pinde.sci.model.mo.InxInfo;
import com.pinde.sci.model.mo.InxInfoExample;

@Service
@Transactional(rollbackFor = Exception.class)
public class CnResNoticeBizImpl implements ICnResNoticeBiz{

	@Autowired
	private InxInfoMapper inxInfoMapper;
	
	@Override
	public int save(InxInfo info) {
		info.setColumnId("CNRESGG");
		info.setColumnName("����");
		return editInfo(info);
	}
	
	@Override
	public int editInfo(InxInfo info) {
		if(StringUtil.isBlank(info.getInfoFlow())){
			info.setInfoFlow(PkUtil.getUUID());
			info.setInfoStatusId(InfoStatusEnum.Passed.getId());
			info.setInfoStatusName(InfoStatusEnum.Passed.getName());
			info.setViewNum(new Long(0));
			info.setInfoTime(DateUtil.getCurrDateTime());
			GeneralMethod.setRecordInfo(info, true);
			return this.inxInfoMapper.insert(info);
		}else{
			GeneralMethod.setRecordInfo(info, false);
			return this.inxInfoMapper.updateByPrimaryKeySelective(info);
		}
	}

	@Override
	public List<InxInfo> findNotice(InxInfo info) {
		InxInfoExample example = new InxInfoExample();
		example.setOrderByClause("INFO_TIME DESC");
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andColumnIdEqualTo("CNRESGG");
		return inxInfoMapper.selectByExample(example);
	}
	
	@Override
	public List<InxInfo> searchNotice(InxInfo info) {
		InxInfoExample example = new InxInfoExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		example.setOrderByClause("INFO_TIME DESC");
		return inxInfoMapper.selectByExample(example);
	}
	
	@Override
	public List<InxInfo> searchSevenDaysNotice(InxInfo info) {
		String beforeSevenDay = DateUtil.addHour(DateUtil.getCurrDateTime(),-7*24).substring(0,8);
		
		InxInfoExample example = new InxInfoExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andInfoTimeGreaterThanOrEqualTo(beforeSevenDay);
		example.setOrderByClause("INFO_TIME DESC");
		return inxInfoMapper.selectByExample(example);
	}

	@Override
	public InxInfo findNoticByFlow(String flow) {
		return this.inxInfoMapper.selectByPrimaryKey(flow);
	}

	@Override
	public int delNotice(String flow) {
		InxInfo record = new InxInfo();
		record.setInfoFlow(flow);
		record.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
		GeneralMethod.setRecordInfo(record, false);
		return this.inxInfoMapper.updateByPrimaryKeySelective(record);
	}

}
