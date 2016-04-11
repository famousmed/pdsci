package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.SchRotation;


public interface ISchRotationBiz {
	List<SchRotation> searchSchRotation();
	
	List<SchRotation> searchSchRotation(String speId);
	
	SchRotation readSchRotation(String rotationFlow);

	int saveSchRotation(SchRotation rotation);

	List<SchRotation> searchRotationByrotationFlows(List<String> rotationFlows);

	List<SchRotation> searchNotExistRotation(String orgFlow);

	int editRotations(List<SchRotation> rotationList);

	int rotationClone(String rotationFlow, String rotationYear);

	List<SchRotation> searchOrgStandardRotation(SchRotation rotation);

	List<SchRotation> searchSchRotationByIsPublish();

	int saveLocalRotation(List<SchRotation> rotationList, String orgFlow);

	List<SchRotation> searchSchRotationForPlatform(String doctorCateGoryId);
}
