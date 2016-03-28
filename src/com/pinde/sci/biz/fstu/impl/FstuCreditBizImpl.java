package com.pinde.sci.biz.fstu.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.fstu.IFstuCreditBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.FstuCreditMapper;
import com.pinde.sci.model.mo.FstuCredit;
import com.pinde.sci.model.mo.FstuCreditExample;
import com.pinde.sci.model.mo.SysUserExample;
import com.pinde.sci.model.mo.FstuCreditExample.Criteria;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor=Exception.class)
public class FstuCreditBizImpl implements IFstuCreditBiz{

	@Resource
	private FstuCreditMapper fstuCreditMapper;
	
	@Override
	public List<FstuCredit> search(FstuCredit credit) {
		FstuCreditExample example=new FstuCreditExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		return fstuCreditMapper.selectByExample(example);
	}
	@Override
	public List<FstuCredit> searchByUserFlows(List<String> userFlow) {
		FstuCreditExample example=new FstuCreditExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowIn(userFlow);;
		return fstuCreditMapper.selectByExample(example);
	}
	@Override
	public int edit(FstuCredit credit) {
		if(StringUtil.isNotBlank(credit.getRecordFlow())){
			GeneralMethod.setRecordInfo(credit, false);
			return fstuCreditMapper.updateByPrimaryKeySelective(credit);
		}else{
			credit.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(credit, true);
			return fstuCreditMapper.insertSelective(credit);
			}
	}
	@Override
	public FstuCredit findByFlow(String flow) {
		
		return fstuCreditMapper.selectByPrimaryKey(flow);
	}
	@Override
	public List<FstuCredit> searchCreditByUserFlow(String userFlow){
		FstuCreditExample example = new FstuCreditExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(userFlow);
		return fstuCreditMapper.selectByExample(example);
	}
	@Override
	public int saveCreditList(List<FstuCredit> credit){
		for(FstuCredit fs:credit){
			edit(fs);
		}
		return GlobalConstant.ONE_LINE;
	}
}
