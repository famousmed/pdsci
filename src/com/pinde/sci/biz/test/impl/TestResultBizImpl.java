package com.pinde.sci.biz.test.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.PkUtil;
import com.pinde.core.util.StringUtil;
import com.pinde.sci.biz.edu.IEduCourseTestPaperBiz;
import com.pinde.sci.biz.test.ITestResultBiz;
import com.pinde.sci.common.GeneralMethod;
import com.pinde.sci.common.GlobalConstant;
import com.pinde.sci.common.GlobalContext;
import com.pinde.sci.dao.base.TestResultMapper;
import com.pinde.sci.dao.test.TestResultExtMapper;
import com.pinde.sci.enums.sys.DictTypeEnum;
import com.pinde.sci.form.test.TestResultForm;
import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.FstuCredit;
import com.pinde.sci.model.mo.FstuCreditExample;
import com.pinde.sci.model.mo.TestResult;
import com.pinde.sci.model.mo.TestResultExample;
import com.pinde.sci.model.mo.TestResultExample.Criteria;
import com.pinde.sci.model.mo.TestResultExample.Criterion;
import com.pinde.sci.model.test.TestResultExt;
import com.sdk.utils.GloatContant;

@Service
@Transactional(rollbackFor = Exception.class)
public class TestResultBizImpl implements ITestResultBiz{
    
	@Autowired
	private TestResultMapper testResultMapper;
	@Autowired
	private TestResultExtMapper testResultExtMapper;
	@Autowired
    private IEduCourseTestPaperBiz eduCourseTestPaperBiz;
	
	
	@Override
	public List<TestResult> searchTestResultList(TestResult testResult) {
		TestResultExample example=new TestResultExample();
		Criteria criteria=example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y);
		
		if(testResult!=null){
			if(StringUtil.isNotBlank(testResult.getPaperFlow())){
				criteria.andPaperFlowEqualTo(testResult.getPaperFlow());
			}
			if(StringUtil.isNotBlank(testResult.getUserFlow())){
				criteria.andUserFlowEqualTo(testResult.getUserFlow());
			}
			if(StringUtil.isNotBlank(testResult.getUserName())){
				criteria.andUserNameEqualTo(testResult.getUserName());
			}
			if(StringUtil.isNotBlank(testResult.getPassFlag())){
				criteria.andPassFlagEqualTo(testResult.getPassFlag());
			}
		}
		return testResultMapper.selectByExample(example);
	}
	
	@Override
	public List<TestResultExt> reasonTestreRultChaTestPaper(String courseFlow,String userFlow,TestResultForm testResult){
		Map<String,Object> map=new HashMap<String, Object>();
		if (StringUtil.isNotBlank(courseFlow)) {
			map.put("courseFlow", courseFlow);
		}
		if (StringUtil.isNotBlank(userFlow)) {
			map.put("userFlow",userFlow);
		}
		
		if (testResult!=null) {
			map.put("testResult",testResult);
		}
		
		return testResultExtMapper.searchTestResultExtList(map);
		
	}
	/**
	 * 根据userFlow查询考试成绩信息
	 * @param userFlow
	 * @return
	 */
	@Override
	public List<TestResult> searchResultByUserFlow(String userFlow){
		TestResultExample example = new TestResultExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(userFlow);
		return testResultMapper.selectByExample(example);
	}
	/**
	 * 编辑考试成绩
	 * @param result
	 * @return
	 */
	@Override
	public int edit(TestResult result) {
		if(StringUtil.isNotBlank(result.getResultFlow())){
			GeneralMethod.setRecordInfo(result, false);
			return testResultMapper.updateByPrimaryKeySelective(result);
		}else{
			result.setResultFlow(PkUtil.getUUID());
			GeneralMethod.setRecordInfo(result, true);
			return testResultMapper.insertSelective(result);
			}
	}

	/**
	 * 保存
	 * @param testResult
	 * @return
	 */
	@Override
	public int saveTestResultList(List<TestResult> testResult){
		for(TestResult tr:testResult){
			if(StringUtil.isNotBlank(tr.getTestTypeId())){
				tr.setTestTypeName(DictTypeEnum.TestType.getDictNameById(tr.getTestTypeId()));
			}else{
				tr.setTestTypeName("");
			}
			edit(tr);
		}
		return GlobalConstant.ONE_LINE;
	}


	@Override
	public List<TestResult> searchResult(String userFlow, TestResult result) {
		TestResultExample example = new TestResultExample();
		Criteria criteria = example.createCriteria().andRecordStatusEqualTo(GlobalConstant.RECORD_STATUS_Y).andUserFlowEqualTo(userFlow);
		if(StringUtil.isNotBlank(result.getTestTypeId())){
			criteria.andTestTypeIdEqualTo(result.getTestTypeId());
		}
		if(StringUtil.isNotBlank(result.getTestTypeName())){
			criteria.andTestTypeNameLike(result.getTestTypeName());
		}
		if(StringUtil.isNotBlank(result.getPaperName())){
			criteria.andPaperNameLike("%"+result.getPaperName()+"%");
		}
		if(StringUtil.isNotBlank(result.getPassFlag())){
			criteria.andPassFlagEqualTo(result.getPassFlag());
		}
		return testResultMapper.selectByExample(example);
	}

	@Override
	public List<TestResult> searchPassResult(String userFlow, String chapterFlow) {
		EduCourseTestPaper eduCourseTestPaper=new EduCourseTestPaper();
		eduCourseTestPaper.setChapterFlow(chapterFlow);
		List<EduCourseTestPaper> courseTestPaperList=this.eduCourseTestPaperBiz.searchCourseTestPaperList(eduCourseTestPaper);
		if(courseTestPaperList!=null && !courseTestPaperList.isEmpty()){
			EduCourseTestPaper courseTestPaper=courseTestPaperList.get(0);
			TestResult testResult=new TestResult();
			testResult.setPaperFlow(courseTestPaper.getPaperFlow());
			testResult.setPassFlag(GlobalConstant.FLAG_Y);
			return searchTestResultList(testResult);
	    }
		return null;
	}

}
