package com.pinde.sci.model.res;

/**
 * ͳ�ƻ�����¼��Ϣ��bean
 * @author Administrator
 *
 */
public class OrgRecruitInfo {
	
	private String orgName;
	
	private String speName;
	
	/**
	 * �ƻ���¼����
	 */
	private Integer planCount;
	
	/**
	 * ѧԱȷ������
	 */
	private Integer confirmCount;
	
	/**
	 * ʣ������
	 */
	private Integer surplusCount;
	
	public OrgRecruitInfo(){}
	
	public OrgRecruitInfo(String orgName , String speName , Integer planCount , Integer confirmCount){
		this.orgName = orgName;
		this.speName = speName;
		if(planCount==null){
			planCount = 0;
		}
		if(confirmCount==null){
			confirmCount = 0;
		}
		this.planCount = planCount;
		this.confirmCount = confirmCount;
		if(planCount!=null && confirmCount!=null){
			this.surplusCount = planCount-confirmCount;
		}
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getSpeName() {
		return speName;
	}

	public void setSpeName(String speName) {
		this.speName = speName;
	}

	public Integer getPlanCount() {
		return planCount;
	}

	public void setPlanCount(Integer planCount) {
		this.planCount = planCount;
	}

	public Integer getConfirmCount() {
		return confirmCount;
	}

	public void setConfirmCount(Integer confirmCount) {
		this.confirmCount = confirmCount;
	}

	public Integer getSurplusCount() {
		return surplusCount;
	}

	public void setSurplusCount(Integer surplusCount) {
		this.surplusCount = surplusCount;
	}


}
