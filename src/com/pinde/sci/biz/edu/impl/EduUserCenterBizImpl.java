package com.pinde.sci.biz.edu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.sci.biz.edu.IEduUserCenterBiz;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.enums.edu.EduCourseTypeEnum;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysUser;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduUserCenterBizImpl implements IEduUserCenterBiz{

	@Autowired
	private EduCourseExtMapper eduCourseExtMapper;
	
	@Override
	public Map<String, Object> countUserCourseByType(
			String userFlow) {
		Map<String, Object> resultMap=new HashMap<String, Object>();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		for(EduCourseTypeEnum type:EduCourseTypeEnum.values()){
			paramMap.put("userFlow", userFlow);
			paramMap.put("courseTypeId",type.getId());
			int countCourse=this.eduCourseExtMapper.countUserCourseByType(paramMap);
		    	resultMap.put(type.getId(), countCourse);
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Integer> countUserCourse(String userFlow,String studyStatusId,String deptFlow) {
		Map<String, Integer> resultMap=new HashMap<String, Integer>();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		paramMap.put("studyStatusId",studyStatusId);
		paramMap.put("deptFlow", deptFlow);
		for(EduCourseTypeEnum type:EduCourseTypeEnum.values()){
			paramMap.put("userFlow", userFlow);
			paramMap.put("courseTypeId",type.getId());
			int countCourse=this.eduCourseExtMapper.countUserCourse(paramMap);
		    	resultMap.put(type.getId(), countCourse);
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> countTchCourse(String userFlow) {
		
		Map<String, Object> resultMap=new HashMap<String, Object>();
		Map<String, Object> paramMap=new HashMap<String, Object>();
		for(EduCourseTypeEnum type:EduCourseTypeEnum.values()){
			paramMap.put("userFlow", userFlow);
			paramMap.put("courseTypeId",type.getId());
			int countCourse=this.eduCourseExtMapper.countTchCourse(paramMap);
		    	resultMap.put(type.getId(), countCourse);
		}
		return resultMap;
	}

	@Override
	public List<EduCourseExt> countRecommendCourseByChooseMost(EduUser user){
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("eduUser", user);
		paramMap.put("courseTypeId", EduCourseTypeEnum.Optional.getId());
		return eduCourseExtMapper.countRecommendCourseByChooseMost(paramMap);
	}

	@Override
	public List<EduCourseExt> countRecommendCourseByScoreMost(EduUser user) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("eduUser", user);
		paramMap.put("courseTypeId", EduCourseTypeEnum.Optional.getId());
		return eduCourseExtMapper.countRecommendCourseByScoreMost(paramMap);
	}

	@Override
	public List<EduCourseExt> searchCourseListByQuestionOrder(EduUser eduUser) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("eduUser", eduUser);
		return eduCourseExtMapper.searchCourseListByQuestionOrder(paramMap);
	}

	@Override
	public List<EduCourseExt> searchCourseListByScoreOrder(EduUser eduUser) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		paramMap.put("eduUser", eduUser);
		return eduCourseExtMapper.searchCourseListByScoreOrder(paramMap);
	}
	
}
