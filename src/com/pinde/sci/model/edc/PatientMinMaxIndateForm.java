package com.pinde.sci.model.edc;

import java.io.Serializable;

public class PatientMinMaxIndateForm implements Serializable{
	
	private static final long serialVersionUID = -147176250662665309L;
	
	//������ˮ��
	private String orgFlow;
	//��������
	private String inCount;
	//��һ����������
	private String minInDate;
	//���һ����������
	private String maxInDate;
	
	public String getOrgFlow() {
		return orgFlow;
	}
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
	}
	public String getInCount() {
		return inCount;
	}
	public void setInCount(String inCount) {
		this.inCount = inCount;
	}
	public String getMinInDate() {
		return minInDate;
	}
	public void setMinInDate(String minInDate) {
		this.minInDate = minInDate;
	}
	public String getMaxInDate() {
		return maxInDate;
	}
	public void setMaxInDate(String maxInDate) {
		this.maxInDate = maxInDate;
	}
	
}
