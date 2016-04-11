package com.pinde.sci.dao.test;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.TestPaper;
import com.pinde.sci.model.test.TestPaperExt;

public interface TestPaperExtMapper {

	/**
	 * ��ѯ�Ծ��俼����Ϣ
	 * @param paramMap
	 * @return
	 */
    public List<TestPaperExt> searchTestPaperExtList(Map<String,Object> paramMap);
    /**
     * ��ѯ�Ծ��б�
     * @param paramMap
     * @return
     */
    public List<TestPaper> searchTestPapers(Map<String,Object> paramMap);
}
