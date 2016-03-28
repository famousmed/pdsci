package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseRequireRef;

public interface IEduCourseRequireRefBiz {
    
	/**
	 * ����һ��������Ա��Χ��¼
	 * @param refFlow
	 * @return
	 */
	int saveRequiredRef(EduCourseRequireRef ref);
	/**
	 * ����һ�������Ա��Χ��¼
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String saveRequiredRefs(List<EduCourseRequireRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * ��ѯ������Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	List<EduCourseRequireRef> searchRequireRefs(EduCourseRequireRef ref);
	/**
	 * ��ȡһ��������Ա��Χ��¼
	 * @param recordFlow
	 * @return
	 */
	EduCourseRequireRef readRequireRef(String recordFlow);
	/**
	 * ɾ��һ��������Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	String deleteRequireRef(EduCourseRequireRef ref);
	/**
	 * ɾ��һ�������Ա��Χ��¼
	 * @param refList
	 * @return
	 */
	String deleteRequireRefs(List<EduCourseRequireRef> refList);
	
	
	
}
