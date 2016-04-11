package com.pinde.sci.biz.edu;

import java.util.List;

import com.pinde.sci.form.pub.EduResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IEduResumeBiz {	
	/**
	 * 保存教育经历
	 * @param resume
	 * @return
	 * @throws Exception 
	 */
	int saveEduResume(SysUser user, EduResumeForm form) throws Exception;
	
	/**
	 * 获取全部教育履历
	 * @param resume
	 * @return
	 * @throws Exception 
	 */
	List<EduResumeForm> queryEduResumeList(PubUserResume resume) throws Exception;
	
	/**
	 * 获取一条教育记录
	 * @param recordId
	 * @throws Exception 
	 */
	EduResumeForm getEduResumeByRecordId(String userFlow, String recordId) throws Exception;
	
	/**
	 * 删除一条教育经历
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delEduResumeByRecordId(String userFlow, String recordId) throws Exception;
}
