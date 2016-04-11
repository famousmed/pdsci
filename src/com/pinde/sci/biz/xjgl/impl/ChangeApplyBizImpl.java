package com.pinde.sci.biz.xjgl.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.JaxbUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.xjgl.IChangeApplyBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduUserChangeApplyMapper;
import com.pinde.sci.dao.base.EduUserMapper;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.dao.edu.EduStdentChangeExtMapper;
import com.pinde.sci.enums.xjgl.UserChangeApplyStatusEnum;
import com.pinde.sci.enums.xjgl.UserChangeApplyTypeEnum;
import com.pinde.sci.form.edu.SubmitApplyForm;
import com.pinde.sci.form.edu.UserChangeApplyForm;
import com.pinde.sci.model.edu.EduStudentChangeExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.EduUserChangeApply;
import com.pinde.sci.model.mo.EduUserChangeApplyExample;

@Service
@Transactional(rollbackFor = Exception.class)
public class ChangeApplyBizImpl implements IChangeApplyBiz{
	@Autowired
	private EduUserMapper eduUserMapper;
	@Autowired
	private EduCourseExtMapper eduCourseExtMapper;
	@Autowired
	private EduUserChangeApplyMapper eduUserChangeApplyMapper;
	@Autowired
	private EduStdentChangeExtMapper eduStdentChangeExtMapper ;
	
	@Override
	public EduUser readEduUser(String userFlow) {
		EduUser user=new EduUser();
		if (StringUtil.isNotBlank(userFlow)) {
			user=eduUserMapper.selectByPrimaryKey(userFlow);
		}
		return user;
	}
	@Override
	public List<EduCourse> searchStuCourseList(Map<String, Object> paramMap) {
		return eduCourseExtMapper.searchStuCourseList(paramMap);
	}
	@Override
	public int saveAndUpdateChangeApplyInfo(SubmitApplyForm form,UserChangeApplyForm applyForm,String userFlow,String recordFlow) {
		if (StringUtil.isNotBlank(recordFlow)) {
			EduUserChangeApply exitUser=eduUserChangeApplyMapper.selectByPrimaryKey(recordFlow);
			if (exitUser!=null) {
				exitUser.setApplyTime(DateUtil.getCurrDate());
				exitUser.setApplyTypeId(applyForm.getApply().getApplyTypeId());
				exitUser.setApplyTypeName(UserChangeApplyTypeEnum.getNameById(applyForm.getApply().getApplyTypeId()));
				String xml=JaxbUtil.convertToXml(form);
				exitUser.setContent(xml);
				GeneralMethod.setRecordInfo(exitUser, false);
				eduUserChangeApplyMapper.updateByPrimaryKeySelective(exitUser);
			}
		}else{
			EduUserChangeApply eduUser=applyForm.getApply();
			eduUser.setApplyTime(DateUtil.getCurrDate());
			eduUser.setApplyTypeName(UserChangeApplyTypeEnum.getNameById(applyForm.getApply().getApplyTypeId()));
			eduUser.setStatusId(UserChangeApplyStatusEnum.Save.getId());
			eduUser.setStatusName(UserChangeApplyStatusEnum.Save.getName());
			if (StringUtil.isNotBlank(userFlow)) {
				eduUser.setUserFlow(userFlow);
			}
			String xml=JaxbUtil.convertToXml(form);
			eduUser.setContent(xml);
			eduUser.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(eduUser, true);
			eduUserChangeApplyMapper.insert(eduUser);
		}
		return GlobalConstant.ONE_LINE;
	}
	@Override
	public List<EduUserChangeApply> searchEduUserChangeApply(EduUserChangeApply user) {
		EduUserChangeApplyExample example=new EduUserChangeApplyExample();
		com.pinde.sci.model.mo.EduUserChangeApplyExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.FLAG_Y);
		if (StringUtil.isNotBlank(user.getUserFlow())) {
			criteria.andUserFlowEqualTo(user.getUserFlow());
		}
		if (StringUtil.isNotBlank(user.getApplyTypeId())) {
			criteria.andApplyTypeIdEqualTo(user.getApplyTypeId());
		}
		if (StringUtil.isNotBlank(user.getApplyTypeName())) {
			criteria.andApplyTypeNameEqualTo(user.getApplyTypeName());
		}
		if (StringUtil.isNotBlank(user.getStatusId())) {
			criteria.andStatusIdEqualTo(user.getStatusId());
		}
		if (StringUtil.isNotBlank(user.getStatusName())) {
			criteria.andStatusNameEqualTo(user.getStatusName());
		}
		if (StringUtil.isNotBlank(user.getRecordFlow())) {
			criteria.andRecordFlowEqualTo(user.getRecordFlow());
		}
		example.setOrderByClause("APPLY_TIME desc,CREATE_TIME desc");
		return eduUserChangeApplyMapper.selectByExampleWithBLOBs(example);
	}
	@Override
	public int updataApplyInfo(EduUserChangeApply user,SubmitApplyForm form) {
			if (form!=null) {
				SubmitApplyForm submitApplyForm=JaxbUtil.converyToJavaBean(user.getContent(), SubmitApplyForm.class);
				submitApplyForm.setAuditContent(form.getAuditContent());
				submitApplyForm.setAuditDate(form.getAuditDate());
				submitApplyForm.setAuditPerson(form.getAuditPerson());
				submitApplyForm.setTeacherSugg(form.getTeacherSugg());
				submitApplyForm.setTrainSugg(form.getTrainSugg());
				submitApplyForm.setPostgraduSchSugg(form.getPostgraduSchSugg());
				submitApplyForm.setSwichTeachSugg(form.getSwichTeachSugg());
				submitApplyForm.setSwitchOrgSugg(form.getSwitchOrgSugg());
				submitApplyForm.setStudySuggg(form.getStudySuggg());
				submitApplyForm.setTrainOrgSugg(form.getTrainOrgSugg());
				if (submitApplyForm!=null) {
					String xml=JaxbUtil.convertToXml(submitApplyForm);
					user.setContent(xml);
				}
			}
			GeneralMethod.setRecordInfo(user, false);
			return eduUserChangeApplyMapper.updateByPrimaryKeyWithBLOBs(user);
	}
	@Override
	public List<EduStudentChangeExt> searchStdentChangeExtsList(
			Map<String, Object> paramMap) {
		return eduStdentChangeExtMapper.searchStdentChangeExtsList(paramMap);
	}
	@Override
	public EduUserChangeApply readEduUserChangeApply(String recordFlow) {
		return eduUserChangeApplyMapper.selectByPrimaryKey(recordFlow);
	}
}
