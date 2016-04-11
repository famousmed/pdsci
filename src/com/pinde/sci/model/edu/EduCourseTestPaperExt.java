package com.pinde.sci.model.edu;

import com.pinde.sci.model.mo.EduCourseTestPaper;
import com.pinde.sci.model.mo.TestPaper;

public class EduCourseTestPaperExt extends EduCourseTestPaper{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1131217490601541114L;
      
	private TestPaper testPaper;

	public TestPaper getTestPaper() {
		return testPaper;
	}

	public void setTestPaper(TestPaper testPaper) {
		this.testPaper = testPaper;
	}
	
	
	
}
