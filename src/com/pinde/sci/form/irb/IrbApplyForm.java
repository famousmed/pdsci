package com.pinde.sci.form.irb;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.IrbApply;

public class IrbApplyForm implements Serializable{
	
	private static final long serialVersionUID = 3394892541658024370L;
	
	private IrbApply irbApply;
	/**
	 * ���鰲������Ҫ�� Y���ǣ�N������
	 */
	private String forMeeting;
	/**
	 * �����б�
	 */
	private List<String> irbTypeIdList;
	public IrbApply getIrbApply() {
		return irbApply;
	}
	public void setIrbApply(IrbApply irbApply) {
		this.irbApply = irbApply;
	}
	public String getForMeeting() {
		return forMeeting;
	}
	public void setForMeeting(String forMeeting) {
		this.forMeeting = forMeeting;
	}
	public List<String> getIrbTypeIdList() {
		return irbTypeIdList;
	}
	public void setIrbTypeIdList(List<String> irbTypeIdList) {
		this.irbTypeIdList = irbTypeIdList;
	}
	
}
