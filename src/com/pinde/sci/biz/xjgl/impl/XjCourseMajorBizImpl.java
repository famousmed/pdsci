package com.pinde.sci.biz.xjgl.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.xjgl.IXjCourseMajorBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.InitConfig;
import com.pinde.sci.dao.base.EduCourseMajorMapper;
import com.pinde.sci.dao.edu.EduCourseMajorExtMapper;
import com.pinde.sci.form.edu.MajorCourseForm;
import com.pinde.sci.model.edu.EduCourseMajorExt;
import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduCourseMajor;
import com.pinde.sci.model.mo.EduCourseMajorExample;
import com.pinde.sci.model.mo.EduCourseMajorExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class XjCourseMajorBizImpl implements IXjCourseMajorBiz{
    
	@Autowired
	private EduCourseMajorExtMapper courseMajorExtMapper;
	@Autowired
	private EduCourseMajorMapper courseMajorMapper;
	
	@Override
	public List<MajorCourseForm> searchIncludeCourseMajor(EduCourseMajor courseMajor,EduCourse course) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(courseMajor!=null){
			paramMap.put("courseMajor", courseMajor);
		}
		if(course!=null){
			paramMap.put("course", course);
		}
		return courseMajorExtMapper.searchIncludeCourseMajor(paramMap);
	}

	@Override
	public int save(EduCourseMajor courseMajor) {
		if(StringUtil.isNotBlank(courseMajor.getRecordFlow())){
			GeneralMethod.setRecordInfo(courseMajor, false);
			return courseMajorMapper.updateByPrimaryKeySelective(courseMajor);
		}else{
			courseMajor.setRecordFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(courseMajor, true);
			return courseMajorMapper.insert(courseMajor);
		}
	}

	@Override
	public List<EduCourse> searchCourseNotIncludeMajor(String majorId,
			String year) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(StringUtil.isNotBlank(majorId)){
			paramMap.put("majorId", majorId);
		}
		if(StringUtil.isNotBlank(year)){
			paramMap.put("year", year);
		}
		return courseMajorExtMapper.selectCourseNotIncludeMajor(paramMap);
	}

	@Override
	public List<EduCourseMajorExt> searchCourseByMajor(String majorId,
			String year) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		if(StringUtil.isNotBlank(majorId)){
			paramMap.put("majorId", majorId);
		}
		if(StringUtil.isNotBlank(year)){
			paramMap.put("year", year);
		}
		return courseMajorExtMapper.selectCourseByMajor(paramMap);
	}

	@Override
	public List<EduCourseMajor> searchCourseMajorListNoStatus(EduCourseMajor courseMajor) {
		EduCourseMajorExample example=new EduCourseMajorExample();
	    Criteria criteria=example.createCriteria();
	    if(StringUtil.isNotBlank(courseMajor.getCourseFlow())){
	    	criteria.andCourseFlowEqualTo(courseMajor.getCourseFlow());
	    }
	    if(StringUtil.isNotBlank(courseMajor.getMajorId())){
	    	criteria.andMajorIdEqualTo(courseMajor.getMajorId());
	    }
	    if(StringUtil.isNotBlank(courseMajor.getPlanYear())){
	    	criteria.andPlanYearEqualTo(courseMajor.getPlanYear());
	    }
	    if(StringUtil.isNotBlank(courseMajor.getRecommendFlag())){
	    	criteria.andRecommendFlagEqualTo(courseMajor.getRecommendFlag());
	    }
		return this.courseMajorMapper.selectByExample(example);
	}

	@Override
	public int delete(EduCourseMajor courseMajor) {
		if(courseMajor!=null && StringUtil.isNotBlank(courseMajor.getRecordFlow())){
			courseMajor.setRecommendFlag(GlobalConstant.FLAG_N);
			courseMajor.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			GeneralMethod.setRecordInfo(courseMajor, false);
			return courseMajorMapper.updateByPrimaryKey(courseMajor);
		}
		return GlobalConstant.ZERO_LINE;
	}

	
	@Override
	public List<String> searchRecommendYear(String year, String recommendFlag) {
		Map<String,String> paramMap=new HashMap<String, String>();
		if(StringUtil.isNotBlank(year)){
		    paramMap.put("year", year);
		}
		if(StringUtil.isNotBlank(recommendFlag)){
			paramMap.put("recommendFlag", recommendFlag);
		}
		return courseMajorExtMapper.searchRecommendYear(paramMap);
	}

	@Override
	public int saveRecommendData(EduCourseMajor courseMajor,String targetYear) {
		List<EduCourseMajor> courseMajorList=searchCourseMajorListNoStatus(courseMajor);
    	if(courseMajorList!=null && !courseMajorList.isEmpty()){
    		for(EduCourseMajor eduCourseMajor:courseMajorList){
    			if(GlobalConstant.RECORD_STATUS_Y.equals(eduCourseMajor.getRecordStatus())){
    				courseMajor.setCourseFlow(eduCourseMajor.getCourseFlow());
        			courseMajor.setMajorId(eduCourseMajor.getMajorId());
        			courseMajor.setPlanYear(targetYear);
        			List<EduCourseMajor> cmList=searchCourseMajorListNoStatus(courseMajor);
        			if(cmList==null || cmList.isEmpty()){
        				eduCourseMajor.setPlanYear(targetYear);
        				eduCourseMajor.setRecommendFlag(GlobalConstant.FLAG_Y);
            			eduCourseMajor.setRecordFlow("");
            			int result=save(eduCourseMajor);
            			if(result!=GlobalConstant.ONE_LINE){
            				return result;
            			}
        			}else if(cmList!=null && !cmList.isEmpty()){
        				if(GlobalConstant.FLAG_N.equals(cmList.get(0).getRecordStatus())){
        					cmList.get(0).setCourseTypeId(eduCourseMajor.getCourseTypeId());
        					cmList.get(0).setCourseTypeName(eduCourseMajor.getCourseTypeName());
        					cmList.get(0).setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
        					cmList.get(0).setRecommendFlag(GlobalConstant.FLAG_Y);
        					int result=save(cmList.get(0));
        					if(result!=GlobalConstant.ONE_LINE){
                				return result;
                			}
        				}
        			}
    			}
    		}
    	}
		return GlobalConstant.ONE_LINE;
	}

	@Override
	public int delRecommendData(EduCourseMajor courseMajor) {
	    if(courseMajor!=null){
	    	if(StringUtil.isNotBlank(courseMajor.getPlanYear())){
	    		courseMajor.setRecommendFlag(GlobalConstant.FLAG_Y);
	    		List<EduCourseMajor> courseMajorList=searchCourseMajorListNoStatus(courseMajor);
	    		if(courseMajorList!=null && !courseMajorList.isEmpty()){
	        		for(EduCourseMajor eduCourseMajor:courseMajorList){
	        			int result=delete(eduCourseMajor);
	        			if(result!=GlobalConstant.ONE_LINE){
            				return result;
            			}
	        		}
	    		}
	    	}
	    }
		return GlobalConstant.ONE_LINE;
	}

	
	
      
	
	
}
