package com.pinde.sci.model.res;

import java.io.Serializable;

import com.pinde.sci.model.mo.ResGradeBorderline;

/**
 * 分数线统计显示的Bean
 * @author Administrator
 *
 */
public class GradeBorderlineStatistics implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	//参见考试某个专业的人数
	private Integer sum;
	
	private ResGradeBorderline gradeBorderline;
	
	private Integer passCount;

	public Integer getSum() {
		return sum;
	}

	public void setSum(Integer sum) {
		this.sum = sum;
	}

	public ResGradeBorderline getGradeBorderline() {
		return gradeBorderline;
	}

	public void setGradeBorderline(ResGradeBorderline gradeBorderline) {
		this.gradeBorderline = gradeBorderline;
	}

	public Integer getPassCount() {
		return passCount;
	}

	public void setPassCount(Integer passCount) {
		this.passCount = passCount;
	}
	
	
}
