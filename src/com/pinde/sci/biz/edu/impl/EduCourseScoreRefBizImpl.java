package com.pinde.sci.biz.edu.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseScoreRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCourseScoreRefMapper;
import com.pinde.sci.enums.edu.ScoreUserScopeEnum;
import com.pinde.sci.model.mo.EduCourseRequireRef;
import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.EduCourseScoreRefExample;
import com.pinde.sci.model.mo.EduCourseScoreRefExample.Criteria;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseScoreRefBizImpl implements IEduCourseScoreRefBiz{

	@Autowired
	private EduCourseScoreRefMapper scoreRefMapper;
	
	@Override
	public int saveScoreRef(EduCourseScoreRef ref) {
		if(StringUtil.isNotBlank(ref.getRecordFlow())){
			GeneralMethod.setRecordInfo(ref, false);
			return scoreRefMapper.updateByPrimaryKeySelective(ref);
		}else{
			ref.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(ref, true);
			return scoreRefMapper.insert(ref);
		}
	}

	@Override
	public String saveScoreRefs(List<EduCourseScoreRef> refList,
			String courseFlow, String refTypeId) {
		//先删除该课程下计分人员范围记录
		EduCourseScoreRef scoreRef=new EduCourseScoreRef();
		scoreRef.setCourseFlow(courseFlow);
		scoreRef.setRefTypeId(refTypeId);
		List<EduCourseScoreRef> refs=searchScoreRefs(scoreRef);
		deleteScoreRefs(refs);
		//保存计分人员范围记录
		if(refList!=null && !refList.isEmpty()){
			for(EduCourseScoreRef ref:refList){
				ref.setCourseFlow(courseFlow);
				saveScoreRef(ref);
		    }
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<EduCourseScoreRef> searchScoreRefs(EduCourseScoreRef ref) {
		EduCourseScoreRefExample example=new EduCourseScoreRefExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(ref.getCourseFlow())){
			criteria.andCourseFlowEqualTo(ref.getCourseFlow());
		}
		if(StringUtil.isNotBlank(ref.getRefTypeId())){
			criteria.andRefTypeIdEqualTo(ref.getRefTypeId());
		}
		return scoreRefMapper.selectByExample(example);
	}

	@Override
	public EduCourseScoreRef readScoreRef(String recordFlow) {
		return scoreRefMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public String deleteScoreRef(EduCourseScoreRef ref) {
		if(ref!=null){
			ref.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(ref, false);
			scoreRefMapper.updateByPrimaryKeySelective(ref);
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@Override
	public String deleteScoreRefs(List<EduCourseScoreRef> refList) {
		if(refList!=null && !refList.isEmpty()){
			for(EduCourseScoreRef ref:refList){
				deleteScoreRef(ref);
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@Override
	public String searchScoreJurisdiction(String trainingSpeId,String userFlow,String schDeptFlow,
			String courseFlow) {
		String scoreBl=GlobalConstant.FLAG_N;
		Criteria criteria=null;
		//按人员
		EduCourseScoreRefExample exampleUser=new EduCourseScoreRefExample();
		criteria=exampleUser.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EduCourseScoreRef> scoreRefUserList=null;
		if(StringUtil.isNotBlank(userFlow)){
			    criteria.andCourseFlowEqualTo(courseFlow);
				criteria.andRefTypeIdEqualTo(ScoreUserScopeEnum.User.getId());
				criteria.andRefFlowEqualTo(userFlow);
				scoreRefUserList=this.scoreRefMapper.selectByExample(exampleUser);
		}
		if(scoreRefUserList!=null && !scoreRefUserList.isEmpty()){
				scoreBl=GlobalConstant.FLAG_Y;
		}
		//按科室
		EduCourseScoreRefExample exampleDept=new EduCourseScoreRefExample();
		criteria=exampleDept.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		List<EduCourseScoreRef> scoreRefDeptList=null;
		if(StringUtil.isNotBlank(schDeptFlow)){
			criteria.andCourseFlowEqualTo(courseFlow);
			criteria.andRefTypeIdEqualTo(ScoreUserScopeEnum.Dept.getId());
			criteria.andRefFlowEqualTo(schDeptFlow);
			scoreRefDeptList=this.scoreRefMapper.selectByExample(exampleDept);
	    }
	    if(scoreRefDeptList!=null && !scoreRefDeptList.isEmpty()){
			scoreBl=GlobalConstant.FLAG_Y;
	    }
	    //按专业
		EduCourseScoreRefExample exampleMajor=new EduCourseScoreRefExample();
	    criteria=exampleMajor.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
	  	List<EduCourseScoreRef> scoreRefMajorList=null;
	    if(StringUtil.isNotBlank(trainingSpeId)){
	       criteria.andCourseFlowEqualTo(courseFlow);
	  	   criteria.andRefTypeIdEqualTo(ScoreUserScopeEnum.Major.getId());
	  	   criteria.andRefFlowEqualTo(trainingSpeId);
	  	   scoreRefMajorList=this.scoreRefMapper.selectByExample(exampleMajor);
	  	}
	  	if(scoreRefMajorList!=null && !scoreRefMajorList.isEmpty()){
	  	   scoreBl=GlobalConstant.FLAG_Y;
	  	}
		return scoreBl;
	}

	
}
