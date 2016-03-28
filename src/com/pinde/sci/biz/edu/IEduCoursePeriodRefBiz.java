package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCoursePeriodRef;

public interface IEduCoursePeriodRefBiz {
	/**
	 * ����һ����ѧʱ��Ա��Χ��¼
	 * @param refFlow
	 * @return
	 */
	int savePeriodRef(EduCoursePeriodRef ref);
	/**
	 * ����һ���ѧʱ��Ա��Χ��¼
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String savePeriodRefs(List<EduCoursePeriodRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * ��ѯ��ѧʱ��Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	List<EduCoursePeriodRef> searchPeriodRefs(EduCoursePeriodRef ref);
	/**
	 * ��ȡһ����ѧʱ��Ա��Χ��¼
	 * @param recordFlow
	 * @return
	 */
	EduCoursePeriodRef readPeriodRef(String recordFlow);
	/**
	 * ɾ��һ����ѧʱ��Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	String deletePeriodRef(EduCoursePeriodRef ref);
	/**
	 * ɾ��һ���ѧʱ��Ա��Χ��¼
	 * @param refList
	 * @return
	 */
	String deletePeriodRefs(List<EduCoursePeriodRef> refList);
	
	/**
	 * �жϸÿγ̶Ը�ѧ���Ƿ��ѧʱ
	 * @param trainingSpeId
	 * @param user
	 * @param courseFlow
	 * @return
	 */
	String searchPeriodJurisdiction(String trainingSpeId,String userFlow,String schDeptFlow,String courseFlow);
}
