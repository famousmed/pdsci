package com.pinde.sci.model.res;

import java.io.Serializable;

public class GradeStep implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer startGrade;
	
	private Integer endGrade;
	
	private Integer count;

	public Integer getStartGrade() {
		return startGrade;
	}

	public void setStartGrade(Integer startGrade) {
		this.startGrade = startGrade;
	}

	public Integer getEndGrade() {
		return endGrade;
	}

	public void setEndGrade(Integer endGrade) {
		this.endGrade = endGrade;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
	
}
