package com.pinde.sci.biz.njmuedu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseBiz;
import com.pinde.sci.biz.njmuedu.INjmuEduStudentCourseBiz;
import com.pinde.sci.biz.sys.IUserBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduStudentCourseMapper;
import com.pinde.sci.dao.njmuedu.NjmuEduCourseExtMapper;
import com.pinde.sci.dao.njmuedu.NjmuEduStudentCourseExtMapper;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.enums.edu.EduStudyStatusEnum;
import com.pinde.sci.enums.njmudu.NjmuEduCourseTypeEnum;
import com.pinde.sci.form.njmuedu.OneCourseCreditForm;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.SysUser;
import com.pinde.sci.model.njmuedu.EduStudentCourseExt;
import com.pinde.sci.model.njmuedu.EduUserExt;

@Service
@Transactional(rollbackFor = Exception.class)
public class NjmuEduStudentCourseBizImpl implements INjmuEduStudentCourseBiz{
	@Autowired
	private EduStudentCourseMapper studentCourseMapper;
	@Autowired
	private NjmuEduStudentCourseExtMapper studentCourseExtMapper;
	@Autowired
	private IEduCourseBiz courseBiz;
	@Autowired
	private IUserBiz userBiz;
	@Autowired
	private NjmuEduCourseExtMapper njmuEduCourseExtMapper;
	
	
	@Override
	public int edit(EduStudentCourse eduStudentCourse) {
		if(StringUtil.isNotBlank(eduStudentCourse.getRecordFlow())){
			GeneralMethod.setRecordInfo(eduStudentCourse, false);
			return studentCourseMapper.updateByPrimaryKeySelective(eduStudentCourse);
		}else{
			eduStudentCourse.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(eduStudentCourse, true);
			return studentCourseMapper.insertSelective(eduStudentCourse);
			
		}
	}

	@Override
	public Map<String,Map<String, Object>> searchStudentChooseCourses(
			List<EduUserExt> eduUserExtList) {
		Map<String,Map<String, Object>> allCourseByUserMap=new HashMap<String, Map<String,Object>>();
		Map<String, Object> requiredCourseMap=new HashMap<String, Object>();
		Map<String, Object> optionalCourseMap=new HashMap<String, Object>();
		Map<String, Object> publicCourseMap=new HashMap<String, Object>();
		Map<String,Object> allCreditMap=new HashMap<String, Object>();
		Map<String,Object> actualCreditMap=new HashMap<String, Object>();
		if(eduUserExtList!=null && !eduUserExtList.isEmpty()){
			for(EduUserExt eduUserExt:eduUserExtList){
				int allCredit=0;
				int actualCredit=0;
				Map<String,Object> paramMap=new HashMap<String, Object>();
				paramMap.put("userFlow", eduUserExt.getUserFlow());
				paramMap.put("courseTypeId", EduCourseTypeEnum.Required.getId());
				List<EduStudentCourseExt> eduStudentCourseExtRequiredList=this.studentCourseExtMapper.searchEduStudentCourseExtByUserFlow(paramMap);
				paramMap.put("courseTypeId", EduCourseTypeEnum.Optional.getId());
				List<EduStudentCourseExt> eduStudentCourseExtOptionalList=this.studentCourseExtMapper.searchEduStudentCourseExtByUserFlow(paramMap);
				paramMap.put("courseTypeId", EduCourseTypeEnum.Public.getId());
				List<EduStudentCourseExt> eduStudentCourseExtPublicList=this.studentCourseExtMapper.searchEduStudentCourseExtByUserFlow(paramMap);
				requiredCourseMap.put(eduUserExt.getUserFlow(), eduStudentCourseExtRequiredList);
				optionalCourseMap.put(eduUserExt.getUserFlow(), eduStudentCourseExtOptionalList);
				publicCourseMap.put(eduUserExt.getUserFlow(), eduStudentCourseExtPublicList);
			    if(eduStudentCourseExtRequiredList!=null && !eduStudentCourseExtRequiredList.isEmpty()){
			    	for(EduStudentCourseExt eduStudentCourseExt:eduStudentCourseExtRequiredList){
			    		allCredit=allCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		if(EduStudyStatusEnum.Finish.getId().equals(eduStudentCourseExt.getStudyStatusId())
			    		  && GlobalConstant.RECORD_STATUS_Y.equals(eduStudentCourseExt.getAchieveCredit())){
			    			actualCredit=actualCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		}
			    	}
			    }
			    if(eduStudentCourseExtOptionalList!=null && !eduStudentCourseExtOptionalList.isEmpty()){
			    	for(EduStudentCourseExt eduStudentCourseExt:eduStudentCourseExtOptionalList){
			    		allCredit=allCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		if(EduStudyStatusEnum.Finish.getId().equals(eduStudentCourseExt.getStudyStatusId())
			    		  && GlobalConstant.RECORD_STATUS_Y.equals(eduStudentCourseExt.getAchieveCredit())){
			    			actualCredit=actualCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		}
			    	}
			    }
			    if(eduStudentCourseExtPublicList!=null && !eduStudentCourseExtPublicList.isEmpty()){
			    	for(EduStudentCourseExt eduStudentCourseExt:eduStudentCourseExtPublicList){
			    		allCredit=allCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		if(EduStudyStatusEnum.Finish.getId().equals(eduStudentCourseExt.getStudyStatusId())
			    	      && GlobalConstant.RECORD_STATUS_Y.equals(eduStudentCourseExt.getAchieveCredit())){
			    			actualCredit=actualCredit+Integer.parseInt(eduStudentCourseExt.getCourse().getCourseCredit());
			    		}
			    	}
			    }
			    allCreditMap.put(eduUserExt.getUserFlow(), allCredit);
			    actualCreditMap.put(eduUserExt.getUserFlow(), actualCredit);
			}
		}
		allCourseByUserMap.put("required", requiredCourseMap);
		allCourseByUserMap.put("optional", optionalCourseMap);
		allCourseByUserMap.put("allCreditMap", allCreditMap);
		allCourseByUserMap.put("actualCreditMap", actualCreditMap);
		return allCourseByUserMap;
	}

	@Override
	public Map<String,Object> searchCourseCreditForm(
			String courseFlow) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("courseFlow", courseFlow);
		List<OneCourseCreditForm> fromList=this.studentCourseExtMapper.searchCourseCreditForm(paramMap);
		Map<String,Object> userAndCourseCreditMap=new HashMap<String, Object>();
	    if(fromList!=null && !fromList.isEmpty()){
	    	for(OneCourseCreditForm form:fromList){
	    		userAndCourseCreditMap.put(form.getUserFlow(), form.getCourseCredit());
	    	}
	    }
		return userAndCourseCreditMap;
	}

	@Override
	public int insertRequireCourse(String userFlow) {
		SysUser user=this.userBiz.readSysUser(userFlow);
		if(user!=null){
			EduStudentCourse studentCourse=null;
			Map<String,Object> paramMap=new HashMap<String, Object>();
			paramMap.put("courseTypeId", NjmuEduCourseTypeEnum.Required.getId());
			paramMap.put("userFlow", userFlow);
			List<EduCourse> courseList=this.njmuEduCourseExtMapper.searchNeedAddCourses(paramMap);
			if(courseList!=null && !courseList.isEmpty()){
				for(EduCourse eduCourse:courseList){
					studentCourse=new EduStudentCourse();
					studentCourse.setUserFlow(userFlow);
					studentCourse.setCourseFlow(eduCourse.getCourseFlow());
					studentCourse.setStudyStatusId(EduStudyStatusEnum.NotStarted.getId());
					studentCourse.setStudyStatusName(EduStudyStatusEnum.NotStarted.getName());
					studentCourse.setCourseTypeId(EduCourseTypeEnum.Required.getId());
					studentCourse.setCourseTypeName(EduCourseTypeEnum.Required.getName());
					studentCourse.setChooseTime(DateUtil.getCurrDateTime(DateUtil.defDtPtn02));
					studentCourse.setCourseCredit(eduCourse.getCourseCredit());
					studentCourse.setCoursePeriod(eduCourse.getCoursePeriod());
					int result=edit(studentCourse);
					if(GlobalConstant.ZERO_LINE==result){
						return GlobalConstant.ZERO_LINE;
					}
				}
			}
		}
		return GlobalConstant.ONE_LINE;
	}
   
	
}
