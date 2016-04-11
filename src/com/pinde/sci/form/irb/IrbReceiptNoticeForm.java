package com.pinde.sci.form.irb;

import java.io.Serializable;

public class IrbReceiptNoticeForm implements Serializable{
	
	private static final long serialVersionUID = -6948275362053393008L;
	
	private String irbFlow;
	private String irbNo;
	private String operTime;
	public String getIrbFlow() {
		return irbFlow;
	}
	public void setIrbFlow(String irbFlow) {
		this.irbFlow = irbFlow;
	}
	public String getIrbNo() {
		return irbNo;
	}
	public void setIrbNo(String irbNo) {
		this.irbNo = irbNo;
	}
	public String getOperTime() {
		return operTime;
	}
	public void setOperTime(String operTime) {
		this.operTime = operTime;
	}
}
