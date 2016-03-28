package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourseScoreRef;
import com.pinde.sci.model.mo.SysUser;

public interface IEduCourseScoreRefBiz {
	/**
	 * 保存一条计分人员范围记录
	 * @param refFlow
	 * @return
	 */
	int saveScoreRef(EduCourseScoreRef ref);
	/**
	 * 保存一组计分人员范围记录
	 * @param requiredDoctorTrainingSpe
	 * @return
	 */
	String saveScoreRefs(List<EduCourseScoreRef> refList,String courseFlow,String refTypeId);
	
	/**
	 * 查询计分人员范围记录
	 * @param ref
	 * @return
	 */
	List<EduCourseScoreRef> searchScoreRefs(EduCourseScoreRef ref);
	/**
	 * 读取一条计分人员范围记录
	 * @param recordFlow
	 * @return
	 */
	EduCourseScoreRef readScoreRef(String recordFlow);
	/**
	 * 删除一条计分人员范围记录
	 * @param ref
	 * @return
	 */
	String deleteScoreRef(EduCourseScoreRef ref);
	/**
	 * 删除一组计分人员范围记录
	 * @param refList
	 * @return
	 */
	String deleteScoreRefs(List<EduCourseScoreRef> refList);
	/**
	 * 判断该课程对该学生是否计分
	 * @param trainingSpeId
	 * @param user
	 * @param courseFlow
	 * @return
	 */
	String searchScoreJurisdiction(String trainingSpeId,String userFlow,String schDeptFlow,String courseFlow);
}
