package com.pinde.sci.biz.edu.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCoursePeriodRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCoursePeriodRefMapper;
import com.pinde.sci.enums.edu.PeriodUserScopeEnum;
import com.pinde.sci.enums.edu.ScoreUserScopeEnum;
import com.pinde.sci.model.mo.EduCoursePeriodRef;
import com.pinde.sci.model.mo.EduCoursePeriodRefExample;
import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.EduCourseScoreRefExample;
import com.pinde.sci.model.mo.EduCoursePeriodRefExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCoursePeriodRefBizImpl implements IEduCoursePeriodRefBiz{

	@Autowired
	private EduCoursePeriodRefMapper periodRefMapper;
	
	@Override
	public int savePeriodRef(EduCoursePeriodRef ref) {
		if(StringUtil.isNotBlank(ref.getRecordFlow())){
			GeneralMethod.setRecordInfo(ref, false);
			return periodRefMapper.updateByPrimaryKeySelective(ref);
		}else{
			ref.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(ref, true);
			return periodRefMapper.insert(ref);
		}
	}

	@Override
	public String savePeriodRefs(List<EduCoursePeriodRef> refList,
			String courseFlow, String refTypeId) {
		//先删除该课程下计学时人员范围记录
		EduCoursePeriodRef periodRef=new EduCoursePeriodRef();
		periodRef.setCourseFlow(courseFlow);
		periodRef.setRefTypeId(refTypeId);
		List<EduCoursePeriodRef> refs=searchPeriodRefs(periodRef);
		deletePeriodRefs(refs);
		//保存计学时人员范围记录
		if(refList!=null && !refList.isEmpty()){
		  for(EduCoursePeriodRef ref:refList){
			ref.setCourseFlow(courseFlow);
			savePeriodRef(ref);
		  }
	    }
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<EduCoursePeriodRef> searchPeriodRefs(EduCoursePeriodRef ref) {
		EduCoursePeriodRefExample example=new EduCoursePeriodRefExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(ref.getCourseFlow())){
			criteria.andCourseFlowEqualTo(ref.getCourseFlow());
		}
		if(StringUtil.isNotBlank(ref.getRefTypeId())){
			criteria.andRefTypeIdEqualTo(ref.getRefTypeId());
		}
		return periodRefMapper.selectByExample(example);
	}

	@Override
	public EduCoursePeriodRef readPeriodRef(String recordFlow) {
		return periodRefMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public String deletePeriodRef(EduCoursePeriodRef ref) {
		if(ref!=null){
			ref.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(ref, false);
			periodRefMapper.updateByPrimaryKeySelective(ref);
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@Override
	public String deletePeriodRefs(List<EduCoursePeriodRef> refList) {
		if(refList!=null && !refList.isEmpty()){
			for(EduCoursePeriodRef ref:refList){
				deletePeriodRef(ref);
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@Override
	public String searchPeriodJurisdiction(String trainingSpeId,
			String userFlow, String schDeptFlow, String courseFlow) {
		String periodBl=GlobalConstant.FLAG_N;
		Criteria criteria=null;
		//按人员
		EduCoursePeriodRefExample exampleUser=new EduCoursePeriodRefExample();
		criteria=exampleUser.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EduCoursePeriodRef> periodRefUserList=null;
		if(StringUtil.isNotBlank(userFlow)){
			    criteria.andCourseFlowEqualTo(courseFlow);
				criteria.andRefTypeIdEqualTo(PeriodUserScopeEnum.User.getId());
				criteria.andRefFlowEqualTo(userFlow);
				periodRefUserList=this.periodRefMapper.selectByExample(exampleUser);
		}
		if(periodRefUserList!=null && !periodRefUserList.isEmpty()){
			   periodBl=GlobalConstant.FLAG_Y;
		}
		//按科室
		EduCoursePeriodRefExample exampleDept=new EduCoursePeriodRefExample();
		criteria=exampleDept.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EduCoursePeriodRef> periodRefDeptList=null;
		if(StringUtil.isNotBlank(schDeptFlow)){
			criteria.andCourseFlowEqualTo(courseFlow);
			criteria.andRefTypeIdEqualTo(PeriodUserScopeEnum.Dept.getId());
			criteria.andRefFlowEqualTo(schDeptFlow);
			periodRefDeptList=this.periodRefMapper.selectByExample(exampleDept);
	    }
	    if(periodRefDeptList!=null && !periodRefDeptList.isEmpty()){
	    	   periodBl=GlobalConstant.FLAG_Y;
	    }
	    //按专业
	    EduCoursePeriodRefExample exampleMajor=new EduCoursePeriodRefExample();
	    criteria=exampleMajor.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
	  	List<EduCoursePeriodRef> periodRefMajorList=null;
	    if(StringUtil.isNotBlank(trainingSpeId)){
	       criteria.andCourseFlowEqualTo(courseFlow);
	  	   criteria.andRefTypeIdEqualTo(PeriodUserScopeEnum.Major.getId());
	  	   criteria.andRefFlowEqualTo(trainingSpeId);
	  	   periodRefMajorList=this.periodRefMapper.selectByExample(exampleMajor);
	  	}
	  	if(periodRefMajorList!=null && !periodRefMajorList.isEmpty()){
	  		   periodBl=GlobalConstant.FLAG_Y;
	  	}
		return periodBl;
	}
    
}
