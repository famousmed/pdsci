package com.pinde.sci.dao.test;

import java.util.List;
import java.util.Map;


import com.pinde.sci.model.test.TestResultExt;

public interface TestResultExtMapper {
	public List<TestResultExt> searchTestResultExtList(Map<String,Object> map);
}
