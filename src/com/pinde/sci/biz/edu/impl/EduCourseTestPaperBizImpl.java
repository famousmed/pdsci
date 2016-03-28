package com.pinde.sci.biz.edu.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseTestPaperBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.dao.base.EduCourseTestPaperMapper;
import com.pinde.sci.dao.base.TestResultMapper;
import com.pinde.sci.dao.edu.EduCourseTestPaperExtMapper;
import com.pinde.sci.model.edu.EduCourseTestPaperExt;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.EduCourseTestPaperExample;
import com.pinde.sci.model.mo.EduStudentCourse;
import com.pinde.sci.model.mo.EduCourseTestPaperExample.Criteria;

@Service
@Transactional(rollbackFor = Exception.class)
public class EduCourseTestPaperBizImpl implements IEduCourseTestPaperBiz{
	@Autowired
	private EduCourseTestPaperMapper courseTestPaperMapper;
	@Autowired
	private EduCourseTestPaperExtMapper courseTestPaperExtMapper;
	@Autowired
	private TestResultMapper testResultMapper;
	
	@Override
	public List<EduCourseTestPaper> searchCourseTestPaperList(
			EduCourseTestPaper eduCourseTestPaper) {
		EduCourseTestPaperExample example=new EduCourseTestPaperExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		if(eduCourseTestPaper!=null){
			if(StringUtil.isNotBlank(eduCourseTestPaper.getCourseFlow())){
				criteria.andCourseFlowEqualTo(eduCourseTestPaper.getCourseFlow());
			}
			if(StringUtil.isNotBlank(eduCourseTestPaper.getPaperFlow())){
				criteria.andPaperFlowEqualTo(eduCourseTestPaper.getPaperFlow());
			}
			if(StringUtil.isNotBlank(eduCourseTestPaper.getChapterFlow())){
				criteria.andChapterFlowEqualTo(eduCourseTestPaper.getChapterFlow());
			}
		}
		return courseTestPaperMapper.selectByExample(example);
	}
	
	@Override
	public List<EduCourseTestPaper> searchCourseTestPaperListNotRecordStatus(
			EduCourseTestPaper eduCourseTestPaper) {
		EduCourseTestPaperExample example=new EduCourseTestPaperExample();
		Criteria criteria=example.createCriteria();
		if(eduCourseTestPaper!=null){
			if(StringUtil.isNotBlank(eduCourseTestPaper.getCourseFlow())){
				criteria.andCourseFlowEqualTo(eduCourseTestPaper.getCourseFlow());
			}
			if(StringUtil.isNotBlank(eduCourseTestPaper.getPaperFlow())){
				criteria.andPaperFlowEqualTo(eduCourseTestPaper.getPaperFlow());
			}
			if(StringUtil.isNotBlank(eduCourseTestPaper.getChapterFlow())){
				criteria.andChapterFlowEqualTo(eduCourseTestPaper.getChapterFlow());
			}
		}
		return courseTestPaperMapper.selectByExample(example);
	}

	@Override
	public int save(EduCourseTestPaper eduCourseTestPaper) {
		if(eduCourseTestPaper!=null){
			if(StringUtil.isNotBlank(eduCourseTestPaper.getRecordFlow())){
				GeneralMethod.setRecordInfo(eduCourseTestPaper, false);
				return courseTestPaperMapper.updateByPrimaryKeySelective(eduCourseTestPaper);
			}else{
				eduCourseTestPaper.setRecordFlow(PkUtil.getUUID());
				GeneralMethod.setRecordInfo(eduCourseTestPaper, true);
				return courseTestPaperMapper.insert(eduCourseTestPaper);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public int addAndDeleteCourseTestPaper(String courseFlow,String chapterFlow,String paperFlow, String type) {
		EduCourseTestPaper courseTestPaper=new EduCourseTestPaper();
    	courseTestPaper.setCourseFlow(courseFlow);
    	courseTestPaper.setPaperFlow(paperFlow);
    	courseTestPaper.setChapterFlow(chapterFlow);
    	List<EduCourseTestPaper> EduCourseTestPapers=this.searchCourseTestPaperListNotRecordStatus(courseTestPaper);
    	EduCourseTestPaper ectp=null;
    	if(EduCourseTestPapers!=null && !EduCourseTestPapers.isEmpty()){
    		ectp=EduCourseTestPapers.get(0);
        }
		if(ectp!=null){
			if("add".equals(type)){
				ectp.setRecordStatus(GlobalConstant.RECORD_STATUS_Y);
			}else if("del".equals(type)){
				ectp.setRecordStatus(GlobalConstant.RECORD_STATUS_N);
			}
			return save(ectp);
		}else{
			if("add".equals(type)){
				EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
				eduCourseTestPaper.setCourseFlow(courseFlow);
				eduCourseTestPaper.setPaperFlow(paperFlow);
				eduCourseTestPaper.setChapterFlow(chapterFlow);
				return save(eduCourseTestPaper);
			}
		}
		return GlobalConstant.ZERO_LINE;
	}

	@Override
	public EduCourseTestPaper readEduCourseTestPaper(String recordFlow) {
		return courseTestPaperMapper.selectByPrimaryKey(recordFlow);
	}

	@Override
	public List<EduCourseTestPaperExt> searchCourseTestPaperExt(
			String courseFlow) {
		Map<String,Object> paramMap=new HashMap<String, Object>();
		
		
		if(StringUtil.isNotBlank(courseFlow)){
			paramMap.put("courseFlow", courseFlow);
		}
		
		return courseTestPaperExtMapper.searchCourseTestPaper(paramMap);
	}
	
	/**
	 * 验证试卷是否绑定
	 * @param form
	 * @return
	 */
	public int testProvingMany(String courseFlow,String chapterFlow){
		EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
		if(StringUtil.isNotBlank(courseFlow)){
			eduCourseTestPaper.setCourseFlow(courseFlow);
		}
		if(StringUtil.isNotBlank(chapterFlow)){
			eduCourseTestPaper.setChapterFlow(chapterFlow);
		}
		List<EduCourseTestPaper> list=searchCourseTestPaperList(eduCourseTestPaper);
		return list.size();
		
	}

	

}
