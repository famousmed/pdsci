package com.pinde.sci.biz.edu.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseMajorBiz;
import com.pinde.sci.biz.edu.IEduStudentCourseBiz;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCourseMajorMapper;
import com.pinde.sci.dao.edu.EduCourseExtMapper;
import com.pinde.sci.dao.edu.EduCourseMajorExtMapper;
import com.pinde.sci.form.edu.CourseMajorNumForm;
import com.pinde.sci.form.edu.StudentCourseNumForm;
import com.pinde.sci.model.edu.EduCourseExt;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.EduCourseMajorExample;
import com.pinde.sci.model.mo.EduCourseMajorExample.Criteria;
@Service
@Transactional(rollbackFor=Exception.class)
public class EduCourseMajorBizImpl implements IEduCourseMajorBiz {
	@Autowired
	private EduCourseMajorMapper courseMajorMapper;
	@Autowired
	private EduCourseMajorExtMapper courseMajorExtMapper;
	@Autowired
	private EduCourseExtMapper courseExtMapper;
	@Autowired
	private IEduStudentCourseBiz studentCourseBiz;

	@Override
	public List<EduCourseMajor> searchCourseMajorList(EduCourseMajor courseMajor) {
		EduCourseMajorExample example = new EduCourseMajorExample();
		com.pinde.sci.model.mo.EduCourseMajorExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		addCriteria(courseMajor, criteria);
		example.setOrderByClause("CREATE_TIME DESC");
		return courseMajorMapper.selectByExample(example);
	}


	private void addCriteria(EduCourseMajor courseMajor, Criteria criteria) {
		if(StringUtil.isNotBlank(courseMajor.getMajorId())){
			criteria.andMajorIdEqualTo(courseMajor.getMajorId());
		}
		if(StringUtil.isNotBlank(courseMajor.getPlanYear())){
			criteria.andPlanYearEqualTo(courseMajor.getPlanYear());
		}
		if(StringUtil.isNotBlank(courseMajor.getCourseFlow())){
			criteria.andCourseFlowEqualTo(courseMajor.getCourseFlow());
		}
	}


	@Override
	public List<EduCourseExt> courseMajorExts(EduCourse course,EduCourseMajor courseMajor) {
		Map<String, Object> map=new HashMap<String, Object>();
		if (course!=null) {
			if (StringUtil.isNotBlank(course.getCourseName())||
					StringUtil.isNotBlank(course.getGradationId())||
					StringUtil.isNotBlank(course.getCourseTypeId())||
					StringUtil.isNotBlank(course.getDeptFlow())) {
					map.put("course",course);
			}
		}
		if (courseMajor!=null) {
			if (StringUtil.isNotBlank(courseMajor.getPlanYear())) {
				map.put("courseMajor",courseMajor);
			}
		}
		return courseExtMapper.selectCourseMajor(map);
	}

	@Override
	public List<EduCourseMajor> searchCourseMajorLists(List<String> courseFlowList) {
		EduCourseMajorExample example=new EduCourseMajorExample();
        com.pinde.sci.model.mo.EduCourseMajorExample.Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
        if(courseFlowList!=null && courseFlowList.size() >0){
        	 criteria.andCourseFlowIn(courseFlowList);
        }
		return this.courseMajorMapper.selectByExample(example);
	}

	@Override
	public EduCourseMajor courseMajor(String recordFlow) {
		return courseMajorMapper.selectByPrimaryKey(recordFlow);
	}


	@Override
	public List<EduCourseMajor> searchCourseMajorByCourseFlowList(EduCourseMajor courseMajor, List<String> courseFlowList) {
		EduCourseMajorExample example = new EduCourseMajorExample();
		com.pinde.sci.model.mo.EduCourseMajorExample.Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		addCriteria(courseMajor, criteria);
		return courseMajorMapper.selectByExample(example);
	}


	@Override
	public List<CourseMajorNumForm> selectCourseMajorNum(String courseFlow,String time) {
		Map<String,Object> map=new HashMap<String, Object>();
		if (StringUtil.isNotBlank(courseFlow)) {
			map.put("courseFlow", courseFlow);
		}
		if (StringUtil.isNotBlank(time)) {
			map.put("time", time);
		}
		List<CourseMajorNumForm> majorList=courseExtMapper.selectCourseMajorNum(map);
		return majorList;
	}

	@Override
	public EduCourseMajor readCourseMajor(String recordFlow) {
		return courseMajorMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public List<EduCourseMajorExt> searchCourseMajorExtList(String planYear, String majorId) {
		EduCourseMajorExt courseMajorExt = new EduCourseMajorExt();
		courseMajorExt.setPlanYear(planYear);
		courseMajorExt.setMajorId(majorId);
		return courseMajorExtMapper.searchCourseMajorExtList(courseMajorExt) ;
	}


	@Override
	public Map<String, Object> extractCourseMajorMap(String period, List<EduCourseMajorExt> courseMajorExtList) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, List<EduCourseMajorExt>> courseTypeMajorMap = new LinkedHashMap<String, List<EduCourseMajorExt>>();
		List<String> courseFlowList = new ArrayList<String>();//该专业所有课程流水号
		for(EduCourseMajorExt cm : courseMajorExtList){
			courseFlowList.add(cm.getCourseFlow());
			//组织课程类别map
			String key = cm.getCourseTypeId();
			List<EduCourseMajorExt> tempList = courseTypeMajorMap.get(key);
			if(tempList == null){
				tempList = new ArrayList<EduCourseMajorExt>();
			}
			tempList.add(cm);
			courseTypeMajorMap.put(key, tempList);
		}
		resultMap.put("courseTypeMajorMap", courseTypeMajorMap);
		
		//查询该届学生该专业所有课程已选人数（已选）
		if(courseFlowList != null && !courseFlowList.isEmpty()){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("courseFlowList", courseFlowList);
			paramMap.put("period", period);
			List<StudentCourseNumForm> chooseStudentCourseCountList = studentCourseBiz.searchStudentCourseChooseCount(paramMap);
			if(chooseStudentCourseCountList != null && !chooseStudentCourseCountList.isEmpty()){
				Map<String, String> chooseCountMap = new HashMap<String, String>();
				for(StudentCourseNumForm form :chooseStudentCourseCountList){
					chooseCountMap.put(form.getCourseFlow(), form.getNum()	);
				}
				resultMap.put("chooseCountMap", chooseCountMap);
			}
		}
		return resultMap;
	}


	@Override
	public List<EduCourseMajorExt> searchReplenishCourseMajorExtList(String planYear, String majorId, String userFlow) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("planYear", planYear);
		paramMap.put("majorId", majorId);
		paramMap.put("userFlow", userFlow);
		return courseMajorExtMapper.searchReplenishCourseMajorExtList(paramMap);
	}

	
}
