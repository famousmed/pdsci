package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCoursePeriodRef;

public interface IEduCoursePeriodRefBiz {
	/**
	 * 保存一条计学时人员范围记录
	 * @param refFlow
	 * @return
	 */
	int savePeriodRef(EduCoursePeriodRef ref);
	/**
	 * 保存一组计学时人员范围记录
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String savePeriodRefs(List<EduCoursePeriodRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * 查询计学时人员范围记录
	 * @param ref
	 * @return
	 */
	List<EduCoursePeriodRef> searchPeriodRefs(EduCoursePeriodRef ref);
	/**
	 * 读取一条计学时人员范围记录
	 * @param recordFlow
	 * @return
	 */
	EduCoursePeriodRef readPeriodRef(String recordFlow);
	/**
	 * 删除一条计学时人员范围记录
	 * @param ref
	 * @return
	 */
	String deletePeriodRef(EduCoursePeriodRef ref);
	/**
	 * 删除一组计学时人员范围记录
	 * @param refList
	 * @return
	 */
	String deletePeriodRefs(List<EduCoursePeriodRef> refList);
	
	/**
	 * 判断该课程对该学生是否计学时
	 * @param trainingSpeId
	 * @param user
	 * @param courseFlow
	 * @return
	 */
	String searchPeriodJurisdiction(String trainingSpeId,String userFlow,String schDeptFlow,String courseFlow);
}
