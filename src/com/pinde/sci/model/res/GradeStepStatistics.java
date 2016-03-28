package com.pinde.sci.model.res;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.ResGradeBorderline;

public class GradeStepStatistics implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ResGradeBorderline gradeBorderline;
	
	private List<GradeStep> gradeSteps;

	public ResGradeBorderline getGradeBorderline() {
		return gradeBorderline;
	}

	public void setGradeBorderline(ResGradeBorderline gradeBorderline) {
		this.gradeBorderline = gradeBorderline;
	}

	public List<GradeStep> getGradeSteps() {
		return gradeSteps;
	}

	public void setGradeSteps(List<GradeStep> gradeSteps) {
		this.gradeSteps = gradeSteps;
	}
	
	
}
