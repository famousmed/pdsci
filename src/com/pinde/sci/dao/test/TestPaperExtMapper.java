package com.pinde.sci.dao.test;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.test.TestPaperExt;

public interface TestPaperExtMapper {

	/**
	 * 查询试卷及其考试信息
	 * @param paramMap
	 * @return
	 */
    public List<TestPaperExt> searchTestPaperExtList(Map<String,Object> paramMap);
    /**
     * 查询试卷列表
     * @param paramMap
     * @return
     */
    public List<TestPaper> searchTestPapers(Map<String,Object> paramMap);
}
