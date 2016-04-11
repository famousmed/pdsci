package com.pinde.sci.biz.hbres.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.hbres.IResDoctorRecruitBiz;
import com.pinde.sci.biz.hbres.RecruitCfgBiz;
import com.pinde.sci.biz.pub.IMsgBiz;
import com.pinde.sci.biz.res.IResOrgSpeAssignBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.ResDoctorRecruitMapper;
import com.pinde.sci.dao.res.ResDoctorRecruitExtMapper;
import com.pinde.sci.enums.res.RecruitTypeEnum;
import com.pinde.sci.form.hbres.ResDoctorTrainingSpeForm;
import com.pinde.sci.model.mo.ResDoctorRecruit;
import com.pinde.sci.model.mo.ResDoctorRecruitExample;
import com.pinde.sci.model.mo.ResDoctorRecruitWithBLOBs;
import com.pinde.sci.model.mo.ResOrgSpeAssign;
import com.pinde.sci.model.mo.ResRecruitCfg;
import com.pinde.sci.model.mo.ResDoctorRecruitExample.Criteria;
import com.pinde.sci.model.mo.SysDict;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.res.ResDoctorRecruitExt;

@Service
@Transactional(rollbackFor=Exception.class)
public class ResDoctorRcruitBizImpl implements IResDoctorRecruitBiz{
	
	@Autowired
	private ResDoctorRecruitExtMapper doctorRecruitExtMapper;
	@Autowired
	private ResDoctorRecruitMapper doctorRecruitMapper;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private IMsgBiz msgBiz;
	@Autowired
	private IResOrgSpeAssignBiz speAssignBiz;
	@Autowired
	private RecruitCfgBiz recruitCfgBiz;
	
	@Override
	public List<ResDoctorRecruitExt> searchDoctorRecruitWithUserList(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.searchDoctorRecruitWithUserList(paramMap);
	}
	
	@Override
	public List<ResDoctorRecruit> searchDoctorRecruit(ResDoctorRecruit recruit){
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
		example.setOrderByClause("EXAM_RESULT desc");
		return doctorRecruitMapper.selectByExample(example);
	}
	
	@Override
	public List<SysDict> searchTrainSpeList(Map<String , Object> paramMap){
		return doctorRecruitExtMapper.searchTrainSpeList(paramMap);
	}
	
	@Override
	public List<ResDoctorRecruitExt> searchDoctorRecruitExt(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.searchDoctorRecruitExt(paramMap);
	}
	
	@Override
	public int searchDoctorNum(ResDoctorRecruit recruit){
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if (StringUtil.isNotBlank(recruit.getOrgFlow())) {
			criteria.andOrgFlowEqualTo(recruit.getOrgFlow());
		}
		if (StringUtil.isNotBlank(recruit.getSpeId())) {
			criteria.andSpeIdEqualTo(recruit.getSpeId());
		}
		if (StringUtil.isNotBlank(recruit.getRecruitYear())) {
			criteria.andRecruitYearEqualTo(recruit.getRecruitYear());
		}
//		if (recruit.getOrdinal() != null) {
//			criteria.andOrdinalEqualTo(recruit.getOrdinal());
//		}
		if(StringUtil.isNotBlank(recruit.getRecruitTypeId())){
			criteria.andRecruitTypeIdEqualTo(recruit.getRecruitTypeId());
		}
		if (StringUtil.isNotBlank(recruit.getRetestFlag())) {
			criteria.andRetestFlagEqualTo(recruit.getRetestFlag());
		}
		if (StringUtil.isNotBlank(recruit.getRecruitFlag())) {
			criteria.andRecruitFlagEqualTo(recruit.getRecruitFlag());
		}
		if (StringUtil.isNotBlank(recruit.getConfirmFlag())) {
			criteria.andConfirmFlagEqualTo(recruit.getConfirmFlag());
		}
		return doctorRecruitMapper.countByExample(example);
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
	public ResDoctorRecruit readResDoctorRecruit(String recruitFlow){
		return this.doctorRecruitMapper.selectByPrimaryKey(recruitFlow);
	}
	
	@Override
	public void noticeRetest(String recruitFlow , String retestNotice){
		String content = retestNotice;
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setRetestFlag(GlobalConstant.FLAG_Y);
		recruit.setRetestNotice(retestNotice);
		editDoctorRecruit(recruit);
		ResDoctorRecruit rdr = this.readResDoctorRecruit(recruitFlow);
		SysUser exitUser = userBiz.readSysUser(rdr.getDoctorFlow());
		String title = InitConfig.getSysCfg("res_retest_notice_email_title");
		this.msgBiz.addEmailMsg(exitUser.getUserEmail() , title, content);
	}
	
	@Override
	public void noticeRetestBatch(String[] recruitFlows,String retestNotice){
		if(recruitFlows!=null && recruitFlows.length>0){
			for(String recruitFlow:recruitFlows){
				noticeRetest(recruitFlow , retestNotice);
			}
		}
	}
	
	@Override
	public List<ResDoctorTrainingSpeForm> searchRegisterStatistics(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.searchRegisterStatistics(paramMap);
	}
	
	@Override
	public String searchNoticeDoctorNum(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.searchNoticeDoctorNum(paramMap);
	}
	
	@Override
	public List<ResDoctorRecruitExt> selectDoctorRecruitExt(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.selectDoctorRecruitExt(paramMap);
	}
	
//	@Override
//	public	int editRecruitUnSelective(ResDoctorRecruit recruit){
//		if(recruit!=null){
//			if(StringUtil.isNotBlank(recruit.getDoctorFlow())){
//				GeneralMethod.setRecordInfo(recruit, false);
//				return doctorRecruitMapper.updateByPrimaryKey(recruit);
//			}else{
//				recruit.setDoctorFlow(PkUtil.getUUID());
//				GeneralMethod.setRecordInfo(recruit, true);
//				return doctorRecruitMapper.insert(recruit);
//			}
//		}
//		return GlobalConstant.ZERO_LINE;
//	}
	
	@Override
	public List<ResDoctorRecruitExt> readDoctorRecruitExt(Map<String, Object> paramMap) {
		return doctorRecruitExtMapper.readDoctorRecruitExt(paramMap);
	}
	
	@Override
	public void noticeRecruit(String admitNotice,String[] recruitFlows){
		String content = admitNotice;
		if (recruitFlows != null && recruitFlows.length>0) {
			ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
			recruit.setRecruitFlag(GlobalConstant.FLAG_Y);
			recruit.setAdmitFlag(GlobalConstant.FLAG_Y);
			recruit.setAdmitNotice(admitNotice);
			for (String recruitFlow:recruitFlows) {
				recruit.setRecruitFlow(recruitFlow);
				editDoctorRecruit(recruit);
				ResDoctorRecruit exitRecruit = this.readResDoctorRecruit(recruitFlow);
				SysUser exitUser = userBiz.readSysUser(exitRecruit.getDoctorFlow());
				String title = InitConfig.getSysCfg("res_admit_notice_email_title");
				this.msgBiz.addEmailMsg(exitUser.getUserEmail() , title, content);
			}
		}
	}

	@Override
	public void swapRecruit(String recruitFlow, String speFlow, String swapNotice) {
		ResDoctorRecruitWithBLOBs recruit = new ResDoctorRecruitWithBLOBs();
		recruit.setRecruitFlow(recruitFlow);
		recruit.setRecruitFlag(GlobalConstant.FLAG_N);
		ResOrgSpeAssign spe = this.speAssignBiz.findSpeAssignByFlow(speFlow);
		recruit.setSwapSpeId(spe.getSpeId());
		recruit.setSwapSpeName(spe.getSpeName());
		this.editDoctorRecruit(recruit);
		
		recruit = this.doctorRecruitMapper.selectByPrimaryKey(recruitFlow);
		ResDoctorRecruitWithBLOBs swapRecruit = new ResDoctorRecruitWithBLOBs();
		swapRecruit.setDoctorFlow(recruit.getDoctorFlow());
		swapRecruit.setOrgFlow(recruit.getOrgFlow());
		swapRecruit.setOrgName(recruit.getOrgName());
		swapRecruit.setSpeId(spe.getSpeId());
		swapRecruit.setSpeName(spe.getSpeName());
		swapRecruit.setSwapFlag(recruit.getSwapFlag());
		swapRecruit.setRecruitTypeId(RecruitTypeEnum.Swap.getId());
		swapRecruit.setRecruitTypeName(RecruitTypeEnum.Swap.getName());
		swapRecruit.setRecruitYear(recruit.getRecruitYear());
		swapRecruit.setExamResult(recruit.getExamResult());
		swapRecruit.setAuditionResult(recruit.getAuditionResult());
		swapRecruit.setOperResult(recruit.getOperResult());
		swapRecruit.setTotleResult(recruit.getTotleResult());
		swapRecruit.setAdmitFlag(GlobalConstant.FLAG_Y);
		swapRecruit.setAdmitNotice(swapNotice);
		swapRecruit.setRecruitFlag(GlobalConstant.FLAG_Y);
		swapRecruit.setRecruitDate(DateUtil.getCurrDate());
		this.editDoctorRecruit(swapRecruit);
		
		SysUser exitUser = userBiz.readSysUser(swapRecruit.getDoctorFlow());
		String title = InitConfig.getSysCfg("res_admit_notice_email_title");
		this.msgBiz.addEmailMsg(exitUser.getUserEmail() , title, swapNotice);
		
	}

	@Override
	public void setDoctorConfirmFlagForOutOfDate(String year, String doctorFlow) {
		ResRecruitCfg recruitCfg = recruitCfgBiz.findRecruitCfgByYear(year);
		String wishBeginDate = recruitCfg.getWishBeginDate();
		String wishEndDate = recruitCfg.getWishEndDate();
		String admitEndDate = recruitCfg.getAdmitEndDate();
		
		//2015 04 23 170839
		//获取当前日期
		String currDate = DateUtil.getCurrDate();
		if(currDate.compareTo(admitEndDate)>0){
			ResDoctorRecruitWithBLOBs record = new ResDoctorRecruitWithBLOBs();
			record.setConfirmFlag(GlobalConstant.FLAG_N);//学员过期标记，直接默认放弃录取
			ResDoctorRecruitExample example = new ResDoctorRecruitExample();
			example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y)
			.andRecruitYearEqualTo(year).andDoctorFlowEqualTo(doctorFlow).andConfirmFlagIsNull()
			.andRecruitFlagEqualTo(GlobalConstant.FLAG_Y).andRecruitDateBetween(wishBeginDate, wishEndDate);
			this.doctorRecruitMapper.updateByExampleSelective(record , example);
		}
		
	}

	@Override
	public boolean doctorIsConfirmAdmit(String doctorFlow) {
		ResDoctorRecruitExample example = new ResDoctorRecruitExample();
		example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y)
		.andDoctorFlowEqualTo(doctorFlow)
		.andConfirmFlagEqualTo(GlobalConstant.FLAG_Y);
		int count = this.doctorRecruitMapper.countByExample(example);
		if(count>0){
			return true;
		}
		return false;
	}

	@Override
	public void modResDoctorRecruitByRecruitFlow(
			ResDoctorRecruitWithBLOBs recruit , boolean isModAll) {
		GeneralMethod.setRecordInfo(recruit , false);
		if(isModAll){
			this.doctorRecruitMapper.updateByPrimaryKeyWithBLOBs(recruit);
		}else{
			this.doctorRecruitMapper.updateByPrimaryKeySelective(recruit);
		}
		
		
	}
	
}
