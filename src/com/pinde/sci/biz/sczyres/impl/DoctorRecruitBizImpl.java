package com.pinde.sci.biz.sczyres.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.res.IResJointOrgBiz;
import com.pinde.sci.biz.sczyres.DoctorRecruitBiz;
import com.pinde.sci.biz.sczyres.DoctorSingupBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.dao.base.ResOrgSpeAssignMapper;
import com.pinde.sci.dao.res.ResDoctorRecruitExtMapper;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitExample;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResJointOrg;
import com.pinde.sci.model.mo.ResOrgSpeAssignExample;
import com.pinde.sci.model.mo.ResDoctorRecruitExample.Criteria;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class DoctorRecruitBizImpl implements DoctorRecruitBiz{

	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private ResOrgSpeAssignMapper speAssignMapper;
	@Autowired
	private ResDoctorRecruitExtMapper doctorRecruitExtMapper;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private DoctorSingupBiz doctorSingupBiz;
	
	
	@Override
	public List<ResDoctorRecruit> findDoctorRecruit(ResDoctorRecruit recruit , String orderByColum , String order) {
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(recruit.getDoctorFlow())) {
			criteria.andDoctorFlowEqualTo(recruit.getDoctorFlow());
		}
		if (StringUtil.isNotBlank(recruit.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(recruit.getOrgFlow());
		}
		if (StringUtil.isNotBlank(recruit.getSpeId())) {
			criteria.andSpeIdEqualTo(recruit.getSpeId());
		}
		if (StringUtil.isNotBlank(recruit.getRecruitYear())) {
			criteria.andRecruitYearEqualTo(recruit.getRecruitYear());
		}
		if (StringUtil.isNotBlank(recruit.getRecruitFlag())) {
			criteria.andRecruitFlagEqualTo(recruit.getRecruitFlag());
		}
		StringBuffer sb = new StringBuffer();
		if(StringUtil.isNotBlank(orderByColum)){
			sb.append(orderByColum);
		}
		if(StringUtil.isNotBlank(order)){
			sb.append(" "+order);
		}
		if(StringUtil.isNotBlank(sb.toString())){
			example.setOrderByClause(sb.toString());	
		}
		return doctorRecruitMapper.selectByExample(example);
	}

	@Override
	public List<ResOrgSpeAssign> findSpeAssign(String orgFlow,
			String assignYear) {
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andOrgFlowEqualTo(orgFlow).andAssignYearEqualTo(assignYear);
		return this.speAssignMapper.selectByExample(example);
	}

	@Override
	public List<ResOrgSpeAssign> findSpes(ResOrgSpeAssign spe) {
		ResOrgSpeAssignExample example = new ResOrgSpeAssignExample();
		com.pinde.sci.model.mo.ResOrgSpeAssignExample.Criteria criteria = example.createCriteria();
		if(StringUtil.isNotBlank(spe.getOrgFlow())){
			criteria.andOrgFlowEqualTo(spe.getOrgFlow());
		}
		if(StringUtil.isNotBlank(spe.getAssignYear())){
			criteria.andAssignYearEqualTo(spe.getAssignYear());
		}
		if(StringUtil.isNotBlank(spe.getSpeId())){
			criteria.andSpeIdEqualTo(spe.getSpeId());
		}
		if(StringUtil.isNotBlank(spe.getRecordStatus())){
			criteria.andRecordStatusEqualTo(spe.getRecordStatus());
		}
		return speAssignMapper.selectByExample(example);
	}
	
	@Override
	public List<ResDoctorRecruitExt> selectDoctorRecruitExt(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.selectDoctorRecruitExt(paramMap);
	}
	
	@Override
	public ResDoctorRecruit readResDoctorRecruit(String recruitFlow){
		return this.doctorRecruitMapper.selectByPrimaryKey(recruitFlow);
	}
	
	@Override
	public	int editDoctorRecruit(ResDoctorRecruitWithBLOBs recruit){
		if(recruit!=null){
			if(StringUtil.isNotBlank(recruit.getRecruitFlow())){
				GeneralMethod.setRecordInfo(recruit, false);
				return doctorRecruitMapper.updateByPrimaryKeySelective(recruit);
			}else{
				recruit.setRecruitFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(recruit, true);
				return doctorRecruitMapper.insertSelective(recruit);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public void recruit(ResDoctorRecruitWithBLOBs recruit) {
		editDoctorRecruit(recruit);
		recruit = (ResDoctorRecruitWithBLOBs)this.readResDoctorRecruit(recruit.getRecruitFlow());
		String admitNotice = recruit.getAdmitNotice();
		if(GlobalConstant.FLAG_Y.equals(recruit.getRecruitFlag())){
		    //将录取通知放到msg中
			if(StringUtil.isNotBlank(admitNotice)){
				this.msgBiz.addSysMsg(recruit.getDoctorFlow(), "录取通知", admitNotice);
			}
		}else if(GlobalConstant.FLAG_N.equals(recruit.getRecruitFlag())) {
			this.msgBiz.addSysMsg(recruit.getDoctorFlow(), "抱歉,经考核您未被我基地录取", "");
		}
	}

	@Override
	public int findCountByRecruit(ResDoctorRecruit recruit) {
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		Criteria criteria = example.createCriteria();
		criteria.andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(recruit.getOrgFlow())){
			criteria.andOrgFlowEqualTo(recruit.getOrgFlow());
		}
		if(StringUtil.isNotBlank(recruit.getCatSpeId())){
            criteria.andCatSpeIdEqualTo(recruit.getCatSpeId());
		}
		if(StringUtil.isNotBlank(recruit.getSpeId())){
			criteria.andSpeIdEqualTo(recruit.getSpeId());
		}
		if(StringUtil.isNotBlank(recruit.getRecruitFlag())){
			criteria.andRecruitFlagEqualTo(recruit.getRecruitFlag());
		}
		if(StringUtil.isNotBlank(recruit.getRecruitYear())){
			criteria.andRecruitYearEqualTo(recruit.getRecruitYear());
		}
		if(StringUtil.isNotBlank(recruit.getConfirmFlag())){
			criteria.andConfirmFlagEqualTo(recruit.getConfirmFlag());
		}
		return this.doctorRecruitMapper.countByExample(example);
	}

	@Override
	public Map<String, ResDoctorRecruit> findSwapDoctorRecruit(
			List<String> noRecruitDoctors) {
		Map<String , ResDoctorRecruit> resultMap = new HashMap<String, ResDoctorRecruit>();
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y)
		.andRecruitTypeIdEqualTo(RecruitTypeEnum.Swap.getId())
		.andDoctorFlowIn(noRecruitDoctors);
		example.setOrderByClause("CREATE_TIME");
		List<ResDoctorRecruit> swaprecruits = this.doctorRecruitMapper.selectByExample(example);
		for(ResDoctorRecruit swapRecruit:swaprecruits){
			resultMap.put(swapRecruit.getDoctorFlow(), swapRecruit);
		}
		return resultMap;
	}
	
	@Override
	public Map<String, ResDoctorRecruit> findNoRecruitDoctorRecruit(
			List<String> swapRecruitDoctors) {
		Map<String , ResDoctorRecruit> resultMap = new HashMap<String, ResDoctorRecruit>();
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y)
        .andRecruitFlagEqualTo(GlobalConstant.FLAG_N)
		.andDoctorFlowIn(swapRecruitDoctors);
		example.setOrderByClause("CREATE_TIME");
		List<ResDoctorRecruit> swaprecruits = this.doctorRecruitMapper.selectByExample(example);
		for(ResDoctorRecruit swapRecruit:swaprecruits){
			resultMap.put(swapRecruit.getDoctorFlow(), swapRecruit);
		}
		return resultMap;
	}

	@Override
	public void swapRecruit(ResDoctorRecruitWithBLOBs recruit) {
		recruit.setRecruitTypeId(RecruitTypeEnum.Swap.getId());
		recruit.setRecruitTypeName(RecruitTypeEnum.Swap.getName());
		recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		doctorSingupBiz.saveRecruit(recruit);
		if(StringUtil.isNotBlank(recruit.getAdmitNotice())){
			this.msgBiz.addSysMsg(recruit.getDoctorFlow(), "调剂通知", recruit.getAdmitNotice());
		}
	}

	



}
