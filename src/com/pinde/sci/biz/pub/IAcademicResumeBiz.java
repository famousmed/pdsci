package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.form.pub.AcademicResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IAcademicResumeBiz {	
	
	/**
	 * 获取全部学会任职
	 * @throws Exception 
	 */
	List<AcademicResumeForm> queryAcademicList(PubUserResume resume) throws Exception;
	
	/**
	 * 获取一条学会任职
	 * @throws Exception 
	 */
	AcademicResumeForm getAcademicResumeByRecordId(String userFlow, String recordId) throws Exception;
	/**
	 * 保存学会任职
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	int saveAcademicResume(SysUser user, AcademicResumeForm form) throws Exception;
	
	/**
	 * 删除一条学会任职
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delAcademicResumeByRecordId(String userFlow, String recordId) throws Exception;
	
}
