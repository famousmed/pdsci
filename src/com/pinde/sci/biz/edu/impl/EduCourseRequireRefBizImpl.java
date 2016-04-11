package com.pinde.sci.biz.edu.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseRequireRefBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCourseRequireRefMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.model.mo.EduCourseRequireRef;
import com.pinde.sci.model.mo.EduCourseRequireRefExample;
import com.pinde.sci.model.mo.EduCourseRequireRefExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseRequireRefBizImpl implements IEduCourseRequireRefBiz{

	@Autowired
	private EduCourseRequireRefMapper requireRefMapper;
	
	@Override
	public int saveRequiredRef(EduCourseRequireRef ref) {
		if(StringUtil.isNotBlank(ref.getRecordFlow())){
			GeneralMethod.setRecordInfo(ref, false);
			return requireRefMapper.updateByPrimaryKeySelective(ref);
		}else{
			ref.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(ref, true);
			return requireRefMapper.insert(ref);
		}
	}

	@Override
	public String saveRequiredRefs(
			List<EduCourseRequireRef> refList,String courseFlow,String refTypeId) {
		//先删除该课程下必修人员范围记录
		EduCourseRequireRef requireRef=new EduCourseRequireRef();
		requireRef.setCourseFlow(courseFlow);
		requireRef.setRefTypeId(refTypeId);
		List<EduCourseRequireRef> refs=searchRequireRefs(requireRef);
		deleteRequireRefs(refs);
		//保存必修人员范围记录
		if(refList!=null && !refList.isEmpty()){
			for(EduCourseRequireRef ref:refList){
			    ref.setCourseFlow(courseFlow);
				saveRequiredRef(ref);
			}
		}
		return GlobalConstant.SAVE_SUCCESSED;
	}

	@Override
	public List<EduCourseRequireRef> searchRequireRefs(EduCourseRequireRef ref) {
		EduCourseRequireRefExample example=new EduCourseRequireRefExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(StringUtil.isNotBlank(ref.getCourseFlow())){
			criteria.andCourseFlowEqualTo(ref.getCourseFlow());
		}
		if(StringUtil.isNotBlank(ref.getRefTypeId())){
			criteria.andRefTypeIdEqualTo(ref.getRefTypeId());
		}
		if(StringUtil.isNotBlank(ref.getRefFlow())){
			criteria.andRefFlowEqualTo(ref.getRefFlow());
		}
		return requireRefMapper.selectByExample(example);
	}

	@Override
	public EduCourseRequireRef readRequireRef(String recordFlow) {
		return requireRefMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public String deleteRequireRef(EduCourseRequireRef ref) {
		if(ref!=null){
			ref.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(ref, false);
			requireRefMapper.updateByPrimaryKeySelective(ref);
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	@Override
	public String deleteRequireRefs(List<EduCourseRequireRef> refList) {
		if(refList!=null && !refList.isEmpty()){
			for(EduCourseRequireRef ref:refList){
				deleteRequireRef(ref);
			}
		}
		return GlobalConstant.DELETE_SUCCESSED;
	}

	
}
