package com.pinde.sci.biz.pub;

import java.util.List;

import com.pinde.sci.form.pub.WorkResumeForm;
import com.pinde.sci.model.mo.PubUserResume;
import com.pinde.sci.model.mo.SysUser;

public interface IWorkResumeBiz {	
	/**
	 * 获取全部工作履历
	 * @param resume
	 * @return
	 * @throws Exception
	 */
	List<WorkResumeForm> queryWorkList(PubUserResume resume) throws Exception;
	
	/**
	 * 获取一条工作经历
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	WorkResumeForm getWorkResumeByRecordId(String userFlow, String recordId) throws Exception;
	
	/**
	 * 保存工作经历
	 * @param form
	 * @return
	 * @throws Exception 
	 */
	int saveWorkResume(SysUser user, WorkResumeForm form) throws Exception;
	
	/**
	 * 删除一条工作经历
	 * @param recordId
	 * @return
	 * @throws Exception 
	 */
	int delWorkResumeByRecordId(String userFlow, String recordId) throws Exception;
}
