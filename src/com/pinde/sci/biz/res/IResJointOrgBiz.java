package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResJointOrg;

public interface IResJointOrgBiz {
	public int save(ResJointOrg resJointOrg);

	int editJointOrgList(List<ResJointOrg> jointOrgList);

	List<ResJointOrg> searchResJointByOrgFlow(String orgFlow);

	List<ResJointOrg> searchResJoint(ResJointOrg joint);

	List<ResJointOrg> searchJointOrgAll();

}
