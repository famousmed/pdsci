package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.SysUser;

public interface IEduCourseScoreRefBiz {
	/**
	 * ����һ���Ʒ���Ա��Χ��¼
	 * @param refFlow
	 * @return
	 */
	int saveScoreRef(EduCourseScoreRef ref);
	/**
	 * ����һ��Ʒ���Ա��Χ��¼
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String saveScoreRefs(List<EduCourseScoreRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * ��ѯ�Ʒ���Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	List<EduCourseScoreRef> searchScoreRefs(EduCourseScoreRef ref);
	/**
	 * ��ȡһ���Ʒ���Ա��Χ��¼
	 * @param recordFlow
	 * @return
	 */
	EduCourseScoreRef readScoreRef(String recordFlow);
	/**
	 * ɾ��һ���Ʒ���Ա��Χ��¼
	 * @param ref
	 * @return
	 */
	String deleteScoreRef(EduCourseScoreRef ref);
	/**
	 * ɾ��һ��Ʒ���Ա��Χ��¼
	 * @param refList
	 * @return
	 */
	String deleteScoreRefs(List<EduCourseScoreRef> refList);
	/**
	 * �жϸÿγ̶Ը�ѧ���Ƿ�Ʒ�
	 * @param trainingSpeId
	 * @param user
	 * @param courseFlow
	 * @return
	 */
	String searchScoreJurisdiction(String trainingSpeId,String userFlow,String schDeptFlow,String courseFlow);
}
