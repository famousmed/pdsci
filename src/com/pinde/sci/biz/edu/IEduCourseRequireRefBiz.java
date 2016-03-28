package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseRequireRef;

public interface IEduCourseRequireRefBiz {
    
	/**
	 * 保存一条必修人员范围记录
	 * @param refFlow
	 * @return
	 */
	int saveRequiredRef(EduCourseRequireRef ref);
	/**
	 * 保存一组必修人员范围记录
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String saveRequiredRefs(List<EduCourseRequireRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * 查询必修人员范围记录
	 * @param ref
	 * @return
	 */
	List<EduCourseRequireRef> searchRequireRefs(EduCourseRequireRef ref);
	/**
	 * 读取一条必修人员范围记录
	 * @param recordFlow
	 * @return
	 */
	EduCourseRequireRef readRequireRef(String recordFlow);
	/**
	 * 删除一条必修人员范围记录
	 * @param ref
	 * @return
	 */
	String deleteRequireRef(EduCourseRequireRef ref);
	/**
	 * 删除一组必修人员范围记录
	 * @param refList
	 * @return
	 */
	String deleteRequireRefs(List<EduCourseRequireRef> refList);
	
	
	
}
